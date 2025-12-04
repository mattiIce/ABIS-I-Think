$PBExportHeader$w_prod_order_summary.srw
$PBExportComments$<Response> print production order report with a preview, inherited from pfemain/w_sheet
forward
global type w_prod_order_summary from w_sheet
end type
type dw_summary from u_dw within w_prod_order_summary
end type
type cb_print from u_cb within w_prod_order_summary
end type
type cb_close from u_cb within w_prod_order_summary
end type
type st_1 from statictext within w_prod_order_summary
end type
type tab_production from tab within w_prod_order_summary
end type
type tabpage_skid from userobject within tab_production
end type
type dw_skid_list from u_dw within tabpage_skid
end type
type dw_skid_detail from u_dw within tabpage_skid
end type
type st_2 from statictext within tabpage_skid
end type
type tabpage_skid from userobject within tab_production
dw_skid_list dw_skid_list
dw_skid_detail dw_skid_detail
st_2 st_2
end type
type tabpage_remain from userobject within tab_production
end type
type r_1 from rectangle within tabpage_remain
end type
type dw_prod_remains from u_dw within tabpage_remain
end type
type tabpage_remain from userobject within tab_production
r_1 r_1
dw_prod_remains dw_prod_remains
end type
type tabpage_scrap from userobject within tab_production
end type
type r_2 from rectangle within tabpage_scrap
end type
type dw_scrap_list from u_dw within tabpage_scrap
end type
type tabpage_scrap from userobject within tab_production
r_2 r_2
dw_scrap_list dw_scrap_list
end type
type tabpage_rejcoil from userobject within tab_production
end type
type r_3 from rectangle within tabpage_rejcoil
end type
type dw_rejcoil_list from u_dw within tabpage_rejcoil
end type
type tabpage_rejcoil from userobject within tab_production
r_3 r_3
dw_rejcoil_list dw_rejcoil_list
end type
type tabpage_reband from userobject within tab_production
end type
type r_5 from rectangle within tabpage_reband
end type
type dw_rebanded_list from u_dw within tabpage_reband
end type
type tabpage_reband from userobject within tab_production
r_5 r_5
dw_rebanded_list dw_rebanded_list
end type
type tab_production from tab within w_prod_order_summary
tabpage_skid tabpage_skid
tabpage_remain tabpage_remain
tabpage_scrap tabpage_scrap
tabpage_rejcoil tabpage_rejcoil
tabpage_reband tabpage_reband
end type
type st_3 from statictext within w_prod_order_summary
end type
type st_4 from statictext within w_prod_order_summary
end type
type ln_1 from line within w_prod_order_summary
end type
type ln_2 from line within w_prod_order_summary
end type
type sle_1 from statictext within w_prod_order_summary
end type
type sle_2 from statictext within w_prod_order_summary
end type
type r_4 from rectangle within w_prod_order_summary
end type
end forward

global type w_prod_order_summary from w_sheet
integer x = 622
integer y = 144
integer width = 2406
integer height = 1818
string title = "Summary"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_summary dw_summary
cb_print cb_print
cb_close cb_close
st_1 st_1
tab_production tab_production
st_3 st_3
st_4 st_4
ln_1 ln_1
ln_2 ln_2
sle_1 sle_1
sle_2 sle_2
r_4 r_4
end type
global w_prod_order_summary w_prod_order_summary

type variables
DataStore ids_report
Long il_job

Boolean	ib_use_package_num //Alex Gerlants. 06/15/2018. Arconic_Package_Num
end variables

forward prototypes
public subroutine wf_set_display_values (long al_job)
public function long wf_rejected_coil_wt (long al_coil_num)
public subroutine wf_set_values (long al_job)
public subroutine wf_get_jobinfo (long al_job)
public function integer wf_get_use_package_num (long al_ab_job_num, ref boolean ab_use_package_num)
end prototypes

public subroutine wf_set_display_values (long al_job);String ls_modstring
Long ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_rejnet, ll_t, ll_l1, ll_l2, ll_rebandedwt, ll_unprocessed_num, ll_unprocessednet

CONNECT USING SQLCA;

SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 

//Modified by Victor Huang in 04/05
SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_unprocessed_num
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessed_num
ls_modstring = "unproccoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_unprocessednet
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessednet
ls_modstring = "unproccoil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 

ll_l1 = tab_production.tabpage_rejcoil.dw_rejcoil_list.RowCount()
ll_l2 = tab_production.tabpage_reband.dw_rebanded_list.RowCount()
ll_l = ll_l1 + ll_l2
ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 
ll_rejnet = 0

IF ll_l1 > 0 THEN
	FOR ll_t = 1 TO ll_l1
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(tab_production.tabpage_rejcoil.dw_rejcoil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
	ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
	tab_production.tabpage_rejcoil.dw_rejcoil_list.Modify(ls_modstring) 
END IF
ll_rebandedwt = 0
IF ll_l2 > 0 THEN
	FOR ll_t = 1 TO ll_l2
		ll_rebandedwt = ll_rebandedwt + wf_rejected_coil_wt(tab_production.tabpage_reband.dw_rebanded_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
	ls_modstring = "rejcoil_wt_t.Text = ~"" + String(ll_rebandedwt, "###,###,###") + "~""
	tab_production.tabpage_reband.dw_rebanded_list.Modify(ls_modstring) 
END IF
ll_rejnet = ll_rejnet + ll_rebandedwt
ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 


SELECT NVL(COUNT(sheet_skid_num),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 

SELECT NVL(COUNT(return_scrap_item_num),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 
ll_coilnet = ll_l

SELECT NVL(SUM(prod_item_net_wt),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 
ll_sheetnet = ll_l

SELECT NVL(SUM(return_item_net_wt),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 
ll_scrapnet = ll_l

SELECT NVL(SUM(prod_item_pieces),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_pc_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 

SELECT SUM(sheet_tare_wt) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_sheetnet
ls_modstring = "sheet_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 

SELECT NVL(SUM(scrap_tare_wt),0) INTO :ll_l
FROM scrap_skid
WHERE scrap_ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_scrapnet
ls_modstring = "scrap_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_summary.Modify(ls_modstring) 


ll_l = ll_sheetnet + ll_scrapnet + ll_rejnet + ll_unprocessednet - ll_coilnet 
ls_modstring = "off_t.Text = ~"" + String(ll_l, "###,###,##0") + "~""
dw_summary.Modify(ls_modstring) 
ls_modstring = "off_per_t.Text = ~"( " + String((ll_l/ll_coilnet)*100, "#0.###") + "% )~""
dw_summary.Modify(ls_modstring) 

//BEGIN Modified by Victor Huang in 04/06
ls_modstring = "processed_t.Text = ~"" + String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###") + "~""
dw_summary.Modify(ls_modstring)
//END Modified by Victor Huang in 04/06

end subroutine

public function long wf_rejected_coil_wt (long al_coil_num);Long ll_wt1, ll_wt2, ll_wt, ll_shift_end_wt

CONNECT USING SQLCA;

SELECT process_quantity, process_end_wt INTO :ll_wt, :ll_shift_end_wt
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (ab_job_num = :il_job)
USING SQLCA;
IF IsNULL(ll_wt) THEN ll_wt = 0

IF IsNULL(ll_shift_end_wt) THEN
	SELECT net_wt_balance INTO :ll_wt1
	FROM coil
	WHERE coil_abc_num = :al_coil_num
	USING SQLCA;
	IF ISNULL(ll_wt1) THEN ll_wt1 = 0
ELSE
	ll_wt1 = ll_shift_end_wt
END IF

SELECT MAX(process_quantity) INTO :ll_wt2
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (process_quantity < :ll_wt)
USING SQLCA;
IF IsNULL(ll_wt2) THEN ll_wt2 = 0

RETURN MAX(ll_wt1, ll_wt2)
end function

public subroutine wf_set_values (long al_job);String ls_modstring
Long ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_t, ll_rejnet, ll_l1, ll_l2, ll_unprocessed_num, ll_unprocessednet

CONNECT USING SQLCA;

SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 

//BEGIN Modified by Victor Huang in 04/05
SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_unprocessed_num
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessed_num
ls_modstring = "unproccoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_unprocessednet
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessednet
ls_modstring = "unproccoil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 
//END Modified by Victor Huang in 04/05

ll_l1 = tab_production.tabpage_rejcoil.dw_rejcoil_list.RowCount()
ll_l2 = tab_production.tabpage_reband.dw_rebanded_list.RowCount()
ll_l = ll_l1 + ll_l2
ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 
ll_rejnet = 0

IF ll_l1 > 0 THEN
	FOR ll_t = 1 TO ll_l1
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(tab_production.tabpage_rejcoil.dw_rejcoil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
IF ll_l2 > 0 THEN
	FOR ll_t = 1 TO ll_l2
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(tab_production.tabpage_reband.dw_rebanded_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 

SELECT NVL(COUNT(sheet_skid_num),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 

SELECT NVL(COUNT(return_scrap_item_num),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 
ll_coilnet = ll_l

SELECT NVL(SUM(prod_item_net_wt),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 
ll_sheetnet = ll_l

SELECT NVL(SUM(return_item_net_wt),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 
ll_scrapnet = ll_l

SELECT NVL(SUM(prod_item_pieces),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_pc_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 

SELECT NVL(SUM(sheet_tare_wt),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_sheetnet
ls_modstring = "sheet_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 

SELECT NVL(SUM(scrap_tare_wt),0) INTO :ll_l
FROM scrap_skid
WHERE scrap_ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_scrapnet
ls_modstring = "scrap_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
ids_report.Modify(ls_modstring) 

ll_l = ll_sheetnet + ll_scrapnet + ll_rejnet + ll_unprocessednet - ll_coilnet
ls_modstring = "off_t.Text = ~"" + String(ll_l, "###,###,##0") + "~""
ids_report.Modify(ls_modstring) 
ls_modstring = "off_per_t.Text = ~"( " + String((ll_l/ll_coilnet)*100, "#0.###") + "% )~""
ids_report.Modify(ls_modstring) 

//BEGIN Modified by Victor Huang in 04/06
ls_modstring = "processed_t.Text = ~"" + String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###") + "~""
ids_report.Modify(ls_modstring)
//END Modified by Victor Huang in 04/06
end subroutine

public subroutine wf_get_jobinfo (long al_job);SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper
Long ll_cust, ll_order, ll_enduser
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT orig_customer_id, enduser_id INTO :ll_cust, :ll_enduser
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
sle_1.Text = Upper(ls_cust)

SELECT sheet_type, alloy2, temper, order_item_desc, gauge, enduser_part_num  
INTO :ls_shape, :ls_alloy, :ls_temper, :ls_desc, :lr_gauge, :ls_part#
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

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
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec +  String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE ELSE
		ls_spec = " "
END CHOOSE	
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part#
sle_2.Text = ls_spec


end subroutine

public function integer wf_get_use_package_num (long al_ab_job_num, ref boolean ab_use_package_num);//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
/*
Function:	wf_get_use_package_num
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value			long		al_ab_job_num
				reference	boolean	ab_use_package_num
*/
Integer	li_rtn = 1
String	ls_use_package_num

select   upper(customer.use_package_num)
into		:ls_use_package_num
from     ab_job
         join customer_order on customer_order.order_abc_num = ab_job.order_abc_num
			join customer on customer.customer_id = customer_order.orig_customer_id
where    ab_job.ab_job_num = :al_ab_job_num
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	If sqlca.sqlnrows > 0 Then
		If IsNull(ls_use_package_num) Then ls_use_package_num = "N"
	Else //sqlca.sqlnrows <= 0
		ls_use_package_num = "N"
	End If
Else //DB error
	li_rtn = -1
	ls_use_package_num = "N"
	
	MessageBox("DB Error", "Database error in wf_get_use_package_num while trying to retrieve use_package_num from table customer" + &
									"~n~r~n~rError:~n~r" + sqlca.sqlerrtext + &
									"~n~r~n~rAssuming use_package_num = 'N'", StopSign!)
End If

If ls_use_package_num = "Y" Then 
	ab_use_package_num = True
Else
	ab_use_package_num = False
End If

Return li_rtn
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
end function

on w_prod_order_summary.create
int iCurrent
call super::create
this.dw_summary=create dw_summary
this.cb_print=create cb_print
this.cb_close=create cb_close
this.st_1=create st_1
this.tab_production=create tab_production
this.st_3=create st_3
this.st_4=create st_4
this.ln_1=create ln_1
this.ln_2=create ln_2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.r_4=create r_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_summary
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.tab_production
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.ln_1
this.Control[iCurrent+9]=this.ln_2
this.Control[iCurrent+10]=this.sle_1
this.Control[iCurrent+11]=this.sle_2
this.Control[iCurrent+12]=this.r_4
end on

on w_prod_order_summary.destroy
call super::destroy
destroy(this.dw_summary)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.tab_production)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.r_4)
end on

event open;call super::open;il_job = message.doubleparm
this.title = "Printing summary of production order # :  " + String(il_job)

tab_production.tabpage_skid.dw_skid_list.of_SetLinkage ( TRUE )
tab_production.tabpage_skid.dw_skid_detail.of_SetLinkage ( TRUE )
tab_production.tabpage_skid.dw_skid_detail.inv_linkage.of_SetMaster(tab_production.tabpage_skid.dw_skid_list)
IF NOT tab_production.tabpage_skid.dw_skid_detail.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked skid & detail in win w_prodution!" )
ELSE
	tab_production.tabpage_skid.dw_skid_detail.inv_linkage.of_Register( "sheet_skid_sheet_skid_num", "sheet_skid_detail_sheet_skid_num" ) 
	tab_production.tabpage_skid.dw_skid_detail.inv_linkage.of_SetStyle( 2 ) 
END IF
tab_production.tabpage_skid.dw_skid_list.inv_Linkage.of_SetTransObject(sqlca) 

tab_production.tabpage_rejcoil.dw_rejcoil_list.Retrieve(il_job)
tab_production.tabpage_skid.dw_skid_list.inv_linkage.of_Retrieve()
tab_production.tabpage_remain.dw_prod_remains.Retrieve(il_job)
tab_production.tabpage_scrap.dw_scrap_list.Retrieve(il_job)
tab_production.tabpage_reband.dw_rebanded_list.Retrieve(il_job)

f_get_use_package_num_4job(il_job, sqlca, ib_use_package_num) //Alex Gerlants. 06/15/2018. Arconic_Package_Num

dw_summary.Retrieve(il_job)
wf_set_display_values(il_job)
wf_get_jobinfo(il_job)
end event

type dw_summary from u_dw within w_prod_order_summary
integer x = 22
integer y = 1395
integer width = 2344
integer height = 202
integer taborder = 40
string dataobject = "d_prod_order_summary"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetPrintPreview(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type cb_print from u_cb within w_prod_order_summary
integer x = 636
integer y = 1613
integer width = 351
integer height = 83
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;Printsetup()

ids_report = CREATE DataStore

//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
If ib_use_package_num Then
	ids_report.DataObject = "d_report_prod_order_summary_pn"
Else //ib_use_package_num = False
	ids_report.DataObject = "d_report_prod_order_summary"
End If
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

ids_report.SetTransObject(sqlca)
ids_report.Retrieve(message.doubleparm)
wf_set_values(message.doubleparm)

String ls_modstring
ls_modstring = "customer_t.Text = ~"" + sle_1.Text + "~""
ids_report.Modify(ls_modstring) 
ls_modstring = "material_t.Text = ~"" + sle_2.Text + "~""
ids_report.Modify(ls_modstring) 

//Alex Gerlants. 10/21/2019. Rename PDF File. Begin
Integer					li_rc
String					ls_orig_customer_po

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

li_rc = f_rename_and_print_job_ds(ls_orig_customer_po, il_job, ids_report)

//ids_report.print() //Alex Gerlants. 10/21/2019. Rename PDF File. Comment out
//Alex Gerlants. 10/21/2019. Rename PDF File. End

IF IsValid(ids_report) THEN DESTROY ids_report

RETURN 1
end event

type cb_close from u_cb within w_prod_order_summary
string tag = "Close without printing"
integer x = 1346
integer y = 1613
integer width = 351
integer height = 83
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;IF IsValid(ids_report) THEN DESTROY ids_report
Close(Parent)
end event

type st_1 from statictext within w_prod_order_summary
integer x = 18
integer y = 1341
integer width = 252
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Summary:"
boolean focusrectangle = false
end type

type tab_production from tab within w_prod_order_summary
integer x = 15
integer y = 189
integer width = 2355
integer height = 1155
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean boldselectedtext = true
boolean pictureonright = true
integer selectedtab = 1
tabpage_skid tabpage_skid
tabpage_remain tabpage_remain
tabpage_scrap tabpage_scrap
tabpage_rejcoil tabpage_rejcoil
tabpage_reband tabpage_reband
end type

on tab_production.create
this.tabpage_skid=create tabpage_skid
this.tabpage_remain=create tabpage_remain
this.tabpage_scrap=create tabpage_scrap
this.tabpage_rejcoil=create tabpage_rejcoil
this.tabpage_reband=create tabpage_reband
this.Control[]={this.tabpage_skid,&
this.tabpage_remain,&
this.tabpage_scrap,&
this.tabpage_rejcoil,&
this.tabpage_reband}
end on

on tab_production.destroy
destroy(this.tabpage_skid)
destroy(this.tabpage_remain)
destroy(this.tabpage_scrap)
destroy(this.tabpage_rejcoil)
destroy(this.tabpage_reband)
end on

type tabpage_skid from userobject within tab_production
integer x = 15
integer y = 90
integer width = 2326
integer height = 1053
long backcolor = 79741120
string text = "Sheet Skid"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Horizontal!"
long picturemaskcolor = 553648127
dw_skid_list dw_skid_list
dw_skid_detail dw_skid_detail
st_2 st_2
end type

on tabpage_skid.create
this.dw_skid_list=create dw_skid_list
this.dw_skid_detail=create dw_skid_detail
this.st_2=create st_2
this.Control[]={this.dw_skid_list,&
this.dw_skid_detail,&
this.st_2}
end on

on tabpage_skid.destroy
destroy(this.dw_skid_list)
destroy(this.dw_skid_detail)
destroy(this.st_2)
end on

type dw_skid_list from u_dw within tabpage_skid
integer x = 7
integer y = 13
integer width = 2297
integer height = 739
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_prod_job_skid_list"
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetPrintPreview(TRUE)

end event

event pfc_retrieve;call super::pfc_retrieve;RETURN this.Retrieve(il_job)
end event

event rbuttondown;Return 0
end event

event rbuttonup;Return 0
end event

type dw_skid_detail from u_dw within tabpage_skid
integer x = 4
integer y = 813
integer width = 2308
integer height = 221
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_prod_skid_detail_list"
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetPrintPreview(TRUE)

end event

event rbuttondown;Return 0
end event

event rbuttonup;Return 0
end event

type st_2 from statictext within tabpage_skid
integer x = 7
integer y = 755
integer width = 344
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Skid Detail:"
boolean focusrectangle = false
end type

type tabpage_remain from userobject within tab_production
integer x = 15
integer y = 90
integer width = 2326
integer height = 1053
long backcolor = 79741120
string text = "Partial"
long tabtextcolor = 33554432
long tabbackcolor = 12639424
string picturename = "Cascade!"
long picturemaskcolor = 79741120
r_1 r_1
dw_prod_remains dw_prod_remains
end type

on tabpage_remain.create
this.r_1=create r_1
this.dw_prod_remains=create dw_prod_remains
this.Control[]={this.r_1,&
this.dw_prod_remains}
end on

on tabpage_remain.destroy
destroy(this.r_1)
destroy(this.dw_prod_remains)
end on

type r_1 from rectangle within tabpage_remain
long linecolor = 12639424
integer linethickness = 12
long fillcolor = 79741120
integer x = 4
integer width = 2311
integer height = 1037
end type

type dw_prod_remains from u_dw within tabpage_remain
integer x = 366
integer y = 48
integer width = 1459
integer height = 928
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_prod_remain_display"
end type

event constructor;SetTransObject(SQLCA)

end event

event rbuttondown;Return 0
end event

event rbuttonup;Return 0
end event

type tabpage_scrap from userobject within tab_production
integer x = 15
integer y = 90
integer width = 2326
integer height = 1053
long backcolor = 79741120
string text = "Scrap"
long tabtextcolor = 33554432
long tabbackcolor = 65535
string picturename = "ArrangeIcons!"
long picturemaskcolor = 79741120
r_2 r_2
dw_scrap_list dw_scrap_list
end type

on tabpage_scrap.create
this.r_2=create r_2
this.dw_scrap_list=create dw_scrap_list
this.Control[]={this.r_2,&
this.dw_scrap_list}
end on

on tabpage_scrap.destroy
destroy(this.r_2)
destroy(this.dw_scrap_list)
end on

type r_2 from rectangle within tabpage_scrap
long linecolor = 65535
integer linethickness = 16
long fillcolor = 79741120
integer width = 2311
integer height = 1037
end type

type dw_scrap_list from u_dw within tabpage_scrap
integer x = 33
integer y = 29
integer width = 2249
integer height = 989
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ab_job_scrap_list"
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetPrintPreview(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;Return 0
end event

event rbuttonup;Return 0
end event

type tabpage_rejcoil from userobject within tab_production
integer x = 15
integer y = 90
integer width = 2326
integer height = 1053
long backcolor = 79741120
string text = "Rej.Coil"
long tabtextcolor = 33554432
long tabbackcolor = 1090519039
string picturename = "CheckStatus!"
long picturemaskcolor = 79741120
r_3 r_3
dw_rejcoil_list dw_rejcoil_list
end type

on tabpage_rejcoil.create
this.r_3=create r_3
this.dw_rejcoil_list=create dw_rejcoil_list
this.Control[]={this.r_3,&
this.dw_rejcoil_list}
end on

on tabpage_rejcoil.destroy
destroy(this.r_3)
destroy(this.dw_rejcoil_list)
end on

type r_3 from rectangle within tabpage_rejcoil
long linecolor = 1090519039
integer linethickness = 12
long fillcolor = 79741120
integer x = 4
integer y = 3
integer width = 2311
integer height = 1040
end type

type dw_rejcoil_list from u_dw within tabpage_rejcoil
integer x = 37
integer y = 29
integer width = 2249
integer height = 986
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ab_job_rej_coil_list"
boolean hscrollbar = true
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetPrintPreview(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;Return 0
end event

event rbuttonup;Return 0
end event

type tabpage_reband from userobject within tab_production
integer x = 15
integer y = 90
integer width = 2326
integer height = 1053
long backcolor = 79741120
string text = "Rebanded Coil"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "DataPipeline!"
long picturemaskcolor = 79741120
r_5 r_5
dw_rebanded_list dw_rebanded_list
end type

on tabpage_reband.create
this.r_5=create r_5
this.dw_rebanded_list=create dw_rebanded_list
this.Control[]={this.r_5,&
this.dw_rebanded_list}
end on

on tabpage_reband.destroy
destroy(this.r_5)
destroy(this.dw_rebanded_list)
end on

type r_5 from rectangle within tabpage_reband
long linecolor = 15780518
integer linethickness = 12
long fillcolor = 79741120
integer x = 4
integer width = 2319
integer height = 1050
end type

type dw_rebanded_list from u_dw within tabpage_reband
integer x = 37
integer y = 19
integer width = 2253
integer height = 1005
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ab_job_reband_coil_list"
boolean hscrollbar = true
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetPrintPreview(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;Return 0
end event

event rbuttonup;Return 0
end event

type st_3 from statictext within w_prod_order_summary
integer x = 37
integer y = 19
integer width = 293
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "CUSTOMER:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_prod_order_summary
integer x = 37
integer y = 99
integer width = 293
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "MATERIAL:"
boolean focusrectangle = false
end type

type ln_1 from line within w_prod_order_summary
long linecolor = 33554432
integer linethickness = 4
integer beginx = 362
integer beginy = 77
integer endx = 2300
integer endy = 77
end type

type ln_2 from line within w_prod_order_summary
long linecolor = 33554432
integer linethickness = 4
integer beginx = 362
integer beginy = 157
integer endx = 2300
integer endy = 157
end type

type sle_1 from statictext within w_prod_order_summary
integer x = 366
integer y = 13
integer width = 1927
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "          "
boolean focusrectangle = false
end type

type sle_2 from statictext within w_prod_order_summary
integer x = 366
integer y = 93
integer width = 1927
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "          "
boolean focusrectangle = false
end type

type r_4 from rectangle within w_prod_order_summary
long linecolor = 79741120
integer linethickness = 4
long fillcolor = 79741120
integer x = 1331
integer y = 243
integer width = 168
integer height = 147
end type

