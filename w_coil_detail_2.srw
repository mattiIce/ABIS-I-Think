$PBExportHeader$w_coil_detail_2.srw
$PBExportComments$<Child> list coil detail used in the w_inv_coil, just like w_coil_detail
forward
global type w_coil_detail_2 from w_child
end type
type dw_coil_detail from u_dw within w_coil_detail_2
end type
type cb_ok from u_cb within w_coil_detail_2
end type
type cb_cancel from u_cb within w_coil_detail_2
end type
end forward

global type w_coil_detail_2 from w_child
string tag = "detail information of an coil"
integer x = 1009
integer y = 467
integer width = 2015
integer height = 1123
string title = "Coil Information"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_coil_detail dw_coil_detail
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_coil_detail_2 w_coil_detail_2

type variables
Boolean	ib_cash_date_required //Alex Gerlants. novelis testing
Long		il_customer_id //Alex Gerlants. novelis testing
end variables

forward prototypes
public function string wf_format_cash_date (string as_cash_date)
public function string wf_unformat_cash_date (string as_cash_date)
end prototypes

public function string wf_format_cash_date (string as_cash_date);//Alex Gerlants. novelis testing
/*
Function:	wf_format_cash_date
				Insert"/" into as_cash_date
Returns:		string <== Formatted cash_date
Arguments:	value	string	as_cash_date <== Unformatted cash_date (without "/")
*/

If IsNull(as_cash_date) Then as_cash_date = ""

If as_cash_date <> "" Then //Cash date populated
	//Insert "/" only if cash date entered by the user
	as_cash_date = Left(as_cash_date, 2) + "/" + Mid(as_cash_date, 3, 2) + "/" + Right(as_cash_date, 4)
Else //Cash date not populated
	SetNull(as_cash_date)
End If

Return as_cash_date
//Alex Gerlants. 12/28/2018. Cash_Date_not_Saved_at_Receiving. End
end function

public function string wf_unformat_cash_date (string as_cash_date);//Alex Gerlants. novelis testing
/*
Function:	wf_unformat_cash_date
				Remove"/" from as_cash_date
Returns:		string <== Formatted cash_date
Arguments:	value	string	as_cash_date <== Formatted cash_date (with "/")
*/
Integer	li_slash_pos_1, li_slash_pos_2
String	ls_month, ls_day, ls_year

If IsNull(as_cash_date) Then as_cash_date = ""

If as_cash_date <> "" Then //Cash date populated
	//Remove "/"
	li_slash_pos_1 = Pos(as_cash_date, "/", 1)
	
	If li_slash_pos_1 > 0 Then
		li_slash_pos_2 = Pos(as_cash_date, "/",li_slash_pos_1 + 1)
		
		If li_slash_pos_2 > 0 Then
			ls_month = Left(as_cash_date, li_slash_pos_1 - 1)
			ls_day = Mid(as_cash_date, li_slash_pos_1 + 1, li_slash_pos_2 - li_slash_pos_1 - 1)
			ls_year = Right(as_cash_date, Len(as_cash_date) - li_slash_pos_2)
			
			as_cash_date = ls_month + ls_day + ls_year
		End If
	End If
Else //Cash date not populated
	SetNull(as_cash_date)
End If

Return as_cash_date
//Alex Gerlants. 12/28/2018. Cash_Date_not_Saved_at_Receiving. End
end function

on w_coil_detail_2.create
int iCurrent
call super::create
this.dw_coil_detail=create dw_coil_detail
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_detail
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_coil_detail_2.destroy
call super::destroy
destroy(this.dw_coil_detail)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;call super::open;s_coil_info lds_data
Long ll_row

DataWindowChild	ldwc //Alex Gerlants. novelis testing
Integer				li_rtn, li_rows, li_coil_status //Alex Gerlants. novelis testing
String				ls_find_string //Alex Gerlants. novelis testing
Long					ll_found_row //Alex Gerlants. novelis testing

dw_coil_detail.SetTransObject(sqlca)

lds_data = message.PowerObjectParm
this.title = "Coil:  " + String(lds_data.ab_coil_num)
ll_row = dw_coil_detail.InsertRow(0)

dw_coil_detail.SetItem(ll_row, "customer_id",lds_data.customer_id)
dw_coil_detail.SetItem(ll_row, "coil_abc_num", lds_data.ab_coil_num )
dw_coil_detail.SetItem(ll_row, "coil_org_num",lds_data.coil_orig_num  )
dw_coil_detail.SetItem(ll_row, "coil_mid_num",lds_data.coil_alt_num)
dw_coil_detail.SetItem(ll_row, "lot_num", lds_data.lot_num   )
dw_coil_detail.SetItem(ll_row, "pieces_per_case", lds_data.pieces)
dw_coil_detail.SetItem(ll_row, "coil_line_num", lds_data.coil_line_num)
dw_coil_detail.SetItem(ll_row, "icra", lds_data.icra )
dw_coil_detail.SetItem(ll_row, "coil_alloy2", lds_data.alloy)
dw_coil_detail.SetItem(ll_row, "coil_gauge",lds_data.gauge )
dw_coil_detail.SetItem(ll_row, "coil_temper",lds_data.Temper )
dw_coil_detail.SetItem(ll_row, "net_wt",lds_data.net_wt )
dw_coil_detail.SetItem(ll_row, "net_wt_balance", lds_data.net_balance)
dw_coil_detail.SetItem(ll_row, "coil_width",lds_data.width )
dw_coil_detail.SetItem(ll_row, "date_received", lds_data.date_received)
dw_coil_detail.SetItem(ll_row, "coil_location", lds_data.location )
dw_coil_detail.SetItem(ll_row, "coil_status",lds_data.status )
dw_coil_detail.SetItem(ll_row, "coil_notes", lds_data.notes )
dw_coil_detail.SetItem(ll_row, "coil_from_cust_id", lds_data.coil_from_cust_id )
dw_coil_detail.SetItem(ll_row, "abco_coil_net_wt", lds_data.abco_coil_net_wt )
dw_coil_detail.SetItem(ll_row, "consumed_coil_num", lds_data.consumed_coil_num )
dw_coil_detail.SetItem(ll_row, "material_num", lds_data.material_num )

lds_data.cash_date = wf_unformat_cash_date(lds_data.cash_date) //Alex Gerlants. novelis testing

dw_coil_detail.SetItem(ll_row, "cash_date", lds_data.cash_date )

IF lds_data.status = 0 THEN
	dw_coil_detail.Object.DataWindow.ReadOnly = "YES"
END IF

dw_coil_detail.ResetUpdate()

//Alex Gerlants. novelis testing. Begin
li_rtn = dw_coil_detail.GetChild("coil_status", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	li_rows = ldwc.Retrieve() //Table: coil_status_desc
	
	If li_rows > 0 Then
		ls_find_string = "coil_status_code = " + String(lds_data.status)
		ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
		
		If ll_found_row > 0 Then
			dw_coil_detail.SetFocus()
			dw_coil_detail.Object.coil_status[1] = lds_data.status
			ldwc.ScrollToRow(ll_found_row)
		End If
	End If
End If

f_get_cash_date_required(lds_data.customer_id, sqlca, ib_cash_date_required)
il_customer_id = lds_data.customer_id //Alex Gerlants. novelis testing
//Alex Gerlants. novelis testing. End

dw_coil_detail.SetFocus()

RETURN 1

end event

type dw_coil_detail from u_dw within w_coil_detail_2
string tag = "Detail information of an coil"
integer x = 29
integer width = 1960
integer height = 896
integer taborder = 10
string dataobject = "d_coil_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event itemchanged;call super::itemchanged;this.ResetUpdate()
end event

event constructor;of_SetBase(TRUE)
end event

type cb_ok from u_cb within w_coil_detail_2
event clicked pbm_bnclicked
string tag = "Close this window and save data"
integer x = 402
integer y = 934
integer width = 351
integer height = 93
integer taborder = 20
string facename = "Arial"
string text = "&OK"
end type

event clicked;s_coil_info lds_data
long ll_row

Integer	li_rtn //Alex Gerlants. novelis testing
String	ls_cash_date //Alex Gerlants. novelis testing
Long		ll_coil_abc_num //Alex Gerlants. novelis testing

dw_coil_detail.AcceptText()
dw_coil_detail.ResetUpdate()

ll_row = dw_coil_detail.GetRow()
IF ll_row < 1 THEN RETURN
lds_data.customer_id = dw_coil_detail.GetItemNumber(ll_row, "customer_id",Primary!, FALSE)
lds_data.ab_coil_num = dw_coil_detail.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
lds_data.coil_orig_num = dw_coil_detail.GetItemString(ll_row, "coil_org_num", Primary!, FALSE)
lds_data.coil_alt_num = dw_coil_detail.GetItemString(ll_row, "coil_mid_num", Primary!, FALSE)
lds_data.lot_num = dw_coil_detail.GetItemString(ll_row, "lot_num",Primary!, FALSE)
lds_data.pieces = dw_coil_detail.GetItemNumber(ll_row, "pieces_per_case", Primary!, FALSE)
lds_data.coil_line_num = dw_coil_detail.GetItemNumber(ll_row, "coil_line_num", Primary!, FALSE)
lds_data.icra = dw_coil_detail.GetItemString(ll_row, "icra", Primary!, FALSE)
lds_data.alloy = dw_coil_detail.GetItemString(ll_row, "coil_alloy2",Primary!, FALSE)
lds_data.gauge = dw_coil_detail.GetItemNumber(ll_row, "coil_gauge", Primary!, FALSE)
lds_data.Temper = dw_coil_detail.GetItemString(ll_row, "coil_temper", Primary!, FALSE)
lds_data.net_wt = dw_coil_detail.GetItemNumber(ll_row, "net_wt", Primary!, FALSE)
lds_data.net_balance = dw_coil_detail.GetItemNumber(ll_row, "net_wt_balance", Primary!, FALSE)
lds_data.width = dw_coil_detail.GetItemNumber(ll_row, "coil_width", Primary!, FALSE)
lds_data.date_received = dw_coil_detail.GetItemDateTime(ll_row, "date_received", Primary!, FALSE)
lds_data.location = dw_coil_detail.GetItemString(ll_row, "coil_location", Primary!, FALSE)
lds_data.status = dw_coil_detail.GetItemNumber(ll_row, "coil_status", Primary!, FALSE)
lds_data.notes = dw_coil_detail.GetItemString(ll_row, "coil_notes", Primary!, FALSE)
lds_data.coil_from_cust_id = dw_coil_detail.GetItemNumber(ll_row, "coil_from_cust_id", Primary!, FALSE)
lds_data.abco_coil_net_wt = dw_coil_detail.GetItemNumber(ll_row, "abco_coil_net_wt", Primary!, FALSE)
lds_data.consumed_coil_num = dw_coil_detail.GetItemString(ll_row, "consumed_coil_num", Primary!, FALSE)
lds_data.material_num = dw_coil_detail.GetItemString(ll_row, "material_num", Primary!, FALSE)
lds_data.cash_date = dw_coil_detail.GetItemString(ll_row, "cash_date", Primary!, FALSE)

//Alex Gerlants. novelis testing. Begin
ll_coil_abc_num = lds_data.ab_coil_num
ls_cash_date = lds_data.cash_date
If IsNull(ls_cash_date) Then ls_cash_date = ""
//ls_cash_date = wf_format_cash_date(ls_cash_date)
li_rtn = f_validate_cash_date(il_customer_id, ll_coil_abc_num, ls_cash_date, ib_cash_date_required)

If  li_rtn = 1 Then //OK
	ls_cash_date = wf_format_cash_date(ls_cash_date)
	lds_data.cash_date = ls_cash_date
Else //Problem in f_validate_cash_date(). Error message is in f_validate_cash_date()
	dw_coil_detail.SetFocus()
	dw_coil_detail.SetRow(1)
	dw_coil_detail.SetColumn("cash_date")
	Return
End If
//Alex Gerlants. novelis testing. End

dw_coil_detail.Reset()
CloseWithReturn(parent, lds_data)
end event

type cb_cancel from u_cb within w_coil_detail_2
string tag = "Close this window without save data"
integer x = 1039
integer y = 934
integer width = 351
integer height = 93
integer taborder = 30
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;s_coil_info lds_data

lds_data.ab_coil_num = 0

dw_coil_detail.Reset()

CloseWithReturn(parent, lds_data)
end event

