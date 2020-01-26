SAS Forum: Importing data from MS Access with Table names over 32 characters;                                                           
                                                                                                                                        
 Two Solutions                                                                                                                          
                                                                                                                                        
     a. Passthru create a view of table with long name (allows non passthru downcode processing)                                        
     b. Passthru use brackets around the long table name                                                                                
                                                                                                                                        
  As I side note you can create a EXCEL SQL query of MS Access                                                                          
  and use an excel interface to load the view of the long table name                                                                    
  This can save you paying for SAS access to MS Acess?                                                                                  
                                                                                                                                        
                                                                                                                                        
SAS Forum                                                                                                                               
https://tinyurl.com/u6qeuaq                                                                                                             
https://communities.sas.com/t5/SAS-Procedures/importing-access-data-with-a-long-table-name/m-p/619943                                   
                                                                                                                                        
Robin2 profile                                                                                                                          
https://communities.sas.com/t5/user/viewprofilepage/user-id/308861                                                                      
                                                                                                                                        
SAS Forum                                                                                                                               
https://tinyurl.com/ya9n4rzw                                                                                                            
https://communities.sas.com/t5/SAS-Enterprise-Guide/PCFF-Import-tables-with-more-than-32-characters-from-mdb/m-p/515988                 
                                                                                                                                        
Related github                                                                                                                          
https://github.com/rogerjdeangelis?utf8=%E2%9C%93&tab=repositories&q=+mdb&type=&language=                                               
                                                                                                                                        
macros                                                                                                                                  
https://tinyurl.com/y9nfugth                                                                                                            
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                                              
                                                                                                                                        
*_                   _                                                                                                                  
(_)_ __  _ __  _   _| |_                                                                                                                
| | '_ \| '_ \| | | | __|                                                                                                               
| | | | | |_) | |_| | |_                                                                                                                
|_|_| |_| .__/ \__,_|\__|                                                                                                               
        |_|                                                                                                                             
;                                                                                                                                       
                                                                                                                                        
  Create an mdb table with a 41 char table name 'T1234567890123456789012345678901234567890'                                             
                                                                                                                                        
 1. SAS provides a sample mdb (also has a sample accdb)                                                                                 
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
*                                                                                                                                       
 _ __  _ __ ___   ___ ___  ___ ___                                                                                                      
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                                     
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                                     
| .__/|_|  \___/ \___\___||___/___/                                                                                                     
|_|                                                                                                                                     
                 __                                                                                                                     
  __ _    __   _(_) _____      __                                                                                                       
 / _` |   \ \ / / |/ _ \ \ /\ / /                                                                                                       
| (_| |_   \ V /| |  __/\ V  V /                                                                                                        
 \__,_(_)   \_/ |_|\___| \_/\_/                                                                                                         
                                                                                                                                        
                                                                                                                                        
Create view T41 of the long table name                                                                                                  
                                                                                                                                        
proc sql dquote=ansi;                                                                                                                   
  connect to access as mydb (Path="d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb");                                      
  execute(                                                                                                                              
    create view T41 as select * from T12345678901234567890123456789012345678901234567890                                                
  ) by mydb;                                                                                                                            
  disconnect from mydb                                                                                                                  
;Quit;                                                                                                                                  
                                                                                                                                        
* get data;                                                                                                                             
libname mydb "d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb";                                                            
* use the view to create the SAS table;                                                                                                 
proc sql;                                                                                                                               
  create                                                                                                                                
     table T41 as                                                                                                                       
  select                                                                                                                                
     *                                                                                                                                  
  from                                                                                                                                  
     mydb.T41                                                                                                                           
;Quit;                                                                                                                                  
                                                                                                                                        
* LOG;                                                                                                                                  
                                                                                                                                        
1890  * get data;                                                                                                                       
1891  libname mydb "d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb";                                                      
NOTE: Libref MYDB was successfully assigned as follows:                                                                                 
      Engine:        ACCESS                                                                                                             
      Physical Name: d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb                                                       
1892  * use the view to create the SAS table;                                                                                           
1893  proc sql;                                                                                                                         
1894    create                                                                                                                          
1895       table T41 as                                                                                                                 
1896    select                                                                                                                          
1897       *                                                                                                                            
1898    from                                                                                                                            
1899       mydb.T41                                                                                                                     
1900  ;                                                                                                                                 
NOTE: Table WORK.T41 created, with 20 rows and 10 columns.                                                                              
                                                                                                                                        
1900!  Quit;                                                                                                                            
NOTE: PROCEDURE SQL used (Total process time):                                                                                          
      real time           0.02 seconds                                                                                                  
                                                                                                                                        
*                                                                                                                                       
 _        _                    _        _                                                                                               
| |__    | |__  _ __ __ _  ___| | _____| |_ ___                                                                                         
| '_ \   | '_ \| '__/ _` |/ __| |/ / _ \ __/ __|                                                                                        
| |_) |  | |_) | | | (_| | (__|   <  __/ |_\__ \                                                                                        
|_.__(_) |_.__/|_|  \__,_|\___|_|\_\___|\__|___/                                                                                        
                                                                                                                                        
;                                                                                                                                       
                                                                                                                                        
proc sql;                                                                                                                               
   connect to access as mydb (Path="d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb");                                     
  create                                                                                                                                
      table work.test as                                                                                                                
  select                                                                                                                                
      *                                                                                                                                 
  from connection to mydb                                                                                                               
      (                                                                                                                                 
       select                                                                                                                           
          *                                                                                                                             
       from                                                                                                                             
         [T12345678901234567890123456789012345678901234567890]                                                                          
      );                                                                                                                                
  disconnect from mydb;                                                                                                                 
quit;                                                                                                                                   
                                                                                                                                        
1901  proc sql;                                                                                                                         
1902     connect to access as mydb (Path="d:\mdb\utl-export-a-sas-dataset-to-ms-access-mdb-in-unix.mdb");                               
                                                                                                                                        
1903    create                                                                                                                          
1904        table work.test as                                                                                                          
1905    select                                                                                                                          
1906        *                                                                                                                           
1907    from connection to mydb                                                                                                         
1908        (                                                                                                                           
1909         select                                                                                                                     
1910            *                                                                                                                       
1911         from                                                                                                                       
1912           [T12345678901234567890123456789012345678901234567890]                                                                    
1913        );                                                                                                                          
NOTE: Table WORK.TEST created, with 20 rows and 10 columns.                                                                             
                                                                                                                                        
1914    disconnect from mydb;                                                                                                           
1915  quit;                                                                                                                             
NOTE: PROCEDURE SQL used (Total process time):                                                                                          
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
