$PBExportHeader$w_report_sketch_profiler.srw
$PBExportComments$<Response> print out selected sketch from sketch Profiler
forward
global type w_report_sketch_profiler from w_sheet
end type
type dw_report from u_dw within w_report_sketch_profiler
end type
type cb_print from u_cb within w_report_sketch_profiler
end type
type cb_close from u_cb within w_report_sketch_profiler
end type
end forward

global type w_report_sketch_profiler from w_sheet
integer x = 318
integer y = 144
integer width = 3079
integer height = 1770
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_report dw_report
cb_print cb_print
cb_close cb_close
end type
global w_report_sketch_profiler w_report_sketch_profiler

type variables
Int ii_sheettype
end variables

on w_report_sketch_profiler.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_close
end on

on w_report_sketch_profiler.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
end on

event open;call super::open;Long ll_id
String	ls_modstring, ls_rtn //Alex Gerlants. 07/20/2016

ll_id = message.DoubleParm

//Alex Gerlants. 07/20/2016. Begin
//At this point, sketch.jpg has the correct picture in gs_Sketch_file.

//Change file Sketch.jpg location from "sketch.jpg" (as on d_report_sketch_profiler) to gs_Sketch_file
//wf_set_sketch_file for w_sketch_management in silverdome1.pbl
//This window is open in Clicked for cb_print on w_sketch_management in silverdome1.pbl
ls_modstring = "p_1.filename = '" + gs_Sketch_file + "'"
ls_rtn = dw_report.Modify(ls_modstring)
//Alex Gerlants. 07/20/2016. End

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(ll_id)
this.title = "Printing Sketch ID # :  " + String(ll_id)
dw_report.SetFocus()


end event

type dw_report from u_dw within w_report_sketch_profiler
integer x = 22
integer y = 6
integer width = 3013
integer height = 1546
integer taborder = 30
string dataobject = "d_report_sketch_profiler"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

type cb_print from u_cb within w_report_sketch_profiler
integer x = 951
integer y = 1568
integer width = 351
integer height = 83
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;Window lw_parent

PrintSetup()

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()

IF IsValid(lw_parent) THEN
	IF lw_Parent.Dynamic wf_set_sketch_file() < 0 THEN RETURN 0
END IF	

dw_report.print()
end event

type cb_close from u_cb within w_report_sketch_profiler
string tag = "Close without printing"
integer x = 1679
integer y = 1568
integer width = 351
integer height = 83
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;Close(Parent)
end event

