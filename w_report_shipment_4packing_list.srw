$PBExportHeader$w_report_shipment_4packing_list.srw
forward
global type w_report_shipment_4packing_list from w_sheet
end type
type cb_print from commandbutton within w_report_shipment_4packing_list
end type
type cb_close from commandbutton within w_report_shipment_4packing_list
end type
type dw_report_shipment_4packing_list from datawindow within w_report_shipment_4packing_list
end type
end forward

global type w_report_shipment_4packing_list from w_sheet
integer width = 3983
integer height = 1027
string title = "EDI Files"
event type string ue_whoami ( )
cb_print cb_print
cb_close cb_close
dw_report_shipment_4packing_list dw_report_shipment_4packing_list
end type
global w_report_shipment_4packing_list w_report_shipment_4packing_list

forward prototypes
public function integer wf_get_edi_file_ids (n_tr_abc01 at_tran, long al_packing_list, ref long al_edi_file_id_856, ref long al_edi_file_id_desadv)
public function integer wf_get_edi_data (n_tr_abc01 at_tran, long al_edi_file_id, ref string as_edi_file_name, ref datetime adt_transaction_time, ref string as_fa_received_file_name, ref datetime adt_fa_received_time)
end prototypes

event type string ue_whoami();RETURN "w_report_shipment_4packing_list"
end event

public function integer wf_get_edi_file_ids (n_tr_abc01 at_tran, long al_packing_list, ref long al_edi_file_id_856, ref long al_edi_file_id_desadv);/*
Function:	wf_get_edi_file_ids
Returns:		integer
Arguments:	value			n_tr_abc01	at_tran
				value			long			al_packing_list
				reference	long			al_edi_file_id_856
				reference	long			al_edi_file_id_desadv
*/

Integer	li_rtn = 1

If Not at_tran.of_isconnected() Then
	connect using at_tran;	
End If

select	nvl(edi_file_id_856, -999), nvl(edi_file_id_desadv, -999)
into		:al_edi_file_id_856, :al_edi_file_id_desadv
from		shipment
where		packing_list = :al_packing_list
using		at_tran;

If at_tran.sqlcode <> 0 Then
	li_rtn = -1
End if

Return li_rtn
end function

public function integer wf_get_edi_data (n_tr_abc01 at_tran, long al_edi_file_id, ref string as_edi_file_name, ref datetime adt_transaction_time, ref string as_fa_received_file_name, ref datetime adt_fa_received_time);/*
Function:	wf_get_edi_data
Returns:		integer
Arguments:	value			n_tr_abc01	at_tran
				value			long			al_edi_file_id
				reference	string		as_edi_file_name
				reference	datetime		adt_transaction_time
				reference	string		as_fa_received_file_name
				reference	datetime		adt_fa_received_time
*/

Integer	li_rtn = 1
String	ls_fa_received_time, ls_year, ls_month, ls_day, ls_hour, ls_minute, ls_date, ls_time
DateTime	ldt_datetime

If Not at_tran.of_isconnected() Then
	connect using at_tran;	
End If

select	edi_file_name, transaction_time, fa_received_file_name, fa_received_time
into		:as_edi_file_name, :adt_transaction_time, :as_fa_received_file_name, :ls_fa_received_time
from		outbound_edi_transaction
where		edi_file_id = :al_edi_file_id
using		at_tran;

If at_tran.sqlcode <> 0 Then
	li_rtn = -1
Else
	//Parse ls_fa_received_time
	ls_year = "20" + Left(ls_fa_received_time, 2)
	ls_month = Mid(ls_fa_received_time, 3, 2)
	ls_day = Mid(ls_fa_received_time, 5, 2)
	ls_hour = Mid(ls_fa_received_time, 7, 2)
	ls_minute = Mid(ls_fa_received_time, 9, 2)
	
	//Build adt_fa_received_time as DateTime
	ls_date = ls_month + "/" + ls_day + "/" + ls_year
	ls_time = ls_hour + ":" + ls_minute + ":00"
	adt_fa_received_time = DateTime(Date(ls_date), Time(ls_time))
End if

Return li_rtn
end function

on w_report_shipment_4packing_list.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_report_shipment_4packing_list=create dw_report_shipment_4packing_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_report_shipment_4packing_list
end on

on w_report_shipment_4packing_list.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_report_shipment_4packing_list)
end on

event open;call super::open;Integer	li_rtn
Long		ll_packing_list
Long		ll_edi_file_id_856, ll_edi_file_id_desadv
Long		ll_inserted_row
String	ls_edi_file_name_856, ls_fa_received_file_name_856
String	ls_edi_file_name_desadv, ls_fa_received_file_name_desadv
DateTime	ldt_transaction_time_856, ldt_fa_received_time_856
DateTime	ldt_transaction_time_desadv, ldt_fa_received_time_desadv

ll_packing_list = Message.DoubleParm

li_rtn = wf_get_edi_file_ids(sqlca, ll_packing_list, ll_edi_file_id_856, ll_edi_file_id_desadv)

If li_rtn = 1 Then //OK in wf_get_edi_file_ids()
	If ll_edi_file_id_856 <> -999 Then
		//Get 856 data
		li_rtn = wf_get_edi_data(	sqlca,&
											ll_edi_file_id_856, ls_edi_file_name_856, ldt_transaction_time_856, &
											ls_fa_received_file_name_856, ldt_fa_received_time_856)
	Else
		SetNull(ls_edi_file_name_856)
		SetNull(ldt_transaction_time_856)
		SetNull(ls_fa_received_file_name_856)
		SetNull(ldt_fa_received_time_856)
	End If
	
	If li_rtn = 1 Then //OK in wf_get_edi_data() for 856
		If ll_edi_file_id_desadv <> -999 Then
			//Get desadv data
			li_rtn = wf_get_edi_data(	sqlca,&
												ll_edi_file_id_desadv, ls_edi_file_name_desadv, ldt_transaction_time_desadv, &
												ls_fa_received_file_name_desadv, ldt_fa_received_time_desadv)
		Else
			SetNull(ls_edi_file_name_desadv)
			SetNull(ldt_transaction_time_desadv)
			SetNull(ls_fa_received_file_name_desadv)
			SetNull(ldt_fa_received_time_desadv)
		End If
											
		If li_rtn = 1 Then //OK in wf_get_edi_data() for desadv
			ll_inserted_row = dw_report_shipment_4packing_list.InsertRow(0)
			
			If ll_inserted_row > 0 Then
				dw_report_shipment_4packing_list.Object.file_name_856[ll_inserted_row] = ls_edi_file_name_856
				dw_report_shipment_4packing_list.Object.file_dttm_856[ll_inserted_row] = ldt_transaction_time_856
				
				dw_report_shipment_4packing_list.Object.file_name_997[ll_inserted_row] = ls_fa_received_file_name_856
				dw_report_shipment_4packing_list.Object.file_dttm_997[ll_inserted_row] = ldt_fa_received_time_856
				
				dw_report_shipment_4packing_list.Object.desadv_file_name[ll_inserted_row] = ls_edi_file_name_desadv
				dw_report_shipment_4packing_list.Object.desadv_file_dttm[ll_inserted_row] = ldt_transaction_time_desadv
				
				dw_report_shipment_4packing_list.Object.packing_list_t.Text = "Packing List: " + String(ll_packing_list)
			End If
		End if
	End If
End If
end event

type cb_print from commandbutton within w_report_shipment_4packing_list
integer x = 1492
integer y = 819
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;dw_report_shipment_4packing_list.Print()
end event

type cb_close from commandbutton within w_report_shipment_4packing_list
integer x = 2224
integer y = 819
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type dw_report_shipment_4packing_list from datawindow within w_report_shipment_4packing_list
integer y = 77
integer width = 3920
integer height = 691
integer taborder = 10
string title = "none"
string dataobject = "d_report_shipment_4packing_list"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

