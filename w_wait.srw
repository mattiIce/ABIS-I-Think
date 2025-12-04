$PBExportHeader$w_wait.srw
forward
global type w_wait from window
end type
type st_clock from statictext within w_wait
end type
type st_header_line3 from statictext within w_wait
end type
type st_header_line2 from statictext within w_wait
end type
type st_header_line1 from statictext within w_wait
end type
type st_seconds from statictext within w_wait
end type
type st_waiting from statictext within w_wait
end type
end forward

global type w_wait from window
integer width = 1434
integer height = 1101
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_clock st_clock
st_header_line3 st_header_line3
st_header_line2 st_header_line2
st_header_line1 st_header_line1
st_seconds st_seconds
st_waiting st_waiting
end type
global w_wait w_wait

type variables

end variables

on w_wait.create
this.st_clock=create st_clock
this.st_header_line3=create st_header_line3
this.st_header_line2=create st_header_line2
this.st_header_line1=create st_header_line1
this.st_seconds=create st_seconds
this.st_waiting=create st_waiting
this.Control[]={this.st_clock,&
this.st_header_line3,&
this.st_header_line2,&
this.st_header_line1,&
this.st_seconds,&
this.st_waiting}
end on

on w_wait.destroy
destroy(this.st_clock)
destroy(this.st_header_line3)
destroy(this.st_header_line2)
destroy(this.st_header_line1)
destroy(this.st_seconds)
destroy(this.st_waiting)
end on

event open;str_wait	lstr_wait
Long		ll_seconds
String	ls_unit_of_measure, ls_header_line1, ls_header_line2, ls_header_line3

lstr_wait = Message.PowerObjectParm

ll_seconds = lstr_wait.number_of_seconds //This response window will close in 'll_seconds' seconds
ls_unit_of_measure = lstr_wait.unit_of_measure
ls_header_line1 = lstr_wait.header_line1
ls_header_line2 = lstr_wait.header_line2
ls_header_line3 = lstr_wait.header_line3

//ll_seconds = 12 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

st_waiting.Text = "Waiting for " + String(ll_seconds) + " " + ls_unit_of_measure + "..."
st_header_line1.Text = ls_header_line1
st_header_line2.Text = ls_header_line2
st_header_line3.Text = ls_header_line3

st_seconds.Text = String(ll_seconds)
st_clock.Text = String(DateTime(Today(), Now()))

Timer(1, This) //Call Timer event every second
end event

event timer;Integer	li_second

li_second = Integer(st_seconds.Text)

If li_second <= 1 Then
	Close(This)
	Return
End If

li_second = li_second - 1 //Count down
st_seconds.Text = String(li_second)
st_clock.Text = String(DateTime(Today(), Now()))


end event

type st_clock from statictext within w_wait
integer x = 907
integer y = 384
integer width = 527
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_header_line3 from statictext within w_wait
integer x = 29
integer y = 253
integer width = 1375
integer height = 77
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_header_line2 from statictext within w_wait
integer x = 29
integer y = 176
integer width = 1375
integer height = 77
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_header_line1 from statictext within w_wait
integer x = 29
integer y = 102
integer width = 1375
integer height = 77
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_seconds from statictext within w_wait
integer x = 176
integer y = 307
integer width = 1053
integer height = 768
integer textsize = -150
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Consolas"
long textcolor = 33554432
long backcolor = 67108864
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_waiting from statictext within w_wait
integer x = 29
integer width = 1375
integer height = 77
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

