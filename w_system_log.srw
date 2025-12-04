$PBExportHeader$w_system_log.srw
$PBExportComments$<sheet> system log inherited from pfemain/w_sheet
forward
global type w_system_log from w_sheet
end type
type dw_list from u_dw within w_system_log
end type
type dw_log from u_dw within w_system_log
end type
type cb_print from u_cb within w_system_log
end type
type cb_pre from u_cb within w_system_log
end type
type cb_next from u_cb within w_system_log
end type
type cb_close from u_cb within w_system_log
end type
type st_message_count from statictext within w_system_log
end type
end forward

global type w_system_log from w_sheet
int Width=2191
int Height=1411
boolean TitleBar=true
string Title="System Log Viewer"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_read_only ( )
event type string ue_whoami ( )
dw_list dw_list
dw_log dw_log
cb_print cb_print
cb_pre cb_pre
cb_next cb_next
cb_close cb_close
st_message_count st_message_count
end type
global w_system_log w_system_log

event ue_whoami;RETURN "w_system_log"
end event

on w_system_log.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_log=create dw_log
this.cb_print=create cb_print
this.cb_pre=create cb_pre
this.cb_next=create cb_next
this.cb_close=create cb_close
this.st_message_count=create st_message_count
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_log
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_pre
this.Control[iCurrent+5]=this.cb_next
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.st_message_count
end on

on w_system_log.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_log)
destroy(this.cb_print)
destroy(this.cb_pre)
destroy(this.cb_next)
destroy(this.cb_close)
destroy(this.st_message_count)
end on

event open;call super::open;Long ll_row
s_security_data  lds_sec

SetPointer(HourGlass!)

IF f_security_door("System Log") < 0 THEN
	OpenWithParm(w_security_check, "System Log")
	lds_sec = Message.PowerObjectParm
	IF lds_sec.security_level < 0 THEN
		Close(this)
		RETURN 0
	END IF
END IF

dw_list.of_SetTransObject(sqlca) 
IF dw_list.Event pfc_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_system_log::open function" )
Else
	SQLCA.of_Commit()
End IF

end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("System Log") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event pfc_print;DataStore lds_print 

lds_print = CREATE datastore  
lds_print.DataObject = "d_report_sys_log"  
lds_print.SetTransObject (SQLCA)
lds_print.retrieve()

lds_print.Print()
DESTROY lds_print
RETURN 1

end event

type dw_list from u_dw within w_system_log
int X=0
int Y=0
int Width=870
int Height=1178
int TabOrder=10
boolean BringToTop=true
string DataObject="d_sys_log_list"
boolean LiveScroll=false
end type

event pfc_retrieve;call super::pfc_retrieve;RETURN this.Retrieve()
end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

li_Row = dw_list.GetRow()
dw_list.SelectRow(0, False)
dw_list.SelectRow(li_Row, True)

dw_log.Event ue_display_row()

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type dw_log from u_dw within w_system_log
event ue_display_row ( )
int X=867
int Y=0
int Width=1295
int Height=1178
int TabOrder=50
boolean BringToTop=true
string DataObject="d_sys_log"
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
boolean LiveScroll=false
end type

event ue_display_row;Long ll_currow, ll_row, ll_id

ll_row = dw_list.RowCount()
ll_currow = dw_list.GetRow()

IF ll_row < 1 THEN Return
IF ll_currow < 1 THEN Return

ll_id = dw_list.GetItemNumber(ll_currow, "system_log_key_num")

st_message_count.Text = String(ll_currow) + "/" + String(ll_row)

This.Retrieve(ll_id)
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)

end event

type cb_print from u_cb within w_system_log
int X=212
int Y=1203
int TabOrder=40
boolean BringToTop=true
string Text="&Print"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Parent.Event pfc_Print()
end event

type cb_pre from u_cb within w_system_log
int X=647
int Y=1203
int TabOrder=30
boolean BringToTop=true
string Text="P&rior"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_list.ScrollPriorRow()
end event

type cb_next from u_cb within w_system_log
int X=1083
int Y=1203
int TabOrder=20
boolean BringToTop=true
string Text="&Next"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_list.ScrollNextRow()
end event

type cb_close from u_cb within w_system_log
int X=1518
int Y=1203
int TabOrder=11
boolean BringToTop=true
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(Parent)
end event

type st_message_count from statictext within w_system_log
int X=1883
int Y=1181
int Width=278
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="1/1"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

