$PBExportHeader$w_inv_recap.srw
$PBExportComments$<Sheet> List all skids and all information about each skid, used for recap process in production .inherited from pfemain\w_sheet
forward
global type w_inv_recap from w_sheet
end type
type dw_skid_list from u_dw within w_inv_recap
end type
type cb_report from u_cb within w_inv_recap
end type
type cb_ready from u_cb within w_inv_recap
end type
type dw_customer from u_dw within w_inv_recap
end type
type cb_save from u_cb within w_inv_recap
end type
type cb_close from u_cb within w_inv_recap
end type
type dw_item_list from u_dw within w_inv_recap
end type
type gb_search from u_gb within w_inv_recap
end type
type cb_sort from u_cb within w_inv_recap
end type
type ddlb_customer from dropdownlistbox within w_inv_recap
end type
type st_1 from statictext within w_inv_recap
end type
type cb_summary from u_cb within w_inv_recap
end type
type cb_prod from u_cb within w_inv_recap
end type
type cb_search from u_cb within w_inv_recap
end type
type cb_reset from u_cb within w_inv_recap
end type
type st_cond from statictext within w_inv_recap
end type
type st_2 from statictext within w_inv_recap
end type
type st_3 from statictext within w_inv_recap
end type
type st_4 from statictext within w_inv_recap
end type
type st_5 from statictext within w_inv_recap
end type
type st_6 from statictext within w_inv_recap
end type
type st_7 from statictext within w_inv_recap
end type
type st_8 from statictext within w_inv_recap
end type
type st_9 from statictext within w_inv_recap
end type
type cb_p_ready from u_cb within w_inv_recap
end type
end forward

global type w_inv_recap from w_sheet
string tag = "Skid Recap"
integer x = 5
integer y = 4
integer width = 3374
integer height = 2084
string title = "Recap application"
string menuname = "m_recap_main"
boolean maxbox = false
boolean resizable = false
event ue_search ( )
event ue_sort ( )
event type string ue_whoami ( )
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
dw_skid_list dw_skid_list
cb_report cb_report
cb_ready cb_ready
dw_customer dw_customer
cb_save cb_save
cb_close cb_close
dw_item_list dw_item_list
gb_search gb_search
cb_sort cb_sort
ddlb_customer ddlb_customer
st_1 st_1
cb_summary cb_summary
cb_prod cb_prod
cb_search cb_search
cb_reset cb_reset
st_cond st_cond
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
cb_p_ready cb_p_ready
end type
global w_inv_recap w_inv_recap

type variables
integer ii_dw_flag
datastore ids_datastore
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
end variables

forward prototypes
public function string wf_search_terms ()
public function integer wf_double_check ()
public function string wf_display_total_terms ()
public function integer wf_display_total_info ()
public subroutine wf_display_gross_wt (long row_num)
public subroutine wf_init_dwdb ()
public subroutine wf_reset_condition ()
public function real wf_get_pctheowt (long al_job)
end prototypes

event ue_search;call super::ue_search;dw_skid_list.Event ue_search_retrieve()
end event

event ue_sort;call super::ue_sort;String ls_null

SetNULL(ls_null)
dw_skid_list.inv_sort.of_SetSort(ls_null)
dw_skid_list.inv_sort.of_Sort()
end event

event ue_whoami;RETURN "w_inv_recap"
end event

event ue_read_only;dw_skid_list.Object.DataWindow.ReadOnly = "YES"
dw_item_list.Object.DataWindow.ReadOnly = "YES"
cb_ready.Enabled = FALSE
cb_save.Enabled = FALSE
m_recap_main.m_file.m_save.Disable()

end event

event ue_set_search;Long ll_row, ll_l
String ls_s
Int li_i, li_s

ll_row = adw_d.RowCount()
IF ll_row < 1 THEN RETURN
FOR ll_l = 1 TO ll_row
	IF Len(ls_s) > 1 THEN ls_s = ls_s + ', '
	ls_s = ls_s + adw_d.getItemString(ll_l, "column_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
NEXT
st_cond.Text = ls_s

wf_reset_condition()

li_s = 1
FOR ll_l = 1 TO ll_row
	li_i = 1
	DO WHILE li_i <= Upperbound(istr_dwdb)
		IF istr_dwdb[li_i].dw_header = adw_d.getItemString(ll_l, "column_t", Primary!, FALSE) THEN
			istr_search[li_s].db_name = istr_dwdb[li_i].db_name
			istr_search[li_s].db_field = istr_dwdb[li_i].db_field
			istr_search[li_s].col_type = istr_dwdb[li_i].col_type
			istr_search[li_s].operator = adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
			istr_search[li_s].value = adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
			IF istr_search[li_s].col_type = "status" THEN
					CHOOSE CASE Upper(Trim(istr_search[li_s].value))
					CASE "GONE"
						istr_search[li_s].value = "0"
					CASE "INPROCESS"
						istr_search[li_s].value = "1"					
					CASE "READY"
						istr_search[li_s].value = "2"					
					CASE "CANCELED"
						istr_search[li_s].value = "3"					
					CASE "ONHOLD"
						istr_search[li_s].value = "4"					
					CASE "PRERECAP"
						istr_search[li_s].value = "5"
					CASE "PARTIAL"
						istr_search[li_s].value = "7"
					CASE "WH-READY"
						istr_search[li_s].value = "8"
					CASE "WH-COMING"
						istr_search[li_s].value = "9"
					CASE "WH-SORT"
						istr_search[li_s].value = "10"
					CASE "WH-GONE"
						istr_search[li_s].value = "11"
					CASE "SAMPLE"
						istr_search[li_s].value = "12"
					CASE "PARTIAL-RD"
						istr_search[li_s].value = "13"
					CASE ELSE
						istr_search[li_s].value = "9999"
				END CHOOSE
			END IF
			li_s++
		END IF
	li_i++
	LOOP
NEXT

dw_skid_list.Event ue_search_retrieve()

end event

event ue_get_header;Int li_i
s_dw_header_type lstr_ht

lstr_ht.dw_header = "NULL"
lstr_ht.col_type = "NULL"

li_i = 1
DO WHILE li_i <= UpperBound(istr_dwdb)
	IF istr_dwdb[li_i].dw_column = as_id THEN
		 lstr_ht.dw_header = istr_dwdb[li_i].dw_header
		 lstr_ht.col_type = istr_dwdb[li_i].col_type
	END IF
	li_i++
LOOP

RETURN lstr_ht
end event

public function string wf_search_terms ();String ls_terms
integer li_i

ls_terms = " WHERE ( ~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" ) and          ( ~~~"SHEET_SKID~~~".~~~"AB_JOB_NUM~~~" = ~~~"AB_JOB~~~".~~~"AB_JOB_NUM~~~" ) and          ( ( ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = :customer_id ) and          ( ~~~"SHEET_SKID~~~".~~~"SKID_SHEET_STATUS~~~" = 5 )  )"
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "status"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
			CASE "date"
				ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
			CASE "string"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
		END CHOOSE
	END IF
	li_i++
LOOP

Return ls_terms
end function

public function integer wf_double_check ();Return 1
end function

public function string wf_display_total_terms ();String ls_terms
String ls_date, ls_op
integer li_rc
Long ll_row, ll_cust
Int li_i

SetNULL(ls_terms)
ll_row = dw_customer.GetRow()
IF ll_row <= 0 THEN RETURN ls_terms
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")

ls_terms = " WHERE ( AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM ) and ( SHEET_SKID.AB_JOB_NUM = AB_JOB.AB_JOB_NUM) and ( ( CUSTOMER_ORDER.ORIG_CUSTOMER_ID = " + String(ll_cust) + ") and ( SHEET_SKID.SKID_SHEET_STATUS = 5 ) )"
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].operator <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "status"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value + " )"
			CASE "date"
				ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + ", 'DD-MON-YYYY'), 'DD-MON-YYYY') " + istr_search[li_i].operator + " TO_DATE('" + istr_search[li_i].value + "','mm/dd/yyyy' )" + " )"
			CASE "string"
				ls_terms = ls_terms + " AND ( " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " ~'" + istr_search[li_i].value + "~' )"
		END CHOOSE
	END IF
	li_i++
LOOP

Return ls_terms
end function

public function integer wf_display_total_info ();String ls_where, ls_select
Long ll_item

ls_where = wf_display_total_terms()
IF IsNULL(ls_where) THEN RETURN 0

CONNECT USING SQLCA;

ls_select = "SELECT COUNT(sheet_skid.sheet_skid_num) FROM sheet_skid, ab_job, customer_order "

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
String ls_Mysql
ls_Mysql = ls_select + ls_where
PREPARE SQLSA FROM :ls_Mysql;
OPEN DYNAMIC my_cursor;
FETCH my_cursor INTO :ll_item;
CLOSE my_cursor ;

IF IsNULL(ll_item) THEN ll_item = 0

IF ll_item < 2 THEN
	dw_skid_list.Object.item_t.Text = String(ll_item, "#,###,###")
	dw_skid_list.Object.skid_t.Text = "skid"
ELSE
	dw_skid_list.Object.item_t.Text = String(ll_item, "#,###,###")
	dw_skid_list.Object.skid_t.Text = "skids"
END IF

RETURN 1

end function

public subroutine wf_display_gross_wt (long row_num);Long ll_item, ll_temp, ll_row, ll_c

ll_temp = 0
ll_item = 0

IF IsNULL(row_num) OR (row_num < 1 ) THEN
	dw_item_list.Object.gross_t.Text = "0"
	RETURN
END IF

ll_temp = dw_skid_list.GetItemNumber(row_num, "sheet_skid_sheet_tare_wt", Primary!, FALSE)
IF IsNULL(ll_temp) THEN ll_temp = 0
ll_item = ll_temp

ll_row = dw_item_list.RowCount()
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_temp = 0
		ll_temp = dw_item_list.GetItemNumber(ll_c, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
		IF IsNULL(ll_temp) THEN ll_temp = 0
		ll_item = ll_item + ll_temp
	NEXT
END IF

dw_item_list.Object.gross_t.Text = String(ll_item, "#,###,###")

end subroutine

public subroutine wf_init_dwdb ();istr_dwdb[1].db_name = "SHEET_SKID"
istr_dwdb[1].db_field = "SHEET_SKID_NUM"
istr_dwdb[1].dw_column = "sheet_skid_sheet_skid_num"
istr_dwdb[1].col_type = "number"
istr_dwdb[1].dw_header = "Skid ID"

istr_dwdb[2].db_name = "SHEET_SKID"
istr_dwdb[2].db_field = "AB_JOB_NUM"
istr_dwdb[2].dw_column = "sheet_skid_ab_job_num"
istr_dwdb[2].col_type = "number"
istr_dwdb[2].dw_header = "Prod Order"

istr_dwdb[3].db_name = "SHEET_SKID"
istr_dwdb[3].db_field = "SHEET_NET_WT"
istr_dwdb[3].dw_column = "sheet_skid_sheet_net_wt"
istr_dwdb[3].col_type = "number"
istr_dwdb[3].dw_header = "Net WT"

istr_dwdb[4].db_name = "SHEET_SKID"
istr_dwdb[4].db_field = "SHEET_TARE_WT"
istr_dwdb[4].dw_column = "sheet_skid_sheet_tare_wt"
istr_dwdb[4].col_type = "number"
istr_dwdb[4].dw_header = "Tare WT"

istr_dwdb[5].db_name = "SHEET_SKID"
istr_dwdb[5].db_field = "SKID_PIECES"
istr_dwdb[5].dw_column = "sheet_skid_skid_pieces"
istr_dwdb[5].col_type = "number"
istr_dwdb[5].dw_header = "Pieces"

istr_dwdb[6].db_name = "SHEET_SKID"
istr_dwdb[6].db_field = "SKID_SHEET_STATUS"
istr_dwdb[6].dw_column = "sheet_skid_skid_sheet_status"
istr_dwdb[6].col_type = "status"
istr_dwdb[6].dw_header = "Status"

istr_dwdb[7].db_name = "SHEET_SKID"
istr_dwdb[7].db_field = "SKID_LOCATION"
istr_dwdb[7].dw_column = "sheet_skid_skid_location"
istr_dwdb[7].col_type = "string"
istr_dwdb[7].dw_header = "Location"

istr_dwdb[8].db_name = "SHEET_SKID"
istr_dwdb[8].db_field = "SKID_DATE"
istr_dwdb[8].dw_column = "sheet_skid_skid_date"
istr_dwdb[8].col_type = "date"
istr_dwdb[8].dw_header = "Created Date"

istr_dwdb[9].db_name = "SHEET_SKID"
istr_dwdb[9].db_field = "SHEET_THEORETICAL_WT"
istr_dwdb[9].dw_column = "sheet_skid_sheet_theoretical_wt"
istr_dwdb[9].col_type = "number"
istr_dwdb[9].dw_header = "Theo WT"

//customer_order_orig_customer_id

end subroutine

public subroutine wf_reset_condition ();Int li_i
li_i = 1
DO WHILE li_i <= Upperbound(istr_search)
	istr_search[li_i].db_name = ""
	istr_search[li_i].db_field = ""
	istr_search[li_i].operator = ""
	istr_search[li_i].value = ""
	istr_search[li_i].col_type = ""
	li_i++
LOOP

end subroutine

public function real wf_get_pctheowt (long al_job);Long ll_order_item, ll_order
Real lr_wt

lr_wt = 0
CONNECT USING SQLCA;
SELECT order_item_num, order_abc_num INTO :ll_order_item, :ll_order
FROM ab_job
WHERE ab_job_num = :al_job
USING SQLCA;

IF ll_order_item > 0 AND ll_order > 0 THEN
	SELECT theoretical_unit_wt INTO :lr_wt
	FROM order_item
	WHERE order_abc_num = :ll_order AND order_item_num = :ll_order_item
	USING SQLCA;
END IF
IF IsNULL(lr_wt) THEN lr_wt = 0

RETURN lr_wt
end function

on w_inv_recap.create
int iCurrent
call super::create
if this.MenuName = "m_recap_main" then this.MenuID = create m_recap_main
this.dw_skid_list=create dw_skid_list
this.cb_report=create cb_report
this.cb_ready=create cb_ready
this.dw_customer=create dw_customer
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_item_list=create dw_item_list
this.gb_search=create gb_search
this.cb_sort=create cb_sort
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.cb_summary=create cb_summary
this.cb_prod=create cb_prod
this.cb_search=create cb_search
this.cb_reset=create cb_reset
this.st_cond=create st_cond
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.cb_p_ready=create cb_p_ready
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_skid_list
this.Control[iCurrent+2]=this.cb_report
this.Control[iCurrent+3]=this.cb_ready
this.Control[iCurrent+4]=this.dw_customer
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_item_list
this.Control[iCurrent+8]=this.gb_search
this.Control[iCurrent+9]=this.cb_sort
this.Control[iCurrent+10]=this.ddlb_customer
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.cb_summary
this.Control[iCurrent+13]=this.cb_prod
this.Control[iCurrent+14]=this.cb_search
this.Control[iCurrent+15]=this.cb_reset
this.Control[iCurrent+16]=this.st_cond
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.st_3
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.st_5
this.Control[iCurrent+21]=this.st_6
this.Control[iCurrent+22]=this.st_7
this.Control[iCurrent+23]=this.st_8
this.Control[iCurrent+24]=this.st_9
this.Control[iCurrent+25]=this.cb_p_ready
end on

on w_inv_recap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_skid_list)
destroy(this.cb_report)
destroy(this.cb_ready)
destroy(this.dw_customer)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_item_list)
destroy(this.gb_search)
destroy(this.cb_sort)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.cb_summary)
destroy(this.cb_prod)
destroy(this.cb_search)
destroy(this.cb_reset)
destroy(this.st_cond)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.cb_p_ready)
end on

event open;call super::open;dw_customer.Visible = FALSE

dw_customer.of_SetLinkage(TRUE)
dw_customer.inv_Linkage.of_setStyle(2)
dw_customer.inv_linkage.of_SetConfirmOnRowChange (True)
dw_customer.inv_linkage.of_setUpdateOnRowChange (TRUE)

dw_skid_list.of_SetLinkage( TRUE ) 
dw_skid_list.inv_Linkage.of_SetMaster(dw_customer)
IF NOT dw_skid_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & skid in win w_inv_skid!" )
ELSE
	dw_skid_list.inv_Linkage.of_Register( "customer_id", "customer_order_orig_customer_id" ) 
	dw_skid_list.inv_Linkage.of_SetStyle( 2 ) 
	dw_skid_list.inv_linkage.of_SetConfirmOnRowChange (True)
	dw_skid_list.inv_linkage.of_setUpdateOnRowChange (TRUE)
END IF

dw_item_list.of_SetLinkage ( TRUE )
dw_item_list.inv_linkage.of_SetMaster(dw_skid_list)
IF NOT dw_item_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked skid & detail in win w_inv_recap" )
ELSE
	dw_item_list.inv_linkage.of_Register( "sheet_skid_sheet_skid_num", "sheet_skid_detail_sheet_skid_num" ) 
	dw_item_list.inv_linkage.of_SetStyle( 2 ) 
END IF


dw_customer.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_customer.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_inv_coil::open function" )
ELSE
	SQLCA.of_Commit()
	dw_customer.SelectRow(1,TRUE)
	wf_display_total_info()
	dw_customer.SetFocus()
End IF

ii_dw_flag = 0
is_select =  " SELECT  ~~~"SHEET_SKID~~~".~~~"SHEET_SKID_NUM~~~" ,           ~~~"SHEET_SKID~~~".~~~"AB_JOB_NUM~~~" ,           ~~~"SHEET_SKID~~~".~~~"SHEET_NET_WT~~~" ,           ~~~"SHEET_SKID~~~".~~~"SHEET_TARE_WT~~~" ,           ~~~"SHEET_SKID~~~".~~~"SKID_PIECES~~~" ,           ~~~"SHEET_SKID~~~".~~~"SKID_SHEET_STATUS~~~" ,           ~~~"SHEET_SKID~~~".~~~"SKID_LOCATION~~~" ,           ~~~"SHEET_SKID~~~".~~~"SKID_DATE~~~" ,           ~~~"SHEET_SKID~~~".~~~"SHEET_THEORETICAL_WT~~~" ,           ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~"     FROM ~~~"AB_JOB~~~" ,           ~~~"CUSTOMER_ORDER~~~" ,           ~~~"SHEET_SKID~~~"    "  

wf_init_dwdb()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)


end event

event pfc_save;Int li_return

ii_dw_flag = 0
IF wf_double_check() < 0 THEN Return -1

dw_skid_list.AcceptText()
dw_item_list.AcceptText()

li_return = dw_customer.inv_linkage.of_GetUpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -1
ELSEIF li_return = 0 THEN
	//No Change
	Return 0
END IF

li_return = dw_customer.inv_linkage.of_UpdateTopDown()
IF li_return <> 1 THEN
	ROLLBACK using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN 
		MessageBox("Rollback Error", SQLCA.SQLErrText )
	ELSE
		MessageBox("Update Failed", "But Rollback succeeded" )
	END IF
ELSE
	COMMIT using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText )
		Return -2
	END IF
	dw_customer.inv_linkage.of_ResetUpdate()
END IF
dw_skid_list.SetFocus()

Return 1
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Inventory(ReCap)") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type dw_skid_list from u_dw within w_inv_recap
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
integer x = 27
integer y = 192
integer width = 2917
integer height = 1360
integer taborder = 40
string dataobject = "d_skid_list_per_cust_recap"
end type

event ue_search_retrieve;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net

if ii_dw_flag = 1 then 
   ls_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
   if ls_net =1 then
      Parent.Event pfc_Save()      
   else
      return 0
   end if
end if   

ls_where = wf_search_terms()

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
	IF this.RowCount() > 0 THEN
		this.SelectRow(1, True)
		this.ScrollToRow(1)
		inv_RowSelect.Event pfc_rowFocusChanged(1)
	ELSE
		dw_item_list.Reset()
	END IF
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

Return 1
end event

event ue_resume_where;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_where = " WHERE ( ~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" ) and          ( ~~~"SHEET_SKID~~~".~~~"AB_JOB_NUM~~~" = ~~~"AB_JOB~~~".~~~"AB_JOB_NUM~~~" ) and          ( ( ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = :customer_id ) and          ( ~~~"SHEET_SKID~~~".~~~"SKID_SHEET_STATUS~~~" = 5 ) )"
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
	IF this.RowCount() > 0 THEN
		this.SelectRow(1, True)
		this.ScrollToRow(1)
		inv_RowSelect.Event pfc_rowFocusChanged(1)
	ELSE
		dw_item_list.Reset()
	END IF
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"


end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row

ls_ColName = this.GetColumnName()
IF ls_ColName = "sheet_skid_sheet_tare_wt" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	wf_display_gross_wt(ll_row)
END IF

ii_dw_flag = 1
end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

wf_display_gross_wt(li_row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event clicked;//Override pfc_clicked because it is running wrong sequence

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

type cb_report from u_cb within w_inv_recap
integer x = 2958
integer y = 1044
integer height = 80
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Reports"
end type

event clicked;call super::clicked;long ll_row_cut
Long ll_cust_id

ll_row_cut = dw_customer.GetRow()
ll_cust_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, TRUE)

OpenWithParm(w_report_inv_skid, ll_cust_id )

end event

type cb_ready from u_cb within w_inv_recap
integer x = 2958
integer y = 428
integer width = 375
integer height = 80
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Set &Partial-Rd"
end type

event clicked;Long ll_row

ll_row = dw_skid_list.GetRow()
IF ll_row < 1 THEN Return 0

//Modified by Victor Huang in 08/05
//Check if the skid has been assigned to a new job. If "Yes", force user to remove the skid from the new job.
Long ll_skid, ll_orig_ab_job
ll_skid = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)

SetNull(ll_orig_ab_job)
select ab_job_num into :ll_orig_ab_job
from process_partial_skid
where sheet_skid_num = :ll_skid
using SQLCA;

IF not isnull(ll_orig_ab_job) THEN 
	MessageBox("Warning","This skid has been assigned to a new job#" + String(ll_orig_ab_job) +". Please remove it from the new job before any modification!", StopSign!)
	RETURN -1
END IF
//End

dw_skid_list.SetItem(ll_row, "Sheet_skid_skid_sheet_status", 13 ) //ready for partial 870

Return ll_row
end event

type dw_customer from u_dw within w_inv_recap
integer x = 686
integer y = 20
integer width = 105
integer height = 36
integer taborder = 0
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
boolean righttoleft = true
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event clicked;SelectRow(0, FALSE)

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF
SelectRow(row, TRUE)

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 









end event

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 




end event

event itemfocuschanged;call super::itemfocuschanged;dw_skid_list.SetFilter("")
dw_skid_list.Filter()
end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

wf_display_total_info()

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type cb_save from u_cb within w_inv_recap
integer x = 2958
integer y = 720
integer height = 80
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;Parent.Event pfc_Save()


end event

type cb_close from u_cb within w_inv_recap
string tag = "Exit"
integer x = 2962
integer y = 1352
integer height = 80
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type dw_item_list from u_dw within w_inv_recap
integer x = 27
integer y = 1556
integer width = 3314
integer height = 296
integer taborder = 50
string dataobject = "d_skid_detail_list_recap"
end type

event rbuttondown;//Override
Return 1
end event

event rbuttonup;//Override
Return 1
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 

end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row, ll_skid_num, ll_skid_row, ll_count, ll_pc, ll_job
Int li_totalrow, ll_i

ls_ColName = this.GetColumnName()
//pieces
IF ls_ColName = "production_sheet_item_prod_item_pieces" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_skid_num = this.GetItemNumber(ll_row,"sheet_skid_detail_sheet_skid_num")
	ll_skid_row = dw_skid_list.GetRow()
	IF ll_skid_num = dw_skid_list.GetItemNumber(ll_skid_row, "sheet_skid_sheet_skid_num") THEN
		li_totalrow = this.RowCount()
		ll_count = 0
		ll_count = this.GetItemNumber(1, "production_sheet_item_prod_item_pieces")
		IF li_totalrow > 1 THEN
			FOR ll_i = 2 TO li_totalrow
				ll_count = ll_count + this.GetItemNumber(ll_i, "production_sheet_item_prod_item_pieces")
			NEXT
		END IF
		dw_skid_list.SetItem(ll_skid_row, "sheet_skid_skid_pieces", ll_count)
	END IF
	ll_pc = this.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
	ll_job = this.GetItemNumber(ll_row,"production_sheet_item_ab_job_num", Primary!, FALSE)
	this.SetItem(ll_row,"production_sheet_item_prod_item_theoreti", Long(wf_get_pctheowt(ll_job) * ll_pc + 0.5) )
	this.AcceptText()
	IF ll_skid_num = dw_skid_list.GetItemNumber(ll_skid_row, "sheet_skid_sheet_skid_num") THEN
		li_totalrow = this.RowCount()
		ll_count = 0
		IF li_totalrow > 0 THEN
			FOR ll_i = 1 TO li_totalrow
				ll_count = ll_count + this.GetItemNumber(ll_i, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
			NEXT
		END IF
		dw_skid_list.SetItem(ll_skid_row, "sheet_skid_sheet_theoretical_wt", ll_count)
	END IF
END IF

//net wt
IF ls_ColName = "production_sheet_item_prod_item_net_wt" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_skid_num = this.GetItemNumber(ll_row,"sheet_skid_detail_sheet_skid_num")
	ll_skid_row = dw_skid_list.GetRow()
	IF ll_skid_num = dw_skid_list.GetItemNumber(ll_skid_row, "sheet_skid_sheet_skid_num") THEN
		li_totalrow = this.RowCount()
		ll_count = 0
		IF li_totalrow > 0 THEN
			FOR ll_i = 1 TO li_totalrow
				ll_count = ll_count + this.GetItemNumber(ll_i, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
			NEXT
		END IF
		dw_skid_list.SetItem(ll_skid_row, "sheet_skid_sheet_net_wt", ll_count)
	END IF
	wf_display_gross_wt(ll_skid_row)
END IF

//theo wt
IF ls_ColName = "production_sheet_item_prod_item_theoreti" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_skid_num = this.GetItemNumber(ll_row,"sheet_skid_detail_sheet_skid_num")
	ll_skid_row = dw_skid_list.GetRow()
	IF ll_skid_num = dw_skid_list.GetItemNumber(ll_skid_row, "sheet_skid_sheet_skid_num") THEN
		li_totalrow = this.RowCount()
		ll_count = 0
		IF li_totalrow > 0 THEN
			FOR ll_i = 1 TO li_totalrow
				ll_count = ll_count + this.GetItemNumber(ll_i, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
			NEXT
		END IF
		dw_skid_list.SetItem(ll_skid_row, "sheet_skid_sheet_theoretical_wt", ll_count)
	END IF
END IF

end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type gb_search from u_gb within w_inv_recap
integer x = 832
integer width = 2505
integer height = 184
integer taborder = 0
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "Search"
borderstyle borderstyle = styleraised!
end type

type cb_sort from u_cb within w_inv_recap
event clicked pbm_bnclicked
string tag = "sort"
integer x = 2958
integer y = 892
integer height = 80
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ort"
end type

event clicked;call super::clicked;Parent.Event ue_sort()
end event

type ddlb_customer from dropdownlistbox within w_inv_recap
integer x = 32
integer y = 80
integer width = 791
integer height = 1292
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_text
Long ll_row, ll_i

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		dw_skid_list.Event ue_resume_where()
		wf_display_total_info()
	END IF
NEXT

end event

type st_1 from statictext within w_inv_recap
integer x = 27
integer y = 16
integer width = 425
integer height = 60
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
string text = "Current customer:"
boolean focusrectangle = false
end type

type cb_summary from u_cb within w_inv_recap
integer x = 2958
integer y = 1196
integer width = 357
integer height = 80
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&um by Job"
end type

event clicked;openwithparm(w_inv_recap_summary, dw_skid_list)
end event

type cb_prod from u_cb within w_inv_recap
integer x = 2958
integer y = 572
integer height = 80
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Open Prod"
end type

event constructor;CHOOSE CASE f_security_door("Production Control")
	CASE 0 //Readonly
		this.Enabled = TRUE
	CASE 1 //Write
		this.Enabled = TRUE
	CASE ELSE
		this.Enabled = FALSE
END CHOOSE

end event

event clicked;Long ll_row

ll_row = dw_skid_list.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select an order first!", StopSign! )
	RETURN
END IF

gl_message = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_ab_job_num" )


SetPointer(HourGlass!)
Message.StringParm = "w_production" 
gnv_app.of_getFrame().Event pfc_open()

end event

type cb_search from u_cb within w_inv_recap
integer x = 3099
integer y = 44
integer width = 224
integer height = 64
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Search"
end type

event clicked;OpenWithParm(w_buildfilter, dw_skid_list.DataObject)
Return 1
end event

type cb_reset from u_cb within w_inv_recap
integer x = 3099
integer y = 112
integer width = 224
integer height = 64
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;dw_skid_list.Event ue_resume_where()
end event

type st_cond from statictext within w_inv_recap
integer x = 855
integer y = 44
integer width = 2203
integer height = 120
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
string text = "All"
boolean focusrectangle = false
end type

type st_2 from statictext within w_inv_recap
integer x = 27
integer y = 1852
integer width = 544
integer height = 60
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
string text = "Color indication for skids:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_inv_recap
integer x = 581
integer y = 1856
integer width = 160
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 1090519039
long backcolor = 79741120
boolean enabled = false
string text = "Done"
boolean focusrectangle = false
end type

type st_4 from statictext within w_inv_recap
integer x = 745
integer y = 1856
integer width = 224
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_5 from statictext within w_inv_recap
integer x = 1006
integer y = 1856
integer width = 160
integer height = 56
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
string text = "New"
boolean focusrectangle = false
end type

type st_6 from statictext within w_inv_recap
integer x = 1175
integer y = 1856
integer width = 206
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Rejected"
boolean focusrectangle = false
end type

type st_7 from statictext within w_inv_recap
integer x = 1417
integer y = 1856
integer width = 206
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OhHold"
boolean focusrectangle = false
end type

type st_8 from statictext within w_inv_recap
integer x = 1655
integer y = 1856
integer width = 229
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 79741120
boolean enabled = false
string text = "PreReCap"
boolean focusrectangle = false
end type

type st_9 from statictext within w_inv_recap
integer x = 1934
integer y = 1856
integer width = 206
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 79741120
boolean enabled = false
string text = "Partial"
boolean focusrectangle = false
end type

type cb_p_ready from u_cb within w_inv_recap
integer x = 2958
integer y = 268
integer width = 366
integer height = 80
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Set R&eady"
end type

event clicked;call super::clicked;Long ll_row

ll_row = dw_skid_list.GetRow()
IF ll_row < 1 THEN Return 0

//Modified by Victor Huang in 08/05
//Check if the skid has been assigned to a new job. If "Yes", force user to remove the skid from the new job.
Long ll_skid, ll_orig_ab_job
ll_skid = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)

SetNull(ll_orig_ab_job)
select ab_job_num into :ll_orig_ab_job
from process_partial_skid
where sheet_skid_num = :ll_skid
using SQLCA;

IF not isnull(ll_orig_ab_job) THEN 
	MessageBox("Warning","This skid has been assigned to a new job#" + String(ll_orig_ab_job) +". Please remove it from the new job before any modification!", StopSign!)
	RETURN -1
END IF

dw_skid_list.SetItem(ll_row, "Sheet_skid_skid_sheet_status", 2 ) //ready to ship

Return ll_row
end event

