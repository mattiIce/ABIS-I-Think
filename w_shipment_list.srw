$PBExportHeader$w_shipment_list.srw
$PBExportComments$<Sheet> list all shipment for browsing, inherited from pfemani\w_sheet
forward
global type w_shipment_list from w_sheet
end type
type cbx_all from checkbox within w_shipment_list
end type
type dw_customer_list_short from u_dw within w_shipment_list
end type
type dw_shipment_list from u_dw within w_shipment_list
end type
type cb_report from u_cb within w_shipment_list
end type
type dw_customer from u_dw within w_shipment_list
end type
type cb_close from u_cb within w_shipment_list
end type
type cb_open from u_cb within w_shipment_list
end type
type gb_1 from groupbox within w_shipment_list
end type
type cb_new from u_cb within w_shipment_list
end type
type ddlb_customer from dropdownlistbox within w_shipment_list
end type
type st_1 from statictext within w_shipment_list
end type
type st_cond from statictext within w_shipment_list
end type
type cb_search from u_cb within w_shipment_list
end type
type cb_reset from u_cb within w_shipment_list
end type
end forward

global type w_shipment_list from w_sheet
integer x = 4
integer y = 3
integer width = 4484
integer height = 2282
string title = "ABCO shipment management"
string menuname = "m_shipment_list"
boolean resizable = false
event ue_openorder ( )
event type string ue_whoami ( )
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
cbx_all cbx_all
dw_customer_list_short dw_customer_list_short
dw_shipment_list dw_shipment_list
cb_report cb_report
dw_customer dw_customer
cb_close cb_close
cb_open cb_open
gb_1 gb_1
cb_new cb_new
ddlb_customer ddlb_customer
st_1 st_1
st_cond st_cond
cb_search cb_search
cb_reset cb_reset
end type
global w_shipment_list w_shipment_list

type variables
Long il_old_job
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]

Long	il_customer //Alex Gerlants. 05/20/2016

end variables

forward prototypes
public function string wf_search_terms ()
public function string wf_display_total_terms ()
public function integer wf_display_total_info ()
public subroutine wf_init_dwdb ()
public subroutine wf_reset_condition ()
public function long wf_get_userid (string as_name)
public function long wf_get_carrierid (string as_name)
public function integer wf_retrieve ()
public subroutine wf_scroll_2row (long al_packing_list)
public subroutine wf_get_ship_info (long al_customer_id, string as_customer_short_name)
public subroutine wf_retrieve_customer_short_list ()
end prototypes

event ue_openorder();SetPointer(HourGlass!)
Int li_rc
Long ll_row

ll_row = dw_shipment_list.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select an shipment first!", StopSign! )
	RETURN
END IF

gl_message = dw_shipment_list.GetItemNumber(ll_row, "packing_list" )
gl_customer = dw_shipment_list.GetItemNumber(ll_row, "customer_id" )

//Close(this) //Alex Gerlants. 05/20/2016

SetPointer(HourGlass!)
Message.StringParm = "w_shipping_2"
gnv_app.of_getFrame().Event pfc_open()

end event

event ue_whoami;RETURN "w_shipment_list"
end event

event ue_read_only;cb_new.Enabled = FALSE
m_shipment_list.m_file.m_new.Disable()

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
			IF istr_search[li_s].col_type = "customer" THEN
					istr_search[li_s].value = String(wf_get_userid(istr_search[li_s].value))
			END IF
			IF istr_search[li_s].col_type = "carrier" THEN
					istr_search[li_s].value = String(wf_get_carrierid(istr_search[li_s].value))
			END IF
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
					CASE ELSE
						istr_search[li_s].value = "9999"
				END CHOOSE
			END IF
			IF istr_search[li_s].col_type = "vehicle_status" THEN
					CHOOSE CASE Upper(Trim(istr_search[li_s].value))
					CASE "GONE"
						istr_search[li_s].value = "0"
					CASE "COMING"
						istr_search[li_s].value = "1"					
					CASE "RESERVED"
						istr_search[li_s].value = "2"					
					CASE "CANCELED"
						istr_search[li_s].value = "3"					
					CASE ELSE
						istr_search[li_s].value = "9999"
				END CHOOSE
			END IF
			li_s++
		END IF
	li_i++
	LOOP
NEXT

dw_shipment_list.Event ue_search_retrieve()

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

ls_terms = " WHERE ( ~~~"SHIPMENT~~~".~~~"CUSTOMER_ID~~~" = :al_cust_id ) "
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "customer"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "carrier"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "vehicle_status"
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

ls_terms = " WHERE ( SHIPMENT.CUSTOMER_ID = " + String(ll_cust) + " ) "
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].operator <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "customer"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "carrier"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "vehicle_status"
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

ls_select = "SELECT COUNT(packing_list) FROM shipment "

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
String ls_Mysql
ls_Mysql = ls_select + ls_where
PREPARE SQLSA FROM :ls_Mysql;
OPEN DYNAMIC my_cursor;
FETCH my_cursor INTO :ll_item;
CLOSE my_cursor ;

IF IsNULL(ll_item) THEN ll_item = 0

dw_shipment_list.Object.item_t.Text = String(ll_item, "#,###,###")
dw_shipment_list.Object.ship_t.Text = "shipment(s) listed"

RETURN 1

end function

public subroutine wf_init_dwdb ();istr_dwdb[1].db_name = "SHIPMENT"
istr_dwdb[1].db_field = "PACKING_LIST"
istr_dwdb[1].dw_column = "packing_list"
istr_dwdb[1].col_type = "number"
istr_dwdb[1].dw_header = "Packing List"

istr_dwdb[2].db_name = "SHIPMENT"
istr_dwdb[2].db_field = "BILL_OF_LADING"
istr_dwdb[2].dw_column = "bill_of_lading"
istr_dwdb[2].col_type = "number"
istr_dwdb[2].dw_header = "Bill of Lading"

istr_dwdb[3].db_name = "SHIPMENT"
istr_dwdb[3].db_field = "DES_SH_CUST_ID"
istr_dwdb[3].dw_column = "des_sh_cust_id"
istr_dwdb[3].col_type = "customer"
istr_dwdb[3].dw_header = "Shipped to"

istr_dwdb[4].db_name = "SHIPMENT"
istr_dwdb[4].db_field = "VEHICLE_ID"
istr_dwdb[4].dw_column = "vehicle_id"
istr_dwdb[4].col_type = "string"
istr_dwdb[4].dw_header = "Vehicle ID"

istr_dwdb[5].db_name = "SHIPMENT"
istr_dwdb[5].db_field = "VEHICLE_STATUS"
istr_dwdb[5].dw_column = "vehicle_status"
istr_dwdb[5].col_type = "vehicle_status"
istr_dwdb[5].dw_header = "Vehicle Status"

istr_dwdb[6].db_name = "SHIPMENT"
istr_dwdb[6].db_field = "SHIPMENT_SCHEDULED_DATE_TIME"
istr_dwdb[6].dw_column = "shipment_scheduled_date_time"
istr_dwdb[6].col_type = "date"
istr_dwdb[6].dw_header = "Scheduled"

istr_dwdb[7].db_name = "SHIPMENT"
istr_dwdb[7].db_field = "DATE_SENT"
istr_dwdb[7].dw_column = "date_sent"
istr_dwdb[7].col_type = "date"
istr_dwdb[7].dw_header = "Date Sent"

istr_dwdb[8].db_name = "SHIPMENT"
istr_dwdb[8].db_field = "SHIPMENT_ACTUALED_DATE_TIME"
istr_dwdb[8].dw_column = "shipment_actualed_date_time"
istr_dwdb[8].col_type = "date"
istr_dwdb[8].dw_header = "Actual Date"

istr_dwdb[9].db_name = "SHIPMENT"
istr_dwdb[9].db_field = "SHIPMENT_NOTES"
istr_dwdb[9].dw_column = "shipment_notes"
istr_dwdb[9].col_type = "string"
istr_dwdb[9].dw_header = "Notes"

//istr_dwdb[10].db_name = "SHIPMENT"
//istr_dwdb[10].db_field = "CUSTOMER_ID"
//istr_dwdb[10].dw_column = "customer_id"
//istr_dwdb[10].col_type = "customer"
//istr_dwdb[10].dw_header = "Sold to"

istr_dwdb[10].db_name = "SHIPMENT"
istr_dwdb[10].db_field = "SHIPMENT_STATUS"
istr_dwdb[10].dw_column = "shipment_status"
istr_dwdb[10].col_type = "status"
istr_dwdb[10].dw_header = "Status"

istr_dwdb[11].db_name = "SHIPMENT"
istr_dwdb[11].db_field = "TRANSPORTATION_METHOD_CODE"
istr_dwdb[11].dw_column = "transportation_method_code"
istr_dwdb[11].col_type = "string"
istr_dwdb[11].dw_header = "Trans.Method Code"

istr_dwdb[12].db_name = "SHIPMENT"
istr_dwdb[12].db_field = "CARRIER_DESCRIPTION_CODE"
istr_dwdb[12].dw_column = "carrier_description_code"
istr_dwdb[12].col_type = "string"
istr_dwdb[12].dw_header = "Carrier Desc. Code"

istr_dwdb[13].db_name = "SHIPMENT"
istr_dwdb[13].db_field = "CARRIER_INITIAL"
istr_dwdb[13].dw_column = "carrier_initial"
istr_dwdb[13].col_type = "string"
istr_dwdb[13].dw_header = "Carrier Initial"

istr_dwdb[14].db_name = "SHIPMENT"
istr_dwdb[14].db_field = "SHIPMENT_EDI856_DATE"
istr_dwdb[14].dw_column = "shipment_edi856_date"
istr_dwdb[14].col_type = "date"
istr_dwdb[14].dw_header = "Edi856 Date"

istr_dwdb[15].db_name = "SHIPMENT"
istr_dwdb[15].db_field = "CARRIER_ID"
istr_dwdb[15].dw_column = "carrier_id"
istr_dwdb[15].col_type = "carrier"
istr_dwdb[15].dw_header = "Carrier"

istr_dwdb[16].db_name = "SHIPMENT"
istr_dwdb[16].db_field = "SHIPMENT_DES_EDI856_DATE"
istr_dwdb[16].dw_column = "shipment_des_edi856_date"
istr_dwdb[16].col_type = "date"
istr_dwdb[16].dw_header = "Shipped to Edi856 Date"

istr_dwdb[17].db_name = "SHIPMENT"
istr_dwdb[17].db_field = "SHIPMENT_ENDUSER_ID"
istr_dwdb[17].dw_column = "shipment_enduser_id"
istr_dwdb[17].col_type = "customer"
istr_dwdb[17].dw_header = "Shipment EndUser"


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

public function long wf_get_carrierid (string as_name);Long ll_id, ll_row, ll_i
DataStore lds_u

ll_id = 0

lds_u = CREATE DataStore
lds_u.DataObject = "d_dddw_carrier_id"
lds_u.SetTransObject(SQLCA)
lds_u.Retrieve()

ll_row = lds_u.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF Upper(Trim(lds_u.GetItemString(ll_i, "carrier_full_name"))) = Upper(Trim(as_name)) THEN
			ll_id = lds_u.GetItemNumber(ll_i, "carrier_id")
		END IF
	NEXT
END IF

DESTROY lds_u

RETURN ll_id
end function

public function integer wf_retrieve ();//Alex Gerlants. 05/26/2016. Begin
/*
Function:	wf_retrieve
Returns:		integer
Arguments:	none
*/

Integer	li_rtn = 1
Long		ll_rows

ll_rows = f_retrieve(dw_shipment_list, il_customer)

Return li_rtn
//Alex Gerlants. 05/26/2016. End
end function

public subroutine wf_scroll_2row (long al_packing_list);//Alex Gerlants. 10/04/2018. Begin
/*
Function:	wf_scroll_2row
Returns:		none
Arguments:	value	long	al_packing_list
*/

Long		ll_found_row, ll_packing_list
String	ls_find_string

ls_find_string = "packing_list = " + String(al_packing_list)
ll_found_row = dw_shipment_list.Find(ls_find_string, 1, dw_shipment_list.RowCount())

If ll_found_row > 0 Then
	dw_shipment_list.SetFocus()
	dw_shipment_list.ScrollToRow(ll_found_row)
	dw_shipment_list.SelectRow(0, False)
	dw_shipment_list.SelectRow(ll_found_row, True)
End If
//Alex Gerlants. 10/04/2018. End
end subroutine

public subroutine wf_get_ship_info (long al_customer_id, string as_customer_short_name);//Alex Gerlants. Short_List_Of_Ship_Customers. Begin
/*
Function:	wf_get_ship_info
Returns:		none
Argumants:	value	long		al_customer_id
				value	string	as_customer_short_name
*/
String ls_text
Long ll_row, ll_i

ls_text = as_customer_short_name

ll_row = dw_customer.RowCount()

FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		dw_shipment_list.Event ue_resume_where()
		wf_display_total_info()
	END IF
NEXT

il_customer = al_customer_id //Alex Gerlants. 05/20/2016

//Alex Gerlants. Short_List_Of_Ship_Customers. End
end subroutine

public subroutine wf_retrieve_customer_short_list ();//Alex Gerlants. Short_List_Of_Ship_Customers. Begin
/*
Function:	wf_retrieve_customer_short_list
Returns:		none
Arguments:	none
*/
DataWindowChild	ldwc
Integer				li_rtn
Long					ll_rows, ll_customer_id
String				ls_customer_short_name
DateTime				ldt_from, ldt_to
Date					ld_from, ld_to

ld_from = RelativeDate(Today(), -730) //2 years back
ld_to = Today()

ldt_from = DateTime(ld_from, Time("00:00:00"))
ldt_to = DateTime(ld_to, Time("23:59:59"))

li_rtn = dw_customer_list_short.GetChild("customer_short_name", ldwc)

If li_rtn = 1 Then
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve(ldt_from, ldt_to)
	
	If ll_rows > 0 Then
		ls_customer_short_name = ldwc.GetItemString(1, "customer_short_name")
		dw_customer_list_short.Object.customer_short_name[1] = ls_customer_short_name
	End If
End If
//Alex Gerlants. Short_List_Of_Ship_Customers. End
end subroutine

on w_shipment_list.create
int iCurrent
call super::create
if this.MenuName = "m_shipment_list" then this.MenuID = create m_shipment_list
this.cbx_all=create cbx_all
this.dw_customer_list_short=create dw_customer_list_short
this.dw_shipment_list=create dw_shipment_list
this.cb_report=create cb_report
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.cb_open=create cb_open
this.gb_1=create gb_1
this.cb_new=create cb_new
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.st_cond=create st_cond
this.cb_search=create cb_search
this.cb_reset=create cb_reset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_all
this.Control[iCurrent+2]=this.dw_customer_list_short
this.Control[iCurrent+3]=this.dw_shipment_list
this.Control[iCurrent+4]=this.cb_report
this.Control[iCurrent+5]=this.dw_customer
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_open
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.cb_new
this.Control[iCurrent+10]=this.ddlb_customer
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_cond
this.Control[iCurrent+13]=this.cb_search
this.Control[iCurrent+14]=this.cb_reset
end on

on w_shipment_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_all)
destroy(this.dw_customer_list_short)
destroy(this.dw_shipment_list)
destroy(this.cb_report)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.cb_open)
destroy(this.gb_1)
destroy(this.cb_new)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.st_cond)
destroy(this.cb_search)
destroy(this.cb_reset)
end on

event open;call super::open;

ddlb_customer.Visible = False //Alex Gerlants. Short_List_Of_Ship_Customers
dw_customer_list_short.Visible = True //Alex Gerlants. Short_List_Of_Ship_Customers

dw_customer.Visible = FALSE

dw_customer.of_SetLinkage(TRUE)
dw_customer.inv_linkage.of_SetStyle(2)
dw_customer.inv_linkage.of_SetUpdateOnRowChange (True)
dw_customer.inv_linkage.of_SetConfirmOnRowChange (True)

dw_shipment_list.of_SetLinkage( TRUE ) 
dw_shipment_list.inv_Linkage.of_SetMaster(dw_customer)
IF NOT dw_shipment_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & shipment in win w_shipment_list!" )
ELSE
	dw_shipment_list.inv_Linkage.of_Register( "customer_id", "customer_id" ) 
	dw_shipment_list.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_customer.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_customer.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_cust_order_list::open function" )
ELSE
	SQLCA.of_Commit()
	dw_customer.SelectRow(1,TRUE)
	wf_display_total_info()
	dw_customer.SetFocus()
End IF

is_select = " SELECT  ~~~"SHIPMENT~~~".~~~"PACKING_LIST~~~" ,~~~"SHIPMENT~~~".~~~"BILL_OF_LADING~~~" ,~~~"SHIPMENT~~~".~~~"DES_SH_CUST_ID~~~" ,~~~"SHIPMENT~~~".~~~"VEHICLE_ID~~~" ,~~~"SHIPMENT~~~".~~~"VEHICLE_STATUS~~~" ,~~~"SHIPMENT~~~".~~~"SHIPMENT_SCHEDULED_DATE_TIME~~~" ,~~~"SHIPMENT~~~".~~~"DATE_SENT~~~" ,~~~"SHIPMENT~~~".~~~"SHIPMENT_ACTUALED_DATE_TIME~~~" ,~~~"SHIPMENT~~~".~~~"SHIPMENT_NOTES~~~" ,~~~"SHIPMENT~~~".~~~"CUSTOMER_ID~~~" ,~~~"SHIPMENT~~~".~~~"SHIPMENT_STATUS~~~" ,~~~"SHIPMENT~~~".~~~"TRANSPORTATION_METHOD_CODE~~~" ,~~~"SHIPMENT~~~".~~~"CARRIER_DESCRIPTION_CODE~~~" ,~~~"SHIPMENT~~~".~~~"CARRIER_INITIAL~~~" ,~~~"SHIPMENT~~~".~~~"SHIPMENT_EDI856_DATE~~~" , ~~~"SHIPMENT~~~".~~~"CARRIER_ID~~~" ,~~~"SHIPMENT~~~".~~~"SHIPMENT_DES_EDI856_DATE~~~" ,~~~"SHIPMENT~~~".~~~"SHIPMENT_ENDUSER_ID~~~"    FROM ~~~"SHIPMENT~~~" "  
SetNULL(gl_message)

wf_init_dwdb()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)
dw_shipment_list.SetFocus()

wf_retrieve_customer_short_list() //Alex Gerlants. Short_List_Of_Ship_Customers
end event

event pfc_print;SetPointer(HourGlass!)

IF MessageBox("Question", "Print out current job list?", Question!, OKCancel!, 1) = 1 THEN
	Return dw_shipment_list.Event pfc_print()
END IF

RETURN 0

end event

event pfc_new;IF MessageBox("Question", "Create a new shipment?", Question!, OKCancel!, 1 ) = 2 THEN RETURN

gl_message = 0

SetPointer(HourGlass!)
Message.StringParm = "w_shipping_2" 
gnv_app.of_getFrame().Event pfc_open()
Close(this)
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Shipment(Control)") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type cbx_all from checkbox within w_shipment_list
integer x = 677
integer y = 19
integer width = 143
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "All"
boolean lefttext = true
end type

event clicked;DataWindowChild	ldwc
Integer				li_rtn
Long					ll_rows, ll_customer_id
String				ls_customer_short_name


dw_shipment_list.Reset()

If This.Checked = True Then
	ddlb_customer.Visible = True
	dw_customer_list_short.Visible = False
	
	ddlb_customer.SelectItem(1)
	dw_shipment_list.SetFocus()
Else
	ddlb_customer.Visible = False
	dw_customer_list_short.Visible = True
	
	li_rtn = dw_customer_list_short.GetChild("customer_short_name", ldwc)

	If li_rtn = 1 Then
		ls_customer_short_name = ldwc.GetItemString(1, "customer_short_name")
		dw_customer_list_short.Object.customer_short_name[1] = ls_customer_short_name
	End If
End If
end event

type dw_customer_list_short from u_dw within w_shipment_list
integer x = 18
integer y = 80
integer width = 805
integer height = 80
integer taborder = 50
string dataobject = "d_customer_list_short"
boolean vscrollbar = false
end type

event constructor;call super::constructor;This.InsertRow(0)
This.of_SetUpdateable(False) 
end event

event itemchanged;call super::itemchanged;DataWindowChild	ldwc
Integer				li_rtn
String				ls_customer_short_name, ls_find_string
Long					ll_found_row, ll_customer_id

This.AcceptText()
li_rtn = This.GetChild("customer_short_name", ldwc)

If li_rtn = 1 Then
	ls_customer_short_name = This.Object.customer_short_name[1]
	ls_find_string = "customer_short_name = '" + Trim(ls_customer_short_name) + "'"
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		ll_customer_id = ldwc.GetItemNumber(ll_found_row, "shipment_customer_id")
		wf_get_ship_info(ll_customer_id, ls_customer_short_name)
	End If
End If
end event

type dw_shipment_list from u_dw within w_shipment_list
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
integer x = 15
integer y = 198
integer width = 4421
integer height = 1802
integer taborder = 10
string dataobject = "d_shipment_list"
boolean hscrollbar = true
boolean resizable = true
end type

event ue_search_retrieve;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net

ls_where = wf_search_terms()

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
ls_where = " WHERE ( ~~~"SHIPMENT~~~".~~~"CUSTOMER_ID~~~" = :al_cust_id ) " 
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

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 

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

type cb_report from u_cb within w_shipment_list
integer x = 1872
integer y = 2032
integer width = 406
integer height = 83
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;Parent.Event pfc_print()
end event

type dw_customer from u_dw within w_shipment_list
integer x = 728
integer y = 13
integer width = 95
integer height = 35
integer taborder = 0
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
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 


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

type cb_close from u_cb within w_shipment_list
string tag = "Exit"
integer x = 2534
integer y = 2032
integer width = 406
integer height = 83
integer taborder = 80
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_open from u_cb within w_shipment_list
string tag = "Open an order"
integer x = 549
integer y = 2032
integer width = 406
integer height = 83
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Open"
end type

event clicked;SetPointer(HourGlass!)
parent.Event ue_openorder()
end event

type gb_1 from groupbox within w_shipment_list
integer x = 834
integer width = 2670
integer height = 198
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

type cb_new from u_cb within w_shipment_list
string tag = "Open an new order"
integer x = 1211
integer y = 2032
integer width = 406
integer height = 83
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New"
end type

event clicked;Parent.Event pfc_new()
end event

type ddlb_customer from dropdownlistbox within w_shipment_list
integer x = 18
integer y = 83
integer width = 805
integer height = 2099
integer taborder = 20
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
		dw_shipment_list.Event ue_resume_where()
		wf_display_total_info()
	END IF
NEXT

If Not IsNull(index) Then //Alex Gerlants. 10/04/2018
	il_customer = dw_customer.Object.customer_id[index] //Alex Gerlants. 05/20/2016
End If //Alex Gerlants. 10/04/2018
end event

type st_1 from statictext within w_shipment_list
integer x = 18
integer y = 22
integer width = 424
integer height = 61
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

type st_cond from statictext within w_shipment_list
integer x = 867
integer y = 54
integer width = 2373
integer height = 131
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

type cb_search from u_cb within w_shipment_list
integer x = 3251
integer y = 42
integer width = 230
integer height = 67
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Search"
end type

event clicked;OpenWithParm(w_buildfilter, dw_shipment_list.DataObject)

end event

type cb_reset from u_cb within w_shipment_list
integer x = 3251
integer y = 118
integer width = 230
integer height = 67
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;dw_shipment_list.Event ue_resume_where()
end event

