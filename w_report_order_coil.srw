$PBExportHeader$w_report_order_coil.srw
$PBExportComments$<popup> print list of coil in this order
forward
global type w_report_order_coil from w_sheet
end type
type dw_report from u_dw within w_report_order_coil
end type
type cb_setzoom from u_cb within w_report_order_coil
end type
type cb_print from u_cb within w_report_order_coil
end type
type cbx_setpreview from u_cbx within w_report_order_coil
end type
type p_1 from u_p within w_report_order_coil
end type
type cb_close from u_cb within w_report_order_coil
end type
end forward

global type w_report_order_coil from w_sheet
integer x = 592
integer y = 643
integer height = 806
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
p_1 p_1
cb_close cb_close
end type
global w_report_order_coil w_report_order_coil

on w_report_order_coil.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.p_1=create p_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.cb_close
end on

on w_report_order_coil.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.p_1)
destroy(this.cb_close)
end on

event open;call super::open;dw_report.SetFocus()
end event

type dw_report from u_dw within w_report_order_coil
integer x = 7
integer y = 13
integer width = 2026
integer height = 630
integer taborder = 40
string dataobject = "d_report_coil_order_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetTransObject(SQLCA)
This.Event pfc_Retrieve()
This.of_SetPrintPreview(TRUE)


end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(message.DoubleParm)
end event

type cb_setzoom from u_cb within w_report_order_coil
integer x = 2066
integer y = 237
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_order_coil
integer x = 2066
integer y = 342
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_report_order_coil
integer x = 2085
integer y = 64
integer width = 366
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type p_1 from u_p within w_report_order_coil
integer x = 2205
integer y = 582
integer width = 69
integer height = 54
string picturename = "print.jpg"
end type

type cb_close from u_cb within w_report_order_coil
string tag = "Close without printing"
integer x = 2070
integer y = 454
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

