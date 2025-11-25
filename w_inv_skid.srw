$PBExportHeader$w_inv_skid.srw
$PBExportComments$<Sheet> List all skids and all information about each skid, inherited from pfemain\w_sheet
forward
global type w_inv_skid from w_sheet
end type
type rb_all from u_rb within w_inv_skid
end type
type rb_default from u_rb within w_inv_skid
end type
type dw_skid_history from u_dw within w_inv_skid
end type
type cb_report from u_cb within w_inv_skid
end type
type dw_customer from u_dw within w_inv_skid
end type
type cb_prerecap from u_cb within w_inv_skid
end type
type cb_close from u_cb within w_inv_skid
end type
type cb_sort from u_cb within w_inv_skid
end type
type st_1 from statictext within w_inv_skid
end type
type ddlb_customer from dropdownlistbox within w_inv_skid
end type
type cb_search from commandbutton within w_inv_skid
end type
type cb_reset from commandbutton within w_inv_skid
end type
type st_cond from statictext within w_inv_skid
end type
type gb_search from u_gb within w_inv_skid
end type
type st_2 from statictext within w_inv_skid
end type
type st_3 from statictext within w_inv_skid
end type
type st_4 from statictext within w_inv_skid
end type
type st_5 from statictext within w_inv_skid
end type
type st_6 from statictext within w_inv_skid
end type
type st_7 from statictext within w_inv_skid
end type
type st_8 from statictext within w_inv_skid
end type
type st_9 from statictext within w_inv_skid
end type
type cb_reference from u_cb within w_inv_skid
end type
type cb_po from u_cb within w_inv_skid
end type
type dw_skid_list from u_dw within w_inv_skid
end type
type st_10 from statictext within w_inv_skid
end type
type gb_2 from u_gb within w_inv_skid
end type
type order_str from structure within w_inv_skid
end type
end forward

type order_str from structure
	long		order_no
	integer		item
end type

global type w_inv_skid from w_sheet
string tag = "Customer Skids"
integer x = 4
integer y = 3
integer width = 3632
integer height = 2106
string title = "Skid Inventory"
string menuname = "m_skid_main"
boolean maxbox = false
boolean resizable = false
event ue_search ( )
event ue_sort ( )
event type string ue_whoami ( )
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
event type string ue_cur_retrieve ( )
event type integer ue_refer ( )
rb_all rb_all
rb_default rb_default
dw_skid_history dw_skid_history
cb_report cb_report
dw_customer dw_customer
cb_prerecap cb_prerecap
cb_close cb_close
cb_sort cb_sort
st_1 st_1
ddlb_customer ddlb_customer
cb_search cb_search
cb_reset cb_reset
st_cond st_cond
gb_search gb_search
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
cb_reference cb_reference
cb_po cb_po
dw_skid_list dw_skid_list
st_10 st_10
gb_2 gb_2
end type
global w_inv_skid w_inv_skid

type variables
integer ii_dw_flag
datastore ids_datastore
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
String is_condition
Long il_customer_id
Int ii_showall
Long il_index
end variables

forward prototypes
public function string wf_search_terms ()
public function string wf_display_total_terms ()
public function integer wf_display_total_info ()
public subroutine wf_init_dwdb ()
public subroutine wf_reset_condition ()
end prototypes

event ue_search;call super::ue_search;dw_skid_list.Event ue_search_retrieve()
end event

event ue_sort;call super::ue_sort;String ls_null

SetNULL(ls_null)
dw_skid_list.inv_sort.of_SetSort(ls_null)
dw_skid_list.inv_sort.of_Sort()
end event

event ue_whoami;RETURN "w_inv_skid"
end event

event ue_read_only;dw_skid_list.Object.DataWindow.ReadOnly = "YES"
cb_prerecap.Enabled = FALSE
cb_po.Enabled = FALSE

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
					CASE "WH-READY"
						istr_search[li_s].value = "8"
					CASE "TAREONLY"
						istr_search[li_s].value = "6"
					CASE "WH-SORT"
						istr_search[li_s].value = "10"
					CASE "WH-COMING"
						istr_search[li_s].value = "9"
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

event ue_cur_retrieve;String ls_mod
ls_mod ="DataWindow.Table.Select = '" + is_select + is_condition + " '"
RETURN ls_mod

end event

event ue_refer;SetPointer(HourGlass!)

Long ll_row, ll_skid

ll_row = dw_skid_list.GetRow()
IF ll_row < 1 THEN RETURN -1
ll_skid = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
IF ll_skid > 0 THEN
	OpenWithParm(w_skid_detail_info, ll_skid)
END IF

RETURN 1
end event

public function string wf_search_terms ();String ls_terms
integer li_i

if ii_showall =1  then
	ls_terms =   " WHERE ( ~"SHEET_SKID~".~"SHEET_SKID_NUM~" = ~"PROCESS_PARTIAL_SKID~".~"SHEET_SKID_NUM~" (+)) AND ( ~"AB_JOB~".~"ORDER_ABC_NUM~" = ~"CUSTOMER_ORDER~".~"ORDER_ABC_NUM~" ) and          ( ~"SHEET_SKID~".~"AB_JOB_NUM~" = ~"AB_JOB~".~"AB_JOB_NUM~" ) and          ( ( ~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" = :customer_id ) and          ( ~"SHEET_SKID~".~"SKID_SHEET_STATUS~" <> 6 )  )"
else
	ls_terms =   " WHERE ( ~"SHEET_SKID~".~"SHEET_SKID_NUM~" = ~"PROCESS_PARTIAL_SKID~".~"SHEET_SKID_NUM~" (+)) AND ( ~"AB_JOB~".~"ORDER_ABC_NUM~" = ~"CUSTOMER_ORDER~".~"ORDER_ABC_NUM~" ) and          ( ~"SHEET_SKID~".~"AB_JOB_NUM~" = ~"AB_JOB~".~"AB_JOB_NUM~" ) and          ( ( ~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" = :customer_id ) and          ( ~"SHEET_SKID~".~"SKID_SHEET_STATUS~"  not in (0, 6) )  )"
end if

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

public function string wf_display_total_terms ();String ls_terms
String ls_date, ls_op
integer li_rc
Long ll_row, ll_cust
Int li_i

SetNULL(ls_terms)
ll_row = dw_customer.GetRow()

IF ll_row <= 0 THEN RETURN ls_terms
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")

ll_cust = il_customer_id

if ii_showall = 1 then
	ls_terms =   " WHERE ( AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM ) AND ( SHEET_SKID.AB_JOB_NUM = AB_JOB.AB_JOB_NUM) AND ( ( CUSTOMER_ORDER.ORIG_CUSTOMER_ID = " + String(ll_cust)  +" ) AND (SHEET_SKID.SKID_SHEET_STATUS <> 6 )  ) "
else
	ls_terms =   " WHERE ( AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM ) AND ( SHEET_SKID.AB_JOB_NUM = AB_JOB.AB_JOB_NUM) AND ( ( CUSTOMER_ORDER.ORIG_CUSTOMER_ID = " + String(ll_cust)  +" ) AND (SHEET_SKID.SKID_SHEET_STATUS not in (0, 6) )  ) "
end if

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

public subroutine wf_init_dwdb ();istr_dwdb[1].db_name = "SHEET_SKID"
istr_dwdb[1].db_field = "SHEET_SKID_DISPLAY_NUM"
istr_dwdb[1].dw_column = "sheet_skid_sheet_skid_display_num"
istr_dwdb[1].col_type = "string"
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
istr_dwdb[7].db_field = "SKID_EDI856_DATE"
istr_dwdb[7].dw_column = "sheet_skid_skid_edi856_date"
istr_dwdb[7].col_type = "date"
istr_dwdb[7].dw_header = "Edi856 Date"

istr_dwdb[8].db_name = "SHEET_SKID"
istr_dwdb[8].db_field = "SKID_LOCATION"
istr_dwdb[8].dw_column = "sheet_skid_skid_location"
istr_dwdb[8].col_type = "string"
istr_dwdb[8].dw_header = "Location"

istr_dwdb[9].db_name = "SHEET_SKID"
istr_dwdb[9].db_field = "SKID_DATE"
istr_dwdb[9].dw_column = "sheet_skid_skid_date"
istr_dwdb[9].col_type = "date"
istr_dwdb[9].dw_header = "Created Date"

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

on w_inv_skid.create
int iCurrent
call super::create
if this.MenuName = "m_skid_main" then this.MenuID = create m_skid_main
this.rb_all=create rb_all
this.rb_default=create rb_default
this.dw_skid_history=create dw_skid_history
this.cb_report=create cb_report
this.dw_customer=create dw_customer
this.cb_prerecap=create cb_prerecap
this.cb_close=create cb_close
this.cb_sort=create cb_sort
this.st_1=create st_1
this.ddlb_customer=create ddlb_customer
this.cb_search=create cb_search
this.cb_reset=create cb_reset
this.st_cond=create st_cond
this.gb_search=create gb_search
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.cb_reference=create cb_reference
this.cb_po=create cb_po
this.dw_skid_list=create dw_skid_list
this.st_10=create st_10
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_all
this.Control[iCurrent+2]=this.rb_default
this.Control[iCurrent+3]=this.dw_skid_history
this.Control[iCurrent+4]=this.cb_report
this.Control[iCurrent+5]=this.dw_customer
this.Control[iCurrent+6]=this.cb_prerecap
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_sort
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.ddlb_customer
this.Control[iCurrent+11]=this.cb_search
this.Control[iCurrent+12]=this.cb_reset
this.Control[iCurrent+13]=this.st_cond
this.Control[iCurrent+14]=this.gb_search
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.st_5
this.Control[iCurrent+19]=this.st_6
this.Control[iCurrent+20]=this.st_7
this.Control[iCurrent+21]=this.st_8
this.Control[iCurrent+22]=this.st_9
this.Control[iCurrent+23]=this.cb_reference
this.Control[iCurrent+24]=this.cb_po
this.Control[iCurrent+25]=this.dw_skid_list
this.Control[iCurrent+26]=this.st_10
this.Control[iCurrent+27]=this.gb_2
end on

on w_inv_skid.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_all)
destroy(this.rb_default)
destroy(this.dw_skid_history)
destroy(this.cb_report)
destroy(this.dw_customer)
destroy(this.cb_prerecap)
destroy(this.cb_close)
destroy(this.cb_sort)
destroy(this.st_1)
destroy(this.ddlb_customer)
destroy(this.cb_search)
destroy(this.cb_reset)
destroy(this.st_cond)
destroy(this.gb_search)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.cb_reference)
destroy(this.cb_po)
destroy(this.dw_skid_list)
destroy(this.st_10)
destroy(this.gb_2)
end on

event open;call super::open;dw_customer.Visible = FALSE

ii_showall = 0		//show dault : all skid but gone
rb_default.checked = true
rb_all.checked = false

dw_customer.of_SetLinkage(TRUE)

dw_skid_list.of_SetLinkage( TRUE ) 
dw_skid_list.inv_Linkage.of_SetMaster(dw_customer)
IF NOT dw_skid_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & skid in win w_inv_skid!" )
ELSE
	dw_skid_list.inv_Linkage.of_Register( "customer_id", "customer_order_orig_customer_id" ) 
	dw_skid_list.inv_Linkage.of_SetStyle( 2 ) 
END IF




dw_skid_history.of_SetLinkage(true)
dw_skid_history.inv_Linkage.of_SetMaster(dw_skid_list)
IF NOT dw_skid_history.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link skid & skid_history in win w_inv_skid!" )
ELSE
	dw_skid_history.inv_Linkage.of_Register( "sheet_skid_sheet_skid_num", "sheet_skid_num"  ) 
	dw_skid_history.inv_Linkage.of_SetStyle( dw_skid_history.inv_linkage.RETRIEVE ) 
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
is_select =  "SELECT  ~"SHEET_SKID~".~"SHEET_SKID_NUM~" ,           ~"SHEET_SKID~".~"AB_JOB_NUM~" ,           ~"SHEET_SKID~".~"SHEET_NET_WT~" ,           ~"SHEET_SKID~".~"SHEET_TARE_WT~" ,           ~"SHEET_SKID~".~"SKID_PIECES~" ,           ~"SHEET_SKID~".~"SKID_SHEET_STATUS~" ,           ~"SHEET_SKID~".~"SKID_EDI856_DATE~" ,           ~"SHEET_SKID~".~"SKID_LOCATION~" ,           ~"SHEET_SKID~".~"SKID_DATE~" ,    ~"SHEET_SKID~".~"REF_ORDER_ABC_NUM~",  ~"SHEET_SKID~".~"SHEET_SKID_DISPLAY_NUM~",          ~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" ,  ~"PROCESS_PARTIAL_SKID~".~"SHEET_SKID_NUM~" ,f_get_skid_duration(sheet_skid.sheet_skid_num)    FROM ~"AB_JOB~" ,           ~"CUSTOMER_ORDER~" ,           ~"SHEET_SKID~",  ~"PROCESS_PARTIAL_SKID~"   " 

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

event pfc_save;call super::pfc_save;ii_dw_flag = 0
Return 1
end event

event pfc_print;//long ll_row_cut
//Long ll_cust_id

//ll_row_cut = dw_customer.GetRow()
//ll_cust_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, TRUE)

//OpenWithParm(w_report_inv_skid, ll_cust_id )

OpenWithParm(w_report_inv_skid, dw_skid_list)
Return 1
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Inventory(Skid)") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type rb_all from u_rb within w_inv_skid
integer x = 1031
integer y = 138
integer width = 230
integer height = 64
string text = "All"
end type

event clicked;call super::clicked;if This.Checked then
	ii_showall =1
	ddlb_customer.SelectItem(il_index)
	ddlb_customer.Event SelectionChanged(il_index)
end if

end event

type rb_default from u_rb within w_inv_skid
integer x = 1031
integer y = 61
integer width = 274
integer height = 64
string text = "Default"
end type

event clicked;call super::clicked;if This.Checked then
	ii_showall =0
	ddlb_customer.SelectItem(il_index)
	ddlb_customer.Event SelectionChanged(il_index)
end if

end event

type dw_skid_history from u_dw within w_inv_skid
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
integer x = 33
integer y = 1565
integer width = 3566
integer height = 269
integer taborder = 10
string dataobject = "d_skid_history"
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
is_condition = ls_where

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
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
ls_where = "   WHERE ( ~"SHEET_SKID~".~"SHEET_SKID_NUM~" = ~"PROCESS_PARTIAL_SKID~".~"SHEET_SKID_NUM~" (+)) AND ( ~"AB_JOB~".~"ORDER_ABC_NUM~" = ~"CUSTOMER_ORDER~".~"ORDER_ABC_NUM~" ) and          ( ~"SHEET_SKID~".~"AB_JOB_NUM~" = ~"AB_JOB~".~"AB_JOB_NUM~" ) and          ( ( ~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" = :customer_id ) and          ( ~"SHEET_SKID~".~"SKID_SHEET_STATUS~" <> 6 ) ) "
is_condition = ls_where
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

event itemchanged;call super::itemchanged;ii_dw_flag = 1
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

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event clicked;//Override pfc's clicked because it is running on wrong sequence

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	//Return
	this.Event GetFocus()
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

type cb_report from u_cb within w_inv_skid
integer x = 2253
integer y = 1840
integer width = 369
integer height = 77
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reports"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type dw_customer from u_dw within w_inv_skid
integer x = 666
integer width = 132
integer height = 35
integer taborder = 20
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
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

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()

end event

type cb_prerecap from u_cb within w_inv_skid
string tag = "set a skid to prerecap status so you can change it"
integer x = 325
integer y = 1840
integer width = 369
integer height = 77
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Set &PreRecap"
end type

event clicked;Long ll_row, ll_skid

ll_row = dw_skid_list.GetRow()
IF ll_row > 0 THEN
	ll_skid = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
	
	//Modified by Victor Huang in 08/05
	//Check if the skid has been assigned to a new job. If "yes", force user to remove the skid from the new job.
	Long ll_orig_ab_job
	
	SetNull(ll_orig_ab_job)
	select ab_job_num into :ll_orig_ab_job
	from process_partial_skid
	where sheet_skid_num = :ll_skid
	using SQLCA;

	IF not isnull(ll_orig_ab_job) THEN 
		MessageBox("Warning","This skid has been assigned to a new job#" + String(ll_orig_ab_job) +". Please remove it from the new job before any modification!", StopSign!)
		RETURN -2
	END IF
	//End	
	
	IF ll_skid > 0 THEN
		IF MessageBox("Question","Set skid #" + String(ll_skid) + " into prerecap status so you can modify it in Recap application?", Question!, OKCancel!, 2) = 1 THEN
			IF dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE) = 0 THEN
				MessageBox("Info", "This skid had been shipped to customer already, no change can be made on it anymore.")
				RETURN -1
			END IF
			CONNECT USING SQLCA;
			UPDATE sheet_skid
			SET skid_sheet_status = 5
			WHERE sheet_skid_num = :ll_skid
			USING SQLCA;
			COMMIT USING SQLCA;
			dw_skid_list.SetItem(ll_row, "sheet_skid_skid_sheet_status", 5)
			dw_skid_list.ResetUpdate()
		END IF
	END  IF
END IF
RETURN 1

			



			



			


end event

type cb_close from u_cb within w_inv_skid
string tag = "Exit"
integer x = 2739
integer y = 1840
integer width = 369
integer height = 77
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_sort from u_cb within w_inv_skid
event clicked pbm_bnclicked
integer x = 1284
integer y = 1840
integer width = 369
integer height = 77
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ort"
end type

event clicked;call super::clicked;Parent.Event ue_sort()
end event

type st_1 from statictext within w_inv_skid
integer x = 33
integer y = 19
integer width = 560
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Current Customer:"
boolean focusrectangle = false
end type

type ddlb_customer from dropdownlistbox within w_inv_skid
integer x = 33
integer y = 96
integer width = 933
integer height = 1203
integer taborder = 30
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
Long ll_row, ll_i, ll_item

il_index = index
ls_text = Text(index)
//MessageBox("ls_text", ls_text)
ll_row = dw_customer.RowCount()
//MessageBox("ll_row", ll_row)
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		//MessageBox("got it", "dddd")
		//dw_customer.Event RowFocusChanged(ll_i)
		//dw_customer.SelectRow(0, False)
		//dw_customer.SelectRow(ll_i, True)
		//temp = dw_customer.GetRow()
		//MessageBox("currenRow", temp)
		il_customer_id = dw_customer.GetItemNumber(ll_i, "customer_id")
		//MessageBox("selectedID", dw_customer.GetItemNumber(ll_i, "customer_id"))
		dw_skid_list.Event ue_resume_where()
		
		//wf_display_total_info()
		ll_item = dw_skid_list.RowCount()
		IF ll_item = 0 THEN
			dw_skid_list.Object.item_t.Text = ""
		ELSEIF ll_item < 2 THEN
			dw_skid_list.Object.item_t.Text = String(ll_item, "#,###,###")
			dw_skid_list.Object.skid_t.Text = "skid"
		ELSE
			dw_skid_list.Object.item_t.Text = String(ll_item, "#,###,###")
			dw_skid_list.Object.skid_t.Text = "skids"
		END IF
		
		
	END IF
NEXT

end event

type cb_search from commandbutton within w_inv_skid
integer x = 3324
integer y = 45
integer width = 252
integer height = 74
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Search"
end type

event clicked;OpenWithParm(w_buildfilter, dw_skid_list.DataObject)
Return 1
end event

type cb_reset from commandbutton within w_inv_skid
integer x = 3324
integer y = 125
integer width = 252
integer height = 74
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset"
end type

event clicked;dw_skid_list.Event ue_resume_where()
end event

type st_cond from statictext within w_inv_skid
integer x = 1536
integer y = 51
integer width = 1741
integer height = 154
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

type gb_search from u_gb within w_inv_skid
integer x = 1503
integer y = 3
integer width = 2096
integer height = 211
integer taborder = 0
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "Search"
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_inv_skid
integer x = 1064
integer y = 1491
integer width = 380
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_inv_skid
integer x = 1426
integer y = 1491
integer width = 187
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
boolean focusrectangle = false
end type

type st_4 from statictext within w_inv_skid
integer x = 1624
integer y = 1491
integer width = 260
integer height = 51
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

type st_5 from statictext within w_inv_skid
integer x = 1887
integer y = 1491
integer width = 197
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
string text = "Ready"
boolean focusrectangle = false
end type

type st_6 from statictext within w_inv_skid
integer x = 2088
integer y = 1491
integer width = 241
integer height = 51
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
string text = "Canceled"
boolean focusrectangle = false
end type

type st_7 from statictext within w_inv_skid
integer x = 2337
integer y = 1491
integer width = 241
integer height = 51
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
string text = "OnHold"
boolean focusrectangle = false
end type

type st_8 from statictext within w_inv_skid
integer x = 2564
integer y = 1501
integer width = 241
integer height = 48
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

type st_9 from statictext within w_inv_skid
integer x = 2831
integer y = 1491
integer width = 241
integer height = 51
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

type cb_reference from u_cb within w_inv_skid
integer x = 1770
integer y = 1840
integer width = 369
integer height = 77
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "R&efer.."
end type

event clicked;RETURN Parent.Event ue_refer()
end event

type cb_po from u_cb within w_inv_skid
string tag = "set a skid to new customer po"
integer x = 805
integer y = 1840
integer width = 369
integer height = 77
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Set &Order"
end type

event clicked;Long ll_row, ll_skid, ll_neworder, ll_order
int ll_neworder_item
String neworder_str, temp_str
ll_row = dw_skid_list.GetRow()
IF ll_row > 0 THEN
	ll_skid = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
	IF ll_skid > 0 THEN
		IF MessageBox("Question","Set skid #" + String(ll_skid) + " under different reference P.O.?", Question!, OKCancel!, 2) = 1 THEN
			IF dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE) = 0 THEN
				MessageBox("Info", "This skid had been shipped to customer already, no change can be made on it anymore.")
				RETURN -1
			END IF
			ll_order = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_ref_order_abc_num")
			OpenWithParm(w_inv_skid_neworder, ll_order)
			//ll_neworder = Message.DoubleParm
			
			neworder_str = Message.StringParm
			neworder_str = LeftTrim(RightTrim(neworder_str))
			temp_str = Mid(neworder_str, Pos(neworder_str, "+++") + 3)
			neworder_str = Mid(neworder_str, 1, Pos(neworder_str, "+++")-1)
			
			ll_neworder = Long(neworder_str)
			ll_neworder_item = Integer(temp_str)
			//Messagebox(
			
			IF ll_neworder > 0 THEN
				CONNECT USING SQLCA;
				UPDATE sheet_skid
				SET ref_order_abc_num = :ll_neworder, ref_order_abc_item = :ll_neworder_item
				WHERE sheet_skid_num = :ll_skid
				USING SQLCA;
				COMMIT USING SQLCA;
				dw_skid_list.SetItem(ll_row, "sheet_skid_ref_order_abc_num", ll_neworder)
				dw_skid_list.ResetUpdate()
			END IF
		END IF
	END  IF
END IF
RETURN 1


end event

type dw_skid_list from u_dw within w_inv_skid
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
integer x = 33
integer y = 240
integer width = 3580
integer height = 1245
integer taborder = 11
string dataobject = "d_skid_list_per_cust"
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
is_condition = ls_where

//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")

ll_cust = il_customer_id

ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"


ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

Return 1
end event

event ue_resume_where();String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ll_cust = il_customer_id
//MessageBox("cust",ll_cust)

if ii_showall =1  then
	ls_where = "   WHERE ( ~"SHEET_SKID~".~"SHEET_SKID_NUM~" = ~"PROCESS_PARTIAL_SKID~".~"SHEET_SKID_NUM~" (+)) AND ( ~"AB_JOB~".~"ORDER_ABC_NUM~" = ~"CUSTOMER_ORDER~".~"ORDER_ABC_NUM~" ) and          ( ~"SHEET_SKID~".~"AB_JOB_NUM~" = ~"AB_JOB~".~"AB_JOB_NUM~" ) and          ( ( ~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" = :customer_id ) and          ( ~"SHEET_SKID~".~"SKID_SHEET_STATUS~" <> 6 )  ) "
else
	ls_where = "   WHERE ( ~"SHEET_SKID~".~"SHEET_SKID_NUM~" = ~"PROCESS_PARTIAL_SKID~".~"SHEET_SKID_NUM~" (+)) AND ( ~"AB_JOB~".~"ORDER_ABC_NUM~" = ~"CUSTOMER_ORDER~".~"ORDER_ABC_NUM~" ) and          ( ~"SHEET_SKID~".~"AB_JOB_NUM~" = ~"AB_JOB~".~"AB_JOB_NUM~" ) and          ( ( ~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" = :customer_id ) and          ( ~"SHEET_SKID~".~"SKID_SHEET_STATUS~" not in(0, 6) )  ) "
end if
	
is_condition = ls_where
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	//MessageBox("where",ls_where)
	
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

end event

event clicked;//Override pfc's clicked because it is running on wrong sequence

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	//Return
	this.Event GetFocus()
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

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

event itemchanged;call super::itemchanged;ii_dw_flag = 1
end event

event rbuttondown;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
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

Return 

end event

type st_10 from statictext within w_inv_skid
integer x = 51
integer y = 1491
integer width = 424
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "Skid History:"
boolean focusrectangle = false
end type

type gb_2 from u_gb within w_inv_skid
integer x = 1002
integer y = 3
integer width = 443
integer height = 218
integer taborder = 21
integer weight = 700
string facename = "Arial"
string text = "Skid Showing"
end type

