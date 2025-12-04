$PBExportHeader$w_report_skid_entry.srw
$PBExportComments$<Popup> print skid entry from
forward
global type w_report_skid_entry from w_sheet
end type
type dw_report from u_dw within w_report_skid_entry
end type
type cb_setzoom from u_cb within w_report_skid_entry
end type
type cb_print from u_cb within w_report_skid_entry
end type
type cbx_setpreview from u_cbx within w_report_skid_entry
end type
type p_1 from u_p within w_report_skid_entry
end type
type cb_close from u_cb within w_report_skid_entry
end type
type rb_1 from u_rb within w_report_skid_entry
end type
type rb_2 from u_rb within w_report_skid_entry
end type
type sle_1 from u_sle within w_report_skid_entry
end type
type sle_2 from u_sle within w_report_skid_entry
end type
type st_1 from statictext within w_report_skid_entry
end type
type st_2 from statictext within w_report_skid_entry
end type
end forward

global type w_report_skid_entry from w_sheet
integer x = 300
integer y = 112
integer width = 3255
integer height = 1789
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
rb_1 rb_1
rb_2 rb_2
sle_1 sle_1
sle_2 sle_2
st_1 st_1
st_2 st_2
end type
global w_report_skid_entry w_report_skid_entry

type variables
Long il_job
Boolean	ib_use_package_num //Alex Gerlants. 06/15/2018. Arconic_Package_Num
end variables

forward prototypes
public subroutine wf_cust_prod_info (long al_job)
public function integer wf_syn_skid_wt ()
public subroutine wf_duplicate_skid_info ()
end prototypes

public subroutine wf_cust_prod_info (long al_job);SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper
Long ll_cust, ll_order, ll_enduser
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#, ls_po, ls_finished_goods

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT orig_customer_id, enduser_id, orig_customer_po INTO :ll_cust, :ll_enduser, :ls_po
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;
SELECT customer_short_name INTO :ls_cust
FROM customer
WHERE customer_id = :ll_cust
USING SQLCA;
IF ll_enduser > 0 THEN
	SELECT customer_short_name INTO :ls_enduser
	FROM customer
	WHERE customer_id = :ll_enduser
	USING SQLCA;
	ls_cust = ls_cust + " ( " + Trim(ls_enduser) + " )"
END IF
ls_cust = ls_cust + "          Cust.P.O.# " + ls_po
sle_1.Text = Upper(ls_cust)

SELECT sheet_type, alloy2, temper, order_item_desc, gauge, enduser_part_num, finished_goods_material_num 
INTO :ls_shape, :ls_alloy, :ls_temper, :ls_desc, :lr_gauge, :ls_part#, :ls_finished_goods
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;
IF isNULL(ls_finished_goods) THEN ls_finished_goods = " "

IF IsNULL(ls_desc) THEN 
	ls_desc = "  "
ELSE
	ls_desc = Trim(ls_desc)
END IF
IF IsNULL(ls_part#) THEN 
	ls_part# = "  "
ELSE
	ls_part# = Trim(ls_part#)
END IF

//part dimensions should be Width x Length 
ls_spec = ls_alloy + " - " + ls_temper + "    " + String(lr_gauge, "##.######") + " X "
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_width INTO :lr_l, :lr_w
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE ELSE
		ls_spec = ls_spec + " "
END CHOOSE	
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part# + "    " + ls_finished_goods
sle_2.Text = ls_spec


end subroutine

public function integer wf_syn_skid_wt ();Long ll_totalrow, ll_row, ll_i
Long ll_nwt, ll_inwt
Long ll_skid, ll_skid_netwt, ll_lastitem, ll_lastitem_netwt

dw_report.AcceptText()
ll_totalrow = dw_report.RowCount()
IF ll_totalrow < 1 THEN RETURN 0
FOR ll_row = 1 TO ll_totalrow
	ll_nwt = dw_report.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt")
	dw_report.SetItem(ll_row, "citem_net_kg", Int(ll_nwt  * 0.45359 + 0.5 ))
NEXT
dw_report.AcceptText()

FOR ll_row = 1 TO ll_totalrow
	ll_skid = dw_report.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
	ll_skid_netwt = dw_report.GetItemNumber(ll_row, "net_wt_kg", Primary!, FALSE)
	ll_nwt = 0
	ll_lastitem = 0
	FOR ll_i = 1 TO ll_totalrow
		IF dw_report.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num") = ll_skid THEN
			ll_inwt = dw_report.GetItemNumber(ll_i, "citem_net_kg", Primary!, FALSE)
			IF ISNULL(ll_inwt) THEN ll_inwt = 0
			ll_nwt = ll_nwt + ll_inwt
			ll_lastitem_netwt = ll_inwt
			ll_lastitem = ll_i
		END IF
	NEXT
	IF ll_nwt <> ll_skid_netwt THEN
		dw_report.SetItem(ll_lastitem, "citem_net_kg", ll_lastitem_netwt + (ll_skid_netwt - ll_nwt))
	END IF
NEXT 

RETURN 1
end function

public subroutine wf_duplicate_skid_info ();Long ll_totalrow, ll_row
Long ll_skid, ll_skid_pre
Long ll_null

SetNULL(ll_null)
dw_report.AcceptText()
ll_totalrow = dw_report.RowCount()
IF ll_totalrow < 2 THEN RETURN 
FOR ll_row = ll_totalrow TO 2 STEP -1
	ll_skid = dw_report.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
	ll_skid_pre = dw_report.GetItemNumber((ll_row - 1), "sheet_skid_sheet_skid_num")
	IF ll_skid = ll_skid_pre THEN
		dw_report.SetItem(ll_row, "sheet_skid_sheet_skid_num",ll_null )
		dw_report.SetItem(ll_row, "gross_wt",ll_null )
		dw_report.SetItem(ll_row, "gross_wt_kg",ll_null )
		dw_report.SetItem(ll_row, "sheet_skid_sheet_net_wt",ll_null )
		dw_report.SetItem(ll_row, "net_wt_kg",ll_null )
		dw_report.SetItem(ll_row, "sheet_skid_sheet_theoretical_wt",ll_null )
		dw_report.SetItem(ll_row, "theo_wt_kg",ll_null )
		dw_report.SetItem(ll_row, "sheet_skid_sheet_tare_wt",ll_null )
		dw_report.SetItem(ll_row, "tare_wt_kg",ll_null )
		dw_report.SetItem(ll_row, "sheet_skid_skid_sheet_status",ll_null )
		dw_report.SetItem(ll_row, "line_t",ll_null )
	END IF
NEXT 

end subroutine

on w_report_skid_entry.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.p_1=create p_1
this.cb_close=create cb_close
this.rb_1=create rb_1
this.rb_2=create rb_2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.sle_1
this.Control[iCurrent+10]=this.sle_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_2
end on

on w_report_skid_entry.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;il_job = Message.DoubleParm

f_get_use_package_num_4job(il_job, sqlca, ib_use_package_num) //Alex Gerlants. 06/15/2018. Arconic_Package_Num

IF il_job > 0 THEN wf_cust_prod_info(il_job)
rb_1.Event Clicked()
dw_report.SetFocus()


end event

type dw_report from u_dw within w_report_skid_entry
integer x = 7
integer y = 214
integer width = 2801
integer height = 1398
integer taborder = 50
string dataobject = "d_report_shopfloor_skid_coil"
boolean hscrollbar = true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_job)
end event

type cb_setzoom from u_cb within w_report_skid_entry
integer x = 2831
integer y = 195
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_skid_entry
integer x = 2831
integer y = 310
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;//Alex Gerlants. 10/21/2019. Rename PDF File. Begin
//dw_report.Event pfc_print() //Alex Gerlants. 10/21/2019. Comment out

String					ls_orig_customer_po
Integer					li_rc
s_printdlgattrib		lstr_printdlg


select	customer_order.orig_customer_po
into		:ls_orig_customer_po
from		ab_job
			join customer_order on customer_order.order_abc_num = ab_job.order_abc_num
where		ab_job_num = :il_job
using		sqlca;

If sqlca.sqlcode <> 0 Then //DB error
	MessageBox("DB error", 	"Database error in Clicked event for cb_print of w_report_skid_entry in silverdome3.pbl~n~r" + &
									"Please contact abis support.~n~r~n~rError:~n~r" + sqlca.sqlerrtext)
	Return
End If

//Get printer
li_rc = dw_report.event pfc_printdlg (lstr_printdlg)
if li_rc <> 1 then return li_rc

//lstr_printdlg.s_printer = "PDFPrinter" //Override printer selection. Force to print on PDFPrinter

//Set the printer from the print dialog above
PrintSetPrinter ( lstr_printdlg.s_printer )

li_rc = f_rename_and_print_job(ls_orig_customer_po, il_job, dw_report)
//Alex Gerlants. 10/21/2019. Rename PDF File. End
end event

type cbx_setpreview from u_cbx within w_report_skid_entry
integer x = 2842
integer y = 51
integer width = 366
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type p_1 from u_p within w_report_skid_entry
integer x = 2977
integer y = 579
integer width = 69
integer height = 54
string picturename = "print.jpg"
end type

type cb_close from u_cb within w_report_skid_entry
string tag = "Close without printing"
integer x = 2831
integer y = 426
integer width = 351
integer height = 93
integer taborder = 40
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type rb_1 from u_rb within w_report_skid_entry
integer x = 344
integer y = 1622
integer width = 494
boolean bringtotop = true
string text = "Sort by coil number"
boolean checked = true
end type

event clicked;//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
//dw_report.DataObject = "d_report_shopfloor_skid_coil"

If ib_use_package_num Then
	dw_report.DataObject = "d_report_shopfloor_skid_coil_pn"
Else
	dw_report.DataObject = "d_report_shopfloor_skid_coil"
End If
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

dw_report.of_SetTransObject(SQLCA)
dw_report.Event pfc_Retrieve()
String ls_modstring
ls_modstring = "customer_t.Text = ~"" + sle_1.Text + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "material_t.Text = ~"" + sle_2.Text + "~""
dw_report.Modify(ls_modstring) 

Long ll_coil_wt, ll_item_wt
CONNECT USING SQLCA;
SELECT SUM(process_quantity) INTO :ll_coil_wt
FROM process_coil
WHERE ab_job_num = :il_job
USING SQLCA;
	
ls_modstring = "coil_t.Text = ~"" + String(ll_coil_wt, "#########") + "~""
dw_report.Modify(ls_modstring) 

CONNECT USING SQLCA;
SELECT SUM(prod_item_net_wt) INTO :ll_item_wt
FROM production_sheet_item
WHERE ab_job_num = :il_job
USING SQLCA;

ls_modstring = "scrap_t.Text = ~"" + String((ll_coil_wt - ll_item_wt), "#########") + "~""
dw_report.Modify(ls_modstring) 

dw_report.ResetUpdate()
end event

type rb_2 from u_rb within w_report_skid_entry
integer x = 962
integer y = 1619
integer width = 508
boolean bringtotop = true
string text = "Sort by skid number"
end type

event clicked;//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
//dw_report.DataObject = "d_report_shopfloor_skid"

If ib_use_package_num Then
	dw_report.DataObject = "d_report_shopfloor_skid_pn"
Else
	dw_report.DataObject = "d_report_shopfloor_skid"
End If
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

dw_report.of_SetTransObject(SQLCA)
dw_report.Event pfc_Retrieve()
//Messagebox("info", "break!")
String ls_modstring
ls_modstring = "customer_t.Text = ~"" + sle_1.Text + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "material_t.Text = ~"" + sle_2.Text + "~""
dw_report.Modify(ls_modstring) 

Long ll_net, ll_tare
CONNECT USING SQLCA;
SELECT SUM(sheet_net_wt), SUM(sheet_tare_wt) INTO :ll_net, :ll_tare
FROM sheet_skid
WHERE ab_job_num = :il_job
USING SQLCA;
	
ls_modstring = "gross_t.Text = ~"" + String((ll_net + ll_tare), "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
wf_syn_skid_wt()
//wf_duplicate_skid_info()

dw_report.ResetUpdate()

end event

type sle_1 from u_sle within w_report_skid_entry
integer x = 443
integer y = 38
integer width = 2359
integer taborder = 20
boolean bringtotop = true
end type

event losefocus;String ls_modstring
ls_modstring = "customer_t.Text = ~"" + this.Text + "~""
dw_report.Modify(ls_modstring) 

end event

type sle_2 from u_sle within w_report_skid_entry
integer x = 443
integer y = 125
integer width = 2359
integer taborder = 11
boolean bringtotop = true
end type

event losefocus;String ls_modstring
ls_modstring = "material_t.Text = ~"" + this.Text + "~""
dw_report.Modify(ls_modstring) 

end event

type st_1 from statictext within w_report_skid_entry
integer x = 29
integer y = 35
integer width = 388
integer height = 74
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "CUSTOMER"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_report_skid_entry
integer x = 29
integer y = 125
integer width = 388
integer height = 74
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "MATERIAL"
alignment alignment = right!
boolean focusrectangle = false
end type

