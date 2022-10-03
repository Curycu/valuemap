## Resubmission
This is a resubmission. In this version I have:    

* Change DESCRIPTION file Imports: h3jsr version fix (== 1.2.3)
* Because h3jsr package will be api update at version 1.3.0 and that CRAN update will break this package  

## R CMD check results
There were no ERRORs or WARNINGs, but 2 notes:  

* checking CRAN incoming feasibility ... [17s] NOTE  
Maintainer: 'Huncheol Ha <hancury@gmail.com>'  

New maintainer:  
  Huncheol Ha <hancury@gmail.com>  
Old maintainer(s):  
  Heoncheol Ha <hancury@gmail.com>  
  
* checking for detritus in the temp directory ... NOTE  
Found the following files/directories:  
  'lastMiKTeXException'  

checking for detritus in the temp directory … NOTE 'lastMiKTeXException'  
Apparently, this is a known issue with Rhub and does not suggest a problem with the package.  
