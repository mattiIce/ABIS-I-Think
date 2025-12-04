$PBExportHeader$w_report_customer_list.srw
$PBExportComments$<Popup> customer list print preview
forward
global type w_report_customer_list from w_sheet
end type
type dw_report from u_dw within w_report_customer_list
end type
type cb_setzoom from u_cb within w_report_customer_list
end type
type cb_print from u_cb within w_report_customer_list
end type
type cbx_setpreview from u_cbx within w_report_customer_list
end type
type p_1 from u_p within w_report_customer_list
end type
type cb_close from u_cb within w_report_customer_list
end type
type ddlb_list from u_ddlb within w_report_customer_list
end type
type st_1 from statictext within w_report_customer_list
end type
end forward

global type w_report_customer_list from w_sheet
integer x = 461
integer y = 125
integer width = 2820
integer height = 1837
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
p_1 p_1
cb_close cb_close
ddlb_list ddlb_list
st_1 st_1
end type
global w_report_customer_list w_report_customer_list

on w_report_customer_list.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.p_1=create p_1
this.cb_close=create cb_close
this.ddlb_list=create ddlb_list
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.ddlb_list
this.Control[iCurrent+8]=this.st_1
end on

on w_report_customer_list.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.ddlb_list)
destroy(this.st_1)
end on

event open;call super::open;ddlb_list.SelectItem(1)
ddlb_list.Event SelectionChanged(1)
dw_report.SetFocus()
end event

type dw_report from u_dw within w_report_customer_list
integer x = 33
integer y = 99
integer width = 2330
integer height = 1635
integer taborder = 40
string dataobject = "d_report_customer_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetTransObject(SQLCA)
This.Event pfc_Retrieve()

This.of_SetPrintPreview(TRUE)
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type cb_setzoom from u_cb within w_report_customer_list
integer x = 2403
integer y = 230
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_customer_list
integer x = 2403
integer y = 336
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

type cbx_setpreview from u_cbx within w_report_customer_list
integer x = 2417
integer y = 58
integer width = 366
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type p_1 from u_p within w_report_customer_list
integer x = 2527
integer y = 576
integer width = 69
integer height = 54
string picturename = "print.jpg"
end type

type cb_close from u_cb within w_report_customer_list
string tag = "Close without printing"
integer x = 2406
integer y = 448
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type ddlb_list from u_ddlb within w_report_customer_list
integer x = 435
integer y = 13
integer width = 969
integer height = 413
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string item[] = {"Customer List","Customer and Contact list"}
end type

event selectionchanged;SetPointer(HourGlass!)

String ls_text

ls_text = Text(index)
IF Len(ls_text) < 2 THEN Return 0

CHOOSE CASE UPPER(Trim(ls_text))
	CASE "CUSTOMER LIST"
		dw_report.DataObject = "d_report_customer_list"
	CASE "CUSTOMER AND CONTACT LIST"
		dw_report.DataObject = "d_report_customer_contact_list"		
END CHOOSE

dw_report.of_SetTransObject(SQLCA)
dw_report.Event pfc_Retrieve()

dw_report.of_SetPrintPreview(TRUE)
end event

type st_1 from statictext within w_report_customer_list
integer x = 37
integer y = 19
integer width = 391
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Select a report:"
boolean focusrectangle = false
end type

