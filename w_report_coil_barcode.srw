$PBExportHeader$w_report_coil_barcode.srw
$PBExportComments$<popup> printcoil barcode form  with a preview, inherited from pfemain/w_sheet
forward
global type w_report_coil_barcode from w_sheet
end type
type dw_report from u_dw within w_report_coil_barcode
end type
type cb_setzoom from u_cb within w_report_coil_barcode
end type
type cb_print from u_cb within w_report_coil_barcode
end type
type p_1 from u_p within w_report_coil_barcode
end type
type cb_close from u_cb within w_report_coil_barcode
end type
end forward

global type w_report_coil_barcode from w_sheet
integer x = 640
integer y = 394
integer width = 2458
integer height = 1261
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
p_1 p_1
cb_close cb_close
end type
global w_report_coil_barcode w_report_coil_barcode

forward prototypes
public subroutine wf_set_w_l (long al_job)
end prototypes

public subroutine wf_set_w_l (long al_job);String ls_cust, ls_shape, ls_tcust
Long ll_order, ll_cust
Real lr_l, lr_s, lr_w, lr_l_p, lr_l_m, lr_s_p, lr_s_m, lr_w_p, lr_w_m
Int li_item
Long ll_coil_wt, ll_row, ll_i, ll_skids, ll_max_skid_wt
Real lr_yield
String ls_modstring

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num, material_yield 
INTO :ll_order, :li_item, :lr_yield
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT orig_customer_id INTO :ll_cust
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;
IF ll_cust > 0 THEN
	SELECT customer_short_name INTO :ls_tcust
	FROM customer
	WHERE customer_id = :ll_cust
	USING SQLCA;
	ls_cust =  Upper(Trim(ls_tcust))
	ls_modstring = "cust_t.Text = ~"" + ls_cust + "~""
	dw_report.Modify(ls_modstring) 
END IF

SELECT sheet_type, max_skid_wt INTO :ls_shape, :ll_max_skid_wt
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

//part dimensions should be Width x Length 
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_length_plus, rt_length_minus, rt_width,  rt_width_plus, rt_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "PARALLELOGRAM"
		SELECT p_length, p_length_plus,p_length_minus, p_width,  p_width_plus,  p_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "FENDER"
		SELECT fe_side, fe_side_plus, fe_side_minus INTO :lr_w, :lr_w_p, :lr_w_m
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "CHEVRON"
		SELECT ch_length, ch_length_plus, ch_length_minus, ch_width, ch_width_plus, ch_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "CIRCLE"
		SELECT c_diameter, c_diameter_plus, c_diameter_minus INTO :lr_w, :lr_w_p, :lr_w_m
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_long_plus, tr_long_minus, tr_width, tr_width_plus , tr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_long_plus, ltr_long_minus, ltr_width, ltr_width_plus, ltr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_long_plus, rtr_long_minus, rtr_width, rtr_width_plus, rtr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
END CHOOSE		

ls_modstring = "w_t.Text = ~"" + String(lr_w, "###,###.###") + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "w_p_t.Text = ~"+" + String(lr_w_p, "###.###") + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "w_m_t.Text = ~"-" + String(lr_w_m, "##.###") + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "l_t.Text = ~"" + String(lr_l, "###,###.###") + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "l_p_t.Text = ~"+" + String(lr_l_p, "##.###") + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "l_m_t.Text = ~"-" + String(lr_l_m, "##.###") + "~""
dw_report.Modify(ls_modstring) 

DataStore lds_coil
lds_coil = CREATE datastore  
lds_coil.DataObject = "d_report_ab_job_coil"  
lds_coil.SetTransObject (SQLCA)  
lds_coil.Retrieve(al_job)

ll_row = lds_coil.rowCount()
ll_coil_wt = 0
IF ll_row < 1 THEN RETURN
FOR ll_i = 1 TO ll_row
	ll_coil_wt = ll_coil_wt + lds_coil.GetItemNumber(ll_i, "coil_net_wt")
NEXT
IF ll_coil_wt = 0 OR IsNULL(ll_coil_wt) THEN RETURN
DESTROY lds_coil

ls_modstring = "total_coil_t.Text = ~"" + String(ll_coil_wt, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

ls_modstring = "max_scrap_t.Text = ~"" + String(Ceiling(ll_coil_wt * ( 1 - lr_yield ) ), "#,###,###") + "~""
dw_report.Modify(ls_modstring) 

ls_modstring = "max_sheet_wt_t.Text = ~"" + String(Ceiling(ll_coil_wt * lr_yield ) , "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

IF ll_max_skid_wt = 0 OR IsNULL(ll_max_skid_wt) THEN RETURN
ls_modstring = "skid_no_t.Text = ~"" + String(Ceiling( ll_coil_wt * lr_yield / ll_max_skid_wt), "###,###") + "~""
dw_report.Modify(ls_modstring) 






end subroutine

on w_report_coil_barcode.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.p_1=create p_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.cb_close
end on

on w_report_coil_barcode.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.p_1)
destroy(this.cb_close)
end on

event open;call super::open;dw_report.SetTransObject(sqlca)
dw_report.Retrieve(message.doubleparm)
this.title = "Printing coil# :  " + String(message.doubleparm) + "'s barcode ticket"
dw_report.SetFocus()


end event

type dw_report from u_dw within w_report_coil_barcode
integer x = 26
integer y = 13
integer width = 2011
integer height = 1136
integer taborder = 40
string dataobject = "d_report_barcode_coil_abc_info"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

type cb_setzoom from u_cb within w_report_coil_barcode
integer x = 2059
integer y = 29
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_coil_barcode
integer x = 2059
integer y = 134
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;Printsetup()
dw_report.print()
end event

type p_1 from u_p within w_report_coil_barcode
integer x = 2205
integer y = 368
integer width = 69
integer height = 54
string picturename = "print.jpg"
end type

type cb_close from u_cb within w_report_coil_barcode
string tag = "Close without printing"
integer x = 2063
integer y = 246
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

