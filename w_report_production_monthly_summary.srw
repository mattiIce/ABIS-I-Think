$PBExportHeader$w_report_production_monthly_summary.srw
$PBExportComments$ production summary report based on different customers
forward
global type w_report_production_monthly_summary from w_sheet
end type
type ddlb_tomonth from u_ddlb within w_report_production_monthly_summary
end type
type ddlb_frommonth from u_ddlb within w_report_production_monthly_summary
end type
type ddlb_toyear from u_ddlb within w_report_production_monthly_summary
end type
type ddlb_fromyear from u_ddlb within w_report_production_monthly_summary
end type
type st_4 from statictext within w_report_production_monthly_summary
end type
type st_3 from statictext within w_report_production_monthly_summary
end type
type st_2 from statictext within w_report_production_monthly_summary
end type
type dw_report from u_dw within w_report_production_monthly_summary
end type
type cb_print from u_cb within w_report_production_monthly_summary
end type
type cb_close from u_cb within w_report_production_monthly_summary
end type
type cb_setzoom from u_cb within w_report_production_monthly_summary
end type
type gb_4 from u_gb within w_report_production_monthly_summary
end type
type gb_3 from u_gb within w_report_production_monthly_summary
end type
type gb_2 from u_gb within w_report_production_monthly_summary
end type
type gb_1 from u_gb within w_report_production_monthly_summary
end type
type rb_lineall from u_rb within w_report_production_monthly_summary
end type
type rb_line from u_rb within w_report_production_monthly_summary
end type
type rb_custall from u_rb within w_report_production_monthly_summary
end type
type rb_cust from u_rb within w_report_production_monthly_summary
end type
type rb_enduserall from u_rb within w_report_production_monthly_summary
end type
type rb_enduser from u_rb within w_report_production_monthly_summary
end type
type ddlb_line from u_ddlb within w_report_production_monthly_summary
end type
type st_1 from statictext within w_report_production_monthly_summary
end type
type ddlb_cust from u_ddlb within w_report_production_monthly_summary
end type
type ddlb_enduser from u_ddlb within w_report_production_monthly_summary
end type
type dw_allcust from u_dw within w_report_production_monthly_summary
end type
type dw_customer from u_dw within w_report_production_monthly_summary
end type
type cb_retrieve from u_cb within w_report_production_monthly_summary
end type
type dw_line from u_dw within w_report_production_monthly_summary
end type
end forward

global type w_report_production_monthly_summary from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer width = 3935
integer height = 1792
string title = "Production Summary Report"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
ddlb_tomonth ddlb_tomonth
ddlb_frommonth ddlb_frommonth
ddlb_toyear ddlb_toyear
ddlb_fromyear ddlb_fromyear
st_4 st_4
st_3 st_3
st_2 st_2
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_setzoom cb_setzoom
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
rb_lineall rb_lineall
rb_line rb_line
rb_custall rb_custall
rb_cust rb_cust
rb_enduserall rb_enduserall
rb_enduser rb_enduser
ddlb_line ddlb_line
st_1 st_1
ddlb_cust ddlb_cust
ddlb_enduser ddlb_enduser
dw_allcust dw_allcust
dw_customer dw_customer
cb_retrieve cb_retrieve
dw_line dw_line
end type
global w_report_production_monthly_summary w_report_production_monthly_summary

type variables
String is_line
String is_cust
String is_enduser
String is_fromyear, is_toyear, is_frommonth, is_tomonth
end variables

forward prototypes
public subroutine wf_settitle ()
end prototypes

event type string ue_whoami();RETURN "w_report_production_monthly_summary"
end event

public subroutine wf_settitle ();
end subroutine

on w_report_production_monthly_summary.create
int iCurrent
call super::create
this.ddlb_tomonth=create ddlb_tomonth
this.ddlb_frommonth=create ddlb_frommonth
this.ddlb_toyear=create ddlb_toyear
this.ddlb_fromyear=create ddlb_fromyear
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_lineall=create rb_lineall
this.rb_line=create rb_line
this.rb_custall=create rb_custall
this.rb_cust=create rb_cust
this.rb_enduserall=create rb_enduserall
this.rb_enduser=create rb_enduser
this.ddlb_line=create ddlb_line
this.st_1=create st_1
this.ddlb_cust=create ddlb_cust
this.ddlb_enduser=create ddlb_enduser
this.dw_allcust=create dw_allcust
this.dw_customer=create dw_customer
this.cb_retrieve=create cb_retrieve
this.dw_line=create dw_line
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_tomonth
this.Control[iCurrent+2]=this.ddlb_frommonth
this.Control[iCurrent+3]=this.ddlb_toyear
this.Control[iCurrent+4]=this.ddlb_fromyear
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_report
this.Control[iCurrent+9]=this.cb_print
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.cb_setzoom
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.rb_lineall
this.Control[iCurrent+17]=this.rb_line
this.Control[iCurrent+18]=this.rb_custall
this.Control[iCurrent+19]=this.rb_cust
this.Control[iCurrent+20]=this.rb_enduserall
this.Control[iCurrent+21]=this.rb_enduser
this.Control[iCurrent+22]=this.ddlb_line
this.Control[iCurrent+23]=this.st_1
this.Control[iCurrent+24]=this.ddlb_cust
this.Control[iCurrent+25]=this.ddlb_enduser
this.Control[iCurrent+26]=this.dw_allcust
this.Control[iCurrent+27]=this.dw_customer
this.Control[iCurrent+28]=this.cb_retrieve
this.Control[iCurrent+29]=this.dw_line
end on

on w_report_production_monthly_summary.destroy
call super::destroy
destroy(this.ddlb_tomonth)
destroy(this.ddlb_frommonth)
destroy(this.ddlb_toyear)
destroy(this.ddlb_fromyear)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_setzoom)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_lineall)
destroy(this.rb_line)
destroy(this.rb_custall)
destroy(this.rb_cust)
destroy(this.rb_enduserall)
destroy(this.rb_enduser)
destroy(this.ddlb_line)
destroy(this.st_1)
destroy(this.ddlb_cust)
destroy(this.ddlb_enduser)
destroy(this.dw_allcust)
destroy(this.dw_customer)
destroy(this.cb_retrieve)
destroy(this.dw_line)
end on

event open;call super::open;Long ll_row, ll_c, ll_year
String ls_spec
Long ll_job, ll_bal_due
DataStore lds_d

dw_report.SetTransObject(SQLCA)

ll_row = dw_allcust.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_enduser.AddItem(dw_allcust.GetItemString(ll_c, "customer_short_name"))
	NEXT
END IF
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
ll_year = year(Today())
IF ll_year > 0 THEN 
	FOR ll_c = 1996 TO ll_year  //first ABIS year
		ddlb_fromyear.AddItem(String(ll_c))
		ddlb_toyear.AddItem(String(ll_c))
	NEXT
END IF








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

type ddlb_tomonth from u_ddlb within w_report_production_monthly_summary
integer x = 1423
integer y = 131
integer width = 432
integer height = 858
integer taborder = 170
string facename = "Arial"
boolean sorted = false
string item[] = {"January","February","March","April","May","June","July","August","September","October","November","December"}
end type

event selectionchanged;call super::selectionchanged;is_tomonth = Text(index)
wf_settitle()

RETURN 1
end event

type ddlb_frommonth from u_ddlb within w_report_production_monthly_summary
integer x = 1423
integer y = 54
integer width = 432
integer height = 858
integer taborder = 170
string facename = "Arial"
boolean sorted = false
string item[] = {"January","February","March","April","May","June","July","August","September","October","November","December"}
end type

event selectionchanged;call super::selectionchanged;is_frommonth = Text(index)
wf_settitle()

RETURN 1
end event

type ddlb_toyear from u_ddlb within w_report_production_monthly_summary
integer x = 958
integer y = 131
integer width = 289
integer height = 698
integer taborder = 170
string facename = "Arial"
string item[] = {"1996",""}
end type

event selectionchanged;call super::selectionchanged;is_toyear = Text(index)
wf_settitle()

RETURN 1
end event

type ddlb_fromyear from u_ddlb within w_report_production_monthly_summary
integer x = 958
integer y = 51
integer width = 289
integer height = 698
integer taborder = 130
string facename = "Arial"
string item[] = {"1996",""}
end type

event selectionchanged;call super::selectionchanged;is_fromyear = Text(index)
wf_settitle()

RETURN 1
end event

type st_4 from statictext within w_report_production_monthly_summary
integer x = 1258
integer y = 134
integer width = 157
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
string text = "Month"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_report_production_monthly_summary
integer x = 702
integer y = 131
integer width = 249
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
string text = "To: Year"
boolean focusrectangle = false
end type

type st_2 from statictext within w_report_production_monthly_summary
integer x = 699
integer y = 64
integer width = 249
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
string text = "From: Year"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_report from u_dw within w_report_production_monthly_summary
event ue_specs ( )
event ue_retrieve ( )
integer x = 11
integer y = 224
integer width = 3902
integer height = 1389
integer taborder = 10
string dataobject = "d_report_monthly_prod_trend"
boolean hscrollbar = true
end type

event ue_retrieve();Long ll_fromyear, ll_toyear, ll_frommonth, ll_tomonth, ll_y, ll_m, ll_yt, ll_mt
Long ll_id, ll_total, ll_newrow
Date ldt_s, ldt_e


this.Reset()

SetPointer(HourGlass!)

ll_fromyear = Long(is_fromyear)
ll_toyear = Long(is_toyear)

IF ll_fromyear > ll_toyear THEN
	MessageBox("Warning", "Ending year must be after begining year.")
	RETURN
END IF

CHOOSE CASE UPPER(is_frommonth)
	CASE 'JANUARY'
		ll_frommonth = 1
	CASE 'FEBRUARY'
		ll_frommonth = 2
	CASE 'MARCH'
		ll_frommonth = 3
	CASE 'APRIL'
		ll_frommonth = 4
	CASE 'MAY'
		ll_frommonth = 5
	CASE 'JUNE'
		ll_frommonth = 6
	CASE 'JULY' 
		ll_frommonth = 7
	CASE 'AUGUST'
		ll_frommonth = 8
	CASE 'SEPTEMBER'
		ll_frommonth = 9
	CASE 'OCTOBER'
		ll_frommonth = 10
	CASE 'NOVEMBER'
		ll_frommonth = 11
	CASE 'DECEMBER'
		ll_frommonth = 12
END CHOOSE

CHOOSE CASE UPPER(is_tomonth)
	CASE 'JANUARY'
		ll_tomonth = 1
	CASE 'FEBRUARY'
		ll_tomonth = 2
	CASE 'MARCH'
		ll_tomonth = 3
	CASE 'APRIL'
		ll_tomonth = 4
	CASE 'MAY'
		ll_tomonth = 5
	CASE 'JUNE'
		ll_tomonth = 6
	CASE 'JULY' 
		ll_tomonth = 7
	CASE 'AUGUST'
		ll_tomonth = 8
	CASE 'SEPTEMBER'
		ll_tomonth = 9
	CASE 'OCTOBER'
		ll_tomonth = 10
	CASE 'NOVEMBER'
		ll_tomonth = 11
	CASE 'DECEMBER'
		ll_tomonth = 12
END CHOOSE

IF ll_fromyear = ll_toyear AND ll_frommonth > ll_tomonth THEN
	MessageBox("Warning", "Ending month must be after begining month within a year.")
	RETURN
END IF


IF ll_tomonth = 12 THEN
	ll_yt = ll_toyear + 1
	ll_mt = 1
ELSE
	ll_yt = ll_toyear
	ll_mt = ll_tomonth + 1
END IF

ll_id = 1

IF ll_fromyear = ll_toyear THEN
	ll_y = ll_fromyear
	FOR ll_m = ll_frommonth TO ll_tomonth
		ll_total = 0
			IF ll_m = 12 THEN 
				ll_mt = 1
				ll_yt = ll_y + 1
			ELSE
				ll_mt = ll_m + 1
				ll_yt = ll_y
			END IF
			
			 ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
			 ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
			 SELECT 	SUM(NVL(prod_item_net_wt,0)) INTO :ll_total
			 FROM production_sheet_item
			 WHERE prod_item_date >= :ldt_s AND prod_item_date < :ldt_e
			 USING SQLCA;
			 
		ll_newrow = this.InsertRow(0)
		this.SetItem(ll_newrow, "ID", ll_id)
		this.SetItem(ll_newrow, "month", String(ll_m) + "/" + Mid(String(ll_y),3))
		this.SetItem(ll_newrow, "total", ll_total)
		ll_id = ll_id + 1
	NEXT
ELSE 
	ll_y = ll_fromyear
	FOR ll_m = ll_frommonth TO 12
		ll_total = 0
			IF ll_m = 12 THEN 
				ll_mt = 1
				ll_yt = ll_y + 1
			ELSE
				ll_mt = ll_m + 1
				ll_yt = ll_y
			END IF
			
			 ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
			 ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
			 SELECT 	SUM(NVL(prod_item_net_wt,0)) INTO :ll_total
			 FROM production_sheet_item
			 WHERE prod_item_date >= :ldt_s AND prod_item_date < :ldt_e
			 USING SQLCA;

		ll_newrow = this.InsertRow(0)
		this.SetItem(ll_newrow, "ID", ll_id)
		this.SetItem(ll_newrow, "month", String(ll_m) + "/" + Mid(String(ll_y),3))
		this.SetItem(ll_newrow, "total", ll_total)
		ll_id = ll_id + 1
	NEXT
	
	ll_y = ll_y + 1
	DO WHILE ll_y < ll_toyear
		FOR ll_m = 1 TO 12
			ll_total = 0
				IF ll_m = 12 THEN 
					ll_mt = 1
					ll_yt = ll_y + 1
				ELSE
					ll_mt = ll_m + 1
					ll_yt = ll_y
				END IF
				
			 ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
			 ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
			 SELECT 	SUM(NVL(prod_item_net_wt,0)) INTO :ll_total
			 FROM production_sheet_item
			 WHERE prod_item_date >= :ldt_s AND prod_item_date < :ldt_e
			 USING SQLCA;

			ll_newrow = this.InsertRow(0)
			this.SetItem(ll_newrow, "ID", ll_id)
			this.SetItem(ll_newrow, "month", String(ll_m) + "/" + Mid(String(ll_y),3))
			this.SetItem(ll_newrow, "total", ll_total)
			ll_id = ll_id + 1
		NEXT
		ll_y = ll_y + 1
	LOOP

	ll_y = ll_toyear
	FOR ll_m = 1 TO ll_tomonth
		ll_total = 0
			IF ll_m = 12 THEN 
				ll_mt = 1
				ll_yt = ll_y + 1
			ELSE
				ll_mt = ll_m + 1
				ll_yt = ll_y
			END IF
			
			 ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
			 ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
			 SELECT 	SUM(NVL(prod_item_net_wt,0)) INTO :ll_total
			 FROM production_sheet_item
			 WHERE prod_item_date >= :ldt_s AND prod_item_date < :ldt_e
			 USING SQLCA;

		ll_newrow = this.InsertRow(0)
		this.SetItem(ll_newrow, "ID", ll_id)
		this.SetItem(ll_newrow, "month", String(ll_m) + "/" + Mid(String(ll_y),3))
		this.SetItem(ll_newrow, "total", ll_total)
		ll_id = ll_id + 1
	NEXT

END IF

this.ResetUpdate()

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

type cb_print from u_cb within w_report_production_monthly_summary
integer x = 3094
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 170
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_production_monthly_summary
string tag = "Exit"
integer x = 3588
integer y = 1629
integer width = 322
integer height = 74
integer taborder = 180
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_setzoom from u_cb within w_report_production_monthly_summary
integer x = 2600
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type gb_4 from u_gb within w_report_production_monthly_summary
integer x = 2878
integer width = 1039
integer height = 214
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "End User"
end type

type gb_3 from u_gb within w_report_production_monthly_summary
integer x = 1883
integer width = 984
integer height = 214
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
end type

type gb_2 from u_gb within w_report_production_monthly_summary
integer x = 666
integer width = 1211
integer height = 214
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Time Range"
end type

type gb_1 from u_gb within w_report_production_monthly_summary
integer x = 4
integer width = 651
integer height = 214
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Line"
end type

type rb_lineall from u_rb within w_report_production_monthly_summary
integer x = 22
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

dw_report.Event ue_retrieve()
RETURN 1


end event

type rb_line from u_rb within w_report_production_monthly_summary
integer x = 22
integer y = 118
integer width = 197
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

dw_report.Event ue_retrieve()
RETURN 1

end event

type rb_custall from u_rb within w_report_production_monthly_summary
integer x = 1909
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

dw_report.Event ue_retrieve()
RETURN 1


end event

type rb_cust from u_rb within w_report_production_monthly_summary
integer x = 1909
integer y = 118
integer width = 197
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

dw_report.Event ue_retrieve()
RETURN 1

end event

type rb_enduserall from u_rb within w_report_production_monthly_summary
integer x = 2911
integer y = 51
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
boolean checked = true
end type

event clicked;IF this.Checked THEN 
	ddlb_enduser.Enabled = FALSE
ELSE
	ddlb_enduser.Enabled = TRUE
END IF
wf_settitle()
dw_report.Event ue_retrieve()
RETURN 1
end event

type rb_enduser from u_rb within w_report_production_monthly_summary
integer x = 2911
integer y = 118
integer width = 201
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Show"
end type

event clicked;IF this.Checked THEN 
	ddlb_enduser.Enabled = TRUE
ELSE
	ddlb_enduser.Enabled = FALSE
END IF
wf_settitle()
dw_report.Event ue_retrieve()
RETURN 1
end event

type ddlb_line from u_ddlb within w_report_production_monthly_summary
integer x = 227
integer y = 115
integer width = 413
integer height = 672
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
end type

event selectionchanged;is_line = Text(index)
wf_settitle()

RETURN 1


end event

type st_1 from statictext within w_report_production_monthly_summary
integer x = 1251
integer y = 61
integer width = 168
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
string text = "Month"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_cust from u_ddlb within w_report_production_monthly_summary
integer x = 2125
integer y = 118
integer width = 724
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

type ddlb_enduser from u_ddlb within w_report_production_monthly_summary
integer x = 3120
integer y = 118
integer width = 775
integer height = 1059
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
end type

event selectionchanged;Long ll_row, ll_i
String ls_text

ls_text = Text(index)
is_enduser = ls_text
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

dw_report.Event ue_retrieve()

RETURN 1


end event

type dw_allcust from u_dw within w_report_production_monthly_summary
boolean visible = false
integer x = 720
integer y = 1661
integer height = 42
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_customer_short_list"
end type

event constructor;of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)
Retrieve()


end event

type dw_customer from u_dw within w_report_production_monthly_summary
boolean visible = false
integer x = 1130
integer y = 1667
integer height = 38
integer taborder = 50
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

type cb_retrieve from u_cb within w_report_production_monthly_summary
integer x = 2107
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;dw_report.Event ue_retrieve()
Return 1
end event

type dw_line from u_dw within w_report_production_monthly_summary
boolean visible = false
integer x = 1551
integer y = 1674
integer height = 35
integer taborder = 20
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

