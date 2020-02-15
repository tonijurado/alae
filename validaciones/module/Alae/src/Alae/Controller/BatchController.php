<?php
/**
 * Modulo de gestión de lotes.
 * Este fichero se encarga de controlar la carga de lotes importados en Alae.
 * Controla la aprobación o rechazo manual de lotes.
 * Controla el listado de lotes sin asignar.
 * @author Maria Quiroz
 * Fecha de creación: 16/05/2014
 */

namespace Alae\Controller;

use Zend\View\Model\ViewModel,
    Alae\Controller\BaseController,
    Zend\View\Model\JsonModel,
    Alae\Service\Datatable;

class BatchController extends BaseController
{
    protected $_document = '\\Alae\\Entity\\Batch';

    public function init()
    {
        if (!$this->isLogged())
        {
            header('Location: ' . \Alae\Service\Helper::getVarsConfig("base_url"));
            exit;
        }
    }

    //RETORNA LOS ANALITOS NULOS
    public function unfilledAction()
    {
        $data     = array();
        $elements = $this->getRepository()->findBy(array("fkAnalyte" => null, "fkStudy" => null));

        foreach ($elements as $unfilled)
        {
            if (!is_null($unfilled->getFkParameter()))
            {
                $data[] = array(
                    "batch"     => $unfilled->getSerial(),
                    "filename"  => $unfilled->getFileName(),
                    "create_at" => $unfilled->getCreatedAt(),
                    "reason"    => $unfilled->getFkParameter()->getMessageError()
                );
            }
        }

        $datatable = new Datatable($data, Datatable::DATATABLE_UNFILLED, $this->_getSession()->getFkProfile()->getName());
        return new ViewModel($datatable->getDatatable());
    }

    protected function download()
    {
        $data     = array();
        $data[]   = array("# Lote", "Nombre del archivo", "Importado el", "Motivo de descarte");
        $elements = $this->getRepository()->findBy(array("fkAnalyte" => null, "fkStudy" => null));

        foreach ($elements as $unfilled)
        {
            $data[] = array(
                $unfilled->getSerial(),
                $unfilled->getFileName(),
                $unfilled->getCreatedAt(),
                $unfilled->getFkParameter()->getMessageError()
            );
        }

        return json_encode($data);
    }

    //ENVIA A EXCEL LOS LOTES SIN ASIGNAR
    public function excelAction()
    {
        \Alae\Service\Download::excel("lotes_sin_asignar", $this->download());
    }

    public function listAction()
    {
        if(isset($_GET['state']))
        {
            $state = $_GET['state'];
        }
        else
        {
            $state = 'open';
        }
        $request = $this->getRequest();

        if ($request->isPost())
        {
            if ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio())
            {
                $AnaStudy            = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->find($request->getPost('id'));
                $updateJustification = $request->getPost('update-justification');
                $updateAcceptedFlag  = $request->getPost('update-accepted_flag');

                if (!empty($updateJustification))
                {
                    foreach ($updateJustification as $key => $value)
                    {
                        $Batch = $this->getRepository()->find($key);

                        if ($Batch && $Batch->getPkBatch())
                        {
                            try
                            {
                                //APROBACIÓN MANUAL DE LOS LOTES
                                $Batch->setValidFlag((bool) $updateAcceptedFlag[$key]);
                                $Batch->setAcceptedFlag((bool) $updateAcceptedFlag[$key]);
                                $Batch->setJustification($updateJustification[$key]);
                                $Batch->setFkUser($this->_getSession());
                                $this->getEntityManager()->persist($Batch);
                                $this->getEntityManager()->flush();

                                $this->transaction(
                                    ($updateAcceptedFlag[$key] ? "Aprobación manual de lotes" : "Rechazo manual de lotes"),
                                    sprintf('El usuario %1$s ha %2$s el lote %3$s',
                                        $this->_getSession()->getUsername(),
                                        ($updateAcceptedFlag[$key] ? "aprobado" : "rechazado"),
                                        $Batch->getFileName()
                                    ),
                                    false
                                );

                                return $this->redirect()->toRoute('batch', array(
                                            'controller' => 'batch',
                                            'action'     => 'list',
                                            'id'         => $AnaStudy->getPkAnalyteStudy()
                                ));
                            }
                            catch (Exception $e)
                            {
                                exit;
                            }
                        }
                    }
                }
            }
        }

        if ($this->getEvent()->getRouteMatch()->getParam('id'))
        {
            $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->find($this->getEvent()->getRouteMatch()->getParam('id'));
        }

        $data = array();
        $query = $this->getEntityManager()->createQuery("
                SELECT b
                FROM Alae\Entity\Batch b
                WHERE b.fkAnalyte = " . $AnaStudy->getFkAnalyte()->getPkAnalyte() . " AND b.fkStudy = " . $AnaStudy->getFkStudy()->getPkStudy() . "
                ORDER BY b.fileName ASC");
        $elements = $query->getResult();

        //MUESTRA LOS LOTES EN PANTALLA
        foreach ($elements as $batch)
        {
            $modify = $validation = "";

            if (!$AnaStudy->getFkStudy()->getCloseFlag())
            {
                if ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio())
                {
                    $modify = is_null($batch->getValidFlag()) ? "" : ($batch->getValidFlag() ? '<button class="btn" onclick="changeElement(this, ' . $batch->getPkBatch() . ');"><span class="btn-reject"></span>rechazar</button>' : '<button class="btn" onclick="changeElement(this, ' . $batch->getPkBatch() . ');"><span class="btn-validate"></span>aceptar</button>');
                }
                if($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio() || $this->_getSession()->isLaboratorio())
                {
                    $nominal = is_null($batch->getValidFlag()) ? '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/batch/nominal/' . $batch->getPkBatch() . '?state='.$state. '" class="btn" type="button"><span class="btn-validate"></span>Valor nominal</a>' : "";
                    $validation = is_null($batch->getValidFlag()) ? '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/verification/index/' . $batch->getPkBatch() . '?state='.$state. '" class="btn" type="button"><span class="btn-validate"></span>validar</a>' : "";
                }
            }

            $data[] = array(
                "batch"           => $batch->getSerial(),
                "filename"        => $batch->getFileName(),
                "filesize"        => $batch->getFileSize(),
                "create_at"       => $batch->getCreatedAt(),
                "nominal"         => $nominal,
                "valid_flag"      => $validation,
                "validation_date" => $batch->getValidationDate(),
                "result"          => is_null($batch->getValidFlag()) ? "" : ($batch->getValidFlag() ? "VÁLIDO" : "NO VÁLIDO"),
                "modify"          => $modify,
                "accepted_flag"   => is_null($batch->getAcceptedFlag()) ? "" : ($batch->getAcceptedFlag() ? "S" : "N"),
                "justification"   => is_null($batch->getJustification()) ? "" : $batch->getJustification()
            );
        }

        if ($this->getEvent()->getRouteMatch()->getParam('an'))
        {
            $error = "<li>No se puede procesar, faltan los valores nominales.<li>";
        }

        $datatable = new Datatable($data, Datatable::DATATABLE_BATCH, $this->_getSession()->getFkProfile()->getName());
        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('AnaStudy', $AnaStudy);
        $viewModel->setVariable('user', $this->_getSession());
        $viewModel->setVariable('state', $state);
        $viewModel->setVariable('error', (isset($error) ? $error : ""));
        
        return $viewModel;
    }

    public function nominalAction()
    {
        echo "prueba";
        $error = "";
        $request = $this->getRequest();
        if(isset($_GET['state']))
        {
            $state = $_GET['state'];
        }
        else
        {
            $state = 'open';
        }
        if ($this->getEvent()->getRouteMatch()->getParam('id'))
        {
            $Batch = $this->getRepository()->find($this->getEvent()->getRouteMatch()->getParam('id'));
            $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
                "fkAnalyte" => $Batch->getFkAnalyte(),
                "fkStudy" => $Batch->getFkStudy()
            ));
        }

        if ($request->isPost())
        {
            $updateAnalyteConcentration = $request->getPost('update-analyte_concentration');
            if (!empty($updateAnalyteConcentration))
            {
                foreach ($updateAnalyteConcentration as $key => $value)
                {
                    $batchNominal = $this->getRepository('\\Alae\\Entity\\BatchNominal')->find($key);

                    if ($batchNominal && $batchNominal->getId())
                    {

                        $older = sprintf('Valores antiguos: Value -> %1$s',
                            $batchNominal->getAnalyteConcentration()
                        );

                        $batchNominal->setAnalyteConcentration($updateAnalyteConcentration[$key]);
                        $this->getEntityManager()->persist($batchNominal);
                        $this->getEntityManager()->flush();

                        $this->transaction(
                            "Edición de valor nominal",
                            sprintf('%1$s<br> Estudio: %2$s. Sample -> %3$s, Valor -> %4$s',
                                $older,
                                $AnaStudy[0]->getFkStudy()->getCode(),
                                $batchNominal->getSampleName(),
                                $updateAnalyteConcentration[$key]
                            ),
                            false
                        );
                    }
                }
            }
        }

        $query   = $this->getEntityManager()->createQuery("
            SELECT n.id, n.sampleName, n.analyteConcentration
            FROM Alae\Entity\BatchNominal n
            WHERE n.fkBatch = " . $Batch->getPkBatch());

        $data     = array();
        $elements = $query->getResult();
        foreach ($elements as $nominal)
        {
            $buttons = "";
            $buttons .= '<span class="form-datatable-change" onclick="changeElement(this, ' . $nominal["id"] . ');"></span>';
            $data[] = array(
                "id"    => $nominal['id'],
                "sample_name"    => $nominal['sampleName'],
                "analyte_concentration"  => $nominal['analyteConcentration'],
                "edit"                  => $buttons
            );
        }

        $datatable = new \Alae\Service\Datatable($data, \Alae\Service\Datatable::DATATABLE_BATCH_NOMINAL, $this->_getSession()->getFkProfile()->getName());
        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('AnaStudy', $AnaStudy);
        $viewModel->setVariable('Batch', $Batch);
        $viewModel->setVariable('state', $state);
        $viewModel->setVariable('user', $this->_getSession());
        $viewModel->setVariable('error', $error);
        $viewModel->setVariable('pkBatch', $Batch->getPkBatch());
        return $viewModel;
    }
}
