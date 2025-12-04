$PBExportHeader$w_mylogon.srw
$PBExportComments$First screen of applications of this system used for user logon to
forward
global type w_mylogon from w_sheet
end type
type st_db from statictext within w_mylogon
end type
type st_1 from u_st within w_mylogon
end type
type st_3 from u_st within w_mylogon
end type
type st_2 from u_st within w_mylogon
end type
type sle_password from u_sle within w_mylogon
end type
type sle_userid from u_sle within w_mylogon
end type
type cb_cancel from u_cb within w_mylogon
end type
type cb_ok from u_cb within w_mylogon
end type
type p_logo from u_p within w_mylogon
end type
type st_help from u_st within w_mylogon
end type
end forward

global type w_mylogon from w_sheet
integer width = 2330
integer height = 666
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
boolean center = true
event ue_cancel ( )
event ue_default ( )
st_db st_db
st_1 st_1
st_3 st_3
st_2 st_2
sle_password sle_password
sle_userid sle_userid
cb_cancel cb_cancel
cb_ok cb_ok
p_logo p_logo
st_help st_help
end type
global w_mylogon w_mylogon

type prototypes
FUNCTION long GetComputerNameA (ref string ComputerName, ref ulong BufferLength) LIBRARY "KERNEL32.DLL"
FUNCTION long GetUserNameA(ref string UserName, ref ulong BufferLength) LIBRARY "ADVAPI32.DLL"

Function boolean GetFileTime (ulong hFile, ref time lpCreationTime, ref time lpLastAccessTime, ref time lpLastWriteTime) Library "KERNEL32.DLL"
end prototypes

type variables
integer		ii_logonattempts = 1
String		is_dbname //Alex Gerlants. 04/15/2016. Use is_dbname in ue_default event to populate application frame title bar (w_lion_sys_frame.Title)
end variables

forward prototypes
public function integer wf_get_computer_user_name (ref string as_computername, ref string as_username)
public function boolean wf_abis_same (ref datetime adt_filedatetime_old, ref datetime adt_filedatetime_new)
public function integer wf_insert_abis_release (str_all_data_types astr_all_data_types)
public function integer wf_read_test_or_prod_file (ref str_all_data_types astr_all_data_types)
public function integer wf_abis_release ()
end prototypes

event ue_cancel();gnv_logonattrib.ii_rc = 0

gnv_logonattrib.is_userid = ""
Close(this)
gnv_app.Event pfc_Exit()
end event

event ue_default();
integer	li_rc
String	ls_user //Alex Gerlants. 10/17/2016
Boolean	lb_rtn //Alex Gerlants. 10/17/2016

//////////////////////////////////////////////////////////////////////////////
// Check required fields
//////////////////////////////////////////////////////////////////////////////
if Len (sle_userid.text) = 0 then
	of_MessageBox ("pfc_logon_enterid", gnv_logonattrib.is_appname, &
		"Please enter a User ID to logon.", exclamation!, OK!, 1)
	sle_userid.SetFocus()
	return
end if
if Len (sle_password.text) = 0 then
	of_MessageBox ("pfc_logon_enterpassword", gnv_logonattrib.is_appname, &
		"Please enter a password to logon.", exclamation!, OK!, 1)
	sle_password.SetFocus()
	return
end if
if Isnull(gnv_logonattrib.ipo_source) or Not IsValid (gnv_logonattrib.ipo_source) then
	this.event ue_cancel()
	return
End If

//////////////////////////////////////////////////////////////////////////////
// Attempt to logon
//////////////////////////////////////////////////////////////////////////////
ii_logonattempts --
li_rc = gnv_logonattrib.ipo_source.dynamic event pfc_logon &
	(sle_userid.text, sle_password.text)
if IsNull (li_rc) then 
	this.event ue_cancel()
	return
ElseIf li_rc <= 0 Then
	If ii_logonattempts > 0 Then
		// There are still have more attempts for a succesful login.
		of_MessageBox ("pfc_logon_incorrectpassword", "Login", &
			"The password is incorrect.", StopSign!, Ok!, 1)
		sle_password.SetFocus()
		Return
	Else
		// Failure return code
		gnv_logonattrib.ii_rc = -1	
		this.Event ue_cancel()
	End If
Else
	// Successful return code
	
	//Alex Gerlants 04/15/2016. Begin
	//Update frame title with database name
	w_lion_sys_frame.Title = w_lion_sys_frame.Title + " - Database: " + is_dbname + "  User: " + sle_userid.text
	//Alex Gerlants 04/15/2016. End
	
	gnv_logonattrib.ii_rc = 1
	gnv_logonattrib.is_userid = sle_userid.text
	gnv_logonattrib.is_password = sle_password.text	
	
		
	//Set role explicitly
	string ls_setrole, ls_clientver, ls_dbver
	ls_setrole = "set role update_role identified by obd#157"
	EXECUTE IMMEDIATE :ls_setrole USING SQLCA;
	
	n_cst_platformwin32 inv_platform
	f_SetPlatform(inv_platform, TRUE)
	inv_platform.of_playSound("Reminder.wav")
	
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
	
	if Len (gnv_logonattrib.is_userid) > 0 then
		if gnv_app.of_IsRegistryAvailable() then
			//RegistrySet (is_userkey + "\logon", "userid", gnv_logonattrib.is_userid)
		else
			//SetProfileString (is_userinifile, "logon", "userid", gnv_logonattrib.is_userid)
		end if

		gnv_app.of_SetUserID (gnv_logonattrib.is_userid)
	end if


	f_user_activity_log("login")
	Close(this)
	
	String ls_rc
	ls_rc = ProfileString(gs_ini_file, "APPLICATION","location","Office")
	
	if Upper(ls_rc) =  "SCAN" then
		//Message.StringParm = "w_display_app_scan"
		//w_lion_sys_frame.Event pfc_open()
		open(w_display_app_scan)
		close(w_lion_sys_frame)
	end if


End if

//Alex Gerlants. 10/17/2016. Begin
ls_user = gnv_app.of_GetUserId()

If li_rc = 1 Then //OK above
	If IsValid(m_lion_sys_frame.m_system.m_13) Then
		lb_rtn = f_validate_user_app(ls_user, "Table yield_strength", sqlca)
		
		If lb_rtn Then
			m_lion_sys_frame.m_system.m_13.Visible = True //"Table yield_strength" menu option visible
		Else
			m_lion_sys_frame.m_system.m_13.Visible = False //"Table yield_strength" menu option not visible
		End If
	End If
End If
//Alex Gerlants. 10/17/2016. End

//Alex Gerlants. 08/08/2017. Begin
select	value
into		:gs_albl_email_address
from 		dbo.abis_ini
where		lower(process) = 'application'
and		lower(section) = 'variables'
using		sqlca;

If sqlca.sqlcode <> 0 Then
	gs_albl_email_address = "albl.com"
End If

If Left(gs_albl_email_address, 1) <> "@" Then
	gs_albl_email_address = "@" + gs_albl_email_address
End If
//Alex Gerlants. 08/08/2017. End

Return
end event

public function integer wf_get_computer_user_name (ref string as_computername, ref string as_username);//Alex_Get_Computer_Name. 10/16/2019. Begin
/*
Function:	wf_get_computer_user_name
Returns:		integer 	 1 if ok
							-1 if error
Arguments:	reference	string	as_computername
				reference	string	as_username
*/

Long		li_rtn_computername, li_rtn_username, li_rtn = 1
String	ls_ComputerName, ls_UserName
Ulong		BufferLength = 250
Boolean	lb_abis_same

ls_ComputerName = Space(BufferLength)
ls_UserName     = Space(BufferLength)

li_rtn_computername = GetComputerNameA(ls_ComputerName, BufferLength)
li_rtn_username = GetUserNameA(ls_UserName, BufferLength)

If li_rtn_computername = 1 And li_rtn_username = 1 Then //OK
	//li_rtn = 1
	as_computername = ls_computername
	as_username = ls_username
Else //Error
	//li_rtn = -1 //Do not stop. Just let the user know.
	
	MessageBox("Error getting computer and user name",  "wf_get_computer_user_name for w_mylogon in silverdome.pbl." + "~n~r" + &
	                        									 "Please call abis support")
End If

Return li_rtn
//Alex_Get_Computer_Name. 10/16/2019. End
end function

public function boolean wf_abis_same (ref datetime adt_filedatetime_old, ref datetime adt_filedatetime_new);//Alex_Get_Computer_Name. 10/16/2019. Begin
/*
Function:	wf_abis_same
Returns:		boolean <== 1 if new abis file creation date is equal to old abis file creation date
                        0 if new abis file creation date is later than old abis file creation date
Arguments:	reference	datetime	adt_filedatetime_old
				reference	datetime	adt_filedatetime_new
*/

Boolean					lb_abis_same = True
Boolean					lb_isdate, lb_istime
Long						ll_pos, ll_days_difference
String					ls_ComputerName, ls_UserName
Date						ld_filedate_old, ld_filedate_new
Time						lt_filetime_old, lt_filetime_new
String					ls_test_or_prod_file, ls_test_or_prod, ls_test_old, ls_test_new, ls_release_old, ls_release_new
String					ls_filedatetime, ls_date, ls_time
Integer					li_pos, li_filenum, li_rtn

String					ls_computer_name, ls_user_name
DateTime					ldt_current_build_dttm, ldt_new_build_dttm, ldt_install_dttm
str_all_data_types	lstr_all_data_types

ls_test_or_prod_file = f_get_ini_value("abis_release","files","test_or_prod","c:\abis\test_or_prod.txt")

//ls_test_old = f_get_ini_value("abis_release","files","test_old","c:\abis_test\abis.exe")
//ls_test_new = f_get_ini_value("abis_release","files","test_new","i:\abis_test\abis.exe")
//
//ls_release_old = f_get_ini_value("abis_release","files","release_old","c:\abis\abis.exe")
//ls_release_new = f_get_ini_value("abis_release","files","release_new","i:\abis_release\abis.exe")

li_filenum = FileOpen (ls_test_or_prod_file, LineMode!, Read!)
FileRead(li_FileNum, ls_test_or_prod)

Choose Case Upper(Trim(ls_test_or_prod))
	Case "TEST"
		MessageBox("wf_abis_same. TEST or PROD", "TEST")
	Case "PROD"
		MessageBox("wf_abis_same. TEST or PROD", "PROD")
	Case Else
		Return False
End Choose



//Update table abis_release
lstr_all_data_types.string_var[1] = ls_computer_name
lstr_all_data_types.string_var[2] = ls_user_name
lstr_all_data_types.datetime_var[1] = ldt_current_build_dttm
lstr_all_data_types.datetime_var[2] = ldt_new_build_dttm
lstr_all_data_types.datetime_var[3] = ldt_install_dttm
lstr_all_data_types.string_var[3] = ls_test_or_prod

li_rtn = wf_insert_abis_release(lstr_all_data_types)

If li_rtn = -1 Then //DB Error in wf_insert_abis_release()

End If

//---

////Get the old abis file date/time
//If Upper(ls_test_or_prod) = "TEST" Then
//	ls_filedatetime = f_file_last_mod(ls_test_old)
//Else
//	ls_filedatetime = f_file_last_mod(ls_release_old)
//End If
//
//li_pos = Pos(ls_filedatetime, " ", 1)
//
//If li_pos > 0 Then
//	ls_date = Left(ls_filedatetime, li_pos - 1)
//	lb_isdate = IsDate(ls_date)
//	
//	ls_time = Right(ls_filedatetime, Len(ls_filedatetime) - li_pos)
//	lb_istime = IsTime(ls_time)
//	
//	If lb_isdate And lb_istime Then
//		ld_filedate_old = Date(ls_date)
//		lt_filetime_old = Time(ls_time)
//		adt_filedatetime_old = DateTime(ld_filedate_old, lt_filetime_old)
//	End If
//End If
//	
////---
//	
////Get the new abis file date/time
//If Upper(ls_test_or_prod) = "TEST" Then
// 	ls_filedatetime = f_file_last_mod(ls_test_new)
//Else
//	ls_filedatetime = f_file_last_mod(ls_release_new)
//End If
//
//li_pos = Pos(ls_filedatetime, " ", 1)
//
//If li_pos > 0 Then
//	ls_date = Left(ls_filedatetime, li_pos - 1)
//	lb_isdate = IsDate(ls_date)
//	
//	ls_time = Right(ls_filedatetime, Len(ls_filedatetime) - li_pos)
//	lb_istime = IsTime(ls_time)
//	
//	If lb_isdate And lb_istime Then
//		ld_filedate_new = Date(ls_date)
//		lt_filetime_new = Time(ls_time)
//		adt_filedatetime_new = DateTime(ld_filedate_new, lt_filetime_new)
//	End If
//End If
//
//ll_days_difference = DaysAfter(ld_filedate_old, ld_filedate_new)
//
//If ll_days_difference > 0 Then
//	lb_abis_same = False
//End If

Return lb_abis_same
//Alex_Get_Computer_Name. 10/16/2019. End
end function

public function integer wf_insert_abis_release (str_all_data_types astr_all_data_types);//Alex_Get_Computer_Name. 10/16/2019. Begin
/*
Function:	wf_insert_abis_release
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	str_all_data_types	astr_all_data_types
*/

Integer	li_rtn = 1
String	ls_install_computer, ls_install_user, ls_test_or_prod
String	ls_current_build_dttm, ls_new_build_dttm, ls_install_dttm
DateTime	ldt_current_build_dttm, ldt_new_build_dttm, ldt_install_dttm

ls_install_computer = astr_all_data_types.string_var[1]
ls_install_user = astr_all_data_types.string_var[2]
ldt_current_build_dttm = astr_all_data_types.datetime_var[1]
ldt_new_build_dttm = astr_all_data_types.datetime_var[2]
ldt_install_dttm = astr_all_data_types.datetime_var[3]
ls_test_or_prod = astr_all_data_types.string_var[3]

ls_current_build_dttm = String(ldt_current_build_dttm)
ls_new_build_dttm = String(ldt_new_build_dttm)
ls_install_dttm = String(ldt_install_dttm)

//insert into dbo.abis_release values ('PREYNOLDS-T540', 'AGerlants', to_date('09/17/2019 10:15:20', 'mm/dd/yyyy hh24:mi:ss'), to_date('10/12/2019 09:10:59', 'mm/dd/yyyy hh24:mi:ss'), to_date('10/17/2019 14:59:58', 'mm/dd/yyyy hh24:mi:ss'), 'prod') using	sqlca;
//insert into dbo.abis_release values (ls_install_computer, ls_install_user, to_date(ls_current_build_dttm, 'mm/dd/yyyy hh24:mi:ss'), to_date(ls_new_build_dttm, 'mm/dd/yyyy hh24:mi:ss'),  to_date(ls_install_dttm, 'mm/dd/yyyy hh24:mi:ss'), ls_test_or_prod) using sqlca;


insert into dbo.abis_release
(
  install_computer,
  install_user,
  current_build_dttm,
  new_build_dttm,
  install_dttm,
  test_or_prod
)
values
(
  :ls_install_computer,
  :ls_install_user,
  :ldt_current_build_dttm,
  :ldt_new_build_dttm,
  :ldt_install_dttm,
  :ls_test_or_prod
)
using	sqlca;


If sqlca.sqlcode = 0 Then //OK
	commit using sqlca;
Else //DB error
	li_rtn = -1
	MessageBox("DB error", 	"Database error in wf_insert_abis_release for w_mylogon while trying to update table abis_release" + &
									"~n~r~n~rDB Error:~n~r" + sqlca.sqlerrtext + &
									"~n~r~n~rApplication will close now.~n~rPlease notify abis support.")
	rollback using sqlca;
End If

Return li_rtn
end function

public function integer wf_read_test_or_prod_file (ref str_all_data_types astr_all_data_types);//Alex_Get_Computer_Name. 10/16/2019. Begin
/*
Function:	wf_read_test_or_prod_file
Returns:		integer					 1 if OK
											-1 if error
											 0 if file does not exist
Arguments:	str_all_data_types	astr_all_data_types
*/

Integer		li_filenum, li_rtn = 1, li_number_of_characters_read, li_counter, li_i
Boolean		lb_file_exists
Long			ll_pos1, ll_pos2, ll_start_pos, ll_pos_space
String		ls_test_or_prod_file, ls_test_or_prod, ls_line, ls_line_arr[], ls_date, ls_time, ls_temp
String		ls_computer_name, ls_user_name
DateTime		ldt_current_build_dttm, ldt_new_build_dttm, ldt_temp

ls_test_or_prod_file = f_get_ini_value("abis_release","files","test_or_prod","c:\abis\test_or_prod.txt")

lb_file_exists = FileExists(ls_test_or_prod_file)

If Not lb_file_exists Then Return 0 //Nothing to do

li_filenum = FileOpen(ls_test_or_prod_file, LineMode!, Read!) //LineMode! = Read 1 line at the time

If li_FileNum < 1 Then
	Return -1
End If

li_counter = 0

//There is only 1 line in this file. It has 3 values separated by "||"
Do Until li_number_of_characters_read = -100 //-100 = End of File
	li_number_of_characters_read = FileRead(li_FileNum, ls_line)
	
	If li_number_of_characters_read <> -100 Then
		li_counter++
		ls_line_arr[li_counter] = ls_line
	End If
Loop

For li_i = 1 To li_counter
	ls_line = ls_line_arr[li_i]
	ll_start_pos = 1
	
	ll_pos1 = Pos(ls_line, "||", ll_start_pos)
	
	If ll_pos1 > 0 Then
		ll_start_pos = ll_pos1 + 1
		
		ll_pos2 = Pos(ls_line, "||", ll_start_pos)
		
		If ll_pos2 > 0 Then
			ls_test_or_prod = Left(ls_line, ll_pos1 - 1)
			
			//Get current build date and time
			ls_temp = Mid(ls_line, ll_pos1 + 2, ll_pos2 - ll_pos1 - 2) //Date and Time separated by " "
			ll_pos_space = Pos(ls_temp, " ", 1)
			
			If ll_pos_space > 0 Then			
				ls_date = Trim(Left(ls_temp, ll_pos_space - 1))
				ls_time = Trim(Right(ls_temp, Len(ls_temp) - ll_pos_space))
				
				If Isdate(ls_date) And IsTime(ls_time) Then
					ldt_current_build_dttm = DateTime(Date(ls_date), Time(ls_time))
				End If
			End If
			
			//Get new build date and time
			ls_temp = Right(ls_line, Len(ls_line) - ll_pos2 - 1)
			
			ll_pos_space = Pos(ls_temp, " ", 1)
			
			If ll_pos_space > 0 Then
				ls_date = Trim(Left(ls_temp, ll_pos_space - 1))
				ls_time = Trim(Right(ls_temp, Len(ls_temp) - ll_pos_space))
				
				If Isdate(ls_date) And IsTime(ls_time) Then
					ldt_new_build_dttm = DateTime(Date(ls_date), Time(ls_time))
				End If
			End If
		End if
	End If
Next

FileClose(li_filenum)

astr_all_data_types.datetime_var[1] = ldt_current_build_dttm //Comes from ls_test_or_prod_file
astr_all_data_types.datetime_var[2] = ldt_new_build_dttm //Comes from ls_test_or_prod_file
astr_all_data_types.string_var[3] = ls_test_or_prod //Comes from ls_test_or_prod_file

Return li_rtn
//Alex_Get_Computer_Name. 10/16/2019. End
end function

public function integer wf_abis_release ();//Alex_Get_Computer_Name. 10/16/2019. Begin
/*
Function:	wf_abis_release
Returns:		integer	 1 if OK
							-1 if error
Arguments:	none
*/

Integer					li_rtn
String					ls_computerName, ls_username, ls_abis_test_or_prod
Boolean					lb_abis_same
DateTime					ldt_install_dttm, ldt_filedatetime_old, ldt_filedatetime_new
str_all_data_types	lstr_all_data_types

li_rtn = wf_get_computer_user_name(ls_computername, ls_username) //ls_ComputerName, ls_UserName are passed back by reference from wf_get_computer_user_name()

If li_rtn = 1 Then //OK in wf_get_computer_user_name()
	li_rtn = wf_read_test_or_prod_file(lstr_all_data_types) //lstr_all_data_types is passed back from wf_read_test_or_prod_file() by reference

	//lstr_all_data_types.datetime_var[1] = ldt_current_build_dttm //Comes from wf_read_test_or_prod_file()
	//lstr_all_data_types.datetime_var[2] = ldt_new_build_dttm //Comes from wf_read_test_or_prod_file()
	//lstr_all_data_types.string_var[3] = ls_test_or_prod //Comes from wf_read_test_or_prod_file()
	
	//li_rtn = 0 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

	If li_rtn = 1 Then //OK in wf_read_test_or_prod_file()
		lstr_all_data_types.string_var[1] = ls_computername
		lstr_all_data_types.string_var[2] = ls_username
		ldt_install_dttm = DateTime(Today(), Now())
		lstr_all_data_types.datetime_var[3] = ldt_install_dttm
		
		li_rtn = wf_insert_abis_release(lstr_all_data_types)
	End If
End If

Return li_rtn

//---


////ls_abis_test_or_prod = ""                      //This file has 1 row: either "TEST" or "PROD"
//                                               //If "TEST" I use "C:\abis_test\abis.exe" to compare to "I:\abis_test"
//															  //If "PROD" I use "C:\abis\abis.exe" to compare to "I:\abis_release"
//                                               
////ls_old_abis = "C:\abis\abis.exe"               //This should come from lion.ini
////ls_new_abis = "V:\Dev\silverdome9\abis.exe"    //This should come from lion.ini
//
//lb_abis_same = wf_abis_same(ldt_filedatetime_old, ldt_filedatetime_new)
//
//If Not lb_abis_same Then
//	//Update table ... here
//	//Table: abis_release:     computer_name  user_name  datetime_old  datetime_new
//End If
//Alex_Get_Computer_Name. 10/16/2019. End
end function

on w_mylogon.create
int iCurrent
call super::create
this.st_db=create st_db
this.st_1=create st_1
this.st_3=create st_3
this.st_2=create st_2
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.p_logo=create p_logo
this.st_help=create st_help
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_db
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_password
this.Control[iCurrent+6]=this.sle_userid
this.Control[iCurrent+7]=this.cb_cancel
this.Control[iCurrent+8]=this.cb_ok
this.Control[iCurrent+9]=this.p_logo
this.Control[iCurrent+10]=this.st_help
end on

on w_mylogon.destroy
call super::destroy
destroy(this.st_db)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.p_logo)
destroy(this.st_help)
end on

event close;call super::close;if gnv_logonattrib.ii_rc=-99 then
	this.event ue_cancel ()
end if
end event

event open;call super::open;ib_disableclosequery = true

// Validate for a valid PowerObjectParm
If NOT(IsValid(gnv_logonattrib)) Then
	// Set the return code to mean the window was closed by error.
	gnv_logonattrib.ii_rc = -1
	gnv_logonattrib.is_userid = ""
	Close(this)
	Return
End If

// User ID
sle_userid.text = gnv_logonattrib.is_userid

// Password
sle_password.text = gnv_logonattrib.is_password

//DB name
String ls_rc
Int li_pos

// ls_rc = ProfileString(gs_ini_file, "DATABASE","ServerName","PDB")
ls_rc = ProfileString(gs_ini_file, "DATABASE","ServerName","PDB")

//Alex Gerlants. 04/15/2016. 
//Commented out the 2 lines below to fix a bug that displays "DB" instead of displaying full database name from lion.ini
//li_pos = Pos(ls_rc, "_")
//ls_rc = Mid(ls_rc, 2, (li_pos - 2))

st_db.Text = Upper(ls_rc) 

is_dbname = ls_rc //Alex Gerlants. 04/15/2016. Use is_dbname in ue_default event to populate application frame title bar (w_lion_sys_frame.Title)


// Logo
If Len(gnv_logonattrib.is_logo) > 0 Then
	p_logo.picturename = gnv_logonattrib.is_logo
Else
	p_logo.Visible = False
End If

// Application Name
if Len (gnv_logonattrib.is_appname) = 0 then
	gnv_logonattrib.is_appname = "the application"	
end if
st_help.text = st_help.text + gnv_logonattrib.is_appname + "."

// Set the logon attempts variable
If IsValid(gnv_logonattrib) Then
	If Not IsNull(gnv_logonattrib.ii_logonattempts) Then
		ii_logonattempts = gnv_logonattrib.ii_logonattempts
	End If
End If

// Set focus
if Len (sle_userid.text) > 0 then
	if Len (sle_password.text) > 0 then
		cb_ok.SetFocus()
	else
		sle_password.SetFocus()
	end if
else
	sle_userid.SetFocus()
end if

//Alex_Auto_Start_Auto_Inventory_Report. 10/22/2018. Begin
gs_auto_start_auto_report = Upper(ProfileString(gs_ini_file,"AUTO_INVENTORY_REPORT","auto_start", "n")) //from lion.ini file

If gs_auto_start_auto_report = "Y" Then
	sle_userid.Text = "dbo"
	sle_password.Text = "obd#157"
	cb_ok.Event Clicked()
End If
//Alex_Auto_Start_Auto_Inventory_Report. 10/22/2018. End


end event

event closequery;call super::closequery;////Alex_Get_Computer_Name. 10/16/2019. Begin
//Integer	li_rtn
//
//If gnv_logonattrib.ii_rc = 1 Then //User logged in successfully
//	li_rtn = wf_abis_release()
//	
//	If li_rtn = -1 Then //Error in wf_abis_release()
//		//gnv_app.Event pfc_Exit() //Exit application
//		Halt Close
//	End If
//End If
////Alex_Get_Computer_Name. 10/16/2019. End
end event

type st_db from statictext within w_mylogon
integer x = 702
integer y = 445
integer width = 1053
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "DB"
boolean focusrectangle = false
end type

type st_1 from u_st within w_mylogon
integer x = 453
integer y = 445
integer width = 238
integer height = 77
string text = "Database:"
alignment alignment = right!
end type

type st_3 from u_st within w_mylogon
integer x = 450
integer y = 349
integer width = 241
integer height = 77
string text = "Password:"
alignment alignment = right!
end type

type st_2 from u_st within w_mylogon
integer x = 450
integer y = 250
integer width = 241
integer height = 77
string text = "User ID:"
alignment alignment = right!
end type

type sle_password from u_sle within w_mylogon
integer x = 720
integer y = 346
integer width = 1090
integer taborder = 40
boolean autohscroll = true
boolean password = true
end type

event constructor;call u_sle::constructor;this.ib_autoselect = true
end event

type sle_userid from u_sle within w_mylogon
integer x = 720
integer y = 240
integer width = 1090
integer taborder = 30
boolean autohscroll = true
end type

event constructor;call u_sle::constructor;this.ib_autoselect = true
end event

type cb_cancel from u_cb within w_mylogon
integer x = 1883
integer y = 224
integer width = 351
integer height = 93
integer taborder = 20
string text = "Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;Parent.Event ue_cancel()
end event

type cb_ok from u_cb within w_mylogon
integer x = 1883
integer y = 67
integer width = 351
integer height = 93
integer taborder = 10
string text = "OK"
boolean default = true
end type

event clicked;call super::clicked;Parent.Event ue_default()
//Parent.Dynamic Event ue_abis_release() //Alex_Get_Computer_Name. 10/16/2019
end event

type p_logo from u_p within w_mylogon
integer width = 161
boolean originalsize = true
end type

type st_help from u_st within w_mylogon
integer x = 505
integer y = 83
integer width = 1317
integer height = 125
long backcolor = 79741120
string text = "Enter a User ID and password to log onto "
end type

