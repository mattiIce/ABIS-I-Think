$PBExportHeader$w_prod_scrap.srw
$PBExportComments$<Sheet> handle scrap and related works, inherited from pfemain\w_sheet
forward
global type w_prod_scrap from w_sheet
end type
type cb_refresh_all from commandbutton within w_prod_scrap
end type
type dw_scrap_status from datawindow within w_prod_scrap
end type
type dw_scrap_type from datawindow within w_prod_scrap
end type
type cb_new from u_cb within w_prod_scrap
end type
type cb_remove from u_cb within w_prod_scrap
end type
type cb_close from u_cb within w_prod_scrap
end type
type cb_print from u_cb within w_prod_scrap
end type
type dw_customer from u_dw within w_prod_scrap
end type
type cb_sort from u_cb within w_prod_scrap
end type
type tab_scrap from tab within w_prod_scrap
end type
type tabpage_skid from userobject within tab_scrap
end type
type dw_scrap_list from u_dw within tabpage_skid
end type
type st_2 from statictext within tabpage_skid
end type
type st_3 from statictext within tabpage_skid
end type
type st_4 from statictext within tabpage_skid
end type
type st_5 from statictext within tabpage_skid
end type
type st_6 from statictext within tabpage_skid
end type
type st_7 from statictext within tabpage_skid
end type
type dw_scrap_item from u_dw within tabpage_skid
end type
type st_8 from statictext within tabpage_skid
end type
type st_9 from statictext within tabpage_skid
end type
type dw_editor from u_dw within tabpage_skid
end type
type cb_esave from u_cb within tabpage_skid
end type
type cb_ereset from u_cb within tabpage_skid
end type
type dw_report from u_dw within tabpage_skid
end type
type tabpage_skid from userobject within tab_scrap
dw_scrap_list dw_scrap_list
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
dw_scrap_item dw_scrap_item
st_8 st_8
st_9 st_9
dw_editor dw_editor
cb_esave cb_esave
cb_ereset cb_ereset
dw_report dw_report
end type
type tabpage_rejcoil from userobject within tab_scrap
end type
type dw_rejcoils from u_dw within tabpage_rejcoil
end type
type tabpage_rejcoil from userobject within tab_scrap
dw_rejcoils dw_rejcoils
end type
type tab_scrap from tab within w_prod_scrap
tabpage_skid tabpage_skid
tabpage_rejcoil tabpage_rejcoil
end type
type st_1 from statictext within w_prod_scrap
end type
type ddlb_customer from dropdownlistbox within w_prod_scrap
end type
type cb_search from u_cb within w_prod_scrap
end type
type cb_reset from u_cb within w_prod_scrap
end type
type st_cond from statictext within w_prod_scrap
end type
type gb_1 from groupbox within w_prod_scrap
end type
type cb_ref from u_cb within w_prod_scrap
end type
type cb_newitem from u_cb within w_prod_scrap
end type
type cb_edit from u_cb within w_prod_scrap
end type
type cb_removeitem from u_cb within w_prod_scrap
end type
end forward

global type w_prod_scrap from w_sheet
integer x = 26
integer y = 16
integer width = 4381
integer height = 2237
string title = "Scrap & Reject Sheets"
string menuname = "m_prod_scrap"
boolean maxbox = false
boolean resizable = false
event ue_deleteitem ( )
event ue_sort ( )
event type string ue_whoami ( )
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
event ue_ref ( )
event ue_deleteskid ( )
event ue_report ( )
cb_refresh_all cb_refresh_all
dw_scrap_status dw_scrap_status
dw_scrap_type dw_scrap_type
cb_new cb_new
cb_remove cb_remove
cb_close cb_close
cb_print cb_print
dw_customer dw_customer
cb_sort cb_sort
tab_scrap tab_scrap
st_1 st_1
ddlb_customer ddlb_customer
cb_search cb_search
cb_reset cb_reset
st_cond st_cond
gb_1 gb_1
cb_ref cb_ref
cb_newitem cb_newitem
cb_edit cb_edit
cb_removeitem cb_removeitem
end type
global w_prod_scrap w_prod_scrap

type variables
integer ii_dw_flag
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_readonly
Integer ii_action
Long il_cur_skid, il_cur_item

String	is_scrap_handing_type //Alex Gerlants. Scrap Credit
Long		il_customer_id //Alex Gerlants. Scrap Credit
end variables

forward prototypes
public function string wf_search_terms ()
public function long wf_new_scrap_skid# ()
public subroutine wf_display_total_info ()
public function string wf_display_total_terms ()
public function string wf_search_terms_2 ()
public function string wf_display_total_terms_2 ()
public subroutine wf_init_dwdb ()
public subroutine wf_reset_condition ()
public subroutine wf_set_action (integer ai_action)
public function integer wf_check_info ()
public function long wf_get_customer_id ()
public function string wf_get_scrap_status_desc (integer ai_scrap_status)
public function string wf_get_scrap_type_desc (integer ai_scrap_type)
public subroutine wf_retrieve_scrap_handling (long al_row)
public function integer wf_get_scrap_handling_type (ref string as_scrap_handling_type_prev, ref string as_scrap_handling_type_new)
public function integer wf_get_orig_customer_id (ref long al_orig_customer_id)
end prototypes

event ue_deleteitem;SetPointer(HourGlass!)

integer li_rc, li_status, li_rowcount
Long ll_row
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
	If ll_row < 1 THEN RETURN
	li_status = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
	IF li_status = 0 THEN
		MessageBox("Warning", "This scrap skid had been shipped!", StopSign!)
		RETURN
	END IF
	li_rowcount = tab_scrap.tabpage_skid.dw_scrap_item.RowCount()
	IF li_rowcount = 1 THEN
		MessageBox("Warning", "This is the last item on the skid!", StopSign!)
		RETURN
	END IF	
	il_cur_skid = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
	tab_scrap.tabpage_skid.dw_scrap_item.RowsCopy(tab_scrap.tabpage_skid.dw_scrap_item.GetRow(), tab_scrap.tabpage_skid.dw_scrap_item.GetRow(), Primary!, tab_scrap.tabpage_skid.dw_editor, 1, Primary!)
	wf_set_action(3)
	tab_scrap.tabpage_skid.dw_editor.Event ue_del_row()
END IF
RETURN

end event

event ue_sort;String ls_null
SetNULL(ls_null)
tab_scrap.tabpage_skid.dw_scrap_list.inv_sort.of_SetSort(ls_null)
tab_scrap.tabpage_skid.dw_scrap_list.inv_sort.of_Sort()
//tab_scrap.tabpage_skid.dw_report.inv_sort.of_SetSort(ls_null)
//tab_scrap.tabpage_skid.dw_report.inv_sort.of_Sort()

end event

event ue_whoami;RETURN "w_prod_scrap"
end event

event ue_read_only;cb_new.Enabled = FALSE
cb_newitem.Enabled = FALSE
cb_edit.Enabled = FALSE
tab_scrap.tabpage_skid.cb_esave.Enabled = FALSE
tab_scrap.tabpage_skid.cb_ereset.Enabled = FALSE
cb_remove.Enabled = FALSE
cb_removeitem.Enabled = TRUE		

m_prod_scrap.m_file.m_new.Disable()
m_prod_scrap.m_file.m_save.Disable()
m_prod_scrap.m_file.m_delete.Disable()

end event

event ue_set_search(datawindow adw_d);Long ll_row, ll_l
String ls_s
Int li_i, li_s
String	ls_column_name, ls_scrap_type_desc, ls_scrap_status_desc //Alex Gerlants. 05/02/2017
Integer	li_value //Alex Gerlants. 05/02/2017

ll_row = adw_d.RowCount()
IF ll_row < 1 THEN RETURN
FOR ll_l = 1 TO ll_row
	IF Len(ls_s) > 1 THEN ls_s = ls_s + ', '
	ls_s = ls_s + adw_d.getItemString(ll_l, "column_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
	
	//Alex Gerlants. 05/02/2017. Begin
	//ls_s = ls_s + adw_d.getItemString(ll_l, "value_t", Primary!, FALSE) //Commented out
	ls_column_name = adw_d.getItemString(ll_l, "column_t", Primary!, FALSE)
	
	If ls_column_name = "Scrap Type" Or ls_column_name = "Status" Then
		li_value = Integer(adw_d.getItemString(ll_l, "value_t", Primary!, FALSE))
		
		Choose Case ls_column_name 
			Case "Scrap Type"
				ls_scrap_type_desc = wf_get_scrap_type_desc(li_value)
				ls_s = ls_s + ls_scrap_type_desc
			Case "Status"
				ls_scrap_status_desc = wf_get_scrap_status_desc(li_value)
				ls_s = ls_s + ls_scrap_status_desc
		End Choose
	Else
	//Alex Gerlants. 05/02/2017. End
		ls_s = ls_s + adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
	End If //Alex Gerlants. 05/02/2017
NEXT


		
//Alex Gerlants. 05/02/2017. End

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
//Alex Gerlants. 05/02/2017. Begin comment out		
//     I am sending scrap_type and scrap_status as a number in adw_d, and not as a string
//     Thus I don't need to transalate from a string to a number
//			IF istr_search[li_s].col_type = "status" THEN
//				CHOOSE CASE Upper(Trim(istr_search[li_s].value))
//					CASE "GONE"
//						istr_search[li_s].value = "0"
//					CASE "INPROCESS"
//						istr_search[li_s].value = "1"					
//					CASE "READY"
//						istr_search[li_s].value = "2"					
//					CASE "CANCELED"
//						istr_search[li_s].value = "3"					
//					CASE "ONHOLD"
//						istr_search[li_s].value = "4"					
//					CASE ELSE
//						istr_search[li_s].value = "9999"
//				END CHOOSE
//			END IF
//			IF istr_search[li_s].col_type = "scrap_type" THEN
//				CHOOSE CASE Upper(Trim(istr_search[li_s].value))
//					CASE "OTHERS"
//						istr_search[li_s].value = "3"	
//					CASE "REJ.SHEET-MILL"
//						istr_search[li_s].value = "1"	
//					CASE "ACCU. SCRAP"
//						istr_search[li_s].value = "2"	
//					CASE "REJ.SHEET-PROCESS"
//						istr_search[li_s].value = "5"	
//					CASE "TRAILER"				
//						istr_search[li_s].value = "4"
//					CASE "SAMPLE"
//						istr_search[li_s].value = "6"
//					CASE "TOTE"
//						istr_search[li_s].value = "7"
//					CASE "EDGE TRIM"
//						istr_search[li_s].value = "8"
//				END CHOOSE
//			END IF
//Alex Gerlants. 05/02/2017. End comment out
			li_s++
		END IF
	li_i++
	LOOP
NEXT

/*
SCRAP_TYPE	SCRAP_TYPE_DESC
----------	---------------
1				Rej.Sheet-Mill
2				Accu. Scrap
3				Others
4				Trailer
5				Rej.Sheet-Process
6				Sample
7				Tote
8				Edge Trim
*/

tab_scrap.tabpage_skid.dw_scrap_list.Event ue_search_retrieve()
tab_scrap.tabpage_skid.dw_scrap_list.of_Retrieve()
tab_scrap.tabpage_skid.dw_scrap_list.SelectRow(0,False)
tab_scrap.tabpage_skid.dw_scrap_list.SelectRow(1,TRUE)
tab_scrap.tabpage_skid.dw_scrap_list.SetRow(1)
		tab_scrap.tabpage_skid.dw_scrap_list.ScrollToRow(1)
tab_scrap.tabpage_skid.dw_scrap_list.SetFocus()
tab_scrap.tabpage_skid.dw_scrap_item.of_Retrieve()


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

event ue_ref;Long ll_row, ll_id

CHOOSE CASE tab_scrap.SelectedTab
	CASE 1 //skid
		ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
		IF ll_row < 1 THEN RETURN
		ll_id = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
		IF ll_id > 0 THEN
			OpenWithParm(w_scrap_skid_detail_info, ll_id)
		END IF		
	CASE 2 //rej coil
		ll_row = tab_scrap.tabpage_rejcoil.dw_rejcoils.GetRow()
		IF ll_row < 1 THEN RETURN
		ll_id = tab_scrap.tabpage_rejcoil.dw_rejcoils.GetItemNumber(ll_row, "coil_coil_abc_num", Primary!, FALSE)
		IF ll_id > 0 THEN
			OpenWithParm(w_coil_detail_info, ll_id)
		END IF		
END CHOOSE

end event

event ue_deleteskid();SetPointer(HourGlass!)

integer li_rc, li_status, li_rowcount
Long ll_row, ll_scrap_item, li_return, scrap_skid_id
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
	If ll_row < 1 THEN RETURN
	li_status = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
	IF li_status = 0 THEN
		MessageBox("Error", "This scrap skid had been shipped!", StopSign!)
		RETURN
	END IF
	/*
	li_rowcount = tab_scrap.tabpage_skid.dw_scrap_item.RowCount()
	IF li_rowcount > 1 THEN
		MessageBox("Warning", "There are more than one items on this skid, Please delete items first.", StopSign!)
		RETURN
	END IF	
	
	*/
	il_cur_skid = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
	//MessageBox ("info", il_cur_skid)
	scrap_skid_id = il_cur_skid
	//transaction dboconnect
	//dboconnect = create transaction
	//dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	//dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	//dboconnect.LogID = gs_LogID
	//dboconnect.LogPass = gs_LogPass
	//connect using SQLCA;
	//if dboconnect.SQLCode<0 then 
	//	MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
   //return
	//end if

	DECLARE p_delete procedure for f_delete_scrap_skid (:scrap_skid_id) using sqlca;
	execute p_delete;
if sqlca.SQLCode <> 0 then 
	MessageBox ("Stored Procedure Failed!!!",sqlca.sqlerrtext,exclamation!)
	return
end if
fetch p_delete INTO :li_return; 
//close p_edi;

close p_delete;
IF li_return >10000 THEN
	MessageBox("Warning", "Skid assigned to shipment " +String(li_return) + "!!! Please delete in shipment first!", StopSign! )
	return
end if
//disconnect using sqlca;
//destroy dboconnect;
	

		IF tab_scrap.tabpage_skid.dw_scrap_list.GetRow() > 0 THEN
			tab_scrap.tabpage_skid.dw_scrap_list.DeleteRow(tab_scrap.tabpage_skid.dw_scrap_list.GetRow() )
		END IF









//	ll_row = tab_scrap.tabpage_skid.dw_scrap_item.GetRow()
//	il_cur_item =  tab_scrap.tabpage_skid.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE)
//	tab_scrap.tabpage_skid.dw_scrap_list.RowsCopy(tab_scrap.tabpage_skid.dw_scrap_list.GetRow(), tab_scrap.tabpage_skid.dw_scrap_list.GetRow(), Primary!, tab_scrap.tabpage_skid.dw_editor, 1, Primary!)
//	wf_set_action(5)
//	tab_scrap.tabpage_skid.dw_editor.Event ue_del_row()

END IF
RETURN

end event

event ue_report();//tab_scrap.tabpage_skid.dw_scrap_list.Print(TRUE)
	
//	Datawindow lds_temp
//lds_temp = Message.PowerObjectParm
SetPointer(HourGlass!)

tab_scrap.tabpage_skid.dw_scrap_list.ShareData(tab_scrap.tabpage_skid.dw_report )

long ll_row_cust
String ls_cust_name, ls_mod

ll_row_cust = dw_customer.GetRow()
ls_cust_name = dw_customer.GetItemString(ll_row_cust, "customer_short_name", Primary!, TRUE)
ls_cust_name = Upper(ls_cust_name)
ls_cust_name = Trim(ls_cust_name)

ls_mod = "cust_t.Text = ~"" + ls_cust_name + "~""
tab_scrap.tabpage_skid.dw_report.Modify(ls_mod) 

//dw_report.SetFocus()

Integer	li_rtn //Alex Gerlants. 05/201/2019.

	tab_scrap.tabpage_skid.dw_report.SetFocus()
	li_rtn = Printsetup() //Alex Gerlants. 05/201/2019. Added "li_rtn = ".
	
	//Alex Gerlants. 05/201/2019.Begin
	If li_rtn = -1 Then //User clicked on "Cancel"...Just return
		Return
	End If
	//Alex Gerlants. 05/201/2019. End
	
	tab_scrap.tabpage_skid.dw_report.Print(TRUE)

end event

public function string wf_search_terms ();String ls_terms
integer li_i

ls_terms = "  WHERE ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = :customer_id ) "

//ls_terms = "  WHERE ( ~~~"SCRAP_SKID_DETAIL~~~".~~~"RETURN_SCRAP_ITEM_NUM~~~" = ~~~"RETURN_SCRAP_ITEM~~~".~~~"RETURN_SCRAP_ITEM_NUM~~~" ) and   ( ~~~"SCRAP_SKID~~~".~~~"SCRAP_SKID_NUM~~~" = ~~~"SCRAP_SKID_DETAIL~~~".~~~"SCRAP_SKID_NUM~~~" ) and  ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = :customer_id ) "
li_i = 1


DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "scrap_type"
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

public function long wf_new_scrap_skid# ();Long  ll_int_next_id
String ls_col_name

ls_col_name = 'scrap_skid_num_seq'
SELECT scrap_skid_num_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;

// generate next id using oracle sequence 
UPDATE sequence_key
SET sequence_curval = :ll_int_next_id
WHERE sequence_name = :ls_col_name
USING SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Database Error", SQLCA.SQLErrText, Exclamation!)
	ROLLBACK using SQLCA;
	Return -2
ELSE
	COMMIT using SQLCA;
END IF

Return ll_int_next_id

end function

public subroutine wf_display_total_info ();String ls_where, ls_select
Long ll_item

CONNECT USING SQLCA;
ls_select = "SELECT COUNT(scrap_skid.scrap_skid_num) FROM scrap_skid "
ls_where = wf_display_total_terms()
IF IsNULL(ls_where) THEN RETURN 

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
String ls_Mysql
ls_Mysql = ls_select + ls_where
PREPARE SQLSA FROM :ls_Mysql;
OPEN DYNAMIC my_cursor;
FETCH my_cursor INTO :ll_item;
CLOSE my_cursor ;

IF IsNULL(ll_item) THEN ll_item = 0

IF ll_item < 2 THEN
	tab_scrap.tabpage_skid.dw_scrap_list.Object.item_t.Text = String(ll_item, "#,###,###")
	tab_scrap.tabpage_skid.dw_scrap_list.Object.skid_t.Text = "scrap skid"
ELSE
	tab_scrap.tabpage_skid.dw_scrap_list.Object.item_t.Text = String(ll_item, "#,###,###")
	tab_scrap.tabpage_skid.dw_scrap_list.Object.skid_t.Text = "scrap skids"
END IF

RETURN 

end subroutine

public function string wf_display_total_terms ();String ls_terms
String ls_date, ls_op
integer li_rc
Long ll_row, ll_cust
Int li_i

SetNULL(ls_terms)
ll_row = dw_customer.GetRow()
IF ll_row <= 0 THEN RETURN ls_terms
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")

ls_terms = "  WHERE ( SCRAP_SKID.CUSTOMER_ID = " + String(ll_cust) + " ) "
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].operator <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "scrap_type"
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

public function string wf_search_terms_2 ();String ls_terms

ls_terms = "  WHERE ( ~~~"AB_JOB~~~".~~~"AB_JOB_NUM~~~" = ~~~"RETURN_SCRAP_ITEM~~~".~~~"AB_JOB_NUM~~~" ) and          ( ~~~"ORDER_ITEM~~~".~~~"ORDER_ITEM_NUM~~~" = ~~~"AB_JOB~~~".~~~"ORDER_ITEM_NUM~~~" ) and          ( ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" ) and          ( ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"ORDER_ITEM~~~".~~~"ORDER_ABC_NUM~~~" ) and          ( ( ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = :al_customer ) )  "

Return ls_terms
end function

public function string wf_display_total_terms_2 ();String ls_terms
Long ll_row, ll_customer

ll_row = dw_customer.GetRow()
ll_customer = dw_customer.GetItemNumber(ll_row, "customer_id" )

ls_terms = "  WHERE ( AB_JOB.AB_JOB_NUM  = RETURN_SCRAP_ITEM.AB_JOB_NUM) and  ( ORDER_ITEM.ORDER_ITEM_NUM =  AB_JOB.ORDER_ITEM_NUM ) and          ( ORDER_ITEM.ORDER_ABC_NUM = AB_JOB.ORDER_ABC_NUM ) and          (  CUSTOMER_ORDER.ORDER_ABC_NUM =  ORDER_ITEM.ORDER_ABC_NUM) and          ( (CUSTOMER_ORDER.ORIG_CUSTOMER_ID = " + String(ll_customer) +  ") )  "

Return ls_terms
end function

public subroutine wf_init_dwdb ();istr_dwdb[1].db_name = "SCRAP_SKID"
istr_dwdb[1].db_field = "SCRAP_TYPE"
istr_dwdb[1].dw_column = "scrap_type"
istr_dwdb[1].col_type = "scrap_type"
istr_dwdb[1].dw_header = "Scrap Type"

istr_dwdb[2].db_name = "SCRAP_SKID"
istr_dwdb[2].db_field = "SCRAP_ALLOY2"
istr_dwdb[2].dw_column = "scrap_alloy2"
istr_dwdb[2].col_type = "string"
istr_dwdb[2].dw_header = "Alloy"

istr_dwdb[3].db_name = "SCRAP_SKID"
istr_dwdb[3].db_field = "SCRAP_TEMPER"
istr_dwdb[3].dw_column = "scrap_temper"
istr_dwdb[3].col_type = "string"
istr_dwdb[3].dw_header = "Temper"

istr_dwdb[4].db_name = "SCRAP_SKID"
istr_dwdb[4].db_field = "SCRAP_NET_WT"
istr_dwdb[4].dw_column = "scrap_net_wt"
istr_dwdb[4].col_type = "number"
istr_dwdb[4].dw_header = "Net WT"

istr_dwdb[5].db_name = "SCRAP_SKID"
istr_dwdb[5].db_field = "SCRAP_TARE_WT"
istr_dwdb[5].dw_column = "scrap_tare_wt"
istr_dwdb[5].col_type = "number"
istr_dwdb[5].dw_header = "Tare"

istr_dwdb[6].db_name = "SCRAP_SKID"
istr_dwdb[6].db_field = "SCRAP_LOCATION"
istr_dwdb[6].dw_column = "scrap_location"
istr_dwdb[6].col_type = "string"
istr_dwdb[6].dw_header = "Location"

istr_dwdb[7].db_name = "SCRAP_SKID"
istr_dwdb[7].db_field = "SCRAP_DATE"
istr_dwdb[7].dw_column = "scrap_date"
istr_dwdb[7].col_type = "date"
istr_dwdb[7].dw_header = "Created Date"

istr_dwdb[8].db_name = "SCRAP_SKID"
istr_dwdb[8].db_field = "SKID_SCRAP_STATUS"
istr_dwdb[8].dw_column = "skid_scrap_status"
istr_dwdb[8].col_type = "status"
istr_dwdb[8].dw_header = "Status"

istr_dwdb[9].db_name = "SCRAP_SKID"
istr_dwdb[9].db_field = "SCRAP_SKID_NUM"
istr_dwdb[9].dw_column = "scrap_skid_num"
istr_dwdb[9].col_type = "number"
istr_dwdb[9].dw_header = "Skid"

istr_dwdb[10].db_name = "SCRAP_SKID"
istr_dwdb[10].db_field = "SCRAP_CUST_PO"
istr_dwdb[10].dw_column = "scrap_cust_po"
istr_dwdb[10].col_type = "string"
istr_dwdb[10].dw_header = "Reference"

istr_dwdb[11].db_name = "SCRAP_SKID"
istr_dwdb[11].db_field = "SCRAP_AB_JOB_NUM"
istr_dwdb[11].dw_column = "scrap_ab_job_num"
istr_dwdb[11].col_type = "string"
istr_dwdb[11].dw_header = "AB Job"

istr_dwdb[12].db_name = "SCRAP_SKID"
istr_dwdb[12].db_field = "SCRAP_NOTES"
istr_dwdb[12].dw_column = "scrap_notes"
istr_dwdb[12].col_type = "string"
istr_dwdb[12].dw_header = "Note"

istr_dwdb[13].db_name = "SCRAP_SKID"
istr_dwdb[13].db_field = "TOTE_NUM"
istr_dwdb[13].dw_column = "tote_num"
istr_dwdb[13].col_type = "number"
istr_dwdb[13].dw_header = "Tote"

istr_dwdb[14].db_name = "SCRAP_SKID"//Alex Gerlants. Tote_Trailer_Name. 06/12/2018.
istr_dwdb[14].db_field = "TRAILER_NAME"//Alex Gerlants. Tote_Trailer_Name. 06/12/2018.
istr_dwdb[14].dw_column = "trailer_name"//Alex Gerlants. Tote_Trailer_Name. 06/12/2018.
istr_dwdb[14].col_type = "string"//Alex Gerlants. Tote_Trailer_Name. 06/12/2018.
istr_dwdb[14].dw_header = "Trailer Name"//Alex Gerlants. Tote_Trailer_Name. 06/12/2018.


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

public subroutine wf_set_action (integer ai_action);IF ai_action = 0 THEN
	IF f_security_door("Scrap Handling") = 1 THEN
		cb_new.Enabled = TRUE
		cb_newitem.Enabled = TRUE
		cb_edit.Enabled = TRUE
		tab_scrap.tabpage_skid.cb_esave.Enabled = FALSE
		tab_scrap.tabpage_skid.cb_ereset.Enabled = FALSE
		cb_remove.Enabled = TRUE		
		cb_removeitem.Enabled = TRUE		
	ELSE
		This.Event ue_read_only()
	END IF
ELSE
	cb_new.Enabled = FALSE
	cb_newitem.Enabled = FALSE
	cb_edit.Enabled = FALSE
	cb_remove.Enabled = FALSE
	cb_removeitem.Enabled = TRUE		
	tab_scrap.tabpage_skid.cb_esave.Enabled = TRUE
	tab_scrap.tabpage_skid.cb_ereset.Enabled = TRUE
END IF
ii_action = ai_action
end subroutine

public function integer wf_check_info ();Long ll_row, ll_row2, ll_cust, ll_job, ll_icoil
String ls_alloy, ls_calloy
Long ll_ccust

Integer	li_rtn //Alex Gerlants. Scrap Credit
String	ls_scrap_handling_type_prev, ls_scrap_handling_type_new //Alex Gerlants. Scrap Credit

ll_row = dw_customer.GetRow()
IF ll_row > 0 THEN
	ll_cust = dw_customer.GetITemNumber(ll_row, "customer_id")
END IF

tab_scrap.tabpage_skid.dw_editor.AcceptText()
ll_row = tab_scrap.tabpage_skid.dw_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN 0
CHOOSE CASE ii_action
	CASE 1, 4  //skid
		ll_job = Long(tab_scrap.tabpage_skid.dw_editor.GetItemString(ll_row, "scrap_ab_job_num", Primary!, FALSE))
	CASE 2, 6   //item
		ll_icoil = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "return_scrap_item_coil_abc_num", Primary!, FALSE)
		ll_job = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "return_scrap_item_ab_job_num", Primary!, FALSE)
		ll_row2 = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
		IF (ll_row2 > 0) THEN
			ls_alloy = tab_scrap.tabpage_skid.dw_scrap_list.GetItemString(ll_row2, "scrap_alloy2", Primary!, FALSE)
		ELSE
			ls_alloy = ""
		END IF
END CHOOSE
IF ll_job > 0 THEN
	CONNECT USING SQLCA;
	SELECT customer_order.orig_customer_id INTO :ll_ccust
	FROM customer_order, ab_job
	WHERE ab_job.ab_job_num = :ll_job and ab_job.order_abc_num = customer_order.order_abc_num
	USING SQLCA;
	IF ll_ccust <> ll_cust THEN
		
//		//Alex Gerlants. Scrap Credit. Begin
//		li_rtn = wf_get_scrap_handling_type(ls_scrap_handling_type_prev, ls_scrap_handling_type_new)
//		
//		If li_rtn = 1 Then
//			If Lower(ls_scrap_handling_type_prev) = "scrap credit" And Lower(ls_scrap_handling_type_new) <> "scrap credit" Then
//				
//			Else
				IF MessageBox("Warning", "Job number and customer do NOT match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -1
//			End If
//		Else //DB error in wf_get_scrap_handling_type(). Error message is there too.
//			Return li_rtn
//		End if
//		
//		//IF MessageBox("Warning", "Job number and customer do NOT match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -1
//		//Alex Gerlants. Scrap Credit. End
	END IF
	SELECT order_item.alloy2 INTO :ls_calloy
	FROM order_item, ab_job
	WHERE ab_job.ab_job_num = :ll_job and ab_job.order_abc_num = order_item.order_abc_num and ab_job.order_item_num = order_item.order_item_num
	USING SQLCA;
	IF (ls_calloy <> ls_alloy) and (ls_alloy <> "") THEN
		IF MessageBox("Warning", "Job and scrap skid alloy do not match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -2
	END IF
END IF
IF ll_icoil > 0 THEN
	CONNECT USING SQLCA;
	SELECT coil_alloy2 INTO :ls_calloy
	FROM coil
	WHERE coil_abc_num = :ll_icoil
	USING SQLCA;
	IF (ls_calloy <> ls_alloy) and (ls_alloy <> "") THEN
		IF MessageBox("Warning", "Coil and scrap skid alloy do not match! Continue?", Question!, YesNo!, 2) = 2 THEN RETURN -3
	END IF	
END IF
	
RETURN 1
end function

public function long wf_get_customer_id ();//Alex Gerlants. 04/02/2017. Begin
/*
Function:	wf_get_customer_id
Return:		long <== Customer id
Arguments:	none
*/

Long 		ll_customer, ll_row
String	ls_find_string, ls_scrap_type_desc

ll_row = dw_customer.GetRow()
ll_customer = dw_customer.GetItemNumber(ll_row, "customer_id" )

Return ll_customer
//Alex Gerlants. 04/02/2017. End
end function

public function string wf_get_scrap_status_desc (integer ai_scrap_status);//Alex Gerlants. 04/02/2017. Begin
/*
Function:	wf_get_scrap_status_desc
Return:		string <== Status description
Arguments:	value	integer	ai_scrap_status
*/

Long 		ll_row, ll_customer, ll_found_row
String	ls_find_string, ls_scrap_status_desc

ls_find_string = "skid_scrap_status = " + String(ai_scrap_status)
ll_found_row = dw_scrap_status.Find(ls_find_string, 1, dw_scrap_status.RowCount())

If ll_found_row > 0 Then
	ls_scrap_status_desc = dw_scrap_status.Object.scrap_status_desc[ll_found_row]
End If

Return ls_scrap_status_desc
//Alex Gerlants. 04/02/2017. End
end function

public function string wf_get_scrap_type_desc (integer ai_scrap_type);//Alex Gerlants. 04/02/2017. Begin
/*
Function:	wf_get_scrap_type_desc
Return:		string <== Scrap type description
Arguments:	value	integer	ai_scrap_type
*/

Long 		ll_row, ll_customer, ll_found_row
String	ls_find_string, ls_scrap_type_desc

ls_find_string = "scrap_type = " + String(ai_scrap_type)
ll_found_row = dw_scrap_type.Find(ls_find_string, 1, dw_scrap_type.RowCount())

If ll_found_row > 0 Then
	ls_scrap_type_desc = dw_scrap_type.Object.scrap_type_desc[ll_found_row]
End If

Return ls_scrap_type_desc
//Alex Gerlants. 04/02/2017. End
end function

public subroutine wf_retrieve_scrap_handling (long al_row);//Alex Gerlants. Scrap Credit. Begin
/*
Function:	wf_retrieve_scrap_handling
Returns:		none
Arguments:	value			long			al_row
*/
Long		ll_ab_job_num, ll_scrap_skid_num

If IsNumber(tab_scrap.tabpage_skid.dw_scrap_list.Object.scrap_ab_job_num[al_row]) Then
	ll_ab_job_num = Long(tab_scrap.tabpage_skid.dw_scrap_list.Object.scrap_ab_job_num[al_row])
Else
	ll_ab_job_num = 0
End If

ll_scrap_skid_num = tab_scrap.tabpage_skid.dw_scrap_list.Object.scrap_skid_num[al_row]

is_scrap_handing_type = f_retrieve_scrap_handling(ll_ab_job_num, ll_scrap_skid_num, sqlca, tab_scrap.tabpage_skid.dw_editor)
//Alex Gerlants. Scrap Credit. End
end subroutine

public function integer wf_get_scrap_handling_type (ref string as_scrap_handling_type_prev, ref string as_scrap_handling_type_new);//Alex Gerlants. Scrap Credit. Begin
/*
Function:	wf_get_scrap_handling_type
Returns:		integer	 1 if ok
							-1 if DB error
Arguments:	reference	string	as_scrap_handling_type_prev
				reference	string	as_scrap_handling_type_new							
*/

Integer	li_rtn = 1
Long		ll_row, ll_scrap_skid_num //Alex Gerlants. Scrap Credit

If tab_scrap.tabpage_skid.dw_editor.DataObject = "d_scrap_skid_list_editor" Then
	ll_row = tab_scrap.tabpage_skid.dw_editor.GetRow()
	ll_scrap_skid_num = tab_scrap.tabpage_skid.dw_editor.Object.scrap_skid_num[ll_row]
	
	select	nvl(scrap_handling_type, '')
	into		:as_scrap_handling_type_prev
	from		scrap_skid
	where		scrap_skid_num = :ll_scrap_skid_num
	using		sqlca;
	
	If sqlca.sqlcode <> 0 Then //DB error
		MessageBox("DB error",	"Database error occurred in wf_get_scrap_handling_type for w_prod_scrap while retrieving " + &
										"scrap_handling_type from table scrap_skid for skid " + String(ll_scrap_skid_num) + &
										"~n~r~n~rerror:~n~r" + sqlca.sqlerrtext)
		li_rtn = -1
	End If
	
	If IsNull(as_scrap_handling_type_prev) Then as_scrap_handling_type_prev = ""
	as_scrap_handling_type_new  = tab_scrap.tabpage_skid.dw_editor.Object.scrap_handling_type[1]
Else
	as_scrap_handling_type_prev = ""
	as_scrap_handling_type_new  = ""
End If

Return li_rtn
//Alex Gerlants. Scrap Credit. End
end function

public function integer wf_get_orig_customer_id (ref long al_orig_customer_id);//Alex Gerlants. Scrap Credit. Begin
/*
Function:	wf_get_orig_customer_id
Returns:		integer	 1 if ok
							-1 if DB error
Arguments:	reference	long	al_orig_customer_id
*/
Integer	li_rtn = 1
Long		ll_row, ll_job

ll_row = tab_scrap.tabpage_skid.dw_editor.GetRow()
ll_job = Long(tab_scrap.tabpage_skid.dw_editor.Object.scrap_ab_job_num[ll_row])

select	customer_order.orig_customer_id
into		:al_orig_customer_id
from		customer_order
			join ab_job on customer_order.order_abc_num = ab_job.order_abc_num
where		ab_job.ab_job_num = :ll_job
using		sqlca;

If sqlca.sqlcode <> 0 Then //DB error
	MessageBox("DB error",	"Database error occurred in wf_get_orig_customer_id for w_prod_scrap while retrieving " + &
									"orig_customer_id from table customer_order for job " + String(ll_job) + &
									"~n~r~n~rerror:~n~r" + sqlca.sqlerrtext)
	li_rtn = -1
End If

Return li_rtn
//Alex Gerlants. Scrap Credit. End
end function

on w_prod_scrap.create
int iCurrent
call super::create
if this.MenuName = "m_prod_scrap" then this.MenuID = create m_prod_scrap
this.cb_refresh_all=create cb_refresh_all
this.dw_scrap_status=create dw_scrap_status
this.dw_scrap_type=create dw_scrap_type
this.cb_new=create cb_new
this.cb_remove=create cb_remove
this.cb_close=create cb_close
this.cb_print=create cb_print
this.dw_customer=create dw_customer
this.cb_sort=create cb_sort
this.tab_scrap=create tab_scrap
this.st_1=create st_1
this.ddlb_customer=create ddlb_customer
this.cb_search=create cb_search
this.cb_reset=create cb_reset
this.st_cond=create st_cond
this.gb_1=create gb_1
this.cb_ref=create cb_ref
this.cb_newitem=create cb_newitem
this.cb_edit=create cb_edit
this.cb_removeitem=create cb_removeitem
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_refresh_all
this.Control[iCurrent+2]=this.dw_scrap_status
this.Control[iCurrent+3]=this.dw_scrap_type
this.Control[iCurrent+4]=this.cb_new
this.Control[iCurrent+5]=this.cb_remove
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.dw_customer
this.Control[iCurrent+9]=this.cb_sort
this.Control[iCurrent+10]=this.tab_scrap
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.ddlb_customer
this.Control[iCurrent+13]=this.cb_search
this.Control[iCurrent+14]=this.cb_reset
this.Control[iCurrent+15]=this.st_cond
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.cb_ref
this.Control[iCurrent+18]=this.cb_newitem
this.Control[iCurrent+19]=this.cb_edit
this.Control[iCurrent+20]=this.cb_removeitem
end on

on w_prod_scrap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_refresh_all)
destroy(this.dw_scrap_status)
destroy(this.dw_scrap_type)
destroy(this.cb_new)
destroy(this.cb_remove)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.dw_customer)
destroy(this.cb_sort)
destroy(this.tab_scrap)
destroy(this.st_1)
destroy(this.ddlb_customer)
destroy(this.cb_search)
destroy(this.cb_reset)
destroy(this.st_cond)
destroy(this.gb_1)
destroy(this.cb_ref)
destroy(this.cb_newitem)
destroy(this.cb_edit)
destroy(this.cb_removeitem)
end on

event open;call super::open;dw_customer.Visible = FALSE

dw_customer.of_SetLinkage(TRUE)
dw_customer.inv_Linkage.of_SetStyle(2)
dw_customer.inv_linkage.of_SetConfirmOnRowChange (True)
dw_customer.inv_linkage.of_setUpdateOnRowChange (TRUE)

tab_scrap.tabpage_skid.dw_scrap_list.of_SetLinkage( TRUE ) 
tab_scrap.tabpage_skid.dw_scrap_list.inv_Linkage.of_SetMaster(dw_customer)
IF NOT tab_scrap.tabpage_skid.dw_scrap_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & scrap in win w_prod_scrap!" )
ELSE
	tab_scrap.tabpage_skid.dw_scrap_list.inv_Linkage.of_Register( "customer_id", "customer_id" ) 
	tab_scrap.tabpage_skid.dw_scrap_list.inv_Linkage.of_SetStyle( 2 ) 
END IF

tab_scrap.tabpage_rejcoil.dw_rejcoils.of_SetLinkage( TRUE ) 
tab_scrap.tabpage_rejcoil.dw_rejcoils.inv_Linkage.of_SetMaster(dw_customer)
IF NOT tab_scrap.tabpage_rejcoil.dw_rejcoils.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & rejected coils in win w_prod_scrap!" )
ELSE
	tab_scrap.tabpage_rejcoil.dw_rejcoils.inv_Linkage.of_Register( "customer_id", "coil_customer_id" ) 
	tab_scrap.tabpage_rejcoil.dw_rejcoils.inv_Linkage.of_SetStyle( 2 ) 
END IF

tab_scrap.tabpage_skid.dw_scrap_item.of_SetLinkage( TRUE ) 
tab_scrap.tabpage_skid.dw_scrap_item.inv_Linkage.of_SetMaster(tab_scrap.tabpage_skid.dw_scrap_list)
IF NOT tab_scrap.tabpage_skid.dw_scrap_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked scrap and scrap detail in win w_prod_scrap!" )
ELSE
	tab_scrap.tabpage_skid.dw_scrap_item.inv_Linkage.of_Register( "scrap_skid_num", "scrap_skid_detail_scrap_skid_num" ) 
//	tab_scrap.tabpage_skid.dw_scrap_item.inv_Linkage.of_SetStyle( 2 ) 
	tab_scrap.tabpage_skid.dw_scrap_item.inv_Linkage.of_SetStyle( tab_scrap.tabpage_skid.dw_scrap_item.inv_linkage.RETRIEVE)
END IF

dw_customer.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_customer.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_prod_scrap::open function" )
ELSE
	SQLCA.of_Commit()
	dw_customer.SelectRow(1,TRUE)
	dw_customer.SetFocus()
	wf_display_total_info()
End IF

//Alex Gerlants. Added ~~~"SCRAP_SKID~~~".~~~"SCRAP_HANDLING_TYPE~~~"
is_select = "  SELECT  ~~~"SCRAP_SKID~~~".~~~"SCRAP_TYPE~~~" ,  ~~~"SCRAP_SKID~~~".~~~"SCRAP_NET_WT~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_TARE_WT~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_LOCATION~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_DATE~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SKID_SCRAP_STATUS~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_SKID_NUM~~~" , ~~~"SCRAP_SKID~~~".~~~"SCRAP_SKID_DISPLAY_NUM~~~" ,          ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_TEMPER~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_CUST_PO~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_AB_JOB_NUM~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_NOTES~~~" ,   ~~~"SCRAP_SKID~~~".~~~"SCRAP_ALLOY2~~~", f_get_scrap_duration(scrap_skid.scrap_skid_num),           ~~~"SCRAP_SKID~~~".~~~"TOTE_NUM~~~" ,           ~~~"SCRAP_SKID~~~".~~~"TRAILER_NAME~~~" ,           ~~~"SCRAP_SKID~~~".~~~"SCRAP_HANDLING_TYPE~~~"        FROM     ~~~"SCRAP_SKID~~~"     "  





wf_init_dwdb()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)

////Alex Gerlants. 05/02/2017. Begin
//Long	ll_rows, ll_customer_id
//
//ll_customer_id = wf_get_customer_id()
//
//dw_scrap_type.SetTransObject(sqlca)
//ll_rows = dw_scrap_type.Retrieve(ll_customer_id)
//
//dw_scrap_status.SetTransObject(sqlca)
//ll_rows = dw_scrap_status.Retrieve(ll_customer_id)
////Alex Gerlants. 05/02/2017. End
end event

event pfc_new;Int li_i
Long ll_skid
li_i = MessageBox("Question","Use a existing pallet?",Question!, YesNoCancel!, 1)
IF li_i = 3 THEN RETURN
IF li_i = 1 THEN
	Open(w_select_new_scrap_skid)
	ll_skid = Message.DoubleParm
	tab_scrap.tabpage_skid.dw_editor.Event ue_addscrap(ll_skid)
	tab_scrap.tabpage_skid.dw_scrap_list.SetFilter("skid_scrap_status <> 6")
	tab_scrap.tabpage_skid.dw_scrap_list.Filter()
ELSE
	tab_scrap.tabpage_skid.dw_editor.ResetUpdate()
	tab_scrap.tabpage_skid.dw_editor.DataObject = "d_scrap_skid_list_editor"
	tab_scrap.tabpage_skid.dw_editor.SetTransObject(sqlca) 
	tab_scrap.tabpage_skid.dw_editor.Event pfc_addrow()
END IF


end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Scrap Handling") = 1 THEN
	ib_readonly = FALSE
	RETURN 1
END IF
This.Event ue_read_only()
ib_readonly = TRUE
end event

event pfc_print;PrintSetup()

Long ll_row, ll_cust
String ls_cust, ls_modstring, ls_terms, ls_desc, ls_rc
Int li_i

ll_row = dw_customer.GetRow()
IF ll_row > 0 THEN	
	li_i = 1
	DO WHILE li_i <= UpperBound(istr_search)
		IF istr_search[li_i].db_name <> "" THEN
			CHOOSE CASE istr_search[li_i].col_type
				CASE "number"
					ls_terms = ls_terms + " AND ( ~~~"" + istr_search[li_i].db_name + "~~~".~~~"" + istr_search[li_i].db_field + "~~~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				CASE "scrap_type"
					ls_terms = ls_terms + " AND ( ~~~"" + istr_search[li_i].db_name + "~~~".~~~"" + istr_search[li_i].db_field + "~~~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				CASE "status"
					ls_terms = ls_terms + " AND ( ~~~"" + istr_search[li_i].db_name + "~~~".~~~"" + istr_search[li_i].db_field + "~~~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
				CASE "date"
					ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(~~~"" + istr_search[li_i].db_name + "~~~".~~~"" + istr_search[li_i].db_field + "~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
				CASE "string"
					ls_terms = ls_terms + " AND ( ~~~"" + istr_search[li_i].db_name + "~~~".~~~"" + istr_search[li_i].db_field + "~~~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
			END CHOOSE
		END IF
		li_i++
	LOOP

	
	tab_scrap.tabpage_skid.dw_report.SetTransObject (SQLCA)  
	IF Len(ls_terms) > 2 THEN
		ls_desc = tab_scrap.tabpage_skid.dw_report.Describe("DataWindow.Table.Select")
		ls_desc = "DataWindow.Table.Select = '" + ls_desc + ls_terms + "'"
		ls_rc = tab_scrap.tabpage_skid.dw_report.Modify(ls_desc)
		IF ls_rc <> "" THEN
			MessageBox("Error","Failure to modify report: " + ls_rc , StopSign!)
			RETURN -1
		END IF
	END IF

	ls_cust = dw_customer.GetItemString(ll_row, "customer_short_name")
	ls_cust = Upper(Trim(ls_cust))
	ls_modstring = "title_t.Text = '" + ls_cust + " " + "SCRAP SKID LIST '"
	
	ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
	tab_scrap.tabpage_skid.dw_report.Retrieve(ll_cust)

	//dw_scrap_list
	//tab_scrap.tabpage_skid.dw_scrap_list.Print(TRUE)
	tab_scrap.tabpage_skid.dw_report.Print(TRUE)

END IF

RETURN 1
end event

event pfc_save;call super::pfc_save;RETURN tab_scrap.tabpage_skid.cb_esave.Event Clicked()

end event

type cb_refresh_all from commandbutton within w_prod_scrap
integer x = 3961
integer y = 1965
integer width = 391
integer height = 83
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Refresh All Tabs"
end type

event clicked;//Alex Gerlants. Scrap Credit. Begin
Long	ll_rows

ll_rows = tab_scrap.tabpage_skid.dw_scrap_list.Retrieve(il_customer_id)
ll_rows = tab_scrap.tabpage_rejcoil.dw_rejcoils.Retrieve(il_customer_id)
//Alex Gerlants. Scrap Credit. End
end event

type dw_scrap_status from datawindow within w_prod_scrap
integer x = 4374
integer y = 771
integer width = 234
integer height = 307
integer taborder = 60
string title = "none"
string dataobject = "d_dddw_scrap_status_desc_4customer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_scrap_type from datawindow within w_prod_scrap
integer x = 4374
integer y = 387
integer width = 234
integer height = 307
integer taborder = 50
string title = "none"
string dataobject = "d_dddw_scrap_type_desc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_new from u_cb within w_prod_scrap
integer x = 165
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Skid"
end type

event clicked;SetPointer(HourGlass!)
Parent.Event pfc_new()
end event

type cb_remove from u_cb within w_prod_scrap
integer x = 911
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Remove Skid"
end type

event clicked;Parent.Event ue_deleteskid()

end event

type cb_close from u_cb within w_prod_scrap
integer x = 3149
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_prod_scrap
string tag = "Scarp skid reports"
integer x = 2030
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;//Parent.Event pfc_print()
Parent.Event ue_report()
end event

type dw_customer from u_dw within w_prod_scrap
integer x = 677
integer y = 13
integer width = 88
integer height = 29
integer taborder = 10
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
end type

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event clicked;call super::clicked;SelectRow(0, FALSE)

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

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

type cb_sort from u_cb within w_prod_scrap
integer x = 2406
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ort"
end type

event clicked;SetPointer(HourGlass!)
Parent.Event ue_sort()
end event

type tab_scrap from tab within w_prod_scrap
integer x = 33
integer y = 170
integer width = 4323
integer height = 1766
integer taborder = 40
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
tabpage_rejcoil tabpage_rejcoil
end type

on tab_scrap.create
this.tabpage_skid=create tabpage_skid
this.tabpage_rejcoil=create tabpage_rejcoil
this.Control[]={this.tabpage_skid,&
this.tabpage_rejcoil}
end on

on tab_scrap.destroy
destroy(this.tabpage_skid)
destroy(this.tabpage_rejcoil)
end on

event selectionchanged;CHOOSE CASE SelectedTab
	CASE 1
		cb_search.Enabled = TRUE
		cb_reset.Enabled = TRUE		

		IF NOT(ib_readonly) THEN cb_new.Enabled = TRUE
		IF NOT(ib_readonly) THEN cb_newitem.Enabled = TRUE
		IF NOT(ib_readonly) THEN cb_sort.Enabled = TRUE
		IF NOT(ib_readonly) THEN cb_edit.Enabled = TRUE
		IF NOT(ib_readonly) THEN cb_remove.Enabled = TRUE
		IF NOT(ib_readonly) THEN cb_removeitem.Enabled = TRUE
		IF NOT(ib_readonly) THEN cb_print.Enabled = TRUE

		IF NOT(ib_readonly) THEN m_prod_scrap.m_file.m_new.Enable()
		IF NOT(ib_readonly) THEN m_prod_scrap.m_file.m_save.Enable()
		IF NOT(ib_readonly) THEN m_prod_scrap.m_file.m_delete.Enable()

	CASE 2
		cb_search.Enabled = FALSE
		cb_reset.Enabled = FALSE
		
		cb_new.Enabled = FALSE
		cb_newitem.Enabled = FALSE
		cb_sort.Enabled = FALSE
		cb_edit.Enabled = FALSE
		cb_remove.Enabled = FALSE
		cb_removeitem.Enabled = FALSE
		cb_print.Enabled = FALSE
		
		m_prod_scrap.m_file.m_new.Disable()
		m_prod_scrap.m_file.m_save.Disable()
		m_prod_scrap.m_file.m_delete.Disable()

END CHOOSE

//tab_scrap.tabpage_skid.dw_scrap_list.Event ue_resume_where()
end event

type tabpage_skid from userobject within tab_scrap
string tag = "skid"
integer x = 15
integer y = 90
integer width = 4293
integer height = 1664
long backcolor = 79741120
string text = "Scrap Skid"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "TabOrder!"
long picturemaskcolor = 553648127
dw_scrap_list dw_scrap_list
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
dw_scrap_item dw_scrap_item
st_8 st_8
st_9 st_9
dw_editor dw_editor
cb_esave cb_esave
cb_ereset cb_ereset
dw_report dw_report
end type

on tabpage_skid.create
this.dw_scrap_list=create dw_scrap_list
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.dw_scrap_item=create dw_scrap_item
this.st_8=create st_8
this.st_9=create st_9
this.dw_editor=create dw_editor
this.cb_esave=create cb_esave
this.cb_ereset=create cb_ereset
this.dw_report=create dw_report
this.Control[]={this.dw_scrap_list,&
this.st_2,&
this.st_3,&
this.st_4,&
this.st_5,&
this.st_6,&
this.st_7,&
this.dw_scrap_item,&
this.st_8,&
this.st_9,&
this.dw_editor,&
this.cb_esave,&
this.cb_ereset,&
this.dw_report}
end on

on tabpage_skid.destroy
destroy(this.dw_scrap_list)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.dw_scrap_item)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.dw_editor)
destroy(this.cb_esave)
destroy(this.cb_ereset)
destroy(this.dw_report)
end on

type dw_scrap_list from u_dw within tabpage_skid
event ue_resume_where ( )
event type integer ue_search_retrieve ( )
event ue_goto_row ( )
integer x = 26
integer y = 19
integer width = 4217
integer height = 858
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_scrap_skid_list"
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_resume_where();String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_where = "  WHERE ( ~~~"SCRAP_SKID_DETAIL~~~".~~~"RETURN_SCRAP_ITEM_NUM~~~" = ~~~"RETURN_SCRAP_ITEM~~~".~~~"RETURN_SCRAP_ITEM_NUM~~~" ) and   ( ~~~"SCRAP_SKID~~~".~~~"SCRAP_SKID_NUM~~~" = ~~~"SCRAP_SKID_DETAIL~~~".~~~"SCRAP_SKID_NUM~~~" ) and  ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = :customer_id ) "
ls_where = "  WHERE ( ~~~"SCRAP_SKID~~~".~~~"CUSTOMER_ID~~~" = :customer_id ) "

ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)

String ls_sql

ls_sql = This.GetSqlSelect()

IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	this.of_Retrieve()
	wf_display_total_info()	
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

end event

event type integer ue_search_retrieve();String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net
String	ls_sql //Alex Gerlants. 05/02/2015

ls_where = wf_search_terms()

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	
	ls_sql = This.GetSqlSelect() //Alex Gerlants. 05/02/2015
	
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

Return 1
end event

event ue_goto_row;Long ll_crow, ll_trow, ll_i

IF il_cur_skid <= 0 THEN RETURN

ll_trow = RowCount()
IF ll_trow > 0 THEN
	ll_crow = 0
	FOR ll_i = 1 TO ll_trow
		IF GetItemNumber(ll_i, "scrap_skid_num", Primary!, FALSE) = il_cur_skid THEN
			ll_crow = ll_i
		END IF
	NEXT
	IF ll_crow > 0 THEN
		SelectRow(0, False)
		SelectRow(ll_crow, True)
		SetRow(ll_crow)
		ScrollToRow(ll_crow)
	END IF
END IF


end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

this.SetFilter("skid_scrap_status <> 6")
this.Filter()


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

//---
//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. Begin
String 	ls_old_sort, ls_column, ls_name
Char 		lc_sort

ls_name = dwo.Name

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)

	/* Get old sort, If any. */
	ls_old_sort = This.Describe("Datawindow.Table.sort")

	//Check whether previously sorted column and currently clicked column are same or not. 
	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
	//If both are not same, simply sort it by Ascending order.
	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
		lc_sort = Right(ls_old_sort, 1)

		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		  
		This.SetSort(ls_column + " " + lc_sort)
	Else
		This.SetSort(ls_column + " A")
	End If

	This.Sort()
End If
//Alex Gerlants. Tote_Trailer_Name. 06/12/2018. End
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

//il_cur_skid = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(lI_row, "scrap_skid_num", Primary!, FALSE)
	
//tab_scrap.tabpage_skid.dw_scrap_item.Retrieve(il_cur_skid)

Return 

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event getfocus;call super::getfocus;ii_dw_flag = 1
tab_scrap.tabpage_skid.dw_editor.ResetUpdate()
tab_scrap.tabpage_skid.dw_editor.DataObject = "d_scrap_skid_list_editor"
tab_scrap.tabpage_skid.dw_editor.SetTransObject(sqlca) 


end event

type st_2 from statictext within tabpage_skid
integer x = 1979
integer y = 896
integer width = 351
integer height = 58
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

type st_3 from statictext within tabpage_skid
integer x = 2330
integer y = 896
integer width = 135
integer height = 58
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

type st_4 from statictext within tabpage_skid
integer x = 2512
integer y = 896
integer width = 252
integer height = 58
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

type st_5 from statictext within tabpage_skid
integer x = 2798
integer y = 896
integer width = 208
integer height = 58
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

type st_6 from statictext within tabpage_skid
integer x = 3313
integer y = 896
integer width = 216
integer height = 58
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

type st_7 from statictext within tabpage_skid
integer x = 3024
integer y = 896
integer width = 252
integer height = 58
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

type dw_scrap_item from u_dw within tabpage_skid
integer x = 15
integer y = 944
integer width = 4217
integer height = 307
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_return_scrap_item"
boolean hscrollbar = true
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


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

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event getfocus;call super::getfocus;ii_dw_flag = 2
tab_scrap.tabpage_skid.dw_editor.ResetUpdate()
tab_scrap.tabpage_skid.dw_editor.DataObject = "d_return_scrap_item_editor"
tab_scrap.tabpage_skid.dw_editor.SetTransObject(sqlca) 

end event

type st_8 from statictext within tabpage_skid
integer x = 11
integer y = 890
integer width = 457
integer height = 58
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
string text = "Scrap Skid Item List:"
boolean focusrectangle = false
end type

type st_9 from statictext within tabpage_skid
integer x = 15
integer y = 1248
integer width = 252
integer height = 48
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
string text = "Editor:"
boolean focusrectangle = false
end type

type dw_editor from u_dw within tabpage_skid
event type integer ue_additem ( )
event type integer ue_addscrap ( long al_skid )
event type integer ue_del_row ( )
event type integer ue_modify ( )
event keypressed pbm_dwnkey
integer x = 15
integer y = 1296
integer width = 4217
integer height = 237
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_return_scrap_item_editor"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_additem;Long ll_item, ll_row
Int li_status

ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return 0
li_status = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to add item to this skid because it has been shipped to customer already!", StopSign!)
	RETURN 0
END IF
il_cur_skid = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)

ll_row = this.Insertrow(0)
ll_item = f_get_next_value("return_scrap_item_id_seq")

SetItem(ll_row, "return_scrap_item_return_scrap_item_num", ll_item)
SetItem(ll_row, "return_scrap_item_return_item_date", Today())

wf_set_action(2)

Return ll_item


end event

event ue_addscrap;Long ll_row, ll_i, ll_new_skid, ll_row_cut, ll_c_id
Int li_cut_status

IF al_skid < 1 THEN Return 0

SetFilter("")
Filter()

ll_row = this.RowCount()
IF ll_row <= 0 THEN Return 0

FOR ll_i = 1 TO ll_row 
	ll_new_skid = this.GetItemNumber(ll_i, "Scrap_skid_num" )
	IF ll_new_skid = al_skid THEN
		li_cut_status = this.GetItemNumber(ll_i,"skid_scrap_status")
		IF li_cut_status <> 6 THEN 
			this.SetFilter("skid_scrap_status <> 6")
			this.Filter()
			MessageBox("Error","This pallet has been used already!", StopSign!)
			Return 0
		END IF
		this.SetItem(ll_i, "skid_scrap_status", 2)
		ll_row_cut = dw_customer.GetRow()
		ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
		SetItem(ll_i, "customer_id", ll_c_id)
		SetItem(ll_i, "scrap_date", Today() )
		Return 0
	END IF
NEXT

RETURN al_skid
end event

event ue_del_row;IF MessageBox("Warning","About to delete the item in editor box, are you sure?", Question!, OKCancel!, 2) = 1 THEN
	tab_scrap.tabpage_skid.cb_esave.Event Clicked()
ELSE
	tab_scrap.tabpage_skid.dw_editor.ResetUpdate()
	tab_scrap.tabpage_skid.dw_editor.Reset()
	wf_set_action(0)
END IF
RETURN 1

end event

event type integer ue_modify();Long ll_row
Int li_status

ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
IF ll_row < 1 THEN Return -1
li_status = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN 0
END IF

//Messagebox("info", ii_dw_flag)

CHOOSE CASE ii_dw_flag
	CASE 1  //scrap skid
		tab_scrap.tabpage_skid.dw_scrap_list.RowsCopy(tab_scrap.tabpage_skid.dw_scrap_list.GetRow(), tab_scrap.tabpage_skid.dw_scrap_list.GetRow(), Primary!, tab_scrap.tabpage_skid.dw_editor, 1, Primary!)
		wf_set_action(4)
		
		wf_retrieve_scrap_handling(ll_row) //Alex Gerlants. Scrap Credit
	CASE 2  //scrap item
		tab_scrap.tabpage_skid.dw_scrap_item.RowsCopy(tab_scrap.tabpage_skid.dw_scrap_item.GetRow(), tab_scrap.tabpage_skid.dw_scrap_item.GetRow(), Primary!, tab_scrap.tabpage_skid.dw_editor, 1, Primary!)
		wf_set_action(6)
END CHOOSE

RETURN ll_row
end event

event keypressed;//Alex Gerlants. 10/03/2019. Scrap Edit Paste Enable
end event

event itemchanged;call super::itemchanged;String ls_colName, ls_po, ls_epo
Long ll_row, ll_job, ll_cust, ll_num, ll_order, ll_custrow, ll_id
DateTime ld_s, ld_e
Int li_item, li_line

SetNull(ll_id)
ls_ColName = this.GetColumnName()
IF ls_ColName = "return_scrap_item_ab_job_num" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_job = this.GetItemNumber(ll_row,"return_scrap_item_ab_job_num" ,Primary!, FALSE)

	ll_num = 0
	CONNECT USING SQLCA;
	SELECT Count(ab_job_num)
	INTO :ll_num
	FROM ab_job
	WHERE ab_job_num = :ll_job
	USING SQLCA;
		IF ll_num <> 1 THEN
		MessageBox("Warning", "Invalid job number!", StopSign!)
		//wf_reset_item_info(ll_row)
		RETURN -1
	END IF

	SELECT order_abc_num, order_item_num, time_date_started, time_date_finished, line_num
	INTO :ll_order, :li_item, :ld_s, :ld_e, :li_line
	FROM ab_job
	WHERE ab_job_num = :ll_job
	USING SQLCA;
	
	SELECT orig_customer_id, enduser_po, orig_customer_po INTO :ll_cust, :ls_epo, :ls_po
	FROM customer_order
	WHERE order_abc_num = :ll_order
	USING SQLCA;
	ll_custrow = dw_customer.Getrow()
	IF ll_cust <> dw_customer.GetItemNumber(ll_custrow, "customer_id") THEN
		MessageBox("Warning", "This is other customer's job!", StopSign!)
		//wf_reset_item_info(ll_row)
		RETURN -2
	END IF

	SetItem(ll_row, "ab_job_line_num", li_line)
	SetItem(ll_row, "ab_job_time_date_started", ld_s)
	SetItem(ll_row, "ab_job_time_date_finished", ld_e)
	SetItem(ll_row, "customer_order_orig_customer_id", ll_cust)
	SetItem(ll_row, "customer_order_enduser_po", ls_epo)
	SetItem(ll_row, "customer_order_orig_customer_po", ls_po)


END IF

end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//Override
//RETURN 1

Return 0 //Disable. Alex Gerlants. 10/01/2019
end event

event rbuttonup;//Override
//RETURN 1

Return 0 //Disable. Alex Gerlants. 10/01/2019
end event

event pfc_addrow;call super::pfc_addrow;long ll_row_skid, ll_new_id, ll_row_cut, ll_c_id, ll_prev_row
Int li_i
Long ll_long
Int li_int
Real lr_real
String ls_s

ll_row_skid = this.GetRow()
ll_row_cut = dw_customer.GetRow()
ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id")
SetItem(ll_row_skid, "customer_id", ll_c_id)

ll_new_id = f_get_next_value("scrap_skid_num_seq")

SetItem(ll_row_skid, "scrap_skid_num", ll_new_id)
SetItem(ll_row_skid, "skid_scrap_status", 2 )
SetItem(ll_row_skid, "scrap_date", Today() )
SetItem(ll_row_skid, "scrap_tare_wt", 0 )

ll_prev_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
IF ll_prev_row > 0 THEN
	li_int = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_prev_row, "scrap_type", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_type", li_int)
	ls_s = tab_scrap.tabpage_skid.dw_scrap_list.GetItemString(ll_prev_row, "scrap_ab_job_num", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_ab_job_num", ls_s)
	ls_s = tab_scrap.tabpage_skid.dw_scrap_list.GetItemString(ll_prev_row, "scrap_alloy2", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_alloy2", ls_s)
	ls_s = tab_scrap.tabpage_skid.dw_scrap_list.GetItemString(ll_prev_row, "scrap_temper", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_temper", ls_s)
	ls_s = tab_scrap.tabpage_skid.dw_scrap_list.GetItemString(ll_prev_row, "scrap_cust_po", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_cust_po", ls_s)
	ls_s = tab_scrap.tabpage_skid.dw_scrap_list.GetItemString(ll_prev_row, "scrap_notes", Primary!, FALSE)
	SetItem(ll_row_skid, "scrap_notes", ls_s)
END IF

wf_set_action(1)

Return ll_row_skid
end event

event clicked;Return 0 //Alex Gerlants. 10/03/2019. Scrap Edit Paste Enable
end event

type cb_esave from u_cb within tabpage_skid
integer x = 4012
integer y = 1584
integer width = 263
integer height = 64
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Save"
end type

event clicked;SetPointer(HourGlass!)
Int li_rc
Long ll_skid, ll_item, ll_row, ll_i

Long ll_snet, ll_stare, ll_scust, ll_cur_net, item_total_net
Int li_sstatus, li_itype 
DateTime ld_sdate
String ls_stemper, ls_spo, ls_location, ls_salloy, ls_snotes, ls_sjob

Long ll_inet, ll_icoil, ll_ijob
DateTime ld_idate
String ls_inotes

//Added by Victor Huang in 10/05 for tote number handling
Int li_tote_num

String	ls_trailer_name //Alex Gerlants. Tote_Trailer_Name. 06/12/2018

String	ls_scrap_handling_type //Alex Gerlants. Scrap Credit
Long		ll_abc_customer_id //Alex Gerlants. Scrap Credit
Integer	li_answer //Alex Gerlants. Scrap Credit

Integer	li_rtn //Alex Gerlants. Scrap Credit
Long		ll_orig_customer_id //Alex Gerlants. Scrap Credit
String	ls_scrap_handling_type_prev, ls_scrap_handling_type_new //Alex Gerlants. Scrap Credit

IF wf_check_info() < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF





tab_scrap.tabpage_skid.dw_editor.AcceptText()
ll_row = tab_scrap.tabpage_skid.dw_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN -2
CHOOSE CASE ii_action
	CASE 1,5,4  //skid
		ll_scust = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
		ll_skid = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
		ll_snet = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
		ll_stare = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "scrap_tare_wt", Primary!, FALSE)
		ls_sjob = tab_scrap.tabpage_skid.dw_editor.GetItemString(ll_row, "scrap_ab_job_num", Primary!, FALSE)
		li_sstatus = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "skid_scrap_status", Primary!, FALSE)
		ld_sdate = tab_scrap.tabpage_skid.dw_editor.GetItemDateTime(ll_row, "scrap_date", Primary!, FALSE)
		li_itype = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "scrap_type", Primary!, FALSE)
		ls_stemper = tab_scrap.tabpage_skid.dw_editor.GetItemString(ll_row, "scrap_temper", Primary!, FALSE)
		ls_spo = tab_scrap.tabpage_skid.dw_editor.GetItemString(ll_row, "scrap_cust_po", Primary!, FALSE)
		ls_location = tab_scrap.tabpage_skid.dw_editor.GetItemString(ll_row, "scrap_location", Primary!, FALSE)
		ls_snotes = tab_scrap.tabpage_skid.dw_editor.GetItemString(ll_row, "scrap_notes", Primary!, FALSE)
		ls_salloy = tab_scrap.tabpage_skid.dw_editor.GetItemString(ll_row, "scrap_alloy2", Primary!, FALSE)
		
		//Added by Victor Huang in 10/05 for tote number handling
		li_tote_num = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "tote_num", Primary!, FALSE)
		
		ls_trailer_name = tab_scrap.tabpage_skid.dw_editor.Object.trailer_name[ll_row] //Alex Gerlants. Tote_Trailer_Name. 06/12/2018
		ls_scrap_handling_type = tab_scrap.tabpage_skid.dw_editor.Object.scrap_handling_type[ll_row] //Alex Gerlants. Scrap Credit
		
	CASE 2,3,6   //item
		ll_item = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE)
		ll_icoil = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "return_scrap_item_coil_abc_num", Primary!, FALSE)
		IF ll_icoil = 0 THEN SetNULL(ll_icoil)
		ll_ijob = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "return_scrap_item_ab_job_num", Primary!, FALSE)
		ll_inet = tab_scrap.tabpage_skid.dw_editor.GetItemNumber(ll_row, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		ld_idate = tab_scrap.tabpage_skid.dw_editor.GetItemDateTime(ll_row, "return_scrap_item_return_item_date", Primary!, FALSE)
		ls_snotes = tab_scrap.tabpage_skid.dw_editor.GetItemString(ll_row, "return_scrap_item_return_item_notes", Primary!, FALSE)
END CHOOSE



ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
IF  (ll_row < 1) AND (ii_action <> 1) THEN
	Messagebox("You did not select a skid", "Please select a skid!!")
	RETURN -1
END IF

IF ii_action <> 1 THEN
il_cur_skid = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE)
END IF



//checking values
CHOOSE CASE ii_action
	CASE 1 //new skid
//		IF ll_snet <> ll_inet THEN
//			IF MessageBox("Question", "Skid net weight does not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
//		END IF
	CASE 2 //new item
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -2
	CASE 3 //delete item
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -3
	CASE 4 //modify skid
		//ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
		//ll_cur_net = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
		
		li_rc = tab_scrap.tabpage_skid.dw_scrap_item.RowCount()
		IF (li_rc < 1) OR IsNULL(li_rc) THEN 
			Messagebox("Warning!", "No item seleted!")
			RETURN 0
		END IF
		item_total_net = 0
		FOR ll_i = 1 TO li_rc
			item_total_net = item_total_net + tab_scrap.tabpage_skid.dw_scrap_item.GetItemNumber(ll_i, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		NEXT
		IF ll_snet <> item_total_net THEN
			Messagebox("Net weight did not add up right!!", "Please Modify item net weight first!!")
			RETURN 0
		END IF
		//IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -4
	CASE 5 //del skid
	CASE 6 //modify item
END CHOOSE


CONNECT USING SQLCA;
CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		ll_ijob = Long(ls_sjob)
		ll_item = f_get_next_value("return_scrap_item_id_seq")
		SetNULL(ll_icoil)
		
		//Alex Gerlants. Scrap Credit. Begin
		If Lower(ls_scrap_handling_type) = "scrap credit" Then
			li_answer = MessageBox("Confirmation","Please confirm saving scrap skid #" + String(ll_skid) + " as scrap credit.", Question!, YesNo!)
			
			If li_answer = 2 Then //No
				Return 0
			End If
			
			ll_abc_customer_id = 1054
			
			INSERT INTO scrap_skid (scrap_skid_num, customer_id, scrap_type, scrap_temper, scrap_net_wt, scrap_tare_wt, scrap_cust_po, scrap_ab_job_num, scrap_location,scrap_date, skid_scrap_status, scrap_notes, scrap_alloy2, tote_num, trailer_name,  scrap_handling_type)
			VALUES (:ll_skid, :ll_abc_customer_id, :li_itype, :ls_stemper,:ll_snet, :ll_stare, :ls_spo, :ls_sjob, :ls_location, :ld_sdate, :li_sstatus, :ls_snotes, :ls_salloy, :li_tote_num, :ls_trailer_name, :ls_scrap_handling_type)
			USING SQLCA;
		Else //Not Scrap Credit. Alex Gerlants. Scrap Credit. End
			INSERT INTO scrap_skid (scrap_skid_num, customer_id, scrap_type, scrap_temper, scrap_net_wt, scrap_tare_wt, scrap_cust_po, scrap_ab_job_num, scrap_location,scrap_date, skid_scrap_status, scrap_notes, scrap_alloy2, tote_num, trailer_name,  scrap_handling_type)
			VALUES (:ll_skid, :ll_scust, :li_itype, :ls_stemper,:ll_snet, :ll_stare, :ls_spo, :ls_sjob, :ls_location, :ld_sdate, :li_sstatus, :ls_snotes, :ls_salloy, :li_tote_num, :ls_trailer_name, :ls_scrap_handling_type)
			USING SQLCA;
		End If //Alex Gerlants. Scrap Credit. 
		
		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: scrap skid table" )
			RETURN -5
		END IF
		INSERT INTO return_scrap_item (return_scrap_item_num, coil_abc_num , ab_job_num , return_item_net_wt, return_item_date, return_item_notes)
		VALUES (:ll_item, :ll_icoil, :ll_ijob, :ll_snet, :ld_sdate, :ls_inotes)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function:  scrap skid item table" )
			RETURN -5
		END IF
		INSERT INTO scrap_skid_detail
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid detail table" )
			RETURN -5
		END IF
	CASE 2	//new item
		INSERT INTO return_scrap_item (return_scrap_item_num, coil_abc_num , ab_job_num , return_item_net_wt, return_item_date, return_item_notes)
		VALUES (:ll_item, :ll_icoil, :ll_ijob, :ll_inet, :ld_idate, :ls_inotes)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function:  scrap skid item table" )
			RETURN -5
		END IF
		INSERT INTO scrap_skid_detail
		VALUES (:il_cur_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function: skid detail table" )
			RETURN -5
		END IF
		
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt + :ll_inet
		WHERE SCRAP_SKID_NUM = :il_cur_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert item function: scrap skid table" )
			RETURN -5
		END IF
		
	CASE 3	//delete item
		DELETE FROM scrap_skid_detail
		WHERE scrap_skid_num = :il_cur_skid AND return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: skid detail table" )
			RETURN -5
		END IF
		DELETE FROM return_scrap_item
		WHERE return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: skid item table" )
			RETURN -5
		END IF
		
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt - :ll_inet
		WHERE SCRAP_SKID_NUM = :il_cur_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: scrap skid table" )
			RETURN -5
		END IF
		
		
		
	CASE 4	//modify skid
		//Alex Gerlants. Scrap Credit. Begin
		li_rtn = wf_get_scrap_handling_type(ls_scrap_handling_type_prev, ls_scrap_handling_type_new)
		
		If li_rtn = -1 Then
			Return -1
		End If
				
		If Lower(ls_scrap_handling_type_new) = "scrap credit" And Lower(ls_scrap_handling_type_prev) <> "scrap credit" Then
			//User is changing to "Scrap Credit" scrap_handing_type from another scrap_handing_type
			li_answer = MessageBox("Confirmation","Please confirm converting scrap skid #" + String(ll_skid) + " into scrap credit.", Question!, YesNo!)
			
			If li_answer = 2 Then //No
				Return 0
			End If
			
			ll_abc_customer_id = 1054
			
			update	scrap_skid
			set		customer_id = :ll_abc_customer_id, scrap_type = :li_itype, scrap_temper = :ls_stemper, scrap_net_wt = :ll_snet, scrap_tare_wt = :ll_stare, scrap_cust_po = :ls_spo, scrap_ab_job_num = :ls_sjob, scrap_location = :ls_location, scrap_date = :ld_sdate, skid_scrap_status = :li_sstatus, scrap_notes = :ls_snotes, scrap_alloy2 = :ls_salloy, tote_num = :li_tote_num, trailer_name = :ls_trailer_name, scrap_handling_type = :ls_scrap_handling_type
			where		scrap_skid_num = :ll_skid
			using		sqlca;
			
			If sqlca.sqlcode = 0 Then //OK
				commit using sqlca;
				MessageBox("Info", "Data had been saved.")
			Else //DB error
				rollback using sqlca;
				MessageBox("Error",	"Database error in Clicked event for tab_scrap.tabpage_skid.cb_esave of w_prod_scrap " + &
											"while updating table scrap_skid for skid " + String(ll_skid) + &
											"~n~r~n~rError:~n~r" + sqlca.sqlerrtext)
			End If
			
			tab_scrap.tabpage_skid.dw_scrap_list.Retrieve(ll_scust) //Re-retrieve. Thus this skid will disappear from ABC customer
			GoTo CONT
		Else
			If Lower(ls_scrap_handling_type_prev) = "scrap credit" And Lower(ls_scrap_handling_type_new) <> "scrap credit" Then
				//User is changing to another scrap_handing_type from "Scrap Credit" scrap_handing_type
				li_rtn = wf_get_orig_customer_id(ll_orig_customer_id)
				
				If li_rtn = 1 Then //OK in wf_get_orig_customer_id()
					update	scrap_skid
					set		customer_id = :ll_orig_customer_id, scrap_type = :li_itype, scrap_temper = :ls_stemper, scrap_net_wt = :ll_snet, scrap_tare_wt = :ll_stare, scrap_cust_po = :ls_spo, scrap_ab_job_num = :ls_sjob, scrap_location = :ls_location, scrap_date = :ld_sdate, skid_scrap_status = :li_sstatus, scrap_notes = :ls_snotes, scrap_alloy2 = :ls_salloy, tote_num = :li_tote_num, trailer_name = :ls_trailer_name, scrap_handling_type = :ls_scrap_handling_type
					where		scrap_skid_num = :ll_skid
					using		sqlca;
					
					If sqlca.sqlcode = 0 Then //OK
						commit using sqlca;
						MessageBox("Info", "Data had been saved.")
					Else //DB error
						rollback using sqlca;
						MessageBox("Error",	"Database error in Clicked event for tab_scrap.tabpage_skid.cb_esave of w_prod_scrap " + &
													"while updating table scrap_skid for skid " + String(ll_skid) + &
													"~n~r~n~rError:~n~r" + sqlca.sqlerrtext)
					End If
					
					tab_scrap.tabpage_skid.dw_scrap_list.Retrieve(ll_scust) //Re-retrieve. Thus this skid will disappear from ABC customer
					GoTo CONT
				Else //DB error in wf_get_orig_customer_id(). Error message is there
					Return -1
				End If
			Else //User is not changing scrap_handling_type; but changing other attributes of a skid
			//Alex Gerlants. Scrap Credit. End
				//This is the original statement
				UPDATE scrap_skid
				SET customer_id = :ll_scust, scrap_type = :li_itype, scrap_temper = :ls_stemper, scrap_net_wt = :ll_snet, scrap_tare_wt = :ll_stare, scrap_cust_po = :ls_spo, scrap_ab_job_num = :ls_sjob, scrap_location = :ls_location, scrap_date = :ld_sdate, skid_scrap_status = :li_sstatus, scrap_notes = :ls_snotes, scrap_alloy2 = :ls_salloy, tote_num = :li_tote_num, trailer_name = :ls_trailer_name, scrap_handling_type = :ls_scrap_handling_type
				WHERE scrap_skid_num = :ll_skid
				USING SQLCA;
			End If //Alex Gerlants. Scrap Credit
		End If //Alex Gerlants. Scrap Credit
		
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF			
	CASE 5	//delete skid
		DELETE FROM scrap_skid_detail
		WHERE scrap_skid_num = :ll_skid AND return_scrap_item_num = :il_cur_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: scrap skid detail table" )
			RETURN -5
		END IF
 		DELETE FROM return_scrap_item
		WHERE return_scrap_item_num = :il_cur_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: scrap skid item table" )
			RETURN -5
		END IF
		DELETE FROM scrap_skid
		WHERE scrap_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: skid table" )
			RETURN -5
		END IF
	CASE 6	//modify item
		ll_row = tab_scrap.tabpage_skid.dw_scrap_item.GetRow()
		ll_cur_net = tab_scrap.tabpage_skid.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_item_net_wt", Primary!, FALSE)
		//Messagebox("current net wt", ll_cur_net)
		ll_cur_net = ll_inet - ll_cur_net
		//Messagebox("net wt diff", ll_cur_net)
		
		UPDATE return_scrap_item
		SET coil_abc_num = :ll_icoil, ab_job_num = :ll_ijob, return_item_net_wt = :ll_inet, return_item_date = :ld_idate, return_item_notes = :ls_inotes
		WHERE return_scrap_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF
		
		//Messagebox("current skid", il_cur_skid)
		UPDATE scrap_skid SET scrap_net_wt = scrap_net_wt + :ll_cur_net
		WHERE SCRAP_SKID_NUM = :il_cur_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify item function: scrap skid table" )
			RETURN -5
		END IF
		
		//tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet)
		
		
END CHOOSE

COMMIT USING SQLCA;

MessageBox("Info", "Data had been saved.")

CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		tab_scrap.tabpage_skid.dw_editor.RowsCopy(tab_scrap.tabpage_skid.dw_editor.GetRow(), tab_scrap.tabpage_skid.dw_editor.GetRow(), Primary!, tab_scrap.tabpage_skid.dw_scrap_list, (tab_scrap.tabpage_skid.dw_scrap_list.RowCount() + 1), Primary!)		
	CASE 2	//new item
		tab_scrap.tabpage_skid.dw_editor.RowsCopy(tab_scrap.tabpage_skid.dw_editor.GetRow(), tab_scrap.tabpage_skid.dw_editor.GetRow(), Primary!, tab_scrap.tabpage_skid.dw_scrap_item, (tab_scrap.tabpage_skid.dw_scrap_item.RowCount() + 1), Primary!)		
			ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
			ll_cur_net = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
			tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_cur_net + ll_inet)
	CASE 3	//delete item
		IF tab_scrap.tabpage_skid.dw_scrap_item.GetRow() > 0 THEN
			tab_scrap.tabpage_skid.dw_scrap_item.DeleteRow(tab_scrap.tabpage_skid.dw_scrap_item.GetRow() )
			ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
			ll_cur_net = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
			tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_cur_net - ll_inet)
		END IF
	CASE 4	//modify skid
		ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
		IF ll_row > 0 THEN
			IF ll_skid = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_skid_num", Primary!, FALSE) THEN		
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_tare_wt",ll_stare)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_ab_job_num",ls_sjob)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "skid_scrap_status", li_sstatus)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_date",ld_sdate) 
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_type", li_itype)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_temper",ls_stemper)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_cust_po",ls_spo)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_location", ls_location)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_notes",ls_snotes)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_alloy2",ls_salloy)
				tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "tote_num",ls_salloy)
				tab_scrap.tabpage_skid.dw_scrap_list.Object.trailer_name[ll_row] = ls_trailer_name //Alex Gerlants. Tote_Trailer_Name. 06/12/2018
				tab_scrap.tabpage_skid.dw_scrap_list.Object.scrap_handling_type[ll_row] = ls_scrap_handling_type //Alex Gerlants. Scrap Credit
				
				tab_scrap.tabpage_skid.dw_scrap_list.SetItemStatus(ll_row, 01, Primary!, NotModified!) //Alex Gerlants. Scrap Credit. Thus it will not ask to save
			END IF
		END IF
	CASE 5	//delete skid
		IF tab_scrap.tabpage_skid.dw_scrap_list.GetRow() > 0 THEN
			tab_scrap.tabpage_skid.dw_scrap_list.DeleteRow(tab_scrap.tabpage_skid.dw_scrap_list.GetRow() )
		END IF
	CASE 6   //modify item
		ll_row = tab_scrap.tabpage_skid.dw_scrap_list.GetRow()
		ll_snet = tab_scrap.tabpage_skid.dw_scrap_list.GetItemNumber(ll_row, "scrap_net_wt", Primary!, FALSE)
		tab_scrap.tabpage_skid.dw_scrap_list.SetItem(ll_row, "scrap_net_wt", ll_snet + ll_cur_net)
		
		ll_row = tab_scrap.tabpage_skid.dw_scrap_item.GetRow()
		IF ll_row > 0 THEN
			IF ll_item = tab_scrap.tabpage_skid.dw_scrap_item.GetItemNumber(ll_row, "return_scrap_item_return_scrap_item_num", Primary!, FALSE) THEN
				tab_scrap.tabpage_skid.dw_scrap_item.SetItem(ll_row, "return_scrap_item_coil_abc_num", ll_icoil)
				tab_scrap.tabpage_skid.dw_scrap_item.SetItem(ll_row, "return_scrap_item_ab_job_num", ll_ijob)
				tab_scrap.tabpage_skid.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_net_wt",ll_inet)
				tab_scrap.tabpage_skid.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_date", ld_idate)
				tab_scrap.tabpage_skid.dw_scrap_item.SetItem(ll_row, "return_scrap_item_return_item_notes", ls_snotes)
				
			END IF
		END IF
END CHOOSE

CONT: //Alex Gerlants. Scrap Credit
tab_scrap.tabpage_skid.dw_scrap_list.ResetUpdate()
tab_scrap.tabpage_skid.dw_scrap_item.ResetUpdate()
tab_scrap.tabpage_skid.dw_scrap_list.Event ue_goto_row()


tab_scrap.tabpage_skid.dw_editor.ResetUpdate()
tab_scrap.tabpage_skid.dw_editor.Reset()
wf_set_action(0)

RETURN 1


end event

type cb_ereset from u_cb within tabpage_skid
integer x = 3694
integer y = 1581
integer width = 263
integer height = 64
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Cancel"
end type

event clicked;tab_scrap.tabpage_skid.dw_editor.ResetUpdate()
tab_scrap.tabpage_skid.dw_editor.Reset()
wf_set_action(0)
end event

type dw_report from u_dw within tabpage_skid
boolean visible = false
integer x = 3306
integer y = 1341
integer width = 154
integer height = 35
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_report_scrap_list"
boolean livescroll = false
end type

type tabpage_rejcoil from userobject within tab_scrap
integer x = 15
integer y = 90
integer width = 4293
integer height = 1664
long backcolor = 79741120
string text = "Rejected Coil"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "CheckStatus!"
long picturemaskcolor = 553648127
dw_rejcoils dw_rejcoils
end type

on tabpage_rejcoil.create
this.dw_rejcoils=create dw_rejcoils
this.Control[]={this.dw_rejcoils}
end on

on tabpage_rejcoil.destroy
destroy(this.dw_rejcoils)
end on

type dw_rejcoils from u_dw within tabpage_rejcoil
integer x = 18
integer y = 10
integer width = 3515
integer height = 1517
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_coil_cust_rejected"
end type

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type st_1 from statictext within w_prod_scrap
integer x = 33
integer y = 13
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
long backcolor = 67108864
boolean enabled = false
string text = "Current customer:"
boolean focusrectangle = false
end type

type ddlb_customer from dropdownlistbox within w_prod_scrap
integer x = 26
integer y = 77
integer width = 841
integer height = 1258
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
		tab_scrap.tabpage_skid.dw_scrap_list.Event ue_resume_where()
		wf_display_total_info()
	END IF
NEXT

//Alex Gerlants. 05/02/2017. Begin
Long	ll_rows, ll_customer_id

ll_customer_id = wf_get_customer_id()
il_customer_id = ll_customer_id //Alex Gerlants. Scrap Credit

dw_scrap_type.SetTransObject(sqlca)
ll_rows = dw_scrap_type.Retrieve(ll_customer_id)

dw_scrap_status.SetTransObject(sqlca)
ll_rows = dw_scrap_status.Retrieve(ll_customer_id)
//Alex Gerlants. 05/02/2017. End
end event

type cb_search from u_cb within w_prod_scrap
integer x = 3361
integer y = 32
integer width = 223
integer height = 61
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Search"
end type

event clicked;Long	ll_rows, ll_customer_id

ll_rows = tab_scrap.tabpage_skid.dw_scrap_list.RowCount()

If ll_rows > 0 Then
	ll_customer_id = tab_scrap.tabpage_skid.dw_scrap_list.Object.customer_id[1]
End If


//OpenWithParm(w_buildfilter, tab_scrap.tabpage_skid.dw_scrap_list.DataObject)
OpenWithParm(w_buildfilter_prod_scrap, tab_scrap.tabpage_skid.dw_scrap_list) //Alex Gerlants. 05/02/2017
RETURN 1
end event

type cb_reset from u_cb within w_prod_scrap
integer x = 3361
integer y = 96
integer width = 223
integer height = 61
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;tab_scrap.tabpage_skid.dw_scrap_list.Event ue_resume_where()
end event

type st_cond from statictext within w_prod_scrap
integer x = 914
integer y = 51
integer width = 2432
integer height = 109
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

type gb_1 from groupbox within w_prod_scrap
integer x = 878
integer width = 2721
integer height = 170
integer taborder = 60
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

type cb_ref from u_cb within w_prod_scrap
integer x = 2776
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Re&ference"
end type

event clicked;Parent.Event ue_ref()
RETURN 1
end event

type cb_newitem from u_cb within w_prod_scrap
integer x = 538
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "New &Item"
end type

event clicked;tab_scrap.tabpage_skid.dw_editor.ResetUpdate()
tab_scrap.tabpage_skid.dw_editor.DataObject = "d_return_scrap_item_editor"
tab_scrap.tabpage_skid.dw_editor.SetTransObject(sqlca) 

RETURN	tab_scrap.tabpage_skid.dw_editor.Event ue_additem()

end event

type cb_edit from u_cb within w_prod_scrap
integer x = 1657
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;RETURN	tab_scrap.tabpage_skid.dw_editor.Event ue_modify()
end event

type cb_removeitem from u_cb within w_prod_scrap
integer x = 1284
integer y = 1965
integer width = 358
integer height = 83
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "R&emove Item"
end type

event clicked;Parent.Event ue_deleteitem()
end event

