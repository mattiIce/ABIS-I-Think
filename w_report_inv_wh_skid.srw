$PBExportHeader$w_report_inv_wh_skid.srw
$PBExportComments$<popup>print wh skid list for each customer
forward
global type w_report_inv_wh_skid from w_sheet
end type
type dw_report from u_dw within w_report_inv_wh_skid
end type
type cb_setzoom from u_cb within w_report_inv_wh_skid
end type
type cb_print from u_cb within w_report_inv_wh_skid
end type
type cbx_setpreview from u_cbx within w_report_inv_wh_skid
end type
type p_1 from u_p within w_report_inv_wh_skid
end type
type cb_close from u_cb within w_report_inv_wh_skid
end type
end forward

global type w_report_inv_wh_skid from w_sheet
integer x = 574
integer y = 218
integer width = 2779
integer height = 1590
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
global w_report_inv_wh_skid w_report_inv_wh_skid

on w_report_inv_wh_skid.create
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

on w_report_inv_wh_skid.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.p_1)
destroy(this.cb_close)
end on

event open;call super::open;Window lw_parent
String ls_mod, ls_cust
Long ll_cust

ll_cust = Message.DoubleParm

//Messagebox("info", ll_cust)
lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	ls_mod = lw_Parent.Dynamic Event ue_cur_retrieve()
	IF Len(ls_mod) > 0 THEN
		dw_report.Modify(ls_mod)
	END IF
END IF	

//Messagebox("info", ls_mod)
dw_report.SetTransObject(SQLCA)
dw_report.Retrieve(ll_cust)

//Messagebox("info", ll_cust)

SELECT customer_full_name INTO :ls_cust
FROM customer
WHERE customer_id = :ll_cust
USING SQLCA;

ls_mod = "cust_t.Text = ~"" + ls_cust + "~""
dw_report.Modify(ls_mod) 

dw_report.SetFocus()
end event

type dw_report from u_dw within w_report_inv_wh_skid
integer x = 11
integer y = 13
integer width = 2245
integer height = 1360
integer taborder = 40
string dataobject = "d_report_wh_skid_list_per_cust"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

type cb_setzoom from u_cb within w_report_inv_wh_skid
integer x = 2297
integer y = 250
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_inv_wh_skid
integer x = 2297
integer y = 355
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

type cbx_setpreview from u_cbx within w_report_inv_wh_skid
integer x = 2315
integer y = 77
integer width = 366
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type p_1 from u_p within w_report_inv_wh_skid
integer x = 2439
integer y = 595
integer width = 69
integer height = 54
string picturename = "print.jpg"
end type

type cb_close from u_cb within w_report_inv_wh_skid
string tag = "Close without printing"
integer x = 2300
integer y = 467
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

