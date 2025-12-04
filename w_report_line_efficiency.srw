$PBExportHeader$w_report_line_efficiency.srw
$PBExportComments$list line downtime efficiency
forward
global type w_report_line_efficiency from w_sheet
end type
type st_2 from statictext within w_report_line_efficiency
end type
type cbx_thisyear from checkbox within w_report_line_efficiency
end type
type cbx_lastyear from checkbox within w_report_line_efficiency
end type
type cbx_yearbefore from checkbox within w_report_line_efficiency
end type
type dw_report_2 from u_dw within w_report_line_efficiency
end type
type cb_print from u_cb within w_report_line_efficiency
end type
type cb_close from u_cb within w_report_line_efficiency
end type
type gb_2 from u_gb within w_report_line_efficiency
end type
type gb_1 from u_gb within w_report_line_efficiency
end type
type ddlb_line from u_ddlb within w_report_line_efficiency
end type
type em_from from u_em within w_report_line_efficiency
end type
type em_to from u_em within w_report_line_efficiency
end type
type st_1 from statictext within w_report_line_efficiency
end type
type cb_retrieve from u_cb within w_report_line_efficiency
end type
type dw_line from u_dw within w_report_line_efficiency
end type
type ln_1 from line within w_report_line_efficiency
end type
type ln_2 from line within w_report_line_efficiency
end type
type ln_3 from line within w_report_line_efficiency
end type
end forward

global type w_report_line_efficiency from w_sheet
string tag = "ABCO production line efficiency report"
integer x = 4
integer y = 3
integer width = 4491
integer height = 2054
string title = "Production Report - Line Efficiency"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
st_2 st_2
cbx_thisyear cbx_thisyear
cbx_lastyear cbx_lastyear
cbx_yearbefore cbx_yearbefore
dw_report_2 dw_report_2
cb_print cb_print
cb_close cb_close
gb_2 gb_2
gb_1 gb_1
ddlb_line ddlb_line
em_from em_from
em_to em_to
st_1 st_1
cb_retrieve cb_retrieve
dw_line dw_line
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
end type
global w_report_line_efficiency w_report_line_efficiency

type variables
String is_line
Long il_line, il_thisyear, il_lastyear, il_yearbefore


end variables

forward prototypes
public subroutine wf_settitle ()
end prototypes

event type string ue_whoami();RETURN "w_report_line_efficiency"
end event

public subroutine wf_settitle ();String ls_modstring, ls_s

ls_s = is_line + " Line Efficiency Report (" + em_from.Text + " - " + em_to.Text + ") "
ls_modstring = "title_t.Text = ~"" + ls_s + "~""
dw_report_2.Modify(ls_modstring) 



end subroutine

on w_report_line_efficiency.create
int iCurrent
call super::create
this.st_2=create st_2
this.cbx_thisyear=create cbx_thisyear
this.cbx_lastyear=create cbx_lastyear
this.cbx_yearbefore=create cbx_yearbefore
this.dw_report_2=create dw_report_2
this.cb_print=create cb_print
this.cb_close=create cb_close
this.gb_2=create gb_2
this.gb_1=create gb_1
this.ddlb_line=create ddlb_line
this.em_from=create em_from
this.em_to=create em_to
this.st_1=create st_1
this.cb_retrieve=create cb_retrieve
this.dw_line=create dw_line
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cbx_thisyear
this.Control[iCurrent+3]=this.cbx_lastyear
this.Control[iCurrent+4]=this.cbx_yearbefore
this.Control[iCurrent+5]=this.dw_report_2
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.ddlb_line
this.Control[iCurrent+11]=this.em_from
this.Control[iCurrent+12]=this.em_to
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.cb_retrieve
this.Control[iCurrent+15]=this.dw_line
this.Control[iCurrent+16]=this.ln_1
this.Control[iCurrent+17]=this.ln_2
this.Control[iCurrent+18]=this.ln_3
end on

on w_report_line_efficiency.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cbx_thisyear)
destroy(this.cbx_lastyear)
destroy(this.cbx_yearbefore)
destroy(this.dw_report_2)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.ddlb_line)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_1)
destroy(this.cb_retrieve)
destroy(this.dw_line)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

event open;call super::open;Long ll_row, ll_c
String ls_spec, ls_thisyear
Long ll_job, ll_bal_due

select to_char(sysdate, 'YYYY') into :ls_thisyear from dual USING SQLCA;

il_thisyear = Long(ls_thisyear)
il_lastyear = il_thisyear - 1
il_yearbefore = il_lastyear - 1

cbx_thisyear.Text = "Show " + String(il_thisyear) + " average"
cbx_lastyear.Text = "Show " + String(il_lastyear) + " average"
cbx_yearbefore.Text = "Show " + String(il_yearbefore) + " average"


ll_row = dw_line.RowCount()
IF ll_row > 0 THEN 
	FOR ll_c = 1 TO ll_row
		ddlb_line.AddItem(dw_line.GetItemString(ll_c, "line_desc"))
	NEXT
END IF

wf_settitle()


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

type st_2 from statictext within w_report_line_efficiency
integer x = 3957
integer y = 426
integer width = 121
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
string text = "From"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_thisyear from checkbox within w_report_line_efficiency
integer x = 3946
integer y = 1053
integer width = 508
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "Show 2011 average"
end type

event clicked;Real lr_eff, lr_height
String ls_thisyear, ls_modify

If this.Checked THEN
   ls_thisyear = String(il_thisyear, "####")

	SELECT SUM(100-100*(dt_total/(86400*(end_time - start_time))))/COUNT(SHIFT_NUM) INTO :lr_eff
	FROM SHIFT
	WHERE dt_total is not NULL and line_num = :il_line and to_char(start_time, 'YYYY') = :ls_thisyear
	USING SQLCA;

   lr_height = 1515 - (lr_eff / 100 * 1260)
	
	dw_report_2.Modify("l_thisyear.Y1 = " + String(lr_height, "#####"))
	dw_report_2.Modify("l_thisyear.Y2 = " + String(lr_height, "#####"))
	dw_report_2.Modify("t_thisyear.Y = " + String(lr_height, "#####"))
	ls_modify = "t_thisyear.Text = ~"" + String(lr_eff, "##.##") + "%~""
	dw_report_2.Modify(ls_modify)
	
	dw_report_2.Modify("l_thisyear.Visible = true")
	dw_report_2.Modify("t_thisyear.Visible = true")
ELSE 
	dw_report_2.Modify("l_thisyear.Visible = false")
	dw_report_2.Modify("t_thisyear.Visible = false")
END IF

end event

type cbx_lastyear from checkbox within w_report_line_efficiency
integer x = 3950
integer y = 896
integer width = 508
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "Show 2010 average"
end type

event clicked;Real lr_eff, lr_height
String ls_lastyear, ls_modify

If this.Checked THEN
   ls_lastyear = String(il_lastyear, "####")

	SELECT SUM(100-100*(dt_total/(86400*(end_time - start_time))))/COUNT(SHIFT_NUM) INTO :lr_eff
	FROM SHIFT
	WHERE dt_total is not NULL and line_num = :il_line and to_char(start_time, 'YYYY') = :ls_lastyear
	USING SQLCA;
	
	lr_height = 1515 - (lr_eff / 100 * 1260)
	
	dw_report_2.Modify("l_lastyear.Y1 = " + String(lr_height, "#####"))
	dw_report_2.Modify("l_lastyear.Y2 = " + String(lr_height, "#####"))
	dw_report_2.Modify("t_lastyear.Y = " + String(lr_height, "#####"))
	ls_modify = "t_lastyear.Text = ~"" + String(lr_eff, "##.##") + "%~""
	dw_report_2.Modify(ls_modify)
	
	dw_report_2.Modify("l_lastyear.Visible = true")
	dw_report_2.Modify("t_lastyear.Visible = true")
ELSE 
	dw_report_2.Modify("l_lastyear.Visible = false")
	dw_report_2.Modify("t_lastyear.Visible = false")
END IF

end event

type cbx_yearbefore from checkbox within w_report_line_efficiency
integer x = 3950
integer y = 739
integer width = 508
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "Show 2009 average"
end type

event clicked;Real lr_eff, lr_height
String ls_yearbefore, ls_modify

If this.Checked THEN
   ls_yearbefore = String(il_yearbefore, "####")

	SELECT SUM(100-100*(dt_total/(86400*(end_time - start_time))))/COUNT(SHIFT_NUM) INTO :lr_eff
	FROM SHIFT
	WHERE dt_total is not NULL and line_num = :il_line and to_char(start_time, 'YYYY') = :ls_yearbefore
	USING SQLCA;
	
	lr_height = 1515 - (lr_eff / 100 * 1260)
	
	dw_report_2.Modify("l_yearbefore.Y1 = " + String(lr_height, "#####"))
	dw_report_2.Modify("l_yearbefore.Y2 = " + String(lr_height, "#####"))
	dw_report_2.Modify("t_yearbefore.Y = " + String(lr_height, "#####"))
	ls_modify = "t_yearbefore.Text = ~"" + String(lr_eff, "##.##") + "%~""
	dw_report_2.Modify(ls_modify)
	
	dw_report_2.Modify("l_yearbefore.Visible = true")
	dw_report_2.Modify("t_yearbefore.Visible = true")
ELSE 
	dw_report_2.Modify("l_yearbefore.Visible = false")
	dw_report_2.Modify("t_yearbefore.Visible = false")
END IF

end event

type dw_report_2 from u_dw within w_report_line_efficiency
integer x = 7
integer y = 10
integer width = 3902
integer height = 1955
integer taborder = 160
string dataobject = "d_line_efficiency_report_line"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)


end event

type cb_print from u_cb within w_report_line_efficiency
integer x = 4059
integer y = 1347
integer width = 307
integer height = 74
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_line_efficiency
string tag = "Exit"
integer x = 4059
integer y = 1475
integer width = 322
integer height = 74
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type gb_2 from u_gb within w_report_line_efficiency
integer x = 3935
integer y = 298
integer width = 523
integer height = 326
integer taborder = 100
string text = "Date Range"
end type

type gb_1 from u_gb within w_report_line_efficiency
integer x = 3942
integer y = 26
integer width = 519
integer height = 214
integer taborder = 130
string text = "Line"
end type

type ddlb_line from u_ddlb within w_report_line_efficiency
integer x = 4012
integer y = 99
integer width = 410
integer height = 314
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
end type

event selectionchanged;Long ll_row, ll_i

is_line = Text(index)
ll_row = dw_line.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_line.GetItemString(ll_i, "line_desc") = is_line THEN
		il_line = dw_line.GetItemNumber(ll_i, "line_num")
	END IF
NEXT
wf_settitle()

RETURN 1


end event

type em_from from u_em within w_report_line_efficiency
integer x = 4144
integer y = 422
integer width = 289
integer height = 77
integer taborder = 80
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event losefocus;call super::losefocus;wf_settitle()
end event

type em_to from u_em within w_report_line_efficiency
integer x = 4147
integer y = 506
integer width = 282
integer height = 77
integer taborder = 70
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event modified;call super::modified;wf_settitle()
end event

type st_1 from statictext within w_report_line_efficiency
integer x = 3994
integer y = 518
integer width = 91
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

type cb_retrieve from u_cb within w_report_line_efficiency
integer x = 4059
integer y = 1219
integer width = 307
integer height = 74
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;DateTime ldt_s, ldt_e

wf_settitle()

ldt_s = Datetime(Date(em_from.Text), Time("00:00:00") ) 
ldt_e = Datetime(Date(em_to.Text), Time("23:59:59") ) 

dw_report_2.Retrieve(ldt_s, ldt_e, il_line)


RETURN 1
end event

type dw_line from u_dw within w_report_line_efficiency
boolean visible = false
integer x = 4136
integer y = 1632
integer height = 112
integer taborder = 11
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

type ln_1 from line within w_report_line_efficiency
long linecolor = 255
integer linethickness = 9
integer beginx = 4114
integer beginy = 1130
integer endx = 4319
integer endy = 1130
end type

type ln_2 from line within w_report_line_efficiency
long linecolor = 16711680
integer linethickness = 9
integer beginx = 4114
integer beginy = 973
integer endx = 4319
integer endy = 973
end type

type ln_3 from line within w_report_line_efficiency
long linecolor = 65535
integer linethickness = 9
integer beginx = 4114
integer beginy = 810
integer endx = 4319
integer endy = 810
end type

