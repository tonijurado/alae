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
     * @var \Alae\Entity\Study
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\Study")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_study", referencedColumnName="pk_study")
     * })
     */
    protected $fkStudy;

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

    public function getFkStudy()
    {
        return $this->fkStudy;
    }

    public function setFkStudy(\Alae\Entity\Study $fkStudy)
    {
        $this->fkStudy = $fkStudy;
    }
}