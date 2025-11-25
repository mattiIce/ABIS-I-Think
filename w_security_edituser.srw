$PBExportHeader$w_security_edituser.srw
$PBExportComments$Response Window used to edit a single user/group
forward
global type w_security_edituser from w_response
end type
type dw_user from u_dw within w_security_edituser
end type
type cb_ok from u_cb within w_security_edituser
end type
type cb_cancel from u_cb within w_security_edituser
end type
end forward

global type w_security_edituser from w_response
int X=552
int Y=465
int Width=1042
int Height=564
boolean TitleBar=true
string Title="Edit User"
long BackColor=77956459
dw_user dw_user
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_security_edituser w_security_edituser

type variables
Protected:
s_security_user_data istr_data
end variables

on w_security_edituser.create
int iCurrent
call w_response::create
this.dw_user=create dw_user
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_user
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=cb_cancel
end on

on w_security_edituser.destroy
call w_response::destroy
destroy(this.dw_user)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_security_edit_user
//
//	Description:  Allows the editing of user or group information
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
window w_parent
istr_data = message.powerobjectparm
if not isvalid(istr_data) then //did we get a parameter object?
	cb_cancel.event post clicked()
	return
end if
dw_user.insertrow(0) // make a row and copy the passed information
dw_user.object.user_type[1] = istr_data.user_type
dw_user.object.name[1] = istr_data.name
dw_user.object.description[1] = istr_data.desc
dw_user.object.priority[1] = istr_data.priority
dw_user.resetupdate() //!!! HACK
choose case istr_data.status // make it look correct 
	case 1 
		this.title = 'Add'
		dw_user.object.name.background.color = 16777215
		dw_user.object.description.background.color = 16777215
		dw_user.object.priority.background.color = 16777215
	case 2
		this.title = 'Edit'
		dw_user.object.name.tabsequence = 0
		dw_user.object.description.background.color = 16777215
		dw_user.object.priority.background.color = 16777215
	case 3 
		this.title = 'Delete'
		dw_user.object.datawindow.readonly = true
end choose
if istr_data.user_type = 0 then
	this.title = this.title + ' User'
	dw_user.object.priority.visible = false
	dw_user.object.priority_t.visible = false
elseif istr_data.user_type = 1 then
	this.title = this.title + ' Group'
else
	this.title = this.title + ' User from Group'
	dw_user.object.priority.visible = false
	dw_user.object.priority_t.visible = false
end if
w_parent = this.parentwindow()

// center the window on the calling window
this.move(w_parent.x + w_parent.width/2 - this.width/2,w_parent.y + w_parent.height/2- this.height/2)
end event

type dw_user from u_dw within w_security_edituser
int X=65
int Y=23
int Width=900
int Height=237
int TabOrder=10
string DataObject="d_security_user_info"
boolean VScrollBar=false
boolean LiveScroll=false
end type

type cb_ok from u_cb within w_security_edituser
int X=118
int Y=301
int TabOrder=20
string Text="OK"
boolean Default=true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	(Arguments: None
//
//	Returns:  None
//
//	Description:  passed the information back to the calling window
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
if dw_user.accepttext() = -1 then return
// if there have been no changes to the data  and we were not called for a delete then
// return an error code to let the calling window know that there were no changes
if dw_user.modifiedcount() = 0 and istr_data.status <> 3 then 
	istr_data.status = -1
else // otherwise return the information
	istr_data.name = dw_user.object.name[1]
	istr_data.desc = dw_user.object.description[1]
	istr_data.priority = dw_user.object.priority[1]
end if

dw_user.resetupdate() // !!! HACK

closewithreturn(parent,istr_data)
end event

type cb_cancel from u_cb within w_security_edituser
int X=523
int Y=301
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	Arguments: None
//
//	Returns:  None
//
//	Description:  Close the window, returning a canceled return code
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
dw_user.reset() // !!!Hack
istr_data.status = -1
closewithreturn(parent,istr_data)
end event

