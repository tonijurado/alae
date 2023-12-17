<?php

/**
 * Modulo encargado de realizar las verificaciones a cada lote
 * Verificaciones de 4 - 24
 *
 *  EL FICHERO CORRESPONDE A ALAE2 
 *  
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
            for ($i = 4; $i < 12; $i++)
            {
                if ($i <> 8) { //Nos saltamos la 8
                    $function = 'V' . $i;
                    $this->$function($Batch);
                }
            }
            
            $response = $this->V12($Batch);
            if ($response)
            {
                $this->V26($Batch);
            }

            $this->V13_25($Batch);

            $response = $this->V12($Batch);
            if ($response)
            {
                //$this->V13_25($Batch);
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

        if ($this->getEvent()->getRouteMatch()->getParam('id'))
        {
            $Batch = $this->getRepository()->find($this->getEvent()->getRouteMatch()->getParam('id'));
        }

        $query   = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch, s.fileName, s.sampleName, s.accuracy, s.useRecord
            FROM Alae\Entity\SampleBatch s
            WHERE s.fkBatch = " . $Batch->getPkBatch() . "
                AND (
                       (s.sampleName LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)
                    OR (s.sampleName LIKE 'CS1%' AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
                )");

        $query->setParameter('regexp1', '^CS[0-9]+(-[0-9]+)?$');
        $query->setParameter('regexp2', '^QC[0-9]+(-[0-9]+)?$');
        $query->setParameter('regexp3', '^((L|H)?DQC)[0-9]+(-[0-9]+)?$');

        $data     = array();
        $elements = $query->getResult();

        if ($request->isPost())
        {
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
                       (s.sampleName LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)
                    OR (s.sampleName LIKE 'CS1%' AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
                )";

            $this->error($where, $parameters[0], array('regexp1' => '^CS[0-9]+(-[0-9]+)?$','regexp2' => '^QC[0-9]+(-[0-9]+)?$','regexp3' => '^((L|H)?DQC)[0-9]+(-[0-9]+)?$'), false);
            $this->V13_25($Batch);
            }
        }

        // ANULAMOS ESTE BLOQUE COMPLETO
        
        //
                
        /* y se sustituye por este que solo evalua que ACURACY esté OK y que UserRecord = 0 

        $query   = $this->getEntityManager()->createQuery("
        SELECT s.fileName, s.sampleName, s.accuracy, s.useRecord
        FROM Alae\Entity\SampleBatch s
        WHERE s.fkBatch = " . $Batch->getPkBatch() . "
            AND (
                   (s.sampleName LIKE 'CS1%' AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
            )");

         // Fin del cambio   */

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
    }

    /*
     * Actualiza curve flag
     */
    protected function curve($pkParameter)
    {
        $sql = "
            UPDATE Alae\Entity\Batch b
            SET b.curveFlag = 1
            WHERE b.pkBatch = " . $pkParameter;
        $query = $this->getEntityManager()->createQuery($sql);
        $query->execute();
    }

    /**
     * Varificaciones desde la 13 hasta la 25
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V13_25(\Alae\Entity\Batch $Batch)
    {
        
        for ($i = 13; $i <= 20; $i++)
        {
            $function = 'V' . $i;
            $this->$function($Batch);
        }
        
        $function = 'V23';
        $this->$function($Batch);

        $function = 'V25';
        $this->$function($Batch);

        $continue = $this->evaluation($Batch);
        
        if ($continue && is_null($Batch->getFkParameter()))
        {
            $this->$function($Batch);
            for ($i = 21; $i <= 26; $i++)
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
            $pkParameter[] = $sampleBatch->getPkSampleBatch();
        }

        if(!$isValid && count($pkParameter) > 0)
        {
            $sql = "
                UPDATE Alae\Entity\SampleBatch s
                SET s.validFlag = 0
                WHERE s.pkSampleBatch in (" . implode(",", $pkParameter) . ")";
            $query = $this->getEntityManager()->createQuery($sql);
            $query->execute();
        }
    }

        /*
     * Verifica los errores de los lotes
     */
    protected function errorCurve($where, $fkParameter, $pkBatch, $parameters = array(), $isValid = true)
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
            $pkParameter[] = $sampleBatch->getPkSampleBatch();
            $this->curve($pkBatch);
        }

        if(!$isValid && count($pkParameter) > 0)
        {
            $sql = "
                UPDATE Alae\Entity\SampleBatch s
                SET s.validFlag = 0
                WHERE s.pkSampleBatch in (" . implode(",", $pkParameter) . ")";
            $query = $this->getEntityManager()->createQuery($sql);
            $query->execute();
        }
    }

    /**
     * V4: Sample Type - SAMPLE TYPE ERRÓNEO
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V4(\Alae\Entity\Batch $Batch)
    {
    /*
        $where = "
        (
            (s.sampleName LIKE 'BLK%' AND s.sampleType <> 'Blank') OR
            (s.sampleName LIKE 'ZS%' AND s.sampleType <> 'Blank') OR
            (s.sampleName LIKE 'CS%' AND s.sampleType <> 'Standard') OR
            (s.sampleName LIKE '%QC%' AND s.sampleType <> 'Quality Control') OR
            (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleType <> 'Solvent') OR
            (REGEXP(s.sampleName, :regexp2) = 1 AND s.sampleType <> 'Unknown')
        ) AND s.fkBatch = " . $Batch->getPkBatch();
        $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V4"));
        $this->error(
            $where,
            $fkParameter[0],
            array(
                "regexp1" => "^REC|FM$",
                "regexp2" => "^[0-9]+(-)[0-9]+\.[0-9]+$"
            )
        );
    */

    //La parte superior comentada es el SampleType Erroneo de ALAE1. Lo cambiamos por el SampleType mejorado de Validaciones que incluye muestras que no existen en ALAE
    //pero que contempla todas las opciones.
    $where = "
    (
        (s.sampleType = 'Blank' AND (s.sampleName NOT LIKE 'BLK%' AND 
                                    s.sampleName NOT LIKE 'SEL%' AND 
                                    s.sampleName NOT LIKE 'ZS-%')
        )
                                    OR

        (s.sampleType = 'Standard' AND (s.sampleName NOT LIKE 'CS%') 
        )
                                    OR
        (s.sampleType = 'Solvent' AND (s.sampleName NOT LIKE 'REC%' AND 
                                      s.sampleName NOT LIKE 'FM%' AND 
                                      s.sampleName NOT LIKE 'EGC%' AND
                                      s.sampleName NOT LIKE 'ES%')
        ) 
                                    OR
        (s.sampleType = 'Quality Control' AND (s.sampleName NOT LIKE 'QC%' AND
                                              s.sampleName NOT LIKE 'LLQC%' AND
                                              s.sampleName NOT LIKE 'ULQC%' AND
                                              s.sampleName NOT LIKE 'LDQC%' AND
                                              s.sampleName NOT LIKE 'HDQC%' AND
                                              s.sampleName NOT LIKE 'PID%' AND
                                              s.sampleName NOT LIKE 'AS%' AND
                                              s.sampleName NOT LIKE 'LL_LLOQ%' AND
                                              s.sampleName NOT LIKE 'TZ%' AND
                                              s.sampleName NOT LIKE 'ME%' AND
                                              s.sampleName NOT LIKE 'FT%' AND
                                              s.sampleName NOT LIKE 'ST%' AND
                                              s.sampleName NOT LIKE 'LT%' AND
                                              s.sampleName NOT LIKE 'PP%' AND
                                              s.sampleName NOT LIKE 'SLP%'
                                              )
        )
                                    OR
        (s.sampleName = 'ZS_BC%' AND (s.sampleType <> 'Unknown')) 
                                    OR
        (s.sampleName = 'ZS_NT%' AND (s.sampleType <> 'Unknown'))
        OR
        (s.sampleType = 'Unknown' AND (s.sampleName  LIKE 'BLK%' OR 
                                        s.sampleName LIKE 'SEL%' OR 
                                        s.sampleName LIKE 'ZS-%' OR
                                        s.sampleName LIKE 'CS%' OR
                                        s.sampleName LIKE 'REC%' OR 
                                        s.sampleName LIKE 'FM%' OR 
                                        s.sampleName LIKE 'EGC%' OR
                                        s.sampleName LIKE 'QC%' OR
                                        s.sampleName LIKE 'LLQC%' OR
                                        s.sampleName LIKE 'ULQC%' OR
                                        s.sampleName LIKE 'LDQC%' OR
                                        s.sampleName LIKE 'HDQC%' OR
                                        s.sampleName LIKE 'PID%' OR
                                        s.sampleName LIKE 'AS%' OR
                                        s.sampleName LIKE 'LL_LLOQ%' OR
                                        s.sampleName LIKE 'TZ%' OR
                                        s.sampleName LIKE 'ME%' OR
                                        s.sampleName LIKE 'FT%' OR
                                        s.sampleName LIKE 'ST%' OR
                                        s.sampleName LIKE 'LT%' OR
                                        s.sampleName LIKE 'PP%' OR
                                        s.sampleName LIKE 'SLP%'))

    ) AND s.fkBatch = " . $Batch->getPkBatch();
    
    

    $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V4"));
    //echo 'V5 antes this ' . $where;
    
    //$this->error($where, $fkParameter[0]);
    $this->errorCurve($where, $fkParameter[0], $Batch->getPkBatch());
    }

    /**
     * V5: Concentración nominal de CS/QC - CONCENTRACIÓN NOMINAL ERRÓNEA
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V5(\Alae\Entity\Batch $Batch)
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
/*
** 20/06/2023 - Toni: Para que el sistema cargue hasta CS15 y no falle, cambiamos la siguiente LINEA ORIGINAL
$where = "s.sampleName LIKE 'CS" . $i . "%' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
por esta otra quitando el % del primer LIKE 'CS" . $i . "%' AND .... 
$where = "s.sampleName LIKE 'CS" . $i . "' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
*/
                    $where = "s.sampleName LIKE 'CS" . $i . "' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
                    $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V5"));
                    //$this->error($where, $fkParameter[0]);
                    $this->errorCurve($where, $fkParameter[0], $Batch->getPkBatch());
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
                    $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V5"));
                    $this->errorCurve($where, $fkParameter[0], $Batch->getPkBatch());
                }
            }

            //Agregamos el 11-07-2019 también el código para verificar las concentraciones nominales de LDQC, HDQC, LLQC y UDQC - Toni (copiado de ALAE2 V5)
            $valueLDQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getLdqcValues()
            );

            $where = "s.sampleName LIKE 'LDQC%' AND s.analyteConcentration <> " . $valueLDQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V5"));
            //$this->error($where, $fkParameter[0]);
            $this->errorCurve($where, $fkParameter[0], $Batch->getPkBatch());

            $valueHDQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getHdqcValues()
            );

            $where = "s.sampleName LIKE 'HDQC%' AND s.analyteConcentration <> " . $valueHDQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V5"));
            //$this->error($where, $fkParameter[0]);
            $this->errorCurve($where, $fkParameter[0], $Batch->getPkBatch());

        }
            //Fin del agregado el 11-07-2019 del control de Concentración nominal de LDQC, HDQC, LLQC y ULQD - Toni            


    }

    /**
     * V6.1: Replicados CS (mínimo) - REPLICADOS INSUFICIENTES
     * V6.2: Replicados QC (mínimo) - REPLICADOS INSUFICIENTES
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V6(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6.1"));
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

            $where = "s.pkSampleBatch IN (" . implode(",", $pkSampleBatch) . ")";
            //$this->error($where, $parameters[0]);
            $this->errorCurve($where, $parameters[0], $Batch->getPkBatch());
        }

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6.2"));
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

            $where = "s.pkSampleBatch IN (" . implode(",", $pkSampleBatch) . ")";
            //$this->error($where, $parameters[0]);

            $this->errorCurve($where, $parameters[0], $Batch->getPkBatch());
        }
    }

    /**
     * V7: Sample Name repetido - SAMPLE NAME REPETIDO
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V7(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V7"));
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
            //$this->error($where, $parameters[0]);
            $this->errorCurve($where, $parameters[0], $Batch->getPkBatch());
        }
    }

    /**
     * V8: Muestras Reinyectadas
     * @param \Alae\Entity\Batch $Batch
     */
    
    protected function V81(\Alae\Entity\Batch $Batch)
    {
        $query    = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch, s.sampleName, s.areaRatio, s.useRecord
            FROM Alae\Entity\SampleBatch s
            WHERE (REGEXP(s.sampleName, :regexp) = 1 OR REGEXP(s.sampleName, :regexp2) = 1) AND  s.fkBatch = " . $Batch->getPkBatch() . "
            ORDER BY s.sampleName ASC");
        $query->setParameter('regexp', '^QC[0-9]+-[0-9]+R[0-9]+\\*$');
        $query->setParameter('regexp2', '^CS[0-9]+-[0-9]+R[0-9]+\\*$');
        $elements = $query->getResult();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.1"));
        $min = $parameters[0]->getMinValue();
        $max = $parameters[0]->getMaxValue();

        // $parameters2 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.2"));
        //$parameters3 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.3"));
        
        //Toni: 

        if (count($elements) > 0)
        {
            foreach ($elements as $temp)
            {
                $areaRatioInj = $temp['areaRatio'];
                $useRecordInj = $temp['useRecord'];
                    //echo 'UseRecord = ' . $useRecordInj . ' /// ';
                $originName  = preg_replace(array('/R[0-9]+/', '/\*/'), '', $temp['sampleName']);
                    //echo $originName . ' /// ';
                    //die();
                $query2    = $this->getEntityManager()->createQuery("
                SELECT s.sampleName, s.areaRatio
                FROM Alae\Entity\SampleBatch s
                WHERE s.fkBatch = " . $Batch->getPkBatch() . " and s.sampleName = '". $originName . "'
                ORDER BY s.sampleName ASC");
                $elements2 = $query2->getResult();
                foreach ($elements2 as $temp2)
                {
                    $sampleNameOrig = $temp2['sampleName'];
                    $areaRatioOrig = $temp2['areaRatio'];
                }

                $dif = (($areaRatioOrig - $areaRatioInj) / $areaRatioOrig) * 100;

                $centi91 = "N";
                if ($dif <= $min || $dif >= $max) //Verificamos el ratio de +- 15%, si no cumple, generamos error para las muestras reinyectadas junto a esta
                {
                    $centi91 = "S";
                    $where = "s.sampleName = '" . $temp['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
                    $this->error($where, $parameters[0], array(), false);
                }

                $centi92 = "N";
                if($useRecordInj == 1) //Si alguna muestra tiene useRecord <> 0 generamos error ya que todas las muestras reinyectadas deben tener useRecord=0
                {
                    $centi92 = "S";
                    $where = "s.sampleName = '" . $temp['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
                    $this->error($where, $parameters[0], array(), false);
                }
                //echo 'Centi 91 calculos -> ' . $centi91 . ' // centi92 UseRecord == 0 ->' . $centi92;
                if($centi91 == "S" || $centi92 == "S")
                {
                    $where = "s.sampleName = '" . $temp['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
                    $this->error($where, $parameters[0], array(), false);

                    $pos = strpos($temp["sampleName"], '*');
                    $pos = $pos - 1;
                    $reinyect =  trim(substr($temp["sampleName"], -3, $pos), '*');

                    $query2    = $this->getEntityManager()->createQuery("
                    SELECT s.sampleName, s.areaRatio
                    FROM Alae\Entity\SampleBatch s
                    WHERE s.fkBatch = " . $Batch->getPkBatch() . " and s.sampleName LIKE '%". $reinyect . "%' AND s.sampleName NOT LIKE  '%\*%'
                    ORDER BY s.sampleName ASC");
                    $elements2 = $query2->getResult();

                    foreach ($elements2 as $temp2)
                    {
                        $where = "s.sampleName = '" . $temp2['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
                        $this->error($where, $parameters[0], array(), false);
                    }   
                }
            }
        }
    }

    /*
     * Verificar muestras reinyectadas [QCRx*]
     * V9.1: Accuracy (QCRx*) - QCR* ACCURACY FUERA DE RANGO
     * V9.2: Use record = 0 ( QCRx*) - QCR* USE RECORD NO VALIDO
     * V9.3: Que tanto V 9.1 como V 9.2 se cumplan - QCR* NO VALIDO
     * @param \Alae\Entity\Batch $Batch
     
    protected function V9(\Alae\Entity\Batch $Batch)
    {
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
            $originName  = preg_replace(array('/R[0-9]+/', '/\* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXBORRA TODAS LAS X/'), '', $SampleName['sampleName']);

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
            if($useRecord == 0)
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
    */
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
            SELECT s.pkSampleBatch, s.sampleName, s.areaRatio, s.useRecord
            FROM Alae\Entity\SampleBatch s
            WHERE (REGEXP(s.sampleName, :regexp) = 1 OR REGEXP(s.sampleName, :regexp2) = 1 OR REGEXP(s.sampleName, :regexp3) = 1) AND  s.fkBatch = " . $Batch->getPkBatch() . "
            ORDER BY s.sampleName ASC");
        $query->setParameter('regexp', '^QC[0-9]+-[0-9]+R[0-9]+\*$');
        $query->setParameter('regexp2', '^CS[0-9]+-[0-9]+R[0-9]+\*$');
        $query->setParameter('regexp3', 'QC-[0-9]+R[0-9]+\*$'); // Añadimos esta para incluir muestras tipo: LLQC-5R1 (es decir, %QC-xRy*)
        $elements = $query->getResult();

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.1"));
        $min = $parameters[0]->getMinValue();
        $max = $parameters[0]->getMaxValue();

        $parameters2 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.2"));
        $parameters3 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V9.3"));
        
        //Toni: 

        if (count($elements) > 0)
        {
            foreach ($elements as $temp)
            {
                $areaRatioInj = $temp['areaRatio'];
                $useRecordInj = $temp['useRecord'];
                    //echo 'UseRecord = ' . $useRecordInj . ' /// ';
                $originName  = preg_replace(array('/R[0-9]+/', '/\*/'), '', $temp['sampleName']);
                    //echo $originName . ' /// ';
                    //die();
                $query2    = $this->getEntityManager()->createQuery("
                SELECT s.sampleName, s.areaRatio
                FROM Alae\Entity\SampleBatch s
                WHERE s.fkBatch = " . $Batch->getPkBatch() . " and s.sampleName = '". $originName . "'
                ORDER BY s.sampleName ASC");
                $elements2 = $query2->getResult();
                foreach ($elements2 as $temp2)
                {
                    $sampleNameOrig = $temp2['sampleName'];
                    $areaRatioOrig = $temp2['areaRatio'];
                }

                $dif = (($areaRatioOrig - $areaRatioInj) / $areaRatioOrig) * 100;

                $centi91 = "N";
                if ($dif <= $min || $dif >= $max) //Verificamos el ratio de +- 15%, si no cumple, generamos error para las muestras reinyectadas junto a esta
                {
                    $centi91 = "S";
                    $where = "s.sampleName = '" . $temp['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
                    $this->error($where, $parameters[0], array(), false);
                }

                $centi92 = "N";
                if($useRecordInj == 1) //Si alguna muestra tiene useRecord <> 0 generamos error ya que todas las muestras reinyectadas deben tener useRecord=0
                {
                    $centi92 = "S";
                    $where = "s.sampleName = '" . $temp['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
                    //$this->error($where, $parameters2[0], array(), false);
                    $this->errorCurve($where, $parameters2[0], $Batch->getPkBatch(), array(), false);
                }
                //echo 'Centi 91 calculos -> ' . $centi91 . ' // centi92 UseRecord == 0 ->' . $centi92;
                if($centi91 == "S" || $centi92 == "S")
                {
                    $where = "s.sampleName = '" . $temp['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
                    //$this->error($where, $parameters3[0], array(), false);
                    $this->error($where, $parameters3[0], array(), false);
                    $pos = strpos($temp["sampleName"], '*');
                    $pos = $pos - 1;
                    $reinyect =  trim(substr($temp["sampleName"], -3, $pos), '*');

                    $query2    = $this->getEntityManager()->createQuery("
                    SELECT s.sampleName, s.areaRatio
                    FROM Alae\Entity\SampleBatch s
                    WHERE s.fkBatch = " . $Batch->getPkBatch() . " and s.sampleName LIKE '%". $reinyect . "%' AND s.sampleName NOT LIKE  '%\*%'
                    ORDER BY s.sampleName ASC");
                    $elements2 = $query2->getResult();

                    foreach ($elements2 as $temp2)
                    {
                        $where = "s.sampleName = '" . $temp2['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
                        //$this->error($where, $parameters3[0], array(), false);
                        $this->error($where, $parameters3[0], array(), false);
                    }   
                }
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
     * 
     * TONI 03/04/2020: Incorporamos en esta verificación también los pasos para VERIFICAR que si NO SE CUMPLE ACCURACY pero está marcado el USE RECORD = 1, 
     * se genere un error de USE RECORD y se rechace el lote.
     * Después de cada verificación, he repetido el código pero añadiendo que s.useRecord = 1, de esta forma identifico las muestras que NO CUMPLEN ACCURACY pero tienen USE RECORD = 1
     * 
     */
    protected function V10(\Alae\Entity\Batch $Batch) //Esta es copia identica de VALIDACIONES aunque no aplica a TZ, LLQC ni PID ya que en muestras estas no existen.
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.1"));
        $where      = "(s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLQC%' OR s.sampleName LIKE 'PID%' OR s.sampleName LIKE 'LL_LLOQ%') AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        //REPITO la consulta anterior pero ahora Verificamos el USE RECORD de las muestras que no cumple accuracy de V10.1
        //Si ese USE RECORD = 1, se debe identificar la muestra como error y se anula lote gracias al parámetro de la tblParameters 
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.1.1"));
            $where      = "(s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLQC%' OR s.sampleName LIKE 'PID%' OR s.sampleName LIKE 'LL_LLOQ%') AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0], array(), false);
        //Fin de la comprobación del USE RECORD = 1 para muestras que no cumplen Accuracy para la V10.1

        
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.2"));
        $where      = "REGEXP(s.sampleName, :regexp) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters[0], array('regexp' => '^CS[0-9]+(-[0-9]+)?$'), false);
        $this->error($where, $parameters[0], array('regexp' => '^CS[0-9]+(-[0-9]+(R[0-9]+)?)?$'), false);

        //REPITO la consulta anterior pero ahora Verificamos el USE RECORD de las muestras que no cumple accuracy de V10.2
        //Si ese USE RECORD = 1, se debe identificar la muestra como error y se anula lote gracias al parámetro de la tblParameters 
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.2.1"));
            $where      = "REGEXP(s.sampleName, :regexp) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch();
            //$this->error($where, $parameters[0], array('regexp' => '^CS[0-9]+(-[0-9]+)?$'), false);
            $this->error($where, $parameters[0], array('regexp' => '^CS[0-9]+(-[0-9]+(R[0-9]+)?)?$'), false);
        //Fin de la comprobación del USE RECORD = 1 para muestras que no cumplen Accuracy para la V10.2


        /*$parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.3"));
        $where      = "(REGEXP(s.sampleName, :regexp) = 1) AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+(-[0-9]+)?$'), false);
        $this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+(-[0-9]+(R[0-9]+)?)?$'), false);*/

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.3"));
        $where      = "(s.sampleType = 'Quality Control' AND 
                        (s.sampleName LIKE 'QC%' OR
                        s.sampleName LIKE 'LLQC%' OR
                        s.sampleName LIKE 'ULQC%' OR
                        s.sampleName LIKE 'LDQC%' OR
                        s.sampleName LIKE 'HDQC%' OR
                        s.sampleName LIKE 'PID%' OR
                        s.sampleName LIKE 'AS%' OR
                        s.sampleName LIKE 'LL_LLOQ%' OR
                        s.sampleName LIKE 'TZ%' OR
                        s.sampleName LIKE 'ME%' OR
                        s.sampleName LIKE 'FT%' OR
                        s.sampleName LIKE 'ST%' OR
                        s.sampleName LIKE 'LT%' OR
                        s.sampleName LIKE 'PP%' OR
                        s.sampleName LIKE 'SLP%'))
                        AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+(-[0-9]+)?$'), false);
        $this->error($where, $parameters[0], array(), false);

        //REPITO la consulta anterior pero ahora Verificamos el USE RECORD de las muestras que no cumple accuracy de V10.3
        //Si ese USE RECORD = 1, se debe identificar la muestra como error y se anula lote gracias al parámetro de la tblParameters 
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.3.1"));
            $where      = "(s.sampleType = 'Quality Control' AND 
                            (s.sampleName LIKE 'QC%' OR
                            s.sampleName LIKE 'LLQC%' OR
                            s.sampleName LIKE 'ULQC%' OR
                            s.sampleName LIKE 'LDQC%' OR
                            s.sampleName LIKE 'HDQC%' OR
                            s.sampleName LIKE 'PID%' OR
                            s.sampleName LIKE 'AS%' OR
                            s.sampleName LIKE 'LL_LLOQ%' OR
                            s.sampleName LIKE 'TZ%' OR
                            s.sampleName LIKE 'ME%' OR
                            s.sampleName LIKE 'FT%' OR
                            s.sampleName LIKE 'ST%' OR
                            s.sampleName LIKE 'LT%' OR
                            s.sampleName LIKE 'PP%' OR
                            s.sampleName LIKE 'SLP%'))
                            AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch();
            //$this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+(-[0-9]+)?$'), false);
            $this->error($where, $parameters[0], array(), false);
        
        //Fin de la comprobación del USE RECORD = 1 para muestras que no cumplen Accuracy para la V10.3 

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.4"));
        $where      = "s.sampleName LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        //REPITO la consulta anterior pero ahora Verificamos el USE RECORD de las muestras que no cumple accuracy de V10.4
        //Si ese USE RECORD = 1, se debe identificar la muestra como error y se anula lote gracias al parámetro de la tblParameters 
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.4.1"));
            $where      = "s.sampleName LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0], array(), false);

        //Fin de la comprobación del USE RECORD = 1 para muestras que no cumplen Accuracy para la V10.4 

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.5"));
        $where      = "REGEXP(s.sampleName, :regexp) = 1 AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array('regexp' => '^((L|H)?DQC)[0-9]+(-[0-9]+)?$'), false);

        //REPITO la consulta anterior pero ahora Verificamos el USE RECORD de las muestras que no cumple accuracy de V10.5
        //Si ese USE RECORD = 1, se debe identificar la muestra como error y se anula lote gracias al parámetro de la tblParameters 
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.5.1"));
            $where      = "REGEXP(s.sampleName, :regexp) = 1 AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0], array('regexp' => '^((L|H)?DQC)[0-9]+(-[0-9]+)?$'), false);
        
        //Fin de la comprobación del USE RECORD = 1 para muestras que no cumplen Accuracy para la V10.5 


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
            //$this->error($where, $parameters[0], array(), false);
            $this->errorCurve($where, $parameters[0], $Batch->getPkBatch(), array(), false);
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
        // Bloque ORIGINAL
        $query   = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch) as counter
            FROM Alae\Entity\SampleBatch s
            WHERE s.fkBatch = " . $Batch->getPkBatch() . "
                AND (
                       (s.sampleName LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)
                    OR (s.sampleName LIKE 'CS1%' AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
                )");
        
        /*
        //Nuevo bloque donde solamente queremos evaluar cuando SI se cumple ACCURACY pero USE RECORD = 0
        $query   = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch) as counter
            FROM Alae\Entity\SampleBatch s
            WHERE s.fkBatch = " . $Batch->getPkBatch() . "
                AND (
                    (s.sampleName LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                    OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)
                )");
        // fin de la modificación
        */
        $query->setParameter('regexp1', '^CS[0-9]+(-[0-9]+)?$');
        $query->setParameter('regexp2', '^QC[0-9]+(-[0-9]+)?$');
        $query->setParameter('regexp3', '^((L|H)?DQC)[0-9]+(-[0-9]+)?$');

        return $query->getSingleScalarResult() > 0 ? false : true;
    }

    /**
     * Criterio de aceptación de blancos y ceros
     * V13.1: Selección manual de los CS válidos
     * V13.2: Interf. Analito en BLK - BLK NO CUMPLE
     * V13.3: Interf. IS en BLK - BLK NO CUMPLE
     * V13.4: Interf. Analito en ZS - ZS NO CUMPLE
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V13(\Alae\Entity\Batch $Batch)
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
            WHERE s.sampleName like 'CS" . $i . "%' AND s.validFlag = 1 AND s.fkBatch = " . $Batch->getPkBatch());
        $elements = $query->getResult();

        $analytePeakArea = $isPeakArea      = 0;
        foreach ($elements as $temp)
        {
            $analytePeakArea = $temp["analyte_peak_area"];
            $isPeakArea      = $temp["is_peak_area"];
        }

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.2"));
        $where      = "s.sampleName LIKE 'BLK%' AND s.analytePeakArea > " . ($analytePeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.3"));
        $where      = "s.sampleName LIKE 'BLK%' AND s.isPeakArea > " . ($isPeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.4"));
        $where      = "s.sampleName LIKE 'ZS%' AND s.analytePeakArea > " . ($analytePeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);
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
            WHERE s.sampleName LIKE 'CS%' AND s.sampleName NOT LIKE  '%\*%' AND s.validFlag <> 0 AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setCsAcceptedTotal($value);

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'QC%' AND s.sampleName NOT LIKE  '%\*%' AND s.validFlag <> 0 AND s.fkBatch = " . $Batch->getPkBatch());
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
            WHERE (s.sampleName LIKE 'CS%' OR s.sampleName LIKE 'QC%') AND s.sampleName NOT LIKE  '%\*%' AND s.validFlag <> 0 AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch());
        $value = $query->getSingleScalarResult();
        $Batch->setIsCsQcAcceptedAvg($value);

        $this->getEntityManager()->persist($Batch);
        $this->getEntityManager()->flush();
    }

    /**
     * V15: 75% CS - LOTE RECHAZADO (75% CS)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V15(\Alae\Entity\Batch $Batch)
    {
        if($Batch->getCsTotal() != 0)
        {
            $value      = ($Batch->getCsAcceptedTotal() / $Batch->getCsTotal()) * 100;
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V15"));

            if ($value < $parameters[0]->getMinValue())
            {
                $where = "s.sampleName LIKE 'CS%' AND s.fkBatch = " . $Batch->getPkBatch();
                //$this->error($where, $parameters[0]);
                $this->errorCurve($where, $parameters[0], $Batch->getPkBatch());
                //$this->curve($Batch->getPkBatch());
            }
        }
    }

    /**
     * V16: CS consecutivos - LOTE RECHAZADO (CS CONSECUTIVOS)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V16(\Alae\Entity\Batch $Batch)
    {
        $isValid = true;
        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy" => $Batch->getFkStudy()
        ));

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

            if ($count == count($results) && $pkSampleBatch)
            {
                $isValid = false;
                break;
            }
        }
        
        if (!$isValid) 
        {
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V16"));
            $where = "s.pkSampleBatch in (" . implode(",", $pkSampleBatch) . ") AND s.fkBatch = " . $Batch->getPkBatch();
            //$this->error($where, $parameters[0]);
            $this->errorCurve($where, $parameters[0], $Batch->getPkBatch());
            //$this->curve($Batch->getPkBatch());
        }
    }

    /**
     * Revisar
     * V17: r > 0.99 - LOTE RECHAZADO (r< 0.99)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V17(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V17"));

        if (($Batch->getCorrelationCoefficient() * 100) < $parameters[0]->getMinValue())
        {
            $this->evaluation($Batch, false, $parameters[0]);
            //$this->errorCurve($where, $parameters[0], $Batch->getPkBatch());
            $this->curve($Batch->getPkBatch());
        }
    }

    /**
     * V18: 67% QC - LOTE RECHAZADO (67% QC)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V18(\Alae\Entity\Batch $Batch)
    {
        if($Batch->getQcTotal() != 0)
        {
            $value      = ($Batch->getQcAcceptedTotal() / $Batch->getQcTotal()) * 100;
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V18"));

            if ($value < $parameters[0]->getMinValue())
            {
                $where = "s.sampleName LIKE 'QC%' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0]);
            }
        }
    }

    /**
     * V19: 50% de cada nivel de QC - LOTE RECHAZADO (50% QCx)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V19(\Alae\Entity\Batch $Batch)
    {
        $query    = $this->getEntityManager()->createQuery("
            SELECT SUBSTRING(s.sampleName, 1, 3) as sample_name, s.validFlag, s.sampleName as otro
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName like 'QC%' AND s.isUsed = 1 AND s.fkBatch = " . $Batch->getPkBatch() . "
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
                WHERE s.sampleName LIKE '" . $qc['sample_name'] . "%' AND s.sampleName NOT LIKE '%*%' AND s.validFlag = 1 AND s.fkBatch = " . $Batch->getPkBatch()
            );
            $qc_not_accepted_total = $query->getSingleScalarResult();

            $value      = ($qc_not_accepted_total / $qc_total) * 100;
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V19"));

            if ($value < $parameters[0]->getMinValue())
            {
                $where = "s.sampleName LIKE '" . $qc['sample_name'] . "%' AND s.sampleName NOT LIKE '%R%' AND s.fkBatch = " . $Batch->getPkBatch();
                $this->error($where, $parameters[0]);
            }
        }
    }

    /**
     * V20.1: 50% BLK - LOTE RECHAZADO (INTERF. BLK)
     * V20.2: 50% ZS  - LOTE RECHAZADO (INTERF. ZS)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V20(\Alae\Entity\Batch $Batch)
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
       
        $parameters         = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V20.1"));
        if ($value < $parameters[0]->getMinValue())
        {
            $where = "s.sampleName LIKE 'BLK%' AND s.fkBatch = " . $Batch->getPkBatch();
            //$this->error($where, $parameters[0]);
            $this->errorCurve($where, $parameters[0], $Batch->getPkBatch());
            //$this->curve($Batch->getPkBatch());
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
        $parameters        = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V20.2"));
        if ($value < $parameters[0]->getMinValue())
        {
            $where = "s.sampleName LIKE 'ZS%' AND s.fkBatch = " . $Batch->getPkBatch();
            //$this->error($where, $parameters[0]);
            $this->errorCurve($where, $parameters[0], $Batch->getPkBatch());
            //$this->curve($Batch->getPkBatch());
        }
    }

    /**
     * V21: Conc. (unknown) > ULOQ ( E ) - CONC. SUPERIOR AL ULOQ
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V21(\Alae\Entity\Batch $Batch)
    {
        if($Batch->getCsTotal() != 0)
        {
            $query = $this->getEntityManager()->createQuery("
                SELECT s.analyteConcentration
                FROM Alae\Entity\SampleBatch s
                WHERE s.sampleName LIKE 'CS%' AND s.fkBatch = " . $Batch->getPkBatch() . "
                ORDER BY s.sampleName DESC")
                ->setMaxResults(1);
            $analyteConcentration = $query->getSingleScalarResult();

            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V21"));
            $where = "s.sampleType = 'Unknown' AND s.calculatedConcentration > $analyteConcentration AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0], array(), false);
        }
    }

    /**
     * V22: Variabilidad IS (unknown) ( H ) - VARIABILIDAD IS
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V22(\Alae\Entity\Batch $Batch)
    {
        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy"   => $Batch->getFkStudy()
        ));

        if ($AnaStudy[0]->getIsUsed())
        {
            $varIs = $Batch->getIsCsQcAcceptedAvg() * ($AnaStudy[0]->getInternalStandard() / 100);
            $min   = $Batch->getIsCsQcAcceptedAvg() - $varIs;
            $max   = $Batch->getIsCsQcAcceptedAvg() + $varIs;
            
            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V22"));
            $where = "s.sampleType = 'Unknown' AND s.isPeakArea NOT BETWEEN $min AND $max AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0], array(), false);
        }
    }

    /**
     * V23: < 5% respuesta IS (unknown) ( B ) - ERROR EXTRACCIÓN IS
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V23(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V23"));
        $parameters1 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V23.1"));
        $value      = $Batch->getIsCsQcAcceptedAvg() * ($parameters[0]->getMinValue() / 100);
        
        //TYPE Unknown
        $where = "(s.sampleName NOT LIKE 'ZS%' AND s.sampleName NOT LIKE 'CS%' AND s.sampleName NOT LIKE 'QC%') AND s.sampleType = 'Unknown' AND s.isPeakArea < $value AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        //SampleName ZS, TYPE Unknown
        $where = "s.sampleName LIKE 'ZS%' AND s.sampleType = 'Blank' AND s.isPeakArea < $value AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        //SampleName CS, TYPE Standard
        $where = "s.sampleName LIKE 'CS%' AND s.sampleType = 'Standard' AND s.isPeakArea < $value AND s.useRecord = 0 AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        //SampleName CS, TYPE Standard y UseRecord=1 --> Se rechaza LOTE V23.1
        $where = "s.sampleName LIKE 'CS%' AND s.sampleType = 'Standard' AND s.isPeakArea < $value AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters1[0], array(), false);
        $this->errorCurve($where, $parameters1[0], $Batch->getPkBatch(), array(), false);

        //SampleName QC, TYPE Quality Control
        $where = "s.sampleName LIKE '%QC%' AND s.sampleType = 'Quality Control' AND s.isPeakArea < $value AND s.useRecord = 0 AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        //SampleName QC, TYPE Quality Control y UseRecord=1 --> Se rechaza LOTE V23.1
        $where = "s.sampleName LIKE '%QC%' AND s.sampleType = 'Quality Control' AND s.isPeakArea < $value AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters1[0], array(), false);
        $this->errorCurve($where, $parameters1[0], $Batch->getPkBatch(), array(), false);

    }

    protected function V24(\Alae\Entity\Batch $Batch)
    {
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS1%' AND s.useRecord = 0 AND s.fkBatch = " . $Batch->getPkBatch());
        $counter = $query->getSingleScalarResult();

        if ($counter == 2)
        {
            $query = $this->getEntityManager()->createQuery("
                SELECT s.analyteConcentration
                FROM Alae\Entity\SampleBatch s
                WHERE s.sampleName LIKE 'CS2%' AND s.fkBatch = " . $Batch->getPkBatch() . "
                ORDER BY s.sampleName ASC")
                ->setMaxResults(1);
            $min = $query->getSingleScalarResult();

            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V24"));
            $where = "s.sampleType = 'Unknown' AND s.calculatedConcentration < $min AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0]);
        }

        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy" => $Batch->getFkStudy()
        ));

        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS" . $AnaStudy[0]->getCsNumber() . "%' AND s.useRecord = 0 AND s.fkBatch = " . $Batch->getPkBatch());
        $counter = $query->getSingleScalarResult();

        if ($counter == 2)
        {
            $query = $this->getEntityManager()->createQuery("
                SELECT s.analyteConcentration
                FROM Alae\Entity\SampleBatch s
                WHERE s.sampleName LIKE 'CS" . ($AnaStudy[0]->getCsNumber() - 1) . "%' AND s.fkBatch = " . $Batch->getPkBatch() . "
                ORDER BY s.sampleName DESC")
                ->setMaxResults(1);
            $max = $query->getSingleScalarResult();

            $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V24"));
            $where = "s.sampleType = 'Unknown' AND s.calculatedConcentration > $max AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0]);
        }
    }

    /**
     * V25: Basales cuantificables
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V25(\Alae\Entity\Batch $Batch)
    {  
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

                    $CalculatedConcentration = \Alae\Service\Conversion::conversion(
                        $AnaStudy->getFkUnit()->getName(),
                        $Batch->getcalculatedConcentrationUnits(),
                        //$Batch->getAnalyteConcentrationUnits(),
                        $cs_values[$i - 1]
                    );
                }
            }
        }

        $query    = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch
            FROM Alae\Entity\SampleBatch s
            WHERE REGEXP(s.sampleName, :regexp) = 1
            AND s.calculatedConcentration >= $CalculatedConcentration
            AND s.sampleType = 'Unknown'
            AND s.fkBatch = " . $Batch->getPkBatch() . "
            ORDER BY s.pkSampleBatch");

        $query->setParameter('regexp', '([0-9])+([0-9])-([0-9])+[.][0][1](-[0-9]+)?$');
        //$query->setParameter('regexp1', '([0-9])+([0-9])-([0-9])+(\\.01-[0-9])');
        $elements = $query->getResult();

        foreach($elements as $SampleName)
        {
            $where = "s.pkSampleBatch = " . $SampleName['pkSampleBatch'];
            $this->error($where, $parameters[0], array(), false);
        }
    }

    /**
     * V26: Tiempo de retención CS/QC (C2)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V26(\Alae\Entity\Batch $Batch)
    {
        $parameters  = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V26"));
        $parameters2 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V26.1"));
        
        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy"   => $Batch->getFkStudy()
        ));

        $minTretAna = $AnaStudy[0]->getRetention() - $AnaStudy[0]->getAcceptance() / 100 * $AnaStudy[0]->getRetention();
        $maxTretAna = $AnaStudy[0]->getRetention() + $AnaStudy[0]->getAcceptance() / 100 * $AnaStudy[0]->getRetention();

        $minTretIS = $AnaStudy[0]->getRetentionIS() - $AnaStudy[0]->getAcceptanceIs() / 100 * $AnaStudy[0]->getRetentionIS();
        $maxTretIS = $AnaStudy[0]->getRetentionIS() + $AnaStudy[0]->getAcceptanceIs() / 100 * $AnaStudy[0]->getRetentionIS();

        /*Toni: 01/08/2023 - Redondeamos todas los resultados anteriores a 2 decimales según reunión con Natalia y Elba.
        Este ajuste también se ha realizado en validaciones*/

        $minTretAna = round ($minTretAna, 2);
        $maxTretAna = round ($maxTretAna, 2);
        $minTretIS  = round ($minTretIS , 2);
        $maxTretIS  = round ($maxTretIS , 2);

        //Fin de los redondeos

        //$parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V26"));
        // Toni: Según mail de Natalia del día 08.12.2019, no se deberían evaluar para el control de tiempo de retención las muestras BLK
        // para conseguirlo, modificamos la primera parte del siguiente WHERE.
        
        $where = " (s.sampleName NOT LIKE 'BLK%' AND s.sampleType <> 'Solvent' AND s.isPeakArea <> 0 AND s.analytePeakArea <> 0) 
                    AND ((s.analyteRetentionTime NOT BETWEEN $minTretAna AND $maxTretAna) OR (s.isRetentionTime NOT BETWEEN $minTretIS AND $maxTretIS))
                   AND s.useRecord <> 1 AND s.fkBatch = " . $Batch->getPkBatch();
        
        $this->error($where, $parameters[0], array(), false);
        //Repetimos la condición con UseRecord=1 para en este caso SI ANULAR LOTE
        $where = " (s.sampleName NOT LIKE 'BLK%' AND s.sampleType <> 'Solvent' AND s.isPeakArea <> 0 AND s.analytePeakArea <> 0) 
                    AND ((s.analyteRetentionTime NOT BETWEEN $minTretAna AND $maxTretAna) OR (s.isRetentionTime NOT BETWEEN $minTretIS AND $maxTretIS))
                   AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch();
        
        //$this->error($where, $parameters2[0], array(), false); *
        $this->errorCurve($where, $parameters2[0], $Batch->getPkBatch(), array(), false);

/*
        $where2 = "(s.sampleName LIKE 'CS%' OR s.sampleName LIKE 'QC%') AND 
                   (s.analyteRetentionTime NOT BETWEEN $minTretAna AND $maxTretAna OR 
                    s.isRetentionTime NOT BETWEEN $minTretIS AND $maxTretIS)
                   AND s.useRecord != 0
                   AND s.fkBatch = " . $Batch->getPkBatch();
        
        $this->error($where2, $parameters2[0], array(), false);
*/
        /*$query = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch as pkSampleBatch, s.sampleName as sampleName, 
                   s.analyteRetentionTime as AnaRetentionTime, s.isRetentionTime as IsRetentionTime
            FROM Alae\Entity\SampleBatch s
            WHERE s.fkBatch = " . $Batch->getPkBatch());
        $elements = $query->getResult();

        if (count($elements) > 0)
        {
            foreach ($elements as $temp)
            {

                if($temp['AnaRetentionTime'] > $minTretAna && $temp['AnaRetentionTime'] < $maxTretAna)
                {
                    $centi = 0;
                }
                else
                {
                    $centi = 1;
                }

                //echo $temp['AnaRetentionTime']." ".$minTretAna." ".$maxTretAna;die();

                if($centi == 1)
                {
                    
                    $where = "s.pkSampleBatch = ".$temp['pkSampleBatch']."
                              AND s.fkBatch = " . $Batch->getPkBatch();

                    $this->error($where, $parameters[0]);
                }
            }
        }*/
    }
}
