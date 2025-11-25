$PBExportHeader$w_security_infomgmt.srw
$PBExportComments$Manage window/control/user relationships
forward
global type w_security_infomgmt from w_sheet
end type
type tv_apps from u_tv within w_security_infomgmt
end type
type dw_controls from u_dw within w_security_infomgmt
end type
type st_bar from statictext within w_security_infomgmt
end type
type rb_active from u_rb within w_security_infomgmt
end type
type rb_all from u_rb within w_security_infomgmt
end type
type gb_display from u_gb within w_security_infomgmt
end type
type ddplb_users from dropdownpicturelistbox within w_security_infomgmt
end type
type st_users from u_st within w_security_infomgmt
end type
end forward

global type w_security_infomgmt from w_sheet
int Width=2905
int Height=1636
boolean TitleBar=true
string Title="User/Window Management"
string MenuName="m_security_info_mgmt"
long BackColor=77956459
tv_apps tv_apps
dw_controls dw_controls
st_bar st_bar
rb_active rb_active
rb_all rb_all
gb_display gb_display
ddplb_users ddplb_users
st_users st_users
end type
global w_security_infomgmt w_security_infomgmt

type variables
protected:
constant string lcs_tab = '~t'
boolean	ib_mousedown
integer	ii_baroffset = 15
long		il_originalcolor
string		is_app
string		is_window
string		is_user
string		is_controlfilter
dragobject	idrg_prevobj
n_ds			ids_users
n_ds			ids_controls
end variables

forward prototypes
protected subroutine of_SetFilter ()
protected function integer of_loadcontrols ()
end prototypes

protected subroutine of_SetFilter ();//////////////////////////////////////////////////////////////////////////////
//
//	Function: of_SetFilter
//
//	Access:  protected
//
//	Arguments : None
//
//	Returns:  None
//
//	Description:  Filter the dw_controls datawindow
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
string ls_filter
ls_filter = "application =  '"+ is_app + "' and window = '"+is_window+"' and user_name = '"+is_user+"'"+is_controlfilter

if dw_controls.setfilter(ls_filter) < 1 then
	messagebox('Selectionchanging',ls_filter)
end if
dw_controls.filter()
dw_controls.sort()


end subroutine

protected function integer of_loadcontrols ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_LoadControls
//
//	Access:  protected
//
//	Arguments : None
//
//	Returns:  integer
//				1 = success
//				-1 = failure
//
//	Description:  for the current, application, window and user; populate the dw_control datawindow
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
integer li_rc
long ll_row,ll_num_controls,ll_row_found,ll_num_rows
string ls_control , ls_buffer, ls_row,ls_desc,ls_object_type,ls_exp
boolean lb_filter

// all keys must be present 
if len(is_app) = 0 or len(is_window) = 0 or len(is_user) = 0 then return -1

lb_filter = rb_all.checked 
dw_controls.setredraw(false)
rb_all.event clicked() // set the all filter

if dw_controls.rowcount() = 0 then // ok, first time retrival to we need to add in all of the controls that are not currently set 
	ll_num_rows = dw_controls.retrieve(is_app,is_window,is_user)
	
	ll_num_controls = ids_controls.retrieve(is_app,is_window) // first get the list of controls for this window
	for ll_row = 1 to ll_num_controls
		ls_control = ids_controls.object.control[ll_row]
		ls_exp = 'Control = "'+ls_control+'"'
		ll_row_found = dw_controls.find(ls_exp,1,ll_num_rows)
		if ll_row_found = 0 then // not already on the list so lets add the control
			ls_desc = ids_controls.object.description[ll_row]
			ls_object_type = ids_controls.object.object_type[ll_row]
			ls_row = is_app + lcs_tab + is_window + lcs_tab +  ls_control +  lcs_tab + is_user + lcs_tab + 'N' + lcs_tab + ls_desc + lcs_tab + ls_object_type
			if len(ls_buffer) = 0 then
				ls_buffer = ls_row
			else
				ls_buffer = ls_buffer + '~r~n' + ls_row
			end if
		end if
	next		
	dw_controls.importstring(ls_buffer)
	lb_filter = true  // sine this is a new entry let's show all of the controls
end if
// reset everything back
if lb_filter then 
	rb_active.checked = false
	rb_all.checked = true
	rb_all.event clicked()
else
	rb_all.checked = false
	rb_active.checked = true
	rb_active.event clicked()
end if
dw_controls.setredraw(true)

return 1

end function

on w_security_infomgmt.create
int iCurrent
call w_sheet::create
if this.MenuName = "m_security_info_mgmt" then this.MenuID = create m_security_info_mgmt
this.tv_apps=create tv_apps
this.dw_controls=create dw_controls
this.st_bar=create st_bar
this.rb_active=create rb_active
this.rb_all=create rb_all
this.gb_display=create gb_display
this.ddplb_users=create ddplb_users
this.st_users=create st_users
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tv_apps
this.Control[iCurrent+2]=dw_controls
this.Control[iCurrent+3]=st_bar
this.Control[iCurrent+4]=rb_active
this.Control[iCurrent+5]=rb_all
this.Control[iCurrent+6]=gb_display
this.Control[iCurrent+7]=ddplb_users
this.Control[iCurrent+8]=st_users
end on

on w_security_infomgmt.destroy
call w_sheet::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tv_apps)
destroy(this.dw_controls)
destroy(this.st_bar)
destroy(this.rb_active)
destroy(this.rb_all)
destroy(this.gb_display)
destroy(this.ddplb_users)
destroy(this.st_users)
end on

event open;call w_sheet::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_pfcsecurity_info_mgmt
//
//	Description:  Allows the setting of security for a window user combination
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

ddplb_users.AddPicture("Custom076!")
ddplb_users.AddPicture("Group!")

ii_baroffset = 5
il_originalcolor = st_bar.backcolor
st_bar.setposition(Totop!)

st_bar.event mouseup(0,0,0) // force a redraw of the controls

dw_controls.settransobject(SQLCA)
dw_controls.of_SetSort(true) // turn on sorting
dw_controls.inv_sort.of_SetColumnHeader (true) // use header clicking only for sorting


end event

event resize;call w_sheet::resize;// resize to fit
tv_apps.Height = newheight - tv_apps.Y
dw_controls.Height = tv_apps.Height - dw_controls.y
st_bar.Height = tv_apps.Height + 70

dw_controls.Width = newwidth - (dw_controls.X + ii_baroffset)

end event

event pfc_postopen;call w_sheet::pfc_postopen;// set up the treeviews, create and populate the datastores

long li_cnt,li_row
integer li_picture
string ls_entry
// Register the datasource for each level of the tree
// Parameters are: level, datawindow object, transaction object, column to display as the label, 
// the retrieval arguments, and whether the DW object is to be used recursively.
li_picture = tv_apps.AddPicture("application!")
tv_apps.of_SetDatasource(1, "d_security_applications", SQLCA, "description", "", False, li_picture,li_picture)
li_picture = tv_apps.AddPicture("window!")
tv_apps.of_SetDatasource(2, "d_security_windows", SQLCA, "window", ":parent.1.application", False, li_picture,li_picture)
tv_apps.of_InitialRetrieve()

ids_users = create n_ds
ids_users.dataobject = 'd_security_users'
ids_users.settransobject(SQLCA)

ids_controls = create n_ds
ids_controls.dataobject = 'd_security_templateupdate'
ids_controls.settransobject(SQLCA)

li_cnt = ids_users.retrieve() // populate the users drop down list box
for li_row = 1 to li_cnt
	if ids_users.object.user_type[li_row] = 0 then
		li_picture = 1
	else
		li_picture = 2
	end if
	ls_entry = ids_users.object.name[li_row] +' : '+ids_users.object.description[li_row] 
	ddplb_users.additem(ls_entry,li_picture)
next


end event

event close;call w_sheet::close;// destroy created controls
destroy ids_users
destroy ids_controls
end event

event pfc_endtran;call w_sheet::pfc_endtran;// commit the transaction
commit using SQLCA;
return SQLCA.sqlcode 
end event

event pfc_postupdate;call w_sheet::pfc_postupdate;// clear and reload the controls datawindow
dw_controls.reset()
of_LoadControls()
return 1
end event

event pfc_preupdate;call w_sheet::pfc_preupdate;
// We need to do several things here
// 1. Discard (not delete) all rows that are marked as newunmodified
// 2. Discard all rows that are marked as newmodfied and have a status of 'NotSet'
// 3. Delete all rows that have a status of 'NotSet'


long ll_num_rows
integer li_rc

dw_controls.setfilter('isRowNew() and  not isRowModified()')
dw_controls.filter()
ll_num_rows = dw_controls.rowcount()
if ll_num_rows > 0 then li_rc = dw_controls.rowsdiscard(1,ll_num_rows,primary!)

dw_controls.setfilter('isRowNew() and  isRowModified() and status = "N"')
dw_controls.filter()
ll_num_rows = dw_controls.rowcount()
if ll_num_rows > 0 then li_rc = dw_controls.rowsdiscard(1,ll_num_rows,primary!)

//dw_controls.setfilter('isRowModified() and status = "N"')
dw_controls.setfilter('status = "N"')
dw_controls.filter()
ll_num_rows = dw_controls.rowcount()
if ll_num_rows > 0 then li_rc = dw_controls.rowsmove(1,ll_num_rows,primary!,dw_controls,1,delete!)

// remove the filter
dw_controls.setfilter('')
dw_controls.filter()

return  1

end event

event pfc_preclose;call w_sheet::pfc_preclose;return this.event pfc_preupdate()
end event

type tv_apps from u_tv within w_security_infomgmt
int X=1
int Y=1
int Width=612
int Height=1428
boolean HideSelection=false
string PictureName[]={"~n"}
string StatePictureName[]={""}
int StatePictureWidth=16
int StatePictureHeight=16
long StatePictureMaskColor=553648127
long BackColor=1090519039
end type

event selectionchanged;call u_tv::selectionchanged;// keep track of what application and window is active
Integer	li_cnt
TreeViewItem	ltvi_This
n_ds l_ds
long ll_row
long ll_parent_handle

this.GetItem(newhandle, ltvi_This)

if  ltvi_this.level >= 1 then // get application info
	ll_parent_handle = newhandle
	for li_cnt = 2 to ltvi_this.level 
		ll_parent_handle = this.finditem ( parenttreeitem!, ll_parent_handle )
	next	
	this.of_GetDataRow (ll_parent_handle,l_ds,ll_row)
	is_app = l_ds.object.application[ll_row]
end if

if  ltvi_this.level = 2 then // get window info
	is_window = ltvi_this.label
end if
of_LoadControls()

end event

event getfocus;call u_tv::getfocus;// keep track of who had focus last
idrg_prevobj = this
end event

type dw_controls from u_dw within w_security_infomgmt
int X=626
int Y=157
int Width=2226
int Height=1268
string DataObject="d_security_info_update"
end type

event retrievestart;call u_dw::retrievestart;return 2 // append data
end event

event getfocus;call u_dw::getfocus;// keep track of who had focus last
idrg_prevobj = this
end event

type st_bar from statictext within w_security_infomgmt
event mousemove pbm_mousemove
event mousedown pbm_lbuttondown
event mouseup pbm_lbuttonup
int X=619
int Width=11
int Height=1425
string DragIcon="Exclamation!"
string Tag="Used at a grab point for 'Explorer' type dual panes"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
string Pointer="Q:\silverdome\ArtGlry\Split.cur"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;// move the bar in sync with the pointer as long as the left mouse button is down
if ib_mousedown then
	this.x = parent.pointerx()
end if


end event

event mousedown;// put the bar into 'drag' mode
ib_mousedown = true
this.backcolor = 0

end event

event mouseup;// mouse was released, so lets resize the controls
ib_mousedown = false
this.backcolor = il_originalcolor

tv_apps.width = this.x - ii_baroffset
dw_controls.x = this.x + this.width + ii_baroffset
st_users.x = dw_controls.x
ddplb_users.x = st_users.x + st_users.width + 20
gb_display.x = ddplb_users.x + ddplb_users.width + 20
rb_active.x = gb_display.x + 40
rb_all.x = rb_active.x + rb_active.width + 20
dw_controls.width = (parent.workspacewidth() - ii_baroffset ) - dw_controls.x 




end event

type rb_active from u_rb within w_security_infomgmt
int X=1832
int Y=61
int Width=385
int Height=52
string Text="Active &Only"
boolean Checked=true
long TextColor=33554432
long BackColor=77956459
end type

event clicked;call u_rb::clicked;//set the filter criteria and filter the datawindow
is_controlfilter = " and status <> 'N'"
of_SetFilter()


end event

type rb_all from u_rb within w_security_infomgmt
int X=2226
int Y=61
int Width=168
int Height=52
string Text="&All"
long TextColor=33554432
long BackColor=77956459
end type

event clicked;call u_rb::clicked;//set the filter criteria and filter the datawindow
is_controlfilter = ""
of_SetFilter()


end event

type gb_display from u_gb within w_security_infomgmt
int X=1796
int Y=1
int Width=630
int Height=132
string Text="&Display Controls"
long BackColor=77956459
end type

type ddplb_users from dropdownpicturelistbox within w_security_infomgmt
int X=822
int Y=29
int Width=907
int Height=1076
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
int Accelerator=117
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
long PictureMaskColor=12632256
end type

event selectionchanged;// save off the selected user

is_user = this.text(index)
is_user = trim(left(is_user,pos(is_user,':') - 1))

of_LoadControls()
end event

type st_users from u_st within w_security_infomgmt
int X=662
int Y=20
int Width=168
int Height=52
string Text="&Users :"
long TextColor=33554432
long BackColor=77956459
end type

