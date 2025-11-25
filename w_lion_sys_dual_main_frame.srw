$PBExportHeader$w_lion_sys_dual_main_frame.srw
$PBExportComments$<frame>lion system frame windows inherited from pfemain\w_frame
forward
global type w_lion_sys_dual_main_frame from w_lion_sys_frame
end type
end forward

global type w_lion_sys_dual_main_frame from w_lion_sys_frame
string menuname = "m_ss_frame"
boolean controlmenu = false
end type
global w_lion_sys_dual_main_frame w_lion_sys_dual_main_frame

on w_lion_sys_dual_main_frame.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_ss_frame" then this.MenuID = create m_ss_frame
end on

on w_lion_sys_dual_main_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

