$PBExportHeader$w_shipment_skid_select.srw
$PBExportComments$<popup> select skid for an shipment inherited from pfemain/w_popup
forward
global type w_shipment_skid_select from w_popup
end type
type cb_check_863 from commandbutton within w_shipment_skid_select
end type
type dw_list from u_dw within w_shipment_skid_select
end type
type cb_select from u_cb within w_shipment_skid_select
end type
type cb_close from u_cb within w_shipment_skid_select
end type
type dw_detail from u_dw within w_shipment_skid_select
end type
type st_1 from statictext within w_shipment_skid_select
end type
end forward

global type w_shipment_skid_select from w_popup
integer x = 556
integer y = 342
integer width = 2856
integer height = 1507
string title = "Select skid for this shipment"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
cb_check_863 cb_check_863
dw_list dw_list
cb_select cb_select
cb_close cb_close
dw_detail dw_detail
st_1 st_1
end type
global w_shipment_skid_select w_shipment_skid_select

type variables
Long	al_cust //Alex Gerlants. Form_863 Cert Label
end variables

forward prototypes
public function boolean wf_customer_863 (long al_customer_id)
public function string wf_all_skid_coils_have_863 (long al_sheet_skid_num)
public subroutine wf_check_863 ()
end prototypes

public function boolean wf_customer_863 (long al_customer_id);//Alex Gerlants. Form_863 Cert Label. Begin
/*
Function:	wf_customer_863
Returns:		boolean	True  if al_customer_id exists for coils in data_in_863
							False if al_customer_id does not exist for coils in data_in_863
Arguments:	value		long	al_customer_id
*/
Boolean	lb_customer_863 = False
Integer	li_count

//select	count(*)
//into		:li_count
//from		dbo.data_in_863
//			join coil on coil.coil_org_num = dbo.data_in_863.coil_num
//where		coil.customer_id = :al_customer_id
//using		sqlca;

select	count(*)
into		:li_count
from		customer
where		customer_id = :al_customer_id
and		nvl(coil_cert_label_req, 'N') = 'Y'
using		sqlca;

If li_count > 0 Then
	lb_customer_863 = True
End If

Return lb_customer_863
//Alex Gerlants. Form_863 Cert Label. End
end function

public function string wf_all_skid_coils_have_863 (long al_sheet_skid_num);//Alex Gerlants. Form_863 Cert Label. Begin
/*
Function:	wf_all_skid_coils_have_863
Returns:		string	"Y" if all coils on al_sheet_skid_num have 863
							"N" if NOT all coils on al_sheet_skid_num have 863
Arguments:	value		long	al_sheet_skid_num
*/
String		ls_all_skid_coils_have_863 = "Y", ls_coil_org_num, ls_sql_863, ls_add_863
Integer		li_rtn, li_count, li_coil_count_863
Long			ll_rows, ll_row
DataStore	lds_skid_coils, lds_skid_coils_863

lds_skid_coils = Create DataStore
lds_skid_coils.DataObject = "d_skid_coils"
lds_skid_coils.SetTransObject(sqlca)

lds_skid_coils_863 = Create DataStore
lds_skid_coils_863.DataObject = "d_skid_coils_863"
lds_skid_coils_863.SetTransObject(sqlca)

ls_sql_863 = lds_skid_coils_863.GetSqlSelect()
ls_add_863 = " where coil_num in ( "

ll_rows = lds_skid_coils.Retrieve(al_sheet_skid_num)

If ll_rows > 0 Then
	li_count = ll_rows
	
	For ll_row = 1 To ll_rows
		ls_coil_org_num = lds_skid_coils.Object.coil_org_num[ll_row]
		ls_add_863 = ls_add_863 + "'" + ls_coil_org_num + "',"
		
//		select	count(*)
//		into		:li_count
//		from		dbo.data_in_863
//		where		coil_num = :ls_coil_org_num
//		using		sqlca;
//		
//		If sqlca.sqlcode < 0 Then //DB error
//			//
//		End If
//		
//		If li_count <= 0 Then
//			ls_all_skid_coils_have_863 = "N"
//			Exit
//		End If
	Next
	
	//Remove the last comma
	ls_add_863 = Left(ls_add_863, Len(ls_add_863) - 1)
	
	//Add closing ")"
	ls_add_863 = ls_add_863 + " )"
	
	//Build final add
	ls_sql_863 = ls_sql_863 + ls_add_863 
	li_rtn = lds_skid_coils_863.SetSqlSelect(ls_sql_863)
	
	ll_rows = lds_skid_coils_863.Retrieve()
	
	If ll_rows > 0 Then
		li_coil_count_863 = lds_skid_coils_863.Object.coil_count_863[1]
		
		If li_count > li_coil_count_863 Then
			ls_all_skid_coils_have_863 = "N"
		End If
	End If
Else
	ls_all_skid_coils_have_863 = "N"
End If

//select	f_all_skid_coils_have_863(:al_sheet_skid_num)
//into		:li_rtn
//from		dual
//using		sqlca;
//
//If li_rtn = 1 Then
//	ls_all_skid_coils_have_863 = "Y"
//Else
//	lS_all_skid_coils_have_863 = "N"
//End If

If IsValid(lds_skid_coils) Then Destroy lds_skid_coils

Return ls_all_skid_coils_have_863
//Alex Gerlants. Form_863 Cert Label. End
end function

public subroutine wf_check_863 ();//Alex Gerlants. Form_863 Cert Label. Begin
/*
Function:	wf_check_863
Returns:		none
Arguments:	none
*/

String	ls_sql, ls_before_from, ls_after_from, ls_add, ls_all_skid_coils_have_863
Long		ll_pos, ll_rows, ll_k, ll_sheet_skid_num
Integer	li_rtn
Boolean	lb_customer_863
Pointer	lp_old

ll_rows = dw_list.RowCount()

lp_old = SetPointer(HourGlass!)

For ll_k = 1 To ll_rows
	dw_list.Object.ind[ll_k] = 1 //Make 863 column visible
	
	ll_sheet_skid_num = dw_list.Object.sheet_skid_sheet_skid_num[ll_k]
	ls_all_skid_coils_have_863 = wf_all_skid_coils_have_863(ll_sheet_skid_num)
	dw_list.Object.all_skid_coils_have_863[ll_k] = ls_all_skid_coils_have_863
	
	dw_list.SetItemStatus(ll_k, 0, Primary!, NotModified!) //It would not ask to save
Next

SetPointer(lp_old)
//Alex Gerlants. Form_863 Cert Label. End
end subroutine

on w_shipment_skid_select.create
int iCurrent
call super::create
this.cb_check_863=create cb_check_863
this.dw_list=create dw_list
this.cb_select=create cb_select
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_check_863
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_detail
this.Control[iCurrent+6]=this.st_1
end on

on w_shipment_skid_select.destroy
call super::destroy
destroy(this.cb_check_863)
destroy(this.dw_list)
destroy(this.cb_select)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.st_1)
end on

event open;call super::open;//this event will select customer and all of its children's skid
Long ll_cust
String ls_select, ls_where, ls_modify, ls_temp
DataStore lds_cust
Long ll_row, ll_i, ll_cid

//Alex Gerlants. Form_863 Cert Label. Begin
String	ls_sql, ls_before_from, ls_after_from, ls_add, ls_all_skid_coils_have_863
Long		ll_pos, ll_rows, ll_k, ll_sheet_skid_num
Integer	li_rtn
Boolean	lb_customer_863
Pointer	lp_old

//ls_sql = dw_list.GetSqlSelect()
//Alex Gerlants. Form_863 Cert Label. End

ll_cust = Message.DoubleParm

al_cust = ll_cust //Alex Gerlants. Form_863 Cert Label
 
IF ll_cust > 0 THEN
	ls_select =  " SELECT  ~~~"SHEET_SKID~~~".~"SHEET_SKID_NUM~~~" ,~~~"SHEET_SKID~~~".~~~"AB_JOB_NUM~~~" ,~~~"SHEET_SKID~~~".~~~"SHEET_NET_WT~~~" ,~~~"SHEET_SKID~~~".~~~"SHEET_TARE_WT~~~" ,~~~"SHEET_SKID~~~".~~~"SKID_DATE~~~" ,~~~"SHEET_SKID~~~".~~~"SKID_SHEET_STATUS~~~" , ~~~"SHEET_SKID~~~".~~~"SKID_PIECES~~~" ,~~~"SHEET_SKID~~~".~~~"SHEET_THEORETICAL_WT~~~" ,~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~"     FROM ~~~"SHEET_SKID~~~" ,~~~"AB_JOB~~~" ,~~~"CUSTOMER_ORDER~~~"  "
	ls_where =  " WHERE ( ~~~"AB_JOB~~~".~~~"AB_JOB_NUM~~~" = ~~~"SHEET_SKID~~~".~~~"AB_JOB_NUM~~~" ) and ( ~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" ) and ( ( ~~~"SHEET_SKID~~~".~~~"SKID_SHEET_STATUS~~~" in (2,12) ) )"   
	ls_temp = " ( ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = " + String(ll_cust) + " )"
	
	lds_cust = CREATE datastore  
	lds_cust.DataObject = "d_dddw_parent"  
	lds_cust.SetTransObject(SQLCA)  
	lds_cust.Retrieve()
	ll_row = lds_cust.RowCount()
	FOR ll_i = 1 TO ll_row
		ll_cid = 0
		IF lds_cust.GetItemNumber(ll_i, "parent_id") = ll_cust THEN
			ll_cid = lds_cust.GetItemNumber(ll_i, "customer_id")
			ls_temp = ls_temp + " OR ( ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = " + String(ll_cid) + " )"
		END IF
	NEXT
	DESTROY lds_cust
	
	ls_where = ls_where + " AND ( " + ls_temp + " )"
	ls_modify ="DataWindow.Table.Select = '" + ls_select + ls_where + " '"
	dw_list.Modify(ls_modify)
	
	//Alex Gerlants. Form_863 Cert Label. Begin
	ls_sql = dw_list.GetSqlSelect() 
	
	ll_pos = Pos(ls_sql, "FROM")
	
	If ll_pos > 0 Then
		ls_before_from = Left(ls_sql, ll_pos - 1)
		ls_after_from = Right(ls_sql, Len(ls_sql) - ll_pos + 1)
		
		//ls_add = " , case dbo.f_all_skid_coils_have_863(sheet_skid.sheet_skid_num) when 1 then 'Y' else 'N' end all_skid_coils_have_863, case dbo.f_customer_863(sheet_skid.sheet_skid_num) when 1 then 'Y' else 'N' end customer_863 "
		ls_add = " , 'N'  all_skid_coils_have_863, 0 ind "
		ls_sql = ls_before_from + ls_add + ls_after_from
		
		li_rtn = dw_list.SetSqlSelect(ls_sql)
	Else
		Close(This)
	End If
	//Alex Gerlants. Form_863 Cert Label. End
	
	ll_rows = dw_list.Retrieve() //Alex Gerlants. Form_863 Cert Label. Added "ll_rows = "
	
	//Alex Gerlants. Form_863 Cert Label. Begin
	cb_check_863.Visible = False
	
	lb_customer_863 = wf_customer_863(ll_cust)
	
	If  lb_customer_863 Then //ll_cust is an 863 customer
		wf_check_863()
	End If
	//Alex Gerlants. Form_863 Cert Label. End

// //Alex Gerlants. Form_863 Cert Label. Begin
//	If  lb_customer_863 Then //ll_cust is an 863 customer
//		lp_old = SetPointer(HourGlass!)
//		
//		For ll_k = 1 To ll_rows
//			dw_list.Object.ind[ll_k] = 1 //Make 863 column visible
//			cb_check_863.Visible = True
//			
//			ll_sheet_skid_num = dw_list.Object.sheet_skid_sheet_skid_num[ll_k]
//			ls_all_skid_coils_have_863 = wf_all_skid_coils_have_863(ll_sheet_skid_num)
//			dw_list.Object.all_skid_coils_have_863[ll_k] = ls_all_skid_coils_have_863
//			
//			dw_list.SetItemStatus(ll_k, 0, Primary!, NotModified!)
//		Next
//		
//		SetPointer(lp_old)
//	Else //ll_cust is NOT an 863 customer
//		lp_old = SetPointer(HourGlass!)
//		cb_check_863.Visible = False
//		
//		For ll_k = 1 To ll_rows
//			dw_list.Object.ind[ll_k] = 0 //Make 863 column invisible
//			dw_list.SetItemStatus(ll_k, 0, Primary!, NotModified!)
//		Next
//		
//		SetPointer(lp_old)
//	End If
//	//Alex Gerlants. Form_863 Cert Label. End
END IF

end event

type cb_check_863 from commandbutton within w_shipment_skid_select
integer x = 2432
integer y = 1293
integer width = 351
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Check 863"
end type

event clicked;//Alex Gerlants. Form_863 Cert Label. Begin
String	ls_sql, ls_before_from, ls_after_from, ls_add, ls_all_skid_coils_have_863
Long		ll_pos, ll_rows, ll_k, ll_sheet_skid_num
Integer	li_rtn
Boolean	lb_customer_863
Pointer	lp_old

ll_rows = dw_list.RowCount()

If  cb_check_863.Visible Then //ll_cust is an 863 customer
	lp_old = SetPointer(HourGlass!)
	
	For ll_k = 1 To ll_rows
		dw_list.Object.ind[ll_k] = 1 //Make 863 column visible
		
		ll_sheet_skid_num = dw_list.Object.sheet_skid_sheet_skid_num[ll_k]
		ls_all_skid_coils_have_863 = wf_all_skid_coils_have_863(ll_sheet_skid_num)
		dw_list.Object.all_skid_coils_have_863[ll_k] = ls_all_skid_coils_have_863
		
		dw_list.SetItemStatus(ll_k, 0, Primary!, NotModified!) //It would not ask to save
	Next
	
	SetPointer(lp_old)
End If







//Alex Gerlants. Form_863 Cert Label. End
end event

type dw_list from u_dw within w_shipment_skid_select
integer x = 15
integer y = 3
integer width = 2783
integer height = 950
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_shipment_avi_skid_list"
end type

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 2 )
SetTransObject(SQLCA)

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 1
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
RETURN 1
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long ll_Row, ll_skid

ll_Row = this.GetRow()
IF ll_row < 1 THEN RETURN
SelectRow(0, False)
SelectRow(ll_Row, True)

ll_skid = this.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
dw_detail.Retrieve(ll_skid)

RETURN

end event

event doubleclicked;cb_select.Event Clicked()
end event

type cb_select from u_cb within w_shipment_skid_select
integer x = 816
integer y = 1293
integer width = 351
integer height = 93
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Select"
end type

event clicked;Window lw_parent
Long ll_skid, ll_row, ll_rc
Long ll_selected[], ll_selectedcount, ll_r, ll_i

ll_selectedcount = dw_list.inv_rowselect.of_selectedCount(ll_selected)

ll_r = UpperBound(ll_selected)
IF ll_r > 0 THEN
	FOR ll_i = ll_r TO 1 STEP -1
		ll_row = ll_selected[ll_i]
		IF ll_row < 1 THEN Return -1
		ll_skid = dw_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
		lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
		IF IsValid(lw_parent) THEN
			ll_rc = lw_Parent.Dynamic Event ue_check_skid(ll_skid)
			CHOOSE CASE ll_rc
				CASE 0
					lw_Parent.Dynamic Event ue_add_skid(ll_skid)
					dw_list.DeleteRow(ll_row)
					dw_list.ResetUpdate()
				CASE -1
					MessageBox("Error","This skid has been assigned to this shipment already.", StopSign!) 
				CASE ELSE
					MessageBox("Error","This skid has been assigned to shipment# " + String(ll_rc) + " already.", StopSign!)
			END CHOOSE
		END IF
	NEXT
END IF

Return 0

end event

type cb_close from u_cb within w_shipment_skid_select
integer x = 1682
integer y = 1293
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type dw_detail from u_dw within w_shipment_skid_select
integer x = 735
integer y = 963
integer width = 1642
integer height = 320
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_shipment_avi_skid_detail"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;SetTransObject(SQLCA)
end event

type st_1 from statictext within w_shipment_skid_select
integer x = 453
integer y = 966
integer width = 256
integer height = 77
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

