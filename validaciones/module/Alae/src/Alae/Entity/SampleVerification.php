<?php

namespace Alae\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * SampleVerification
 *
 * @ORM\Table(name="alae_sample_verification")
 * @ORM\Entity
 */
class SampleVerification
{
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
}