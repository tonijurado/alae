<?php

namespace Alae\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * AnalyteStudy
 *
 * @ORM\Table(name="alae_analyte_study", indexes={@ORM\Index(name="fk_analyte", columns={"fk_analyte"}), @ORM\Index(name="fk_analyte_is", columns={"fk_analyte_is"}), @ORM\Index(name="fk_unit", columns={"fk_unit"}), @ORM\Index(name="IDX_26E654AD2792B43C", columns={"fk_study"})})
 * @ORM\Entity
 */
class AnalyteStudy
{

    /**
     * @var integer
     *
     * @ORM\Column(name="pk_analyte_study", type="bigint", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    protected $pkAnalyteStudy;

    /**
     * @var integer
     *
     * @ORM\Column(name="cs_number", type="integer", nullable=false)
     */
    protected $csNumber = '15';

    /**
     * @var integer
     *
     * @ORM\Column(name="qc_number", type="integer", nullable=false)
     */
    protected $qcNumber = '6';

    /**
     * @var string
     *
     * @ORM\Column(name="cs_values", type="string", length=100, nullable=true)
     */
    protected $csValues;

    /**
     * @var string
     *
     * @ORM\Column(name="hdqc_values", type="decimal", precision=19, scale=2, nullable=false)
     */
    protected $hdqcValues;

    /**
     * @var string
     *
     * @ORM\Column(name="ldqc_values", type="decimal", precision=19, scale=2, nullable=false)
     */
    protected $ldqcValues;

        /**
     * @var string
     *
     * @ORM\Column(name="llqc_values", type="decimal", precision=19, scale=2, nullable=false)
     */
    protected $llqcValues;

        /**
     * @var string
     *
     * @ORM\Column(name="ulqc_values", type="decimal", precision=19, scale=2, nullable=false)
     */
    protected $ulqcValues;

    /**
     * @var string
     *
     * @ORM\Column(name="qc_values", type="string", length=100, nullable=true)
     */
    protected $qcValues;

    /**
     * @var string
     *
     * @ORM\Column(name="internal_standard", type="decimal", precision=19, scale=4, nullable=true)
     */
    protected $internalStandard;

    /**
     * @var boolean
     *
     * @ORM\Column(name="status", type="boolean", nullable=false)
     */
    protected $status;

    /**
     * @var boolean
     *
     * @ORM\Column(name="is_used", type="boolean", nullable=true)
     */
    protected $isUsed;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="updated_at", type="datetime", nullable=false)
     */
    protected $updatedAt;

    /**
     * @var \Alae\Entity\Study
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\Study")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_study", referencedColumnName="pk_study")
     * })
     */
    protected $fkStudy;

    /**
     * @var \Alae\Entity\Analyte
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\Analyte")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_analyte", referencedColumnName="pk_analyte")
     * })
     */
    protected $fkAnalyte;

    /**
     * @var \Alae\Entity\Analyte
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\Analyte")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_analyte_is", referencedColumnName="pk_analyte")
     * })
     */
    protected $fkAnalyteIs;

    /**
     * @var \Alae\Entity\Unit
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\Unit")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_unit", referencedColumnName="pk_unit")
     * })
     */
    protected $fkUnit;

    /**
     * @var \Alae\Entity\User
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\User")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_user", referencedColumnName="pk_user")
     * })
     */
    protected $fkUser;

    /**
     * @var \Alae\Entity\User
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\User")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_user_approve", referencedColumnName="pk_user")
     * })
     */
    protected $fkUserApprove;

    /**
     * @var string
     *
     * @ORM\Column(name="retention", type="decimal", precision=19, scale=4, nullable=true)
     */
    protected $retention = 0;

    /**
     * @var string
     *
     * @ORM\Column(name="acceptance", type="decimal", precision=19, scale=4, nullable=true)
     */
    protected $acceptance = 0;

    /**
     * @var string
     *
     * @ORM\Column(name="retention_is", type="decimal", precision=19, scale=4, nullable=true)
     */
    protected $retentionIs = 0;

    /**
     * @var string
     *
     * @ORM\Column(name="acceptance_is", type="decimal", precision=19, scale=4, nullable=true)
     */
    protected $acceptanceIs = 0;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="associated_at", type="datetime", nullable=false)
     */
    protected $associatedAt;

    /**
     * @var \Alae\Entity\User
     *
     * @ORM\ManyToOne(targetEntity="Alae\Entity\User")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="fk_user_associated", referencedColumnName="pk_user")
     * })
     */
    protected $fkUserAssociated;

    public function __construct()
    {
        $this->updatedAt = new \DateTime('now');
    }

    public function getPkAnalyteStudy()
    {
        return $this->pkAnalyteStudy;
    }

    public function setPkAnalyteStudy($pkAnalyteStudy)
    {
        $this->pkAnalyteStudy = $pkAnalyteStudy;
    }

    public function getCsNumber()
    {
        return $this->csNumber;
    }

    public function setCsNumber($csNumber)
    {
        $this->csNumber = $csNumber;
    }

    public function getQcNumber()
    {
        return $this->qcNumber;
    }

    public function setQcNumber($qcNumber)
    {
        $this->qcNumber = $qcNumber;
    }

    public function getCsValues()
    {
        return $this->csValues;
    }

    public function setCsValues($csValues)
    {
        $this->csValues = $csValues;
    }

    public function getQcValues()
    {
        return $this->qcValues;
    }

    public function setQcValues($qcValues)
    {
        $this->qcValues = $qcValues;
    }

    public function getInternalStandard()
    {
        return (float) $this->internalStandard;
    }

    public function setInternalStandard($internalStandard)
    {
        $this->internalStandard = $internalStandard;
    }

    public function getStatus()
    {
        return $this->status;
    }

    public function setStatus($status)
    {
        $this->status = $status;
    }

    public function getIsUsed()
    {
        return $this->isUsed;
    }

    public function setIsUsed($isUsed)
    {
        $this->isUsed = $isUsed;
    }

    public function getUpdatedAt()
    {
        return $this->updatedAt->format('d.m.Y H:i:s');
    }

    public function setUpdatedAt(\DateTime $updatedAt)
    {
        $this->updatedAt = $updatedAt;
    }

    public function getFkStudy()
    {
        return $this->fkStudy;
    }

    public function setFkStudy(\Alae\Entity\Study $fkStudy)
    {
        $this->fkStudy = $fkStudy;
    }

    public function getFkAnalyte()
    {
        return $this->fkAnalyte;
    }

    public function setFkAnalyte(\Alae\Entity\Analyte $fkAnalyte)
    {
        $this->fkAnalyte = $fkAnalyte;
    }

    public function getFkAnalyteIs()
    {
        return $this->fkAnalyteIs;
    }

    public function setFkAnalyteIs(\Alae\Entity\Analyte $fkAnalyteIs)
    {
        $this->fkAnalyteIs = $fkAnalyteIs;
    }

    public function getFkUnit()
    {
        return $this->fkUnit;
    }

    public function setFkUnit(\Alae\Entity\Unit $fkUnit)
    {
        $this->fkUnit = $fkUnit;
    }

    public function getFkUser()
    {
        return $this->fkUser;
    }

    public function setFkUser(\Alae\Entity\User $fkUser)
    {
        $this->fkUser = $fkUser;
    }

    public function getFkUserApprove()
    {
        return $this->fkUserApprove;
    }

    public function setFkUserApprove(\Alae\Entity\User $fkUser)
    {
        $this->fkUserApprove = $fkUser;
    }

    public function setLdqcValues($ldqcValues)
    {
        $this->ldqcValues = $ldqcValues;
    }

    public function getLdqcValues()
    {
        return $this->ldqcValues;
    }

    public function setHdqcValues($hdqcValues)
    {
        $this->hdqcValues = $hdqcValues;
    }

    public function getHdqcValues()
    {
        return $this->hdqcValues;
    }

    public function setLlqcValues($llqcValues)
    {
        $this->llqcValues = $llqcValues;
    }

    public function getLlqcValues()
    {
        return $this->llqcValues;
    }

    public function setUlqcValues($ulqcValues)
    {
        $this->ulqcValues = $ulqcValues;
    }

    public function getUlqcValues()
    {
        return $this->ulqcValues;
    }

    public function getRetention()
    {
        return (float) $this->retention;
    }

    public function setRetention($retention)
    {
        $this->retention = $retention;
    }

    public function getAcceptance()
    {
        return (float) $this->acceptance;
    }

    public function setAcceptance($acceptance)
    {
        $this->acceptance = $acceptance;
    }

    public function getRetentionIs()
    {
        return (float) $this->retentionIs;
    }

    public function setRetentionIs($retentionIs)
    {
        $this->retentionIs = $retentionIs;
    }

    public function getAcceptanceIs()
    {
        return (float) $this->acceptanceIs;
    }

    public function setAcceptanceIs($acceptanceIs)
    {
        $this->acceptanceIs = $acceptanceIs;
    }

    public function getAssociateddAt()
    {
        return $this->associatedAt->format('d.m.Y H:i:s');
    }

    public function setAssociatedAt(\DateTime $associatedAt)
    {
        $this->associatedAt = $associatedAt;
    }

    public function getFkUserAssociated()
    {
        return $this->fkUserAssociated;
    }

    public function setFkUserAssociated(\Alae\Entity\User $fkUser)
    {
        $this->fkUserAssociated = $fkUser;
    }
}
