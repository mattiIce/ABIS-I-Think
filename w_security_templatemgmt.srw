$PBExportHeader$w_security_templatemgmt.srw
$PBExportComments$Manage window template information
forward
global type w_security_templatemgmt from w_sheet
end type
type tv_apps from u_tv within w_security_templatemgmt
end type
type st_bar from statictext within w_security_templatemgmt
end type
type dw_deletedcontrols from u_dw within w_security_templatemgmt
end type
type dw_windows from u_dw within w_security_templatemgmt
end type
end forward

global type w_security_templatemgmt from w_sheet
int Width=2507
int Height=1489
boolean TitleBar=true
string Title="Template Management"
string MenuName="m_security_template_mgmt"
long BackColor=77956459
event ue_delete_window ( )
tv_apps tv_apps
st_bar st_bar
dw_deletedcontrols dw_deletedcontrols
dw_windows dw_windows
end type
global w_security_templatemgmt w_security_templatemgmt

type variables
Protected:
boolean	ib_mousedown
integer	ii_prevpos
integer	ii_baroffset = 15
long	il_originalcolor
string	is_app
string	is_window
dragobject idrg_prevobj

end variables

event ue_delete_window;call w_sheet::ue_delete_window;// if a window is deleted then we have to also delete any rows in the template table and the security_info table
// we are assuming that there is no cascading delete referntial integrity rules or triggers in place
int li_rc
long ll_handle,ll_cnt

if len(is_window) = 0 then
	messagebox(this.title,'No window is currently selected')
	return
end if

li_rc = messagebox(this.title,'Ok to delete all controls for window : '+is_window+'. Doing this will also cause any other changes you have made to be updated to the database at this time.',question!,okcancel!,2)
if li_rc = 2 then return

// delete any records in the security_info table for this application,window, use the hidden datawindow so that PFC will automatically update it for me
dw_deletedcontrols.retrieve(is_app,is_window)
ll_cnt = dw_deletedcontrols.rowcount()
dw_deletedcontrols.rowsmove(1,ll_cnt,primary!,dw_deletedcontrols,1,delete!)
// delete the template rows
ll_cnt = dw_windows.rowcount()
dw_windows.rowsmove(1,ll_cnt,primary!,dw_windows,1,delete!)
// remove the treeview item for the window
ll_handle = tv_apps.finditem ( currenttreeitem!,0)
tv_apps.of_DeleteItem (ll_handle )
this.event post pfc_save()

end event

on w_security_templatemgmt.create
int iCurrent
call w_sheet::create
if this.MenuName = "m_security_template_mgmt" then this.MenuID = create m_security_template_mgmt
this.tv_apps=create tv_apps
this.st_bar=create st_bar
this.dw_deletedcontrols=create dw_deletedcontrols
this.dw_windows=create dw_windows
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=tv_apps
this.Control[iCurrent+2]=st_bar
this.Control[iCurrent+3]=dw_deletedcontrols
this.Control[iCurrent+4]=dw_windows
end on

on w_security_templatemgmt.destroy
call w_sheet::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tv_apps)
destroy(this.st_bar)
destroy(this.dw_deletedcontrols)
destroy(this.dw_windows)
end on

event open;call w_sheet::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_security_template
//
//	Description:  Edit the controls that are on of a window
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

// Register the datasource for each level of the tree
// Parameters are: level, datawindow object, transaction object, column to display as the label, 
// the retrieval arguments, and whether the DW object is to be used recursively.
li_rc = tv_apps.AddPicture("application5!")
tv_apps.of_SetDatasource(1, "d_security_applications", SQLCA, "description", "", False, li_rc,li_rc)
li_rc = tv_apps.AddPicture("window!")
tv_apps.of_SetDatasource(2, "d_security_windows", SQLCA, "window", ":parent.1.application", False, li_rc,li_rc)
ii_baroffset = 5
il_originalcolor = st_bar.backcolor
st_bar.setposition(Totop!)

st_bar.event mouseup(0,0,0)

dw_windows.settransobject(SQLCA)
dw_windows.of_SetSort(true)
dw_windows.inv_sort.of_SetStyle(2)
dw_deletedcontrols.settransobject(SQLCA)



end event

event resize;call w_sheet::resize;// resize to the window
tv_apps.Height = newheight - tv_apps.Y
dw_windows.Height = tv_apps.Height
st_bar.Height = tv_apps.Height + 70

dw_windows.Width = newwidth - (dw_windows.X + ii_baroffset)

end event

event pfc_postopen;call w_sheet::pfc_postopen;// populate the treeview
tv_apps.of_InitialRetrieve()

end event

event pfc_endtran;call w_sheet::pfc_endtran;// commit the transaction
commit using SQLCA;
return SQLCA.sqlcode
end event

type tv_apps from u_tv within w_security_templatemgmt
int X=1
int Y=1
int Width=619
int Height=1226
int TabOrder=20
string PictureName[]={"+"}
string StatePictureName[]={""}
int StatePictureWidth=16
int StatePictureHeight=16
long StatePictureMaskColor=553648127
long BackColor=16777215
end type

event selectionchanged;call u_tv::selectionchanged;// keep track of the current application and window
Integer	li_RC
TreeViewItem	ltvi_This
n_ds l_ds
long ll_row
long ll_parent_handle
string ls_filter
this.GetItem(newhandle, ltvi_This)
choose case ltvi_this.level 
	case 1
		is_window = ''
		ls_filter = "application =  '"+ is_app + "' and window = '"+is_window+"'"
		if dw_windows.setfilter(ls_filter) < 1 then
			messagebox('Selectionchanging',ls_filter)
			return
		end if
		dw_windows.filter()
	case 2
		ll_parent_handle = this.finditem ( parenttreeitem!, newhandle )
		this.of_GetDataRow(ll_parent_handle,l_ds,ll_row)
		is_app = l_ds.object.application[ll_row]
		is_window = ltvi_this.label
		ls_filter = "application =  '"+ is_app + "' and window = '"+is_window+"'"
		if dw_windows.setfilter(ls_filter) < 1 then
			messagebox('Selectionchanging',ls_filter)
			return
		end if
		dw_windows.filter()
		if dw_windows.rowcount() = 0 then
			li_rc = dw_windows.retrieve(is_app,is_window)
		end if
end choose



end event

event getfocus;call u_tv::getfocus;// keep track of who had focus last
idrg_prevobj = this
end event

type st_bar from statictext within w_security_templatemgmt
event mousemove pbm_mousemove
event mousedown pbm_lbuttondown
event mouseup pbm_lbuttonup
int X=612
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

event mousemove;if ib_mousedown then
	this.x = parent.pointerx()
end if


end event

event mousedown;ib_mousedown = true
this.backcolor = 0

end event

event mouseup;ib_mousedown = false
this.backcolor = il_originalcolor

tv_apps.width = this.x - ii_baroffset
dw_windows.x = this.x + this.width + ii_baroffset
dw_windows.width = (parent.workspacewidth() - ii_baroffset ) - dw_windows.x 
end event

type dw_deletedcontrols from u_dw within w_security_templatemgmt
int X=1195
int Y=324
int TabOrder=10
boolean Visible=false
boolean Enabled=false
string Tag="This DW is hidden so that updates to it and the template dw will be syncronized by PFC"
string DataObject="d_security_controllistdel"
end type

type dw_windows from u_dw within w_security_templatemgmt
int X=630
int Y=1
int Width=1835
int Height=1226
int TabOrder=30
string DataObject="d_security_templateupdate"
end type

event retrievestart;call u_dw::retrievestart;return 2 // append data
end event

event getfocus;call u_dw::getfocus;// keep track of who had focus last
idrg_prevobj = this
end event

