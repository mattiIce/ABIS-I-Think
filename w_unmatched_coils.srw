$PBExportHeader$w_unmatched_coils.srw
forward
global type w_unmatched_coils from w_sheet
end type
type dw_unmatched_coils from u_dw within w_unmatched_coils
end type
type cb_close from commandbutton within w_unmatched_coils
end type
type cb_print from commandbutton within w_unmatched_coils
end type
end forward

global type w_unmatched_coils from w_sheet
integer width = 2245
integer height = 1232
string title = "Unmatched Coils"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_unmatched_coils dw_unmatched_coils
cb_close cb_close
cb_print cb_print
end type
global w_unmatched_coils w_unmatched_coils

on w_unmatched_coils.create
int iCurrent
call super::create
this.dw_unmatched_coils=create dw_unmatched_coils
this.cb_close=create cb_close
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_unmatched_coils
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_print
end on

on w_unmatched_coils.destroy
call super::destroy
destroy(this.dw_unmatched_coils)
destroy(this.cb_close)
destroy(this.cb_print)
end on

event open;call super::open;DataStore	lds_unmatched_coils
Long			ll_row

lds_unmatched_coils = Message.PowerObjectParm

lds_unmatched_coils.RowCount()
lds_unmatched_coils.RowsCopy(1, lds_unmatched_coils.RowCount(), Primary!, dw_unmatched_coils, 1, Primary!)

For ll_row = 1 To dw_unmatched_coils.RowCount()
	dw_unmatched_coils.SetItemStatus(ll_row, 0, Primary!, NotModified!)
Next
end event

event pfc_print;call super::pfc_print;Return dw_unmatched_coils.Event pfc_print()
end event

type dw_unmatched_coils from u_dw within w_unmatched_coils
integer x = 22
integer width = 2183
integer height = 1030
integer taborder = 10
string dataobject = "d_unmatched_coils"
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

type cb_close from commandbutton within w_unmatched_coils
integer x = 1214
integer y = 1053
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

event clicked;Close(Parent)
end event

type cb_print from commandbutton within w_unmatched_coils
integer x = 684
integer y = 1053
integer width = 322
integer height = 90
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;Parent.Event pfc_print()
end event

