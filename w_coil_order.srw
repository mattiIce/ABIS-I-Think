$PBExportHeader$w_coil_order.srw
$PBExportComments$<child> list all coils for an order, inherited from pfemain\w_child
forward
global type w_coil_order from w_child
end type
type cbx_starting_goods_material_num from checkbox within w_coil_order
end type
type cb_getgize from commandbutton within w_coil_order
end type
type dw_order_coil from u_dw within w_coil_order
end type
type cb_cancel from u_cb within w_coil_order
end type
type cb_more from u_cb within w_coil_order
end type
type cb_add from u_cb within w_coil_order
end type
type st_1 from statictext within w_coil_order
end type
type st_2 from statictext within w_coil_order
end type
type st_3 from statictext within w_coil_order
end type
type st_4 from statictext within w_coil_order
end type
type st_5 from statictext within w_coil_order
end type
type st_6 from statictext within w_coil_order
end type
type st_7 from statictext within w_coil_order
end type
type st_10 from statictext within w_coil_order
end type
type st_8 from statictext within w_coil_order
end type
type st_9 from statictext within w_coil_order
end type
type st_11 from statictext within w_coil_order
end type
end forward

global type w_coil_order from w_child
string tag = "list all coils of a order"
integer x = 519
integer y = 374
integer width = 4074
integer height = 1584
string title = "Coils for ABC order 888888"
boolean minbox = false
boolean maxbox = false
cbx_starting_goods_material_num cbx_starting_goods_material_num
cb_getgize cb_getgize
dw_order_coil dw_order_coil
cb_cancel cb_cancel
cb_more cb_more
cb_add cb_add
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_10 st_10
st_8 st_8
st_9 st_9
st_11 st_11
end type
global w_coil_order w_coil_order

type variables
long il_customer_id
Long il_order_id
Long il_ab_job_id
s_order_data istr_data

Long		il_order_item_num //Alex Gerlants. Wrong_Coil_4Job
String	is_starting_goods_material_num //Alex Gerlants. 11/07/2019. Add_Coil_2Job_Add_Cash_Date
end variables

forward prototypes
public function integer wf_validate_coil_material_num (long al_customer_id, long al_order_abc_num, long al_order_item_num, long al_coil_abc_num, long al_ab_job_num)
end prototypes

public function integer wf_validate_coil_material_num (long al_customer_id, long al_order_abc_num, long al_order_item_num, long al_coil_abc_num, long al_ab_job_num);//Alex Gerlants. Wrong_Coil_4Job. 06/13/2018. Begin
/*
Function:	wf_validate_coil_material_num
Returns:		integer	 1 If coil.material_num = order_item.starting_goods_material_num
							-1 If coil.material_num <> order_item.starting_goods_material_num 
							-2 If coil.material_num is not available
							-3 If order_item.starting_goods_material_num is not available
							-4 If DB error
Arguments:	value	long	al_customer_id
				value	long	al_order_abc_num
				value	long	al_order_item_num
				value	long	al_coil_abc_num
				value	long	al_ab_job_num
*/

Integer	li_rtn = 1
String	ls_material_num, ls_starting_goods_material_num, ls_validate_material, ls_customer_short_name
//Long		ll_order_abc_num, ll_order_item_num

select	upper(validate_material), customer_short_name
into		:ls_validate_material, :ls_customer_short_name
from		customer
where		customer_id = :il_customer_id
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	If IsNull(ls_validate_material) Then ls_validate_material = "N"
Else //DB error
	li_rtn = -1
	
	MessageBox("DB Error", "Database error in wf_validate_coil_material_num while retrieving data for customer " + ls_customer_short_name + &
						"~n~r~n~rError: " + sqlca.sqlerrtext)
End If

If li_rtn = 1 And ls_validate_material = "Y" Then //OK above
	select 	material_num
	into		:ls_material_num
	from		coil
	where		coil_abc_num = :al_coil_abc_num
	using		sqlca;
	
	If sqlca.sqlcode = 0 Then //OK
		If IsNull(ls_material_num) Then ls_material_num = "NA"
	
		If ls_material_num <> "NA" Then //OK. coil.material_num is available
			//Get order_item.starting_goods_material_num
			select 	order_item.starting_goods_material_num
			into		:ls_starting_goods_material_num
			from   	order_item
			where  	order_abc_num = :al_order_abc_num
			and		order_item_num = :al_order_item_num
			using		sqlca;
			
			If sqlca.sqlcode = 0 Then //OK
				If IsNull(ls_starting_goods_material_num) Then ls_starting_goods_material_num = "NA"
			
				If ls_starting_goods_material_num <> "NA" Then //OK. order_item.starting_goods_material_num is available
					//Now, compare ls_material_num with ls_starting_goods_material_num
					If ls_material_num <> ls_starting_goods_material_num Then
						li_rtn = -1
						
						//Alex Gerlants. 10/30/2019. Changed from " with  Starting Material = " + ls_starting_goods_material_num to " with  Starting Material = " + ls_material_num
						MessageBox("ERROR. CANNOT USE THIS COIL", "Material for Coil " + String(al_coil_abc_num) + &
										" not equal to Starting Material for Order " + String(al_order_abc_num) + &
										" and Item " + String(al_order_item_num) + "~n~r~n~r" + &
										"Coil Material:                  " + ls_material_num + "~n~r" + &
										"Order Starting Material: " + ls_starting_goods_material_num + "~n~r~n~r" + &
										"If you really want to use this coil, please create another item for order " + String(al_order_abc_num) + &
										" with  Starting Material = " + ls_material_num + ".", &
										StopSign!)
					End If
				Else //order_item.starting_goods_material_num is not available
					li_rtn = -3
					
					MessageBox("ERROR. CANNOT USE THIS COIL", "Starting Material not available for order " + String(al_order_abc_num) + " and order item " + String(al_order_item_num), StopSign!)
				End If
			Else //DB error
				li_rtn = -4
				
				MessageBox("DB Error", "Database error in wf_validate_coil_material_num while retrieving data for Job " + String(al_ab_job_num) + &
									"~n~r~n~rError: " + sqlca.sqlerrtext)
			End If
		Else //coil.material_num is not available
			li_rtn = -2
			
			MessageBox("ERROR. CANNOT USE THIS COIL", "Material not available for coil " + String(al_coil_abc_num), StopSign!)
		End If
	Else //DB error
		li_rtn = -4
		
		MessageBox("DB Error", "Database error in wf_validate_coil_material_num while retrieving data for coil " + String(al_coil_abc_num) + &
							"~n~r~n~rError: " + sqlca.sqlerrtext)
	End If
End if

Return li_rtn//Alex Gerlants. Wrong_Coil_4Job. 06/13/2018. End
end function

on w_coil_order.create
int iCurrent
call super::create
this.cbx_starting_goods_material_num=create cbx_starting_goods_material_num
this.cb_getgize=create cb_getgize
this.dw_order_coil=create dw_order_coil
this.cb_cancel=create cb_cancel
this.cb_more=create cb_more
this.cb_add=create cb_add
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_10=create st_10
this.st_8=create st_8
this.st_9=create st_9
this.st_11=create st_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_starting_goods_material_num
this.Control[iCurrent+2]=this.cb_getgize
this.Control[iCurrent+3]=this.dw_order_coil
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_more
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.st_10
this.Control[iCurrent+15]=this.st_8
this.Control[iCurrent+16]=this.st_9
this.Control[iCurrent+17]=this.st_11
end on

on w_coil_order.destroy
call super::destroy
destroy(this.cbx_starting_goods_material_num)
destroy(this.cb_getgize)
destroy(this.dw_order_coil)
destroy(this.cb_cancel)
destroy(this.cb_more)
destroy(this.cb_add)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_10)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_11)
end on

event open;call super::open;istr_data = message.PowerObjectParm
il_order_id = istr_data.order_num
il_customer_id = istr_data.customer_num
il_ab_job_id = istr_data.ab_job_num
il_order_item_num = istr_data.order_item_num //Alex Gerlants. Wrong_Coil_4Job

//Alex Gerlants. 11/07/2019. Add_Coil_2Job_Add_Cash_Date. Begin
select	starting_goods_material_num
into		:is_starting_goods_material_num
from		order_item
where		order_abc_num = :il_order_id
and		order_item_num = :il_order_item_num
using		sqlca;

//select	order_item.starting_goods_material_num
//into		:is_starting_goods_material_num
//from     ab_job
//         join order_item on order_item.order_abc_num = ab_job.order_abc_num and order_item.order_item_num = ab_job.order_item_num
//where    ab_job.ab_job_num = :il_ab_job_id
//using		sqlca;

If sqlca.sqlcode < 0 Then //DB error
	MessageBox("Database error", 	"Database error in Open event for w_coil_order in silverdome6.pbl " + &
											"while retrieving starting_goods_material_num for Order ABC Number " + &
											String(il_order_id) + " and Order Item Number " + String(il_order_item_num) + &
											" from table order_item~n~r" + &
											"Cannot continue. Please contact abis support.~n~r~n~r" + &
											"Error: " + sqlca.sqlerrtext)
	Close(This)
End If
//Alex Gerlants. 11/07/2019. Add_Coil_2Job_Add_Cash_Date.End

dw_order_coil.SetTransObject(sqlca)

//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. Begin
Long	ll_rows
//dw_order_coil.Retrieve(il_order_id) //Alex Gerlants. 10/30/2019. Comment out
ll_rows = dw_order_coil.Retrieve(il_customer_id)

//this.title = "Coils of Customer Order:  " + String(il_order_id) //Alex Gerlants. 10/30/2019. Comment out
String	ls_cust_name

select	customer_full_name
into		:ls_cust_name
from		customer
where		customer_id = :il_customer_id
using		sqlca;

This.title = " Coils list ( Customer:  " + ls_cust_name + " )"
cb_more.Text = "&Show Order's Coil"

cb_getgize.Visible = False
//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. End

dw_order_coil.SetFocus()

end event

event pfc_postopen;call super::pfc_postopen;//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. Begin
This.X = 110
This.Y = 290
This.Width = 4065
This.Height = 1645
dw_order_coil.X = 33
dw_order_coil.Y = 10
dw_order_coil.Width = 3455
dw_order_coil.Height = 1286
//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. End
end event

type cbx_starting_goods_material_num from checkbox within w_coil_order
integer x = 3496
integer y = 42
integer width = 530
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Order Material Only"
end type

event clicked;String	ls_filter_string
Integer	li_rtn

If IsNull(is_starting_goods_material_num) Then is_starting_goods_material_num = ""

If is_starting_goods_material_num = "" Then
	This.Checked = False
	Return
End If

If This.Checked = True Then
	ls_filter_string = "material_num = '" + is_starting_goods_material_num + "'"
	li_rtn = dw_order_coil.SetFilter(ls_filter_string)
	li_rtn = dw_order_coil.Filter()
Else //This.Checked = False
	li_rtn = dw_order_coil.SetFilter("") //Remove filter
	li_rtn = dw_order_coil.Filter()
End If
end event

type cb_getgize from commandbutton within w_coil_order
integer x = 2637
integer y = 1354
integer width = 322
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GetSize"
end type

event clicked;//dw_order_coil

MessageBox("", "Window~n~r" + &
					"Parent.X = " + String(Parent.X) + "~n~r" + &
					"Parent.Y = " + String(Parent.Y) + "~n~r" + &
					"Parent.Width = " + String(Parent.Width) + "~n~r" + &
					"Parent.Height = " + String(Parent.Height) + "~n~r~n~r" + &
					"DataWindow~n~r" + &
					"dw_order_coil.X = " + String(dw_order_coil.X) + "~n~r" + &
					"dw_order_coil.Y = " + String(dw_order_coil.Y) + "~n~r" + &
					"dw_order_coil.Width = " + String(dw_order_coil.Width) + "~n~r" + &
					"dw_order_coil.Height = " + String(dw_order_coil.Height))
end event

type dw_order_coil from u_dw within w_coil_order
string tag = "list all coils for an order"
integer x = 33
integer y = 10
integer width = 3419
integer height = 1286
integer taborder = 10
string dragicon = "Information!"
string dataobject = "d_coil_cust_list"
boolean hscrollbar = true
boolean resizable = true
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 

end event

event rbuttondown;//Override
Return
end event

event rbuttonup;//Override
Return 
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

event clicked;call super::clicked;String 	ls_old_sort, ls_old_column, ls_column, ls_name, ls_sort_string
Char 		lc_sort

ls_name = dwo.Name

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)

	/* Get old sort, If any. */
	ls_old_sort = This.Describe("Datawindow.Table.sort")
	ls_old_column = Left(ls_old_sort, Len(ls_old_sort) - 2)

	//Check whether previously sorted column and currently clicked column are same or not. 
	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
	//If both are not same, simply sort it by Ascending order.
	If ls_column = ls_old_column Then 
		lc_sort = Right(ls_old_sort, 1)

		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		
		ls_sort_string = ls_column + " " + lc_sort
		This.SetSort(ls_sort_string)
	Else
		If KeyDown(keyShift!) And ls_old_sort <> "?" Then //ls_old_sort = "?" when user clicks on a column header the first time
			ls_sort_string = ls_old_sort + ", " + ls_column + " A" //Add new sort to the old sort
			This.SetSort(ls_sort_string)
		Else
			ls_sort_string = ls_column + " A"
			This.SetSort(ls_sort_string)
		End If
	End If

	This.Sort()
End If
end event

event retrieveend;call super::retrieveend;//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. Begin
Long		ll_rows, ll_row, ll_pos
String	ls_cash_date_string
Date		ld_cash_date_date

If dw_order_coil.DataObject = "d_coil_cust_list" Then

	ll_rows = This.RowCount()
	
	For ll_row = 1 To ll_rows
		ls_cash_date_string = This.Object.cash_date_string[ll_row]
		
		If IsDate(ls_cash_date_string) Then
			ld_cash_date_date = Date(ls_cash_date_string)
		Else
			This.Object.cash_date_string[ll_row] = "01/01/1900"
			ld_cash_date_date = Date("01/01/1900")
		End If
		
		This.Object.cash_date_date[ll_row] = ld_cash_date_date
		This.Object.cash_date_string[ll_row] = String(ld_cash_date_date, "mm/dd/yyyy")
		This.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	Next
	
	This.SetSort("cash_date_date A, material_num A")
	This.Sort()
	
End If
//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. End
end event

type cb_cancel from u_cb within w_coil_order
integer x = 1726
integer y = 1360
integer width = 435
integer height = 83
integer taborder = 40
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)


end event

type cb_more from u_cb within w_coil_order
integer x = 516
integer y = 1360
integer width = 435
integer height = 83
integer taborder = 20
string facename = "Arial"
string text = "&Show Cust~'s Coil"
end type

event clicked;IF this.Text <> "&Show Order's Coil" THEN
	//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. Begin
	Parent.X = 110
	Parent.Y = 290
	Parent.Width = 3182
	Parent.Height = 1645
	dw_order_coil.X = 33
	dw_order_coil.Y = 10
	dw_order_coil.Width = 3061
	dw_order_coil.Height = 1286
	//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. End
	
	this.Text = "&Show Order's Coil"
	String ls_cust_name

	SELECT customer_full_name INTO :ls_cust_name
	FROM customer
	WHERE customer_id = :il_customer_id
	USING SQLCA;

	Parent.title = " Coils list ( Customer:  " + ls_cust_name + " )"
	dw_order_coil.DataObject = "d_coil_cust_list"
	dw_order_coil.SetTransObject(sqlca)
	dw_order_coil.Retrieve(il_customer_id)

ELSE
	//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. Begin
	Parent.X = 110
	Parent.Y = 290
	Parent.Width = 4827
	Parent.Height = 1645
	dw_order_coil.X = 33
	dw_order_coil.Y = 10
	dw_order_coil.Width = 4703
	dw_order_coil.Height = 1286
	//Alex Gerlants. 10/30/2019. Add_Coil_2Job_Add_Cash_Date. End
	
	this.Text = "&Show Cust's Coil"
	dw_order_coil.DataObject = "d_coil_order_list"
	dw_order_coil.SetTransObject(sqlca)
	dw_order_coil.Retrieve(il_order_id)
	Parent.title = "Coils of Customer Order:  " + String(il_order_id)
END IF

dw_order_coil.SetFocus()



end event

type cb_add from u_cb within w_coil_order
string tag = "add coil to current production order"
integer x = 1119
integer y = 1360
integer width = 435
integer height = 83
integer taborder = 30
string facename = "Arial"
string text = "&Add"
end type

event clicked;Long ll_row, ll_coil_num, ll_order, ll_ct, ll_i
integer li_rc, li_status, li_flag
Window lw_parent
datastore lds_job

Integer	li_rtn

ll_row = dw_order_coil.GetRow()
IF ll_row > 0 THEN
	IF dw_order_coil.DataObject = "d_coil_order_list" THEN 
		ll_coil_num = dw_order_coil.GetItemNumber(ll_row, "coil_abc_num", Primary!, TRUE)
		IF ll_coil_num <= 0 THEN 
			MessageBox("Error", "Failed to retrieve this coil!" )
			Return 1
		END IF	
	ELSE
		ll_coil_num = dw_order_coil.GetItemNumber(ll_row, "coil_coil_abc_num", Primary!, TRUE)
		IF ll_coil_num <= 0 THEN 
			MessageBox("Error", "Failed to retrieve this coil!" )
			Return 2
		END IF			
	END IF
	li_status = dw_order_coil.GetItemNumber(ll_row,"coil_coil_status", Primary!, TRUE)
END IF

//Alex Gerlants. Wrong_Coil_4Job. 06/13/2018. Begin
li_rtn = wf_validate_coil_material_num(il_customer_id, il_order_id, il_order_item_num, ll_coil_num, il_ab_job_id)

If li_rtn <> 1 Then //Problem in wf_validate_coil_material_num()
	Return -1
End If
//Alex Gerlants. Wrong_Coil_4Job. 06/13/2018. End

ll_ct = 0
lds_job = CREATE datastore  
lds_job.DataObject = "d_coil_for_job_list"  
lds_job.SetTransObject (SQLCA)  
lds_job.Retrieve(ll_coil_num)
ll_ct = lds_job.RowCount()

li_flag = 1
IF ll_ct > 0 THEN
	FOR ll_i = 1 TO ll_ct
		ll_order = lds_job.GetItemNumber(ll_i, "ab_job_num")
		IF ll_order = il_ab_job_id THEN
			//do nothing
			MessageBox("Warning", "This coil has been assigned to this order already!", StopSign!)
			li_flag = -1
		ELSE		
			li_rc = MessageBox("Warning", "This coil has been assigned to Order# " + String(ll_order) + " Continue?",StopSign!, YesNo!, 2) 	
			IF li_rc <> 1 THEN 
				//do nothing
				li_flag = -1
			ELSE
				//update coil in order-coil relation
				li_rc = MessageBox("Question", "Do you want to remove this coil from its original assigment: Order# " + String(ll_order) + " ?",Question!, YesNo!, 1) 	
				IF li_rc = 1 THEN
					//replace original assigment
					MessageBox("Warning", "You must remove this coil from Order# " + String(ll_order) + " first, then come back and try again.",StopSign!)
					li_flag = -1
				END IF
			END IF
		END IF
	NEXT	
END IF
DESTROY lds_job
IF li_flag = -1 THEN RETURN -1

//TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
//Return -1 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
//TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

//add new coil to ab_job
lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	lw_Parent.Dynamic Event ue_add_coil(ll_coil_num)
END IF	
dw_order_coil.DeleteRow(ll_row)
dw_order_coil.ResetUpdate()

Return 0
end event

type st_1 from statictext within w_coil_order
integer x = 37
integer y = 1302
integer width = 351
integer height = 54
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
string text = "Color indication:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_coil_order
integer x = 402
integer y = 1302
integer width = 146
integer height = 54
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
string text = "Done"
boolean focusrectangle = false
end type

type st_3 from statictext within w_coil_order
integer x = 563
integer y = 1302
integer width = 245
integer height = 54
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

type st_4 from statictext within w_coil_order
integer x = 823
integer y = 1302
integer width = 146
integer height = 54
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

type st_5 from statictext within w_coil_order
integer x = 984
integer y = 1302
integer width = 249
integer height = 54
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

type st_6 from statictext within w_coil_order
integer x = 1247
integer y = 1302
integer width = 249
integer height = 54
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

type st_7 from statictext within w_coil_order
integer x = 1510
integer y = 1302
integer width = 249
integer height = 54
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
string text = "InTransit"
boolean focusrectangle = false
end type

type st_10 from statictext within w_coil_order
integer x = 1774
integer y = 1302
integer width = 150
integer height = 54
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
string text = "Return"
boolean focusrectangle = false
end type

type st_8 from statictext within w_coil_order
integer x = 1938
integer y = 1302
integer width = 241
integer height = 54
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
string text = "Rebanded"
boolean focusrectangle = false
end type

type st_9 from statictext within w_coil_order
integer x = 2194
integer y = 1302
integer width = 150
integer height = 54
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
string text = "Retry"
boolean focusrectangle = false
end type

type st_11 from statictext within w_coil_order
integer x = 2359
integer y = 1302
integer width = 146
integer height = 54
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

