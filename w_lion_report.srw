$PBExportHeader$w_lion_report.srw
$PBExportComments$inherited from pfd_abc/w_report
forward
global type w_lion_report from w_report
end type
end forward

global type w_lion_report from w_report
end type
global w_lion_report w_lion_report

on w_lion_report.create
call w_report::create
end on

on w_lion_report.destroy
call w_report::destroy
end on

type cb_print from w_report`cb_print within w_lion_report
boolean BringToTop=true
end type

