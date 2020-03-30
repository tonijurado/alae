<?php

namespace Alae\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * SampleVerification
 *
 * @ORM\Table(name="alae_sample_verification_study")
 * @ORM\Entity
 */
class SampleVerificationStudy
{

    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="bigint", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    protected $id;

    /**
     * @var string
     *
     * @ORM\Column(name="name", type="string", length=250, nullable=false)
     */
    protected $name;

    /**
     * @var string
     *
     * @ORM\Column(name="associated", type="string", length=250, nullable=false)
     */
    protected $associated;

      /**
     * @var string
     *
     * @ORM\Column(name="value", type="string", length=250, nullable=false)
     */
    protected $value;

    /**
     * @var \Alae\Entity\AnalyteStudy
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\AnalyteStudy")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_analyte_study", referencedColumnName="pk_analyte_study")
     * })
     */
    protected $fkAnalyteStudy;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }
 
    public function getName()
    {
        return $this->name;
    }

    public function setName($name)
    {
        $this->name = $name;
    }

    public function getAssociated()
    {
        return $this->associated;
    }

    public function setAssociated($associated)
    {
        $this->associated = $associated;
    }

    public function getValue()
    {
        return $this->value;
    }

    public function setValue($value)
    {
        $this->value = $value;
    }

    public function getFkAnalyteStudy()
    {
        return $this->fkAnalyteStudy;
    }

    public function setFkAnalyteStudy(\Alae\Entity\AnalyteStudy $fkAnalyteStudy)
    {
        $this->fkAnalyteStudy = $fkAnalyteStudy;
    }
}