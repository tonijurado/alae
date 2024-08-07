<?php

namespace DoctrineORMModule\Proxy\__CG__\Alae\Entity;

/**
 * DO NOT EDIT THIS FILE - IT WAS CREATED BY DOCTRINE'S PROXY GENERATOR
 */
class Parameter extends \Alae\Entity\Parameter implements \Doctrine\ORM\Proxy\Proxy
{
    /**
     * @var \Closure the callback responsible for loading properties in the proxy object. This callback is called with
     *      three parameters, being respectively the proxy object to be initialized, the method that triggered the
     *      initialization process and an array of ordered parameters that were passed to that method.
     *
     * @see \Doctrine\Common\Persistence\Proxy::__setInitializer
     */
    public $__initializer__;

    /**
     * @var \Closure the callback responsible of loading properties that need to be copied in the cloned object
     *
     * @see \Doctrine\Common\Persistence\Proxy::__setCloner
     */
    public $__cloner__;

    /**
     * @var boolean flag indicating if this object was already initialized
     *
     * @see \Doctrine\Common\Persistence\Proxy::__isInitialized
     */
    public $__isInitialized__ = false;

    /**
     * @var array properties to be lazy loaded, with keys being the property
     *            names and values being their default values
     *
     * @see \Doctrine\Common\Persistence\Proxy::__getLazyProperties
     */
    public static $lazyPropertiesDefaults = array();



    /**
     * @param \Closure $initializer
     * @param \Closure $cloner
     */
    public function __construct($initializer = null, $cloner = null)
    {

        $this->__initializer__ = $initializer;
        $this->__cloner__      = $cloner;
    }







    /**
     * 
     * @return array
     */
    public function __sleep()
    {
        if ($this->__isInitialized__) {
            return array('__isInitialized__', 'pkParameter', 'rule', 'verification', 'minValue', 'maxValue', 'codeError', 'messageError', 'typeParam', 'status', 'fkUser');
        }

        return array('__isInitialized__', 'pkParameter', 'rule', 'verification', 'minValue', 'maxValue', 'codeError', 'messageError', 'typeParam', 'status', 'fkUser');
    }

    /**
     * 
     */
    public function __wakeup()
    {
        if ( ! $this->__isInitialized__) {
            $this->__initializer__ = function (Parameter $proxy) {
                $proxy->__setInitializer(null);
                $proxy->__setCloner(null);

                $existingProperties = get_object_vars($proxy);

                foreach ($proxy->__getLazyProperties() as $property => $defaultValue) {
                    if ( ! array_key_exists($property, $existingProperties)) {
                        $proxy->$property = $defaultValue;
                    }
                }
            };

        }
    }

    /**
     * 
     */
    public function __clone()
    {
        $this->__cloner__ && $this->__cloner__->__invoke($this, '__clone', array());
    }

    /**
     * Forces initialization of the proxy
     */
    public function __load()
    {
        $this->__initializer__ && $this->__initializer__->__invoke($this, '__load', array());
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __isInitialized()
    {
        return $this->__isInitialized__;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __setInitialized($initialized)
    {
        $this->__isInitialized__ = $initialized;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __setInitializer(\Closure $initializer = null)
    {
        $this->__initializer__ = $initializer;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __getInitializer()
    {
        return $this->__initializer__;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __setCloner(\Closure $cloner = null)
    {
        $this->__cloner__ = $cloner;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific cloning logic
     */
    public function __getCloner()
    {
        return $this->__cloner__;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     * @static
     */
    public function __getLazyProperties()
    {
        return self::$lazyPropertiesDefaults;
    }

    
    /**
     * {@inheritDoc}
     */
    public function getPkParameter()
    {
        if ($this->__isInitialized__ === false) {
            return (int)  parent::getPkParameter();
        }


        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getPkParameter', array());

        return parent::getPkParameter();
    }

    /**
     * {@inheritDoc}
     */
    public function setPkParameter($pkParameter)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setPkParameter', array($pkParameter));

        return parent::setPkParameter($pkParameter);
    }

    /**
     * {@inheritDoc}
     */
    public function getRule()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getRule', array());

        return parent::getRule();
    }

    /**
     * {@inheritDoc}
     */
    public function setRule($rule)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setRule', array($rule));

        return parent::setRule($rule);
    }

    /**
     * {@inheritDoc}
     */
    public function getVerification()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getVerification', array());

        return parent::getVerification();
    }

    /**
     * {@inheritDoc}
     */
    public function setVerification($verification)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setVerification', array($verification));

        return parent::setVerification($verification);
    }

    /**
     * {@inheritDoc}
     */
    public function getMinValue()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getMinValue', array());

        return parent::getMinValue();
    }

    /**
     * {@inheritDoc}
     */
    public function setMinValue($minValue)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setMinValue', array($minValue));

        return parent::setMinValue($minValue);
    }

    /**
     * {@inheritDoc}
     */
    public function getMaxValue()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getMaxValue', array());

        return parent::getMaxValue();
    }

    /**
     * {@inheritDoc}
     */
    public function setMaxValue($maxValue)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setMaxValue', array($maxValue));

        return parent::setMaxValue($maxValue);
    }

    /**
     * {@inheritDoc}
     */
    public function getCodeError()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getCodeError', array());

        return parent::getCodeError();
    }

    /**
     * {@inheritDoc}
     */
    public function setCodeError($codeError)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setCodeError', array($codeError));

        return parent::setCodeError($codeError);
    }

    /**
     * {@inheritDoc}
     */
    public function getMessageError()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getMessageError', array());

        return parent::getMessageError();
    }

    /**
     * {@inheritDoc}
     */
    public function setMessageError($messageError)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setMessageError', array($messageError));

        return parent::setMessageError($messageError);
    }

    /**
     * {@inheritDoc}
     */
    public function getTypeParam()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getTypeParam', array());

        return parent::getTypeParam();
    }

    /**
     * {@inheritDoc}
     */
    public function setTypeParam($typeParam)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setTypeParam', array($typeParam));

        return parent::setTypeParam($typeParam);
    }

    /**
     * {@inheritDoc}
     */
    public function getStatus()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getStatus', array());

        return parent::getStatus();
    }

    /**
     * {@inheritDoc}
     */
    public function setStatus($status)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setStatus', array($status));

        return parent::setStatus($status);
    }

    /**
     * {@inheritDoc}
     */
    public function getFkUser()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getFkUser', array());

        return parent::getFkUser();
    }

    /**
     * {@inheritDoc}
     */
    public function setFkUser(\Alae\Entity\User $fkUser)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setFkUser', array($fkUser));

        return parent::setFkUser($fkUser);
    }

}
