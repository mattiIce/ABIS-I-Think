$PBExportHeader$w_sheet_package.srw
forward
global type w_sheet_package from w_sheet
end type
type cb_clear from commandbutton within w_sheet_package
end type
type st_history_header from statictext within w_sheet_package
end type
type dw_sheet_skid_package_history from u_dw within w_sheet_package
end type
type cb_new_package_num from commandbutton within w_sheet_package
end type
type dw_sheet_skid_package from u_dw within w_sheet_package
end type
type cb_retrieve from commandbutton within w_sheet_package
end type
type cb_close from commandbutton within w_sheet_package
end type
end forward

global type w_sheet_package from w_sheet
string tag = "Display/Update Customer Package Number"
integer width = 2417
integer height = 995
string title = "Display/Update Customer Package Number"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
event type string ue_whoami ( )
cb_clear cb_clear
st_history_header st_history_header
dw_sheet_skid_package_history dw_sheet_skid_package_history
cb_new_package_num cb_new_package_num
dw_sheet_skid_package dw_sheet_skid_package
cb_retrieve cb_retrieve
cb_close cb_close
end type
global w_sheet_package w_sheet_package

event type string ue_whoami();Return "w_sheet_package"
end event

on w_sheet_package.create
int iCurrent
call super::create
this.cb_clear=create cb_clear
this.st_history_header=create st_history_header
this.dw_sheet_skid_package_history=create dw_sheet_skid_package_history
this.cb_new_package_num=create cb_new_package_num
this.dw_sheet_skid_package=create dw_sheet_skid_package
this.cb_retrieve=create cb_retrieve
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_clear
this.Control[iCurrent+2]=this.st_history_header
this.Control[iCurrent+3]=this.dw_sheet_skid_package_history
this.Control[iCurrent+4]=this.cb_new_package_num
this.Control[iCurrent+5]=this.dw_sheet_skid_package
this.Control[iCurrent+6]=this.cb_retrieve
this.Control[iCurrent+7]=this.cb_close
end on

on w_sheet_package.destroy
call super::destroy
destroy(this.cb_clear)
destroy(this.st_history_header)
destroy(this.dw_sheet_skid_package_history)
destroy(this.cb_new_package_num)
destroy(this.dw_sheet_skid_package)
destroy(this.cb_retrieve)
destroy(this.cb_close)
end on

event open;call super::open;dw_sheet_skid_package.SetTransObject(sqlca)
dw_sheet_skid_package_history.SetTransObject(sqlca)
dw_sheet_skid_package.InsertRow(0)
dw_sheet_skid_package.SetFocus()


end event

event pfc_postopen;call super::pfc_postopen;This.Width = 2410
This.height = 1031
end event

event closequery;Return 0 //Allow the window to be closed
end event

type cb_clear from commandbutton within w_sheet_package
integer x = 1152
integer y = 685
integer width = 450
integer height = 102
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear"
end type

event clicked;dw_sheet_skid_package.Reset()
dw_sheet_skid_package_history.Reset()
dw_sheet_skid_package.InsertRow(0)
dw_sheet_skid_package.SetFocus()

end event

type st_history_header from statictext within w_sheet_package
integer x = 907
integer y = 99
integer width = 1456
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_sheet_skid_package_history from u_dw within w_sheet_package
integer x = 907
integer y = 179
integer width = 1419
integer height = 371
integer taborder = 10
string dataobject = "d_sheet_skid_package_history"
end type

event dberror;call super::dberror;MessageBox("Database Error", "Database Error occurred while updating table sheet_skid_package_hsitory~n~r~n~r" + &
										"Error:~n~r" + sqlerrtext, StopSign!)


Return 1 //Do not display the system error message
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

type cb_new_package_num from commandbutton within w_sheet_package
integer x = 600
integer y = 685
integer width = 450
integer height = 102
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "New Package Num"
end type

event clicked;Long		ll_sheet_skid_num, ll_package_num, ll_inserted_row
Boolean	lb_use_package_num
String	ls_customer_short_name
Integer	li_rtn

dw_sheet_skid_package.AcceptText()
ll_sheet_skid_num = Long(dw_sheet_skid_package.Object.sheet_skid_num_display[1])

li_rtn = MessageBox("Are you sure?",	"You are just about to update customer package number for skid " + String(ll_sheet_skid_num) + &
										"~n~rOnce you click on 'Yes', customer package number will be saved immediately." + &
										"~n~r~n~rDo you want to continue?", Question!, YesNo!, 2)

If li_rtn = 2 Then
	Return
End If

f_get_use_package_num_4skid(ll_sheet_skid_num, sqlca, ls_customer_short_name, lb_use_package_num)

If Not lb_use_package_num Then
	MessageBox("No Package Number Customer", "This customer " + ls_customer_short_name + " does not support Package Number...Exiting.")
	Return
End If

li_rtn = f_get_package_num_min_max(sqlca)

If li_rtn = -1 Then //Error message is in f_get_package_num_min_max()
	Return
End If

li_rtn = f_get_next_package_num(sqlca, ll_package_num) //li_rtn = sqlca.sqlcode in f_get_next_package_num()

If li_rtn <> 0 Then
	Return -1
End If

dw_sheet_skid_package.Object.sheet_skid_num[1] = ll_sheet_skid_num
dw_sheet_skid_package.Object.package_num[1] = ll_package_num

ll_inserted_row = dw_sheet_skid_package_history.InsertRow(0)

If ll_inserted_row > 0 Then
	dw_sheet_skid_package_history.Object.sheet_skid_num[ll_inserted_row] = ll_sheet_skid_num
	dw_sheet_skid_package_history.Object.package_num[ll_inserted_row] = ll_package_num
	dw_sheet_skid_package_history.Object.change_user[ll_inserted_row] = sqlca.logid
	dw_sheet_skid_package_history.Object.change_date_time[ll_inserted_row] = DateTime(Today(), Now())
End If

li_rtn = dw_sheet_skid_package.Update()

If li_rtn = 1 Then
	li_rtn = dw_sheet_skid_package_history.Update()
	
	If li_rtn = 1 Then
		commit using sqlca;
		cb_retrieve.Event Clicked()
		dw_sheet_skid_package.SetItemStatus(1, 0, Primary!, NotModified!)
		
		//MessageBox("New Package Number saved",	"New Package Number " + String(ll_package_num) + " for skid " + String(ll_sheet_skid_num) + " saved successfully")
	Else
		rollback using sqlca; //Error message is in dberror event for dw_sheet_skid_package_history
	End If
Else
	rollback using sqlca; //Error message is in dberror event for dw_sheet_skid_package
End If

//update	dbo.sheet_skid_package
//set		package_num = :ll_sheet_skid_num
//using		sqlca;
//	
//If sqlca.sqlcode = 0 Then //OK
//
//Else //DB error
//	MessageBox("DB Error", "Database error occurred in Clicked event for w_sheet_package while trying to update " + &
//									"table sheet_skid_package for skid " + String(ll_sheet_skid_num) + &
//									"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, &
//									StopSign!)
//End If
end event

type dw_sheet_skid_package from u_dw within w_sheet_package
integer x = 59
integer y = 179
integer width = 757
integer height = 307
integer taborder = 10
string dataobject = "d_sheet_skid_package"
boolean vscrollbar = false
boolean livescroll = false
end type

event retrieveend;call super::retrieveend;Long	ll_rowcount, ll_sheet_skid_num

ll_rowcount = rowcount

If ll_rowcount = 1 Then //There is supposed to be 1 row for a sheet_skid_num
	ll_sheet_skid_num = dw_sheet_skid_package.Object.sheet_skid_num[1]
	dw_sheet_skid_package.Object.sheet_skid_num_display[1] = String(ll_sheet_skid_num)
End If
end event

event dberror;call super::dberror;MessageBox("Database Error", "Database Error occurred while updating table sheet_skid_package~n~r~n~r" + &
										"Error:~n~r" + sqlerrtext, StopSign!)


Return 1 //Do not display the system error message
end event

event itemchanged;call super::itemchanged;String	ls_column_name

ls_column_name = dwo.name

If ls_column_name = "sheet_skid_num_display" Then
	cb_retrieve.Event Clicked()
End If
end event

type cb_retrieve from commandbutton within w_sheet_package
integer x = 62
integer y = 685
integer width = 450
integer height = 102
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
boolean default = true
end type

event clicked;Long		ll_sheet_skid_num, ll_rows, ll_inserted_row
Integer	li_counter
String	ls_text

dw_sheet_skid_package.AcceptText()
cb_new_package_num.Enabled = True
dw_sheet_skid_package_history.Reset()
st_history_header.Text = ""

//dw_sheet_skid_package.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ll_rows = dw_sheet_skid_package.RowCount()

ll_sheet_skid_num = Long(dw_sheet_skid_package.Object.sheet_skid_num_display[1])
ll_rows = dw_sheet_skid_package.Retrieve(ll_sheet_skid_num)

If ll_rows > 0 Then
	dw_sheet_skid_package.SetItemStatus(1, 0, Primary!, NotModified!)
	dw_sheet_skid_package.Object.sheet_skid_num_display[1] = String(dw_sheet_skid_package.Object.sheet_skid_num[1])
	ll_rows = dw_sheet_skid_package_history.Retrieve(ll_sheet_skid_num)
	st_history_header.Text = "Customer package number change history for skid " + String(ll_sheet_skid_num)
Else
	ll_inserted_row = dw_sheet_skid_package.InsertRow(0)
	
	If ll_inserted_row > 0 Then
		dw_sheet_skid_package.Object.sheet_skid_num_display[ll_inserted_row] = String(ll_sheet_skid_num)
		dw_sheet_skid_package.SetColumn("sheet_skid_num_display")
		
		
		//Check if ll_sheet_skid_num exists on sheet_skid table. If it doesn't, tell the user.
		select	count(*)
		into		:li_counter
		from		sheet_skid
		where		sheet_skid_num = :ll_sheet_skid_num
		using		sqlca;
		
		If li_counter > 0 Then //ll_sheet_skid_num exists on sheet_skid table
			//
		Else //ll_sheet_skid_num does not exist on sheet_skid table
			dw_sheet_skid_package_history.Reset()
			st_history_header.Text = ""
			cb_new_package_num.Enabled = False
			MessageBox("Skid does not exist", "Skid " + String(ll_sheet_skid_num) + " does not exist")
		End If
		
		dw_sheet_skid_package.SetFocus()
		dw_sheet_skid_package.SetColumn("sheet_skid_num_display")
	End If
End If
end event

type cb_close from commandbutton within w_sheet_package
integer x = 1891
integer y = 685
integer width = 450
integer height = 102
integer taborder = 10
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

