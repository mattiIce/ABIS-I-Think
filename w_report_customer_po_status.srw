$PBExportHeader$w_report_customer_po_status.srw
$PBExportComments$<popup> job/shift/coil status based on customer PO
forward
global type w_report_customer_po_status from w_sheet
end type
type cb_reset from u_cb within w_report_customer_po_status
end type
type cb_retrieve from u_cb within w_report_customer_po_status
end type
type st_1 from statictext within w_report_customer_po_status
end type
type sle_po from u_sle within w_report_customer_po_status
end type
type dw_report from u_dw within w_report_customer_po_status
end type
type cb_print from u_cb within w_report_customer_po_status
end type
type cb_close from u_cb within w_report_customer_po_status
end type
end forward

global type w_report_customer_po_status from w_sheet
integer x = 592
integer y = 416
integer width = 3679
integer height = 1846
string title = "Job/Shift/Coil status based on customer P.O."
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cb_reset cb_reset
cb_retrieve cb_retrieve
st_1 st_1
sle_po sle_po
dw_report dw_report
cb_print cb_print
cb_close cb_close
end type
global w_report_customer_po_status w_report_customer_po_status

event type string ue_whoami();Return "w_report_customer_po_status"
end event

on w_report_customer_po_status.create
int iCurrent
call super::create
this.cb_reset=create cb_reset
this.cb_retrieve=create cb_retrieve
this.st_1=create st_1
this.sle_po=create sle_po
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reset
this.Control[iCurrent+2]=this.cb_retrieve
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_po
this.Control[iCurrent+5]=this.dw_report
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.cb_close
end on

on w_report_customer_po_status.destroy
call super::destroy
destroy(this.cb_reset)
destroy(this.cb_retrieve)
destroy(this.st_1)
destroy(this.sle_po)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
end on

event open;call super::open;dw_report.SetTransObject(SQLCA)
dw_report.SetFocus()
end event

type cb_reset from u_cb within w_report_customer_po_status
integer x = 1712
integer y = 19
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "R&eset"
end type

event clicked;call super::clicked;sle_po.Text = ""
dw_report.Reset()
end event

type cb_retrieve from u_cb within w_report_customer_po_status
integer x = 1317
integer y = 19
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;call super::clicked;dw_report.Reset()
dw_report.Retrieve(sle_po.Text)
end event

type st_1 from statictext within w_report_customer_po_status
integer x = 22
integer y = 32
integer width = 443
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Customer P.O."
boolean focusrectangle = false
end type

type sle_po from u_sle within w_report_customer_po_status
integer x = 475
integer y = 16
integer width = 819
integer height = 96
integer taborder = 10
integer textsize = -9
string facename = "Arial"
end type

type dw_report from u_dw within w_report_customer_po_status
integer y = 131
integer width = 3668
integer height = 1494
integer taborder = 40
string dataobject = "d_report_order_status_per_po"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

type cb_print from u_cb within w_report_customer_po_status
integer x = 1009
integer y = 1635
integer width = 351
integer height = 93
integer taborder = 50
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cb_close from u_cb within w_report_customer_po_status
string tag = "Close without printing"
integer x = 2231
integer y = 1635
integer width = 351
integer height = 93
integer taborder = 60
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

