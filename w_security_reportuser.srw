$PBExportHeader$w_security_reportuser.srw
$PBExportComments$Report on user information
forward
global type w_security_reportuser from w_sheet
end type
type dw_report from u_dw within w_security_reportuser
end type
type ddplb_users from dropdownpicturelistbox within w_security_reportuser
end type
type st_1 from u_st within w_security_reportuser
end type
end forward

global type w_security_reportuser from w_sheet
int Width=2760
int Height=1668
boolean TitleBar=true
string Title="Security User Report"
string MenuName="m_security_reports"
long BackColor=77956459
dw_report dw_report
ddplb_users ddplb_users
st_1 st_1
end type
global w_security_reportuser w_security_reportuser

type variables

end variables

on w_security_reportuser.create
int iCurrent
call w_sheet::create
if this.MenuName = "m_security_reports" then this.MenuID = create m_security_reports
this.dw_report=create dw_report
this.ddplb_users=create ddplb_users
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_report
this.Control[iCurrent+2]=ddplb_users
this.Control[iCurrent+3]=st_1
end on

on w_security_reportuser.destroy
call w_sheet::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_report)
destroy(this.ddplb_users)
destroy(this.st_1)
end on

event open;call w_sheet::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_security_report_user
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

dw_report.settransobject(SQLCA)
dw_report.of_setprintpreview(true)


end event

event pfc_postopen;call w_sheet::pfc_postopen;
long li_cnt,li_row
integer li_picture
string ls_entry
n_ds lds_users

dw_report.setfocus()
lds_users = create n_ds
lds_users.dataobject = 'd_security_users'
lds_users.settransobject(SQLCA)

li_cnt = lds_users.retrieve() // populate the users drop down list box
for li_row = 1 to li_cnt
	if lds_users.object.user_type[li_row] = 0 then
		li_picture = 1
	else
		li_picture = 2
	end if
	ls_entry = lds_users.object.name[li_row] +' : '+lds_users.object.description[li_row] 
	ddplb_users.additem(ls_entry,li_picture)
next

destroy lds_users

ddplb_users.setfocus()
end event

event resize;call w_sheet::resize;// Resize the datawindow to the new size
dw_report.resize (newwidth - 2*dw_report.x,newheight - dw_report.y)
end event

event pfc_print;call w_sheet::pfc_print;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_print
//
//	Arguments: None
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:  Ensure that the datawindow gets the pfc_print message. It might 
//					not if it is not the current control on the window
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
return dw_report.event pfc_print()

end event

event pfc_printimmediate;call w_sheet::pfc_printimmediate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_printimmediate
//
//	Arguments: None
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:  Ensure that the datawindow gets the pfc_printimmediate message. It might 
//					not if it is not the current control on the window
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
return dw_report.event pfc_printimmediate()

end event

type dw_report from u_dw within w_security_reportuser
int X=40
int Y=113
int Width=2628
int Height=1297
int TabOrder=10
string DataObject="d_security_report_by_user"
end type

type ddplb_users from dropdownpicturelistbox within w_security_reportuser
event selectionchanged pbm_cbnselchange
int X=353
int Y=13
int Width=904
int Height=1076
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
long PictureMaskColor=536870912
end type

event selectionchanged;// save off the selected user
string ls_user
ls_user = this.text(index)
ls_user = trim(left(ls_user,pos(ls_user,':') - 1))

dw_report.retrieve(ls_user)
end event

type st_1 from u_st within w_security_reportuser
int X=33
int Y=29
int Width=360
string Text="Users/Groups"
long TextColor=33554432
long BackColor=77956459
end type

