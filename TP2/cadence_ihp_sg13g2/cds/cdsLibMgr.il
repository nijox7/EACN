printf("loading cdsLibMgr.il file...\n")
envSetVal("cdsLibManager.main"      "showCategoriesOn"        'boolean t)
; try if other libMgr related settings still work if used from this place:
 ; design kit installation path
SG13_IHP_TECH=getShellEnvVar("IHP_TECH")
; path of user data and library tree             
SG13_PROJECT=getShellEnvVar("PROJECT")        
; default dir for new libs
envSetVal("ddserv.lib" "newLibDir" 'string strcat(SG13_PROJECT "/cds")) 
envSetVal("cdsLibManager.main"	"dblClickEditCellView"	'boolean	nil)
envSetVal("cdsLibManager.newLib" "pathText" 'string strcat(SG13_PROJECT "/cds")) 
