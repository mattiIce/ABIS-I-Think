$PBExportHeader$w_lion_sys_frame.srw
$PBExportComments$<frame>lion system frame windows inherited from pfemain\w_frame
forward
global type w_lion_sys_frame from w_frame
end type
end forward

global type w_lion_sys_frame from w_frame
integer x = 4
integer y = 3
integer width = 3734
integer height = 2461
string title = "Aluminum Blanking Integrated System"
string menuname = "m_lion_sys_frame"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = false
windowstate windowstate = maximized!
end type
global w_lion_sys_frame w_lion_sys_frame

event pfc_open;SetPointer(HourGlass!)
String   ls_sheet 
Window  lw_Sheet,lw_OpenSheets[]   
Integer li_rc, li_i

ls_sheet = Message.StringParm  

li_rc = this.inv_sheetmanager.of_getSheets(lw_OpenSheets)
IF li_rc > 0 THEN
	FOR li_i = 1 TO li_rc
		IF ls_sheet = lw_OpenSheets[li_i].Dynamic Event ue_whoami() THEN
			lw_OpenSheets[li_i].WindowState = Normal!
			lw_OpenSheets[li_i].BringToTop = TRUE
			RETURN
		END IF
	NEXT
END IF

IF Isvalid(w_display_app) THEN Close(w_display_app)
IF Isvalid(w_display_app_shop) THEN Close(w_display_app_shop)
OpenSheet(lw_sheet, ls_sheet, this, 0, Original!)
ArrangeSheets(Cascade!)




end event

event pfc_preopen;this.of_SetSheetManager(TRUE) 
this.of_SetStatusBar(TRUE)

//this.inv_statusbar.of_SetGDI(TRUE) // No availiable in 32-bit window
//this.inv_statusbar.of_SetMem(TRUE) // Return wrong values -- bug 
//this.inv_statusbar.of_SetUser(TRUE)// No availiable in 32-bit window
this.inv_statusbar.of_SetTimer(TRUE)


end event

event pfc_postopen;call super::pfc_postopen;/*
if gnv_app.of_LogonDlg() < 1 then
	//halt close
	Close(gnv_app.of_getframe()) 
Else
	this.SetMicroHelp("Connection complete")
end if
*/

end event

on w_lion_sys_frame.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_lion_sys_frame" then this.MenuID = create m_lion_sys_frame
end on

on w_lion_sys_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;//gnv_app.of_Splash(2)

end event

event pfc_pagesetup;call super::pfc_pagesetup;PrintSetup()
Return 1
end event

event close;call super::close;close(w_display_app)

end event

