Importing data from MS Access with Table names over 32 characters;

  As I side note you can create a EXCEL SQL query of MS Access
  and use an excel interface to load the view of the long table name

SAS Forum
https://tinyurl.com/ya9n4rzw
https://communities.sas.com/t5/SAS-Enterprise-Guide/PCFF-Import-tables-with-more-than-32-characters-from-mdb/m-p/515988

Related github
https://github.com/rogerjdeangelis?utf8=%E2%9C%93&tab=repositories&q=+mdb&type=&language=

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


INPUT
=====

  Create an mdb table with a 41 char table name 'T1234567890123456789012345678901234567890'

 1. SAS provides a sample mdb
    C:\Program Files\sashome\SASFoundation\9.4\access\sasmisc\demo.mdb

    Copy the mdb

    %bincop(
      in=C:\Program Files\sashome\SASFoundation\9.4\access\sasmisc\demo.mdb
      ,out=d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb
   );

 2. Open up the mdb and rename the customer table to T12345678901234567890123456789012345678901234567890
    * this can be done passthrue, but I am too lazy;


 EXAMPLE OUTPUT
 --------------

  WORK. T41 total obs=20  (was T12345678901234567890123456789012345678901234567890)


   CUSTOMER_
      ID        STATE    ZIP_CODE    COUNTRY     PHONE           ...    CITY

   14324742      CA       95123      USA         408/629-0589    ...    SAN JOSE
   14569877      NC       27514      USA         919/489-6792           MEMPHIS
   14898029      MD       20850      USA         301/760-2541           ROCKVILLE
   15432147      MI       49001      USA         616/582-3906           KALAMAZOO
   18543489      TX       78701      USA         512/478-0788           AUSTIN
   19783482      VA       22090      USA         703/714-2900           RESTON


PROCESS
=======

   Create view T41 of the long table name

   proc sql dquote=ansi;
     connect to access as mydb (Path="d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb");
     execute(
       create view T41 as select * from T12345678901234567890123456789012345678901234567890
     ) by mydb;
     disconnect from mydb
   ;Quit;

   * use the view to create the SAS table;
   proc sql dquote=ansi;
        connect to access as mydb (Path="d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb");
        execute(
          create view T41 as select * from T12345678901234567890123456789012345678901234567890
        ) by mydb;
        disconnect from mydb
   ;Quit;


OUTPUT
======

see above


Make Data

see input

