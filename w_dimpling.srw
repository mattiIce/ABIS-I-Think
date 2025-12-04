$PBExportHeader$w_dimpling.srw
forward
global type w_dimpling from w_sheet
end type
type cb_check_window_dimensions from commandbutton within w_dimpling
end type
type cb_close from commandbutton within w_dimpling
end type
type cb_save from commandbutton within w_dimpling
end type
type cb_delete from commandbutton within w_dimpling
end type
type cb_add from commandbutton within w_dimpling
end type
type cb_print from commandbutton within w_dimpling
end type
type dw_dimpling from u_dw within w_dimpling
end type
end forward

global type w_dimpling from w_sheet
integer width = 2406
integer height = 1414
string title = "Table Dimpling"
boolean resizable = false
event type string ue_whoami ( )
cb_check_window_dimensions cb_check_window_dimensions
cb_close cb_close
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
cb_print cb_print
dw_dimpling dw_dimpling
end type
global w_dimpling w_dimpling

type variables
u_dw	idw_main
end variables

forward prototypes
public function boolean wf_last_row_populated ()
end prototypes

event type string ue_whoami();Return "w_dimpling"
end event

public function boolean wf_last_row_populated ();/*
Function:	wf_last_row_populated
Returns:		boolean	True if last row has dimpling_desc populated
							False  if last row has dimpling_desc NOT populated
Arguments:	none							
*/

Boolean	lb_rtn
Long		ll_rows
String	ls_dimpling_desc

ll_rows = idw_main.RowCount()

If ll_rows > 0 Then
	ls_dimpling_desc = idw_main.Object.dimpling_desc[ll_rows]
	If IsNull(ls_dimpling_desc) Then ls_dimpling_desc = ""
	
	If ls_dimpling_desc = "" Then
		lb_rtn = False
	Else
		lb_rtn = True
	End If
Else
	lb_rtn = False
End If

Return lb_rtn
end function

on w_dimpling.create
int iCurrent
call super::create
this.cb_check_window_dimensions=create cb_check_window_dimensions
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_print=create cb_print
this.dw_dimpling=create dw_dimpling
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_check_window_dimensions
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.dw_dimpling
end on

on w_dimpling.destroy
call super::destroy
destroy(this.cb_check_window_dimensions)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_print)
destroy(this.dw_dimpling)
end on

event open;call super::open;idw_main = dw_dimpling
cb_check_window_dimensions.Visible = False

idw_main.SetTransObject(sqlca)
idw_main.Retrieve()

end event

event pfc_postopen;call super::pfc_postopen;This.Width = 2421
This.Height = 1491
end event

event closequery;Long		ll_modified_count, ll_deleted_count, ll_rows
Integer	li_answer
Boolean	lb_last_row_populated

idw_main.AcceptText()

ll_modified_count = idw_main.ModifiedCount()
ll_deleted_count = idw_main.DeletedCount( )

If ll_modified_count > 0 Or ll_deleted_count > 0 Then
	li_answer = MessageBox("", "Do you want to save changes?", Exclamation!, YesNoCancel!, 1)
	
	Choose Case li_answer
		Case 1 //Yes
			cb_save.Event Clicked()
			Return 0 //Allow the window to be closed
		Case 2 //No
			Return 0 //Allow the window to be closed
		Case 3 //Cancel
			Return 1 //Prevent the window from closing
	End Choose
Else
	Return 0 //Allow the window to be closed
End If
end event

type cb_check_window_dimensions from commandbutton within w_dimpling
integer x = 1499
integer y = 1216
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Check Dims"
end type

event clicked;MessageBox("", "Width = " + String(Parent.Width) + "~n~r" + "Height = " + String(Parent.Height))
end event

type cb_close from commandbutton within w_dimpling
integer x = 2037
integer y = 1213
integer width = 322
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean default = true
end type

event clicked;Close(Parent) //Validation is in CloseQuery event for w_dimpling
end event

type cb_save from commandbutton within w_dimpling
integer x = 1145
integer y = 1213
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
Long		ll_rows, ll_row
Boolean	lb_last_row_populated

ll_rows = idw_main.RowCount()

lb_last_row_populated = wf_last_row_populated()
	
//Delete the last row added when user clicked on "Add" button, but never populated.	
If Not lb_last_row_populated Then
	ll_rows = idw_main.RowCount()
	idw_main.DeleteRow(ll_rows) //Just delete without asking
End If

////Resequence dimpling_code
//ll_rows = idw_main.RowCount() //Recount rows
//
//If ll_rows > 0 Then
//	For ll_row = 1 To ll_rows
//		idw_main.Object.dimpling_code[ll_row] = ll_row
//	Next
//End If

li_rtn = idw_main.Update()

If li_rtn = 1 Then //OK in pfc_save in pfc_w_master
	commit using sqlca;
Else
	rollback using sqlca;
End If
end event

type cb_delete from commandbutton within w_dimpling
integer x = 399
integer y = 1213
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
Long		ll_selected_row, ll_rows
String	ls_dimpling_desc
Boolean	lb_last_row_populated

idw_main.AcceptText()

/*
There is only 1 row can be selected at a time.
Thus, ll_selected_row[] will always have 1 selected row
*/

//Selected row is in ll_selected_row[]
//li_selected_count = idw_main.inv_rowselect.of_SelectedCount(ll_selected_row[])
ll_selected_row = idw_main.GetSelectedRow(0)

If ll_selected_row > 0 Then
	
	//idw_main.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
	
	ls_dimpling_desc = idw_main.Object.dimpling_desc[ll_selected_row]
	
	li_answer = MessageBox("Are you sure?",	"Dumpling '" + ls_dimpling_desc + "'"+ &
															" in the selected row will be deleted." + &
															"~n~Are you sure?", Question!, YesNo!, 2)
	
	If li_answer = 1 Then //Yes
		idw_main.DeleteRow(ll_selected_row)
	End If
Else //No row selected
	lb_last_row_populated = wf_last_row_populated()
	
	If Not lb_last_row_populated Then
		ll_rows = idw_main.RowCount()
		idw_main.DeleteRow(ll_rows) //Just delete without asking
	End If
End If
end event

type cb_add from commandbutton within w_dimpling
integer x = 22
integer y = 1213
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
Integer	li_dimpling_code
String	ls_dimpling_desc, ls_dimpling_note

idw_main.AcceptText()
ll_rows = idw_main.RowCount()

//li_dimpling_code = idw_main.Object.dimpling_code[ll_rows]
//If IsNull(li_dimpling_code) Then li_dimpling_code = 0

If ll_rows > 0 Then
	ls_dimpling_desc = idw_main.Object.dimpling_desc[ll_rows]
	If IsNull(ls_dimpling_desc) Then ls_dimpling_desc = ""
End If	

If ls_dimpling_desc <> "" Or ll_rows <= 0 Then
	ll_inserted_row = idw_main.InsertRow(0)
	
	If ll_inserted_row > 0 Then
		idw_main.SetFocus()
		idw_main.ScrollToRow(ll_inserted_row)
		idw_main.SetRow(ll_inserted_row)
		idw_main.Object.dimpling_code[ll_inserted_row] = ll_rows + 1
		idw_main.SetColumn("dimpling_desc")
	End If
Else
	idw_main.SetFocus()
	idw_main.ScrollToRow(ll_rows)
	idw_main.SetRow(ll_rows)
	idw_main.SetColumn("dimpling_desc")
End If
end event

type cb_print from commandbutton within w_dimpling
integer x = 768
integer y = 1213
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;Printsetup()

idw_main.Print()
end event

type dw_dimpling from u_dw within w_dimpling
integer x = 15
integer width = 2355
integer height = 1158
integer taborder = 10
string dataobject = "d_report_dimpling"
end type

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

If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
end event

