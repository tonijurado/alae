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
 * Fecha de creación: 16/05/2014
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
        $elements = $this->getRepository()->findBy(array("status" => true, "closeFlag" => 0), array("code" => 'desc'));
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
                    if($request->getPost('validation') == 0)
                    {
                        $validation = "Total";
                    }
                    else
                    {
                        $validation = "Parcial";
                    }
                    if($request->getPost('verification'))
                    {
                        $verification = "Sí";
                    }
                    else
                    {
                        $verification = "No";
                    }
                    //echo substr($request->getPost('code'), -1)." ".$request->getPost('validation')." ".$request->getPost('verification');die();
                    //CREA EL ESTUDIO
                    $Study = new \Alae\Entity\Study();
                    $Study->setCode($request->getPost('code'));
                    $Study->setValidation($request->getPost('validation'));
                    
                    if($request->getPost('verification'))
                    {
                        $Study->setVerification(1);
                    }
                    else
                    {
                        $Study->setVerification(0);
                    }
                    
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
                        sprintf('El usuario %1$s ha creado el estudio %2$s - Código: %2$s, Validación: %3$s, Verificación V13: %4$s, Descripción: %5$s, Observaciones: %6$s, Fecha de creación: %7$s',
                            $User->getUsername(),
                            $Study->getCode(),
                            $validation,
                            $verification,
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

        if(isset($_GET['state']))
        {
            $state = $_GET['state'];
        }
        else
        {
            $state = 'open';
        }

		$mostrarConfirmar = false;
        $request = $this->getRequest();

        if ($this->getEvent()->getRouteMatch()->getParam('id'))
        {
            $Study        = $this->getRepository()->find($this->getEvent()->getRouteMatch()->getParam('id'));
            $canEdit      = ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio()) && !$Study->getCloseFlag() && !$Study->getApprove();
            $verification = $Study->getVerification();
            $validation   = $Study->getValidation();
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

            $updateAnalyte      = $request->getPost('update-analyte');
            $updateAnalyteIs    = $request->getPost('update-analyte_is');
            $updateCsNumber  = $request->getPost('update-cs_number');
            $updateQcNumber  = $request->getPost('update-qc_number');
            $updateUnit      = $request->getPost('update-unit');
            if($validation == 0)
            {
                
            }
            else
            {
                if($verification == 1)
                {
                    $createRetention    = $request->getPost('create-retention');
                    $createAcceptance   = $request->getPost('create-acceptance');
                    $createRetentionIs  = $request->getPost('create-retention_is');
                    $createAcceptanceIs = $request->getPost('create-acceptance_is');
                    $updateRetention    = $request->getPost('update-retention');
                    $updateAcceptance   = $request->getPost('update-acceptance');
                    $updateRetentionIs  = $request->getPost('update-retention_is');
                    $updateAcceptanceIs = $request->getPost('update-acceptance_is');    
                }
                else
                {
                    
                }
            }

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

                        if($validation == 0)
                        {
                            $newer = sprintf('El usuario %1$s ha agregado el analito %2$s(%3$s) al estudio %4$s.<br>Patrón Interno (IS): %5$s, Núm CS: %6$s, Núm QC: %7$s, Unidades: %8$s',
                                    $User->getUsername(),
                                    $Analyte->getName(),
                                    $Analyte->getShortening(),
                                    $Study->getCode(),
                                    $AnalyteIs->getName(),
                                    $createCsNumber[$key],
                                    $createQcNumber[$key],
                                    $Unit->getName()
                                );
                        }
                        else
                        {
                            if($verification == 1)
                            {
                                $AnaStudy->setRetention($createRetention[$key]);
                                $AnaStudy->setAcceptance($createAcceptance[$key]);
                                $AnaStudy->setRetentionIs($createRetentionIs[$key]);
                                $AnaStudy->setAcceptanceIs($createAcceptanceIs[$key]);

                                $newer =  sprintf('El usuario %1$s ha agregado el analito %2$s(%3$s) al estudio %4$s.<br>Patrón Interno (IS): %5$s, Núm CS: %6$s, Núm QC: %7$s, Unidades: %8$s, Tiempo retención: %9$s,Margen de aceptación: %10$s,Tiempo retención IS: %11$s,Margen de aceptación IS: %12$s',
                                    $User->getUsername(),
                                    $Analyte->getName(),
                                    $Analyte->getShortening(),
                                    $Study->getCode(),
                                    $AnalyteIs->getName(),
                                    $createCsNumber[$key],
                                    $createQcNumber[$key],
                                    $Unit->getName(),
                                    $createRetention[$key],
                                    $createAcceptance[$key],
                                    $createRetentionIs[$key],
                                    $createAcceptanceIs[$key]
                                ); 
                            }
                            else
                            {
                                $newer = sprintf('El usuario %1$s ha agregado el analito %2$s(%3$s) al estudio %4$s.<br>Patrón Interno (IS): %5$s, Núm CS: %6$s, Núm QC: %7$s, Unidades: %8$s',
                                    $User->getUsername(),
                                    $Analyte->getName(),
                                    $Analyte->getShortening(),
                                    $Study->getCode(),
                                    $AnalyteIs->getName(),
                                    $createCsNumber[$key],
                                    $createQcNumber[$key],
                                    $Unit->getName()
                                );
                            }
                        }
                        
                        $AnaStudy->setStatus(false);
                        $AnaStudy->setFkUser($User);
                        $this->getEntityManager()->persist($AnaStudy);
                        $this->getEntityManager()->flush();
                        $this->transaction(
                            "Asociar analitos a estudio",
                            sprintf('%1$s',
                                $newer
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
                            $Analyte   = $this->getRepository('\\Alae\\Entity\\Analyte')->find($updateAnalyte[$key]);
                            $AnalyteIs = $this->getRepository('\\Alae\\Entity\\Analyte')->find($updateAnalyteIs[$key]);
                            $Unit      = $this->getRepository('\\Alae\\Entity\\Unit')->find($updateUnit[$key]);

                            if($validation == 0)
                            {
                                $older =  sprintf('Valores antiguos -> Analito: %1$s, Patrón Interno IS: %2$s, Núm CS: %3$s, Núm QC: %4$s, Unidad: %5$s',
                                        $AnaStudy->getFkAnalyte()->getShortening(),
                                        $AnaStudy->getFkAnalyteIs()->getShortening(),
                                        $AnaStudy->getCsNumber(),
                                        $AnaStudy->getQcNumber(),
                                        $AnaStudy->getFkUnit()->getName()
                                    );  

                                    $AnaStudy->setFkAnalyte($Analyte);
                                    $AnaStudy->setFkAnalyteIs($AnalyteIs);
                                    $AnaStudy->setCsNumber($updateCsNumber[$key]);
                                    $AnaStudy->setQcNumber($updateQcNumber[$key]);
                                    $AnaStudy->setFkUnit($Unit);

                                    $this->getEntityManager()->persist($AnaStudy);
                                    $this->getEntityManager()->flush();

                                    $newer =  sprintf('Valores nuevos -> Analito: %1$s, Patrón Interno IS: %2$s, Núm CS: %3$s, Núm QC: %4$s, Unidad: %5$s',
                                        $Analyte->getShortening(),
                                        $AnalyteIs->getShortening(),
                                        $updateCsNumber[$key],
                                        $updateQcNumber[$key],
                                        $Unit->getName()
                                    );
                                
                            }
                            else
                            {
                                if($verification == 1)
                                {
                                    $older =  sprintf('Valores antiguos -> Analito: %1$s, Patrón Interno IS: %2$s, Núm CS: %3$s, Núm QC: %4$s, Unidad: %5$s, Tiempo retención analito: %6$s,Margen de aceptación: %7$s,Tiempo retención IS: %8$s,Margen de aceptación IS: %9$s',
                                        $AnaStudy->getFkAnalyte()->getShortening(),
                                        $AnaStudy->getFkAnalyteIs()->getShortening(),
                                        $AnaStudy->getCsNumber(),
                                        $AnaStudy->getQcNumber(),
                                        $AnaStudy->getFkUnit()->getName(),
                                        $AnaStudy->getRetention(),
                                        $AnaStudy->getAcceptance(),
                                        $AnaStudy->getRetentionIs(),
                                        $AnaStudy->getAcceptanceIs()
                                    );  

                                    $AnaStudy->setFkAnalyte($Analyte);
                                    $AnaStudy->setFkAnalyteIs($AnalyteIs);
                                    $AnaStudy->setCsNumber($updateCsNumber[$key]);
                                    $AnaStudy->setQcNumber($updateQcNumber[$key]);
                                    $AnaStudy->setFkUnit($Unit);
                                    $AnaStudy->setRetention($updateRetention[$key]);
                                    $AnaStudy->setAcceptance($updateAcceptance[$key]);
                                    $AnaStudy->setRetentionIs($updateRetentionIs[$key]);
                                    $AnaStudy->setAcceptanceIs($updateAcceptanceIs[$key]);

                                    $this->getEntityManager()->persist($AnaStudy);
                                    $this->getEntityManager()->flush();

                                    $newer =  sprintf('Valores nuevos -> Analito: %1$s, Patrón Interno IS: %2$s, Núm CS: %3$s, Núm QC: %4$s, '
                                    .'Unidad: %5$s, Tiempo retención: %6$s,Margen de aceptación: %7$s, Tiempo retención IS: %8$s, Margen de aceptación IS: %9$s',
                                        $Analyte->getShortening(),
                                        $AnalyteIs->getShortening(),
                                        $updateCsNumber[$key],
                                        $updateQcNumber[$key],
                                        $Unit->getName(),
                                        $updateRetention[$key],
                                        $updateAcceptance[$key],
                                        $updateRetentionIs[$key],
                                        $updateAcceptanceIs[$key]
                                    ); 
                                }
                                else
                                {
                                    $older =  sprintf('Valores antiguos -> Analito: %1$s, Patrón Interno IS: %2$s, Núm CS: %3$s, Núm QC: %4$s, Unidad: %5$s',
                                        $AnaStudy->getFkAnalyte()->getShortening(),
                                        $AnaStudy->getFkAnalyteIs()->getShortening(),
                                        $AnaStudy->getCsNumber(),
                                        $AnaStudy->getQcNumber(),
                                        $AnaStudy->getFkUnit()->getName()
                                    );  

                                    $AnaStudy->setFkAnalyte($Analyte);
                                    $AnaStudy->setFkAnalyteIs($AnalyteIs);
                                    $AnaStudy->setCsNumber($updateCsNumber[$key]);
                                    $AnaStudy->setQcNumber($updateQcNumber[$key]);
                                    $AnaStudy->setFkUnit($Unit);

                                    $this->getEntityManager()->persist($AnaStudy);
                                    $this->getEntityManager()->flush();

                                    $newer =  sprintf('Valores nuevos -> Analito: %1$s, Patrón Interno IS: %2$s, Núm CS: %3$s, Núm QC: %4$s, Unidad: %5$s',
                                        $Analyte->getShortening(),
                                        $AnalyteIs->getShortening(),
                                        $updateCsNumber[$key],
                                        $updateQcNumber[$key],
                                        $Unit->getName()
                                    );
                                }
                            }
                            
                            $this->transaction(
                                "Edición de analitos asociados a estudio",
                                sprintf('El usuario %1$s ha editado la información del analito %2$s(%3$s) en el estudio %4$s.<br>%5$s'
                                        . '<br>%6$s',
                                    $User->getUsername(),
                                    $AnaStudy->getFkAnalyte()->getName(),
                                    $AnaStudy->getFkAnalyte()->getShortening(),
                                    $Study->getCode(),
                                    $older,
                                    $newer
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
                $buttons .= '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/nominalconcentration/' . $anaStudy->getPkAnalyteStudy() . '?state='.$state.'"><span class="form-datatable-nominal"></span></a>';
            }
            elseif($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio() && !$anaStudy->getFkStudy()->getCloseFlag())
            {
                $buttons .= '<span class="form-datatable-change" onclick="changeElement(this, ' . $anaStudy->getPkAnalyteStudy() . ');"></span>';
                $buttons .= '<span class="form-datatable-delete" onclick="removeElement(this, ' . $anaStudy->getPkAnalyteStudy() . ');"></span>';
            }

            if($anaStudy->getFkStudy()->getApprove() && $anaStudy->getStatus())
            {
                $buttons .= '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/sampleverificationassociation/' . $anaStudy->getPkAnalyteStudy() . '?state='.$state.'"><span class="form-datatable-change" title="asociación"></span></a>';
                //$buttons .= '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/study/sampleverification/' . $anaStudy->getPkAnalyteStudy() . '?state='.$state.'"><span class="form-datatable-change" title="verificación"></span></a>';
            }

            if($anaStudy->getFkUserAssociated())
            {
                $buttons .= '<a href="' . \Alae\Service\Helper::getVarsConfig("base_url") . '/batch/list/' . $anaStudy->getPkAnalyteStudy() . '?state='.$state.'"><span class="form-datatable-batch"></span></a>';    
            }

            $min = $anaStudy->getRetention() - ($anaStudy->getAcceptance() * $anaStudy->getRetention() / 100);
            $max = $anaStudy->getRetention() + ($anaStudy->getAcceptance() * $anaStudy->getRetention() / 100);

            $min_is = $anaStudy->getRetentionIs() - ($anaStudy->getAcceptanceIs() * $anaStudy->getRetentionIs() / 100);
            $max_is = $anaStudy->getRetentionIs() + ($anaStudy->getAcceptanceIs() * $anaStudy->getRetentionIs() / 100);
    
            if($validation == 0)
            {
                $data[] = array(
                    "analyte"    => $anaStudy->getFkAnalyte()->getShortening(),
                    "analyte_is" => $anaStudy->getFkAnalyteIs()->getShortening(),
                    "cs_number"  => $anaStudy->getCsNumber(),
                    "qc_number"  => $anaStudy->getQcNumber(),
                    "unit"       => $anaStudy->getFkUnit()->getName(),
                    "edit"       => $buttons
                );
            }
            else
            {
                if($verification == 1)
                {
                    $data[] = array(
                        "analyte"    => $anaStudy->getFkAnalyte()->getShortening(),
                        "analyte_is" => $anaStudy->getFkAnalyteIs()->getShortening(),
                        "cs_number"  => $anaStudy->getCsNumber(),
                        "qc_number"  => $anaStudy->getQcNumber(),
                        "unit"       => $anaStudy->getFkUnit()->getName(),
                        "retention" => number_format($anaStudy->getRetention(), 2, '.', ''),
                        "acceptance" => number_format($anaStudy->getAcceptance(), 2, '.', ''),
                        "retention_min" => number_format($min, 2, '.', ''),
                        "retention_max" => number_format($max, 2, '.', ''),
                        "retention_is" => number_format($anaStudy->getRetentionIs(), 2, '.', ''),
                        "acceptance_is" => number_format($anaStudy->getAcceptanceIs(), 2, '.', ''),
                        "retention_min_is" => number_format($min_is, 2, '.', ''),
                        "retention_max_is" => number_format($max_is, 2, '.', ''),
                        "use"        => $anaStudy->getIsUsed(),
                        "edit"       => $buttons
                    );
                }
                else
                {
                    $data[] = array(
                        "analyte"    => $anaStudy->getFkAnalyte()->getShortening(),
                        "analyte_is" => $anaStudy->getFkAnalyteIs()->getShortening(),
                        "cs_number"  => $anaStudy->getCsNumber(),
                        "qc_number"  => $anaStudy->getQcNumber(),
                        "unit"       => $anaStudy->getFkUnit()->getName(),
                        "edit"       => $buttons
                    );
                }
            }
        }

        $isDuplicated = $Study->getApprove() && $this->_getSession()->isAdministrador() && !$Study->getCloseFlag();

        $Analyte   = $this->getRepository('\\Alae\\Entity\\Analyte')->findBy(array("status" => true), array('shortening' => 'ASC'));
        $Unit      = $this->getRepository('\\Alae\\Entity\\Unit')->findAll();

        if($validation == 0)
        {
            $datatable = new Datatable($data, Datatable::DATATABLE_ANASTUDY2, $this->_getSession()->getFkProfile()->getName());
        }
        else
        {
            if($verification == 1)
            {
                $datatable = new Datatable($data, Datatable::DATATABLE_ANASTUDY, $this->_getSession()->getFkProfile()->getName());
            }
            else
            {
                $datatable = new Datatable($data, Datatable::DATATABLE_ANASTUDY2, $this->_getSession()->getFkProfile()->getName());
            }
        }

        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('study', $Study);
        $viewModel->setVariable('error', (isset($error) ? $error : ""));
        $viewModel->setVariable('analytes', $Analyte);
        $viewModel->setVariable('units', $Unit);
        $viewModel->setVariable('user', $this->_getSession());
        $viewModel->setVariable('isDuplicated',  $isDuplicated);
        $viewModel->setVariable('disabled', (($canEdit) ? '' : 'disabled=""'));
        $viewModel->setVariable('mostrarConfirmar', $mostrarConfirmar);
        
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
                    $counter = 0;
                    //XXXXV
                    if (preg_match("/^[A-Z0-9]+(\-[0-9]{4}?)+[V]+(\-[0-9]{2}?)?$/i", $Study->getCode()))
                    {
                        $query = $this->getEntityManager()->createQuery("
                            SELECT COUNT(s.pkStudy)
                            FROM Alae\Entity\Study s
                            WHERE s.code LIKE  '%" . $code[0]. "-". $code[1] . "%' AND 
                            (REGEXP(s.code, :regexp1) = 1 OR
                            REGEXP(s.code, :regexp2) = 1)");
                        $query->setParameter('regexp1', '^[A-Z0-9]+(\-[0-9]{4})+([V])$');
                        $query->setParameter('regexp2', '^[A-Z0-9]+(\-[0-9]{4})+([V])+(\-[0-9]{2})$');
                        $counter = $query->getSingleScalarResult();
                    }

                    //XXXXV01
                    if (preg_match("/^[A-Z0-9]+(\-[0-9]{4}?)+[V]+([0-9]{2}?)+(\-[0-9]{2}?)?$/i", $Study->getCode()))
                    {
                        $query = $this->getEntityManager()->createQuery("
                            SELECT COUNT(s.pkStudy)
                            FROM Alae\Entity\Study s
                            WHERE s.code LIKE  '%" . $code[0]. "-". $code[1] . "%' AND 
                            (REGEXP(s.code, :regexp1) = 1 OR
                            REGEXP(s.code, :regexp2) = 1)");
                            $query->setParameter('regexp1', '^[A-Z0-9]+(\-[0-9]{4})+([V][0-9]{2})$');
                            $query->setParameter('regexp2', '^[A-Z0-9]+(\-[0-9]{4})+([V][0-9]{2})+(\-[0-9]{2})$');
                        $counter = $query->getSingleScalarResult();
                    }

                    //XXXXXV
                    if (preg_match("/^[A-Z0-9]+(\-[0-9]{5}?)+[V]+(\-[0-9]{2}?)?$/i", $Study->getCode()))
                    {
                        $query = $this->getEntityManager()->createQuery("
                            SELECT COUNT(s.pkStudy)
                            FROM Alae\Entity\Study s
                            WHERE s.code LIKE  '%" . $code[0]. "-". $code[1] . "%' AND 
                            (REGEXP(s.code, :regexp1) = 1 OR
                            REGEXP(s.code, :regexp2) = 1)");
                        $query->setParameter('regexp1', '^[A-Z0-9]+(\-[0-9]{5})+([V])$');
                        $query->setParameter('regexp2', '^[A-Z0-9]+(\-[0-9]{5})+([V])+(\-[0-9]{2})$');
                        $counter = $query->getSingleScalarResult();
                    }

                    //XXXXXV01
                    if (preg_match("/^[A-Z0-9]+(\-[0-9]{5}?)+[V]+([0-9]{2}?)+(\-[0-9]{2}?)?$/i", $Study->getCode()))
                    {
                        $query = $this->getEntityManager()->createQuery("
                            SELECT COUNT(s.pkStudy)
                            FROM Alae\Entity\Study s
                            WHERE s.code LIKE  '%" . $code[0]. "-". $code[1] . "%' AND 
                            (REGEXP(s.code, :regexp1) = 1 OR
                            REGEXP(s.code, :regexp2) = 1)");
                            $query->setParameter('regexp1', '^[A-Z0-9]+(\-[0-9]{5})+([V][0-9]{2})$');
                            $query->setParameter('regexp2', '^[A-Z0-9]+(\-[0-9]{5})+([V][0-9]{2})+(\-[0-9]{2})$');
                        $counter = $query->getSingleScalarResult();
                    }
                    
                    $newStudy = new \Alae\Entity\Study();
                    $newStudy->setVerification($Study->getVerification());
                    $newStudy->setValidation($Study->getValidation());
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

                        $Study   = $this->getRepository()->find($AnaStudy->getFkStudy()->getPkStudy());
                        $elements = $this->getRepository("\\Alae\\Entity\\SampleVerification")->findAll();
        
                        //MOSTRAR LOS DATOS
                        foreach ($elements as $sample)
                        {
                            $studyVerification = new \Alae\Entity\SampleVerificationStudy();
                            $studyVerification->setName($sample->getName());
                            $studyVerification->setassociated($sample->getAssociated());
                            
                            $first = substr($sample->getAssociated(), 0, 2); 
                            $last = substr($sample->getAssociated(), -1); 
                            
                            if($first == 'CS')
                            {
                                $cs_values = explode(",", $AnaStudy->getCsValues());
                                $value = $cs_values[$last - 1];
                            }

                            if($first == 'QC')
                            {
                                $qc_values = explode(",", $AnaStudy->getQcValues());
                                $value = $qc_values[$last - 1];
                            }

                            if($sample->getAssociated() == 'LLQC')
                            {
                                $value = $AnaStudy->getLlqcValues();
                               
                            }
                            $studyVerification->setValue($value);
                            $studyVerification->setFkAnalyteStudy($AnaStudy);
                            $this->getEntityManager()->persist($studyVerification);
                            $this->getEntityManager()->flush();
                        }

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
    public function associatedApproveAction()
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
                        $AnaStudy->setFkUserAssociated($User);
                        $AnaStudy->setAssociatedAt(new \DateTime('now'));
                        $this->getEntityManager()->persist($AnaStudy);
                        $this->getEntityManager()->flush();
                        $this->transaction(
                            "Aprobación de asociación de concentraciones nominales",
                            sprintf('El usuario %1$s ha aprobado la asociación de concentraciones nominales <br>'
                                    . ' en el estudio %2$s del analito %3$s',
                                $User->getUsername(),
                                $AnaStudy->getFkStudy()->getCode(),
                                $AnaStudy->getFkAnalyte()->getShortening()
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
            $AnaStudy->setLlqcValues($request->getPost("llqc_number"));
            $AnaStudy->setUlqcValues($request->getPost("ulqc_number"));
            $this->getEntityManager()->persist($AnaStudy);
            $this->getEntityManager()->flush();
            $this->transaction(
                "Ingreso concentraciones nominales",
                sprintf('El usuario %1$s ha ingresado las concentraciones nominales del estudio %2$s<br>'
                        . 'Analito: %3$s<br>'
                        . 'Concentración Nominal de los Estándares de Calibración: %4$s<br>'
                        . 'Concentración Nominal de los Controles de Calidad: %5$s<br>'
                        . 'Concentración Nominal de los LDQC y HDQC, respectivamente: %6$s, %7$s<br>'
                        . 'Concentración Nominal de los LLQC y ULQC, respectivamente: %8$s, %9$s',
                    $this->_getSession()->getUsername(),
                    $AnaStudy->getFkStudy()->getCode(),
                    $AnaStudy->getFkAnalyte()->getName(),
                    implode(",", $request->getPost("cs_number")),
                    implode(",", $request->getPost("qc_number")),
                    $request->getPost("ldqc_number"),
                    $request->getPost("hdqc_number"),
                    $request->getPost("llqc_number"),
                    $request->getPost("ulqc_number")
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
        $viewModel->setVariable('llqc_number', number_format($AnaStudy->getLlqcValues(), 2, '.',''));
        $viewModel->setVariable('ulqc_number', number_format($AnaStudy->getUlqcValues(), 2, '.',''));
        $viewModel->setVariable('User', $this->_getSession());
        $viewModel->setVariable('isUnlock', $counter == 0 ? true : false);
        $viewModel->setVariable('disabled', (!$AnaStudy->getStatus() && ($this->_getSession()->isAdministrador() || $this->_getSession()->isDirectorEstudio()) ? '' : 'disabled=""'));
        $viewModel->setVariable('state', $_GET['state']);
        return $viewModel;
    }

    /*
     * Función para ingresar las concentraciones nominacionales de los samples
     */
    public function sampleverificationAction()
    {
        $request = $this->getRequest();

        $error = "";
        $centi = 0;

        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->find($this->getEvent()->getRouteMatch()->getParam('id'));

        if ($request->isPost())
        {
            $Study   = $this->getRepository()->find($AnaStudy->getFkStudy()->getPkStudy());
            $updateConc = $request->getPost('update-analyte_concentration');
            
            if (!empty($updateConc))
            {
                $User = $this->_getSession();

                foreach ($updateConc as $key => $value)
                {
                    $sampleBatch = $this->getRepository('\\Alae\\Entity\\SampleBatch')->find($key);
                    
                    $samplename = substr($sampleBatch->getsampleName(), 0, -1);

                    $batch = $sampleBatch->getFkBatch()->getPkBatch();
                    
                    $query      = $this->getEntityManager()->createQuery("
                    SELECT s.pkSampleBatch FROM Alae\Entity\SampleBatch s
                    WHERE s.sampleName LIKE '%". $samplename . "%' AND s.fkBatch = " . $batch);
                    $samples   = $query->getResult();
                    
                    foreach ($samples as $sample)
                    {
                        $sampleBatch2 = $this->getRepository('\\Alae\\Entity\\SampleBatch')->find($sample["pkSampleBatch"]);
                    

                        if ($sampleBatch2 && $sampleBatch2->getPkSampleBatch())
                        {    
                            $older = sprintf('Valores antiguos: Sample -> %1$s, Concentración -> %2$s',
                                $sampleBatch2->getSampleName(),
                                $sampleBatch2->getAnalyteConcentration()
                            );
                            
                            $sampleBatch2->setAnalyteConcentration($updateConc[$key]);
                            $this->getEntityManager()->persist($sampleBatch2);
                            $this->getEntityManager()->flush();

                            //INGRESO A AUDIT TRANSACTION
                            $this->transaction(
                                "Edición manual de muestras",
                                sprintf('Estudio: %1$s<br> %2$s <br> Nuevo valor de concentración -> %3$s',
                                    $Study->getCode(),
                                    $older,
                                    $updateConc[$key]
                                ),
                                false
                            );
                        }
                    }
                }
            }

        }

        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->find($this->getEvent()->getRouteMatch()->getParam('id'));
        
        $query    = $this->getEntityManager()->createQuery("
            SELECT b
            FROM Alae\Entity\Batch b
            WHERE b.fkAnalyte = " . $AnaStudy->getFkAnalyte()->getPkAnalyte() . " AND b.fkStudy = " . $AnaStudy->getFkStudy()->getPkStudy() . "
            ORDER BY b.fileName ASC");
        $batch = $query->getResult();

        $list    = array();
        $pkBatch = array();
        $data = array();
        foreach ($batch as $Batch)
        {
            //OBTIENE LOS DATOS DEL REPORTE
            $qb       = $this->getEntityManager()->createQueryBuilder();
            $qb
                    ->select('s.pkSampleBatch as PKSampleBatch', 's.sampleName as sampleName', 's.analyteConcentration','s.isConcentration')
                    ->from('Alae\Entity\SampleBatch', 's')
                    ->where("s.fkBatch = " . $Batch->getPkBatch() . " AND (s.sampleName LIKE '%NT%' OR s.sampleName LIKE '%BC%') AND (s.sampleName LIKE '%1')  ")
                    ->groupBy('s.pkSampleBatch')
                    ->orderBy('s.sampleName', 'ASC');
            $elements = $qb->getQuery()->getResult();

            if (count($elements) > 0)
            {
                
                
                foreach ($elements as $temp)
                {
                    $buttons = "";
                    if (!$AnaStudy->getFkStudy()->getCloseFlag())
                    {
                        $buttons .= '<span class="form-datatable-change" onclick="changeElement(this, ' . $temp["PKSampleBatch"] . ');"></span>';
                    }
                    $data[] = array(
                        "sample_name"           => $temp["sampleName"],
                        "analyte_concentration" => $temp["analyteConcentration"],
                        "edit"                  => $buttons
                    );
                }
            }
        }

        if (!$AnaStudy->getFkStudy()->getCloseFlag())
        {
            $datatable = new Datatable($data, Datatable::DATATABLE_VERIFICATION_SAMPLE_BATCH, $this->_getSession()->getFkProfile()->getName());
        }
        else
        {
            $datatable = new Datatable($data, Datatable::DATATABLE_VERIFICATION_SAMPLE_BATCH_R, $this->_getSession()->getFkProfile()->getName());
        }

        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('AnaStudy', $AnaStudy);
        $viewModel->setVariable('user', $this->_getSession());
        $viewModel->setVariable('error', $error);
        $viewModel->setVariable('state', $_GET['state']);
        return $viewModel;
    }

    public function deleteVerificationAssociationAction()
    {
        $request = $this->getRequest();
        
        if ($request->isGet())
        {
            $sample = $this->getRepository('\\Alae\\Entity\\SampleVerificationStudy')->find($request->getQuery('pk'));

            if ($sample && $sample->getId())
            {
                try
                {
                    //BORRA EL ESTUDIO
                    $this->getEntityManager()->remove($sample);
                    $this->getEntityManager()->flush();
                    $this->transaction(
                        "Eliminar asociación",
                        sprintf('El usuario %1$s ha eliminado la asociación de %2$s con %3$s',
                            $this->_getSession()->getUsername(),
                            $sample->getName(),
                            $sample->getAssociated()
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

    public function sampleverificationassociationAction()
    {
        $request = $this->getRequest();

        $error = "";
        $centi = 0;

        $AnaStudy = $this->getRepository("\\Alae\\Entity\\AnalyteStudy")->find($this->getEvent()->getRouteMatch()->getParam('id'));

        $query    = $this->getEntityManager()->createQuery("
            SELECT b
            FROM Alae\Entity\Batch b
            WHERE b.fkAnalyte = " . $AnaStudy->getFkAnalyte()->getPkAnalyte() . " AND b.fkStudy = " . $AnaStudy->getFkStudy()->getPkStudy() . "
            ORDER BY b.fileName ASC");
        $batch = $query->getResult();

        if ($request->isPost())
        {
            $createNames      = $request->getPost('create-name');
            $createAssociated = $request->getPost('create-associated');
            $createValue      = $request->getPost('create-value');

            if (!empty($createNames))
            {
                foreach ($createNames as $key => $value)
                {
                    $sample = new \Alae\Entity\SampleVerificationStudy();
                    $sample->setFkAnalyteStudy($AnaStudy);
                    $sample->setName($createNames[$key]);
                    $sample->setAssociated($createAssociated[$key]);
                    $sample->setValue($createValue[$key]);
                    $this->getEntityManager()->persist($sample);
                    $this->getEntityManager()->flush();

                    $this->transaction(
                        "Ingreso de nivel de concentración asociado",
                        sprintf('En el Estudio %1$s y Analito %2$s. Se ha ingresado el sample %3$s asociado a: %4$s con valor: %5$s',
                            $AnaStudy->getFkStudy()->getCode(),
                            $AnaStudy->getFkAnalyte()->getShortening(),
                            $sample->getName(),
                            $sample->getAssociated(),
                            $sample->getValue()
                        ),
                        false
                    );  
                }
            }

            $updateName = $request->getPost('update-name');
            $updateAssociated = $request->getPost('update-associated');
            $updateValue = $request->getPost('update-value');

            if (!empty($updateName))
            {
                $User = $this->_getSession();

                foreach ($updateName as $key => $value)
                {
                    
                    $sampleVerification = $this->getRepository('\\Alae\\Entity\\SampleVerificationStudy')->find($key);
                    
                    if ($sampleVerification && $sampleVerification->getId())
                    {    
                        $older = sprintf('Valores antiguos: Sample -> %1$s, Association -> %2$s, valor -> %3$s ',
                            $sampleVerification->getName(),
                            $sampleVerification->getAssociated(),
                            $sampleVerification->getValue()
                        );
                        
                        $sampleVerification->setName($updateName[$key]);
                        $sampleVerification->setAssociated($updateAssociated[$key]);
                        $sampleVerification->setValue($updateValue[$key]);
                        $this->getEntityManager()->persist($sampleVerification);
                        $this->getEntityManager()->flush();

                        //INGRESO A AUDIT TRANSACTION
                        $this->transaction(
                            "Edición de tabla de asociación",
                            sprintf('%1$s<br> Estudio: %2$s. Analito: %3$s. Nombre -> %4$s, Asociación -> %5$s, Value ->%6$s ',
                                $older,
                                $AnaStudy->getFkStudy()->getCode(),
                                $AnaStudy->getFkAnalyte()->getShortening(),
                                $updateName[$key],
                                $updateAssociated[$key],
                                $updateValue[$key]
                            ),
                            false
                        );
                    }
                }
            }
        }

        $query    = $this->getEntityManager()->createQuery("
            SELECT v.id as id, v.name as name, v.associated as associated, v.value as value
            FROM Alae\Entity\SampleVerificationStudy v
            WHERE v.fkAnalyteStudy = " . $AnaStudy->getPkAnalyteStudy() . "
            ORDER BY v.id ASC");
        $elements = $query->getResult();

                /*SELECT distinct v.NAME, v.associated FROM alae_sample_batch s 
        JOIN alae_sample_verification v
        ON s.sample_name LIKE CONCAT('', v.name ,'%')
        WHERE s.fk_batch = 8271*/
        
        $data     = array();
        if (count($elements) > 0)
        {   
            foreach ($elements as $temp)
            {
                $buttons = "";
                if (!$AnaStudy->getFkUserAssociated())
                {
                    $buttons .= '<span class="form-datatable-change" onclick="changeElement(this, ' . $temp["id"] . ');"></span>';
                    $buttons .= '<span class="form-datatable-delete" onclick="removeElement(this, ' . $temp["id"] . ');"></span>';
    
                }

                $data[] = array(
                    "name"       => $temp["name"],
                    "associated" => $temp["associated"],
                    "value"      => $temp["value"],
                    "edit"                  => $buttons
                );
            }
        }

        if (!$AnaStudy->getFkUserAssociated())
        {
            $datatable = new Datatable($data, Datatable::DATATABLE_VERIFICATION_SAMPLE_ASSOC, $this->_getSession()->getFkProfile()->getName());
        }
        else
        {
            $datatable = new Datatable($data, Datatable::DATATABLE_VERIFICATION_SAMPLE_ASSOC_R, $this->_getSession()->getFkProfile()->getName());    
        }
        $viewModel = new ViewModel($datatable->getDatatable());
        $viewModel->setVariable('user', $this->_getSession());
        $viewModel->setVariable('error', $error);
        $viewModel->setVariable('AnaStudy', $AnaStudy);
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
