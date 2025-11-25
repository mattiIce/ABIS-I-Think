Release Notes for PFC Version 6.0

Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.

Updated 11/14/97



Contents of this file:
=====================
New Libraries
New Extension Objects
New Syntax
Obsolete Library
Known Issues
Documentation Updates
Misceallenous



NEW LIBRARIES
=============
PFC 6.0 contains two new libraries for utility-oriented services:
PFCUTIL.PBL
PFEUTIL.PBL

Both existing and new PFC applications should include these libraries
in their application paths.

The following PFE-level objects from prior versions of PFC have been 
moved to PFEUTIL.PBL.  If you have existing applications with customized
extension PBLs, you may wish to synchronize their contents with the
object list found in PFEUTIL.PBL.  This is not required.

The following objects were moved to PFEUTIL.PBL:
n_cst_debug
n_cst_sqlspy
w_debuglog
w_sqlspy
w_sqlspyinspect



NEW EXTENSION OBJECTS
=====================
These extension objects should be included in your customized 
extension PBLs.  The object name, PowerBuilder library, and 
release are listed for each new extension object.
For more information or help on retaining customizations to your 
extension levels when upgrading to a new release of PFC, please 
refer to Powersoft Faxline #4505.

Note:  this step is only necessary for migrating existing PFC 
applications to a newer version of PFC.

5.0.02	n_cst_filesrvmac			pfeapsrv.pbl
5.0.02	n_cst_filesrvsol2			pfeapsrv.pbl
5.0.02	n_cst_platformmac			pfeapsrv.pbl
5.0.02	n_cst_platformsol2			pfeapsrv.pbl
5.0.02	w_print					pfeapsrv.pbl

6.0	n_cst_apppreference			pfeapsrv.pbl
6.0	n_cst_color				pfeapsrv.pbl
6.0	n_cst_columnattrib			pfeapsrv.pbl
6.0	n_cst_dberrorattrib			pfeapsrv.pbl
6.0	n_cst_dropdown				pfeapsrv.pbl
6.0	n_cst_filesrvaix			pfeapsrv.pbl
6.0	n_cst_filesrvhpux			pfeapsrv.pbl
6.0	n_cst_infoattrib			pfeapsrv.pbl
6.0	n_cst_linkedlistbase			pfeapsrv.pbl
6.0	n_cst_linkedlistnode			pfeapsrv.pbl
6.0	n_cst_linkedlistnodecompare		pfeapsrv.pbl
6.0	n_cst_list				pfeapsrv.pbl
6.0	n_cst_luw				pfeapsrv.pbl
6.0	n_cst_lvsrv				pfeapsrv.pbl
6.0	n_cst_lvsrv_datasource			pfeapsrv.bpl
6.0	n_cst_lvsrv_sort			pfeapsrv.pbl
6.0	n_cst_lvsrvattrib			pfeapsrv.pbl
6.0	n_cst_metaclass				pfeapsrv.pbl
6.0	n_cst_mru				pfeapsrv.pbl
6.0	n_cst_mruattrib				pfeapsrv.pbl
6.0	n_cst_nodebase				pfeapsrv.pbl
6.0	n_cst_nodecomparebase			pfeapsrv.pbl
6.0	n_cst_platformaix			pfeapsrv.pbl
6.0	n_cst_platformhpux			pfeapsrv.pbl
6.0	n_cst_queue				pfeapsrv.pbl
6.0	n_cst_stack				pfeapsrv.pbl
6.0	n_cst_tmgmultiple			pfeapsrv.pbl
6.0	n_cst_tmgregisterattrib			pfeapsrv.pbl
6.0	n_cst_tmgsingle				pfeapsrv.pbl
6.0	n_cst_tree				pfeapsrv.pbl
6.0	n_cst_treenode				pfeapsrv.pbl
6.0	n_cst_treenodecompare			pfeapsrv.pbl
6.0	n_cst_tvsrv				pfeapsrv.pbl
6.0	n_cst_tvsrv_levelsource			pfeapsrv.pbl
6.0	n_cst_tvsrv_print			pfeapsrv.pbl
6.0	n_cst_tvsrvattrib			pfeapsrv.pbl

6.0	n_cst_dssrv_multitable			pfedwsrv.pbl
6.0	n_cst_dssrv_printpreview		pfedwsrv.pbl
6.0	n_cst_dssrv_report			pfedwsrv.pbl
6.0	n_cst_dwsrv_resize			pfedwsrv.pbl
6.0	n_cst_restorerowattrib			pfedwsrv.pbl
6.0	w_restorerow				pfedwsrv.pbl

6.0	m_lvs					pfemain.pbl
6.0	m_tvs					pfemain.pbl
6.0	n_base					pfemain.pbl
6.0	n_cst_baseattrib			pfemain.pbl
6.0	n_cst_calculatorattrib			pfemain.pbl
6.0	n_cst_calendarattrib			pfemain.pbl
6.0	n_cxinfo				pfemain.pbl
6.0	n_cxk					pfemain.pbl
6.0	n_dda					pfemain.pbl
6.0	n_dsa					pfemain.pbl
6.0	n_inet					pfemain.pbl
6.0	n_ir					pfemain.pbl
6.0	n_oo					pfemain.pbl
6.0	n_ostg					pfemain.pbl
6.0	n_ostm					pfemain.pbl
6.0	n_srv					pfemain.pbl
6.0	n_tmg					pfemain.pbl
6.0	u_base					pfemain.pbl
6.0	u_calculator				pfemain.pbl
6.0	u_calendar				pfemain.pbl
6.0	u_lvs					pfemain.pbl
6.0	u_progressbar				pfemain.pbl
6.0	u_st_splitbar				pfemain.pbl
6.0	u_tvs					pfemain.pbl

6.0	*n_cst_dwpropertyattrib			pfeutil.pbl
6.0	*n_cst_dwsrv_property			pfeutil.pbl
6.0	*n_cst_propertyattrib			pfeutil.pbl
6.0	*u_tab_dwproperty			pfeutil.pbl
6.0	*u_tab_dwproperty_srv			pfeutil.pbl
6.0	*u_tabpg_dwproperty_base		pfeutil.pbl
6.0	*u_tabpg_dwproperty_buffers		pfeutil.pbl
6.0	*u_tabpg_dwproperty_services		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvcalculator	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvcalendar		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvcalendar2	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvdropdownsearch	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvfilter		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvfind		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvlinkage		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvlinkage2		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvmultitable	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvprintpreview	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvquerymode	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvreport		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvreqcolumn	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvresize		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvrowmanager	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvrowselection	pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvsort		pfeutil.pbl
6.0	*u_tabpg_dwproperty_srvsyntax		pfeutil.pbl
6.0	*u_tabpg_dwproperty_status		pfeutil.pbl
6.0	*w_dwproperty				pfeutil.pbl
6.0	*w_dwpropertyservices			pfeutil.pbl

* = these objects are in a new PFC PBL.  No action should be required
to incorporate these objects into existing customized extension libraries
as long as you will be including PFEUTIL.PBL in your application path.



NEW SYNTAX
==========
There has been new syntax added to PFC for consistency, ease of use
in the product, and new functionality.  Some existing syntax has been 
"obsoleted" in favor of the new syntax.  This syntax will be removed from 
PFC in a future version of the product.

Old syntax			New syntax
----------			----------
all prefixed constants		CAPS and non-prefixed
pfc_n_cst_dwsrv
  of_GetColumnNameSource	of_GetColumnDisplayNameStyle
  of_SetColumnNameSource	of_SetColumnDisplayNameStyle
  of_RefreshDDDWs		of_PopulateDDDWs
pfc_n_cst_dwsrv_linkage
  of_SetUpdateBottomUp		of_SetUpdateStyle
  of_GetUpdateBottomUp		of_GetUpdateStyle
  of_SetUseColLinks		of_SetStyle
  of_GetUseColLinks		of_GetStyle
  of_GetValue
  of_SetArguments		of_Register
  of_ResetArguments		of_UnRegister
  of_GetArguments		of_GetRegistered
  of_LinkTo			of_SetMaster
  of_UnLink			of_ResetMaster
  ib_updatebottomup		ii_updatestyle
pfc_n_cst_dwsrv_dropdownsearch
  of_AddColumn			of_Register
  of_GetColumn			of_GetRegistered
pfc_n_cst_dwsrv_multitable
  of_AddToUpdate 		of_Register
pfc_n_cst_security
  of_GetType
  of_FindEntry
  of_GetTag
  of_ScanDataWindow
  of_InitScanProcess
  of_ScanWindow
  of_AddObject
  of_ScanControlArray
pfc_u_dw
  pfc_retrievedddw		pfc_populatedddw
  of_GetUpdateable		of_IsUpdateable
pfc_n_cst_datetime
  of_DayofWeek			DayNumber
pfc_w_dwdebugger		pfc_w_dwproperty
pfc_w_undelete			pfc_w_restorerow

  
OBSOLETE LIBRARY
================
PFCOLD.PBL contains objects which have been obsoleted from PFC.
You will need to include it when migrating PFC applications to PFC 6.0.

After your existing PFC apps have been migrated, it is only necessary
to include this library if you have customized extension objects which 
depend on it.

Note that all obsoleted objects do have replacement objects.


KNOWN ISSUES
============


DOCUMENTATION UPDATES
=====================
The following two files can be found in an uncompressed format on the CD.
Pfcdlg16.hlp - 16bit dialog help
pfcdlg.rtf - Use this source file to extend the PFC dialog help.


MISCELLANEOUS
=============
Remember to read the Technical Migration Information for Migrating to 
PowerBuilder 6.0.
Feedback and comments are welcomed - pfc@powersoft.com