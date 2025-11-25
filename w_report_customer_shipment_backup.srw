$PBExportHeader$w_report_customer_shipment_backup.srw
forward
global type w_report_customer_shipment_backup from w_sheet
end type
type gb_1 from u_gb within w_report_customer_shipment_backup
end type
type gb_2 from u_gb within w_report_customer_shipment_backup
end type
type gb_3 from u_gb within w_report_customer_shipment_backup
end type
type dw_customer from u_dw within w_report_customer_shipment_backup
end type
type dw_allcust from u_dw within w_report_customer_shipment_backup
end type
type dw_report from u_dw within w_report_customer_shipment_backup
end type
type cb_print from u_cb within w_report_customer_shipment_backup
end type
type cb_close from u_cb within w_report_customer_shipment_backup
end type
type cb_preview from u_cb within w_report_customer_shipment_backup
end type
type ddlb_customer from dropdownlistbox within w_report_customer_shipment_backup
end type
type st_3 from statictext within w_report_customer_shipment_backup
end type
type em_from from editmask within w_report_customer_shipment_backup
end type
type em_to from editmask within w_report_customer_shipment_backup
end type
type cb_setzoom from u_cb within w_report_customer_shipment_backup
end type
type ddlb_enduser from dropdownlistbox within w_report_customer_shipment_backup
end type
type rb_custall from u_rb within w_report_customer_shipment_backup
end type
type rb_cust from u_rb within w_report_customer_shipment_backup
end type
type rb_dateall from u_rb within w_report_customer_shipment_backup
end type
type rb_date from u_rb within w_report_customer_shipment_backup
end type
type rb_enduserall from u_rb within w_report_customer_shipment_backup
end type
type rb_enduser from u_rb within w_report_customer_shipment_backup
end type
type cb_sort from u_cb within w_report_customer_shipment_backup
end type
type cb_email from u_cb within w_report_customer_shipment_backup
end type
end forward

global type w_report_customer_shipment_backup from w_sheet
string tag = "Shipment Report"
integer x = 424
integer y = 310
integer width = 3664
integer height = 1891
string title = "Shipment Report "
boolean maxbox = false
boolean resizable = false
long backcolor = 81324524
event type string ue_whoami ( )
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
dw_customer dw_customer
dw_allcust dw_allcust
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_preview cb_preview
ddlb_customer ddlb_customer
st_3 st_3
em_from em_from
em_to em_to
cb_setzoom cb_setzoom
ddlb_enduser ddlb_enduser
rb_custall rb_custall
rb_cust rb_cust
rb_dateall rb_dateall
rb_date rb_date
rb_enduserall rb_enduserall
rb_enduser rb_enduser
cb_sort cb_sort
cb_email cb_email
end type
global w_report_customer_shipment_backup w_report_customer_shipment_backup

type variables

end variables

forward prototypes
public subroutine wf_settitle ()
public subroutine wf_setfilter ()
public subroutine wf_shipment ()
end prototypes

event ue_whoami;RETURN "w_report_customer_shipment"
end event

public subroutine wf_settitle ();String ls_modstring,ls_s
long ll_c


ll_c = dw_customer.GetRow()
ls_s = dw_customer.GetItemString(ll_c, "customer_short_name")
ls_s = Trim(ls_s)

ls_modstring = "customer_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

ls_s = "(" +em_from.Text + "-" + em_to.Text+")"
ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 


/*
String ls_modstring,ls_s
Long ll_c, ll_t

IF rb_dateall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_from.Text + "-" + em_to.Text
END IF
ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

/*
IF rb_statusall.Checked THEN
	ls_s = "All"
ELSE
	ll_t = 0
	IF cbx_1.Checked THEN
		ls_s = cbx_1.Text
		ll_t++
	END IF
	IF cbx_2.Checked THEN 
		ls_s = cbx_2.Text
		ll_t++
	END IF
	IF cbx_3.Checked THEN 
		ls_s = cbx_3.Text
		ll_t++
	END IF
	IF cbx_4.Checked THEN
		ls_s = cbx_4.Text
		ll_t++
	END IF
	IF cbx_5.Checked THEN
		ls_s = cbx_5.Text
		ll_t++
	END IF
	IF cbx_6.Checked THEN
		ls_s = cbx_6.Text
		ll_t++
	END IF
	IF cbx_7.Checked THEN
		ls_s = cbx_7.Text
		ll_t++
	END IF
	IF cbx_8.Checked THEN
		ls_s = cbx_8.Text
		ll_t++
	END IF
	IF ll_t > 1 THEN ls_s = "Multiple"
END IF

*/
ls_modstring = "status_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

/*
IF rb_specsall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_gauge.Text
END IF
ls_modstring = "gauge_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_specsall.Checked THEN
	ls_s = "All"
ELSE
	ls_s = em_width.Text
END IF
ls_modstring = "width_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

*/
IF rb_enduserall.Checked THEN
	ls_s = "All"
ELSE
	ll_c = dw_allcust.GetRow()
	ls_s = dw_allcust.GetItemString(ll_c, "customer_short_name")
	ls_s = Trim(ls_s)
END IF
ls_modstring = "enduser_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_custall.Checked THEN
	ls_s = "ABCO Customers Shipment Report" 
ELSE
	ll_c = dw_customer.GetRow()
	ls_s = dw_customer.GetItemString(ll_c, "customer_short_name")
	ls_s = Trim(ls_s)
	ls_s = ls_s + " Shipment Report" 
END IF	
ls_modstring = "title_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 
*/
end subroutine

public subroutine wf_setfilter ();/*
String ls_s, ls_status
Int li_status

ls_s = ""
IF rb_specs.Checked THEN
	IF Real(em_gauge.text) > 0 THEN
		ls_s = "(coil_coil_gauge = " + em_gauge.text + ")"
		IF Real(em_width.Text) > 0 THEN
			ls_s = ls_s + " and " + "(coil_coil_width = " + em_width.text + ")"
		END IF
	ELSE
		ls_s = " "
		IF Real(em_width.Text) > 0 THEN
			ls_s = "(coil_coil_width = " + em_width.text + ")"
		END IF		
	END IF
END IF

IF rb_status.Checked THEN
	ls_status = ""
	IF cbx_1.Checked THEN li_status = 2
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_2.Checked THEN li_status = 1
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_3.Checked THEN li_status = 3
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_4.Checked THEN li_status = 5
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_5.Checked THEN li_status = 4
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_6.Checked THEN li_status = 6
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_7.Checked THEN li_status = 7
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	IF cbx_8.Checked THEN li_status = 8
	IF Len(ls_status) < 3 THEN
		ls_status = "( " + "coil_coil_status = " + String(li_status)
	ELSE
		ls_status = ls_status + " OR " + "coil_coil_status = " + String(li_status)
	END IF
	
	IF Pos(ls_status, "(") > 0 THEN
		ls_status = ls_status + " )"
	END IF
	
	IF Len(ls_s) > 3 THEN
		ls_s = ls_s + " and " + ls_status
	ELSE
		ls_s = ls_status
	END IF
END IF

dw_report.inv_filter.of_SetFilter(ls_s)
dw_report.inv_filter.of_Filter()
*/
end subroutine

public subroutine wf_shipment ();Long ll_cust_row, ll_cust, ll_enduser
Date ld_s, ld_e

ll_cust_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_cust_row, "customer_id")

//MessageBox ( "customer id", string(ll_cust))

dw_report.reset()
IF rb_dateall.Checked THEN
	ld_s = Date("00/00/0000")
	ld_e = Date("12/31/9999")
ELSE
	ld_s = Date(em_from.Text)
	ld_e = Date(em_to.Text)
END IF

IF rb_enduser.Checked THEN 
	ll_cust_row = dw_allcust.GetRow()
   ll_enduser = dw_allcust.GetItemNumber(ll_cust_row, "customer_id")
	dw_report.Reset()
	dw_report.DataObject = "d_report_shipment_e"
   dw_report.SetTransObject(SQLCA)
	//MessageBox ( "enduser id", string(ll_enduser))
   dw_report.Retrieve(ll_cust, ld_s, ld_e, ll_enduser)
ELSE
	dw_report.Reset()
	dw_report.DataObject = "d_report_shipment"
   dw_report.SetTransObject(SQLCA)
	
	dw_report.retrieve(ll_cust, ld_s, ld_e)
END IF

end subroutine

on w_report_customer_shipment_backup.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_customer=create dw_customer
this.dw_allcust=create dw_allcust
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_preview=create cb_preview
this.ddlb_customer=create ddlb_customer
this.st_3=create st_3
this.em_from=create em_from
this.em_to=create em_to
this.cb_setzoom=create cb_setzoom
this.ddlb_enduser=create ddlb_enduser
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.rb_dateall=create rb_dateall
this.rb_date=create rb_date
this.rb_enduserall=create rb_enduserall
this.rb_enduser=create rb_enduser
this.cb_sort=create cb_sort
this.cb_email=create cb_email
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.dw_customer
this.Control[iCurrent+5]=this.dw_allcust
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_preview
this.Control[iCurrent+10]=this.ddlb_customer
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.em_from
this.Control[iCurrent+13]=this.em_to
this.Control[iCurrent+14]=this.cb_setzoom
this.Control[iCurrent+15]=this.ddlb_enduser
this.Control[iCurrent+16]=this.rb_custall
this.Control[iCurrent+17]=this.rb_cust
this.Control[iCurrent+18]=this.rb_dateall
this.Control[iCurrent+19]=this.rb_date
this.Control[iCurrent+20]=this.rb_enduserall
this.Control[iCurrent+21]=this.rb_enduser
this.Control[iCurrent+22]=this.cb_sort
this.Control[iCurrent+23]=this.cb_email
end on

on w_report_customer_shipment_backup.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_customer)
destroy(this.dw_allcust)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_preview)
destroy(this.ddlb_customer)
destroy(this.st_3)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.cb_setzoom)
destroy(this.ddlb_enduser)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.rb_dateall)
destroy(this.rb_date)
destroy(this.rb_enduserall)
destroy(this.rb_enduser)
destroy(this.cb_sort)
destroy(this.cb_email)
end on

event open;call super::open;dw_customer.Visible = FALSE
dw_customer.SetTransObject(SQLCA)
dw_customer.Retrieve()
dw_customer.SelectRow(1,TRUE)

dw_allcust.Visible = FALSE
dw_allcust.SetTransObject(SQLCA)
dw_allcust.Retrieve()

Long ll_row, ll_i
ll_row = dw_allcust.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_enduser.AddItem(dw_allcust.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF

ddlb_customer.Enabled = TRUE
em_from.Enabled = TRUE
em_to.Enabled = TRUE


wf_settitle()
cb_preview.SetFocus()

//dw_report.Event ue_retrieve()


end event

event pfc_print;RETURN dw_report.Event pfc_print()
end event

event close;call super::close;f_display_app()
end event

event pfc_saveas;Long ll_cust
String ls_cust, ls_title, ls_from, ls_to
//Save quote File
ll_cust = dw_customer.GetRow()
ls_cust = dw_customer.GetItemString(ll_cust, "customer_short_name")
ls_cust = Trim(ls_cust)

ls_from = string(Date(em_from.Text),"mmddyyyy")
ls_to = string(Date(em_to.Text),"mmddyyyy")

ls_title = ProfileString(gs_ini_file, "REPORT","file_path","c:\temp")+'\' +"Shipment_" + ls_cust + '_' + ls_from + '_' + ls_to +".PSR"

IF dw_report.SaveAs(ls_title, PSReport!, FALSE) =-1 THEN
  	MessageBox("Report SaveAs", "Error") 
	RETURN
END IF

MessageBox("Success", "File has been saved as " + ls_title + " Successfully!" )


end event

type gb_1 from u_gb within w_report_customer_shipment_backup
integer x = 15
integer width = 1115
integer height = 205
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type gb_2 from u_gb within w_report_customer_shipment_backup
integer x = 2293
integer width = 922
integer height = 205
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = " Date"
end type

type gb_3 from u_gb within w_report_customer_shipment_backup
integer x = 1130
integer width = 1156
integer height = 205
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "End User"
end type

type dw_customer from u_dw within w_report_customer_shipment_backup
boolean visible = false
integer x = 2399
integer y = 1693
integer width = 132
integer height = 38
integer taborder = 0
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
end type

event clicked;SelectRow(0, FALSE)

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

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )

end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()

end event

type dw_allcust from u_dw within w_report_customer_shipment_backup
boolean visible = false
integer x = 2341
integer y = 1731
integer width = 157
integer height = 70
integer taborder = 70
string dataobject = "d_customer_short_list"
boolean vscrollbar = false
end type

event clicked;SelectRow(0, FALSE)

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

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )

end event

event rbuttondown;//disbaled
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()

end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

Return 

end event

type dw_report from u_dw within w_report_customer_shipment_backup
event ue_retrieve ( )
event ue_clean_duplicates ( )
integer x = 15
integer y = 224
integer width = 3624
integer height = 1392
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_report_shipment"
boolean hscrollbar = true
end type

event ue_retrieve;dw_report.Reset()

wf_shipment()
wf_settitle()
wf_setfilter()
//this.Event ue_clean_duplicates()







end event

event ue_clean_duplicates;/*

Long ll_row, ll_i

ll_row = this.RowCount()
IF ll_row < 2 THEN RETURN
FOR ll_i = ll_row TO 2 STEP -1
	IF this.GetItemString(ll_i, "coil_coil_org_num") = this.GetItemString((ll_i - 1), "coil_coil_org_num") THEN
		IF (this.GetItemString(ll_i, "coil_coil_mid_num") = this.GetItemString((ll_i - 1), "coil_coil_mid_num")) OR ISNULL(this.GetItemString(ll_i, "coil_coil_mid_num")) THEN
			IF this.GetItemString(ll_i, "coil_lot_num") = this.GetItemString((ll_i - 1), "coil_lot_num") THEN
				IF this.GetItemNumber(ll_i, "customer_order_enduser_id") = this.GetItemNumber((ll_i - 1), "customer_order_enduser_id") THEN
					this.DeleteRow(ll_i)
				END IF
			END IF
		END IF
	END IF
NEXT

*/
end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)





end event

type cb_print from u_cb within w_report_customer_shipment_backup
integer x = 2048
integer y = 1654
integer width = 307
integer height = 74
integer taborder = 140
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_customer_shipment_backup
string tag = "Exit"
integer x = 2494
integer y = 1654
integer width = 322
integer height = 74
integer taborder = 150
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_preview from u_cb within w_report_customer_shipment_backup
event clicked pbm_bnclicked
integer x = 263
integer y = 1654
integer width = 307
integer height = 70
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;dw_report.Event ue_retrieve()

end event

type ddlb_customer from dropdownlistbox within w_report_customer_shipment_backup
integer x = 263
integer y = 112
integer width = 827
integer height = 1203
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
integer accelerator = 50
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_text, ls_modstring
Long ll_row, ll_i


dw_report.reset()
ls_text = Text(index)

/*
IF rb_enduser.Checked THEN 
	dw_report.DataObject = "d_report_shipment_e"
ELSE
	dw_report.DataObject = "d_report_shipment"
END IF
*/

ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
	END IF
NEXT

//dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()

RETURN 1


end event

type st_3 from statictext within w_report_customer_shipment_backup
integer x = 2823
integer y = 115
integer width = 91
integer height = 61
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
string text = "To"
boolean focusrectangle = false
end type

type em_from from editmask within w_report_customer_shipment_backup
integer x = 2523
integer y = 109
integer width = 285
integer height = 74
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event constructor;this.Text = String(Today(), "mm/dd/yyyy")

end event

event losefocus;wf_SetTitle()
RETURN 1
end event

type em_to from editmask within w_report_customer_shipment_backup
integer x = 2893
integer y = 109
integer width = 285
integer height = 74
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

event constructor;this.Text = String(Today(), "mm/dd/yyyy")

end event

event losefocus;wf_settitle()

RETURN 1
end event

type cb_setzoom from u_cb within w_report_customer_shipment_backup
integer x = 1159
integer y = 1654
integer width = 307
integer height = 74
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type ddlb_enduser from dropdownlistbox within w_report_customer_shipment_backup
integer x = 1401
integer y = 106
integer width = 827
integer height = 1194
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_text
Long ll_i, ll_row

ls_text = Text(index)
ll_row = dw_allcust.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_allcust.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_allcust.Event RowFocusChanged(ll_i)
		dw_allcust.SelectRow(0, False)
		dw_allcust.SelectRow(ll_i, True)
	END IF
NEXT
dw_report.SetTransObject(SQLCA)
wf_settitle()

//dw_report.Event ue_retrieve()

RETURN 1
end event

type rb_custall from u_rb within w_report_customer_shipment_backup
boolean visible = false
integer x = 29
integer y = 48
integer width = 212
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
end type

event clicked;/*
IF this.Checked THEN
	ddlb_customer.Enabled = FALSE
	IF rb_enduser.Checked THEN 
		dw_report.DataObject = "d_report_inv_abc_coils_e" 
	ELSE
		dw_report.DataObject = "d_report_inv_abc_coils" 
	END IF											
ELSE
	ddlb_customer.Enabled = TRUE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

dw_report.Event ue_retrieve()
*/
MessageBox("Error", "All has been disabled due to too many records")
RETURN 1
end event

type rb_cust from u_rb within w_report_customer_shipment_backup
integer x = 26
integer y = 112
integer width = 230
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_customer.Enabled = TRUE
ELSE
	ddlb_customer.Enabled = FALSE
END IF
wf_settitle()	
end event

type rb_dateall from u_rb within w_report_customer_shipment_backup
boolean visible = false
integer x = 2216
integer y = 48
integer width = 176
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
end type

event clicked;IF this.Checked THEN
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
ELSE
	em_from.Enabled = TRUE
	em_to.Enabled = TRUE
END IF
wf_settitle()

dw_report.Event ue_retrieve()
RETURN 1
end event

type rb_date from u_rb within w_report_customer_shipment_backup
integer x = 2326
integer y = 112
integer width = 190
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "From"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	em_from.Enabled = TRUE
	em_to.Enabled = TRUE
ELSE
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
END IF
wf_settitle()	
end event

type rb_enduserall from u_rb within w_report_customer_shipment_backup
integer x = 1159
integer y = 48
integer width = 172
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;/*
IF this.Checked THEN
	ddlb_enduser.Enabled = FALSE
	IF rb_custall.Checked THEN 
		dw_report.DataObject = "d_report_shipment"
	ELSE
		dw_report.DataObject = "d_report_shipment_e"
	END IF								
ELSE
	ddlb_enduser.Enabled = TRUE
END IF
dw_report.SetTransObject(SQLCA)
wf_settitle()
//dw_report.Event ue_retrieve()
RETURN 1
*/
end event

type rb_enduser from u_rb within w_report_customer_shipment_backup
integer x = 1159
integer y = 112
integer width = 208
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
end type

event clicked;ddlb_enduser.Enabled = TRUE
/*
//dw_report.Reset()
IF this.Checked THEN 
	ddlb_enduser.Enabled = TRUE
	dw_report.DataObject = "d_report_shipment_e"
ELSE
	ddlb_enduser.Enabled = FALSE
	dw_report.DataObject = "d_report_shipment"
	//dw_report.DataObject = Left(dw_report.DataObject, (Len(dw_report.DataObject) - 2))
END IF
dw_report.Reset()
dw_report.SetTransObject(SQLCA)
wf_settitle()

*/

end event

type cb_sort from u_cb within w_report_customer_shipment_backup
integer x = 709
integer y = 1654
integer width = 307
integer height = 74
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Sort"
end type

event clicked;SetPointer(HourGlass!)

String ls_null

SetNULL(ls_null)
dw_report.inv_sort.of_SetSort(ls_null)
dw_report.inv_sort.of_Sort()
end event

type cb_email from u_cb within w_report_customer_shipment_backup
integer x = 1602
integer y = 1654
integer width = 307
integer height = 74
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Email"
end type

event clicked;SetPointer(HourGlass!)
String ls_file, ls_today, ls_now
Date ld_today
Time ld_now

ld_today = Today()
ld_now = Now()
ls_today = string(ld_today,"yymmdd")
ls_now = string(ld_now,"hhmm")

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\m_' + ls_today + ls_now + ".html"
//if dw_report.SaveAs(ls_file,Excel5!, false) =-1 then
if dw_report.SaveAs(ls_file,HTMLtable!, false) =-1 then
   MessageBox("Email SaveAs", "Error")
	return -1
end if

f_send_email(0,ls_file)

RETURN 1
end event

