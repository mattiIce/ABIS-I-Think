$PBExportHeader$w_security_applist.srw
$PBExportComments$Lists the applications as found in the pb.ini file
forward
global type w_security_applist from w_main
end type
type dw_applications from u_dw within w_security_applist
end type
type cb_exit from u_cb within w_security_applist
end type
type cb_select from u_cb within w_security_applist
end type
end forward

global type w_security_applist from w_main
int Width=1807
int Height=1178
boolean TitleBar=true
string Title="Select Application"
long BackColor=77956459
dw_applications dw_applications
cb_exit cb_exit
cb_select cb_select
end type
global w_security_applist w_security_applist

type variables
Protected:
integer	il_gutter = 50
string	is_libpath
string	is_pbinifile
end variables

forward prototypes
protected function string of_getpbinifile ()
end prototypes

protected function string of_getpbinifile ();// returns the name of the pb.ini file if it is specified in the win.ini file
// looks for the initpath050 and then initpath entries in the Powerbuilder section
// if both of these two entries do not exist then it assumes that the file name is on the path
// and validates that it can find it by seeing if the current applicaiton has been set

string ls_ini_file, ls_docname, ls_named, ls_path
integer li_value, li_posi

ls_ini_file = ProfileString ( "c:\windows\win.ini", "powerbuilder", "InitPath050", "C:\Pwrs\Pb5i32\PB.INI" )
IF ls_ini_file = "PB.INI" THEN
	ls_ini_file = ProfileString ( "c:\windows\win.ini", "powerbuilder", "InitPath", "C:\Pwrs\Pb5i32\PB.INI" ) 
END IF

IF ls_ini_file <> "PB.INI" THEN
	IF Right(ls_ini_file, 1) = "\" THEN
		ls_ini_file = ls_ini_file + "PB.INI"
	ELSEIF Right(ls_ini_file, 6) <> "PB.INI" THEN
		ls_ini_file = ls_ini_file + "\PB.INI"
	END IF 
ELSE
	MessageBox ( "PB.INI error", "The utility was unable to determine the specific pathname to PB.INI.~n" + & 
		"This is required by this utility.", Information! ) 
	li_value = GetFileOpenName ("Specify the Location of PB.INI", ls_docname, ls_named, "INI", "INI Files (*.INI),*.INI" )	
	IF li_value = 1 THEN 
		ls_ini_file = ls_docname
		li_posi = Pos ( ls_docname, "PB.INI" ) 
		ls_path = Left ( ls_docname, li_posi - 2 )
		SetProfileString ("win.ini", "powerbuilder", "InitPath050", ls_path )
	END IF 
END IF 
	
IF ProfileString ( ls_ini_file, "application", "appname", "not_found") = "not_found" THEN
	Return ""
END IF 

Return ls_ini_file 


end function

on w_security_applist.create
int iCurrent
call w_main::create
this.dw_applications=create dw_applications
this.cb_exit=create cb_exit
this.cb_select=create cb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_applications
this.Control[iCurrent+2]=cb_exit
this.Control[iCurrent+3]=cb_select
end on

on w_security_applist.destroy
call w_main::destroy
destroy(this.dw_applications)
destroy(this.cb_exit)
destroy(this.cb_select)
end on

event open;call w_main::open;dw_applications.of_SetSort(true)
dw_applications.inv_sort.of_SetColumnHeader (true)

end event

event resize;call w_main::resize;int il_third,il_right_edge,il_left_edge,temp

dw_applications.width = newwidth - dw_applications.x
il_third = dw_applications.width / 3
temp = newheight - (dw_applications.y + cb_exit.height + il_gutter*2)
dw_applications.height = newheight - (dw_applications.y + cb_exit.height + il_gutter*2)
il_right_edge = (il_third + cb_exit.width/2) 
il_left_edge = ((dw_applications.width - il_third) - cb_select.width/2)
if il_right_edge > il_left_edge then 
	il_third += (il_left_edge - il_right_edge)
	if il_third <0 then il_third = 0
end if
cb_exit.move((il_third - cb_exit.width/2),dw_applications.y + dw_applications.height + il_gutter)
cb_select.move(((dw_applications.width - il_third)  - cb_select.width/2),cb_exit.y)


end event

event pfc_postopen;call w_main::pfc_postopen;string ls_app, ls_pbl
string ls_keys [],ls_buff
int li_num_keys,li_cnt,li_pos1,li_pos2
n_cst_inifile u_ini

SetPointer ( HourGlass! )
dw_applications.setredraw(false)
//  GET THE PATH-QUALIFIED NAME OF PB.INI
is_pbinifile = this.of_GetPBINIFile ( )
li_num_keys = u_ini.of_GetKeys(is_pbinifile, "application", ls_keys )

FOR li_cnt = 1 to li_num_keys 
	if pos(ls_keys[li_cnt],'$') > 0 then 
		li_pos1 = Pos (ls_keys[li_cnt], "(", 1) 
		li_pos2 = Pos (ls_keys[li_cnt], ")", li_pos1 ) 
		ls_app  = Mid (ls_keys[li_cnt], li_pos1 + 1, li_pos2 - li_pos1 - 1 )
		ls_pbl  = Mid (ls_keys[li_cnt], 2, li_pos1 - 2 ) 
		dw_applications.ImportString ( ls_app + "~t" + ls_pbl)
	end if
NEXT 

dw_applications.Sort()
dw_applications.setredraw(true)
dw_applications.resetupdate()
dw_applications.ScrolltoRow ( 1 )
dw_applications.Event  RowFocusChanged(1)
end event

type dw_applications from u_dw within w_security_applist
int X=40
int Y=17
int Width=1689
int Height=890
int TabOrder=20
string DataObject="d_security_pb_ini_applications"
end type

event doubleclicked;call super::doubleclicked;
string ls_app_name,ls_clean_app_name,ls_return

if isnull(row) then row = 0
IF row = 0 THEN
	row = this.getrow()
	if row = 0 then return
end if
	

ls_clean_app_name = this.object.app[row]
is_libpath = this.object.pbl[row]
ls_app_name = '$'+is_libpath+'('+ls_clean_app_name+')'

ls_return = ls_clean_app_name + '~t' + profilestring(is_pbinifile,"Application",ls_app_name,'')
openwithparm ( w_security_windowlist, ls_return)
close(parent)

end event

event rowfocuschanged;call u_dw::rowfocuschanged;if isnull(currentrow) then 
	currentrow = this.getrow()
end if

IF currentrow = 0 THEN Return

this.SelectRow ( 0, FALSE )
this.SelectRow ( currentrow, TRUE )
end event

type cb_exit from u_cb within w_security_applist
int X=317
int Y=922
int TabOrder=30
string Text="E&xit"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;close(parent)
end event

type cb_select from u_cb within w_security_applist
int X=993
int Y=922
int TabOrder=10
string Text="&Select"
boolean Default=true
end type

event clicked;call u_cb::clicked;dw_applications.postevent(doubleclicked!)
end event

