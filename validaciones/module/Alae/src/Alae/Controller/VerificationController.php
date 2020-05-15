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

            //******** VERIFICAR SI LOS VALORES NOMINALES ESTAN PUESTOS */
            $elements = $this->getRepository("\\Alae\\Entity\\BatchNominal")->findBy(array("fkBatch" => $Batch->getPkBatch()));
            $centi = 0;
            foreach ($elements as $nominal)
            {
                $value = $nominal->getAnalyteConcentration();
                
                if(!isset($value))
                {
                    $centi++;
                }
            }

            if ($centi == 0)
            {
                for ($i = 5; $i < 12; $i++)
                {
                    $function = 'V' . $i;
                    $this->$function($Batch);
                }
                
                $response = $this->V12($Batch); //Llama a V12 para ver si debe mostrar la venta emergente. Si response es TRUE hace el resto de verificaciones V13_23, sino, ventana emergente

                if ($response)
                {
                    //$this->V13($Batch);
                    $this->V13_23($Batch);
                }
                else
                {
                    //Este return ejecuta la VENTANA EMERGENTE 
                    return $this->redirect()->toRoute('verification', array(
                        'controller' => 'verification',
                        'action'     => 'error',
                        'id'         => $Batch->getPkBatch()
                    ));
                }
            }
            else
            {
                $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
                    "fkAnalyte" => $Batch->getFkAnalyte(),
                    "fkStudy" => $Batch->getFkStudy()
                ));
                
                return $this->redirect()->toRoute('batch', array(
                    'controller' => 'batch',
                    'action'     => 'list',
                    'id'         => $AnaStudy[0]->getPkAnalyteStudy(),
                    'an'         => 1
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

        //ESTA QUERY DEBE COINCIDIR CON LA QUERY COUNT de la V12

        $query   = $this->getEntityManager()->createQuery("
        SELECT s.pkSampleBatch, s.fileName, s.sampleName, s.accuracy, s.useRecord
        FROM Alae\Entity\SampleBatch s
        WHERE s.fkBatch = " . $Batch->getPkBatch() . " AND (s.sampleName NOT LIKE '%R%*') 
            AND (
                ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                OR (s.sampleType LIKE 'Standard' AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                OR (s.sampleType LIKE 'Quality Control' AND s.sampleName NOT LIKE 'LLOQ%' AND s.sampleName NOT LIKE 'LLQC%' AND s.sampleName NOT LIKE 'TZ%' AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                OR (s.sampleName LIKE 'TZ%' AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
            )");
        //$query->setParameter('regexp1', '^CS[0-9]+(-[0-9]+)?$');
        //$query->setParameter('regexp2', '^QC[0-9]+(-[0-9]+)?$');
        //$query->setParameter('regexp3', '^((L|H)?DQC)[0-9]+(-[0-9]+)?$');
        
        /*
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
        */

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
                        if ($request->getPost('reason_'.$pkSampleBatch) == "V12.9")
                        {
                            $this->evaluation($Batch, false, $parameters[0]);
                        }
                    
                        $where = "s.fkBatch = " . $Batch->getPkBatch() . "
                        AND s.pkSampleBatch = " . $pkSampleBatch . "
                        AND (
                                ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy NOT BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 1)
                                OR (s.sampleType LIKE 'Standard' AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                                OR (s.sampleType LIKE 'Quality Control' AND s.sampleName NOT LIKE 'LLOQ%' AND s.sampleName NOT LIKE 'LLQC%' AND s.sampleName NOT LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                                OR (s.sampleName LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)

                                OR ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                                OR (s.sampleType LIKE 'Standard' AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                                OR (s.sampleType LIKE 'Quality Control' AND s.sampleName NOT LIKE 'LLOQ%' AND s.sampleName NOT LIKE 'LLQC%' AND s.sampleName NOT LIKE 'TZ%' AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                                OR (s.sampleName LIKE 'TZ%' AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
                            )";


/*
                                OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                                OR (REGEXP(s.sampleName, :regexp4) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy NOT BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 1)
                                OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                                OR (REGEXP(s.sampleName, :regexp5) = 1 AND s.accuracy NOT BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 1)
                                OR (s.sampleName LIKE 'TZ%' AND s.accuracy NOT BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 1)
                                OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy NOT BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 1)
                                OR (s.sampleName LIKE 'ULQC%' AND s.accuracy NOT BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 1)

                                OR ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                                OR (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                                OR (REGEXP(s.sampleName, :regexp4) = 1 AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                                OR (REGEXP(s.sampleName, :regexp2) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                                OR (REGEXP(s.sampleName, :regexp5) = 1 AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                                OR (s.sampleName LIKE 'TZ%' AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
                                OR (REGEXP(s.sampleName, :regexp3) = 1 AND s.accuracy BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 0)
                                OR (s.sampleName LIKE 'ULQC%' AND s.accuracy BETWEEN " . $min5 . " AND " . $max5 . " AND s.useRecord = 0)
                            )";
*/
//                        $this->error($where, $parameters[0], array('regexp1' => '^CS[0-9]+(-[0-9]+)?$','regexp2' => '^QC[0-9]+(-[0-9]+)?$','regexp3' => '^((LD|HD|UL)?QC)[0-9]+(-[0-9]+)?$'), false);
                        $this->error($where, $parameters[0]);
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
        //echo 'paso1';
        $sql = "
            SELECT s
            FROM Alae\Entity\SampleBatch s
            WHERE $where";
        
        $query = $this->getEntityManager()->createQuery($sql);
        //echo '- Paso2 - countParameters = ' . count($parameters);
        if(count($parameters) > 0)
            foreach ($parameters as $key => $value)
                //echo $key . '-' . $value;
                $query->setParameter($key, $value);
                //echo $query;
        $elements = $query->getResult();
        //echo $elements . '-'; //************* */
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
        /*
        $where = "
        (

            (s.sampleName LIKE 'SEL%' AND s.sampleType <> 'Blank') OR
            (s.sampleName LIKE 'ZS-BC%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE 'ZS-NT%' AND s.sampleType <> 'Unknown') OR

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
            (s.sampleName LIKE '%ME%' AND s.sampleType <> 'Quality Control') OR
            (REGEXP(s.sampleName, :regexp1) = 1 AND s.sampleType <> 'Solvent') OR
            (REGEXP(s.sampleName, :regexp2) = 1 AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%EGC%' AND s.sampleType <> 'Solvent') OR
            (s.sampleName LIKE '%ES%' AND s.sampleType <> 'Solvent') OR
            (s.sampleName LIKE '%SCAx%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%SCBx%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%ULOQ%' AND s.sampleType <> 'Unknown') OR
            (s.sampleName LIKE '%RSQC%' AND s.sampleType <> 'Unknown') 
        ) AND s.fkBatch = " . $Batch->getPkBatch();
        */
        //Toni: 14/01/2020 Cambiamos el enfoque de $Where. El objetivo es identificar las muestras de la tabla de los requerimientos
        
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
                                            s.sampleName LIKE 'ES%' OR
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
        
        

        $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V5"));
        //echo 'V5 antes this ' . $where;
        
        $this->error($where, $fkParameter[0]);
    }

    /**
     * V6: Concentración nominal de CS/QC - CONCENTRACIÓN NOMINAL ERRÓNEA
     * @param \Alae\Entity\Batch $Batch
	 * CambioToni sin importancia (comentario)
     */
    protected function V6(\Alae\Entity\Batch $Batch)
    {
        $elements = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array("fkStudy" => $Batch->getFkStudy(), "fkAnalyte" => $Batch->getFkAnalyte()));

        //cs, etc
        foreach ($elements as $AnaStudy)
        {
            $cs_values = explode(",", $AnaStudy->getCsValues());
            $qc_values = explode(",", $AnaStudy->getQcValues());

            //CS
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

            //QC
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

            //LDQC
            $valueLDQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getLdqcValues()
            );

            $where = "s.sampleName LIKE 'LDQC%' AND s.analyteConcentration <> " . $valueLDQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
            $this->error($where, $fkParameter[0]);
            //LDQC

            //HDQC
            $valueHDQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getHdqcValues()
            );

            $where = "s.sampleName LIKE 'HDQC%' AND s.analyteConcentration <> " . $valueHDQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
            $this->error($where, $fkParameter[0]);
            //HDQC

            //LLQC
            $valueLLQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getLlqcValues()
            );

            $where = "s.sampleName LIKE 'LLQC%' AND s.analyteConcentration <> " . $valueLLQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
            $this->error($where, $fkParameter[0]);
            //LLQC

            //ULQC
            $valueULQC = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $AnaStudy->getUlqcValues()
            );

            $where = "s.sampleName LIKE 'ULQC%' AND s.analyteConcentration <> " . $valueULQC . " AND s.fkBatch = " . $Batch->getPkBatch();
            $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
            $this->error($where, $fkParameter[0]);
            //ULQC
        }
        //fin cs, etc

        //SampleVerificationStudy
        $elements = $this->getRepository("\\Alae\\Entity\\SampleVerificationStudy")->findBy(array("fkAnalyteStudy" => $AnaStudy->getPkAnalyteStudy()));
        
        foreach ($elements as $sample)
        {
            //$elements = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array("fkStudy" => $Batch->getFkStudy(), "fkAnalyte" => $Batch->getFkAnalyte()));

            /*$first = substr($sample->getAssociated(), 0, 2); 
            $last = substr($sample->getAssociated(), -1);*/ 
            $valueAssoc = $sample->getValue();
            $sample1 = $sample->getName();

            $value = \Alae\Service\Conversion::conversion(
                $AnaStudy->getFkUnit()->getName(),
                $Batch->getAnalyteConcentrationUnits(),
                $valueAssoc
            );
            
            /*if($first == 'CS')
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
            }*/
            
            $where = "s.sampleName LIKE '$sample1%' AND s.sampleName NOT LIKE '%NT%' AND s.sampleName NOT LIKE '%BC%' AND s.analyteConcentration <> " . $value . " AND s.fkBatch = " . $Batch->getPkBatch();
                    $fkParameter = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V6"));
                    $this->error($where, $fkParameter[0]);
        }
        //fin SampleVerificationStudy

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
            SELECT s.pkSampleBatch, SUBSTRING(s.sampleName, 1, 4) as sampleNameTemp,  COUNT(s.pkSampleBatch) as counter
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'CS%' AND s.fkBatch = " . $Batch->getPkBatch() . "
            GROUP BY sampleNameTemp
            HAVING counter < " . $parameters[0]->getMinValue());
        $elements   = $query->getResult();
        
        if (count($elements) > 0)
        {
            // echo 'PASO POR AQUI = ' . count($elements);
            // die();
            $pkSampleBatch = array();
            foreach ($elements as $temp)
            {
                $pkSampleBatch[] = $temp["pkSampleBatch"];
            }
            
            if(count($pkSampleBatch) > 0)
            {
                $where = "s.pkSampleBatch IN (" . implode(",", $pkSampleBatch) . ")";
               // echo 'where = ' . $where;
                $this->error($where, $parameters[0]);
            }
        }
        //die();
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V7.2"));
        $query      = $this->getEntityManager()->createQuery("
            SELECT s.pkSampleBatch, SUBSTRING(s.sampleName, 1, 4) as sampleNameTemp,  COUNT(s.pkSampleBatch) as counter
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'QC%' AND s.fkBatch = " . $Batch->getPkBatch() . "
            GROUP BY sampleNameTemp
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
                    $this->error($where, $parameters2[0], array(), false);
                }
                //echo 'Centi 91 calculos -> ' . $centi91 . ' // centi92 UseRecord == 0 ->' . $centi92;
                if($centi91 == "S" || $centi92 == "S")
                {
                    $where = "s.sampleName = '" . $temp['sampleName'] . "' AND s.fkBatch = " . $Batch->getPkBatch();
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
    protected function V10(\Alae\Entity\Batch $Batch)
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


        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.3"));
        $where      = "(REGEXP(s.sampleName, :regexp) = 1) AND s.accuracy NOT BETWEEN " . $parameters[0]->getMinValue() . " AND " . $parameters[0]->getMaxValue() . " AND s.fkBatch = " . $Batch->getPkBatch();
        //$this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+(-[0-9]+)?$'), false);
        $this->error($where, $parameters[0], array('regexp' => '^QC[0-9]+(-[0-9]+(R[0-9]+)?)?$'), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V10.3"));
        $where      = "(s.sampleType = 'Quality Control' AND 
                        (s.sampleName LIKE 'ULQC%' OR
                        s.sampleName LIKE 'AS%' OR
                        s.sampleName LIKE 'TZ%' OR
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
                            (s.sampleName LIKE 'ULQC%' OR
                            s.sampleName LIKE 'AS%' OR
                            s.sampleName LIKE 'TZ%' OR
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
            $this->error($where, $parameters[0], array(), false);
        }
    }

    /**
     * V12: Use record (CS/QC/DQC)
     * @param \Alae\Entity\Batch $Batch
     * 
     * Toni: 2 de abril de 2020
     * V12 debe comprobar que si una muestra cumple Accuracy(V10), su UseRecord DEBE SER 1
     * En caso de que una muestra NO CUMPLA ACCURACY, su UseRecord DEBE SER 0
     * Si por el motivo que sea, una muestra cumple ACCURACY, pero tiene UseRecord = 0, debe aparecer una ventana emergente donde especificar el motivo.
     * Esta función V12 lo que está mirando es CUANTAS MUESTRAS aparecerán en la ventana emergente.
     * La función ejecuta un SELECT COUNT para ver si el numero de muestras a mostrar en la ventana emergente es MAYOR que 0
     * El return devuelve FALSE si el numero de muestras en MAYOR que 0 y por tanto DEBE mostrar la ventana emergente, sino retorna TRUE que significa que NO debe mostrar la ventana emergente.
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
/*
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
*/
        /*REAJUSTADO DE CONDICION HABLADO CON NATALIA el 16/03/2020
            Deben saltar las muestras que:
                * CS1, LLOQ, LLQC tengan Accuracy entre 80-120 con UseRecord=0
                * Todos los SampleType = Standard que no sean CS1 entre 85 y 115 con useRecord = 0
                * Todos los SampleType = Quality Control menos los LLQC, LLOQ y TZ entre 85 y 115 con useRecord = 0
                * Los sampleName = TZ entre 90 y 110 con useRecord = 0
        *******************************************************************************************************************************************************
        NOTA: Los criterios de la Query siguiente, son los mismos criterios que debemos aplicar en errorAction() ->Filas 125 de este fichero 
        Parece que esta query de abajo es para contar y la de arriba errorAction() es para mostrar el desplegable
        *******************************************************************************************************************************************************
        */
        $query   = $this->getEntityManager()->createQuery("
        SELECT COUNT(s.pkSampleBatch) as counter
        FROM Alae\Entity\SampleBatch s
        WHERE s.fkBatch = " . $Batch->getPkBatch() . " AND (s.sampleName NOT LIKE '%R%*') 
            AND (
                ((s.sampleName LIKE 'CS1%' OR s.sampleName LIKE 'LLOQ%' OR s.sampleName LIKE 'LLQC%') AND s.accuracy BETWEEN " . $min1  . " AND " . $max1 . " AND s.useRecord = 0)
                OR (s.sampleType LIKE 'Standard' AND s.sampleName NOT LIKE 'CS1%' AND s.accuracy BETWEEN " . $min2 . " AND " . $max2 . " AND s.useRecord = 0)
                OR (s.sampleType LIKE 'Quality Control' AND s.sampleName NOT LIKE 'LLOQ%' AND s.sampleName NOT LIKE 'LLQC%' AND s.sampleName NOT LIKE 'TZ%' AND s.accuracy BETWEEN " . $min3 . " AND " . $max3 . " AND s.useRecord = 0)
                OR (s.sampleName LIKE 'TZ%' AND s.accuracy BETWEEN " . $min4 . " AND " . $max4 . " AND s.useRecord = 0)
            )");
        //$query->setParameter('regexp1', '^CS[0-9]+(-[0-9]+)?$');
        //$query->setParameter('regexp2', '^QC[0-9]+(-[0-9]+)?$');
        //$query->setParameter('regexp3', '^((L|H)?DQC)[0-9]+(-[0-9]+)?$');

        return $query->getSingleScalarResult() > 0 ? false : true; // Si encuentra algo para mostrar en la ventana emergente, retorna FALSE, sino TRUE
    }
    // FIN DEL REAJUSTADO HABLADO CON NATALIA EL 16/03/2020

    /**
     * V13: Tiempo de retención CS/QC (C2)
     * @param \Alae\Entity\Batch $Batch
     */
    protected function V13(\Alae\Entity\Batch $Batch)
    {
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.1"));
        $parameters2 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.2"));

        //Toni: 14-01-2020 Agregamos v13.3 que estaba en el documento de usr
        //$parameters3 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V13.3"));
        
        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->findBy(array(
            "fkAnalyte" => $Batch->getFkAnalyte(),
            "fkStudy"   => $Batch->getFkStudy()
        ));

        $Study = $this->getRepository("\\Alae\\Entity\\Study")->findBy(array(
            "pkStudy"   => $Batch->getFkStudy()
        ));

        //SI ES VALIDACION PARCIAL
        /*
            Hola Victor, esta condición tiene algo raro porque SIEMPRE devuelve 1 cuando en la tabla Study
            el campo validación para el estudio 3126 es 0.
            He hecho pruebas con echo y die y getValidation devuelve 1 cuando debería dar 0
            Estoy casi convencido que esa función no devuelve el campo correcto, pero no se donde va a buscarlo
        */
        if($Study[0]->getVerification() == 1)
        {

            $min = $AnaStudy[0]->getRetention() - ($AnaStudy[0]->getAcceptance() * $AnaStudy[0]->getRetention() / 100);
            $max = $AnaStudy[0]->getRetention() + ($AnaStudy[0]->getAcceptance() * $AnaStudy[0]->getRetention() / 100);

            $min_is = $AnaStudy[0]->getRetentionIs() - ($AnaStudy[0]->getAcceptanceIs() * $AnaStudy[0]->getRetentionIs() / 100);
            $max_is = $AnaStudy[0]->getRetentionIs() + ($AnaStudy[0]->getAcceptanceIs() * $AnaStudy[0]->getRetentionIs() / 100);

            // Toni: Añado al condicional $where la condicion de que no evalue SampleName BLK según mail y nota de NATALIA del 8 de diciembre de 2019
            /*
            $where = " (s.sampleName <> 'BLK' AND s.sampleType != 'Solvent' AND s.analyteRetentionTime NOT BETWEEN $min AND $max OR 
                        s.isRetentionTime NOT BETWEEN $min_is AND $max_is)
                    AND s.fkBatch = " . $Batch->getPkBatch();
            
            */
            
            
            /*
                Toni: 26-03-2020, se deben evaluar todas las muestras excepto:
                -	muestras cuyo Sample Type sea = Solvent
                -	muestras cuyo Sample Name empieza por BLK o SEL
                -	muestras cuyo Sample Name empieza por CO_BLK, CC_BLK y LL_BLK 
                -	muestras cuyo valor en las columnas Analyte Peak Area o IS Peak Area sea = 0.
            */
            $where = "(s.sampleType <> 'Solvent') 
                    AND
                    (
                        s.sampleName NOT LIKE 'BLK%' AND
                        s.sampleName NOT LIKE 'SEL%' AND
                        s.sampleName NOT LIKE 'CO_BLK%' AND
                        s.sampleName NOT LIKE 'CC_BLK%' AND
                        s.sampleName NOT LIKE 'LL_BLK%'
                    )
                    AND 
                    (
                        s.isPeakArea <> 0 AND
                        s.analytePeakArea <> 0
                    )
                    AND
                    (
                        s.analyteRetentionTime NOT BETWEEN $min AND $max OR s.isRetentionTime NOT BETWEEN $min_is AND $max_is
                    )
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

            /* No ejecutamos esta condición porque queda incluida en la condición que determina el 13.1
            //Toni: 14/1/2020 - Agrego condición 13.3 para descargar muestras con analytePeakArea = 0 OR isPeakArea = 0
            $where3 = " (s.analytePeakArea = 0 OR s.isPeakArea = 0) 
                        AND s.fkBatch = " . $Batch->getPkBatch();

            $this->error($where3, $parameters3[0], array(), false);
          */
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
            WHERE (s.sampleName LIKE 'CS%' OR s.sampleName LIKE 'QC%' OR 
                   s.sampleName LIKE 'LLQC%' OR 
                   s.sampleName LIKE 'ULQC%') 
                   AND 
                   (s.sampleName NOT LIKE  '%\*%' OR 
                   s.sampleName NOT LIKE  'HDQC%' OR 
                   s.sampleName NOT LIKE  'LDQC%') 
                   AND s.validFlag <> 0 AND s.useRecord = 1 AND s.fkBatch = " . $Batch->getPkBatch());
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

        //21.01.2020 - Según mail de Natalia, cambiamos requisito: CO-BL, CC-BL y LL-BL por CO_BLK, CC_BLK y LL_BLK

        $where = "
        (s.sampleName NOT LIKE 'BLK%' AND s.sampleName NOT LIKE 'SEL%' AND 
        s.sampleName NOT LIKE 'CO_BLK%' AND s.sampleName NOT LIKE 'CC_BLK%' AND s.sampleName NOT LIKE 'LL_BLK%') 
		AND s.sampleType <> 'Solvent' AND s.isPeakArea < $value 
        AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters2 = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V14.2"));
        
        $where2 = "
        (s.sampleName NOT LIKE 'BLK%' AND s.sampleName NOT LIKE 'SEL%' AND 
        s.sampleName NOT LIKE 'CO_BLK%' AND s.sampleName NOT LIKE 'CC_BLK%' AND s.sampleName NOT LIKE 'LL_BLK%')   
        AND s.sampleType <> 'Solvent' AND s.isPeakArea < $value
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
        $where      = "s.sampleName LIKE 'BLK%' AND s.analytePeakArea >= " . ($analytePeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V15.3"));
        $where      = "s.sampleName LIKE 'BLK%' AND s.isPeakArea >= " . ($isPeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);

        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V15.4"));
        $where      = "s.sampleName LIKE 'ZS%' AND s.sampleName NOT LIKE 'ZS_NT%' AND s.sampleName NOT LIKE 'ZS_BC%' AND s.analytePeakArea >= " . ($analytePeakArea * ($parameters[0]->getMinValue() / 100)) . " AND s.fkBatch = " . $Batch->getPkBatch();
        $this->error($where, $parameters[0], array(), false);
    }

    protected function V16(\Alae\Entity\Batch $Batch)
    {
        //En realidad la V16 del documento funcional no es una Verificación, simplemente es información de datos que debemos tener para calcular otras verificaciones
        //y así se hace (son datos que se almacenan en la tabla Batch y se calculan en la V15)
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
    /* 
    protected function V21(\Alae\Entity\Batch $Batch)
    {
        if($Batch->getQcTotal() != 0)
        {
                echo 'getQcTotal:= ' . $Batch->getQcTotal();
                echo ' - getQcAcceptedTotal := ' . $Batch->getQcAcceptedTotal();
            $value      = ($Batch->getQcAcceptedTotal() / $Batch->getQcTotal()) * 100;
                echo ' - VALUE := ' . $value;
                die();
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
    */

    protected function V21(\Alae\Entity\Batch $Batch)
    {
        //Empezamos obteniendo el número total de QC's a contar los QC's + LLQC + ULQC y no Reinjecciones (*)
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch) 
            FROM Alae\Entity\SampleBatch s
            WHERE ((s.sampleName like 'QC%' OR s.sampleName like 'LLQC%' or s.sampleName like 'ULQC%') AND s.sampleName NOT LIKE '%*%') AND s.isUsed = 1 AND s.fkBatch = " . $Batch->getPkBatch() . "
            ");
        $qc_total = $query->getSingleScalarResult();
        
        //Ahora contamos los QC's válidos
        $query = $this->getEntityManager()->createQuery("
        SELECT COUNT(s.pkSampleBatch) 
        FROM Alae\Entity\SampleBatch s
        WHERE ((s.sampleName like 'QC%' OR s.sampleName like 'LLQC%' or s.sampleName like 'ULQC%') AND s.sampleName NOT LIKE '%*%') AND s.isUsed = 1 AND s.validFlag = 1 AND s.fkBatch = " . $Batch->getPkBatch() . "
        ");
        $qc_totalAccepted = $query->getSingleScalarResult();

        $value = $qc_totalAccepted/$qc_total * 100;

        //echo 'QC TOTAL = ' . $qc_total . ' - QC Aceptados = ' . $qc_totalAccepted . ' - Valor = ' . $value;
        //die();
        $parameters = $this->getRepository("\\Alae\\Entity\\Parameter")->findBy(array("rule" => "V21"));
        if ($value < $parameters[0]->getMinValue())
        {
            $where = "((s.sampleName like 'QC%' OR s.sampleName like 'LLQC%' or s.sampleName like 'ULQC%') AND s.sampleName NOT LIKE '%*%') AND s.isUsed = 1 AND s.fkBatch = " . $Batch->getPkBatch();
            $this->error($where, $parameters[0]);
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
            WHERE (s.sampleName like 'QC%' OR s.sampleName like 'LLQC%' or s.sampleName like 'ULQC%')  AND s.isUsed = 1 AND s.fkBatch = " . $Batch->getPkBatch() . "
            GROUP BY sample_name
            ORDER BY sample_name ASC");
        $elements = $query->getResult();

        foreach ($elements as $qc)
        {
            $query = $this->getEntityManager()->createQuery("
                SELECT COUNT(s.pkSampleBatch)
                FROM Alae\Entity\SampleBatch s
                WHERE s.sampleName LIKE '" . $qc['sample_name'] . "%' AND s.isUsed = 1 AND s.sampleName NOT LIKE '%*%' AND s.fkBatch = " . $Batch->getPkBatch()
            );
            $qc_total = $query->getSingleScalarResult();

            $query = $this->getEntityManager()->createQuery("
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
            WHERE s.sampleName LIKE 'ZS%' AND s.sampleName NOT LIKE 'ZS_NT%' AND s.sampleName NOT LIKE 'ZS_BC%' AND s.fkBatch = " . $Batch->getPkBatch()
        );
        $zs_total = $query->getSingleScalarResult();
        $query = $this->getEntityManager()->createQuery("
            SELECT COUNT(s.pkSampleBatch)
            FROM Alae\Entity\SampleBatch s
            WHERE s.sampleName LIKE 'ZS%' AND s.sampleName NOT LIKE 'ZS_NT%' AND s.sampleName NOT LIKE 'ZS_BC%' AND s.validFlag <> 0 AND s.fkBatch = " . $Batch->getPkBatch()
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
                $where = "s.sampleName LIKE 'ZS%' AND s.sampleName NOT LIKE 'ZS_NT%' AND s.sampleName NOT LIKE 'ZS_BC%' AND s.fkBatch = " . $Batch->getPkBatch();
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
