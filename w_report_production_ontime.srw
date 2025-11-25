$PBExportHeader$w_report_production_ontime.srw
$PBExportComments$ production line on time report based on different customers
forward
global type w_report_production_ontime from w_sheet
end type
type cb_export from u_cb within w_report_production_ontime
end type
type dw_report from u_dw within w_report_production_ontime
end type
type cb_print from u_cb within w_report_production_ontime
end type
type cb_close from u_cb within w_report_production_ontime
end type
type cb_setzoom from u_cb within w_report_production_ontime
end type
type gb_3 from u_gb within w_report_production_ontime
end type
type gb_2 from u_gb within w_report_production_ontime
end type
type gb_1 from u_gb within w_report_production_ontime
end type
type rb_lineall from u_rb within w_report_production_ontime
end type
type rb_line from u_rb within w_report_production_ontime
end type
type rb_dateall from u_rb within w_report_production_ontime
end type
type rb_date from u_rb within w_report_production_ontime
end type
type rb_custall from u_rb within w_report_production_ontime
end type
type rb_cust from u_rb within w_report_production_ontime
end type
type ddlb_line from u_ddlb within w_report_production_ontime
end type
type em_from from u_em within w_report_production_ontime
end type
type em_to from u_em within w_report_production_ontime
end type
type st_1 from statictext within w_report_production_ontime
end type
type ddlb_cust from u_ddlb within w_report_production_ontime
end type
type dw_customer from u_dw within w_report_production_ontime
end type
type cb_retrieve from u_cb within w_report_production_ontime
end type
type dw_line from u_dw within w_report_production_ontime
end type
end forward

global type w_report_production_ontime from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer width = 2944
integer height = 1811
string title = "Production OnTime Report"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
cb_export cb_export
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_setzoom cb_setzoom
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
rb_lineall rb_lineall
rb_line rb_line
rb_dateall rb_dateall
rb_date rb_date
rb_custall rb_custall
rb_cust rb_cust
ddlb_line ddlb_line
em_from em_from
em_to em_to
st_1 st_1
ddlb_cust ddlb_cust
dw_customer dw_customer
cb_retrieve cb_retrieve
dw_line dw_line
end type
global w_report_production_ontime w_report_production_ontime

type variables
String is_line
String is_status
String is_cust
String is_enduser
String is_desc
end variables

forward prototypes
public function string wf_search_terms ()
public subroutine wf_settitle ()
end prototypes

event type string ue_whoami();RETURN "w_report_production_ontime"
end event

public function string wf_search_terms ();String ls_terms, ls_s
Long ll_row, ll_i
Long ll_line, ll_cust

ls_s = is_desc
IF rb_line.Checked THEN
	ll_row = dw_line.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_line.GetItemString(ll_i, "line_desc") = is_line THEN
			ll_line = dw_line.GetItemNumber(ll_i, "line_num")
		END IF
	NEXT
	ls_s = ls_s + " and ( ~~~"AB_JOB~~~".~~~"LINE_NUM~~~" = " + String(ll_line) + " )"
END IF

IF rb_date.Checked THEN
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"AB_JOB~~~".~~~"TIME_DATE_FINISHED~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) >= " + " TO_DATE(~~~'" + em_from.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  
	ls_s = ls_s + " and (TO_DATE(TO_CHAR(~~~"AB_JOB~~~".~~~"TIME_DATE_FINISHED~~~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  )  <= " + " TO_DATE(~~~'" + em_to.Text + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
END IF

IF rb_cust.Checked THEN
	ll_row = dw_customer.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_customer.GetItemString(ll_i, "customer_short_name") = is_cust THEN
			ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
	ls_s = ls_s + " and (~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = " + String(ll_cust) + " )"
END IF

ls_terms = ls_terms + ls_s 

RETURN ls_terms
end function

public subroutine wf_settitle ();String ls_modstring,ls_s
Long ll_c

IF rb_lineall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = is_line
END IF

ls_modstring = "line_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_dateall.Checked THEN
	ls_s = "ALL"		
ELSE
	ls_s = em_from.Text + " - " + em_to.Text
END IF

ls_modstring = "date_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 

IF rb_custall.Checked THEN
	ls_s = "ALL" 	
ELSE
	ls_s = is_cust 
END IF	

ls_modstring = "cust_t.Text = ~"" + ls_s + "~""
dw_report.Modify(ls_modstring) 


end subroutine

on w_report_production_ontime.create
int iCurrent
call super::create
this.cb_export=create cb_export
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_lineall=create rb_lineall
this.rb_line=create rb_line
this.rb_dateall=create rb_dateall
this.rb_date=create rb_date
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.ddlb_line=create ddlb_line
this.em_from=create em_from
this.em_to=create em_to
this.st_1=create st_1
this.ddlb_cust=create ddlb_cust
this.dw_customer=create dw_customer
this.cb_retrieve=create cb_retrieve
this.dw_line=create dw_line
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_export
this.Control[iCurrent+2]=this.dw_report
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_setzoom
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.rb_lineall
this.Control[iCurrent+10]=this.rb_line
this.Control[iCurrent+11]=this.rb_dateall
this.Control[iCurrent+12]=this.rb_date
this.Control[iCurrent+13]=this.rb_custall
this.Control[iCurrent+14]=this.rb_cust
this.Control[iCurrent+15]=this.ddlb_line
this.Control[iCurrent+16]=this.em_from
this.Control[iCurrent+17]=this.em_to
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.ddlb_cust
this.Control[iCurrent+20]=this.dw_customer
this.Control[iCurrent+21]=this.cb_retrieve
this.Control[iCurrent+22]=this.dw_line
end on

on w_report_production_ontime.destroy
call super::destroy
destroy(this.cb_export)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_setzoom)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_lineall)
destroy(this.rb_line)
destroy(this.rb_dateall)
destroy(this.rb_date)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.ddlb_line)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_1)
destroy(this.ddlb_cust)
destroy(this.dw_customer)
destroy(this.cb_retrieve)
destroy(this.dw_line)
end on

event open;call super::open;Long ll_row, ll_c

dw_line.Visible = FALSE
dw_customer.Visible = FALSE

ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_cust.AddItem(dw_customer.GetItemString(ll_c, "customer_short_name"))
	NEXT
END IF
ll_row = dw_line.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_line.AddItem(dw_line.GetItemString(ll_c, "line_desc"))
	NEXT
END IF

wf_settitle()

is_desc = dw_report.Describe("DataWindow.Table.Select")








end event

event pfc_print;RETURN dw_report.Event pfc_print()
end event

event close;call super::close;f_display_app()
end event

event pfc_saveas;/*
Long ll_cust
String ls_cust, ls_title, ls_from, ls_to
//Save quote File
ll_cust = dw_customer.GetRow()
ls_cust = dw_customer.GetItemString(ll_cust, "customer_short_name")
ls_cust = Trim(ls_cust)

ls_from = string(Date(em_from.Text),"mmddyyyy")
ls_to = string(Date(em_to.Text),"mmddyyyy")

ls_title = ProfileString(gs_ini_file, "REPORT","file_path","c:\temp")+'\' +"Inv_" + ls_cust + '_' + ls_from + '_' + ls_to +".PSR"

IF dw_report.SaveAs(ls_title, PSReport!, FALSE) =-1 THEN
  	MessageBox("Quotation DataStore SaveAs", "Error") 
	RETURN
END IF

MessageBox("Success", "File has been saved as " + ls_title + " Successfully!" )
*/

end event

type cb_export from u_cb within w_report_production_ontime
integer x = 790
integer y = 1606
integer width = 325
integer height = 106
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Export"
end type

event clicked;call super::clicked;SetPointer(HourGlass!)
String ls_file, ls_today, ls_now
Date ld_today
Time ld_now

ld_today = Today()
ld_now = Now()
ls_today = string(ld_today,"yymmdd")
ls_now = string(ld_now,"hhmm")

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\abis_' + ls_today + ls_now + ".xls"
if dw_report.SaveAs(ls_file,HTMLTable!, TRUE) =-1 then
   MessageBox("Data SaveAs", "Error")
	return -1
else
	messageBox("Success", "Data have been successfully save as " + ls_file)
end if

RETURN 1
end event

type dw_report from u_dw within w_report_production_ontime
event ue_specs ( )
event ue_retrieve ( )
integer x = 7
integer y = 224
integer width = 2911
integer height = 1366
integer taborder = 10
string dataobject = "d_ontime_process_report"
boolean hscrollbar = true
end type

event ue_specs();Long ll_row, ll_c
Long ll_job, ll_coil, ll_pwt, ll_status
Long ll_wt, ll_wt1, ll_wt2, ll_shift_end_wt, ll_ontime
String ls_modstring


ll_row = this.RowCount()
ll_ontime = 0
IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_job = this.GetItemNumber(ll_c, "ab_job_ab_job_num")
		ll_coil = this.GetItemNumber(ll_c, "process_coil_coil_abc_num")
		
		SELECT process_quantity, process_end_wt, process_coil_status INTO :ll_wt, :ll_shift_end_wt, :ll_status
		FROM process_coil
		WHERE (coil_abc_num = :ll_coil) AND (ab_job_num = :ll_job)
		USING SQLCA;
		IF IsNULL(ll_wt) THEN ll_wt = 0

		IF IsNULL(ll_shift_end_wt) THEN
			SELECT net_wt_balance INTO :ll_wt1
			FROM coil
			WHERE coil_abc_num = :ll_coil
			USING SQLCA;
			IF ISNULL(ll_wt1) THEN ll_wt1 = 0
		ELSE
			ll_wt1 = ll_shift_end_wt
		END IF

		SELECT MAX(process_quantity) INTO :ll_wt2
		FROM process_coil
		WHERE (coil_abc_num = :ll_coil) AND (process_quantity < :ll_wt)
		USING SQLCA;
		IF IsNULL(ll_wt2) THEN ll_wt2 = 0

		ll_pwt = ll_wt - MAX(ll_wt1, ll_wt2)
		
		IF ll_status = 2 THEN //new coil not being processed
			this.SetItem(ll_c, "Process_wt", 0)
		ELSE //being processed
			this.SetItem(ll_c, "process_wt", ll_pwt)
		END IF
		
		IF this.GetItemNumber(ll_c, "compute_3") >= 0 THEN ll_ontime = ll_ontime + 1
	NEXT
END IF

ls_modstring = "final_1.Text = ~"" + "Total # Coils Processed On Time = " + String(ll_ontime) + "~""
dw_report.Modify(ls_modstring) 

IF ll_row > 0 THEN
	ls_modstring = "final_2.Text = ~"" + "On Time Processing Rate = " + String(ll_ontime/ll_row * 100.00, "###.##") + "%" + "~""
	dw_report.Modify(ls_modstring) 
ELSE
	ls_modstring = "final_2.Text = ~"" + "On Time Processing Rate"  + "~""
	dw_report.Modify(ls_modstring) 
END IF

this.ResetUpdate()

end event

event ue_retrieve();String ls_modify, ls_rc

This.Reset()

wf_settitle()

ls_modify ="DataWindow.Table.Select = '" + wf_search_terms() + " '"
ls_rc = This.Modify(ls_modify)
IF ls_rc = "" THEN
	This.SetTransObject(SQLCA)
	This.Retrieve()
	This.Event ue_specs()
ELSE
	MessageBox("Error","Failure to modify datawindow!", StopSign!)
END IF

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

type cb_print from u_cb within w_report_production_ontime
integer x = 1755
integer y = 1606
integer width = 325
integer height = 106
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_production_ontime
string tag = "Exit"
integer x = 2238
integer y = 1606
integer width = 325
integer height = 106
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_setzoom from u_cb within w_report_production_ontime
integer x = 1273
integer y = 1606
integer width = 325
integer height = 106
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type gb_3 from u_gb within w_report_production_ontime
integer x = 1799
integer width = 1119
integer height = 208
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type gb_2 from u_gb within w_report_production_ontime
integer x = 823
integer width = 955
integer height = 208
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Job Done Date"
end type

type gb_1 from u_gb within w_report_production_ontime
integer x = 4
integer width = 794
integer height = 208
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Line"
end type

type rb_lineall from u_rb within w_report_production_ontime
integer x = 37
integer y = 51
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_line.Enabled = FALSE
ELSE
	ddlb_line.Enabled = TRUE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

RETURN 1


end event

type rb_line from u_rb within w_report_production_ontime
integer x = 37
integer y = 118
integer width = 216
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Line"
end type

event clicked;IF this.Checked THEN 
	ddlb_line.Enabled = TRUE
ELSE
	ddlb_line.Enabled = FALSE
END IF
dw_report.SetTransObject(SQLCA)
wf_settitle()

RETURN 1

end event

type rb_dateall from u_rb within w_report_production_ontime
integer x = 859
integer y = 51
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
ELSE
	em_from.Enabled = TRUE
	em_to.Enabled = TRUE
END IF
wf_settitle()
RETURN 1
end event

type rb_date from u_rb within w_report_production_ontime
integer x = 859
integer y = 118
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "From "
end type

event clicked;IF this.Checked THEN
	em_from.Enabled = TRUE
	em_to.Enabled = TRUE
ELSE
	em_from.Enabled = FALSE
	em_to.Enabled = FALSE
END IF
wf_settitle()	
RETURN 1
end event

type rb_custall from u_rb within w_report_production_ontime
integer x = 1832
integer y = 51
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN
	ddlb_cust.Enabled = FALSE
ELSE
	ddlb_cust.Enabled = TRUE
END IF

dw_report.SetTransObject(SQLCA)
wf_settitle()

RETURN 1


end event

type rb_cust from u_rb within w_report_production_ontime
integer x = 1832
integer y = 118
integer width = 212
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Show"
end type

event clicked;IF this.Checked THEN 
	ddlb_cust.Enabled = TRUE
ELSE
	ddlb_cust.Enabled = FALSE
END IF
dw_report.SetTransObject(SQLCA)
wf_settitle()

RETURN 1

end event

type ddlb_line from u_ddlb within w_report_production_ontime
integer x = 234
integer y = 115
integer width = 512
integer height = 672
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i

is_line = Text(index)
wf_settitle()

RETURN 1


end event

type em_from from u_em within w_report_production_ontime
integer x = 1083
integer y = 112
integer width = 289
integer height = 77
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type em_to from u_em within w_report_production_ontime
integer x = 1470
integer y = 112
integer width = 282
integer height = 77
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type st_1 from statictext within w_report_production_ontime
integer x = 1386
integer y = 118
integer width = 69
integer height = 67
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
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_cust from u_ddlb within w_report_production_ontime
integer x = 2052
integer y = 122
integer width = 856
integer height = 992
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i
String ls_text

ls_text = Text(index)
is_cust = ls_text
wf_settitle()
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
	END IF
NEXT
RETURN 1


end event

type dw_customer from u_dw within w_report_production_ontime
boolean visible = false
integer x = 2575
integer y = 1680
integer height = 38
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_customer_short_display"
end type

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)
Retrieve()

end event

type cb_retrieve from u_cb within w_report_production_ontime
integer x = 307
integer y = 1606
integer width = 325
integer height = 106
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;IF rb_dateall.Checked AND rb_lineall.Checked AND rb_custall.Checked THEN
	IF Messagebox("Warning", "It takes long time to generate this report. Continue?",Question!, YesNo!, 2) = 2 THEN
		RETURN 0
	END IF
END IF

dw_report.Event ue_retrieve()
Return 1
end event

type dw_line from u_dw within w_report_production_ontime
boolean visible = false
integer x = 2578
integer y = 1642
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_line_number"
end type

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)
Retrieve()

end event

