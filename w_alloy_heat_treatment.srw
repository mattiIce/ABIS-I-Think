$PBExportHeader$w_alloy_heat_treatment.srw
forward
global type w_alloy_heat_treatment from w_sheet
end type
type st_1 from statictext within w_alloy_heat_treatment
end type
type dw_name from datawindow within w_alloy_heat_treatment
end type
type cb_1 from commandbutton within w_alloy_heat_treatment
end type
type cb_close from commandbutton within w_alloy_heat_treatment
end type
type cb_save from commandbutton within w_alloy_heat_treatment
end type
type cb_add from commandbutton within w_alloy_heat_treatment
end type
type cb_print from commandbutton within w_alloy_heat_treatment
end type
type dw_alloy_heat_treatment from u_dw within w_alloy_heat_treatment
end type
end forward

global type w_alloy_heat_treatment from w_sheet
integer width = 1419
integer height = 2256
string title = "Alloy Heat Treatment"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
st_1 st_1
dw_name dw_name
cb_1 cb_1
cb_close cb_close
cb_save cb_save
cb_add cb_add
cb_print cb_print
dw_alloy_heat_treatment dw_alloy_heat_treatment
end type
global w_alloy_heat_treatment w_alloy_heat_treatment

type variables
Long	il_new_row
end variables

forward prototypes
protected function boolean wf_validate_data (ref string as_alloy_error_string)
end prototypes

event type string ue_whoami();Return "w_alloy_heat_treatment"
end event

protected function boolean wf_validate_data (ref string as_alloy_error_string);/*
Function:	wf_validate_data
Returns:		boolean	True  if OK to save
							False if not OK to save
Arguments:	reference	string	as_alloy_error_string					
*/

Boolean	lb_ok_2save = True
Long		ll_rows, ll_row
Integer	li_alloy_blank_count, li_i
String	ls_old_sort, ls_alloy, ls_heat_treated, ls_alloy_prev, ls_alloy_dup[], ls_alloy_dup_final[], ls_alloy_dup_string
String	ls_alloy_save[], ls_heat_treated_save[]

dw_alloy_heat_treatment.AcceptText()
ll_rows = dw_alloy_heat_treatment.RowCount()
ls_old_sort = dw_alloy_heat_treatment.Describe("Datawindow.Table.sort")

dw_alloy_heat_treatment.SetSort("alloy asc")
dw_alloy_heat_treatment.Sort()

ls_alloy_prev = ""

For ll_row = 1 To ll_rows
	ls_alloy = Trim(dw_alloy_heat_treatment.Object.alloy[ll_row])
	If IsNull(ls_alloy) Then ls_alloy = ""
	
	If ls_alloy = "" Then
		li_alloy_blank_count++
	Else
		If ls_alloy = ls_alloy_prev Then
			ls_alloy_dup[UpperBound(ls_alloy_dup[]) + 1] = ls_alloy
		End If
	End If
	
	ls_alloy_prev = ls_alloy
Next

If li_alloy_blank_count > 0 Then
	If li_alloy_blank_count > 1 Then
		lb_ok_2save = False
		as_alloy_error_string = "There are " + String(li_alloy_blank_count) + " blank alloys"
	Else //li_alloy_blank_count = 1
		lb_ok_2save = False
		as_alloy_error_string = "There is 1 blank alloy"
	End If
End If

IF UpperBound(ls_alloy_dup[]) > 0 Then //There are alloy duplicates

	//Remove dups
	ls_alloy_prev = ""
	
	For li_i = 1 To UpperBound(ls_alloy_dup[])
		ls_alloy = ls_alloy_dup[li_i]
		
		If ls_alloy <> ls_alloy_prev Then
			ls_alloy_dup_final[UpperBound(ls_alloy_dup_final[]) + 1] = ls_alloy
		End If
		
		ls_alloy_prev = ls_alloy
	Next

	lb_ok_2save = False
	
	For li_i = 1 To UpperBound(ls_alloy_dup_final[])
		ls_alloy = ls_alloy_dup_final[li_i]
		ls_alloy_dup_string = ls_alloy_dup_string + ls_alloy + ", "
	Next
	
	//Remove the last comma
	ls_alloy_dup_string = Left(ls_alloy_dup_string, Len(ls_alloy_dup_string) - 2)
	ls_alloy_dup_string = "Duplicate alloys: " + ls_alloy_dup_string
	
	as_alloy_error_string = as_alloy_error_string + "~n~r~n~r" + ls_alloy_dup_string
End If

////Restore original sort
//dw_alloy_heat_treatment.SetSort(ls_old_sort)
//dw_alloy_heat_treatment.Sort()

Return lb_ok_2save
end function

on w_alloy_heat_treatment.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_name=create dw_name
this.cb_1=create cb_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_print=create cb_print
this.dw_alloy_heat_treatment=create dw_alloy_heat_treatment
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_name
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.dw_alloy_heat_treatment
end on

on w_alloy_heat_treatment.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_name)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_print)
destroy(this.dw_alloy_heat_treatment)
end on

event open;call super::open;dw_alloy_heat_treatment.SetTransObject(sqlca)
dw_alloy_heat_treatment.Retrieve()

//dw_alloy_heat_treatment.SetFocus()
//dw_alloy_heat_treatment.ScrollToRow(1)
//dw_alloy_heat_treatment.SetRow(1)
//dw_alloy_heat_treatment.SetColumn("alloy")

cb_1.Visible = False //This is to establish window's size

dw_name.SetFocus()

dw_name.InsertRow(0)
end event

event pfc_postopen;call super::pfc_postopen;This.X = 100
This.Y = 0
This.Width = 1412
This.Height = 2192

dw_alloy_heat_treatment.Width = 772
dw_alloy_heat_treatment.Height = 1904
end event

event closequery;// Edit/Extend Ancestor Script is tunrned off

Boolean	lb_rtn
Integer	li_rtn, li_answer
Long		ll_modifiedcount
String	ls_alloy_error_string

dw_alloy_heat_treatment.AcceptText()
ll_modifiedcount = dw_alloy_heat_treatment.ModifiedCount()

If ll_modifiedcount > 0 Then
	li_answer = MessageBox("Save?", "Do you want to save changes?", Question!, YesNoCancel!, 1)
	
	Choose Case li_answer
		Case 1 //Yes
			lb_rtn = wf_validate_data(ls_alloy_error_string)
			
			Choose Case lb_rtn
				Case True //Data OK
					//Fall through to save
				Case Else //Data have errors
					MessageBox("Data error. Cannot save.", "Errors:~n~r" + ls_alloy_error_string + &
											"~n~r~n~rPlease correct.", StopSign!)
											
					Return 1 //Prevent the window from closing
			End Choose
			
			li_rtn = dw_alloy_heat_treatment.Update()

			If li_rtn = 1 Then //OK
				commit using sqlca;
			Else //Error
				rollback using sqlca;
			End If
		Case 2 //No
			Return 0 //Allow the window to be closed
		Case 3 //Cancel
			Return 1 //Prevent the window from closing
	End Choose
End If


end event

type st_1 from statictext within w_alloy_heat_treatment
integer x = 113
integer y = 6
integer width = 187
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filter"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_name from datawindow within w_alloy_heat_treatment
integer x = 311
integer width = 603
integer height = 77
integer taborder = 20
string title = "none"
string dataobject = "d_name"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String	ls_data, ls_filter_string, ls_rtn
Integer	li_rtn
Long		ll_rows, ll_filteredcount

ls_data = Lower(data)

If Len(ls_data) > 0 Then
	ls_filter_string = "Lower(alloy) like '" + ls_data + "%'"
Else
	ls_filter_string = ""
End If


li_rtn = dw_alloy_heat_treatment.SetFilter(ls_filter_string)
li_rtn = dw_alloy_heat_treatment.Filter()

dw_alloy_heat_treatment.SetSort("alloy Asc")
dw_alloy_heat_treatment.Sort()

end event

type cb_1 from commandbutton within w_alloy_heat_treatment
integer x = 1035
integer y = 912
integer width = 139
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;MessageBox("", "Window Width = " + String(Parent.Width) + "~n~rWindow Height = " + String(Parent.Height) + &
		"~n~rDW Width = " + String(dw_alloy_heat_treatment.Width) + "~n~rDW Height = " + String(dw_alloy_heat_treatment.Height))
end event

type cb_close from commandbutton within w_alloy_heat_treatment
integer x = 1002
integer y = 755
integer width = 208
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Parent.Event pfc_close()


end event

type cb_save from commandbutton within w_alloy_heat_treatment
integer x = 1002
integer y = 557
integer width = 208
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;Boolean	lb_rtn
String	ls_alloy_error_string
Long		ll_rows, ll_row, ll_row_inserted
String	ls_alloy, ls_heat_treated
String	ls_alloy_save[], ls_heat_treated_save[]

Integer	li_rtn

dw_alloy_heat_treatment.AcceptText()

lb_rtn = wf_validate_data(ls_alloy_error_string)

If Not lb_rtn Then
	MessageBox("Data error. Cannot save.", "Errors:~n~r" + ls_alloy_error_string + &
							"~n~r~n~rPlease correct.", StopSign!)
	Return
End If

li_rtn = dw_alloy_heat_treatment.Update()

If li_rtn = 1 Then //OK
	commit using sqlca;
Else //Error
	rollback using sqlca;
End If


end event

type cb_add from commandbutton within w_alloy_heat_treatment
integer x = 1002
integer y = 301
integer width = 208
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;Long		ll_last_row, ll_row, ll_skid_dims_id
Integer	li_scrap_type
String	ls_alloy

dw_alloy_heat_treatment.AcceptText()
ll_last_row = dw_alloy_heat_treatment.RowCount()



ls_alloy = dw_alloy_heat_treatment.Object.alloy[ll_last_row]
If IsNull(ls_alloy) Then ls_alloy = ""

If ls_alloy = "" Then
	dw_alloy_heat_treatment.SetFocus()
	dw_alloy_heat_treatment.ScrollToRow(ll_last_row)
	dw_alloy_heat_treatment.SetRow(ll_last_row)
	dw_alloy_heat_treatment.SetColumn("alloy")
	
	Return
End If

//---

ll_row = dw_alloy_heat_treatment.Event pfc_addrow()

If ll_row > 0 Then
	il_new_row = ll_row
	dw_alloy_heat_treatment.Object.heat_treated[ll_row] = "Y" //Pre-populate with "Y" - Heat Treated
	dw_alloy_heat_treatment.SetFocus()
	dw_alloy_heat_treatment.ScrollToRow(ll_row)
	dw_alloy_heat_treatment.SetRow(ll_row)
	dw_alloy_heat_treatment.SetColumn("alloy")
End If



end event

type cb_print from commandbutton within w_alloy_heat_treatment
integer x = 1002
integer y = 435
integer width = 208
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

event clicked;
dw_alloy_heat_treatment.Event pfc_print()


end event

type dw_alloy_heat_treatment from u_dw within w_alloy_heat_treatment
integer x = 143
integer y = 96
integer width = 764
integer height = 1904
integer taborder = 10
string dataobject = "d_alloy_heat_treatment"
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
end event

event itemchanged;call super::itemchanged;//String	ls_column_name, ls_data
//String	ls_find_string, ls_alloy_prev, ls_null
//Long		ll_found_row, ll_counter
//Integer	li_scrap_type_prev, li_null
//
////MessageBox("", "ItemChanged for dw_alloy_heat_treatment of w_scrap_type")
//
//SetNull(li_null)
//SetNull(ls_null)
//
//This.AcceptText()
//ls_column_name = dwo.name
//ls_data = Trim(data)
//
//Choose Case ls_column_name
//	Case "alloy"
//		If ls_data = "" Then
//			Return 1 //Reject the data value and do not allow focus to change
//		End If
//		
//		ls_find_string = "Lower(alloy) = Lower('" + ls_data + "')"
//		ll_found_row = dw_alloy_heat_treatment.Find(ls_find_string, 1, dw_alloy_heat_treatment.RowCount())
//		
//		Do While ll_found_row > 0
//			ll_counter++
//			If ll_found_row + 1 > dw_alloy_heat_treatment.RowCount() Then Exit
//			
//			ll_found_row = dw_alloy_heat_treatment.Find(ls_find_string, ll_found_row + 1, dw_alloy_heat_treatment.RowCount())
//		Loop
//		
//		If ll_counter > 1 Then
//			MessageBox("Data Error", "Duplicate alloy. Please correct.")
//			ls_alloy_prev = This.GetItemString(row, "alloy", Primary!, True)
//			
//			If row = il_new_row Then
//				This.Object.alloy[row] = ls_null
//			Else
//				This.Object.alloy[row] = ls_alloy_prev
//			End if
//			
//			Return 1 //Reject the data value and do not allow focus to change
//		End If
//End Choose
end event

event itemfocuschanged;call super::itemfocuschanged;////MessageBox("", "ItemFocusChanged for dw_scrap_type_desc of w_scrap_type")
//
//String	ls_column_name, ls_data
//String	ls_scrap_type, ls_find_string, ls_scrap_type_desc, ls_scrap_type_desc_prev
//Long		ll_row, ll_found_row, ll_counter
//Integer	li_scrap_type, li_scrap_type_prev
//
//ll_row = row - 1
//If ll_row <= 0 Then Return 1
//
//This.AcceptText()
//ls_column_name = dwo.name
////ls_data = Trim(data)
//
//Choose Case ls_column_name
//	Case "scrap_type"
//		li_scrap_type = This.Object.scrap_type[ll_row]
//		
//		If IsNull(li_scrap_type) Then
//			Return 1 //Reject the data value and do not allow focus to change
//		End If
//		
//		//If Not IsNumber(ls_data) Or ls_data = "0" Then
//		//	Return 1 //Reject the data value and do not allow focus to change
//		//End If
//		
//		ls_find_string = "scrap_type = " + String(li_scrap_type)
//		ll_found_row = dw_scrap_type_desc.Find(ls_find_string, 1, dw_scrap_type_desc.RowCount())
//		
//		Do While ll_found_row > 0
//			ll_counter++
//			ll_found_row = dw_scrap_type_desc.Find(ls_find_string, ll_found_row + 1, dw_scrap_type_desc.RowCount())
//		Loop
//		
//		If ll_counter > 1 Then
//			MessageBox("Data Error", "Duplicate Scrap Type. Please correct.")
//			li_scrap_type_prev = This.GetItemNumber(row, "scrap_type", Primary!, True)
//			This.Object.scrap_type[row] = li_scrap_type_prev
//			Return 2 //Reject the data value but allow the focus to change
//		End If
//	Case "scrap_type_desc"
//		ls_scrap_type_desc = This.Object.scrap_type_desc[ll_row]
//		
//		If IsNull(ls_scrap_type_desc) Then
//			Return 1 //Reject the data value and do not allow focus to change
//		End If
//		
//		//If ls_data = "" Then
//		//	Return 1 //Reject the data value and do not allow focus to change
//		//End If
//		
//		ls_find_string = "scrap_type_desc = '" + ls_scrap_type_desc + "'"
//		ll_found_row = dw_scrap_type_desc.Find(ls_find_string, 1, dw_scrap_type_desc.RowCount())
//		
//		Do While ll_found_row > 0
//			ll_counter++
//			ll_found_row = dw_scrap_type_desc.Find(ls_find_string, ll_found_row + 1, dw_scrap_type_desc.RowCount())
//		Loop
//		
//		If ll_counter > 1 Then
//			MessageBox("Data Error", "Duplicate Scrap Type Description. Please correct.")
//			ls_scrap_type_desc_prev = This.GetItemString(row, "scrap_type_desc", Primary!, True)
//			This.Object.scrap_type_desc[row] = ls_scrap_type_desc_prev
//			Return 2 //Reject the data value but allow the focus to change
//		End If
//End Choose
end event

