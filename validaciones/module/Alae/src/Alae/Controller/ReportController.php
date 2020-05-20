<?php

/**
 * Zend Framework (http://framework.zend.com/)
 *
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2013 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

  /**
 * Modulo de reportes del sistema
   * En este fichero la clase reportController se encarga de preparar la información necesaria
   * para generar los diferentes reports del sistema. La clase contiene las funciones identificadas como:
   * r#action donde el número corresponde a cada uno de los reportes existentes.
   * Cada una de estas funciones enviará a formato excel o formato pdf el resultado.
 * @author Maria Quiroz
   Fecha de creación: 19/05/2014
 */

namespace Alae\Controller;

use Zend\View\Model\ViewModel,
    Alae\Controller\BaseController,
    Zend\View\Model\JsonModel,
    Alae\Service\Datatable;

class ReportController extends BaseController
{

    public function init()
    {
        if (!$this->isLogged())
        {
            header('Location: ' . \Alae\Service\Helper::getVarsConfig("base_url"));
            exit;
        }
    }

    public function auditAction()
    {
        $request = $this->getRequest();
        $where = "";
        if ($request->isPost())
        {
            $from = $request->getPost('from');

            //PARAMETROS DE FECHA INICIO Y FECHA FIN
            if ($request->getPost('from') != "" && $request->getPost('to') != "")
            {
                $to = $request->getPost('to');
                $where = "WHERE a.createdAt > '$from' AND a.createdAt < '$to 23:59:00'";
            }
            else
            {
                $where = "WHERE a.createdAt > '$from'";
            }
        }

        $query = $this->getEntityManager()->createQuery("
            SELECT a
            FROM Alae\Entity\AuditTransaction a
            $where
            ORDER BY a.createdAt DESC");
        $elements = $query->getResult();

        //MUESTRA LOS DATOS DE LAS TRANSACCIONES FILTRADAS POR FECHA INICIO Y FECHA FIN EN PANTALLA
        $data     = array();
        foreach ($elements as $AuditTransaction)
        {
            $data[] = array(
                "created_at"        => $AuditTransaction->getCreatedAt(),
                "section"           => $AuditTransaction->getSection(),
                "audit_description" => $AuditTransaction->getDescription(),
                "user"              => $AuditTransaction->getFkUser()->getUsername()
            );
        }

        $datatable = new Datatable($data, Datatable::DATATABLE_AUDIT_TRAIL, $this->_getSession()->getFkProfile()->getName());
        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('user', $this->_getSession());
        return $viewModel;
    }

    public function ajxstudyAction()
    {
        //MUESTRA EL LISTADO DE ANALITOS
        $request  = $this->getRequest();
        $elements = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->findBy(array(
            "fkStudy" => $request->getQuery('id')));
        //$data     = '<option value="-1">Seleccione</option>';
        $data = '';
        foreach ($elements as $anaStudy)
        {
            $data .= '<option style="color:#000000;" value="' . $anaStudy->getFkAnalyte()->getPkAnalyte() . '">' . $anaStudy->getFkAnalyte()->getName() . '</option>';
        }
        return new JsonModel(array("data" => $data));
    }

    public function ajxbatchAction()
    {
        //MUESTRA EL LISTADO DE LOTES
        $request  = $this->getRequest();
        $query    = $this->getEntityManager()->createQuery("
            SELECT b
            FROM Alae\Entity\Batch b
            WHERE b.fkAnalyte = " . $request->getQuery('an') . " AND b.fkStudy = " . $request->getQuery('id') . " AND b.validFlag is NOT NULL
            ORDER BY b.fileName ASC");
        $elements = $query->getResult();
        // $data     = '<option value="-1">Seleccione</option>';
        $data = '';
        foreach ($elements as $Batch)
        {
            $data .= '<option value="' . $Batch->getPkBatch() . '">' . $Batch->getFileName() . '</option>';
        }
        return new JsonModel(array("data" => $data));
    }

    public function indexAction()
    {
        $error    = $this->getEvent()->getRouteMatch()->getParam('id') > 0 ? true : false;
        $elements = $this->getRepository("\\Alae\\Entity\\Study")->findBy(array("status" => true), array("code" => 'desc'));
        return new ViewModel(array("studies" => $elements, "error" => $error));
    }

    protected function counterAnalyte($pkStudy)
    {
        //CUENTA LOS ANALITOS
        $query    = $this->getEntityManager()->createQuery("
            SELECT COUNT(a.fkAnalyte)
            FROM \Alae\Entity\AnalyteStudy a
            WHERE a.fkStudy = " . $pkStudy . "
            GROUP BY a.fkStudy");
        $response = $query->execute();
        return $response ? $query->getSingleScalarResult() : 0;
    }

    /**
     * Información general del estudio
     * $_GET['id'] = pkStudy
     */
    public function r1Action()
    {
        //REPORTE 1 PDF
        $request = $this->getRequest();
        if ($request->isGet())
        {
            $study            = $this->getRepository('\\Alae\\Entity\\Study')->find($request->getQuery('id'));
            $counterAnalyte   = $this->counterAnalyte($study->getPkStudy());
            $analytes         = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->findBy(array("fkStudy" => $study->getPkStudy()));
            
            $cs_values        = [];
            $csData           = [];
            $qc_values        = [];
            $qcData           = [];
            $ldqc_values      = [];
            $ldqcData         = [];
            $hdqc_values      = [];
            $hdqcData         = [];
            $llqc_values      = [];
            $llqcData         = [];
            $ulqc_values      = [];
            $ulqcData         = [];
            $verifications    = [];
            $verificationData = [];
            foreach ($analytes as $anaStudy)
            {
                $csData        = explode(",", $anaStudy->getCsValues());
                $cs_valuesData = [];
                $i             = 1;
                foreach ($csData as $cs)
                {
                    $cs_valuesData = [
                        "analyte"  => $anaStudy->getFkAnalyte()->getName(),
                        "unit"     => $anaStudy->getFkUnit()->getName(),
                        "sample"   => "CS".$i,
                        "value"    => $cs,
                    ];
                    array_push($cs_values, $cs_valuesData);
                    $i++;
                }

                $qcData        = explode(",", $anaStudy->getQcValues());
                $qc_valuesData = [];
                $i             = 1;
                foreach ($qcData as $qc)
                {
                    $qc_valuesData = [
                        "analyte"  => $anaStudy->getFkAnalyte()->getName(),
                        "unit"     => $anaStudy->getFkUnit()->getName(),
                        "sample"   => "QC".$i,
                        "value"    => $qc
                    ];
                    array_push($qc_values, $qc_valuesData);
                    $i++;
                }

                $ldqc_valuesData = [
                    "analyte"    => $anaStudy->getFkAnalyte()->getName(),
                    "unit"       => $anaStudy->getFkUnit()->getName(),
                    "sample"     => "LDQC",
                    "value"      => $anaStudy->getLdqcValues(),
                ];
                array_push($ldqc_values, $ldqc_valuesData);

                $hdqc_valuesData = [
                    "analyte"    => $anaStudy->getFkAnalyte()->getName(),
                    "unit"       => $anaStudy->getFkUnit()->getName(),
                    "sample"     => "HDQC",
                    "value"      => $anaStudy->getHdqcValues(),
                ];
                array_push($hdqc_values, $hdqc_valuesData);

                $llqc_valuesData = [
                    "analyte"    => $anaStudy->getFkAnalyte()->getName(),
                    "unit"       => $anaStudy->getFkUnit()->getName(),
                    "sample"     => "LLQC",
                    "value"      => $anaStudy->getLlqcValues(),
                ];
                array_push($llqc_values, $llqc_valuesData);

                $ulqc_valuesData = [
                    "analyte"    => $anaStudy->getFkAnalyte()->getName(),
                    "unit"       => $anaStudy->getFkUnit()->getName(),
                    "sample"     => "ULQC",
                    "value"     => $anaStudy->getUlqcValues(),
                ];
                array_push($ulqc_values, $ulqc_valuesData);

                $SampleVerificationStudy = $this->getRepository('\\Alae\\Entity\\SampleVerificationStudy')->findBy(array("fkAnalyteStudy" => $anaStudy->getPkAnalyteStudy()));

                foreach ($SampleVerificationStudy as $sampleVerification) 
                    {
                        $verificationData = [
                            "analyte"     => $anaStudy->getFkAnalyte()->getName(),
                            "sample"      => $sampleVerification->getName(),
                            "associated"  => $sampleVerification->getAssociated(),
                            "value"       => $sampleVerification->getValue()
                        ];

                        array_push($verifications, $verificationData);
                    }
            }

            $properties = array(
                "study"          => $study,
                "validation"     => $study->getValidation(),
                "verification"   => $study->getVerification(),
                "counterAnalyte" => $counterAnalyte,
                "analytes"       => $analytes,
                "cs_values"      => $cs_values,
                "qc_values"      => $qc_values,
                "ldqc_values"    => $ldqc_values,
                "hdqc_values"    => $hdqc_values,
                "llqc_values"    => $llqc_values,
                "ulqc_values"    => $ulqc_values,
                "verifications"  => $verifications
            );

            $viewModel = new ViewModel();
            $viewModel->setTerminal(true);
            $page      = $this->render('alae/report/r1page', $properties);
            $viewModel->setVariable('page', $page);
            $viewModel->setVariable('filename', "informacion_general_de_un_estudio" . date("Ymd-Hi"));
            return $viewModel;
        }
    }

    /**
     * Tabla contenedora de cada lote analitico
     * $_GET['ba'] = pkBatch
     */
    public function r2Action()
    {
        //REPORTE 2 PDF
        $request = $this->getRequest();
        $page    = "";
        if ($request->isGet())
        {
            //GENERA LOS DATOS DEL REPORTE
            ini_set('max_execution_time', 300000);
            $Batch = $this->getRepository('\\Alae\\Entity\\Batch')->find($request->getQuery('ba'));
            if ($Batch && $Batch->getPkBatch())
            {
                $qb       = $this->getEntityManager()->createQueryBuilder();
                $qb
                        ->select('s.sampleName, s.analytePeakName, s.sampleType, s.fileName, s.analytePeakArea, s.isPeakArea, s.areaRatio, s.analyteConcentration, s.calculatedConcentration, s.dilutionFactor, s.accuracy, s.useRecord,
                     s.acquisitionDate, s.analyteRetentionTime, s.isRetentionTime, s.analyteIntegrationType, s.isIntegrationType, s.recordModified,
                    GROUP_CONCAT(DISTINCT p.codeError) as codeError,
                    GROUP_CONCAT(DISTINCT p.messageError) as messageError')
                        ->from('Alae\Entity\SampleBatch', 's')
                        ->leftJoin('Alae\Entity\Error', 'e', \Doctrine\ORM\Query\Expr\Join::WITH, 's.pkSampleBatch = e.fkSampleBatch')
                        ->leftJoin('Alae\Entity\Parameter', 'p', \Doctrine\ORM\Query\Expr\Join::WITH, 'e.fkParameter = p.pkParameter')
                        ->where("s.fkBatch = " . $Batch->getPkBatch())
                        ->groupBy('s.pkSampleBatch')
                        ->orderBy('s.pkSampleBatch', 'ASC');
                $elements = $qb->getQuery()->getResult();
                
                if (count($elements) > 0)
                {
                    $tr1 = $tr2 = "";
                    $tr3 = $tr4 = "";

                    foreach ($elements as $sampleBatch)
                    {
                        $row1     = $row2     = "";
                        $row3     = $row4     = "";
                        $isTable2 = false;

                        foreach ($sampleBatch as $key => $value)
                        {
                            switch ($key)
                            {
                                case "sampleName":
                                    $row1 .= sprintf('<td style="width:75px;text-align:left;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    $row3 .= sprintf('<td style="width:100px;text-align:left;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "fileName":
                                    $row1 .= sprintf('<td style="width:110px;text-align:left;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "analytePeakArea":
                                case "isPeakArea":
                                case "areaRatio":
                                    $row1 .= sprintf('<td style="width:50px;text-align:right;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "analyteConcentration":
                                    $value = number_format($value, 2, '.', '');
                                    $row1 .= sprintf('<td style="width:70px;text-align:right;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "calculatedConcentration":
                                    $value = number_format($value, 2, '.', '');
                                    $row1 .= sprintf('<td style="width:70px;text-align:right;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "dilutionFactor":
                                case "accuracy":
                                    $value = number_format($value, 2, '.', '');
                                    $row1 .= sprintf('<td style="width:50px;text-align:right;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "useRecord":
                                    $row1 .= sprintf('<td style="width:40px;text-align:center;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "analyteRetentionTime":
                                    $row3 .= sprintf('<td style="width:150px;text-align:center;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "isRetentionTime":
                                    $row3 .= sprintf('<td style="width:150px;text-align:center;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "analyteIntegrationType":
                                    $row3 .= sprintf('<td style="width:150px;text-align:center;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "isIntegrationType":
                                    $row3 .= sprintf('<td style="width:150px;text-align:center;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "recordModified":
                                    $row3 .= sprintf('<td style="width:100px;text-align:center;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "acquisitionDate":
                                    $value = $value->format('d.m.Y H:i:s');
                                    $row1 .= sprintf('<td style="width:70px;text-align:right;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "codeError":
                                    $row1 .= sprintf('<td style="width:50px;text-align:center;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                                case "messageError":
                                	$value = str_replace(",", " // ", $value);
                                    $row1 .= sprintf('<td style="width:150px;text-align:left;border: black 1px solid;font-size:13px;padding:4px">%s</td>', htmlentities($value));
                                    $row3 .= sprintf('<td style="width:200px;text-align:left;border: black 1px solid;font-size:13px;padding:4px">%s</td>', htmlentities($value));
                                    break;  
                                default:
                                    $row1 .= sprintf('<td style="width:50px;text-align:left;border: black 1px solid;font-size:13px;padding:4px">%s</td>', $value);
                                    break;
                            }
                        }
                        
                        $tr1 .= sprintf("<tr>%s</tr>", $row1);
                        $tr2 .= sprintf("<tr>%s</tr>", $row2);

                        $tr3 .= sprintf("<tr>%s</tr>", $row3);
                        $tr4 .= sprintf("<tr>%s</tr>", $row4);

                    }

                    //AND ((p.pkParameter BETWEEN 1 AND 8) OR (p.pkParameter BETWEEN 23 AND 29))
                    //GENERA LOS ERRORES
                    $query  = $this->getEntityManager()->createQuery("
                        SELECT DISTINCT(p.pkParameter) as pkParameter, p.messageError
                        FROM Alae\Entity\Error e, Alae\Entity\SampleBatch s, Alae\Entity\Parameter p
                        WHERE s.pkSampleBatch = e.fkSampleBatch
                            AND e.fkParameter = p.pkParameter 
							AND (p.status = 1) 
                            AND s.fkBatch = " . $Batch->getPkBatch() . "
                        ORDER BY p.pkParameter");
						
					//Toni: En el Select ANTERIOR la fila AND (p.status = 1) ) determina que ese parametro 
					//NO DEBE DAR EL LOTE COMO RECHAZADO. Esto lo hace ya en verificationControler, 
					//pero también lo quito aquí para que no salga en el Report 2.
					// He hecho lo mismo en el REPORT 3
					
                    $errors = $query->getResult();

                    $message = array();
                    if (!is_null($Batch->getFkParameter()))
                    {
                        $message[$Batch->getFkParameter()->getPkParameter()] = $Batch->getFkParameter()->getMessageError();
                    }
                    foreach ($errors as $data)
                    {
                        $message[$data['pkParameter']] = $data['messageError'];
                    }
                    ksort($message);

                    $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
                        "fkAnalyte" => $request->getQuery('an'),
                        "fkStudy"   => $request->getQuery('id')
                    ));

                    $varIs = $Batch->getIsCsQcAcceptedAvg(); //* ($AnaStudy[0]->getInternalStandard() / 100);                   
                    $var5 = $Batch->getIsCsQcAcceptedAvg() * (5 / 100);
					
				
                    //echo $tr1;die();
                    /*$properties = array(
                        "batch"  => $Batch,
                        "tr1"    => $tr1,
                        "tr2"    => $tr2,
                        "varIs"    => $varIs,
                        "var5"    => $var5,
                        "errors" => implode(" // ", $message)
                    );
                    $page .= $this->render('alae/report/r2', $properties);*/
                    $viewModel = new ViewModel();
                    $viewModel->setTerminal(true);
                    //$page      = $this->render('acua/report/r2page', $data);
                    $viewModel->setVariable('batch', $Batch);
                    $viewModel->setVariable('tr1', $tr1);
                    
                    $viewModel->setVariable('tr2', $tr2);
                    $viewModel->setVariable('tr3', $tr3);
                    $viewModel->setVariable('tr4', $tr4);
                    $viewModel->setVariable('varIs', $varIs);
                    $viewModel->setVariable('var5', $var5);
                    $viewModel->setVariable('errors', implode(" // ", $message));
            //$viewModel->setVariable('page', $page);
            $viewModel->setVariable('filename', "tabla_alae_de_cada_lote_analitico" . date("YmdHi"));
            return $viewModel;
                }
                else
                {
                    return $this->redirect()->toRoute('report', array(
                                'controller' => 'report',
                                'action'     => 'index',
                                'id'         => 1
                    ));
                }
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                            'controller' => 'report',
                            'action'     => 'index',
                            'id'         => 1
                ));
            }
        }

        /*$viewModel = new ViewModel();
        $viewModel->setTerminal(true);
        $viewModel->setVariable('page', $page);
        $viewModel->setVariable('filename', "tabla_alae_de_cada_lote_analitico" . date("Ymd-Hi"));
        return $viewModel;*/
    }

    //AND ((p.pkParameter BETWEEN 1 AND 8) OR (p.pkParameter BETWEEN 23 AND 29))
    /**
     * Resumen de lotes de un estudio
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r3Action()
    {
        //REPORTE 3 PDF
        $request = $this->getRequest();
        if ($request->isGet())
        {
            $query    = $this->getEntityManager()->createQuery("
                SELECT b
                FROM Alae\Entity\Batch b
                WHERE b.fkAnalyte = " . $request->getQuery('an') . " AND b.fkStudy = " . $request->getQuery('id') . "
                AND b.validationDate IS NOT NULL
                ORDER BY b.fileName ASC");
            $elements = $query->getResult();

            $Analyte = $this->getRepository("\\Alae\\Entity\\Analyte")->find($request->getQuery('an'));
            $Study   = $this->getRepository("\\Alae\\Entity\\Study")->find($request->getQuery('id'));

            if (count($elements) > 0)
            {
                $properties = array();

                //OBTIENE LOS DATOS DEL REPORTE
                foreach ($elements as $Batch)
                {
                    $query    = $this->getEntityManager()->createQuery("
                        SELECT DISTINCT(p.pkParameter) as pkParameter, p.messageError
                        FROM Alae\Entity\Error e, Alae\Entity\SampleBatch s, Alae\Entity\Parameter p
                        WHERE s.pkSampleBatch = e.fkSampleBatch
                            AND e.fkParameter = p.pkParameter
							AND (p.status = 1) 
                            AND s.fkBatch = " . $Batch->getPkBatch());
						
					//Toni: En el Select ANTERIOR la fila AND (p.status = 1)  determina que ese parametro 
					//NO DEBE DAR EL LOTE COMO RECHAZADO. Esto lo hace ya en verificationControler, 
					//pero también lo quito aquí para que no salga en el Report 2.
					// He hecho lo mismo en el REPORT 2							
					
                    $elements = $query->getResult();

                    $message = array();
                    if (!is_null($Batch->getFkParameter()))
                    {
                        $message[$Batch->getFkParameter()->getPkParameter()] = $Batch->getFkParameter()->getMessageError();
                    }
                    foreach ($elements as $data)
                    {
                        $message[$data['pkParameter']] = $data['messageError'];
                    }

                    ksort($message);
                    $properties[] = array(
                        "filename" => $Batch->getFileName(),
                        "error"    => implode("<br>", $message),
                        "message"  => is_null($Batch->getValidFlag()) ? "Falta validar" : ($Batch->getValidFlag() ? "Aceptado" : "Rechazado"),
                        "veredicto"=> $Batch->getJustification()
                    );
                }

                $viewModel = new ViewModel();
                $viewModel->setTerminal(true);
                $viewModel->setVariable('list', $properties);
                $viewModel->setVariable('analyte', $Analyte->getName());
                $viewModel->setVariable('study', $Study->getCode());
                $viewModel->setVariable('filename', "resumen_de_lotes_de_un_estudio" . date("Ymd-Hi"));
                return $viewModel;
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                            'controller' => 'report',
                            'action'     => 'index',
                            'id'         => 1
                ));
            }
        }
    }

   /**
     * Listado de muestras a repetir
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r4Action()
    {
        //REPORTE 4 PDF
        $request = $this->getRequest();
        if ($request->isGet())
        {
            $batch   = $this->getRepository("\\Alae\\Entity\\Batch")->findBy(array(
                "fkAnalyte" => $request->getQuery('an'),
                "fkStudy"   => $request->getQuery('id'),
                "validFlag" => true
            ), array("fileName" => 'asc'));
            $Analyte = $this->getRepository("\\Alae\\Entity\\Analyte")->find($request->getQuery('an'));
            $Study   = $this->getRepository("\\Alae\\Entity\\Study")->find($request->getQuery('id'));
			$AnalyteName = $Analyte->getName();
            $studyName = $Study->getCode();

            if (count($batch) > 0)
            {
                ini_set('max_execution_time', 9000);
                $message = array();

                foreach ($batch as $Batch)
                {
                    $em   = $this->getEntityManager();
                    $db   = $em->getConnection();
                    //LLAMAR AL STORED PROCEDURE PROC_ALAE_SAMPLE_ERRORS
                    $stmt = $db->prepare('call proc_alae_sample_errors(:pk_batch)');
                    $stmt->bindValue('pk_batch', $Batch->getPkBatch());

                    $stmt->execute();

                    while ($row = $stmt->fetch())
                    {
                        $message[] = array(
                            "sampleName"   => $row['sample_name'],
                            "codeError"    => str_replace(",", "<br>", $row['code_error']),
                            "messageError" => str_replace(",", "<br>", $row['message_error']),
                            "filename"     => $Batch->getFileName()
                        );
                    }
                }


                $viewModel = new ViewModel();
                $viewModel->setTerminal(true);
                $viewModel->setVariable('list', $message);
                $viewModel->setVariable('analyte', $AnalyteName);
                $viewModel->setVariable('study', $studyName);

                $viewModel->setVariable('filename', "listado_de_muestras_a_repetir" . date("Ymd-Hi"));

                return $viewModel;
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                            'controller' => 'report',
                            'action'     => 'index',
                            'id'         => 1
                ));
            }
        }
    }

   /**
     * Summary of calibration curve parameter
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r5Action()
    {
        //REPORTE 5 EXCEL
        $request = $this->getRequest();
        if ($request->isGet())
        {
            //OBTIENE LOS DATOS DEL REPORTE
            $query = $this->getEntityManager()->createQuery("
                SELECT b
                FROM Alae\Entity\Batch b
                WHERE b.validFlag = 1 AND b.fkAnalyte = " . $request->getQuery('an') . " AND b.fkStudy = " . $request->getQuery('id') . "
                ORDER BY b.fileName ASC");
            $batch = $query->getResult();

            if (count($batch) > 0)
            {
                $viewModel = new ViewModel(array(
                    "batch"    => $batch,
                    "filename" => "summary_of_calibration_curve_parameters" . date("Ymd-Hi")
                ));
                $viewModel->setTerminal(true);
                return $viewModel;
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                            'controller' => 'report',
                            'action'     => 'index',
                            'id'         => 1
                ));
            }
        }
    }

   /**
     * Calculo de las concentraciones de los CS (calculatedConcentration)
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r6Action()
    {
        //REPORTE 6 EXCEL
        $request = $this->getRequest();

        if ($request->isGet())
        {
            //OBTIENE LOS DATOS DEL REPORTE
            $analytes = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->findBy(array("fkAnalyte" => $request->getQuery('an'), "fkStudy" => $request->getQuery('id')));
            $qb = $this->getEntityManager()->createQueryBuilder();
            $qb
                ->select('s', 'GROUP_CONCAT(DISTINCT p.codeError) as codeError')
                ->from('Alae\Entity\SampleBatch', 's')
                ->leftJoin('Alae\Entity\Error', 'e', \Doctrine\ORM\Query\Expr\Join::WITH, 's.pkSampleBatch = e.fkSampleBatch')
                ->leftJoin('Alae\Entity\Parameter', 'p', \Doctrine\ORM\Query\Expr\Join::WITH, 'e.fkParameter = p.pkParameter')
                ->innerJoin('Alae\Entity\Batch', 'b', \Doctrine\ORM\Query\Expr\Join::WITH, 's.fkBatch = b.pkBatch')
                ->where("s.sampleName LIKE 'CS%' AND b.validFlag = 1 AND b.fkAnalyte = " . $request->getQuery('an') . " AND b.fkStudy = " . $request->getQuery('id'))
                ->groupBy('b.pkBatch, s.pkSampleBatch')
                ->orderBy('b.fileName, s.sampleName', 'ASC');
            $elements = $qb->getQuery()->getResult();

            $concentration = $properties = array();
            
            foreach ($elements as $element)
            {
                $properties[$element[0]->getFkBatch()->getFileName()][] = array(
                    "sampleName"              => $element[0]->getSampleName(),
                    "calculatedConcentration" => number_format((float)$element[0]->getCalculatedConcentration(), 2, '.', ''),
                    "error"                   => $element['codeError']
                );

                if($element['codeError'] == '')
                {
                    //VERIFICAR QUE NO VAYAN AL RESUMEN DEL PIE LOS INYECTADOS
                    $cadena = $element[0]->getSampleName(); 
                    $cadena1 = substr($cadena,-2);
                    
                    $digito1 = $cadena1[0];
                    $digito2 = $cadena1[1];

                    if($digito1 == "R" && ($digito2 == '*' || ctype_digit($digito2)))
                    {
                        $centi = "N";
                    }
                    else
                    {
                        $centi = "S";
                    }
                    
                    IF($centi == "S")
                    {
                        $concentration[preg_replace('/-\d+/i', '', $element[0]->getSampleName())][] = number_format((float)$element[0]->getCalculatedConcentration(), 2, '.', '');
                    }
                    
                }    
            }
            
            $response = array(
                "analyte"      => $analytes[0],
                "cs_values"    => explode(",", $analytes[0]->getCsValues()),
                "elements"     => $properties,
                "values"       => $concentration,
                "filename"     => "back_calculated_concentration_of_calibration_standard" . date("Ymd-Hi")
            );

            $viewModel = new ViewModel($response);
            $viewModel->setTerminal(true);
            return $viewModel;
        }
        else
        {
            return $this->redirect()->toRoute('report', array(
                'controller' => 'report',
                'action'     => 'index',
                'id'         => 1
            ));
        }
    }

   /**
     * Calculo de las concentraciones de los CS (accuracy)
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r7Action()
    {
        //REPORTE 7 EXCEL
        $request = $this->getRequest();
        if ($request->isGet())
        {
            
            $analytes = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->findBy(array("fkAnalyte" => $request->getQuery('an'), "fkStudy" => $request->getQuery('id')));
            $query    = $this->getEntityManager()->createQuery("
                SELECT b
                FROM Alae\Entity\Batch b
                WHERE b.validFlag = 1 AND b.fkAnalyte = " . $request->getQuery('an') . " AND b.fkStudy = " . $request->getQuery('id') . "
                ORDER BY b.fileName ASC");
            $batch    = $query->getResult();

            if (count($batch) > 0)
            {
                $list    = array();
                $pkBatch = array();
                foreach ($batch as $Batch)
                {
                    //OBTIENE LOS DATOS DEL REPORTE
                    $qb       = $this->getEntityManager()->createQueryBuilder();
                    $qb
                            ->select('s.accuracy', 'SUBSTRING(s.sampleName, 1, 3) as sampleName', 'GROUP_CONCAT(DISTINCT p.codeError) as codeError')
                            ->from('Alae\Entity\SampleBatch', 's')
                            ->leftJoin('Alae\Entity\Error', 'e', \Doctrine\ORM\Query\Expr\Join::WITH, 's.pkSampleBatch = e.fkSampleBatch')
                            ->leftJoin('Alae\Entity\Parameter', 'p', \Doctrine\ORM\Query\Expr\Join::WITH, 'e.fkParameter = p.pkParameter')
                            ->where("s.sampleName LIKE 'CS%' AND s.fkBatch = " . $Batch->getPkBatch())
                            ->groupBy('s.pkSampleBatch')
                            ->orderBy('s.sampleName', 'ASC');
                    $elements = $qb->getQuery()->getResult();

                    $Concentration           = array();
                    $calculatedConcentration = array();
                    if (count($elements) > 0)
                    {
                        $counter = 0;
                        foreach ($elements as $temp)
                        {
                            $value                                                          = number_format($temp["accuracy"], 2, '.', '');
                            $calculatedConcentration[$counter % 2 == 0 ? 'par' : 'impar'][] = array($value, $temp["codeError"]);
                            $Concentration[$temp["sampleName"]][]                           = $value;
                            $counter++;
                        }
                    }
                    list($name, $aux) = explode("_", $Batch->getFileName());
                    $calculatedConcentration['name'] = $name;

                    $list[] = $calculatedConcentration;

                    $pkBatch[] = $Batch->getPkBatch();
                }

                $query    = $this->getEntityManager()->createQuery("
                    SELECT SUM(IF(s.validFlag=1, 1, 0)) as counter, AVG(s.accuracy) as promedio, SUBSTRING(s.sampleName, 1, 3) as sampleName
                    FROM Alae\Entity\SampleBatch s
                    WHERE s.sampleName LIKE 'CS%' AND s.validFlag = 1 AND s.fkBatch in (" . implode(",", $pkBatch) . ")
                    GROUP BY sampleName
                    ORDER By s.sampleName");
                $elements = $query->getResult();

                $calculations = array();
                foreach ($elements as $element)
                {
                    $calculations[] = array(
                        "count" => $element['counter'],
                        "prom"  => number_format($element['promedio'], 2, '.', '')
                    );
                }
                $properties = array(
                    "analyte"      => $analytes[0],
                    "cs_values"    => explode(",", $analytes[0]->getCsValues()),
                    "list"         => $list,
                    "calculations" => $calculations,
                    "filename"     => "percent_calculated_nominal_concentration_of_calibration_standards" . date("Ymd-Hi")
                );

                $viewModel = new ViewModel($properties);
                $viewModel->setTerminal(true);
                return $viewModel;
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                            'controller' => 'report',
                            'action'     => 'index',
                            'id'         => 1
                ));
            }
        }
    }

   /**
     * Calculo de las concentraciones de los QC
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r8Action()
    {
        //REPORTE 8 EXCEL
        $request = $this->getRequest();

        if ($request->isGet())
        {
            //OBTIENE LOS DATOS DEL REPORTE
            $analytes = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->findBy(array("fkAnalyte" => $request->getQuery('an'), "fkStudy" => $request->getQuery('id')));
            $qb = $this->getEntityManager()->createQueryBuilder();
            $qb
                ->select('s', 'GROUP_CONCAT(DISTINCT p.codeError) as codeError')
                ->from('Alae\Entity\SampleBatch', 's')
                ->leftJoin('Alae\Entity\Error', 'e', \Doctrine\ORM\Query\Expr\Join::WITH, 's.pkSampleBatch = e.fkSampleBatch')
                ->leftJoin('Alae\Entity\Parameter', 'p', \Doctrine\ORM\Query\Expr\Join::WITH, 'e.fkParameter = p.pkParameter')
                ->innerJoin('Alae\Entity\Batch', 'b', \Doctrine\ORM\Query\Expr\Join::WITH, 's.fkBatch = b.pkBatch')
                ->where("s.sampleName LIKE 'QC%' AND s.sampleName NOT LIKE '%*%' AND b.validFlag = 1 AND b.fkAnalyte = " . $request->getQuery('an') . " AND b.fkStudy = " . $request->getQuery('id'))
                ->groupBy('b.pkBatch, s.pkSampleBatch')
                ->orderBy('b.fileName, s.sampleName', 'ASC');
            $elements = $qb->getQuery()->getResult();

            $concentration = $accuracy = $properties = array();
            foreach ($elements as $element)
            {
                $error = number_format((float)$element[0]->getCalculatedConcentration(), 2, '.', '');
                $properties[$element[0]->getFkBatch()->getFileName()][] = array(
                    "sampleName"              => $element[0]->getSampleName(),
                    "calculatedConcentration" => number_format((float)$element[0]->getCalculatedConcentration(), 2, '.', ''),
                    "accuracy"                => number_format((float)$element[0]->getAccuracy(), 2, '.', ''),
                    "error"                   => $element['codeError']
                );

                if($element['codeError'] == '' || $element['codeError'] == 'O')
                {
                    //VERIFICAR QUE NO VAYAN AL RESUMEN DEL PIE LOS INYECTADOS
                    $cadena = $element[0]->getSampleName(); 
                    $cadena1 = substr($cadena,-2);
                    
                    $digito1 = $cadena1[0];
                    $digito2 = $cadena1[1];

                    if($digito1 == "R" && ($digito2 == '*' || ctype_digit($digito2)))
                    {
                        $centi = "N";
                    }
                    else
                    {
                        $centi = "S";
                    }
                    
                    IF($centi == "S")
                    {
                        $concentration[preg_replace('/-\d+/i', '', $element[0]->getSampleName())][] = $error;
                    }
                }
                $accuracy[preg_replace('/-\d+/i', '', $element[0]->getSampleName())][] = number_format((float)$element[0]->getAccuracy(), 2, '.', '');
            }
            
            $response = array(
                "analyte"      => $analytes[0],
                "qc_values"    => explode(",", $analytes[0]->getQcValues()),
                "elements"     => $properties,
                "valuesCon"    => $concentration,
                "valuesAcc"    => $accuracy,
                "filename"     => "between_run_accuracy_and_precision_of_quality_control_samples" . date("Ymd-Hi")
            );

            $viewModel = new ViewModel($response);
            $viewModel->setTerminal(true);
            return $viewModel;
        }
        else
        {
            return $this->redirect()->toRoute('report', array(
                'controller' => 'report',
                'action'     => 'index',
                'id'         => 1
            ));
        }
    }

   /**
     * Calculo de las concentraciones de los (L|H)DQC
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r9Action()
    {
        //REPORTE 9 EXCEL
        $request = $this->getRequest();

        if ($request->isGet())
        {
            //OBTIENE LOS DATOS DEL REPORTE
            $analytes = $this->getRepository('\\Alae\\Entity\\AnalyteStudy')->findBy(array("fkAnalyte" => $request->getQuery('an'), "fkStudy" => $request->getQuery('id')));
            $query    = $this->getEntityManager()->createQuery("
                SELECT s.sampleName, GROUP_CONCAT(DISTINCT s.pkSampleBatch) as values
                FROM Alae\Entity\Batch b, Alae\Entity\SampleBatch s
                WHERE  b.validFlag = 1 AND b.fkAnalyte = " . $request->getQuery('an') . " AND b.fkStudy = " . $request->getQuery('id') . "
                    AND s.fkBatch = b.pkBatch AND s.sampleName LIKE '%DQC%'
                GROUP BY s.sampleName
                ORDER BY s.sampleName ASC");
            $elements = $query->getResult();

            $factor = array();
            foreach($elements as $element)
            {
                $factor[preg_replace('/-\d+/i', '', $element['sampleName'])] = 1;
            }

            $page = "";
            if (count($factor) > 0)
            {
                foreach($factor as $key => $value)
                {
                    $qb = $this->getEntityManager()->createQueryBuilder();
                    $qb
                        ->select('s', 'GROUP_CONCAT(DISTINCT p.codeError) as codeError')
                        ->from('Alae\Entity\SampleBatch', 's')
                        ->leftJoin('Alae\Entity\Error', 'e', \Doctrine\ORM\Query\Expr\Join::WITH, 's.pkSampleBatch = e.fkSampleBatch')
                        ->leftJoin('Alae\Entity\Parameter', 'p', \Doctrine\ORM\Query\Expr\Join::WITH, 'e.fkParameter = p.pkParameter')
                        ->innerJoin('Alae\Entity\Batch', 'b', \Doctrine\ORM\Query\Expr\Join::WITH, 's.fkBatch = b.pkBatch')
                        ->where("s.sampleName LIKE '$key%' AND b.validFlag = 1 AND b.fkAnalyte = " . $request->getQuery('an') . " AND b.fkStudy = " . $request->getQuery('id'))
                        ->groupBy('b.pkBatch, s.pkSampleBatch')
                        ->orderBy('b.fileName, s.sampleName', 'ASC');
                    $elements = $qb->getQuery()->getResult();

                    $concentration = $accuracy = $properties = array();
                    foreach ($elements as $element)
                    {
                        $error = ($element['codeError'] == '' || $element['codeError'] == 'O') ? number_format((float)$element[0]->getCalculatedConcentration(), 2, '.', '') : "NVR";
                        $properties[$element[0]->getFkBatch()->getFileName()][] = array(
                            "sampleName"              => $element[0]->getSampleName(),
                            "calculatedConcentration" => $error,
                            "dilutionFactor"          => number_format((float)$element[0]->getDilutionFactor(), 2, '.', ''),
                            "accuracy"                => number_format((float)$element[0]->getAccuracy(), 2, '.', ''),
                            "error"                   => $element['codeError']
                        );

                        $concentration[] = $error;
                        $accuracy[]      = number_format((float)$element[0]->getAccuracy(), 2, '.', '');
                    }
                    //var_dump($properties);
                    $page .= $this->render('alae/report/r9page', array(
                        "name"          => $key,
                        "properties"    => $properties,
                        "concentration" => $concentration,
                        "accuracy"      => $accuracy
                    ));
                }
//die();
                $properties = array(
                    "analyte"      => $analytes[0],
                    "filename"     => "Between_Run_Accuracy_and_Precision_of_dilution_Quality_Control_Samples" . date("Ymd-Hi"),
                    "page"         => $page
                );

                $viewModel = new ViewModel($properties);
                $viewModel->setTerminal(true);
                return $viewModel;
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                    'controller' => 'report',
                    'action'     => 'index',
                    'id'         => 1
                ));
            }
        }
    }

    /**
     * Summary of calibration curve parameter
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r10Action()
    {
        //REPORTE 4 EXCEL r10
        $request = $this->getRequest();
        if ($request->isGet())
        {
            $batch   = $this->getRepository("\\Alae\\Entity\\Batch")->findBy(array(
                "fkAnalyte" => $request->getQuery('an'),
                "fkStudy"   => $request->getQuery('id'),
                "validFlag" => true
            ), array("fileName" => 'asc'));
            $Analyte = $this->getRepository("\\Alae\\Entity\\Analyte")->find($request->getQuery('an'));
            $Study   = $this->getRepository("\\Alae\\Entity\\Study")->find($request->getQuery('id'));
            $AnalyteName = $Analyte->getName();
            $studyName = $Study->getCode();

            if (count($batch) > 0)
            {
                ini_set('max_execution_time', 9000);
                $message = array();

                foreach ($batch as $Batch)
                {
                    $em   = $this->getEntityManager();
                    $db   = $em->getConnection();
                    //LLAMAR AL STORED PROCEDURE PROC_ALAE_SAMPLE_ERRORS
                    $stmt = $db->prepare('call proc_alae_sample_errors(:pk_batch)');
                    $stmt->bindValue('pk_batch', $Batch->getPkBatch());

                    $stmt->execute();

                    while ($row = $stmt->fetch())
                    {
                        $message[] = array(
                            "sampleName"   => $row['sample_name'],
                            "codeError"    => str_replace(",", "<br>", $row['code_error']),
                            "messageError" => str_replace(",", "<br>", $row['message_error']),
                            "filename"     => $Batch->getFileName()
                        );
                    }
                }
                

                $viewModel = new ViewModel();
                $viewModel->setTerminal(true);
                $viewModel->setVariable('list', $message);
                $viewModel->setVariable('analyte', $AnalyteName);
                $viewModel->setVariable('study', $studyName);

                $viewModel->setVariable('filename', "listado_de_muestras_a_repetir" . date("Ymd-Hi"));

                return $viewModel;
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                            'controller' => 'report',
                            'action'     => 'index',
                            'id'         => 1
                ));
            }
        }
    }

    /**
     * Listado Record Modified
     * $_GET['id'] = pkStudy
     * $_GET['an'] = pkAnalyte
     */
    public function r11Action()
    {
        //echo 'r11';die();
        $request = $this->getRequest();
        if ($request->isGet())
        {
            $batch   = $this->getRepository("\\Alae\\Entity\\Batch")->findBy(array(
                "fkAnalyte" => $request->getQuery('an'),
                "fkStudy"   => $request->getQuery('id'),
                "validFlag" => true
            ), array("fileName" => 'asc'));
            $Analyte = $this->getRepository("\\Alae\\Entity\\Analyte")->find($request->getQuery('an'));
            $Study   = $this->getRepository("\\Alae\\Entity\\Study")->find($request->getQuery('id'));
            $AnalyteName = $Analyte->getName();
            $studyName = $Study->getCode();

            $countTot1 = 0;
            $recordModifiedTot1 = 0;

            if (count($batch) > 0)
            {
                ini_set('max_execution_time', 9000);
                $message = array();

                foreach ($batch as $Batch)
                {
                    //número total de muestras
                    //WHERE NOT (s.sampleName LIKE  '%R%' AND s.sampleName NOT LIKE  '%\*%') AND  s.fkBatch = " . $Batch->getPkBatch() . "
                    $query    = $this->getEntityManager()->createQuery("
                        SELECT COUNT(s.pkSampleBatch) as count1
                        FROM Alae\Entity\SampleBatch s
                        WHERE s.fkBatch = " . $Batch->getPkBatch() . "
                        ORDER By s.sampleName");
                    $elements1 = $query->getResult();

                    $count1 = $elements1[0]['count1'];
                    //echo $count1;
                    //número de muestras con “Record Modified = 1”
                    $query    = $this->getEntityManager()->createQuery("
                        SELECT COUNT(s.recordModified) as recordModified
                        FROM Alae\Entity\SampleBatch s
                        WHERE s.fkBatch = " . $Batch->getPkBatch() ." AND
                        s.recordModified = 1
                        ORDER By s.sampleName");
                    $elements2 = $query->getResult();

                    $recordModified =  $elements2[0]['recordModified'];
                    //echo '-' . $recordModified; die();
                    $query    = $this->getEntityManager()->createQuery("
                        SELECT s.sampleName, s.analyteIntegrationType, s.isIntegrationType
                        FROM Alae\Entity\SampleBatch s
                        WHERE s.fkBatch = " . $Batch->getPkBatch() ." AND
                        s.recordModified = 1
                        ORDER By s.sampleName");
                    $results = $query->getResult();

                    $countTot1 = $countTot1 + $count1;
                    $recordModifiedTot1 = $recordModifiedTot1 + $recordModified;

                    foreach ($results as $row1) 
                    {
                        $message[] = array(
                            "sampleName"   => $row1['sampleName'],
                            "analyteIntegrationType"    => $row1['analyteIntegrationType'],
                            "isIntegrationType" => $row1['isIntegrationType'],
                            "filename"     => $Batch->getFileName()
                        );
                    }
                }

                //% de muestras modificadas sobre el número total de muestras
                $percent =  ($recordModifiedTot1 / $countTot1) * 100 ;

                $viewModel = new ViewModel();
                $viewModel->setTerminal(true);
                $viewModel->setVariable('list', $message);
                $viewModel->setVariable('analyte', $AnalyteName);
                $viewModel->setVariable('study', $studyName);
                $viewModel->setVariable('countTot1', $countTot1);
                $viewModel->setVariable('recordModified', $recordModifiedTot1);
                //$viewModel->setVariable('percent', $percent);

                $viewModel->setVariable('filename', "listado_de_muestras_con_integracion_modificada" . date("Ymd-Hi"));

                return $viewModel;
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                            'controller' => 'report',
                            'action'     => 'index',
                            'id'         => 1
                ));
            }
        }
    }

    public function rtxtAction()
    {
        
        $request = $this->getRequest();
        $page    = "";
        $user = $this->_getSession()->getPkUser();
        if ($request->isGet())
        {
            //GENERA LOS DATOS DEL REPORTE
            ini_set('max_execution_time', 300000);
            $Batch = $this->getRepository('\\Alae\\Entity\\Batch')->find($request->getQuery('ba'));
            if ($Batch && $Batch->getPkBatch())
            {
                $qb       = $this->getEntityManager()->createQueryBuilder();
                $qb
                        ->select('s.sampleName, s.analytePeakName, s.sampleType, s.fileName, s.analytePeakArea, s.isPeakArea, s.areaRatio, s.analyteConcentration, s.calculatedConcentration, s.dilutionFactor, s.accuracy, s.useRecord,
                     s.acquisitionDate, s.analyteRetentionTime, s.isRetentionTime, s.analyteIntegrationType, s.isIntegrationType, s.recordModified,
                    GROUP_CONCAT(DISTINCT p.codeError) as codeError,
                    GROUP_CONCAT(DISTINCT p.messageError) as messageError')
                        ->from('Alae\Entity\SampleBatch', 's')
                        ->leftJoin('Alae\Entity\Error', 'e', \Doctrine\ORM\Query\Expr\Join::WITH, 's.pkSampleBatch = e.fkSampleBatch')
                        ->leftJoin('Alae\Entity\Parameter', 'p', \Doctrine\ORM\Query\Expr\Join::WITH, 'e.fkParameter = p.pkParameter')
                        ->where("s.fkBatch = " . $Batch->getPkBatch())
                        ->groupBy('s.pkSampleBatch')
                        ->orderBy('s.pkSampleBatch', 'ASC');
                $elements = $qb->getQuery()->getResult();

                if (count($elements) > 0)
                {
                    $tr1 = $tr2 = "";

                    foreach ($elements as $sampleBatch)
                    {
                        $row1     = $row2     = "";
                        $isTable2 = false;

                        foreach ($sampleBatch as $key => $value)
                        {
                            switch ($key)
                            {
                                case "sampleName":
                                    $row1 .= $value."\t";
                                    break;
                                case "sampleId":
                                    $row1 .= $value."\t";
                                    break;
                                case "sampleType":
                                    $row1 .= $value."\t";
                                    break;
                                case "fileName":
                                    $row1 .= $value."\t";
                                    break;
                                case "analytePeakName":
                                    $row1 .= $value."\t";
                                    break;
                                case "analytePeakArea":
                                case "isPeakArea":
                                case "areaRatio":
                                    $row1 .= $value."\t";
                                    break;
                                case "analyteConcentration":
                                    $value = number_format($value, 2, '.', '');
                                    $row1 .= $value."\t";
                                    break;
                                case "calculatedConcentration":
                                    $value = number_format($value, 2, '.', '');
                                    $row1 .= $value."\t";
                                    break;
                                case "dilutionFactor":
                                case "accuracy":
                                    $value = number_format($value, 2, '.', '');
                                    $row1 .= $value."\t";
                                    break;
                                case "useRecord":
                                    $row1 .= $value."\t";
                                    break;
                                case "recordModified":
                                    $row1 .= $value."\t";
                                    break;
                                case "acquisitionDate":
                                    $value = $value->format('d.m.Y H:i:s');
                                    $row1 .= $value."\t";
                                    break;
                                case "analyteIntegrationType":
                                case "isIntegrationType":
                                    $row1 .= $value."\t";
                                    break;
                                case "codeError":
                                    $row1 .= $value."\t";
                                    break;
                                case "messageError":
                                    $value = str_replace(",", " // ", $value);
                                    $row1 .= htmlentities($value)."\t";
                                    break;
                                default:
                                    $row1 .= $value."\t";
                                    break;
                            }
                        }
                        
                        $tr1 .= $row1."\r\n";
                        $tr2 .= sprintf("<tr>%s</tr>", $row2);

                    }

                    //AND ((p.pkParameter BETWEEN 1 AND 8) OR (p.pkParameter BETWEEN 23 AND 29))
                    //GENERA LOS ERRORES
                    $query  = $this->getEntityManager()->createQuery("
                        SELECT DISTINCT(p.pkParameter) as pkParameter, p.messageError
                        FROM Alae\Entity\Error e, Alae\Entity\SampleBatch s, Alae\Entity\Parameter p
                        WHERE s.pkSampleBatch = e.fkSampleBatch
                            AND e.fkParameter = p.pkParameter
                            AND s.fkBatch = " . $Batch->getPkBatch() . "
                        ORDER BY p.pkParameter");
                    $errors = $query->getResult();

                    $message = array();
                    if (!is_null($Batch->getFkParameter()))
                    {
                        $message[$Batch->getFkParameter()->getPkParameter()] = $Batch->getFkParameter()->getMessageError();
                    }
                    foreach ($errors as $data)
                    {
                        $message[$data['pkParameter']] = $data['messageError'];
                    }
                    ksort($message);
                    
                    $response = array(
                        "user"  => $user,
                        "batch"  => $Batch,
                        "tr1"    => $tr1,
                        "tr2"    => $tr2,
                        "errors" => implode(" // ", $message),
                        "filename"     => "tabla_alae_de_cada_lote_analitico" . date("Ymd-Hi")
                    );
                    $viewModel = new ViewModel($response);
                    $viewModel->setTerminal(true);
                    //$viewModel->setVariable('filename', "tabla_alae_de_cada_lote_analitico" . date("Ymd-Hi").".txt");
                    return $viewModel;
                }
                else
                {
                    return $this->redirect()->toRoute('report', array(
                                'controller' => 'report',
                                'action'     => 'index',
                                'id'         => 1
                    ));
                }
            }
            else
            {
                return $this->redirect()->toRoute('report', array(
                            'controller' => 'report',
                            'action'     => 'index',
                            'id'         => 1
                ));
            }
        }
    }

    public function graphicsAction()
    {

    }


}
