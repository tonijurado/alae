<?php

namespace Alae\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * SampleVerification
 *
 * @ORM\Table(name="alae_batch_nominal")
 * @ORM\Entity
 */
class BatchNominal
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
     * @var \Alae\Entity\Batch
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\Batch")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_batch", referencedColumnName="pk_batch")
     * })
     */
    protected $fkBatch;

    /**
     * @var string
     *
     * @ORM\Column(name="sample_name", type="string", length=250, nullable=false)
     */
    protected $sampleName;

        /**
     * @var string
     *
     * @ORM\Column(name="value", type="decimal", precision=19, scale=2, nullable=true)
     */
    protected $analyteConcentration;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }
 
    public function getSampleName()
    {
        return $this->sampleName;
    }

    public function setSampleName($sampleName)
    {
        $this->sampleName = $sampleName;
    }

    public function getAnalyteConcentration()
    {
        return $this->analyteConcentration;
    }

    public function setAnalyteConcentration($analyteConcentration)
    {
        $this->analyteConcentration = $analyteConcentration;
    }

    public function getFkBatch()
    {
        return $this->fkBatch;
    }

    public function setFkBatch(\Alae\Entity\Batch $fkBatch)
    {
        $this->fkBatch = $fkBatch;
    }
}