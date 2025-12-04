$PBExportHeader$w_coil_list_by_archived_bol.srw
forward
global type w_coil_list_by_archived_bol from w_sheet
end type
type dw_coil_list_by_bol from u_dw within w_coil_list_by_archived_bol
end type
type cb_close from u_cb within w_coil_list_by_archived_bol
end type
end forward

global type w_coil_list_by_archived_bol from w_sheet
int X=340
int Y=416
int Width=3668
int Height=1091
WindowType WindowType=response!
long BackColor=82042848
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event type integer ue_markdamage ( )
event type integer ue_sendedi861 ( )
event type integer ue_import ( )
dw_coil_list_by_bol dw_coil_list_by_bol
cb_close cb_close
end type
global w_coil_list_by_archived_bol w_coil_list_by_archived_bol

type variables
String is_select
String is_where
s_coil_info ids_coil
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_delete
Boolean ib_new
Boolean ib_modify
Long il_cur_coil
Boolean ib_readonly
Boolean ib_allcust
String is_bol
Long il_edi_file_id
Long il_customer_id
end variables

on w_coil_list_by_archived_bol.create
int iCurrent
call super::create
this.dw_coil_list_by_bol=create dw_coil_list_by_bol
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_list_by_bol
this.Control[iCurrent+2]=this.cb_close
end on

on w_coil_list_by_archived_bol.destroy
call super::destroy
destroy(this.dw_coil_list_by_bol)
destroy(this.cb_close)
end on

event open;call super::open;s_edi_file_id_and_bol lds_edi_file_id_and_bol

lds_edi_file_id_and_bol = Message.PowerObjectParm
date ld_received_time

is_bol = lds_edi_file_id_and_bol.bol 
il_edi_file_id = lds_edi_file_id_and_bol.edi_file_id
il_customer_id = lds_edi_file_id_and_bol.customer_id

IF il_customer_id =1153 THEN
	this.title = "Coils of ALCAN-KINGSTOM BOL#:" + is_bol
ELSEIF il_customer_id =1459 THEN
	this.title = "Coils of ALCAN-OSWEGO BOL#:" + is_bol
END IF

//this.title = "Coils available to import for ALCAN BOL#:" + is_bol

dw_coil_list_by_bol.SetTransObject(sqlca)
dw_coil_list_by_bol.Retrieve(is_bol,il_edi_file_id)

dw_coil_list_by_bol.SetFocus()


end event

type dw_coil_list_by_bol from u_dw within w_coil_list_by_archived_bol
int X=84
int Y=64
int Width=3489
int Height=643
int TabOrder=10
boolean BringToTop=true
string DataObject="d_coil_list_by_bol"
boolean HScrollBar=true
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(is_bol,il_edi_file_id)
end event

event clicked;call super::clicked;//Override pfc_clicked

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event doubleclicked;//parent.event ue_import()
end event

type cb_close from u_cb within w_coil_list_by_archived_bol
int X=3211
int Y=816
int TabOrder=20
boolean BringToTop=true
string Text="&Close"
end type

event clicked;close(parent)
end event

