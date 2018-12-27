<?php

/**
 * Zend Framework (http://framework.zend.com/)
 *
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2013 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */
/**
 * Modulo de gestión de estudios, este fichero se encarga de:
 * 	1.- Creación y edición de estudios
 * 	2.- Asignación de analitos para el estudio
 * 	3.- Ingreso de concentraciones nominales
 * 	4.- Aprobación, duplicación y cierre de estudios
 * 	5.- Aprobación y desbloqueo de concentraciones nominales
 * @author Maria Quiroz
   Fecha de creación: 16/05/2014
 */

namespace Alae\Controller;

use Zend\View\Model\ViewModel,
    Alae\Controller\BaseController,
    Zend\View\Model\JsonModel,
    Alae\Service\Datatable;

class StudyController extends BaseController
{

    protected $_document = '\\Alae\\Entity\\Study';

    public function init()
    {
        if (!$this->isLogged())
        {
            header('Location: ' . \Alae\Service\Helper::getVarsConfig("base_url"));
            exit;
        }
    }

    public function indexAction()
    {
        $data     = array();
        $elements = $this->getRepository()->findBy(array("status" => true, "closeFlag" => 0), array("pkStudy" => 'desc'));
        $User     = $this->_getSession();

        foreach ($elements as $study)
        {
            switch ($this->_getSession()->getFkProfile()->getName())
            {
                case "Administrador":
                    //CASO DIRECTOR DE ESTUDIO MOSTRAR BOTONES DE VER Y EDITAR
                case "Director Estudio":
                    $buttons = ($study->getCloseFlag()) ?
                        '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/edit/' . $study->getPkStudy() . '?state=open"><span class="form-datatable-lupa"></span></a>' :
                        '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/edit/' . $study->getPkStudy() . '?state=open"><span class="form-datatable-change"></span></a>';
                    break;
                case "Laboratorio":
                    //CASO UGC MOSTRAR BOTON DE VER
                case "UGC":
                    $buttons = '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/edit/' . $study->getPkStudy() . '?state=open"><span class="form-datatable-lupa"></span></a>';
                    break;
            }

            $counterAnalyte = $this->counterAnalyte($study->getPkStudy());
            //MUESTRA LOS DATOS EN PANTALLA
            $data[]         = array(
                "code"        => $study->getCode(),
                "description" => $study->getDescription(),
                "date"        => $study->getCreatedAt(),
                "analyte"     => $counterAnalyte,
                "observation" => $study->getObservation(),
                "edit"        => $buttons
            );
        }

        $datatable = new Datatable($data, Datatable::DATATABLE_STUDY, $this->_getSession()->getFkProfile()->getName());
        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('user', $User);
        return $viewModel;
    }

    public function indexCloseAction()
    {
        $data     = array();
        $elements = $this->getRepository()->findBy(array("status" => true,"closeFlag" => 1), array("pkStudy" => 'desc'));
        $User     = $this->_getSession();

        foreach ($elements as $study)
        {
            switch ($this->_getSession()->getFkProfile()->getName())
            {
                case "Administrador":
                    $buttons = '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/edit/' . $study->getPkStudy() . '?state=close"><span class="form-datatable-lupa"></span></a>';
                    break;
                case "Director Estudio":
                    $buttons = '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/edit/' . $study->getPkStudy() . '?state=close"><span class="form-datatable-lupa"></span></a>';
                    break;
                case "Laboratorio":
                    //CASO UGC MOSTRAR BOTON DE VER
                case "UGC":
                    $buttons = '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/edit/' . $study->getPkStudy() . '?state=close"><span class="form-datatable-lupa"></span></a>';
                    break;
            }

            $counterAnalyte = $this->counterAnalyte($study->getPkStudy());
            //MUESTRA LOS DATOS EN PANTALLA
            $data[]         = array(
                "code"        => $study->getCode(),
                "description" => $study->getDescription(),
                "date"        => $study->getCreatedAt(),
                "analyte"     => $counterAnalyte,
                "observation" => $study->getObservation(),
                "edit"        => $buttons
            );
        }

        $datatable = new Datatable($data, Datatable::DATATABLE_STUDY_CLOSE, $this->_getSession()->getFkProfile()->getName());
        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('user', $User);
        return $viewModel;
    }

    /*
     * Esta función se encarga de controlar y crear un estudio.
     */
    public function createAction()
    {
        $request = $this->getRequest();
        $viewModel = new ViewModel();

        if ($request->isPost())
        {
            $User = $this->_getSession();
            $elements = $this->getRepository()->findBy(array("code" => $request->getPost('code')));

            if(count($elements) > 0)
            {
                //VERIFICA QUE EL ESTUDIO YA EXISTE
                $viewModel->setVariable('error', "<li>Este estudio ya existe. Intente con otro código, por favor<li>");
            }
            else
            {
                /*
                 * Creación de los datos básicos del estudio
                 */
                try
                {
                    //CREA EL ESTUDIO
                    $Study = new \Alae\Entity\Study();
                    $Study->setCode($request->getPost('code'));
                    $Study->setDescription($request->getPost('description'));
                    $Study->setCreatedAt($request->getPost('create_at'));
                    $Study->setObservation($request->getPost('observation'));
                    $Study->setFkDilutionTree($request->getPost('dilution_tree'));
                    $Study->setStatus(true);
                    $Study->setCloseFlag(false);
                    $Study->setApprove(false);
                    $Study->setDuplicate(false);
                    $Study->setFkUser($User);
                    $this->getEntityManager()->persist($Study);
                    $this->getEntityManager()->flush();
                    $this->transaction(
                        "Creación de estudio",
                        sprintf('El usuario %1$s ha creado el estudio %2$s - Código: %2$s, Descripción: %3$s, Observaciones: %4$s, Fecha de creación: %5$s',
                            $User->getUsername(),
                            $Study->getCode(),
                            $Study->getDescription(),
                            $Study->getObservation(),
                            $Study->getCreatedAt()
                        ),
                        false
                    );
                    return $this->redirect()->toRoute('study', array(
                        'controller' => 'study',
                        'action'     => 'edit',
                        'id'         => $Study->getPkStudy()
                    ));
                }
                catch (Exception $e)
                {
                    exit;
                }
            }
        }


        $viewModel->setVariable('user', $this->_getSession());
        return $viewModel;
    }

    /*
     * Esta función se encarga de eliminar los analitos de un estudio
     */
    public function deleteanastudyAction()
    {
        $request = $this->getRequest();

        if ($request->isGet())
        {
            $AnaStudy = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->find($request->getQuery('pk'));
            if ($AnaStudy && $AnaStudy->getPkAnalyteStudy())
            {
                try
                {
                    //BORRA EL ESTUDIO
                    $this->getEntityManager()->remove($AnaStudy);
                    $this->getEntityManager()->flush();
                    $this->transaction(
                        "Eliminar de analito en estudio",
                        sprintf('El usuario %1$s ha eliminado el analito %2$s del estudio %3$s',
                            $this->_getSession()->getUsername(),
                            $AnaStudy->getFkAnalyte()->getShortening(),
                            $AnaStudy->getFkStudy()->getCode()
                        ),
                        false
                    );
                    return new JsonModel(array("status" => true));
                }
                catch (Exception $e)
                {
                    exit;
                }
            }
        }
    }
    
/*
 * Esta función se encarga para editar los datos de un estudio
 */
    public function editAction()
    {
		$mostrarConfirmar = false;
        $request = $this->getRequest();

        if ($this->getEvent()->getRouteMatch()->getParam('id'))
        {
            $Study   = $this->getRepository()->find($this->getEvent()->getRouteMatch()->getParam('id'));
            $canEdit = ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio()) && !$Study->getCloseFlag() && !$Study->getApprove();
        }

        if ($request->isPost())
        {
			$mostrarConfirmar = true;
            $User    = $this->_getSession();
            $Study   = $this->getRepository()->find($request->getPost('study_id'));
            $canEdit = ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio()) && !$Study->getCloseFlag() && !$Study->getApprove();

            /*
             * Creación de los datos básicos del estudio
             */
            if ($canEdit &&
               (($Study->getDescription() != $request->getPost('description') && $request->getPost('description') != '') ||
                ($Study->getObservation() != $request->getPost('observation') && $request->getPost('observation') != '') ||
                ($Study->getCreatedAt() != $request->getPost('create_at') && $request->getPost('create_at') != '') ||
                ($Study->getFkDilutionTree() != $request->getPost('dilution_tree') && $request->getPost('dilution_tree') != '')))
            {
                try
                {
                    //EDITA EL ESTUDIO
                    $older = sprintf('Valores antes del cambio -> Usuario: %1$s Código: %2$s, Descripción: %3$s, Observaciones: %4$s, Fecha de creación: %5$s',
                        $Study->getFkUser()->getUsername(),
                        $Study->getCode(),
                        $Study->getDescription(),
                        $Study->getObservation(),
                        $Study->getCreatedAt()
                    );

                    if($Study->getDescription() != $request->getPost('description') && $request->getPost('description') != '')
                        $Study->setDescription($request->getPost('description'));

                    if($Study->getObservation() != $request->getPost('observation') && $request->getPost('observation') != '')
                        $Study->setObservation($request->getPost('observation'));

                    if($Study->getCreatedAt() != $request->getPost('create_at') && $request->getPost('create_at') != '')
                        $Study->setCreatedAt($request->getPost('create_at'));

                    if($Study->getFkDilutionTree() != $request->getPost('dilution_tree') && $request->getPost('dilution_tree') != '')
                        $Study->set($request->getPost('dilution_tree'));

                    $Study->setFkUser($User);
                    $this->getEntityManager()->persist($Study);
                    $this->getEntityManager()->flush();
                    $this->transaction(
                        "Edición de estudios",
                        sprintf('El usuario %1$s ha editado el estudio %2$s <br> %3$s <br> Valores nuevos -> Código: %2$s, Descripción: %4$s, Observaciones: %5$s, Fecha de creación: %6$s',
                            $User->getUsername(),
                            $request->getPost('code'),
                            $older,
                            $request->getPost('description'),
                            $request->getPost('observation'),
                            $request->getPost('create_at')
                        ),
                        false
                    );
                }
                catch (Exception $e)
                {
                    exit;
                }
            }

            /*
             * Asociaciones de analitos y ediciones de los existentes
             */
            $createAnalyte   = $request->getPost('create-analyte');
            $createAnalyteIs = $request->getPost('create-analyte_is');
            $createCsNumber  = $request->getPost('create-cs_number');
            $createQcNumber  = $request->getPost('create-qc_number');
            $createUnit      = $request->getPost('create-unit');
            $createIs        = $request->getPost('create-is');
            $createRetentionTime = $request->getPost('create-retention_TimeA');
            $createRetentionTimeIS = $request->getPost('create-retention_TimeIS');
            $createAccceptanceMargin = $request->getPost('create-acceptance_Margin');
            $createUse       = $request->getPost('create-use');
            $updateAnalyte   = $request->getPost('update-analyte');
            $updateAnalyteIs = $request->getPost('update-analyte_is');
            $updateRetentionTime = $request->getPost('update-retention_TimeA');
            $updateRetentionTimeIS = $request->getPost('update-retention_TimeIS');
            $updateAccceptanceMargin = $request->getPost('update-acceptance_Margin');
            $updateCsNumber  = $request->getPost('update-cs_number');
            $updateQcNumber  = $request->getPost('update-qc_number');
            $updateIs        = $request->getPost('update-is');
            $updateUse       = $request->getPost('update-use');

            if (!empty($createAnalyte))
            {
                foreach ($createAnalyte as $key => $value)
                {
                    $Analyte   = $this->getRepository('\\Alae\\Entity\\Analyte')->find($value);
                    $AnalyteIs = $this->getRepository('\\Alae\\Entity\\Analyte')->find($createAnalyteIs[$key]);
                    $Unit      = $this->getRepository('\\Alae\\Entity\\Unit')->find($createUnit[$key]);

                    try
                    {
                        $AnaStudy = new \Alae\Entity\AnalyteStudy();
                        $AnaStudy->setFkAnalyte($Analyte);
                        $AnaStudy->setFkAnalyteIs($AnalyteIs);
                        $AnaStudy->setFkStudy($Study);
                        $AnaStudy->setCsNumber($createCsNumber[$key]);
                        $AnaStudy->setQcNumber($createQcNumber[$key]);
                        $AnaStudy->setFkUnit($Unit);
                        $AnaStudy->setInternalStandard($createIs[$key]);
                        $AnaStudy->setRetentionTimeAnalyte($createRetentionTime[$key]);
                        $AnaStudy->setRetentionTimeIS($createRetentionTimeIS[$key]);
                        $AnaStudy->setAcceptanceMargin($createAccceptanceMargin[$key]);
                        $AnaStudy->setStatus(false);
                        $AnaStudy->setIsUsed((isset($createUse[$key]) ? true : false));
                        $AnaStudy->setFkUser($User);
                        $this->getEntityManager()->persist($AnaStudy);
                        $this->getEntityManager()->flush();
                        $this->transaction(
                            "Asociar analitos a estudio",
                            sprintf('El usuario %1$s ha agrega el analito %2$s(%3$s) al estudio %4$s.<br>Patrón Interno (IS): %5$s, Núm CS: %6$s, Núm QC: %7$s, Unidades: %8$s, % var IS: %9$s, Tiempo retención analito: %11$s,Tiempo retención IS: %12$s,Margen de aceptación: %13$s, usar: %10$s',
                                $User->getUsername(),
                                $Analyte->getName(),
                                $Analyte->getShortening(),
                                $Study->getCode(),
                                $AnalyteIs->getName(),
                                $createCsNumber[$key],
                                $createQcNumber[$key],
                                $Unit->getName(),
                                $createIs[$key],
                                (isset($createUse[$key]) ? "S" : "N"),
                                $createAnalyte[$key],
                                $createAnalyteIs[$key],
                                $createRetentionTime[$key]
                            ),
                            false
                        );
                    }
                    catch (Exception $e)
                    {
                        exit;
                    }
                }
            }

            if (!empty($updateCsNumber))
            {
                foreach ($updateCsNumber as $key => $value)
                {
                    $AnaStudy = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->find($key);

                    if ($AnaStudy && $AnaStudy->getPkAnalyteStudy())
                    {
                        try
                        {
                            $older =  sprintf('Valores antiguos -> Analito: %9$s, Patrón Internos IS: %8$s, Tiempo retención analito: %4$s,Tiempo retención IS: %5$s,Margen de aceptación: %6$s, Núm CS: %1$s, Núm QC: %2$s, % var IS: %3$s, usar: %7$s<br>',
                                $AnaStudy->getCsNumber(),
                                $AnaStudy->getQcNumber(),
                                $AnaStudy->getInternalStandard(),
                                $AnaStudy->getRetentionTimeAnalyte(),
                                $AnaStudy->getRetentionTimeIS(),
                                $AnaStudy->getAcceptanceMargin(),
                                ($AnaStudy->getIsUsed() ? "S" : "N"),
                                $AnaStudy->getFkAnalyteIs()->getShortening(),
                                $AnaStudy->getFkAnalyte()->getShortening()
                            );
                            $Analyte   = $this->getRepository('\\Alae\\Entity\\Analyte')->find($updateAnalyte[$key]);
                            $AnalyteIs = $this->getRepository('\\Alae\\Entity\\Analyte')->find($updateAnalyteIs[$key]);

                            $AnaStudy->setFkAnalyte($Analyte);
                            $AnaStudy->setFkAnalyteIs($AnalyteIs);
                            $AnaStudy->setCsNumber($updateCsNumber[$key]);
                            $AnaStudy->setQcNumber($updateQcNumber[$key]);
                            $AnaStudy->setInternalStandard($updateIs[$key]);
                            $AnaStudy->setRetentionTimeAnalyte($updateRetentionTime[$key]);
                            $AnaStudy->setRetentionTimeIS($updateRetentionTimeIS[$key]);
                            $AnaStudy->setAcceptanceMargin($updateAccceptanceMargin[$key]);
                            $AnaStudy->setIsUsed(isset($updateUse[$key]) ? true : false);
                            $this->getEntityManager()->persist($AnaStudy);
                            $this->getEntityManager()->flush();
                            $this->transaction(
                                "Edición de analitos asociados a estudio",
                                sprintf('El usuario %1$s ha editado la información del analito %2$s(%3$s) en el estudio %4$s.<br>%5$s'
                                        . 'Valores nuevos -> Analito: %11$s, Patrón Internos IS: %10$s, Núm CS: %6$s, Núm QC: %7$s, % var IS: %8$s, Tiempo retención analito: %12$s,Tiempo retención IS: %13$s,Margen de aceptación: %14$s,usar: %9$s',
                                    $User->getUsername(),
                                    $AnaStudy->getFkAnalyte()->getName(),
                                    $AnaStudy->getFkAnalyte()->getShortening(),
                                    $Study->getCode(),
                                    $older,
                                    $updateCsNumber[$key],
                                    $updateQcNumber[$key],
                                    $updateIs[$key],
                                    (isset($updateUse[$key]) ? "S" : "N"),
                                    $AnalyteIs->getShortening(),
                                    $Analyte->getShortening(),
                                    $updateAnalyte[$key],
                                    $updateAnalyteIs[$key],
                                    $updateRetentionTime[$key]
                                ),
                                false
                            );
                        }
                        catch (Exception $e)
                        {
                            exit;
                        }
                    }
                }
            }
        }

        $data     = array();
         //$elements = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->findBy(array("fkStudy" => $Study->getPkStudy()));

        $query    = $this->getEntityManager()->createQuery("
                                SELECT s
                                FROM Alae\Entity\AnalyteStudy s, Alae\Entity\Analyte a
                                WHERE s.fkAnalyte = a.pkAnalyte AND s.fkStudy = " .$Study->getPkStudy() ." 
                                ORDER BY a.shortening ASC");
                                $elements = $query->getResult();

        foreach ($elements as $anaStudy)
        {
            $buttons = "";

            if ($anaStudy->getFkStudy()->getApprove())
            {
                $buttons .= '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/nominalconcentration/' . $anaStudy->getPkAnalyteStudy() . '?state='.$_GET['state'].'"><span class="form-datatable-nominal"></span></a>';
            }
            elseif($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio() && !$anaStudy->getFkStudy()->getCloseFlag())
            {
                $buttons .= '<span class="form-datatable-change" onclick="changeElement(this, ' . $anaStudy->getPkAnalyteStudy() . ');"></span>';
                $buttons .= $this->_getSession()->isAdministrador() ? '<span class="form-datatable-delete" onclick="removeElement(this, ' . $anaStudy->getPkAnalyteStudy() . ');"></span>' : '';
            }

            if($anaStudy->getFkStudy()->getApprove() && $anaStudy->getStatus())
            {
                $buttons .= '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/batch/list/' . $anaStudy->getPkAnalyteStudy() . '?state='.$_GET['state'].'"><span class="form-datatable-batch"></span></a>';
            }
    
            $data[] = array(
                "analyte"    => $anaStudy->getFkAnalyte()->getShortening(),
                "analyte_is" => $anaStudy->getFkAnalyteIs()->getShortening(),
                "cs_number"  => $anaStudy->getCsNumber(),
                "qc_number"  => $anaStudy->getQcNumber(),
                "unit"       => $anaStudy->getFkUnit()->getName(),
                "is"         => number_format($anaStudy->getInternalStandard(), 4, '.', ''),
                "retention_TimeA" => number_format($anaStudy->getRetentionTimeAnalyte(), 4, '.', ''),
                "retention_TimeIS" => number_format($anaStudy->getRetentionTimeIS(), 4, '.', ''),
                "acceptance_Margin" => number_format($anaStudy->getAcceptanceMargin(), 4, '.', ''),
                "use"        => $anaStudy->getIsUsed(),
                "edit"       => $buttons
            );
        }

        $isDuplicated = $Study->getApprove() && $this->_getSession()->isAdministrador() && !$Study->getCloseFlag();

        $Analyte   = $this->getRepository('\\Alae\\Entity\\Analyte')->findBy(array("status" => true), array('shortening' => 'ASC'));
        $Unit      = $this->getRepository('\\Alae\\Entity\\Unit')->findAll();
        $datatable = new Datatable($data, Datatable::DATATABLE_ANASTUDY, $this->_getSession()->getFkProfile()->getName());
        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('study', $Study);
        $viewModel->setVariable('error', (isset($error) ? $error : ""));
        $viewModel->setVariable('analytes', $Analyte);
        $viewModel->setVariable('units', $Unit);
        $viewModel->setVariable('user', $this->_getSession());
        $viewModel->setVariable('isDuplicated',  $isDuplicated);
        $viewModel->setVariable('disabled', (($canEdit) ? '' : 'disabled=""'));
        $viewModel->setVariable('mostrarConfirmar', $mostrarConfirmar);
        
        if(isset($_GET['state']))
        {
            $state = $_GET['state'];
        }
        else
        {
            $state = 'open';
        }
        
        $viewModel->setVariable('state', $state);
        return $viewModel;
    }

    /*
     * Función que se encarga de la eliminación de estudios
     */
    public function deleteAction()
    {
        $request = $this->getRequest();
        if ($request->isGet())
        {
            $Study = $this->getRepository()->find($request->getQuery('pk'));
            if ($Study && $Study->getPkStudy())
            {
                try
                {
                    //BORRAR ESTUDIO
                    $User = $this->_getSession();
                    $Study->setStatus(false);
                    $Study->setFkUser($User);
                    $this->getEntityManager()->persist($Study);
                    $this->getEntityManager()->flush();
                    $this->transaction(
                        "Eliminar estudio",
                        sprintf('El usuario %1$s ha eliminado el estudio %2$s',
                            $User->getUsername(),
                            $Study->getCode()
                        ),
                        false
                    );
                    return new JsonModel(array("status" => true));
                }
                catch (Exception $e)
                {
                    exit;
                }
            }
        }
    }

    /*
     * Función que se encarga de la aprobación del estudio
     */
    public function approveAction()
    {
        $request = $this->getRequest();

	if ($request->isGet() && ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio()))
	{
            $Study = $this->getRepository('\\Alae\\Entity\\Study')->find($request->getQuery('id'));

	    if ($Study && $Study->getPkStudy())
            {
                try
                {
                    //APROBAR ESTUDIO
                    $User = $this->_getSession();
                    $Study->setApprove(true);
                    $Study->setFkUserApprove($User);
                    $Study->setApprovedAt(new \DateTime('now'));
                    $this->getEntityManager()->persist($Study);
                    $this->getEntityManager()->flush();
                    $this->transaction(
                        "Aprobar estudio",
                        sprintf('El usuario %1$s ha aprobado el estudio %2$s',
                            $User->getUsername(),
                            $Study->getCode()
                        ),
                        false
                    );
                    return new JsonModel(array("status" => true));
                }
                catch (Exception $e)
                {
                    exit;
                }
            }
	}
    }

    /*
     * Esta función se encarga de cerrar el estudio
     */
    public function closeAction()
    {
        $request = $this->getRequest();

        if ($request->isGet() && ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio()))
        {
            $Study = $this->getRepository('\\Alae\\Entity\\Study')->find($request->getQuery('id'));

            if ($Study && $Study->getPkStudy())
            {
                try
                {
                    //CERRAR ESTUDIO
                    $User = $this->_getSession();
                    $Study->setCloseFlag(true);
                    $Study->setFkUserClose($User);
                    $this->getEntityManager()->persist($Study);
                    $this->getEntityManager()->flush();
                    $this->transaction(
                        "Cerrar estudio",
                        sprintf("El estudio %s ha sido cerrado por el usuario %s ", $Study->getCode(), $User->getUsername()),
                        false
                    );
                    return new JsonModel(array("status" => true));
                }
                catch (Exception $e)
                {
                    exit;
                }
            }
        }
    }

    /*
     * Esta función se encarga de duplicar el estudio
     */
    public function duplicateAction()
    {
        $request = $this->getRequest();

        if ($request->isGet() && $this->_getSession()->isAdministrador())
        {
            $Study = $this->getRepository('\\Alae\\Entity\\Study')->find($request->getQuery('id'));

            if ($Study && $Study->getPkStudy())
            {
                try
                {
                    //DUPLICAR ESTUDIO
                    $User  = $this->_getSession();
                    $code  = explode("-", $Study->getCode());
                    $query = $this->getEntityManager()->createQuery("
                            SELECT COUNT(s.pkStudy)
                            FROM Alae\Entity\Study s
                            WHERE s.code LIKE  '%" . ($code[0] . "-" . $code[1]) . "%'");
                    $counter = $query->getSingleScalarResult();

                    $newStudy = new \Alae\Entity\Study();
                    $newStudy->setDescription($Study->getDescription());
                    $newStudy->setObservation($Study->getObservation());
                    $newStudy->setCode($code[0] . "-" . $code[1] . "-" . str_pad($counter, 2, "0", STR_PAD_LEFT));
                    $newStudy->setCloseFlag(false);
                    $newStudy->setStatus(true);
                    $newStudy->setApprove(false);
                    $newStudy->setDuplicate(true);
                    $newStudy->setCreatedAt($Study->getCreatedAt());
                    $newStudy->setFkUser($User);
                    $this->getEntityManager()->persist($newStudy);
                    $this->getEntityManager()->flush();

                    $elements = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array("fkStudy" => $Study->getPkStudy()));
                    foreach ($elements as $AnaStudy)
                    {
                        $newAnaStudy = new \Alae\Entity\AnalyteStudy();
                        $newAnaStudy->setFkAnalyte($AnaStudy->getFkAnalyte());
                        $newAnaStudy->setFkAnalyteIs($AnaStudy->getFkAnalyteIs());
                        $newAnaStudy->setFkStudy($newStudy);
                        $newAnaStudy->setCsNumber($AnaStudy->getCsNumber());
                        $newAnaStudy->setQcNumber($AnaStudy->getQcNumber());
                        $newAnaStudy->setFkUnit($AnaStudy->getFkUnit());
                        $newAnaStudy->setInternalStandard($AnaStudy->getInternalStandard());
                        $newAnaStudy->setStatus(false);
                        $newAnaStudy->setIsUsed($AnaStudy->getIsUsed());
                        $newAnaStudy->setFkUser($User);
                        $this->getEntityManager()->persist($newAnaStudy);
                        $this->getEntityManager()->flush();
                    }

                    $Study->setCloseFlag(true);
                    $this->getEntityManager()->persist($Study);
                    $this->getEntityManager()->flush();

                    $this->transaction(
                        "Duplicar estudio",
                        sprintf('El usuario %1$s ha duplicado el estudio %2$s.<br>',
                            $User->getUsername(),
                            $Study->getCode()
                        ),
                        false
                    );

                    return new JsonModel(array("status" => true));
                }
                catch (Exception $e)
                {
                    exit;
                }
            }
        }
    }

    /**
     * Función para aprobar las concentraciones nominales
     */
    public function approvencAction()
    {
        $request = $this->getRequest();

	if ($request->isGet() && ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio()))
	{
            $AnaStudy = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->find($request->getQuery('id'));

	    if ($AnaStudy && $AnaStudy->getPkAnalyteStudy())
            {
                try
                {
                    //APROBAR CONCENTRACIONES NOMINALES
                    $User = $this->_getSession();
                    $AnaStudy->setStatus(true);
                    $AnaStudy->setFkUserApprove($User);
                    $this->getEntityManager()->persist($AnaStudy);
                    $this->getEntityManager()->flush();
                    $this->transaction(
                        "Aprobación de concentraciones nominales",
                        sprintf('El usuario %1$s ha aprobado las concentraciones nominales del estudio %2$s<br>'
                                . 'Concentración Nominal de los Estándares de Calibración: %3$s<br>'
                                . 'Concentración Nominal de los Controles de Calidad: %4$s<br>'
                                . 'Concentración Nominal de los LDQC y HDQC, respectivamente: %5$s, %6$s',
                            $User->getUsername(),
                            $AnaStudy->getFkStudy()->getCode(),
                            $AnaStudy->getCsValues(),
                            $AnaStudy->getQcValues(),
                            $AnaStudy->getLdqcValues(),
                            $AnaStudy->getHdqcValues()
                        ),
                        false
                    );
                    return new JsonModel(array("status" => true));
                }
                catch (Exception $e)
                {
                    exit;
                }
            }
	}
    }

    /*
     * Función para desbloquear las concentraciones nominales
     */
    public function unlockAction()
    {
        $request = $this->getRequest();

	if ($request->isGet() && $this->_getSession()->isAdministrador())
	{
            $AnaStudy = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->find($request->getQuery('id'));

	    if ($AnaStudy && $AnaStudy->getPkAnalyteStudy())
            {
                try
                {
                    //DESBLOQUEA LAS CONCENTRACIONES NOMINALES
                    $User = $this->_getSession();
                    $AnaStudy->setStatus(false);
                    $AnaStudy->setFkUser($User);
                    $this->getEntityManager()->persist($AnaStudy);
                    $this->getEntityManager()->flush();

                    $this->transaction(
                        "Desbloquear concentraciones nominales",
                        sprintf('El usuario %1$s ha desbloqueado las concentraciones nominales del estudio %2$s<br>'
                                . 'Analito: %3$s<br>'
                                . 'Concentración Nominal de los Estándares de Calibración: %4$s<br>'
                                . 'Concentración Nominal de los Controles de Calidad: %5$s',
                            $this->_getSession()->getUsername(),
                            $AnaStudy->getFkStudy()->getCode(),
                            $AnaStudy->getFkAnalyte()->getName(),
                            $AnaStudy->getCsValues(),
                            $AnaStudy->getQcValues()
                        ),
                        false
                    );
                    return new JsonModel(array("status" => true));
                }
                catch (Exception $e)
                {
                    exit;
                }
            }
	}
    }

    /*
     * Función para ingresar las concentraciones nominacionales
     */
     public function nominalconcentrationAction()
    {
        $request = $this->getRequest();

        if ($this->getEvent()->getRouteMatch()->getParam('id'))
        {
            $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->find($this->getEvent()->getRouteMatch()->getParam('id'));
        }

        if ($request->isPost())
        {
            //INGRESAR LAS CONCENTRACIONES NOMINALES
            $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->find($request->getPost('id'));
            $AnaStudy->setCsValues(implode(",", $request->getPost("cs_number")));
            $AnaStudy->setQcValues(implode(",", $request->getPost("qc_number")));
            $AnaStudy->setHdqcValues($request->getPost("hdqc_number"));
            $AnaStudy->setLdqcValues($request->getPost("ldqc_number"));
            $this->getEntityManager()->persist($AnaStudy);
            $this->getEntityManager()->flush();
            $this->transaction(
                "Ingreso concentraciones nominales",
                sprintf('El usuario %1$s ha ingresado las concentraciones nominales del estudio %2$s<br>'
                        . 'Analito: %3$s<br>'
                        . 'Concentración Nominal de los Estándares de Calibración: %4$s<br>'
                        . 'Concentración Nominal de los Controles de Calidad: %5$s<br>'
                        . 'Concentración Nominal de los LDQC y HDQC, respectivamente: %6$s, %7$s',
                    $this->_getSession()->getUsername(),
                    $AnaStudy->getFkStudy()->getCode(),
                    $AnaStudy->getFkAnalyte()->getName(),
                    implode(",", $request->getPost("cs_number")),
                    implode(",", $request->getPost("qc_number")),
                    $request->getPost("ldqc_number"),
                    $request->getPost("hdqc_number")
                ),
                false
            );
        }

        $query = $this->getEntityManager()->createQuery("
                SELECT COUNT(b.pkBatch)
                FROM Alae\Entity\Batch b
                WHERE
                    b.validFlag IS NOT NULL AND
                    b.fkStudy = " . $AnaStudy->getFkStudy()->getPkStudy() . " AND
                    b.fkAnalyte = " . $AnaStudy->getFkAnalyte()->getPkAnalyte());
        $counter = $query->getSingleScalarResult();

        $viewModel = new ViewModel();
        $viewModel->setVariable('AnaStudy', $AnaStudy);
        $viewModel->setVariable('cs_number', explode(",", $AnaStudy->getCsValues()));
        $viewModel->setVariable('qc_number', explode(",", $AnaStudy->getQcValues()));
        $viewModel->setVariable('ldqc_number', number_format($AnaStudy->getLdqcValues(), 2, '.',''));
        $viewModel->setVariable('hdqc_number', number_format($AnaStudy->getHdqcValues(), 2, '.',''));
        $viewModel->setVariable('User', $this->_getSession());
        $viewModel->setVariable('isUnlock', $counter == 0 ? true : false);
        $viewModel->setVariable('disabled', (!$AnaStudy->getStatus() && ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio()) ? '' : 'disabled=""'));
        $viewModel->setVariable('state', $_GET['state']);
        return $viewModel;
    }

    //función para contar los analitos en un estudio
    protected function counterAnalyte($pkStudy)
    {
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(a.fkAnalyte)
            FROM \Alae\Entity\AnalyteStudy a
            WHERE a.fkStudy = " . $pkStudy . "
            GROUP BY a.fkStudy");
        $response = $query->execute();
        return $response ? $query->getSingleScalarResult() : 0;
    }
}
