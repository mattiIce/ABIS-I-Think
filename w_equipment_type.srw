$PBExportHeader$w_equipment_type.srw
forward
global type w_equipment_type from w_sheet
end type
type cb_print from commandbutton within w_equipment_type
end type
type dw_validate from datawindow within w_equipment_type
end type
type cb_save from commandbutton within w_equipment_type
end type
type cb_close from commandbutton within w_equipment_type
end type
type cb_delete from commandbutton within w_equipment_type
end type
type cb_add from commandbutton within w_equipment_type
end type
type dw_equipment_type from u_dw within w_equipment_type
end type
end forward

global type w_equipment_type from w_sheet
integer width = 2231
integer height = 1411
string title = "Table Equipment_Type"
boolean resizable = false
string icon = "JaguarProfile!"
event type string ue_whoami ( )
cb_print cb_print
dw_validate dw_validate
cb_save cb_save
cb_close cb_close
cb_delete cb_delete
cb_add cb_add
dw_equipment_type dw_equipment_type
end type
global w_equipment_type w_equipment_type

forward prototypes
public subroutine wf_validate (ref string as_key_complete, ref string as_key_non_duplicate)
end prototypes

event type string ue_whoami();Return "w_equipment_type"
end event

public subroutine wf_validate (ref string as_key_complete, ref string as_key_non_duplicate);/*
Function:	wf_validate
				1. Make sure 

Returns:		none
Arguments:	reference	string	as_key_complete
				reference	string	as_key_non_duplicate
*/

//Integer	li_rtn = 1
Long		ll_rows, ll_row
String	ls_equipment_type_code, ls_equipment_type_desc, ls_key, ls_key_prev

dw_equipment_type.AcceptText()
ll_rows = dw_equipment_type.RowCount()

dw_validate.Reset()
dw_equipment_type.RowsCopy(1, ll_rows, Primary!, dw_validate, 1, Primary!)

dw_validate.SetSort("equipment_type_code A")
dw_validate.Sort()

ls_key_prev = ""

For ll_row = 1 To ll_rows
	ls_equipment_type_code = dw_validate.Object.equipment_type_code[ll_row]
	If IsNull(ls_equipment_type_code) Then ls_equipment_type_code = ""
	
	ls_equipment_type_desc = dw_validate.Object.equipment_type_desc[ll_row]
	If IsNull(ls_equipment_type_desc) Then ls_equipment_type_desc = ""
	
	If ls_equipment_type_code = "" Or ls_equipment_type_desc = "" Then
		as_key_complete = "Equipment Type and Equipment Type Description must be populated."
	End If
	
	ls_key = ls_equipment_type_code
	
	If ls_key = ls_key_prev Then
		as_key_non_duplicate = "Combination of Equipment Type and Equipment Type Description must NOT repeate."
	End If
	
	ls_key_prev = ls_key
	
	If as_key_complete <> "" And as_key_non_duplicate <> "" Then
		Exit
	End If
Next
end subroutine

on w_equipment_type.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.dw_validate=create dw_validate
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_equipment_type=create dw_equipment_type
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.dw_validate
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.dw_equipment_type
end on

on w_equipment_type.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.dw_validate)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_equipment_type)
end on

event open;call super::open;Long	ll_rows

dw_equipment_type.SetTransObject(sqlca)
ll_rows = dw_equipment_type.Retrieve()
end event

event closequery;/*
Returns Long:	0 - Allow the window to be closed
					1 - Prevent the window from closing
*/

Integer	li_rtn, li_answer
Long		ll_modified_count, ll_deleted_count
String	ls_key_complete, ls_key_non_duplicate

dw_equipment_type.AcceptText()

ll_modified_count = dw_equipment_type.ModifiedCount()
ll_deleted_count = dw_equipment_type.DeletedCount()

If ll_modified_count > 0 Or ll_deleted_count > 0 Then
	wf_validate(ls_key_complete, ls_key_non_duplicate)
	
	If ls_key_complete <> "" Or ls_key_non_duplicate <> "" Then //Errors found
		If ls_key_complete <> "" And ls_key_non_duplicate <> "" Then
			li_rtn = MessageBox("Data Error", ls_key_complete + "~n~r" + ls_key_non_duplicate + &
							"~n~rClose without saving?", Question!, YesNo!, 2)
		ElseIf ls_key_complete <> "" Then
			li_rtn = MessageBox("Data Error", ls_key_complete + &
							"~n~rClose without saving?", Question!, YesNo!, 2)
		Else //ls_key_non_duplicate <> ""
			li_rtn = MessageBox("Data Error", ls_key_non_duplicate + &
							"~n~rClose without saving?",Question!, YesNo!, 2)
		End If
		
		If li_rtn = 1 Then //Yes
			Return 0 //Allow the window to be closed
		Else //No
			Return 1 //Prevent the window from closing
		End If
	Else //No errors found
		li_rtn = MessageBox("Data Modified", "Close without saving?", Question!, YesNo!, 2)
		
		If li_rtn = 1 Then //Yes
			Return 0 //Allow the window to be closed
		Else //No
			Return 1 //Prevent the window from closing
		End If
		
		li_rtn = dw_equipment_type.Update()
		
		If li_rtn = 1 Then //OK in pfc_save in pfc_w_master
			commit using sqlca;
		Else
			rollback using sqlca; //Error message is in dberror event for dw_equipment_type
		End If
	End If
Else
	Return 0 //Allow the window to be closed
End If
end event

event pfc_postopen;call super::pfc_postopen;This.Width = 2253
end event

type cb_print from commandbutton within w_equipment_type
integer x = 848
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;Printsetup()

dw_equipment_type.Print()
end event

type dw_validate from datawindow within w_equipment_type
boolean visible = false
integer x = 1492
integer y = 435
integer width = 549
integer height = 320
integer taborder = 20
string dataobject = "d_equipment_type"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_save from commandbutton within w_equipment_type
integer x = 1258
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;Integer	li_rtn
Long		ll_modified_count, ll_deleted_count
String	ls_key_complete, ls_key_non_duplicate

dw_equipment_type.AcceptText()

ll_modified_count = dw_equipment_type.ModifiedCount()
ll_deleted_count = dw_equipment_type.DeletedCount()

If ll_modified_count > 0 Or ll_deleted_count > 0 Then
	wf_validate(ls_key_complete, ls_key_non_duplicate)
	
	If ls_key_complete <> "" Or ls_key_non_duplicate <> "" Then
		If ls_key_complete <> "" And ls_key_non_duplicate <> "" Then
			MessageBox("Data Error", ls_key_complete + "~n~r" + ls_key_non_duplicate, StopSign!)
		ElseIf ls_key_complete <> "" Then
			MessageBox("Data Error", ls_key_complete, StopSign!)
		Else //ls_key_non_duplicate <> ""
			MessageBox("Data Error", ls_key_non_duplicate, StopSign!)
		End If
		
		Return -1
	End If
	
	li_rtn = dw_equipment_type.Update()
	
	If li_rtn = 1 Then //OK in pfc_save in pfc_w_master
		commit using sqlca;
	End If
Else
	Return 1
End If
end event

type cb_close from commandbutton within w_equipment_type
integer x = 1872
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(Parent) //Validation is in CloseQuery event for w_equipment_type
end event

type cb_delete from commandbutton within w_equipment_type
integer x = 439
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;Integer	li_answer, li_selected_count
Long		ll_selected_row[]
String	ls_equipment_type_code

dw_equipment_type.AcceptText()

/*
There is only 1 row can be selected at a time.
Thus, ll_selected_row[] will always have 1 selected row
*/

//Selected row is in ll_selected_row[]
li_selected_count = dw_equipment_type.inv_rowselect.of_SelectedCount(ll_selected_row[])

If li_selected_count > 0 Then
	ls_equipment_type_code = dw_equipment_type.Object.equipment_type_code[ll_selected_row[1]]
	
	li_answer = MessageBox("Are you sure?",	"Equipment type '" + ls_equipment_type_code + "'"+ &
															" in the selected row will be deleted." + &
															"~n~Are you sure?", Question!, YesNo!, 2)
	
	If li_answer = 1 Then //Yes
		dw_equipment_type.DeleteRow(ll_selected_row[1])
	End If
End If
end event

type cb_add from commandbutton within w_equipment_type
integer x = 29
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;Long		ll_inserted_row, ll_rows
String	ls_equipment_type_code, ls_equipment_type_desc

dw_equipment_type.AcceptText()
ll_rows = dw_equipment_type.RowCount()

ls_equipment_type_code = dw_equipment_type.Object.equipment_type_code[ll_rows]
If IsNull(ls_equipment_type_code) Then ls_equipment_type_code = ""

ls_equipment_type_desc = dw_equipment_type.Object.equipment_type_desc[ll_rows]
If IsNull(ls_equipment_type_desc) Then ls_equipment_type_desc = ""

If ls_equipment_type_code <> "" And ls_equipment_type_desc <> "" Then
	ll_inserted_row = dw_equipment_type.InsertRow(0)
	
	dw_equipment_type.SetFocus()
	dw_equipment_type.ScrollToRow(ll_inserted_row)
	dw_equipment_type.SetRow(ll_inserted_row)
	dw_equipment_type.SetColumn("equipment_type_code")
End If
end event

type dw_equipment_type from u_dw within w_equipment_type
integer x = 29
integer y = 102
integer width = 2165
integer height = 1101
integer taborder = 10
string dataobject = "d_equipment_type"
end type

event constructor;call super::constructor;//Set up PFC Select Service
This.of_SetRowSelect(True)
This.inv_RowSelect.of_SetStyle(0) // 0=single row selection
                                  // 1=multirow selection
                                  // 2=extended row selection
end event

event clicked;call super::clicked;String 	ls_old_sort, ls_column, ls_name
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
end event

event dberror;call super::dberror;MessageBox("Database Error", "Database error while trying to update table equipment_type" + &
										"~n~rDB Error:~n~r" + sqlerrtext)
end event

