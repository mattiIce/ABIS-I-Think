$PBExportHeader$w_security_reportwindow.srw
$PBExportComments$Report on window information
forward
global type w_security_reportwindow from w_sheet
end type
type dw_report from u_dw within w_security_reportwindow
end type
type st_1 from u_st within w_security_reportwindow
end type
type ddlb_apps from u_ddlb within w_security_reportwindow
end type
type ddlb_windows from u_ddlb within w_security_reportwindow
end type
type st_win from u_st within w_security_reportwindow
end type
end forward

global type w_security_reportwindow from w_sheet
int Width=2841
int Height=1732
boolean TitleBar=true
string Title="Security Window Report"
string MenuName="m_security_reports"
long BackColor=77956459
event ue_scroll_next ( )
event ue_scroll_prev ( )
event ue_scroll_first ( )
event ue_scroll_last ( )
dw_report dw_report
st_1 st_1
ddlb_apps ddlb_apps
ddlb_windows ddlb_windows
st_win st_win
end type
global w_security_reportwindow w_security_reportwindow

type variables
n_ds ids_windows

end variables

event ue_scroll_next;call w_sheet::ue_scroll_next;dw_report.event ue_scroll_page('N')
end event

event ue_scroll_prev;call w_sheet::ue_scroll_prev;dw_report.event ue_scroll_page('P')
end event

event ue_scroll_first;call w_sheet::ue_scroll_first;dw_report.event ue_scroll_page('F')
end event

event ue_scroll_last;call w_sheet::ue_scroll_last;dw_report.event ue_scroll_page('L')
end event

on w_security_reportwindow.create
int iCurrent
call w_sheet::create
if this.MenuName = "m_security_reports" then this.MenuID = create m_security_reports
this.dw_report=create dw_report
this.st_1=create st_1
this.ddlb_apps=create ddlb_apps
this.ddlb_windows=create ddlb_windows
this.st_win=create st_win
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_report
this.Control[iCurrent+2]=st_1
this.Control[iCurrent+3]=ddlb_apps
this.Control[iCurrent+4]=ddlb_windows
this.Control[iCurrent+5]=st_win
end on

on w_security_reportwindow.destroy
call w_sheet::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_report)
destroy(this.st_1)
destroy(this.ddlb_apps)
destroy(this.ddlb_windows)
destroy(this.st_win)
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

dw_report.settransobject(SQLCA)


end event

event pfc_postopen;call w_sheet::pfc_postopen;
long li_cnt,li_row
string ls_entry

ids_windows = create n_ds

ids_windows.dataobject = 'd_security_applications'
ids_windows.settransobject(SQLCA)

li_cnt = ids_windows.retrieve() // populate the applications drop down list box
for li_row = 1 to li_cnt
	ls_entry = ids_windows.object.application[li_row] +' : '+ids_windows.object.description[li_row] 
	ddlb_apps.additem(ls_entry)
next

ids_windows.dataobject = 'd_security_windows'  // this will get reused in the ddlb_apps.selectionchanged event
ids_windows.settransobject(SQLCA)


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

event close;call w_sheet::close;destroy ids_windows 
end event

type dw_report from u_dw within w_security_reportwindow
event type integer ue_scroll_page ( string ls_direction )
int X=29
int Y=109
int Width=2646
int Height=1297
int TabOrder=30
string DataObject="d_security_report_by_window"
end type

event ue_scroll_page;call u_dw::ue_scroll_page;choose case ls_direction
	case 'N'
		this.scrollnextpage()
	case 'P'
		this.scrollpriorpage()
	case 'F'
		this.scrolltorow(0)
	case 'L'
		this.scrolltorow(this.rowcount())
	case else
		return -1
end choose
return 1

end event

type st_1 from u_st within w_security_reportwindow
int X=33
int Y=20
int Width=296
string Text="Applications :"
long TextColor=33554432
long BackColor=77956459
end type

type ddlb_apps from u_ddlb within w_security_reportwindow
int X=338
int Y=13
int Width=854
int Height=1085
int TabOrder=10
end type

event selectionchanged;call u_ddlb::selectionchanged;
long li_cnt,li_row
string ls_entry,ls_app

ls_app = this.text(index) // get the application name
ls_app = trim(left(ls_app,pos(ls_app,':') - 1))


ddlb_windows.reset()
li_cnt = ids_windows.retrieve(ls_app) // populate the windows drop down list box

for li_row = 1 to li_cnt
	ls_entry = ids_windows.object.window[li_row]
	ddlb_windows.additem(ls_entry)
next

dw_report.reset()


end event

type ddlb_windows from u_ddlb within w_security_reportwindow
int X=1544
int Y=13
int Width=833
int Height=916
int TabOrder=20
end type

event selectionchanged;call u_ddlb::selectionchanged;string ls_window
long li_cnt

ls_window = this.text(index)

li_cnt = dw_report.retrieve(ls_window)

if li_cnt = 0 then messagebox(parent.title,'Security has not been set for this window ('+ls_window+').')
end event

type st_win from u_st within w_security_reportwindow
int X=1266
int Y=20
int Width=246
string Text="Windows :"
Alignment Alignment=Right!
long TextColor=33554432
long BackColor=77956459
end type

