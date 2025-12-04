$PBExportHeader$w_email_customer_trans.srw
$PBExportComments$<Response>email customer about their trans
forward
global type w_email_customer_trans from w_sheet
end type
type dw_report from u_dw within w_email_customer_trans
end type
type cb_print from u_cb within w_email_customer_trans
end type
type cb_close from u_cb within w_email_customer_trans
end type
type cb_email from u_cb within w_email_customer_trans
end type
end forward

global type w_email_customer_trans from w_sheet
integer x = 622
integer y = 125
integer width = 2498
integer height = 1770
string title = "Email"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_email cb_email
end type
global w_email_customer_trans w_email_customer_trans

type variables
Int ii_sheettype
end variables

on w_email_customer_trans.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_email=create cb_email
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_email
end on

on w_email_customer_trans.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_email)
end on

event open;call super::open;DataStore lds_temp
lds_temp = CREATE datastore
lds_temp = message.PowerObjectParm
dw_report.SetTransObject(sqlca)
lds_temp.RowsCopy(lds_temp.GetRow(),lds_temp.RowCount(), Primary!, dw_report, 1, Primary!)
DESTROY lds_temp
dw_report.SetFocus()


end event

type dw_report from u_dw within w_email_customer_trans
integer x = 22
integer y = 13
integer width = 2439
integer height = 1546
integer taborder = 40
string dataobject = "d_email_datastore"
boolean hscrollbar = true
end type

event losefocus;This.ResetUpdate()
end event

type cb_print from u_cb within w_email_customer_trans
integer x = 329
integer y = 1571
integer width = 351
integer height = 83
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;PrintSetup()

dw_report.print()
end event

type cb_close from u_cb within w_email_customer_trans
string tag = "Close without printing"
integer x = 1682
integer y = 1571
integer width = 351
integer height = 83
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_email from u_cb within w_email_customer_trans
integer x = 1006
integer y = 1571
integer width = 351
integer height = 83
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Send"
end type

event clicked;SetPointer(HourGlass!)
String ls_file, ls_today, ls_now
Date ld_today
Time ld_now

ld_today = Today()
ld_now = Now()
ls_today = string(ld_today,"yymmdd")
ls_now = string(ld_now,"hhmm")

ls_file = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp")+'\m_' + ls_today + ls_now + ".txt"
if dw_report.SaveAs(ls_file,Text!, false) =-1 then
   MessageBox("Email SaveAs", "Error")
	return -1
end if

f_send_email(0,ls_file)

RETURN 1
end event

