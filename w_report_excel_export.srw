$PBExportHeader$w_report_excel_export.srw
$PBExportComments$<popup>report used for exporting to excel format. The SQL command is random.
forward
global type w_report_excel_export from w_sheet
end type
type tab_rpt from tab within w_report_excel_export
end type
type tabpage_sql from userobject within tab_rpt
end type
type dw_title from u_dw within tabpage_sql
end type
type cb_retrieve from u_cb within tabpage_sql
end type
type cb_reset from u_cb within tabpage_sql
end type
type mle_command from multilineedit within tabpage_sql
end type
type gb_1 from groupbox within tabpage_sql
end type
type gb_2 from groupbox within tabpage_sql
end type
type tabpage_sql from userobject within tab_rpt
dw_title dw_title
cb_retrieve cb_retrieve
cb_reset cb_reset
mle_command mle_command
gb_1 gb_1
gb_2 gb_2
end type
type tabpage_rpt from userobject within tab_rpt
end type
type st_status from statictext within tabpage_rpt
end type
type cb_export from u_cb within tabpage_rpt
end type
type cb_print from u_cb within tabpage_rpt
end type
type dw_report from u_dw within tabpage_rpt
end type
type tabpage_rpt from userobject within tab_rpt
st_status st_status
cb_export cb_export
cb_print cb_print
dw_report dw_report
end type
type tab_rpt from tab within w_report_excel_export
tabpage_sql tabpage_sql
tabpage_rpt tabpage_rpt
end type
type cb_close from u_cb within w_report_excel_export
end type
end forward

global type w_report_excel_export from w_sheet
integer x = 592
integer y = 416
integer width = 3697
integer height = 1984
string title = "Excel Export Application"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
tab_rpt tab_rpt
cb_close cb_close
end type
global w_report_excel_export w_report_excel_export

event type string ue_whoami();RETURN "w_report_excel_export"
end event

on w_report_excel_export.create
int iCurrent
call super::create
this.tab_rpt=create tab_rpt
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_rpt
this.Control[iCurrent+2]=this.cb_close
end on

on w_report_excel_export.destroy
call super::destroy
destroy(this.tab_rpt)
destroy(this.cb_close)
end on

type tab_rpt from tab within w_report_excel_export
event create ( )
event destroy ( )
integer x = 4
integer y = 13
integer width = 3664
integer height = 1750
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_sql tabpage_sql
tabpage_rpt tabpage_rpt
end type

on tab_rpt.create
this.tabpage_sql=create tabpage_sql
this.tabpage_rpt=create tabpage_rpt
this.Control[]={this.tabpage_sql,&
this.tabpage_rpt}
end on

on tab_rpt.destroy
destroy(this.tabpage_sql)
destroy(this.tabpage_rpt)
end on

type tabpage_sql from userobject within tab_rpt
event create ( )
event destroy ( )
integer x = 15
integer y = 99
integer width = 3635
integer height = 1638
long backcolor = 79741120
string text = "Setup"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_title dw_title
cb_retrieve cb_retrieve
cb_reset cb_reset
mle_command mle_command
gb_1 gb_1
gb_2 gb_2
end type

on tabpage_sql.create
this.dw_title=create dw_title
this.cb_retrieve=create cb_retrieve
this.cb_reset=create cb_reset
this.mle_command=create mle_command
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_title,&
this.cb_retrieve,&
this.cb_reset,&
this.mle_command,&
this.gb_1,&
this.gb_2}
end on

on tabpage_sql.destroy
destroy(this.dw_title)
destroy(this.cb_retrieve)
destroy(this.cb_reset)
destroy(this.mle_command)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type dw_title from u_dw within tabpage_sql
integer x = 3021
integer y = 64
integer width = 571
integer height = 1440
integer taborder = 40
string dataobject = "d_report_excel_ext_title"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)
this.SetFocus()
this.InsertRow(0)
this.ResetUpdate()

end event

event losefocus;call super::losefocus;this.AcceptText()
this.ResetUpdate()
end event

type cb_retrieve from u_cb within tabpage_sql
integer x = 1284
integer y = 1526
integer width = 351
integer height = 93
integer taborder = 70
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;call super::clicked;tab_rpt.tabpage_rpt.dw_report.Reset()

String ls_sql, ls_modify, ls_where, ls_rc, ls_select, ls_modstring, ls_temp
Int li_l, li_i, li_c

ls_sql = Trim(Upper(mle_command.Text))

li_i = Pos(ls_sql,"ALTER",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept ALTER commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"COMMIT",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept COMMIT commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"CREATE",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept CREATE commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"DROP",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept DROP commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"GRANT",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept GRANT commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"RENAME",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept RENAME commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"REVOKE",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept REVOKE commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"TRUNCATE",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept TRUNCATE commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"DELETE",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept DELETE commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"INSERT",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept INSERT commands.")
	RETURN -1
END IF

li_i = Pos(ls_sql,"UPDATE",1)
IF li_i > 0 OR isNULL(li_i) THEN
	MessageBox("Warning", "This application can NOT accept UPDATE commands.")
	RETURN -1
END IF

//delete ; if necessary
li_i = Pos(ls_sql, ";", 1)
IF  li_i > 0 THEN
	ls_sql = Mid(ls_sql, 1, (li_i - 1))
END IF

//change ' into ~'
li_i = Pos(ls_sql,"'",1)
DO WHILE li_i > 0
    ls_sql = Replace(ls_sql,li_i,1,"~~'")
    li_i = Pos(ls_sql,"'",li_i+Len("~~'"))
LOOP

ls_select = Mid(ls_sql, 1, (Pos(ls_sql, "FROM") - 2))
ls_where = Mid(ls_sql, Pos(ls_sql, "FROM"))
li_l = Len(ls_select)

li_c = 1  //default is 1
FOR li_i = 1 to li_l
	ls_temp = Mid(ls_select, li_i, 1)
	IF ls_temp = "," THEN li_c++
	IF ls_temp = "*" THEN
		MessageBox("Warning", "This application can NOT accept asterisk (*) format, please specify column titles.")
		RETURN -1
	END IF
NEXT
li_c++

IF li_c > 20 THEN
	Messagebox("Warning", "The maximum number of fields in this report is 20, please contact your DBA for assistance.")
ELSE
	FOR li_i = 1 TO li_c 
		ls_temp = dw_title.GetItemString(1, "col_" + string(li_i))
		IF NOT ISNULL(ls_temp) THEN
			ls_modstring = "col_" + string(li_i) + "_t" + ".Text = ~"" + ls_temp +  "~""  
			tab_rpt.tabpage_rpt.dw_report.Modify(ls_modstring) 
		END IF
	NEXT
	
	FOR li_i = li_c TO 20
		ls_select = ls_select + ",NULL"
		ls_modstring = "col_" + string(li_i) + "_t" + ".Text = ~"" + "" +  "~""  //clean unused titles
		tab_rpt.tabpage_rpt.dw_report.Modify(ls_modstring) 
	NEXT
END IF

ls_modify ="DataWindow.Table.Select = '" + ls_select  + " " + ls_where + " '"
ls_rc = tab_rpt.tabpage_rpt.dw_report.Modify(ls_modify)
IF ls_rc = "" THEN
	tab_rpt.SelectTab(2)
	tab_rpt.tabpage_rpt.st_status.Text = "Retrieving data, please wait..."
	tab_rpt.tabpage_rpt.dw_report.Retrieve()
	
	tab_rpt.tabpage_rpt.st_status.Text = "Done. " + String(tab_rpt.tabpage_rpt.dw_report.RowCount()) + " rows retrieved."
ELSE
	MessageBox("Error","Failure to create datawindow!", StopSign!)
END IF

RETURN 1

end event

type cb_reset from u_cb within tabpage_sql
integer x = 2081
integer y = 1526
integer width = 351
integer height = 93
integer taborder = 70
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "R&eset"
end type

event clicked;call super::clicked;Int li_i
String ls_modstring

mle_command.Text = ""
tab_rpt.tabpage_rpt.dw_report.Reset()
FOR li_i = 1 TO 20
	ls_modstring = "col_" + string(li_i) + "_t" + ".Text = ~"" + "Title " + String(li_i) +  "~""  
	tab_rpt.tabpage_rpt.dw_report.Modify(ls_modstring) 
NEXT

dw_title.Reset()
dw_title.InsertRow(0)
dw_title.ResetUpdate()



end event

type mle_command from multilineedit within tabpage_sql
integer x = 37
integer y = 64
integer width = 2907
integer height = 1440
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type gb_1 from groupbox within tabpage_sql
integer x = 11
integer y = 3
integer width = 2955
integer height = 1514
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "SQL Command"
end type

type gb_2 from groupbox within tabpage_sql
integer x = 2984
integer y = 3
integer width = 633
integer height = 1514
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Column Title"
end type

type tabpage_rpt from userobject within tab_rpt
event create ( )
event destroy ( )
integer x = 15
integer y = 99
integer width = 3635
integer height = 1638
long backcolor = 67108864
string text = "Report"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_status st_status
cb_export cb_export
cb_print cb_print
dw_report dw_report
end type

on tabpage_rpt.create
this.st_status=create st_status
this.cb_export=create cb_export
this.cb_print=create cb_print
this.dw_report=create dw_report
this.Control[]={this.st_status,&
this.cb_export,&
this.cb_print,&
this.dw_report}
end on

on tabpage_rpt.destroy
destroy(this.st_status)
destroy(this.cb_export)
destroy(this.cb_print)
destroy(this.dw_report)
end on

type st_status from statictext within tabpage_rpt
integer x = 2706
integer y = 1533
integer width = 911
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Done"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_export from u_cb within tabpage_rpt
string tag = "Export current report to Excel format"
integer x = 1949
integer y = 1536
integer width = 351
integer height = 93
integer taborder = 100
integer weight = 700
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
	messageBox("Success", "Data have been successfully saved as " + ls_file)
end if

RETURN 1
end event

type cb_print from u_cb within tabpage_rpt
integer x = 1236
integer y = 1536
integer width = 351
integer height = 93
integer taborder = 90
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type dw_report from u_dw within tabpage_rpt
integer x = 7
integer y = 13
integer width = 3621
integer height = 1514
integer taborder = 70
string dataobject = "d_report_excel_ext"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)
this.SetTransObject(SQLCA)
this.SetFocus()

end event

type cb_close from u_cb within w_report_excel_export
string tag = "Close without printing"
integer x = 3317
integer y = 1792
integer width = 351
integer height = 93
integer taborder = 20
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

