
set anio=%date:~6,4%
set mes=%date:~3,2%
set dia=%date:~0,2%
set hora=%time:~0,2%
set hora=%hora: =0%
set minuto=%time:~3,2%
set segundo=%time:~6,2% 
c:\xampp\mysql\bin\mysqldump.exe -u root --password=P@ssw0rd1 --routines --add-drop-database --database alae > d:\copiasAlae\copiaAlae_%anio%%mes%%dia%_%hora%h%minuto%m.sql
