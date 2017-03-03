<?php
/* APLICACION ALAE
   Variables de control de rutas del sistema
   Autor: María Quiroz
   Fecha de creación: 10/05/2014
*/
namespace Alae;

return array(
    //RUTA BASE
    "base_url"              => "http://localhost/alae/public",
 //"base_url" => "http://www.alaeapp.com",
    //"base_url" => "http://localhost/alae/public",
    "batch_directory"       => "C:\lotes",
    "batch_directory_older" => "C:\lotes_xyz",
    "mail_host_smtp"        => "smtp.gmail.com",
    "mail_port"             => 587,
    "mail_username"         => "cilantro.admistrador@gmail.com", //email base
    "mail_admin_email"      => "cilantro.admistrador@gmail.com",
    "mail_password"         => "c1lantr01t",
);

/*return array(
    "base_url" 				=> "http://www.alae.com/public",
    "batch_directory" 		=> "D:\lotes",
	"batch_directory_older" => "D:\lotesBKP",
    "mail_host_smtp" 		=> "smtp.anapharmeurope.com",
    "mail_port" 			=> 587,
	"mail_username"			=> "alae@anapharmeurope.com",
    "mail_admin_email" 		=> "alae@anapharmeurope.com",
    "mail_password" 		=> "App2014",
);*/