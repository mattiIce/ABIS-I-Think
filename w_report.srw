$PBExportHeader$w_report.srw
$PBExportComments$<Sheet>report window inherited from pfcwnsrv/pfc_w_sheet
forward
global type w_report from pfc_w_sheet
end type
type cb_setzoom from pfc_u_cb within w_report
end type
type cbx_preview from pfc_u_cbx within w_report
end type
type dw_report from pfc_u_dw within w_report
end type
type cb_print from pfc_u_cb within w_report
end type
type cb_cancel from u_cb within w_report
end type
end forward

global type w_report from pfc_w_sheet
int Width=2429
int Height=1428
cb_setzoom cb_setzoom
cbx_preview cbx_preview
dw_report dw_report
cb_print cb_print
cb_cancel cb_cancel
end type
global w_report w_report

on w_report.create
int iCurrent
call pfc_w_sheet::create
this.cb_setzoom=create cb_setzoom
this.cbx_preview=create cbx_preview
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_setzoom
this.Control[iCurrent+2]=cbx_preview
this.Control[iCurrent+3]=dw_report
this.Control[iCurrent+4]=cb_print
this.Control[iCurrent+5]=cb_cancel
end on

on w_report.destroy
call pfc_w_sheet::destroy
destroy(this.cb_setzoom)
destroy(this.cbx_preview)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_cancel)
end on

type cb_setzoom from pfc_u_cb within w_report
int X=2024
int Y=257
int TabOrder=30
string Text="&SetZoom"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cbx_preview from pfc_u_cbx within w_report
int X=2038
int Y=103
int Width=345
int TabOrder=20
string Text="SetPreview"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type dw_report from pfc_u_dw within w_report
int X=29
int Y=23
int Width=1953
int Height=1277
int TabOrder=10
boolean HScrollBar=true
end type

event constructor;call super::constructor;This.of_SetTransObject(SQLCA)
This.Retrieve()

This.of_SetPrintPreview(TRUE)
end event

type cb_print from pfc_u_cb within w_report
int X=2024
int Y=362
int TabOrder=40
boolean BringToTop=true
string Text="&Print"
int Weight=700
string FaceName="Arial"
end type

type cb_cancel from u_cb within w_report
int X=2024
int Y=477
int TabOrder=2
string Text="&Cancel"
int Weight=700
string FaceName="Arial"
end type

