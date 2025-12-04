$PBExportHeader$n_cst_lionappmanager.sru
$PBExportComments$lion's application manager inherited form pfeapsrv\n_cst_appmanager
forward
global type n_cst_lionappmanager from n_cst_appmanager
end type
end forward

global type n_cst_lionappmanager from n_cst_appmanager
event ue_show_apps ( )
end type
global n_cst_lionappmanager n_cst_lionappmanager

type variables
boolean ib_creating = false
window iw_window
end variables

forward prototypes
public function integer of_mylogondlg ()
end prototypes

public function integer of_mylogondlg ();//n_cst_logonattrib	lnv_logonattrib
//
//this.event pfc_prelogondlg (lnv_logonattrib)
//
//lnv_logonattrib.ipo_source.dynamic event pfc_logon(gs_LogID, gs_LogPass)
//
//lnv_logonattrib.ii_rc = 1
//lnv_logonattrib.is_userid = gs_LogID
//lnv_logonattrib.is_password = gs_LogPass	
//
//if Len (lnv_logonattrib.is_userid) > 0 then
//	if of_IsRegistryAvailable() then
//		RegistrySet (is_userkey + "\logon", "userid", lnv_logonattrib.is_userid)
//	else
//		SetProfileString (is_userinifile, "logon", "userid", lnv_logonattrib.is_userid)
//	end if
//
//	of_SetUserID (lnv_logonattrib.is_userid)
//end if
//
//return lnv_logonattrib.ii_rc
//

//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_LogonDlg
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = successful login
//	 0 = User cancelled from the logon dialog
//	-1 = an error occurred opening the logon window
//
//	Description:  Obtain a User ID and password from the user
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// Load logon object values
//////////////////////////////////////////////////////////////////////////////
this.event pfc_prelogondlg (gnv_logonattrib)

//////////////////////////////////////////////////////////////////////////////
// Open logon window
//////////////////////////////////////////////////////////////////////////////
Open(w_mylogon)

//////////////////////////////////////////////////////////////////////////////
// Store user id
//////////////////////////////////////////////////////////////////////////////
//if Len (gnv_logonattrib.is_userid) > 0 then
//	if of_IsRegistryAvailable() then
//		RegistrySet (is_userkey + "\logon", "userid", gnv_logonattrib.is_userid)
//	else
//		SetProfileString (is_userinifile, "logon", "userid", gnv_logonattrib.is_userid)
//	end if
//
//	of_SetUserID (gnv_logonattrib.is_userid)
//end if
//
return gnv_logonattrib.ii_rc

end function

event constructor;call super::constructor;this.of_SetAppIniFile(gs_ini_file)
//this.of_SetHelpFile( gs_initpath + "lion.hlp")
this.of_SetLogo("abc1.jpg")

//Alex Gerlants. 09/22/2016. Begin
//this.of_SetCopyright("Copyright @ 1998-2004, Aluminum Blanking Co.")
this.of_SetCopyright(&
	"Build Date: " + String(DateTime(n_cst_debug.PFC_BUILD_DATE, n_cst_debug.PFC_BUILD_TIME), "mm/dd/yyyy hh:mm:ss AM/PM") + &
	"~n~r~n~r" + "Copyright @ 1998-2004, Aluminum Blanking Co.")
//Alex Gerlants. 09/22/2016. End
	
this.of_SetVersion("Version 9.20A")
//iapp_object.DisplayName = "Aluminum Blanking Co. Integrated System" 


end event

on n_cst_lionappmanager.create
call super::create
end on

on n_cst_lionappmanager.destroy
call super::destroy
end on

event pfc_open;call super::pfc_open;String ls_clientver, ls_dbver, ls_frame
gl_session = 0

of_Splash(1)
n_cst_datetime inv_datetime
inv_datetime.of_Wait(2)

this.of_SetTrRegistration(TRUE)
inv_trregistration.of_register(SQLCA)


ls_frame = ProfileString(gs_ini_file,"FRAME","default_frame","w_lion_sys_frame")
int li_rc

if ls_frame = "w_da_frame" then
	gi_screen = 1
	this.of_seterror( true)
	li_rc = this.inv_error.of_setpredefinedsource( "err.txt")
	IF li_rc = -1 THEN
          MessageBox("of_SetPredefinedSource failed", "Please ensure errors.txt exists")
   END IF
	this.inv_error.of_setlogfile( "errlog.txt")
	this.inv_error.of_setstyle( 1)
	this.inv_error.of_setlogseverity( 4)
	this.inv_error.of_SetTimeOut(30)
	open(w_da_frame)
elseif ls_frame = "dual" then
	//Open both frame
	gi_screen = 2
	Open(w_lion_sys_frame)
	string ls_dual_mode
	ls_dual_mode = ProfileString(gs_ini_file,"FRAME","dual_mode","leftright")
	if ls_dual_mode = "updown" then gi_dual_mode = 2
//	Open(w_ejob_frame)
//	Open(w_lion_sys_dual_main_frame)
	this.event pfc_prelogondlg (gnv_logonattrib)
	this.of_seterror( true)
	li_rc = this.inv_error.of_setpredefinedsource( "err.txt")
	IF li_rc = -1 THEN
          MessageBox("of_SetPredefinedSource failed", "Please ensure errors.txt exists")
   END IF
	this.inv_error.of_setlogfile( "errlog.txt")
	this.inv_error.of_setstyle( 1)
	this.inv_error.of_setlogseverity( 4)
	this.inv_error.of_SetTimeOut(30)
//	w_da_frame lw_da_frame
	open(w_da_frame)
	
	
	
	//==============================================================
	
//	n_cst_platformwin32 inv_platform
//	f_SetPlatform(inv_platform, TRUE)
//	inv_platform.of_playSound("Reminder.wav")
	
	ls_clientver = gnv_app.of_GetVersion()
	//SELECT client_version INTO :ls_dbver FROM system_options 
	ls_dbver = f_system_option("Client Version")
	IF ls_clientver <> ls_dbver THEN
		MessageBox("Incorrect ABIS version", "You are running " + ls_clientver + &
		" of the ABIS client, but database is expecting " + ls_dbver + &
		". Please upgrade your client software."    )
		gnv_app.Event pfc_Exit()
	//HALT CLOSE
	END IF
	
			gnv_app.of_SetUserID (gnv_logonattrib.is_userid)
			String ls_default_sheet
			ls_default_sheet = ProfileString(gs_ini_file,"FRAME","default_sheet","w_production_folder_shop")
//			Message.StringParm = ls_default_sheet
//			w_lion_sys_dual_main_frame.windowstate = maximized!
//			w_lion_sys_dual_main_frame.Event pfc_Open()
//			w_ejob_frame.windowstate = maximized!
//			w_ejob_frame.Event pfc_Open()
//			w_lion_sys_frame.windowstate = maximized!
//			w_lion_sys_frame.Event pfc_Open()
//			open(w_production_folder)
//			close(w_lion_sys_frame)
//			window lw_to_open
			Open(iw_window, ls_default_sheet)
			iw_window.windowstate = maximized!
			//message.powerobjectparm = lw_to_open
//			lw_da_frame.wf_set_ejob_window( lw_to_open )
			close(w_lion_sys_frame)
	//==============================================================
else
	gi_screen = 1
	Open(w_lion_sys_frame)
	of_myLogonDlg()
end if

//Alex_Auto_Start_Auto_Inventory_Report. 10/22/2018. Begin
If gs_auto_start_auto_report = "Y" Then
	OpenSheet(w_run_report, w_lion_sys_frame, 0, Original!)
End If
//Alex_Auto_Start_Auto_Inventory_Report. 10/22/2018. End


//IF of_myLogonDlg() <= 0 THEN
//	this.Event pfc_Exit()
//ELSE
//	
//	//Set role explicitly
//	string ls_setrole
//	ls_setrole = "set role update_role identified by obd#157"
//	EXECUTE IMMEDIATE :ls_setrole USING SQLCA;
//	
//	n_cst_platformwin32 inv_platform
//	f_SetPlatform(inv_platform, TRUE)
//	inv_platform.of_playSound("Reminder.wav")
//	
//	ls_clientver = This.of_GetVersion()
//	SELECT client_version INTO :ls_dbver FROM system_options;
//	IF ls_clientver <> ls_dbver THEN
//		MessageBox("Incorrect ABIS version", "You are running " + ls_clientver + &
//		" of the ABIS client, but database is expecting " + ls_dbver + &
//		". Please upgrade your client software."    )
//		this.Event pfc_Exit()
//	//HALT CLOSE
//	END IF
//
//	f_user_activity_log("login")
//	open(w_display_app)
	
//END IF



	
	
end event

event pfc_logon;call super::pfc_logon;string	ls_file, ls_section, ls_dbms, ls_server, ls_clientver, ls_dbver
long	ll_return

SetPointer(HourGlass!)

ls_file=gnv_app.of_GetAppIniFile()
ls_section="Database"

ll_return = sqlca.of_Init(ls_file, ls_section)
if ll_return = -1 THEN
	MessageBox("Connect","Connection Initial Error")
	return -1
	//HALT CLOSE
END IF

sqlca.of_SetUser(as_userid, as_password)
sqlca.LogID = as_userid
sqlca.LogPass = as_password

ll_return = sqlca.of_Connect()
IF ll_return <> 0 THEN
	MessageBox("Connect to DB Error",& 
		+ string(sqlca.sqldbcode) + " " + sqlca.sqlerrtext)
	return -1
	//HALT CLOSE
END IF

//ls_clientver = This.of_GetVersion()
//SELECT client_version INTO :ls_dbver FROM system_options;
//IF ls_clientver <> ls_dbver THEN
//	MessageBox("Incorrect ABIS version", "You are running " + ls_clientver + &
//	" of the ABIS client, but database is expecting " + ls_dbver + &
//	". Please upgrade your client software."    )
//	return -1
//	//HALT CLOSE
//END IF
//
return 1
end event

event pfc_close;call super::pfc_close;SetPointer(HourGlass!)
IF gl_session > 0 THEN f_user_activity_log("logout")
sqlca.of_DisConnect()

end event

