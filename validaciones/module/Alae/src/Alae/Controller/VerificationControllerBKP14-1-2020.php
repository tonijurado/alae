<?php

/**
 * Modulo encargado de realizar las verificaciones a cada lote
 * Verificaciones de 4 - 24
 *
 * @author Maria Quiroz
 * Fecha de creación: 18/05/2014
 */

namespace Alae\Controller;

use Zend\View\Model\ViewModel,
    Alae\Controller\BaseController,
    Zend\View\Model\JsonModel,
    Alae\Service\Verification;

class VerificationController extends BaseController
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

    /*
     * Función para redirigir a la verificación del batch
     */
    public function indexAction()
    {
        if ($this->getEvent()->getRouteMatch()->getParam('id'))
        {
            $Batch = $this->getRepository()->find($this->getEvent()->getRouteMatch()->getParam('id'));
            
            for ($i = 5; $i < 12; $i++)
            {
                $function = 'V' . $i;
                $this->$function($Batch);
            }
            
            $response = $this->V12($Batch);
            if ($response)
            {
                //$this->V13($Batch);
                $this->V13_23($Batch);
            }
            else
            {
                return $this->redirect()->toRoute('verification', array(
                    'controller' => 'verification',
                    'action'     => 'error',
                    'id'         => $Batch->getPkBatch()
                ));
            }
        }
    }

    /*
     * Función para verificar los parametros del sistema
     */
    public function errorAction()
    {

        $request = $this->getRequest();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.1"));
        $min1 = $parameters[0]->getMinValue();
        $max1 = $parameters[0]->getMaxValue();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.2"));
        $min2 = $parameters[0]->getMinValue();
        $max2 = $parameters[0]->getMaxValue();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.3"));
        $min3 = $parameters[0]->getMinValue();
        $max3 = $parameters[0]->getMaxValue();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.4"));
        $min4 = $parameters[0]->getMinValue();
        $max4 = $parameters[0]->getMaxValue();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.5"));
        $min5 = $parameters[0]->getMinValue();
        $max5 = $parameters[0]->getMaxValue();

        if ($this->getEvent()->getRouteMatch()->getParam('id'))
        {
            $Batch = $this->getRepository()->find($this->getEvent()->getRouteMatch()->getParam('id'));
        }

        $query   = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch, s.fileName, s.sampleName, s.accuracy, s.useRecord
            FROM Alae\Entity\SampleBatch s
            WHERE s.fkBatch = " . $Batch->getPkBatch() . "
                AND (
                    ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy NOT BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                    OR (s.sampleName LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy NOT BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 1)
                    OR ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                    OR (s.sampleName LIKE 'TZ%' AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 0)
                    
                )");
        $query->setParameter('regexp1', '^CS[0-9]+(-[0-9]+)?$');
        $query->setParameter('regexp2', '^QC[0-9]+(-[0-9]+)?$');
        $query->setParameter('regexp3', '^((L|H)?DQC)[0-9]+(-[0-9]+)?$');

        $data     = array();
        $elements = $query->getResult();

        if ($request->isPost())
        {
            /*$reasons = $request->getPost('reason');
            if (!empty($reasons))
            {
                foreach ($reasons as $keyR => $valueR)
                {*/
                    $Batch = $this->getRepository()->find($request->getPost('id'));
                    /*$parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => $valueR));
                    if ($valueR == "V12.8")
                    {
                        $this->evaluation($Batch, false, $parameters[0]);
                    }*/
                    $Batch = $this->getRepository()->find($request->getPost('id'));

                    //TRATAMIENTO DE FILA DE LA PANTALLA EMERGENTE
                    foreach ($elements as $sampleBatchReason)
                    {
                        $pkSampleBatch = $sampleBatchReason['pkSampleBatch'];
                        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => $request->getPost('reason_'.$pkSampleBatch)));
                        if ($request->getPost('reason_'.$pkSampleBatch) == "V12.8")
                        {
                            $this->evaluation($Batch, false, $parameters[0]);
                        }
                    
                        $where = "s.fkBatch = " . $Batch->getPkBatch() . "
                        AND s.pkSampleBatch = " . $pkSampleBatch . "
                        AND (
                                ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy NOT BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 1)
                                OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                                OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                                OR (s.sampleName LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)
                                OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy NOT BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 1)
                                OR ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                                OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                                OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                                OR (s.sampleName LIKE 'TZ%' AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
                                OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 0)
                            )";

                        $this->error($where, $parameters[0], array('regexp1' => '^CS[0-9]+(-[0-9]+)?$','regexp2' => '^QC[0-9]+(-[0-9]+)?$','regexp3' => '^((L|H)?DQC)[0-9]+(-[0-9]+)?$'), false);
                        $this->V13_23($Batch);
                    }
                //}
            //}
        }

        foreach ($elements as $sampleBatch)
        {
            $data[] = array(
                "filename"    => preg_replace('/\\\\[0-9]+\.wiff/', '', $sampleBatch['fileName']),
                "sample_name" => $sampleBatch['sampleName'],
                "accuracy"    => $sampleBatch['accuracy'],
                "use_record"  => $sampleBatch['useRecord'],
                "reason"      => $this->getReason($sampleBatch['pkSampleBatch'])
            );
        }

       
        $datatable = new \Alae\Service\Datatable($data, \Alae\Service\Datatable::DATATABLE_SAMPLE_BATCH, $this->_getSession()->getFkProfile()->getName());
        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('pkBatch', $Batch->getPkBatch());
        return $viewModel;
       
    }

    /*
     * Función para evaluar el status del lote
     */
    protected function evaluation(\Alae\Entity\Batch $Batch, $status = true, $parameter = false)
    {
        if (is_null($Batch->getFkParameter()))
        {
            if ($parameter)
            {
                $Batch->setFkParameter($parameter);
            }

            if ($status)
            {
                //AND ((e.fkParameter BETWEEN 1 AND 8) OR (e.fkParameter BETWEEN 23 AND 29))
                $query = $this->getEntityManager()->createQuery("
                    SELECT COUNT(e.fkParameter)
                    FROM Alae\Entity\Error e, Alae\Entity\SampleBatch s, Alae\Entity\Parameter p
                    WHERE s.pkSampleBatch = e.fkSampleBatch
                        AND p.status = 1
                        AND s.fkBatch = " . $Batch->getPkBatch() ."
                        AND p.pkParameter = e.fkParameter");
                $errors = $query->getSingleScalarResult();
                $status = $errors > 0 ? false : true;
            }
            
            $Batch->setValidFlag($status);
            $Batch->setValidationDate(new \DateTime('now'));
            $Batch->setFkUser($this->_getSession());
            $this->getEntityManager()->persist($Batch);
            $this->getEntityManager()->flush();

            return $status;
        }

        return $Batch->getValidFlag();
    }

    /*
     * Retornar el listado de Reason
     */
    protected function getReason($id)
    {
        $elements = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("typeParam" => false));
        $options  = "";
        foreach ($elements as $Parameter)
        {
            $options .= sprintf('<option value="%1$s">%2$s</option>', $Parameter->getRule(), $Parameter->getMessageError());
        }
        return '<select name="reason_'.$id.'" style="width:100%;">'.$options.'</select>';
        //return '<select name="reason[]" style="width:100%;">'.$options.'</select>';
    }

    /**
     * Varificaciones desde la 13 hasta la 23
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V13_23(\Alae\Entity\Batch $Batch)
    {
        for ($i = 13; $i <= 23; $i++) //Cambio el segundo $i de 20 a 23 para que llegue hasta el final de las verificaciones.
        {
            $function = 'V' . $i;
            $this->$function($Batch);
        }
        
        $continue = $this->evaluation($Batch);
        
        if ($continue && is_null($Batch->getFkParameter()))
        {
            for ($i = 21; $i <= 23; $i++)
            {
                $function = 'V' . $i;
                $this->$function($Batch);
            }
        }

        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy" => $Batch->getFkStudy()
        ));

        return $this->redirect()->toRoute('batch', array(
            'controller' => 'batch',
            'action'     => 'list',
            'id'         => $AnaStudy[0]->getPkAnalyteStudy()
        ));
    }

    /*
     * Verifica los errores de los lotes
     */
    protected function error($where, $fkParameter, $parameters = array(), $isValid = true)
    {

        $sql = "
            SELECT s
            FROM Alae\Entity\SampleBatch s
            WHERE $where";
        
        $query = $this->getEntityManager()->createQuery($sql);
        if(count($parameters) > 0)
            foreach ($parameters as $key => $value)
                $query->setParameter($key, $value);
        $elements = $query->getResult();

        $pkParameter = array();
        foreach($elements as $sampleBatch)
        {
            $Error = new \Alae\Entity\Error();
            $Error->setFkSampleBatch($sampleBatch);
            $Error->setFkParameter($fkParameter);
            $this->getEntityManager()->persist($Error);
            $this->getEntityManager()->flush();

           
//            if($fkParameter->getStatus())
//            {
                $pkParameter[] = $sampleBatch->getPkSampleBatch();
//            }
        }

		//*******
		//NO DEBERÍA RECHAZAR UN LOTE SI TODOS LOS pkParameter tienen status = 0
		//*******
		//$contadorParameter = count($pkParameter); echo $contadorParameter . "-" . $fkParameter; die();		
        if(!$isValid && count($pkParameter) > 0)
        {
            $sql = "
                UPDATE Alae\Entity\SampleBatch s
                SET s.validFlag = 0
                WHERE s.pkSampleBatch in (" . implode(",", $pkParameter) . ")";
            $query = $this->getEntityManager()->createQuery($sql);
            $query->execute();
        }

        /*
         * DEBE MARCAR COMO MALA validFlag = 0 las muestras que pasan por error.
         * Al pasar muestras que NO anulan lote, no se marcan como erróneas y las verificaciones del número de CS válido o QC válidos
         * o muestras consecutivas erróneas no funcionan bien.
         *
            $sql = "
                UPDATE Alae\Entity\SampleBatch s
                SET s.validFlag = 0
                WHERE $where";
            $query = $this->getEntityManager()->createQuery($sql);
            $query->execute();    


         /* 
          * FIN DE LA PRUEBA DE TONI PARA MARCAR COMO validFlag = 0 las muestras que entrar en error
          */

        
    }

    /**
     * V5: Sample Type - SAMPLE TYPE ERRÓNEO
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V5(\Alae\Entity\Batch $Batch)
    {

        // En el siguiente WHERE, Toni añade las 3 primeras lineas de condiciones según los comentarios de Natalia del mail del 08 de diciembre de 2020
        // donde se especifica que las muestras SEL, SEL-NT y cualquier otra SEL que haya, ZS-BC y ZS-NT deben ser 'Unknown'
         
        $where = "
        (

            (s.sampleName LIKE '%SEL%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%ZS-BC%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%ZS-NT%' AND s.sampleType <> 'Unknown') OR

            (s.sampleName LIKE 'BLK%' AND s.sampleType <> 'Blank') OR
            (s.sampleName LIKE 'CS%' AND s.sampleType <> 'Standard') OR
            (s.sampleName LIKE '%QC%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%LLQC%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%ULQC%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%LDQC%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%HDQC%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%TZ%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%FT%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%ST%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%LT%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%PP%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%SLP%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%PID%' AND s.sampleType <> 'Quality Control') OR
            (s.sampleName LIKE '%LLOQ%' AND s.sampleType <> 'Quality Control') OR
            (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleType <> 'Solvent') OR
            (REGEXP(s.sampleName, :regexp2) = 1 AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%EGC%' AND s.sampleType <> 'Solvent') OR
            (s.sampleName LIKE '%ES%' AND s.sampleType <> 'Solvent') OR
            (s.sampleName LIKE '%SCAx%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%SCBx%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%ULOQ%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%RSQC1%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%RSQC3%' AND s.sampleType <> 'Unknown')
        ) AND s.fkBatch = " . $Batch->getPkBatch();
        $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V5"));
        $this->error(
            $where,
            $fkParameter[0],
            array(
                "regexp1" => "^REC|FM$",
                "regexp2" => "^[0-9]+(-)[0-9]+\.[0-9]+$"
            )
        );
    }

    /**
     * V6: Concentración nominal de CS/QC - CONCENTRACIÓN NOMINAL ERRÓNEA
     * @param \Alae\Entity\Batch $Batch
	 * CambioToni sin importancia (comentario)
     */
    protected function V6(\Alae\Entity\Batch $Batch)
    {
        $elements = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array("fkStudy" => $Batch->getFkStudy(), "fkAnalyte" => $Batch->getFkAnalyte()));

        foreach ($elements as $AnaStudy)
        {
            $cs_values = explode(",", $AnaStudy->getCsValues());
            $qc_values = explode(",", $AnaStudy->getQcValues());

            if (count($cs_values) == $AnaStudy->getCsNumber())
            {
                for ($i = 1; $i <= count($cs_values); $i++)
                {
                    $value = \Alae\Service\Conversion::conversion(
                        $AnaStudy->getFkUnit()->getName(),
                        $Batch->getAnalyteConcentrationUnits(),
                        $cs_values[$i - 1]
					);
					

                    $where = "s.sampleName LIKE 'CS" . $i . "%' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
						/*
						if ($i == 7) 
						{
							echo '1-' . $AnaStudy->getCsNumber() . ' 2-' .	$cs_values. ' 3-' . $value . ' 4-' . $where; die();
						} //**
						*/
                    $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
                    $this->error($where, $fkParameter[0]);
                }
            }

            if (count($qc_values) == $AnaStudy->getQcNumber())
            {
                for ($i = 1; $i <= count($qc_values); $i++)
                {
                    $value = \Alae\Service\Conversion::conversion(
                        $AnaStudy->getFkUnit()->getName(),
                        $Batch->getAnalyteConcentrationUnits(),
                        $qc_values[$i - 1]
                    );

                    $where = "s.sampleName LIKE 'QC" . $i . "%' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
                    $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
                    $this->error($where, $fkParameter[0]);
                }
            }

            $valueLDQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getLdqcValues()
            );

            $where = "s.sampleName LIKE 'LDQC%' AND s.analyteConcentration <> " . $valueLDQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
            $this->error($where, $fkParameter[0]);

            $valueHDQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getHdqcValues()
            );

            $where = "s.sampleName LIKE 'HDQC%' AND s.analyteConcentration <> " . $valueHDQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
            $this->error($where, $fkParameter[0]);

            $valueLLQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getLlqcValues()
            );

            $where = "s.sampleName LIKE 'LLQC%' AND s.analyteConcentration <> " . $valueLLQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
            $this->error($where, $fkParameter[0]);

            $valueULQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getUlqcValues()
            );

            $where = "s.sampleName LIKE 'ULQC%' AND s.analyteConcentration <> " . $valueULQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
            $this->error($where, $fkParameter[0]);
        }

        $elements = $this->getRepository("\\Alae\\Entity\\SampleVerificationStudy")->findBy(array("fkStudy" => $Batch->getFkStudy()));
        
        foreach ($elements as $sample)
        {
            $elements = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array("fkStudy" => $Batch->getFkStudy(), "fkAnalyte" => $Batch->getFkAnalyte()));

            $first = substr($sample->getAssociated(), 0, 2); 
            $last = substr($sample->getAssociated(), -1); 
            
            if($first == 'CS')
            {
                $cs_values = explode(",", $AnaStudy->getCsValues());
                $value = \Alae\Service\Conversion::conversion(
                    $AnaStudy->getFkUnit()->getName(),
                    $Batch->getAnalyteConcentrationUnits(),
                    $cs_values[$last - 1]
                );
            }

            if($first == 'QC')
            {
                $qc_values = explode(",", $AnaStudy->getQcValues());
                $value = \Alae\Service\Conversion::conversion(
                    $AnaStudy->getFkUnit()->getName(),
                    $Batch->getAnalyteConcentrationUnits(),
                    $qc_values[$last - 1]
                );
            }

            if($sample->getAssociated() == 'HDQC')
            {
                $value = \Alae\Service\Conversion::conversion(
                    $AnaStudy->getFkUnit()->getName(),
                    $Batch->getAnalyteConcentrationUnits(),
                    $AnaStudy->getHdqcValues()
                );
            }

            if($sample->getAssociated() == 'LDQC')
            {
                $value = \Alae\Service\Conversion::conversion(
                    $AnaStudy->getFkUnit()->getName(),
                    $Batch->getAnalyteConcentrationUnits(),
                    $AnaStudy->getLdqcValues()
                );
            }

            if($sample->getAssociated() == 'LLQC')
            {
                $value = \Alae\Service\Conversion::conversion(
                    $AnaStudy->getFkUnit()->getName(),
                    $Batch->getAnalyteConcentrationUnits(),
                    $AnaStudy->getLlqcValues()
                );
            }

            if($sample->getAssociated() == 'ULQC')
            {
                $value = \Alae\Service\Conversion::conversion(
                    $AnaStudy->getFkUnit()->getName(),
                    $Batch->getAnalyteConcentrationUnits(),
                    $AnaStudy->getUlqcValues()
                );
            }

            $sample = $sample->getName();
            /*if ($sample == 'PID')
            {
                $where = "s.sampleName LIKE '$sample%' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
            
                echo $where;
                die();
            }*/
            
            //echo $sample." ".$value;die();
            $where = "s.sampleName LIKE '$sample%' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
                    $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
                    $this->error($where, $fkParameter[0]);
			//if ($sample == 'PID') { echo $sample." ".$value; die();} //** para borrar
        }

        $elements = $this->getRepository("\\Alae\\Entity\\BatchNominal")->findBy(array("fkBatch" => $Batch->getPkBatch()));

        foreach ($elements as $nominal)
        {
            //$sample = $nominal->getSampleName()."-1";
            $sample = $nominal->getSampleName();
            $value = $nominal->getAnalyteConcentration();
            //$where = "s.sampleName = '$sample' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
            $where = "s.sampleName LIKE '$sample%' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
                    $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
                    $this->error($where, $fkParameter[0]);
        }
        
    }

    /**
     * V7.1: Replicados CS (mínimo) - REPLICADOS INSUFICIENTES
     * V7.2: Replicados QC (mínimo) - REPLICADOS INSUFICIENTES
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V7(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V7.1"));
        $query      = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch, SUBSTRING(s.sampleName, 1, 4) as sampleName,  COUNT(s.pkSampleBatch) as counter
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS%' AND s.fkBatch = " . $Batch->getPkBatch() . "
            GROUP BY sampleName
            HAVING counter < " . $parameters[0]->getMinValue());
        $elements   = $query->getResult();

        if (count($elements) > 0)
        {
            $pkSampleBatch = array();
            foreach ($elements as $temp)
            {
                $pkSampleBatch[] = $temp["pkSampleBatch"];
            }
            
            if(count($pkSampleBatch) > 0)
            {
                $where = "s.pkSampleBatch IN (" . implode(",", $pkSampleBatch) . ")";
                $this->error($where, $parameters[0]);
            }
        }

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V7.2"));
        $query      = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch, SUBSTRING(s.sampleName, 1, 4) as sampleName,  COUNT(s.pkSampleBatch) as counter
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'QC%' AND s.fkBatch = " . $Batch->getPkBatch() . "
            GROUP BY sampleName
            HAVING counter < " . $parameters[0]->getMinValue());
        $elements   = $query->getResult();

        if (count($elements) > 0)
        {
            $pkSampleBatch = array();
            foreach ($elements as $temp)
            {
                $pkSampleBatch[] = $temp["pkSampleBatch"];
            }
            
            if(count($pkSampleBatch) > 0)
            {
                $where = "s.pkSampleBatch IN (" . implode(",", $pkSampleBatch) . ")";
                $this->error($where, $parameters[0]);
            }
        }
    }

    /**
     * V8: Sample Name repetido - SAMPLE NAME REPETIDO
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V8(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V8"));
        $query    = $this->getEntityManager()->createQuery("
            SELECT s.sampleName,  COUNT(s.pkSampleBatch) as counter
            FROM Alae\Entity\SampleBatch s
            WHERE s.fkBatch = " . $Batch->getPkBatch() . "
            GROUP BY s.sampleName
            HAVING counter > 1");
        $elements = $query->getResult();

        if (count($elements) > 0)
        {
            $sampleNames = array();
            foreach ($elements as $temp)
            {
                $sampleNames[] = sprintf("'%s'", $temp["sampleName"]);
            }

            $where = "s.sampleName IN (" . implode(",", $sampleNames) . ") AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0]);
        }
    }

    /**
     * V9: Muestras Reinyectadas
     * Verificar muestras reinyectadas [QCRx*]
     * V9.1: Accuracy (QCRx*) - QCR* ACCURACY FUERA DE RANGO
     * V9.2: Use record = 0 ( QCRx*) - QCR* USE RECORD NO VALIDO
     * V9.3: Que tanto V 9.1 como V 9.2 se cumplan - QCR* NO VALIDO
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V9(\Alae\Entity\Batch $Batch)
    {
        $query    = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch, s.sampleName
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE  '%R%' AND s.sampleName NOT LIKE  '%\*%' AND  s.fkBatch = " . $Batch->getPkBatch() . "
            ORDER BY s.sampleName ASC");
        $elements = $query->getResult();

        if (count($elements) > 0)
        {
            $replicated = array();
            $original   = array();
            foreach ($elements as $temp)
            {
                $ids[preg_replace('/R[0-9]+/', '', $temp["sampleName"])][] = $temp["pkSampleBatch"];
            }

            foreach ($ids as $key => $values){
                array_pop($values);
                if(!empty($values)){
                    $replicated[] = implode(",", $values);
                }

                $original[] = sprintf("'%s'", $key);
            }

            $pkSampleBatch = "";
            if(!empty($replicated)){
                 $where = "(s.pkSampleBatch in (" . implode(",", $replicated) . ") OR
                     (s.sampleName in (" . implode(",", $original) . ") AND s.sampleName NOT LIKE  '%R%' AND s.sampleName NOT LIKE  '%\*%')
                 )";
            }
            else
            {
                $where = "s.sampleName in (" . implode(",", $original) . ") AND s.sampleName NOT LIKE  '%R%' AND s.sampleName NOT LIKE  '%\*%'";
            }

            $sql = "
               UPDATE Alae\Entity\SampleBatch s
               SET s.isUsed = 0, s.validFlag = 0
               WHERE s.fkBatch = " . $Batch->getPkBatch() . " AND $where";
            
            $query = $this->getEntityManager()->createQuery($sql);
            $query->execute();
        }

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.1"));
        $min = $parameters[0]->getMinValue();
        $max = $parameters[0]->getMaxValue();

        $parameters2 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.2"));

        $parameters3 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.3"));

        //$where = "REGEXP(s.sampleName, :regexp) = 1 AND s.accuracy NOT BETWEEN " . $min . " AND " . $max . " AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+-[0-9]+R[0-9]+\\*$'), false);

        $query    = $this->getEntityManager()->createQuery("
            SELECT s.sampleName, s.areaRatio, s.useRecord
            FROM Alae\Entity\SampleBatch s
            WHERE (REGEXP(s.sampleName, :regexp) = 1 OR REGEXP(s.sampleName, :regexp2) = 1) AND s.fkBatch = " . $Batch->getPkBatch() . "
            ORDER BY s.sampleName DESC");
        $query->setParameter('regexp', '^QC[0-9]+-[0-9]+R[0-9]+\\*$');
        $query->setParameter('regexp2', '^CS[0-9]+-[0-9]+R[0-9]+\\*$');
        $elements = $query->getResult();

        foreach($elements as $SampleName)
        {
            $areaRatioInj = $SampleName['areaRatio'];
            $injName = $SampleName['sampleName'];
            $useRecord = $SampleName['useRecord'];
            $originName  = preg_replace(array('/R[0-9]+/', '/\*/'), '', $SampleName['sampleName']);

            $query    = $this->getEntityManager()->createQuery("
            SELECT s.areaRatio
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName = '". $originName . "' AND s.fkBatch = " . $Batch->getPkBatch());
            $query->setMaxResults(1);
            $areaRatioOrig = $query->getSingleScalarResult();

            $dif = (($areaRatioOrig - $areaRatioInj) / $areaRatioOrig) * 100;

            $centi = "N";
            if ($dif >= $min && $dif <= $max)
            {
                $centi = "S";
            }

            $centi91 = "N";
            if($centi == "N")
            {
                $centi91 = "S";
                $where = "s.sampleName = '" . $injName . "' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0], array(), false);
            }

            $centi92 = "N";
            if($useRecord == 1) //Cambio de 0 a 1 y verificacion ok.
            {
                $centi92 = "S";
                $where = "s.sampleName = '" . $injName . "' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters2[0], array(), false);   
            }

            if($centi91 == "S" && $centi92 == "S")
            {
                $where = "s.sampleName = '" . $injName . "' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters3[0], array(), false);
            }
        }
    }

    /**
     * Verificacion de accuracy
     * V10.1: Accuracy (CS1) - NO CUMPLE ACCURACY
     * V10.2: Accuracy (CS2-CSx) - NO CUMPLE ACCURACY
     * V10.3: Accuracy (QC) - NO CUMPLE ACCURACY
     * V10.4: Accuracy (TZ) - NO CUMPLE ACCURACY
     * V10.5: Accuracy (DQC) - NO CUMPLE ACCURACY
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V10(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.1"));
        $where      = "(s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
                //echo $where;
                //die();
        $this->error($where, $parameters[0], array(), false);
            
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.2"));
        $where      = "REGEXP(s.sampleName, :regexp) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters[0], array('regexp' => '^CS[0-9]+(-[0-9]+)?$'), false);
        $this->error($where, $parameters[0], array('regexp' => '^CS[0-9]+(-[0-9]+(R[0-9]+)?)?$'), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.3"));
        $where      = "(REGEXP(s.sampleName, :regexp) = 1 OR s.sampleName LIKE 'ULQC%') AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+(-[0-9]+)?$'), false);
        $this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+(-[0-9]+(R[0-9]+)?)?$'), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.4"));
        $where      = "s.sampleName LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.5"));
        $where      = "REGEXP(s.sampleName, :regexp) = 1 AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array('regexp' => '^((L|H)?DQC)[0-9]+(-[0-9]+)?$'), false);
    }

    /**
     * V11: Revisión del dilution factor en HDQC / LDQC - FACTOR DILUCIÓN ERRÓNEO
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V11(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V11"));
        $query      = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch, s.sampleName, s.dilutionFactor
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE '%DQC%' AND s.fkBatch = " . $Batch->getPkBatch());
        $elements = $query->getResult();

        $pkSampleBatch = array();
        foreach($elements as $SampleBatch)
        {
            $factor = preg_replace('/LDQC|HDQC|-\d+/i', '', $SampleBatch['sampleName']);
            if((float)$factor <> (float)$SampleBatch['dilutionFactor'])
            {
                $pkSampleBatch[] = $SampleBatch['pkSampleBatch'];
            }
        }

        if(count($pkSampleBatch) > 0)
        {
            $ids = implode(",", $pkSampleBatch);
            $where = "s.pkSampleBatch in ($ids) AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0], array(), false);
        }
    }

    /**
     * V12: Use record (CS/QC/DQC)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V12(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.1"));
        $min1 = $parameters[0]->getMinValue();
        $max1 = $parameters[0]->getMaxValue();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.2"));
        $min2 = $parameters[0]->getMinValue();
        $max2 = $parameters[0]->getMaxValue();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.3"));
        $min3 = $parameters[0]->getMinValue();
        $max3 = $parameters[0]->getMaxValue();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.4"));
        $min4 = $parameters[0]->getMinValue();
        $max4 = $parameters[0]->getMaxValue();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.5"));
        $min5 = $parameters[0]->getMinValue();
        $max5 = $parameters[0]->getMaxValue();

        $query   = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch) as counter
            FROM Alae\Entity\SampleBatch s
            WHERE s.fkBatch = " . $Batch->getPkBatch() . "
                AND (
                    ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy NOT BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                    OR (s.sampleName LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy NOT BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 1)
                    OR ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                    OR (s.sampleName LIKE 'TZ%' AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 0)
                )");
        $query->setParameter('regexp1', '^CS[0-9]+(-[0-9]+)?$');
        $query->setParameter('regexp2', '^QC[0-9]+(-[0-9]+)?$');
        $query->setParameter('regexp3', '^((L|H)?DQC)[0-9]+(-[0-9]+)?$');

        return $query->getSingleScalarResult() > 0 ? false : true;
    }

    /**
     * V13: Tiempo de retención CS/QC (C2)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V13(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.1"));
        $parameters2 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.2"));
    
        //Toni: 14/1/2020 Agregamos la V13.3
        $parameters3 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.3"));
        
        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy"   => $Batch->getFkStudy()
        ));

        $Study = $this->getRepository("\\Alae\\Entity\\Study")->findBy(array(
            "pkStudy"   => $Batch->getFkStudy()
        ));

        //SI ES VALIDACION PARCIAL
        if($Study[0]->getValidation() == 1)
        { 
            $min = $AnaStudy[0]->getRetention() - ($AnaStudy[0]->getAcceptance() * $AnaStudy[0]->getRetention() / 100);
            $max = $AnaStudy[0]->getRetention() + ($AnaStudy[0]->getAcceptance() * $AnaStudy[0]->getRetention() / 100);

            $min_is = $AnaStudy[0]->getRetentionIs() - ($AnaStudy[0]->getAcceptanceIs() * $AnaStudy[0]->getRetentionIs() / 100);
            $max_is = $AnaStudy[0]->getRetentionIs() + ($AnaStudy[0]->getAcceptanceIs() * $AnaStudy[0]->getRetentionIs() / 100);

            // Toni: Añado al condicional $where la condicion de que no evalue SampleName BLK según mail y nota de NATALIA del 8 de diciembre de 2019

            $where = " (s.sampleName <> 'BLK' AND s.sampleType != 'Solvent' AND s.analyteRetentionTime NOT BETWEEN $min AND $max OR 
                        s.isRetentionTime NOT BETWEEN $min_is AND $max_is)
                    AND s.fkBatch = " . $Batch->getPkBatch();
            
            $this->error($where, $parameters[0], array(), false);
            // Toni: 14/1/2020 - Cambio el Where2 para que evalue s.sampletype en lugar de s.sampleName (cambio la primera linea de where2)
            //$where2 = "(s.sampleName LIKE 'CS%' OR s.sampleName LIKE 'QC%') AND
            $where2 = "(s.sampleType = 'Standard' OR s.sampleType = 'Quality Control') AND
                        s.sampleType != 'Solvent' AND 
                    (s.analyteRetentionTime NOT BETWEEN $min AND $max OR 
                        s.isRetentionTime NOT BETWEEN $min_is AND $max_is)
                    AND s.useRecord != 0
                    AND s.fkBatch = " . $Batch->getPkBatch();
            
            $this->error($where2, $parameters2[0], array(), false);
        }
    }

    /**
     * Guardar Valores Para Revisión De Criterios Del Lote
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V14(\Alae\Entity\Batch $Batch)
    {
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS%' AND s.isUsed = 1 AND s.sampleName NOT LIKE  '%\*%' AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setCsTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'QC%' AND s.isUsed = 1 AND s.sampleName NOT LIKE  '%\*%' AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setQcTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'LDQC%' AND s.isUsed = 1 AND s.sampleName NOT LIKE  '%\*%' AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setLdqcTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'HDQC%' AND s.isUsed = 1 AND s.sampleName NOT LIKE  '%\*%' AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setHdqcTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS%' AND s.sampleName NOT LIKE  '%\*%' AND s.useRecord <> 0 AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setCsAcceptedTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'QC%' AND s.sampleName NOT LIKE  '%\*%' AND s.useRecord <> 0 AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setQcAcceptedTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s  
            WHERE s.sampleName LIKE 'LDQC%' AND s.sampleName NOT LIKE  '%\*%' AND s.validFlag <> 0 AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setLdqcTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'HDQC%' AND s.sampleName NOT LIKE  '%\*%' AND s.validFlag <> 0 AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setHdqcTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT AVG(s.isPeakArea)
            FROM Alae\Entity\SampleBatch s
            WHERE (s.sampleName LIKE 'CS%' OR s.sampleName LIKE 'QC%') AND (s.sampleName NOT LIKE  '%\*%' OR s.sampleName NOT LIKE  'HDQC%' OR s.sampleName NOT LIKE  'LDQC%') AND s.validFlag <> 0 AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        if($value)
        {
            $Batch->setIsCsQcAcceptedAvg($value);
        }
        else
        {
            $Batch->setIsCsQcAcceptedAvg(0);
        }
        $this->getEntityManager()->persist($Batch);
        $this->getEntityManager()->flush();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V14.1"));
        $value      = $Batch->getIsCsQcAcceptedAvg() * ($parameters[0]->getMinValue() / 100);

        $where = "
		(s.sampleName NOT LIKE 'BLK%' AND s.sampleName NOT LIKE 'SEL%') 
		AND s.sampleType <> 'Solvent' AND s.isPeakArea < $value 
        AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters2 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V14.2"));
        
        $where2 = "
        (s.sampleName NOT LIKE 'BLK%' AND s.sampleName NOT LIKE 'SEL%')   
        AND s.sampleType <> 'Solvent' AND s.isPeakArea < $value
        AND (s.sampleName LIKE 'CS%' OR s.sampleName LIKE 'QC%') 
        AND (s.sampleType = 'Standard' OR s.sampleType = 'Quality Control') 
        AND s.useRecord = 1
        AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where2, $parameters2[0], array(), false);
    }

    /**
     * Criterio de aceptación de blancos y ceros
     * V15.1: Selección manual de los CS válidos
     * V15.2: Interf. Analito en BLK - BLK NO CUMPLE
     * V15.3: Interf. IS en BLK - BLK NO CUMPLE
     * V23.4: Interf. Analito en ZS - ZS NO CUMPLE
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V15(\Alae\Entity\Batch $Batch)
    {
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS1%' AND s.useRecord = 0 AND s.fkBatch = " . $Batch->getPkBatch());
        $counter = $query->getSingleScalarResult();

        $i = ($counter == 2) ? 2 : 1;
        $query = $this->getEntityManager()->createQuery("
            SELECT AVG(s.analytePeakArea) as analyte_peak_area, AVG(s.isPeakArea) as is_peak_area
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName like 'CS1%' AND s.useRecord = 1 AND s.validFlag = 1 AND s.fkBatch = " . $Batch->getPkBatch());
        $elements = $query->getResult();

        $analytePeakArea = $isPeakArea      = 0;
        foreach ($elements as $temp)
        {
            $analytePeakArea = $temp["analyte_peak_area"];
            $isPeakArea      = $temp["is_peak_area"];
        }

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V15.2"));
        $where      = "s.sampleName LIKE 'BLK%' AND s.analytePeakArea > " . ($analytePeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V15.3"));
        $where      = "s.sampleName LIKE 'BLK%' AND s.isPeakArea > " . ($isPeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V15.4"));
        $where      = "s.sampleName LIKE 'ZS%' AND s.analytePeakArea > " . ($analytePeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);
    }

    protected function V16(\Alae\Entity\Batch $Batch)
    {

    }

    /**
     * V17: 75% CS - LOTE RECHAZADO (75% CS)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V17(\Alae\Entity\Batch $Batch)
    {
        
        if($Batch->getCsTotal() != 0)
        {
            $value      = ($Batch->getCsAcceptedTotal() / $Batch->getCsTotal()) * 100;
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V17"));

            if ($value < $parameters[0]->getMinValue())
            {
                $where = "s.sampleName LIKE 'CS%' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0]);
            }
        }
    }

    /**
     * V18: CS consecutivos - LOTE RECHAZADO (CS CONSECUTIVOS)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V18(\Alae\Entity\Batch $Batch)
    {
        $isValid = true;
        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy" => $Batch->getFkStudy()
        ));

        /*
            Esta verificación es correcta, pero lo que ocurre es que las muestras que NO anulan lote, tienen el ValidFlag de la muestra como 1
            y debería ser 0
        */
        for ($i = 2; $i <= $AnaStudy[0]->getCsNumber(); $i++)
        {
            $query         = $this->getEntityManager()->createQuery("
                SELECT s.pkSampleBatch, s.validFlag
                FROM Alae\Entity\SampleBatch s
                WHERE (s.sampleName LIKE 'CS" . $i . "%' OR s.sampleName LIKE 'CS" . ($i - 1) . "%') AND s.fkBatch = " . $Batch->getPkBatch() . "
                ORDER BY s.sampleName ASC"
            );

            $results       = $query->getResult();

            $pkSampleBatch = array();
            $count         = 0;
            foreach ($results as $result)
            {
                if ($result['validFlag'] == 0)
                {
                    $pkSampleBatch[] = $result['pkSampleBatch'];
                    $count++;
                }
            }

            if ($count == count($results))
            {
                $isValid = false;
                break;
            }
        }

        if (!$isValid && count($pkSampleBatch) > 0)
        {
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V18"));
            $where = "s.pkSampleBatch in (" . implode(",", $pkSampleBatch) . ") AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0]);
        }
    }

    /**
     * Al menos el 50% de los estándares de calibración al nivel del límite inferior de cuantificación (CS1) 
     * y el límite superior de cuantificación (CS8 o superior) deben ser válidos. 
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V19(\Alae\Entity\Batch $Batch)
    {
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS1%' AND s.fkBatch = " . $Batch->getPkBatch());
        $cs1Total = $query->getSingleScalarResult();

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS1%'  AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch());
        $cs1AceptadosTotal = $query->getSingleScalarResult();

		/* Cambio de TONI para controlar los DIV/0 en caso de que cs1AceptadosTotal sea 0*/
        if($cs1AceptadosTotal != 0)
        {
            $value      = ($cs1AceptadosTotal / $cs1Total) * 100;
		}
		else
		{
			$value 		= 0;
		}
        

		$parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V19.1"));

            if ($value < $parameters[0]->getMinValue())
            {
                $where = "s.sampleName LIKE 'CS1%' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0]);
            }
        

        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy" => $Batch->getFkStudy()
        ));
        

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS" .$AnaStudy[0]->getCsNumber(). "%' AND s.fkBatch = " . $Batch->getPkBatch());
        $csMaxTotal = $query->getSingleScalarResult();

        $query = $this->getEntityManager()->createQuery("
        SELECT COUNT(s.pkSampleBatch)
        FROM Alae\Entity\SampleBatch s
        WHERE s.sampleName LIKE 'CS" .$AnaStudy[0]->getCsNumber(). "%' AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch());
        $csMaxAceptadosTotal = $query->getSingleScalarResult();

        /* CAMBIO DE TONI PARA CONTROLAR LOS DIV/0 en caso que no haya ningún CSMAXAceptado*/
        if($csMaxAceptadosTotal != 0)
        {
		    $value = ($csMaxAceptadosTotal / $csMaxTotal) * 100;
		}
		else
		{
			$value = 0;
		}
        
    
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V19.2"));

            if ($value < $parameters[0]->getMinValue())
            {
                $where = "s.sampleName LIKE 'CS" .$AnaStudy[0]->getCsNumber(). "%' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0]);
            }
        
    }

        /**
     * V20: r > 0.99 - LOTE RECHAZADO (r< 0.99)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V20(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V20"));

        if ($Batch->getCorrelationCoefficient() < $parameters[0]->getMinValue()/100) //Divido el valor entre 100 ya que en la tabla de parametros pone 99
        {
            //$this->evaluation($Batch, false, $parameters[0]);
            $where = "s.sampleName LIKE 'CS%' AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0]); //Toni: Descomento esta línea ya que estaba comentada y no hacía nada...
        }
    }

    /**
     * V21: 67% QC - LOTE RECHAZADO (67% QC)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V21(\Alae\Entity\Batch $Batch)
    {
        if($Batch->getQcTotal() != 0)
        {
            $value      = ($Batch->getQcAcceptedTotal() / $Batch->getQcTotal()) * 100;
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V21"));
			//echo "value: " . $value . " / QCAcceptedTotal = " . $Batch->getQcAcceptedTotal() . " / QCTotal = " . $Batch->getQcTotal() ;
			//die();
            if ($value < $parameters[0]->getMinValue())
            {
                $where = "(s.sampleName NOT LIKE 'DQC%' AND s.sampleName LIKE 'QC%') AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0]);
            }
        }
    }

    /**
     * V22: 50% de cada nivel de QC - LOTE RECHAZADO (50% QCx)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V22(\Alae\Entity\Batch $Batch)
    {
        $query    = $this->getEntityManager()->createQuery("
            SELECT SUBSTRING(s.sampleName, 1, 3) as sample_name, s.validFlag, s.sampleName as otro
            FROM Alae\Entity\SampleBatch s
            WHERE (s.sampleName like 'QC%' OR s.sampleName like 'LLQC%')  AND s.isUsed = 1 AND s.fkBatch = " . $Batch->getPkBatch() . "
            GROUP BY sample_name
            ORDER BY sample_name ASC");
        $elements = $query->getResult();

        foreach ($elements as $qc)
        {
            $query    = $this->getEntityManager()->createQuery("
                SELECT COUNT(s.pkSampleBatch)
                FROM Alae\Entity\SampleBatch s
                WHERE s.sampleName LIKE '" . $qc['sample_name'] . "%' AND s.isUsed = 1 AND s.sampleName NOT LIKE '%*%' AND s.fkBatch = " . $Batch->getPkBatch()
            );
            $qc_total = $query->getSingleScalarResult();

            $query                 = $this->getEntityManager()->createQuery("
                SELECT COUNT(s.pkSampleBatch)
                FROM Alae\Entity\SampleBatch s
                WHERE s.sampleName LIKE '" . $qc['sample_name'] . "%' AND s.sampleName NOT LIKE '%*%' AND s.useRecord = 0 AND s.fkBatch = " . $Batch->getPkBatch()
            );
            $qc_not_accepted_total = $query->getSingleScalarResult();
                
                
            $value      = ($qc_not_accepted_total / $qc_total) * 100;


            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V22"));

            if ($value > $parameters[0]->getMinValue())
            {
                $where = "s.sampleName LIKE '" . $qc['sample_name'] . "%' AND s.sampleName NOT LIKE '%R%' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0]);
            }
        }
    }

    /**
     * V23.1: 50% BLK - LOTE RECHAZADO (INTERF. BLK)
     * V23.2: 50% ZS  - LOTE RECHAZADO (INTERF. ZS)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V23(\Alae\Entity\Batch $Batch)
    {
        $query    = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'BLK%' AND s.fkBatch = " . $Batch->getPkBatch()
        );
        $blk_total = $query->getSingleScalarResult();
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'BLK%' AND s.validFlag <> 0 AND s.fkBatch = " . $Batch->getPkBatch()
        );
        $blk_accepted_total = $query->getSingleScalarResult();
		        
        if($blk_accepted_total != 0)
        {
			$value  = ($blk_accepted_total / $blk_total) * 100;
		}
		else {
			$value	= 0;
		}
        
		$parameters         = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V23.1"));
        if ($value < $parameters[0]->getMinValue())
        {
            $where = "s.sampleName LIKE 'BLK%' AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0]);
        }

        $query    = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'ZS%' AND s.fkBatch = " . $Batch->getPkBatch()
        );
        $zs_total = $query->getSingleScalarResult();
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'ZS%' AND s.validFlag <> 0 AND s.fkBatch = " . $Batch->getPkBatch()
        );
        $zs_accepted_total = $query->getSingleScalarResult();
        
        if($zs_accepted_total != 0)
        {
            $value             = ($zs_accepted_total / $zs_total) * 100;
		}
		else {
			$value				= 0;
		}

		$parameters        = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V23.2"));
            if ($value < $parameters[0]->getMinValue())
            {
                $where = "s.sampleName LIKE 'ZS%' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0]);
            }
        
    }

    
    /**
     * V25: Basales cuantificables
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V25(\Alae\Entity\Batch $Batch)
    {
       /* 
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V25"));

        $elements = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array("fkStudy" => $Batch->getFkStudy(), "fkAnalyte" => $Batch->getFkAnalyte()));

        foreach ($elements as $AnaStudy)
        {
            $cs_values = explode(",", $AnaStudy->getCsValues());
            //print_r($cs_values);die();
            if (count($cs_values) == $AnaStudy->getCsNumber())
            {
                for ($i = 1; $i <= 1; $i++)
                {
                    $analyteConcentration = \Alae\Service\Conversion::conversion(
                        $AnaStudy->getFkUnit()->getName(),
                        $Batch->getAnalyteConcentrationUnits(),
                        $cs_values[$i - 1]
                    );
                }
            }
        }

        //echo $analyteConcentration."pr";die();

        /*$query = $this->getEntityManager()->createQuery("
            SELECT s.analyteConcentration
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS1%' AND s.fkBatch = " . $Batch->getPkBatch() . "
            ORDER BY s.sampleName DESC")
            ->setMaxResults(1);
        $analyteConcentration = $query->getSingleScalarResult();

        echo $analyteConcentration;die();*/
     /*   
        $query    = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch
            FROM Alae\Entity\SampleBatch s
            WHERE (REGEXP(s.sampleName, :regexp) = 1  OR REGEXP(s.sampleName, :regexp1) = 1)
            AND s.analyteConcentration >= $analyteConcentration
            AND s.sampleType = 'Unknown'
            AND s.fkBatch = " . $Batch->getPkBatch() . "
            ORDER BY s.pkSampleBatch");

        $query->setParameter('regexp', '([0-9])+([0-9])-([0-9])+(\\.01)');
        $query->setParameter('regexp1', '([0-9])+([0-9])-([0-9])+(\\.01-[0-9])');
        $elements = $query->getResult();

        foreach($elements as $SampleName)
        {
            $where = "s.pkSampleBatch = " . $SampleName['pkSampleBatch'];
            $this->error($where, $parameters[0], array(), false);
        }
        */
    }
}