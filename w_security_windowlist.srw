$PBExportHeader$w_security_windowlist.srw
$PBExportComments$List the windows in the application and scans the ones selected
forward
global type w_security_windowlist from w_main
end type
type dw_windows from u_dw within w_security_windowlist
end type
type cb_exit from u_cb within w_security_windowlist
end type
type cb_cancel from u_cb within w_security_windowlist
end type
type cb_scan from u_cb within w_security_windowlist
end type
end forward

global type w_security_windowlist from w_main
int Width=2745
int Height=1284
boolean TitleBar=true
string Title="Select Windows"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_scanlist ( )
dw_windows dw_windows
cb_exit cb_exit
cb_cancel cb_cancel
cb_scan cb_scan
end type
global w_security_windowlist w_security_windowlist

type variables
Protected:
boolean	ib_canceled
integer	il_gutter
string	is_liblist
string	is_app
n_cst_string inv_string
end variables

event ue_scanlist;call super::ue_scanlist;string error_msg,lib_list,lib_list_array[],temp,win_name, ls_title
int rc,row,ll_num_rows
window iw_created
u_security lnvo_security

ls_title = this.title
temp = is_liblist
rc = 1
do while temp <> ''
	lib_list_array[rc] = inv_string.of_gettoken(temp,';')
	rc ++	
loop
lib_list = inv_string.of_globalreplace(is_liblist,';',',')
if right(lib_list,1) = ',' then lib_list = left(lib_list,len(lib_list) - 1)



rc = lion.setlibrarylist(lib_list)
if rc = -1 then 
	messagebox('','Setlibrraylist may not be called from the development environment. You have to make an exe out of this applicaiotn and then run the application',information!)
	return
elseif rc < -1 then 
	messagebox('','Setlibrraylist failed. return code = '+string(rc)+'~r~n'+lib_list)
	return
end if

ib_canceled = false
cb_cancel.enabled = true

lnvo_security = create u_security

lnvo_security.of_InitScanProcess(SQLCA,is_app,lib_list_array)
rc = dw_windows.setfilter('isSelected()')
rc = dw_windows.filter()
ll_num_rows = dw_windows.rowcount()
dw_windows.selectrow(0,false)
for row = 1 to ll_num_rows
	yield()
	if ib_canceled then exit
	this.title = ls_title + ' ('+string(row)+' of '+string(ll_num_rows)+')'
	dw_windows.scrolltorow(row)
	dw_windows.selectrow(row,true)
	win_name = dw_windows.getitemstring(row,'name')
	gnv_app.ib_creating = true  // trap create errors, this prevents the system error event from acting if there is an error
	iw_created = create using win_name
	gnv_app.ib_creating = false
	lnvo_security.of_ScanWindow(iw_created)
	yield()
	gnv_app.ib_creating = true  // trap destroy errors
	destroy iw_created
	gnv_app.ib_creating = false
next
this.title = ls_title 
dw_windows.selectrow(0,true)

rc = dw_windows.setfilter('')
rc = dw_windows.filter()
rc = dw_windows.sort()
destroy lnvo_security
cb_cancel.enabled = false



end event

on w_security_windowlist.create
int iCurrent
call w_main::create
this.dw_windows=create dw_windows
this.cb_exit=create cb_exit
this.cb_cancel=create cb_cancel
this.cb_scan=create cb_scan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_windows
this.Control[iCurrent+2]=cb_exit
this.Control[iCurrent+3]=cb_cancel
this.Control[iCurrent+4]=cb_scan
end on

on w_security_windowlist.destroy
call w_main::destroy
destroy(this.dw_windows)
destroy(this.cb_exit)
destroy(this.cb_cancel)
destroy(this.cb_scan)
end on

event open;call w_main::open;
is_liblist = message.stringparm
is_app = left(is_liblist,pos(is_liblist,'~t') - 1)
is_liblist = mid(is_liblist,pos(is_liblist,'~t') + 1)

il_gutter = cb_exit.y - (dw_windows.y + dw_windows.height)

dw_windows.of_SetSort(true)
dw_windows.inv_sort.of_SetColumnHeader (true)

cb_cancel.enabled = false


end event

event pfc_postopen;call w_main::pfc_postopen;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_postopen
//
//	Arguments: None
//
//	Returns:  None
//
//	Description:  Scan the list of libraries and extract the windows, adding them to the display datawindow
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
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_list_of_objects,ls_libs,ls_lib_list

setpointer(hourglass!)
ls_lib_list = is_liblist
do while len(ls_lib_list) > 0
	ls_libs = inv_string.of_gettoken(ls_lib_list,';')
	ls_list_of_objects = librarydirectory(ls_libs,Dirwindow!)
	if len(ls_list_of_objects) > 0 then 
		ls_list_of_objects = inv_string.of_globalreplace(ls_list_of_objects,'~r~n','')
		ls_list_of_objects = inv_string.of_globalreplace(ls_list_of_objects,'~r','')
		if right(ls_list_of_objects,1) = '~n' then ls_list_of_objects = left(ls_list_of_objects,len(ls_list_of_objects) -1)
		ls_list_of_objects = ls_libs + '~t' + inv_string.of_globalreplace(ls_list_of_objects,'~n','~n'+ls_libs+'~t')
		ls_list_of_objects = lower(ls_list_of_objects)
		dw_windows.importstring(ls_list_of_objects)
	end if
loop


dw_windows.resetupdate()

end event

event resize;call w_main::resize;int il_third,il_right_edge,il_left_edge

dw_windows.width = newwidth - dw_windows.x
il_third = dw_windows.width / 3
dw_windows.height = newheight - (dw_windows.y + cb_exit.height + il_gutter*2)
il_right_edge = (il_third + cb_exit.width/2) 
il_left_edge = ((dw_windows.width - il_third) - cb_scan.width/2)
if il_right_edge > il_left_edge then 
	il_third += (il_left_edge - il_right_edge)
	if il_third <0 then il_third = 0
end if
cb_scan.move((il_third - cb_scan.width/2),dw_windows.x + dw_windows.height + il_gutter)
cb_exit.move(((dw_windows.width - il_third)  - cb_exit.width/2),cb_scan.y)
cb_cancel.x = cb_scan.x + ((cb_exit.x - cb_scan.x) / 2)
cb_cancel.y = cb_scan.y
end event

type dw_windows from u_dw within w_security_windowlist
event constructor pbm_constructor
int X=1
int Y=1
int Width=2699
int Height=925
int TabOrder=30
string DataObject="d_security_window_list"
end type

event constructor;call u_dw::constructor;this.of_SetRowselect ( true ) 
this.inv_rowselect.of_SetStyle(2)
//this.modify("datawindow.selected.mouse = No")




end event

event pfc_clear;call u_dw::pfc_clear;this.selectrow(0,false)
return 0
end event

type cb_exit from u_cb within w_security_windowlist
event clicked pbm_bnclicked
int X=1537
int Y=964
int TabOrder=40
string Text="E&xit"
end type

event clicked;call u_cb::clicked;close(parent)
end event

type cb_cancel from u_cb within w_security_windowlist
event clicked pbm_bnclicked
int X=1060
int Y=964
int TabOrder=10
string Text="Cancel"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;ib_canceled = true
end event

type cb_scan from u_cb within w_security_windowlist
event clicked pbm_bnclicked
int X=584
int Y=964
int TabOrder=20
string Text="&Scan"
end type

event clicked;call u_cb::clicked;parent.event post ue_scanlist()
end event

