$PBExportHeader$w_buildfilter_order_entry.srw
$PBExportComments$<Response>  Building Dynamic Filter Expressions using the base DataWindow service used only in order_entry
forward
global type w_buildfilter_order_entry from w_main
end type
type gb_4 from groupbox within w_buildfilter_order_entry
end type
type gb_3 from groupbox within w_buildfilter_order_entry
end type
type dw_1 from u_dw within w_buildfilter_order_entry
end type
type cb_cancel from u_cb within w_buildfilter_order_entry
end type
type cb_reset from u_cb within w_buildfilter_order_entry
end type
type st_6 from u_st within w_buildfilter_order_entry
end type
type mle_2 from u_mle within w_buildfilter_order_entry
end type
type ddlb_column from u_ddlb within w_buildfilter_order_entry
end type
type cb_apply from u_cb within w_buildfilter_order_entry
end type
type dw_search from u_dw within w_buildfilter_order_entry
end type
type cb_add from u_cb within w_buildfilter_order_entry
end type
type cb_remove from u_cb within w_buildfilter_order_entry
end type
type gb_1 from groupbox within w_buildfilter_order_entry
end type
type st_1 from u_st within w_buildfilter_order_entry
end type
type ddlb_shape from u_ddlb within w_buildfilter_order_entry
end type
type st_3 from u_st within w_buildfilter_order_entry
end type
type ddlb_parts from u_ddlb within w_buildfilter_order_entry
end type
type ddlb_cust from u_ddlb within w_buildfilter_order_entry
end type
type st_2 from statictext within w_buildfilter_order_entry
end type
type gb_2 from u_gb within w_buildfilter_order_entry
end type
end forward

global type w_buildfilter_order_entry from w_main
integer x = 819
integer y = 486
integer width = 2059
integer height = 1254
string title = "Order Entry Filter Expressions"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
event ue_buildexpr1 ( )
gb_4 gb_4
gb_3 gb_3
dw_1 dw_1
cb_cancel cb_cancel
cb_reset cb_reset
st_6 st_6
mle_2 mle_2
ddlb_column ddlb_column
cb_apply cb_apply
dw_search dw_search
cb_add cb_add
cb_remove cb_remove
gb_1 gb_1
st_1 st_1
ddlb_shape ddlb_shape
st_3 st_3
ddlb_parts ddlb_parts
ddlb_cust ddlb_cust
st_2 st_2
gb_2 gb_2
end type
global w_buildfilter_order_entry w_buildfilter_order_entry

type variables
s_colname_header istr_ch[]
DataStore ids_cust
end variables

forward prototypes
public subroutine wf_init_customer ()
end prototypes

public subroutine wf_init_customer ();Long ll_row, ll_i
DataStore lds_u

lds_u = CREATE DataStore
lds_u.DataObject = "d_dddw_id_short"
lds_u.SetTransObject(SQLCA)
lds_u.Retrieve()

ddlb_cust.AddItem("ALL CUSTOMERS")
ll_row = lds_u.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		 ddlb_cust.AddItem(lds_u.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF

DESTROY lds_u

end subroutine

on w_buildfilter_order_entry.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_reset)
destroy(this.st_6)
destroy(this.mle_2)
destroy(this.ddlb_column)
destroy(this.cb_apply)
destroy(this.dw_search)
destroy(this.cb_add)
destroy(this.cb_remove)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.ddlb_shape)
destroy(this.st_3)
destroy(this.ddlb_parts)
destroy(this.ddlb_cust)
destroy(this.st_2)
destroy(this.gb_2)
end on

on w_buildfilter_order_entry.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.gb_3=create gb_3
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_reset=create cb_reset
this.st_6=create st_6
this.mle_2=create mle_2
this.ddlb_column=create ddlb_column
this.cb_apply=create cb_apply
this.dw_search=create dw_search
this.cb_add=create cb_add
this.cb_remove=create cb_remove
this.gb_1=create gb_1
this.st_1=create st_1
this.ddlb_shape=create ddlb_shape
this.st_3=create st_3
this.ddlb_parts=create ddlb_parts
this.ddlb_cust=create ddlb_cust
this.st_2=create st_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_reset
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.mle_2
this.Control[iCurrent+8]=this.ddlb_column
this.Control[iCurrent+9]=this.cb_apply
this.Control[iCurrent+10]=this.dw_search
this.Control[iCurrent+11]=this.cb_add
this.Control[iCurrent+12]=this.cb_remove
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.ddlb_shape
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.ddlb_parts
this.Control[iCurrent+18]=this.ddlb_cust
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.gb_2
end on

event open;call super::open;dw_1.DataObject = Message.StringParm
dw_1.SetTransObject(SQLCA)

// Build the list of columns.

integer li_colcount
integer li_idx, li_i
string	ls_colname, ls_type
s_dw_header_type lstr_ht
Window lw_parent

li_i = 1
lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	li_colcount = Integer( dw_1.Object.DataWindow.Column.Count )
	For li_idx = 1 to li_colcount
		ls_colname = dw_1.Describe("#"+ string(li_idx) +".Name")
		ls_type = dw_1.Describe("#"+ string(li_idx) +".ColType")
		If len(ls_colname) > 0 Then
			lstr_ht = lw_Parent.Event Dynamic ue_get_header(ls_colname)
			CHOOSE CASE lstr_ht.dw_header
				CASE "NULL"
					//nothing
				CASE "Shape"
					//nothing
				CASE "Customer"
					//nothing
				CASE ELSE
					ddlb_column.AddItem(lstr_ht.dw_header)
					istr_ch[li_i].col_name = ls_colname
					istr_ch[li_i].dw_header = lstr_ht.dw_header
					istr_ch[li_i].col_type = lstr_ht.col_type
					li_i++
			END CHOOSE
		End If
	Next
END IF
ddlb_shape.SelectItem(1)

wf_init_customer()
ddlb_cust.SelectItem(1)
end event

type gb_4 from groupbox within w_buildfilter_order_entry
integer x = 77
integer y = 253
integer width = 1485
integer height = 202
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Column"
end type

type gb_3 from groupbox within w_buildfilter_order_entry
integer x = 889
integer y = 51
integer width = 1079
integer height = 202
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Shape"
end type

type dw_1 from u_dw within w_buildfilter_order_entry
integer x = 1752
integer y = 768
integer width = 121
integer height = 35
integer taborder = 0
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	constructor
//
//	Description:
//	Initializes the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetTransObject(sqlca)

of_SetRowSelect(true)
of_SetUpdateable(false)

of_Retrieve()

end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	rowfocuschanged
//
//	Description:
//	Set the row value in grouping one equal to the current row number.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


end event

event pfc_retrieve;call super::pfc_retrieve;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	pfc_retrieve
//
//	Arguments:
//	None
//
//	Returns:
//	long
//	The number of rows retrieved from the database
// -1 if it fails
// If any argument's value is NULL, pfc_retrieve returns NULL
//
//	Description:
//	Retrieves data into the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return this.Retrieve()
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	pfc_prermbmenu
//
//	Arguments:
//	am_dw   	the menu that will be displayed when the DataWindow
//				is right clicked.
//
//	Returns:
//	None
//
//	Description:
// Initialize the Right Mouse Menu for the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

am_dw.m_table.m_insert.enabled = false
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_delete.enabled = false
end event

type cb_cancel from u_cb within w_buildfilter_order_entry
integer x = 1262
integer y = 1059
integer width = 424
integer height = 83
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_reset from u_cb within w_buildfilter_order_entry
integer x = 775
integer y = 1059
integer width = 424
integer height = 83
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "C&lear Search"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	clicked
//
//	Description:
//	Sets the filter to the expression created by of_BuildExpression(), then
// applies the filter to the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////

dw_search.Reset()
dw_search.ResetUpdate()
cb_apply.Enabled = FALSE
end event

type st_6 from u_st within w_buildfilter_order_entry
integer x = 117
integer y = 304
integer height = 77
boolean bringtotop = true
string text = "Select Column:"
end type

type mle_2 from u_mle within w_buildfilter_order_entry
integer x = 48
integer y = 1002
integer width = 1832
integer height = 54
integer taborder = 0
boolean bringtotop = true
long backcolor = 79741120
string text = "You can also build a dynamic search expression with a column, operator and value."
boolean border = false
boolean autovscroll = false
boolean displayonly = true
borderstyle borderstyle = stylebox!
end type

type ddlb_column from u_ddlb within w_buildfilter_order_entry
integer x = 121
integer y = 355
integer width = 1039
integer height = 506
integer taborder = 10
boolean bringtotop = true
boolean sorted = false
end type

type cb_apply from u_cb within w_buildfilter_order_entry
integer x = 289
integer y = 1059
integer width = 424
integer height = 83
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Apply Search"
boolean default = true
end type

event clicked;Window lw_parent
Int li_row, li_i
String ls_s

dw_search.AcceptText()
dw_search.ResetUpdate()
lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
li_row = dw_search.rowCount()
IF li_row > 0 THEN
	FOR li_i = 1 TO li_row
		ls_s = dw_search.GetItemString(li_i, "value_t", Primary!, FALSE)
		IF (Len(ls_s) < 1) OR IsNULL(ls_s)  THEN
			MessageBox("Warning", dw_search.GetItemString(li_i, "column_t", Primary!, FALSE) + " has no value yet." )
			RETURN 0
		END IF
	NEXT
ELSE			
	MessageBox("Warning", "Nothing to search here.")
	RETURN -1
END IF

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	lw_Parent.Dynamic Event ue_set_search(dw_search)
END IF

Close(parent)
end event

type dw_search from u_dw within w_buildfilter_order_entry
integer x = 77
integer y = 467
integer width = 1902
integer height = 509
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_search_dw_order_entry"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetUpdateable(false)

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//override
RETURN 0
end event

event losefocus;this.AcceptText()
this.ResetUpdate()
end event

type cb_add from u_cb within w_buildfilter_order_entry
integer x = 1185
integer y = 355
integer width = 351
integer height = 80
integer taborder = 70
boolean bringtotop = true
string text = "&Add"
end type

event clicked;String ls_s, ls_colname, ls_type
Int li_i, ll_row

ls_s = ddlb_column.text

li_i = 1
DO WHILE li_i <= UpperBound(istr_ch)
	IF Trim(istr_ch[li_i].dw_header) = Trim(ls_s) THEN
		ls_type = istr_ch[li_i].col_type
		ll_row = dw_search.InsertRow(0)
		dw_search.SetItem(ll_row, "column_t", ls_s)
		dw_search.SetItem(ll_row, "operator_t", "=")
		CHOOSE CASE UPPER(Trim(ls_type))
			CASE "STRING"
				dw_search.SetItem(ll_row, "format_t", "2")
			CASE "NUMBER"
				dw_search.SetItem(ll_row, "format_t", "1")
			CASE "DATE"
				dw_search.SetItem(ll_row, "format_t", "3")
			CASE "STATUS"
				dw_search.SetItem(ll_row, "format_t", "4")
			CASE "CUSTOMER"
				dw_search.SetItem(ll_row, "format_t", "5")
			CASE "CARRIER"
				dw_search.SetItem(ll_row, "format_t", "5")
			CASE "VEHICLE_STATUS"
				dw_search.SetItem(ll_row, "format_t", "4")
			CASE ELSE
				dw_search.SetItem(ll_row, "format_t", "2")				
		END CHOOSE
		cb_apply.Enabled = TRUE
	End If
	li_i++
LOOP


end event

type cb_remove from u_cb within w_buildfilter_order_entry
integer x = 1595
integer y = 355
integer width = 351
integer height = 80
integer taborder = 80
boolean bringtotop = true
string text = "&Remove"
end type

event clicked;Long ll_row
ll_row = dw_search.GetRow()
IF ll_row > 0 THEN
	dw_search.deleterow(ll_row)
	IF dw_search.RowCount() < 1 THEN cb_apply.Enabled = FALSE
	dw_search.AcceptText()
	dw_search.ResetUpdate()
END IF
end event

type gb_1 from groupbox within w_buildfilter_order_entry
integer x = 77
integer y = 51
integer width = 790
integer height = 202
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Customer"
end type

type st_1 from u_st within w_buildfilter_order_entry
integer x = 911
integer y = 99
boolean bringtotop = true
string text = "Select Shape:"
end type

type ddlb_shape from u_ddlb within w_buildfilter_order_entry
integer x = 911
integer y = 150
integer width = 549
integer height = 477
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean sorted = false
string item[] = {"No Shape Required","Circle","Rectangle","Parallelogram","Fender","Chevron","Trapezoid","L.Trapezoid","R.Trapezoid","Other","Reinforcement","Liftgate"}
end type

event selectionchanged;String ls_text
Long ll_row, ll_i, ll_j, ll_temp, ll_item

dw_search.AcceptText()

ls_text = Text(index)
ll_row = dw_search.RowCount()
IF ll_row > 0 THEN
	ll_temp = 0
	FOR ll_i = 1 TO ll_row
		IF dw_search.GetItemString(ll_i, "column_t", Primary!, FALSE) = "Shape" THEN
			ll_temp = ll_i
		END IF
	NEXT
END IF
IF ll_temp <> 0 THEN dw_search.Deleterow(ll_temp)

ll_item = ddlb_parts.TotalItems() 
IF ll_item > 0 THEN
	FOR ll_j = 1 TO ll_item
		ll_row = dw_search.RowCount()
		IF ll_row > 0 THEN
			ll_temp = 0
			FOR ll_i = 1 TO ll_row
				IF dw_search.GetItemString(ll_i, "column_t", Primary!, FALSE) = ddlb_parts.Text(ll_j) THEN
					ll_temp = ll_i
				END IF
			NEXT
		END IF
		IF ll_temp <> 0 THEN dw_search.Deleterow(ll_temp)
	NEXT
END IF
		
CHOOSE CASE ls_text
	CASE "No Shape Required"
		//nothing
	CASE ELSE
		ll_row = dw_search.InsertRow(0)
		dw_search.SetItem(ll_row, "column_t", "Shape")
		dw_search.SetItem(ll_row, "operator_t", "=")
		dw_search.SetItem(ll_row, "value_t", ls_text)
END CHOOSE

ddlb_parts.Reset()
CHOOSE CASE ls_text
	CASE "No Shape Required"
			//
	CASE "Rectangle"
		ddlb_parts.AddItem("Length")
		ddlb_parts.AddItem("Width")			
	CASE "Parallelogram"
		ddlb_parts.AddItem("Length")
		ddlb_parts.AddItem("Width")			
	CASE "Fender"
		ddlb_parts.AddItem("Side")
	CASE "Circle"
		ddlb_parts.AddItem("Diameter")
	CASE "Chevron"
		ddlb_parts.AddItem("Length")
		ddlb_parts.AddItem("Width")			
	CASE "Trapezoid"
		ddlb_parts.AddItem("L.Length")
		ddlb_parts.AddItem("S.Length")
		ddlb_parts.AddItem("Width")			
	CASE "L.Trapezoid"
		ddlb_parts.AddItem("L.Length")
		ddlb_parts.AddItem("S.Length")
		ddlb_parts.AddItem("Width")			
	CASE "R.Trapezoid"
		ddlb_parts.AddItem("L.Length")
		ddlb_parts.AddItem("S.Length")
		ddlb_parts.AddItem("Width")			
	CASE "Other"
		ddlb_parts.AddItem("Length1")
		ddlb_parts.AddItem("Length2")
		ddlb_parts.AddItem("Length3")			
		ddlb_parts.AddItem("Length4")
		ddlb_parts.AddItem("Length5")
		ddlb_parts.AddItem("Length6")					
		
	CASE "Reinforcement"
		ddlb_parts.AddItem("Length")
		ddlb_parts.AddItem("Width")			
	CASE "Liftgate_shape"
		ddlb_parts.AddItem("Length")
		ddlb_parts.AddItem("Width")			
		
END CHOOSE

IF dw_search.RowCount() > 0 THEN
	cb_apply.Enabled = TRUE
ELSE
	cb_apply.Enabled = FALSE
END IF

end event

type st_3 from u_st within w_buildfilter_order_entry
integer x = 1467
integer y = 99
integer width = 289
boolean bringtotop = true
string text = "Select Parts:"
end type

type ddlb_parts from u_ddlb within w_buildfilter_order_entry
integer x = 1470
integer y = 150
integer width = 475
integer height = 477
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean sorted = false
end type

event selectionchanged;String ls_text
Long ll_row, ll_i

ls_text = Text(index)
IF len(ls_text) > 1 THEN
	ll_row = dw_search.InsertRow(0)
	dw_search.SetItem(ll_row, "column_t", ls_text)
	dw_search.SetItem(ll_row, "operator_t", "=")
	dw_search.SetItem(ll_row, "format_t", "1")
END IF
end event

type ddlb_cust from u_ddlb within w_buildfilter_order_entry
integer x = 121
integer y = 150
integer width = 717
integer height = 816
integer taborder = 20
boolean bringtotop = true
boolean sorted = false
end type

event selectionchanged;String ls_text
Long ll_row, ll_i, ll_temp

dw_search.AcceptText()

ls_text = Text(index)
ll_row = dw_search.RowCount()
IF ll_row > 0 THEN
	ll_temp = 0
	FOR ll_i = 1 TO ll_row
		IF dw_search.GetItemString(ll_i, "column_t", Primary!, FALSE) = "Customer" THEN
			ll_temp = ll_i
		END IF
	NEXT
END IF
IF ll_temp <> 0 THEN dw_search.Deleterow(ll_temp)

ll_row = dw_search.InsertRow(0)
dw_search.SetItem(ll_row, "column_t", "Customer")
dw_search.SetItem(ll_row, "operator_t", "=")
dw_search.SetItem(ll_row, "value_t", ls_text)

IF dw_search.RowCount() > 0 THEN
	cb_apply.Enabled = TRUE
ELSE
	cb_apply.Enabled = FALSE
END IF

end event

type st_2 from statictext within w_buildfilter_order_entry
integer x = 121
integer y = 99
integer width = 388
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Customer:"
boolean focusrectangle = false
end type

type gb_2 from u_gb within w_buildfilter_order_entry
integer x = 44
integer width = 1960
integer height = 998
integer taborder = 0
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Build Serach From Supplied Criteria:"
end type

