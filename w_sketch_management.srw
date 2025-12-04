$PBExportHeader$w_sketch_management.srw
$PBExportComments$<Sheet> display and modify sketch information inherited from pfemain/w_sheet
forward
global type w_sketch_management from w_sheet
end type
type dw_sketch_list from u_dw within w_sketch_management
end type
type mle_desc from u_mle within w_sketch_management
end type
type st_1 from statictext within w_sketch_management
end type
type sle_title from u_sle within w_sketch_management
end type
type st_2 from statictext within w_sketch_management
end type
type cb_save from u_cb within w_sketch_management
end type
type cb_close from u_cb within w_sketch_management
end type
type p_1 from picture within w_sketch_management
end type
type cb_open from u_cb within w_sketch_management
end type
type cb_new from u_cb within w_sketch_management
end type
type cbx_obsolete from checkbox within w_sketch_management
end type
type cb_print from u_cb within w_sketch_management
end type
end forward

global type w_sketch_management from w_sheet
integer x = 37
integer y = 218
integer width = 3664
integer height = 2048
string title = "Sketch Profiler"
boolean maxbox = false
boolean resizable = false
event ue_open ( )
event type string ue_whoami ( )
dw_sketch_list dw_sketch_list
mle_desc mle_desc
st_1 st_1
sle_title sle_title
st_2 st_2
cb_save cb_save
cb_close cb_close
p_1 p_1
cb_open cb_open
cb_new cb_new
cbx_obsolete cbx_obsolete
cb_print cb_print
end type
global w_sketch_management w_sketch_management

type variables
Boolean ib_notsaved
Boolean ib_newbmp
Blob ib_pic
end variables

forward prototypes
public function integer wf_save ()
public function blob wf_get_bmp ()
public function integer wf_set_sketch_file ()
end prototypes

event ue_open;call super::ue_open;ib_pic = wf_get_bmp()
IF IsNull(ib_pic) THEN Return 
p_1.SetPicture(ib_pic)
ib_newbmp = TRUE

end event

event ue_whoami;RETURN "w_sketch_management"
end event

public function integer wf_save ();int li_row
int li_status
Long ll_sid

IF sle_title.Text = "" THEN
	MessageBox("Error", "You must supply a title!")
	Return -1
END IF

dw_sketch_list.Event pfc_Update(TRUE,TRUE)

li_row = dw_sketch_list.GetRow()
IF li_row <= 0 THEN Return -2
ll_sid = dw_sketch_list.GetItemNumber(li_row, "sketch_id")

IF cbx_obsolete.Checked THEN
	li_status = 0
ELSE
	li_status = 1
END IF

SetPointer(HourGlass!)

UPDATE sketch_jpg
SET sketch_name = :sle_title.Text, sketch_notes = :mle_desc.Text, sketch_status = :li_status
WHERE sketch_id = :ll_sid
USING SQLCA;
IF SQLCA.SQLCode >= 0 THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
	Return -3
END IF

UPDATEBLOB sketch_jpg
SET sketch_view = :ib_pic
WHERE sketch_id = :ll_sid
USING SQLCA;
IF SQLCA.SQLCode >= 0 THEN
	COMMIT USING SQLCA;
	MessageBox("Info", "Sketch has been saved successfully.")
ELSE
	MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
	Return -4
END IF

//obselete coding
UPDATE sketch_jpg
SET sketch_name = :sle_title.Text, sketch_notes = :mle_desc.Text, sketch_status = :li_status
WHERE sketch_id = :ll_sid
USING SQLCA;
IF SQLCA.SQLCode >= 0 THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
	Return -5
END IF
//end of coding

dw_sketch_list.Reset()
dw_sketch_list.Event pfc_Retrieve()

Return 0
end function

public function blob wf_get_bmp ();Integer li_filenum, li_loops, li_i
Long ll_flen, ll_bytes_read, ll_new_pos
blob lb_b, lb_tot_b
String ls_docname, ls_named
integer li_val

SetPointer(HourGlass!)

li_val = GetFileOpenName("Select File", ls_docname, ls_named, "JPG", "JPEG Files (*.jpg),*.jpg" )
IF li_val <> 1 THEN
	SetNull(lb_tot_b)
	RETURN lb_tot_b 
END IF

ll_flen = FileLength(ls_docname)
li_filenum = FileOpen(ls_docname, StreamMode!, Read!, LockRead!)
IF ll_flen > 32765 THEN
	IF Mod(ll_flen, 32765) = 0 THEN
		li_loops = ll_flen / 32765
	ELSE
		li_loops = (ll_flen / 32765) + 1
	END IF
ELSE
	li_loops = 1
END IF

ll_new_pos = 1
FOR li_i = 1 TO li_loops
	ll_bytes_read = FileRead(li_FileNum, lb_b)
	lb_tot_b = lb_tot_b + lb_b
NEXT

FileClose(li_FileNum)

Return lb_tot_b
end function

public function integer wf_set_sketch_file ();//copy current sketch to current directory sketch.bmp file
// and will be used in the production order report
Int li_filenum
Long ll_flen
Long ll_new_pos
Int li_loops, li_i
Blob lb_pic
Long ll_sid

SetPointer(HourGlass!)

ll_sid = dw_sketch_list.GetItemNumber(dw_sketch_list.Getrow(), "sketch_id")
IF ll_sid <= 0 THEN 
	MessageBox("Error", "Invalid sketch id!")
	Return 0
END IF

SELECTBLOB sketch_view 
INTO :lb_pic
FROM sketch_jpg
WHERE sketch_id = :ll_sid
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return -1
END IF

ll_flen = Len(lb_pic)
IF ll_flen > 32765 THEN
	IF Mod(ll_flen, 32765) = 0 THEN
		li_loops = ll_flen / 32765
	ELSE
		li_loops = (ll_flen / 32765) + 1
	END IF
ELSE
	li_loops = 1
END IF

ll_new_pos = 1
li_filenum = FileOpen(gs_Sketch_file, StreamMode!, Write!, LockReadWrite!, Replace!)
FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
FileClose(li_FileNum)

FOR li_i = 1 TO li_loops
	li_filenum = FileOpen(gs_Sketch_file, StreamMode!, Write!, LockreadWrite!,Append!)
	FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
	FileClose(li_FileNum)
NEXT

Return 1
end function

on w_sketch_management.create
int iCurrent
call super::create
this.dw_sketch_list=create dw_sketch_list
this.mle_desc=create mle_desc
this.st_1=create st_1
this.sle_title=create sle_title
this.st_2=create st_2
this.cb_save=create cb_save
this.cb_close=create cb_close
this.p_1=create p_1
this.cb_open=create cb_open
this.cb_new=create cb_new
this.cbx_obsolete=create cbx_obsolete
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sketch_list
this.Control[iCurrent+2]=this.mle_desc
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_title
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.p_1
this.Control[iCurrent+9]=this.cb_open
this.Control[iCurrent+10]=this.cb_new
this.Control[iCurrent+11]=this.cbx_obsolete
this.Control[iCurrent+12]=this.cb_print
end on

on w_sketch_management.destroy
call super::destroy
destroy(this.dw_sketch_list)
destroy(this.mle_desc)
destroy(this.st_1)
destroy(this.sle_title)
destroy(this.st_2)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.p_1)
destroy(this.cb_open)
destroy(this.cb_new)
destroy(this.cbx_obsolete)
destroy(this.cb_print)
end on

event open;call super::open;SetPointer(HourGlass!)
s_security_data  lds_sec

IF f_security_door("Production Sketch") < 0 THEN
	OpenWithParm(w_security_check, "Production Sketch")
	lds_sec = Message.PowerObjectParm
	IF lds_sec.security_level < 0 THEN
		Close(this)
		RETURN 0
	END IF
END IF

dw_sketch_list.SetTransObject(SQLCA)
dw_sketch_list.Retrieve()
ib_newbmp = FALSE
end event

event close;call super::close;f_display_app()
end event

type dw_sketch_list from u_dw within w_sketch_management
integer x = 15
integer y = 10
integer width = 662
integer height = 1808
integer taborder = 10
string dataobject = "d_sketch_list"
boolean livescroll = false
end type

event clicked;call super::clicked;long ll_sid
int li_rc, li_status

IF ib_notsaved THEN
	li_rc = MessageBox("The current sketch has been changed", "Do you want to save?", Question!, YesNoCancel! )
	IF li_rc = 1 THEN li_rc = wf_save()
	IF li_rc = -1 OR li_rc = 3 THEN Return
END IF

IF row <= 0 THEN return

this.selectrow(0, FALSE)
this.selectrow(row, TRUE)

ll_sid = this.GetItemNumber(row, "sketch_id")
IF ll_sid <= 0 THEN 
	MessageBox("Error", "Invalid sketch id!")
	Return 
END IF

SetPointer(HourGlass!)

SELECT sketch_name, sketch_notes, sketch_status
INTO :sle_title.Text, :mle_desc.Text, :li_status
FROM sketch_jpg
WHERE sketch_id = :ll_sid
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return
END IF
IF li_status = 0 THEN
	cbx_obsolete.Checked = TRUE
ELSE
	cbx_obsolete.Checked = FALSE
END IF
	
SELECTBLOB sketch_view 
INTO :ib_pic
FROM sketch_jpg
WHERE sketch_id = :ll_sid
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return
END IF
p_1.SetPicture(ib_pic)

Parent.title = sle_title.Text
ib_notsaved = FALSE
ib_newbmp = FALSE
end event

event pfc_addrow;call super::pfc_addrow;long ll_row
Int li_new_id

ll_row = this.GetRow()
li_new_id = f_get_next_value("sketch_id_seq")
this.SetItem(ll_row, "sketch_id", li_new_id)
this.SetItem(ll_row, "sketch_name", "New Sketch")

Return ll_row
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

type mle_desc from u_mle within w_sketch_management
integer x = 1723
integer y = 6
integer width = 1580
integer height = 134
integer taborder = 30
string facename = "Arial"
end type

type st_1 from statictext within w_sketch_management
integer x = 1463
integer y = 45
integer width = 256
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Description:"
boolean focusrectangle = false
end type

type sle_title from u_sle within w_sketch_management
integer x = 808
integer y = 35
integer width = 647
integer taborder = 20
end type

type st_2 from statictext within w_sketch_management
integer x = 688
integer y = 48
integer width = 117
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Title:"
boolean focusrectangle = false
end type

type cb_save from u_cb within w_sketch_management
string tag = "Save current sketch"
integer x = 1595
integer y = 1840
integer width = 351
integer height = 83
integer taborder = 70
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;wf_save()
end event

type cb_close from u_cb within w_sketch_management
string tag = "Exit this application"
integer x = 2670
integer y = 1840
integer width = 351
integer height = 83
integer taborder = 90
boolean bringtotop = true
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type p_1 from picture within w_sketch_management
integer x = 684
integer y = 150
integer width = 2926
integer height = 1667
boolean bringtotop = true
boolean originalsize = true
end type

type cb_open from u_cb within w_sketch_management
string tag = "Open an JPG file"
integer x = 1057
integer y = 1840
integer width = 351
integer height = 83
integer taborder = 60
string facename = "Arial"
string text = "&ImportJPG"
end type

event clicked;call super::clicked;Parent.Event ue_open()
end event

type cb_new from u_cb within w_sketch_management
string tag = "Create a new record"
integer x = 519
integer y = 1840
integer width = 351
integer height = 83
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "&New"
end type

event clicked;call super::clicked;dw_sketch_list.Event pfc_addrow()
end event

type cbx_obsolete from checkbox within w_sketch_management
integer x = 3321
integer y = 38
integer width = 282
integer height = 77
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Obsolete"
end type

type cb_print from u_cb within w_sketch_management
string tag = "Print current sketch"
integer x = 2132
integer y = 1840
integer width = 351
integer height = 83
integer taborder = 80
boolean bringtotop = true
string facename = "Arial"
string text = "&Print"
end type

event clicked;Long ll_id

ll_id = dw_sketch_list.GetItemNumber(dw_sketch_list.GetRow(), "sketch_id")
IF ll_id <= 0 THEN 
	MessageBox("Error", "Invalid sketch id!")
	Return 0
END IF

IF wf_set_sketch_file() > 0 THEN
	OpenWithParm(w_report_sketch_profiler, ll_id)
END IF
end event

