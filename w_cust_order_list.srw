$PBExportHeader$w_cust_order_list.srw
$PBExportComments$<Sheet> list all customer orders inherited from pfemain/w_sheet
forward
global type w_cust_order_list from w_sheet
end type
type dw_order_list from u_dw within w_cust_order_list
end type
type cb_report from u_cb within w_cust_order_list
end type
type cb_close from u_cb within w_cust_order_list
end type
type cb_open from u_cb within w_cust_order_list
end type
type gb_1 from groupbox within w_cust_order_list
end type
type cb_new from u_cb within w_cust_order_list
end type
type st_cond from statictext within w_cust_order_list
end type
type cb_search from u_cb within w_cust_order_list
end type
type cb_reset from u_cb within w_cust_order_list
end type
type st_1 from statictext within w_cust_order_list
end type
type st_2 from statictext within w_cust_order_list
end type
type st_3 from statictext within w_cust_order_list
end type
type st_4 from statictext within w_cust_order_list
end type
type st_5 from statictext within w_cust_order_list
end type
type st_6 from statictext within w_cust_order_list
end type
type dw_report from u_dw within w_cust_order_list
end type
type cb_end_user_change from u_cb within w_cust_order_list
end type
type cb_showall from u_cb within w_cust_order_list
end type
end forward

global type w_cust_order_list from w_sheet
integer x = 4
integer y = 3
integer width = 3529
integer height = 2173
string title = "ABCO customer order management"
string menuname = "m_cust_order_list"
boolean maxbox = false
boolean resizable = false
event ue_openorder ( )
event type string ue_whoami ( )
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
event type integer ue_neworder ( )
event ue_end_user_change ( )
dw_order_list dw_order_list
cb_report cb_report
cb_close cb_close
cb_open cb_open
gb_1 gb_1
cb_new cb_new
st_cond st_cond
cb_search cb_search
cb_reset cb_reset
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
dw_report dw_report
cb_end_user_change cb_end_user_change
cb_showall cb_showall
end type
global w_cust_order_list w_cust_order_list

type variables
Long il_old_job
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_allcust
s_search_condition istr_or[]
Long il_custid
Int ii_showall
end variables

forward prototypes
public function string wf_search_terms ()
public function string wf_display_total_terms ()
public function integer wf_display_total_info ()
public subroutine wf_init_dwdb ()
public subroutine wf_reset_condition ()
public function long wf_get_userid (string as_name)
public subroutine wf_set_partsize (datawindow adw_d)
public function integer wf_retrieve ()
end prototypes

event ue_openorder();SetPointer(HourGlass!)

Int li_rc
Long ll_row

ll_row = dw_order_list.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select an order first!", StopSign! )
	RETURN
END IF

gl_message = dw_order_list.GetItemNumber(ll_row, "order_abc_num" )

//Close(this) //Alex Gerlants. 05/20/2016

SetPointer(HourGlass!)
Message.StringParm = "w_order_entry" 
gnv_app.of_getFrame().Event pfc_open()

end event

event ue_whoami;RETURN "w_cust_order_list"
end event

event ue_read_only;cb_new.Enabled = FALSE
cb_end_user_change.Enabled = FALSE
m_cust_order_list.m_file.m_new.Disable()

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
			CHOOSE CASE adw_d.getItemString(ll_l, "column_t", Primary!, FALSE) 
				CASE "Customer"
					IF adw_d.getItemString(ll_l, "value_t", Primary!, FALSE) = "ALL CUSTOMERS" THEN
						ib_allcust = TRUE
						il_custid = 0
					ELSE						
						istr_search[li_s].db_name = istr_dwdb[li_i].db_name
						istr_search[li_s].db_field = istr_dwdb[li_i].db_field
						istr_search[li_s].col_type = istr_dwdb[li_i].col_type
						istr_search[li_s].operator = adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
						istr_search[li_s].value = adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
						il_custid = wf_get_userid(istr_search[li_s].value)
						istr_search[li_s].value = String(il_custid)
						ib_allcust = FALSE
						li_s++
					END IF
				CASE "EndUser"
						istr_search[li_s].db_name = istr_dwdb[li_i].db_name
						istr_search[li_s].db_field = istr_dwdb[li_i].db_field
						istr_search[li_s].col_type = istr_dwdb[li_i].col_type
						istr_search[li_s].operator = adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
						istr_search[li_s].value = adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
						il_custid = wf_get_userid(istr_search[li_s].value)
						istr_search[li_s].value = String(il_custid)
						li_s++
				CASE ELSE
					istr_search[li_s].db_name = istr_dwdb[li_i].db_name
					istr_search[li_s].db_field = istr_dwdb[li_i].db_field
					istr_search[li_s].col_type = istr_dwdb[li_i].col_type
					istr_search[li_s].operator = adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
					istr_search[li_s].value = adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)

					IF istr_search[li_s].col_type = "status" THEN
							CHOOSE CASE Upper(Trim(istr_search[li_s].value))
							CASE "DONE"
								istr_search[li_s].value = "0"
							CASE "INPROCESS"
								istr_search[li_s].value = "1"					
							CASE "NEW"
								istr_search[li_s].value = "2"					
							CASE "CANCELED"
								istr_search[li_s].value = "3"					
							CASE "ONHOLD"
								istr_search[li_s].value = "4"					
							CASE ELSE
								istr_search[li_s].value = "9999"
						END CHOOSE
					END IF
					
					li_s++
					
			END CHOOSE
		END IF
	li_i++
	LOOP
NEXT

wf_set_partsize(adw_d)

dw_order_list.Event ue_search_retrieve()



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

event ue_neworder;SetPointer(HourGlass!)
IF f_security_door("Order Entry") = 1 THEN 
	this.Event pfc_new()
ELSE
	MessageBox("Info", "You do not have privilege to create a new customer order")
END IF

RETURN 1
end event

event ue_end_user_change;SetPointer(HourGlass!)

Int li_rc
Long ll_row
s_order_data ls_order_data

ll_row = dw_order_list.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select an order first!", StopSign! )
	RETURN 
END IF

ls_order_data.order_num = dw_order_list.GetItemNumber(ll_row, "order_abc_num")
ls_order_data.customer_num = dw_order_list.GetItemNumber(ll_row, "enduser_id")

OpenWithParm(w_end_user_change,ls_order_data)

li_rc = Message.DoubleParm

IF li_rc =1 THEN
	This.Event open()
END IF






end event

public function string wf_search_terms ();String ls_terms
integer li_i
Boolean lb_or

ls_terms = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~"(+) )  "

li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "customer"
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

lb_or = FALSE
li_i = 1 
DO WHILE li_i <= UpperBound(istr_or)
	IF istr_or[li_i].db_name <> "" THEN
		CHOOSE CASE li_i 
			CASE 1
				//ls_terms = ls_terms + " AND ( ~"" + istr_or[li_i].db_name + "~".~"" + istr_or[li_i].db_field + "~" " + istr_or[li_i].operator + " " +istr_or[li_i].value + " )"
				ls_terms = ls_terms + " AND ( (~"" + istr_or[li_i].db_name + "~".~"" + istr_or[li_i].db_field + "~" " + istr_or[li_i].operator + " " +istr_or[li_i].value + " )"
				lb_or = TRUE
			CASE ELSE			
				ls_terms = ls_terms + " OR (~"" + istr_or[li_i].db_name + "~".~"" + istr_or[li_i].db_field + "~" " + istr_or[li_i].operator + " " +istr_or[li_i].value + " )" 
		END CHOOSE
	END IF
	li_i++
LOOP
IF lb_or THEN 
	ls_terms = ls_terms + "  ) ORDER BY ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" DESC "
ELSE
	ls_terms = ls_terms + " ORDER BY ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" DESC "
END IF

Return ls_terms
end function

public function string wf_display_total_terms ();String ls_terms
String ls_date, ls_op
integer li_rc
Long ll_row, ll_cust
Int li_i
Boolean lb_or

IF ib_allcust THEN
//	ls_terms = "   WHERE ( CUSTOMER_ORDER.ORDER_ABC_NUM = ORDER_ITEM.ORDER_ABC_NUM ) "
	ls_terms = " "
ELSE
//	ls_terms = "   WHERE ( CUSTOMER_ORDER.ORDER_ABC_NUM = ORDER_ITEM.ORDER_ABC_NUM ) and ( ( CUSTOMER_ORDER.ORIG_CUSTOMER_ID = " + String(ll_cust) + " ) ) "
	ls_terms = "  WHERE ( CUSTOMER_ORDER.ORIG_CUSTOMER_ID = " + String(il_custid) + " )"
END IF

li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].operator <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value + " )"
			CASE "customer"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value + " )"
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

lb_or = FALSE
li_i = 1 
DO WHILE li_i <= UpperBound(istr_or)
	IF istr_or[li_i].db_name <> "" THEN
		CHOOSE CASE li_i 
			CASE 1
				ls_terms = ls_terms + " AND ( (" + istr_or[li_i].db_name + "." + istr_or[li_i].db_field + " " + istr_or[li_i].operator + " " + istr_or[li_i].value + " )"
				lb_or = TRUE
			CASE ELSE			
				ls_terms = ls_terms + " OR (" + istr_or[li_i].db_name + "." + istr_or[li_i].db_field + " " + istr_or[li_i].operator + " " + istr_or[li_i].value + " )" 
		END CHOOSE
	END IF
	li_i++
LOOP
IF lb_or THEN ls_terms = ls_terms + " )"

Return ls_terms
end function

public function integer wf_display_total_info ();String ls_where, ls_select
Long ll_item


ls_where = wf_display_total_terms()
IF IsNULL(ls_where) THEN RETURN 0

//CONNECT USING SQLCA;
//
//ls_select = "SELECT COUNT(order_abc_num) FROM customer_order "
//
//DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
//String ls_Mysql
//ls_Mysql = ls_select + ls_where
//PREPARE SQLSA FROM :ls_Mysql;
//OPEN DYNAMIC my_cursor;
//FETCH my_cursor INTO :ll_item;
//CLOSE my_cursor ;
//
//IF IsNULL(ll_item) THEN ll_item = 0
//
//dw_order_list.Object.item_t.Text = String(ll_item, "#,###,###") 

RETURN 1

end function

public subroutine wf_init_dwdb ();istr_dwdb[1].db_name = "CUSTOMER_ORDER"
istr_dwdb[1].db_field = "ORDER_ABC_NUM"
istr_dwdb[1].dw_column = "order_abc_num"
istr_dwdb[1].col_type = "number"
istr_dwdb[1].dw_header = "Order No."

istr_dwdb[2].db_name = "CUSTOMER_ORDER"
istr_dwdb[2].db_field = "ENDUSER_ID"
istr_dwdb[2].dw_column = "enduser_id"
istr_dwdb[2].col_type = "customer"
istr_dwdb[2].dw_header = "EndUser"

istr_dwdb[3].db_name = "CUSTOMER_ORDER"
istr_dwdb[3].db_field = "ORIG_CUSTOMER_PO"
istr_dwdb[3].dw_column = "orig_customer_po"
istr_dwdb[3].col_type = "string"
istr_dwdb[3].dw_header = "Customer P.O."

istr_dwdb[4].db_name = "CUSTOMER_ORDER"
istr_dwdb[4].db_field = "ENDUSER_PO"
istr_dwdb[4].dw_column = "enduser_po"
istr_dwdb[4].col_type = "string"
istr_dwdb[4].dw_header = "Enduser P.O."

istr_dwdb[5].db_name = "CUSTOMER_ORDER"
istr_dwdb[5].db_field = "CREATED_DATE"
istr_dwdb[5].dw_column = "created_date"
istr_dwdb[5].col_type = "date"
istr_dwdb[5].dw_header = "Created"

istr_dwdb[6].db_name = "ORDER_ITEM"
istr_dwdb[6].db_field = "SHEET_TYPE"
istr_dwdb[6].dw_column = "order_item_sheet_type"
istr_dwdb[6].col_type = "string"
istr_dwdb[6].dw_header = "Shape"

istr_dwdb[7].db_name = "ORDER_ITEM"
istr_dwdb[7].db_field = "ALLOY2"
istr_dwdb[7].dw_column = "order_item_alloy2"
istr_dwdb[7].col_type = "string"
istr_dwdb[7].dw_header = "Alloy"

istr_dwdb[8].db_name = "ORDER_ITEM"
istr_dwdb[8].db_field = "TEMPER"
istr_dwdb[8].dw_column = "order_item_temper"
istr_dwdb[8].col_type = "string"
istr_dwdb[8].dw_header = "Temp"

istr_dwdb[9].db_name = "ORDER_ITEM"
istr_dwdb[9].db_field = "GAUGE"
istr_dwdb[9].dw_column = "order_item_gauge"
istr_dwdb[9].col_type = "number"
istr_dwdb[9].dw_header = "Gauge"

istr_dwdb[10].db_name = "ORDER_ITEM"
istr_dwdb[10].db_field = "ITEM_STATUS"
istr_dwdb[10].dw_column = "order_item_item_status"
istr_dwdb[10].col_type = "status"
istr_dwdb[10].dw_header = "Status"

istr_dwdb[11].db_name = "CUSTOMER_ORDER"
istr_dwdb[11].db_field = "ORIG_CUSTOMER_ID"
istr_dwdb[11].dw_column = "orig_customer_id"
istr_dwdb[11].col_type = "customer"
istr_dwdb[11].dw_header = "Customer"


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
li_i = 1
DO WHILE li_i <= Upperbound(istr_or)
	istr_or[li_i].db_name = ""
	istr_or[li_i].db_field = ""
	istr_or[li_i].operator = ""
	istr_or[li_i].value = ""
	istr_or[li_i].col_type = ""
	li_i++
LOOP

end subroutine

public function long wf_get_userid (string as_name);Long ll_id, ll_row, ll_i
DataStore lds_u

ll_id = 0

lds_u = CREATE DataStore
lds_u.DataObject = "d_dddw_id_short"
lds_u.SetTransObject(SQLCA)
lds_u.Retrieve()

ll_row = lds_u.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF Upper(Trim(lds_u.GetItemString(ll_i, "customer_short_name"))) = Upper(Trim(as_name)) THEN
			ll_id = lds_u.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
END IF

DESTROY lds_u

RETURN ll_id
end function

public subroutine wf_set_partsize (datawindow adw_d);Long ll_row, ll_l
String ls_s
Int li_i, li_s, ll_j
DataStore lds_d
String ls_select, ls_where, ls_modify, ls_rc

ll_row = adw_d.RowCount()
IF ll_row < 1 THEN RETURN

li_i = 1
DO WHILE li_i <= Upperbound(istr_or)
	istr_or[li_i].db_name = ""
	istr_or[li_i].db_field = ""
	istr_or[li_i].operator = ""
	istr_or[li_i].value = ""
	istr_or[li_i].col_type = ""
	li_i++
LOOP

lds_d = CREATE DataStore

FOR ll_l = 1 TO ll_row
	IF	adw_d.getItemString(ll_l, "column_t", Primary!, FALSE) = "Shape" THEN
		CHOOSE CASE adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
			CASE "Rectangle"
				lds_d.dataObject = "d_order_item_rectangle"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"RECTANGLE~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"RECTANGLE~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"RECTANGLE~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length" THEN
						ls_where = ls_where  + " AND (~~~"RECTANGLE~~~".~~~"RT_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Width" THEN
						ls_where = ls_where  + " AND (~~~"RECTANGLE~~~".~~~"RT_WIDTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			
		
				CASE "Reinforcement"
				lds_d.dataObject = "d_order_item_reinforcement"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"REINFORCEMENT~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"REINFORCEMENT~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"REINFORCEMENT~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length" THEN
						ls_where = ls_where  + " AND (~~~"REINFORCEMENT~~~".~~~"RE_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Width" THEN
						ls_where = ls_where  + " AND (~~~"REINFORCEMENT~~~".~~~"RE_WIDTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			CASE "Liftgate_shape"
				lds_d.dataObject = "d_order_item_liftgate_shape"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"LIFTGATE_SHAPE~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"LIFTGATE_SHAPE~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"LIFTGATE_SHAPE~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length" THEN
						ls_where = ls_where  + " AND (~~~"LIFTGATE_SHAPE~~~".~~~"LI_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Width" THEN
						ls_where = ls_where  + " AND (~~~"LIFTGATE_SHAPE~~~".~~~"LI_WIDTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			

			CASE "Parallelogram"
				lds_d.dataObject = "d_order_item_Parallelogram"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"PARALLELOGRAM~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"PARALLELOGRAM~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"PARALLELOGRAM~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length" THEN
						ls_where = ls_where  + " AND (~~~"PARALLELOGRAM~~~".~~~"P_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Width" THEN
						ls_where = ls_where  + " AND (~~~"PARALLELOGRAM~~~".~~~"P_WIDTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			CASE "Fender"
				lds_d.dataObject = "d_order_item_fender"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"FENDER~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"FENDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"FENDER~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Side" THEN
						ls_where = ls_where  + " AND (~~~"FENDER~~~".~~~"FE_SIDE~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			CASE "Circle"
				lds_d.dataObject = "d_order_item_circle"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"CIRCLE~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"CIRCLE~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"CIRCLE~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Diameter" THEN
						ls_where = ls_where  + " AND (~~~"CIRCLE~~~".~~~"C_DIAMETER~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			CASE "Chevron"
				lds_d.dataObject = "d_order_item_chevron"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"CHEVRON~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"CHEVRON~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"CHEVRON~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length" THEN
						ls_where = ls_where  + " AND (~~~"CHEVRON~~~".~~~"CH_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Width" THEN
						ls_where = ls_where  + " AND (~~~"CHEVRON~~~".~~~"CH_WIDTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			CASE "Trapezoid"
				lds_d.dataObject = "d_order_item_trapezoid"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"TRAPEZOID~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"TRAPEZOID~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"TRAPEZOID~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "L.Length" THEN
						ls_where = ls_where  + " AND (~~~"TRAPEZOID~~~".~~~"TR_LONG_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "S.Length" THEN
						ls_where = ls_where  + " AND (~~~"TRAPEZOID~~~".~~~"TR_SHORT_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Width" THEN
						ls_where = ls_where  + " AND (~~~"TRAPEZOID~~~".~~~"TR_WIDTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			CASE "L.Trapezoid"
				lds_d.dataObject = "d_order_item_ltrapezoid"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"LEFT_TRAPEZOID~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"LEFT_TRAPEZOID~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"LEFT_TRAPEZOID~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "L.Length" THEN
						ls_where = ls_where  + " AND (~~~"LEFT_TRAPEZOID~~~".~~~"LTR_LONG_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "S.Length" THEN
						ls_where = ls_where  + " AND (~~~"LEFT_TRAPEZOID~~~".~~~"LTR_SHORT_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Width" THEN
						ls_where = ls_where  + " AND (~~~"LEFT_TRAPEZOID~~~".~~~"LTR_WIDTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			CASE "R.Trapezoid"
				lds_d.dataObject = "d_order_item_rtrapezoid"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"RIGHT_TRAPEZOID~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"RIGHT_TRAPEZOID~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"RIGHT_TRAPEZOID~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "L.Length" THEN
						ls_where = ls_where  + " AND (~~~"RIGHT_TRAPEZOID~~~".~~~"RTR_LONG_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "S.Length" THEN
						ls_where = ls_where  + " AND (~~~"RIGHT_TRAPEZOID~~~".~~~"RTR_SHORT_LENGTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Width" THEN
						ls_where = ls_where  + " AND (~~~"RIGHT_TRAPEZOID~~~".~~~"RTR_WIDTH~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
			CASE "Other"
				lds_d.dataObject = "d_order_item_x1shape"
				lds_d.SetTransObject(SQLCA)
				ls_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~"  FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~" ,~~~"X1_SHAPE~~~"   "
				ls_where = "  WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"X1_SHAPE~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"X1_SHAPE~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" ) "
				FOR ll_j = 1 TO ll_row
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length1" THEN
						ls_where = ls_where  + " AND (~~~"X1_SHAPE~~~".~~~"X_1~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length2" THEN
						ls_where = ls_where  + " AND (~~~"X1_SHAPE~~~".~~~"X_2~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length3" THEN
						ls_where = ls_where  + " AND (~~~"X1_SHAPE~~~".~~~"X_3~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length4" THEN
						ls_where = ls_where  + " AND (~~~"X1_SHAPE~~~".~~~"X_4~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length5" THEN
						ls_where = ls_where  + " AND (~~~"X1_SHAPE~~~".~~~"X_5~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
					IF	adw_d.getItemString(ll_j, "column_t", Primary!, FALSE) = "Length6" THEN
						ls_where = ls_where  + " AND (~~~"X1_SHAPE~~~".~~~"X_6~~~" " + adw_d.getItemString(ll_j, "operator_t", Primary!, FALSE) + " " + adw_d.getItemString(ll_j, "value_t", Primary!, FALSE) + " )"
					END IF
				NEXT
		END CHOOSE
	END IF
NEXT

ls_modify ="DataWindow.Table.Select = '" + ls_select + ls_where + " '"
ls_rc = lds_d.Modify(ls_modify)
IF ls_rc = "" THEN lds_d.Retrieve()

//customer_order_order_abc_num
ll_row = lds_d.RowCount()
IF ll_row < 1 THEN RETURN
li_s = 1
FOR ll_l = 1 TO ll_row
	istr_or[li_s].db_name = "CUSTOMER_ORDER"
	istr_or[li_s].db_field = "ORDER_ABC_NUM"
	istr_or[li_s].col_type = "number"
	istr_or[li_s].operator = "="
	istr_or[li_s].value = String(lds_d.getItemNumber(ll_l, "customer_order_order_abc_num"))
	li_s++
NEXT

DESTROY lds_d

end subroutine

public function integer wf_retrieve ();//Alex Gerlants. 05/26/2016. Begin
/*
Function:	wf_retrieve
Returns:		integer
Arguments:	none
*/

Integer	li_rtn = 1
Long		ll_rows

ll_rows = f_retrieve(dw_order_list, -99) //-99 means that f_retrieve will retrieve all orders in dw_order_list

Return li_rtn
//Alex Gerlants. 05/26/2016. End
end function

on w_cust_order_list.create
int iCurrent
call super::create
if this.MenuName = "m_cust_order_list" then this.MenuID = create m_cust_order_list
this.dw_order_list=create dw_order_list
this.cb_report=create cb_report
this.cb_close=create cb_close
this.cb_open=create cb_open
this.gb_1=create gb_1
this.cb_new=create cb_new
this.st_cond=create st_cond
this.cb_search=create cb_search
this.cb_reset=create cb_reset
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.dw_report=create dw_report
this.cb_end_user_change=create cb_end_user_change
this.cb_showall=create cb_showall
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_order_list
this.Control[iCurrent+2]=this.cb_report
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_open
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_new
this.Control[iCurrent+7]=this.st_cond
this.Control[iCurrent+8]=this.cb_search
this.Control[iCurrent+9]=this.cb_reset
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.dw_report
this.Control[iCurrent+17]=this.cb_end_user_change
this.Control[iCurrent+18]=this.cb_showall
end on

on w_cust_order_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_order_list)
destroy(this.cb_report)
destroy(this.cb_close)
destroy(this.cb_open)
destroy(this.gb_1)
destroy(this.cb_new)
destroy(this.st_cond)
destroy(this.cb_search)
destroy(this.cb_reset)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_report)
destroy(this.cb_end_user_change)
destroy(this.cb_showall)
end on

event open;call super::open;is_select = "   SELECT  ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" ,~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" ,~~~"CUSTOMER_ORDER~~~".~~~"ENDUSER_ID~" ,~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_PO~~~" ,~~~"CUSTOMER_ORDER~~~".~"ENDUSER_PO~~~" ,~~~"CUSTOMER_ORDER~~~".~~~"CREATED_DATE~~~" ,~~~"ORDER_ITEM~~~".~~~"SHEET_TYPE~~~" , ~~~"ORDER_ITEM~~~".~~~"ENDUSER_PART_NUM~~~" ,~~~"ORDER_ITEM~~~".~~~"ALLOY2~~~" ,~~~"ORDER_ITEM~~~".~~~"TEMPER~~~" , ~~~"ORDER_ITEM~~~".~~~"GAUGE~~~" ,~~~"ORDER_ITEM~~~".~~~"ITEM_STATUS~~~"     FROM ~~~"CUSTOMER_ORDER~~~" ,~~~"ORDER_ITEM~~~"  "

SetNULL(gl_message)

wf_init_dwdb()

dw_order_list.SetFocus()
ib_allcust = TRUE
dw_order_list.Event ue_resume_all_cust()

ii_showall=1 //showall

end event

event pfc_print;SetPointer(HourGlass!)

dw_report.Reset()
//Modified by Victor Huang at 05/05
dw_order_list.ShareData(dw_report)
//Using this RowsCopy(), the customer and enduser columns show the customer_id, the short_name won't show.
//dw_order_list.RowsCopy(1, dw_order_list.RowCount(), Primary!, dw_report, 1, Primary!)
dw_report.ResetUpdate()

IF MessageBox("Question", "Print out current job list?", Question!, OKCancel!, 1) = 1 THEN
	dw_report.print()
END IF

//Modified by Victor Huang at 05/05
dw_report.ShareDataOff()
dw_report.Reset()

RETURN 1


end event

event pfc_new;IF MessageBox("Question", "Create a new customer order?", Question!, YesNO!, 1 ) = 2 THEN RETURN

gl_message = 0

//IF MessageBox("Question", "Do you want to use an existing part number?", Question!, YesNO!, 1 ) = 1 THEN 
	//SetPointer(HourGlass!)
	//Message.StringParm = "w_order_entry_part_number" 
	//gnv_app.of_getFrame().Event pfc_open()
//ELSE
	SetPointer(HourGlass!)
	Message.StringParm = "w_order_entry" 
	gnv_app.of_getFrame().Event pfc_open()
//END IF

//Close(this) //Alex Gerlants. 03/25/2019. Do not close this window if new order.
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Order Entry") = 1 THEN
	IF f_security_door("End User Change") = 1 THEN
		cb_end_user_change.ENABLED = TRUE
	END IF
	RETURN 1
END IF
This.Event ue_read_only()
end event

type dw_order_list from u_dw within w_cust_order_list
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_resume_all_cust ( )
integer x = 15
integer y = 176
integer width = 3507
integer height = 1587
integer taborder = 10
string dataobject = "d_order_list"
boolean hscrollbar = true
end type

event ue_search_retrieve;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net

ls_where = wf_search_terms()

ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve()
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

cb_showall.Text = "&Show New"
ii_showall = 0


Return 1
end event

event ue_resume_where;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ls_where = "    WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~"(+) ) ORDER BY ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" DESC  "
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve()
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

end event

event ue_resume_all_cust;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ls_where = "    WHERE ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~"(+) ) AND ( (~~~"ORDER_ITEM~~~".~~~"ITEM_STATUS~~~" = 1) OR (~~~"ORDER_ITEM~~~".~~~"ITEM_STATUS~~~" = 2) OR (~~~"ORDER_ITEM~~~".~~~"ITEM_STATUS~~~" = 4) ) ORDER BY ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" DESC   "
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve()
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "New, InProcess and OnHold orders only"

end event

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 
SetTransObject(SQLCA)



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

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event clicked;//Override pfc's clicked because it is running on wrong sequence
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

event doubleclicked;IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

SelectRow(row, TRUE)
cb_open.TriggerEvent (clicked!)

end event

type cb_report from u_cb within w_cust_order_list
integer x = 2264
integer y = 1856
integer width = 406
integer height = 83
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_cust_order_list
string tag = "Exit"
integer x = 2714
integer y = 1856
integer width = 406
integer height = 83
integer taborder = 90
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_open from u_cb within w_cust_order_list
string tag = "Open an order"
integer x = 410
integer y = 1856
integer width = 406
integer height = 83
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Open"
end type

event clicked;SetPointer(HourGlass!)
parent.Event ue_openorder()
end event

type gb_1 from groupbox within w_cust_order_list
integer x = 51
integer width = 3449
integer height = 179
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Search"
end type

type cb_new from u_cb within w_cust_order_list
string tag = "Open an new order"
integer x = 863
integer y = 1856
integer width = 406
integer height = 83
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New"
end type

event clicked;RETURN Parent.Event ue_neworder()
end event

type st_cond from statictext within w_cust_order_list
integer x = 80
integer y = 48
integer width = 3131
integer height = 115
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
string text = "All"
boolean focusrectangle = false
end type

type cb_search from u_cb within w_cust_order_list
integer x = 3233
integer y = 35
integer width = 230
integer height = 67
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Search"
end type

event clicked;OpenWithParm(w_buildfilter_order_entry, dw_order_list.DataObject)

end event

type cb_reset from u_cb within w_cust_order_list
integer x = 3233
integer y = 109
integer width = 230
integer height = 67
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;dw_order_list.Event ue_resume_all_cust()
cb_showall.Text = "&Show All"
ii_showall = 1

end event

type st_1 from statictext within w_cust_order_list
integer x = 18
integer y = 1773
integer width = 358
integer height = 64
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

type st_2 from statictext within w_cust_order_list
integer x = 388
integer y = 1773
integer width = 154
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 79741120
boolean enabled = false
string text = "Done"
boolean focusrectangle = false
end type

type st_3 from statictext within w_cust_order_list
integer x = 549
integer y = 1773
integer width = 230
integer height = 61
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

type st_4 from statictext within w_cust_order_list
integer x = 841
integer y = 1773
integer width = 121
integer height = 61
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
string text = "New"
boolean focusrectangle = false
end type

type st_5 from statictext within w_cust_order_list
integer x = 991
integer y = 1773
integer width = 208
integer height = 61
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

type st_6 from statictext within w_cust_order_list
integer x = 1254
integer y = 1773
integer width = 168
integer height = 61
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

type dw_report from u_dw within w_cust_order_list
boolean visible = false
integer x = 3178
integer y = 1856
integer width = 168
integer height = 45
integer taborder = 20
string dataobject = "d_report_order_list"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 
SetTransObject(SQLCA)
//Retrieve()
//Reset()

end event

type cb_end_user_change from u_cb within w_cust_order_list
string tag = "Open an new order"
integer x = 1317
integer y = 1856
integer width = 450
integer height = 83
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "End User &Change"
end type

event clicked;Parent.Event ue_end_user_change()
end event

type cb_showall from u_cb within w_cust_order_list
string tag = "Show all records"
integer x = 1810
integer y = 1856
integer width = 406
integer height = 83
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Show All"
end type

event clicked;IF ii_showall = 1 THEN  //show all
	dw_order_list.Event ue_resume_where()
	this.Text = "&Show New"
	ii_showall = 0
ELSE	//show new, inprocess and onhold
	dw_order_list.Event ue_resume_all_cust()
	this.Text = "&Show All"
	ii_showall = 1
END IF

end event

