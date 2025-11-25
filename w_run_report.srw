$PBExportHeader$w_run_report.srw
forward
global type w_run_report from w_sheet
end type
type dw_arconic_mtd_report from datawindow within w_run_report
end type
type dw_qr_flaw_report from datawindow within w_run_report
end type
type dw_abco_backlog_report from datawindow within w_run_report
end type
type dw_qr_report from datawindow within w_run_report
end type
type dw_coils_weight_zeroed_out from datawindow within w_run_report
end type
type dw_report_inv_cust_coils_863 from datawindow within w_run_report
end type
type cb_coils_proc_manual_run from commandbutton within w_run_report
end type
type dw_coils_processed from datawindow within w_run_report
end type
type dw_auto_report_emails_error from datawindow within w_run_report
end type
type cb_novelis_manual_run from commandbutton within w_run_report
end type
type cb_start_stop_timer from commandbutton within w_run_report
end type
type dw_auto_report_emails from datawindow within w_run_report
end type
type dw_auto_report_customers from datawindow within w_run_report
end type
type dw_auto_report_schedule from datawindow within w_run_report
end type
type dw_report_auto_run_log from datawindow within w_run_report
end type
type st_timer_start_stop from statictext within w_run_report
end type
type dw_edi_alert from datawindow within w_run_report
end type
type cb_close from commandbutton within w_run_report
end type
type r_1 from rectangle within w_run_report
end type
end forward

global type w_run_report from w_sheet
integer x = 214
integer width = 6356
integer height = 1770
string title = "Auto Inventory Report"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
dw_arconic_mtd_report dw_arconic_mtd_report
dw_qr_flaw_report dw_qr_flaw_report
dw_abco_backlog_report dw_abco_backlog_report
dw_qr_report dw_qr_report
dw_coils_weight_zeroed_out dw_coils_weight_zeroed_out
dw_report_inv_cust_coils_863 dw_report_inv_cust_coils_863
cb_coils_proc_manual_run cb_coils_proc_manual_run
dw_coils_processed dw_coils_processed
dw_auto_report_emails_error dw_auto_report_emails_error
cb_novelis_manual_run cb_novelis_manual_run
cb_start_stop_timer cb_start_stop_timer
dw_auto_report_emails dw_auto_report_emails
dw_auto_report_customers dw_auto_report_customers
dw_auto_report_schedule dw_auto_report_schedule
dw_report_auto_run_log dw_report_auto_run_log
st_timer_start_stop st_timer_start_stop
dw_edi_alert dw_edi_alert
cb_close cb_close
r_1 r_1
end type
global w_run_report w_run_report

type variables
Long		il_timer_interval_seconds
String	is_email_folder, is_archive_folder

Long		il_customer_ids[] //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report







end variables

forward prototypes
public function datetime wf_convert_date_string_2dttm (string as_date_string)
public subroutine wf_send_smtp_email_2support (string as_body)
public function long wf_time_difference_minutes (datetime adt_start, datetime adt_end)
public function long wf_time_difference_seconds (datetime adt_start, datetime adt_end)
public function integer wf_retrieve_outbound_edi_transaction (long al_edi_file_id, ref long al_interchange_control_number, ref string as_fa_received_time, ref string as_fa_received_file_name, ref integer ai_fa_receive_status)
public function integer wf_insert_auto_run_log (string as_run_message)
public function integer wf_get_recipient_emails (long ll_customer_id, ref string as_emails[])
public subroutine wf_get_customer_ids (string as_customer_name, ref long al_customer_ids[])
public function integer wf_send_user_emails_4novelis (string as_email_addresses[], w_inventory_reports aw_inventory_reports, long al_customer_ids[], boolean ab_unmatched_coils)
public subroutine wf_get_email_addresses (string as_report_name, string as_customer_name, ref string as_email_addresses[])
public subroutine wf_get_email_addresses_error (string as_report_name, string as_customer_name, ref string as_email_addresses[])
public function integer wf_auto_combined_4novelis (string as_report_name, long al_customer_ids[], string as_email_addresses[], string as_customer_name)
public function integer wf_auto_report_4others (string as_report_name, long al_customer_ids[], string as_email_addresses[])
public function integer wf_coils_processed_report (string as_report_name, long al_customer_ids[], string as_email_addresses[])
public function string wf_get_customer_names (long al_customer_ids[])
public function integer wf_coil_inventory_report_863 (string as_email_addresses[])
public function integer wf_coils_weight_zeroed_out_report (string as_email_addresses[])
public function integer wf_qr_report (string as_email_addresses[])
public function integer wf_aleris_skid_count_report_m (string as_email_addresses[], long al_customer_ids[])
public function integer wf_aleris_skid_count_report_w (string as_email_addresses[], long al_customer_ids[])
public function integer wf_onhold_status_updates_report (string as_email_addresses[])
public function integer wf_onhold_status_updates_report_monthly (string as_email_addresses[])
public function integer wf_inv_coils_skids_scrap_skids (string as_email_addresses[])
public function integer wf_remove_coil_duplicates (ref datastore ads)
public subroutine wf_specs (ref datastore ads)
public function string wf_job_spec (long al_job)
public subroutine wf_specs_scrap_skids (ref datastore ads)
public function integer wf_remove_skid_duplicates (ref datastore ads)
public function integer wf_remove_scrap_skid_duplicates (ref datastore ads)
public function integer wf_aluminum_content_blank_report (string as_email_addresses[])
public function integer wf_fix_first_job_in_jobset ()
public function integer wf_recapped_jobs_without_870_report (string as_email_addresses[])
public function integer wf_abco_backlog_report (string as_email_addresses[])
public subroutine wf_excel_open_xls_saveas_xlsx_backlog (string as_file_in_xls, string as_file_out_xlsx)
public subroutine wf_exporttoexcel_backlog (datawindow adw_dw, long al_rows, ref string as_file_out)
public function integer wf_qr_flaw_report (string as_email_addresses[], string as_customer_name)
public subroutine wf_exporttoexcel_qr_flaw (datawindow adw_dw, long al_rows, ref string as_file_out, string as_customer_name, string as_select_date)
protected function integer wf_const_bg_coil_report (string as_email_addresses[], long al_customer_ids[])
public function integer wf_arconic_mtd_report (string as_email_addresses[], long al_customer_ids[])
public function integer wf_arconic_mtd_report_dw (string as_email_addresses[], long al_customer_ids[])
public subroutine wf_update_processed_wt_4arconic (ref datastore ads)
public subroutine wf_insert_customer_wt_4arconic (ref datastore ads)
end prototypes

event type string ue_whoami();Return "w_run_report"
end event

public function datetime wf_convert_date_string_2dttm (string as_date_string);/*
Function:	wf_convert_date_string_2dttm
Returns:		DateTime
Arguments:	value	string	as_date_string
*/

DateTime	ldt_rtn
Long		ll_length
String	ls_year, ls_month, ls_day, ls_hour, ls_minute
String	ls_date, ls_time

ll_length = Len(as_date_string)

If ll_length = 10 Then
	//Example:	1609161643
	ls_year = "20" + Left(as_date_string, 2)
	ls_month = Mid(as_date_string, 3, 2)
	ls_day = Mid(as_date_string, 5, 2)
	ls_hour = Mid(as_date_string, 7, 2)
	ls_minute = Right(as_date_string, 2)
Else //ll_length = 12
	//Example:	201608171812
	ls_year = Left(as_date_string, 4)
	ls_month = Mid(as_date_string, 5, 2)
	ls_day = Mid(as_date_string, 7, 2)
	ls_hour = Mid(as_date_string, 9, 2)
	ls_minute = Right(as_date_string, 2)
End If

ls_date = ls_month + "/" + ls_day + "/" + ls_year
ls_time = ls_hour + ":" + ls_minute

ldt_rtn = DateTime(Date(ls_date), Time(ls_time))

Return ldt_rtn
end function

public subroutine wf_send_smtp_email_2support (string as_body);//Alex Gerlants. 08/03/2016. Begin
/*
Function:	wf_send_smtp_email_2support
Returns:		none
Arguments:	value	string	as_body
*/

//UInt 		lui_port
//Boolean	lb_Return
//
//lui_port = Long(ii_port)
//
//// *** Set email properties *********************
//in_smtp.of_ResetAll()
//in_smtp.of_SetPort(lui_port)
//in_smtp.of_SetServer(is_server)
//in_smtp.of_SetLogFile(True, is_logfile)
//in_smtp.of_SetDebugViewer(ib_debugviewer)
//in_smtp.of_SetSubject(is_subject)
//in_smtp.of_SetBody(as_body, False)
//in_smtp.of_SetFrom(is_from_email, is_from_name)
//in_smtp.of_AddAddress(is_send_email, is_send_name)
//
////// *** set Userid/Password if required **********
////If of_getreg("Auth", "N") = "Y" Then
////	ls_uid = of_getreg("Userid", "")
////	ls_pwd = of_getreg("Password", "")
////	in_smtp.of_SetLogin(ls_uid, ls_pwd)
////End If
////
////// *** add any attachments **********************
////li_max = lb_attachments.TotalItems()
////For li_idx = 1 To li_max
////	ls_filename = lb_attachments.Text(li_idx)
////	in_smtp.of_AddAttachment(ls_filename)
////Next
//
//// *** send the message *************************
//lb_Return = in_smtp.of_SendMail()
//
////If lb_Return Then
////	MessageBox("SendMail", "Mail successfully sent!")
////Else
////	MessageBox("SendMail Error", in_smtp.of_GetLastError())
////End If

//Alex Gerlants. 08/03/2016. End
end subroutine

public function long wf_time_difference_minutes (datetime adt_start, datetime adt_end);/*
Function:	wf_time_difference_minutes
Returns:		long	<== Minutes between adt_end and adt_start
Arguments:	value		DataTime		adt_start
				value		DataTime		adt_end
*/

Long						ll_minutes_after
pfc_n_cst_datetime	lpfc_n_cst_datetime

ll_minutes_after = lpfc_n_cst_datetime.of_SecondsAfter(adt_start, adt_end) / 60

Return ll_minutes_after
end function

public function long wf_time_difference_seconds (datetime adt_start, datetime adt_end);/*
Function:	wf_time_difference_seconds
Returns:		long	<== Minutes between adt_end and adt_start
Arguments:	value		DataTime		adt_start
				value		DataTime		adt_end
*/

Long						ll_seconds_after
pfc_n_cst_datetime	lpfc_n_cst_datetime

ll_seconds_after = lpfc_n_cst_datetime.of_SecondsAfter(adt_start, adt_end)

Return ll_seconds_after
end function

public function integer wf_retrieve_outbound_edi_transaction (long al_edi_file_id, ref long al_interchange_control_number, ref string as_fa_received_time, ref string as_fa_received_file_name, ref integer ai_fa_receive_status);/*
Function:	wf_retrieve_outbound_edi_transaction
Returns:		integer	-1 if DB error
							 1 if OK
Arguments:	value			long		al_edi_file_id
				reference	long		al_interchange_control_number
				reference	string	as_fa_received_time
				reference	string	as_fa_received_file_name
				reference	integer	ai_fa_receive_status
*/

Integer	li_rtn = 1
//String	ls_fa_received_time, ls_fa_received_file_name
//
//select	ltrim(rtrim(nvl(fa_received_time, ''))), ltrim(rtrim(nvl(fa_received_file_name, ''))), interchange_control_number, fa_receive_status
//into		:as_fa_received_time, :as_fa_received_file_name, :al_interchange_control_number, :ai_fa_receive_status
//from		outbound_edi_transaction
//where		edi_file_id = :al_edi_file_id
//using		sqlca;
//
//If sqlca.sqlcode = 0 Then //OK
//	If sqlca.sqlnrows > 0 Then  //Table outbound_edi_transaction has a row for al_edi_file_id
//		//If ai_fa_receive_status = 1, then we have received 997.
//	Else //Table outbound_edi_transaction doesn't have a row for al_edi_file_id
//		If IsNull(as_fa_received_time) Then as_fa_received_time = ""
//		If IsNull(as_fa_received_file_name) Then as_fa_received_file_name = ""
//		If IsNull(ai_fa_receive_status) Then ai_fa_receive_status = 0
//	End If
//Else //DB error
//	If IsNull(as_fa_received_time) Then as_fa_received_time = ""
//	If IsNull(as_fa_received_file_name) Then as_fa_received_file_name = ""
//	If IsNull(ai_fa_receive_status) Then ai_fa_receive_status = 0
//End If

Return li_rtn
end function

public function integer wf_insert_auto_run_log (string as_run_message);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_insert_auto_run_log
Returns:		integer
Argumants:	value	string	as_run_message
*/

Integer	li_rtn = 1
Long		ll_inserted_row
DateTime	ldt_current_date_time

ldt_current_date_time = DateTime(Today(), Now())
ll_inserted_row = dw_report_auto_run_log.InsertRow(0)

If ll_inserted_row > 0 Then
	dw_report_auto_run_log.Object.run_date[ll_inserted_row] = ldt_current_date_time
	dw_report_auto_run_log.Object.run_message[ll_inserted_row] = as_run_message
	
	li_rtn = dw_report_auto_run_log.Update()
	
	IF li_rtn = 1 Then //OK
		commit using sqlca;
	Else //li_rtn = -1
		rollback using sqlca;
	End If
Else
	li_rtn = -1
End If

Return li_rtn
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end function

public function integer wf_get_recipient_emails (long ll_customer_id, ref string as_emails[]);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_get_recipient_emails
Returns:		integer	 1 if ok
							-1 if DB error
							 0 if no email rows retrieve
Arguments:	value			long	ll_customer_id		
				reference	string	as_emails[] <== emails from lds_report_emails
*/

Integer		li_rtn
Long			ll_rows, ll_row
String		ls_email_address
DataStore	lds_report_emails

lds_report_emails = Create DataStore
lds_report_emails.dataObject = "d_report_emails"
lds_report_emails.SetTransObject(sqlca)

ll_rows = lds_report_emails.Retrieve(ll_customer_id)

Choose Case ll_rows
	Case Is > 0
		li_rtn = 1
	Case 0
		li_rtn = 0
	Case Else
		li_rtn = -1
End Choose

If li_rtn = 1 Then //ll_rows > 0
	For ll_row = 1 To ll_rows
		ls_email_address = lds_report_emails.Object.email_address[ll_row]
		as_emails[UpperBound(as_emails[]) + 1] = ls_email_address
	Next
End If

Return li_rtn
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end function

public subroutine wf_get_customer_ids (string as_customer_name, ref long al_customer_ids[]);/*
Function:	wf_get_customer_ids
Returns:		none
Arguments:	value			string	as_customer_name
				reference	long		al_customer_ids[]
*/

Long	ll_rows_customers, ll_row_customers, ll_customer_id

ll_rows_customers = dw_auto_report_customers.Retrieve(as_customer_name)

//Collect customer_id's for as_customer_name into ll_customer_ids[]
For ll_row_customers = 1 To ll_rows_customers
	ll_customer_id = dw_auto_report_customers.Object.customer_id[ll_row_customers]
	al_customer_ids[UpperBound(al_customer_ids[]) + 1] = ll_customer_id
Next
end subroutine

public function integer wf_send_user_emails_4novelis (string as_email_addresses[], w_inventory_reports aw_inventory_reports, long al_customer_ids[], boolean ab_unmatched_coils);/*
Function:	wf_send_user_emails_4novelis
Returns:		integer
Arguments:	value	string					as_email_addresses[]
				value	w_inventory_reports	aw_inventory_reports
				value	long						al_customer_ids[]
				value	boolean					ab_unmatched_coils
*/

Integer					li_rtn = 1
Boolean					lb_archive_files
Long						ll_i
String					ls_email_address, ls_run_message
//w_inventory_reports	lw_inventory_reports

For ll_i = 1 To UpperBound(as_email_addresses[])
	ls_email_address = as_email_addresses[ll_i]
	
	If ll_i = UpperBound(as_email_addresses[]) Then
		lb_archive_files = True
	End If

	li_rtn = aw_inventory_reports.wf_auto_email_4novelis(ls_email_address, lb_archive_files, ab_unmatched_coils)
	
	If li_rtn = 1 Then //OK
		ls_run_message = "Novelis report email sent successfully to " + ls_email_address
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	Else //li_rtn = -1. Error
		ls_run_message = "Novelis report email to " + ls_email_address + " failed. Contact abis support."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	End If
Next

Return li_rtn
end function

public subroutine wf_get_email_addresses (string as_report_name, string as_customer_name, ref string as_email_addresses[]);/*
Function:	wf_get_email_addresses
Returns:		none
Arguments:	value			string	as_report_name
				value			string	as_customer_name
				reference	string	as_email_addresses[]
*/

Long		ll_rows_emails, ll_row_emails
String	ls_email_address

ll_rows_emails = dw_auto_report_emails.Retrieve(as_report_name, as_customer_name)

//Collect email_addresses for ls_customer_name into ls_email_addresses[]
For ll_row_emails = 1 To ll_rows_emails
	ls_email_address = dw_auto_report_emails.Object.email_address[ll_row_emails]
	as_email_addresses[UpperBound(as_email_addresses[]) + 1] = ls_email_address
Next
end subroutine

public subroutine wf_get_email_addresses_error (string as_report_name, string as_customer_name, ref string as_email_addresses[]);/*
Function:	wf_get_email_addresses_error
Returns:		none
Arguments:	value			string	as_report_name
				value			string	as_customer_name
				reference	string	as_email_addresses[]
*/

Long		ll_rows_emails, ll_row_emails
String	ls_email_address

ll_rows_emails = dw_auto_report_emails_error.Retrieve(as_report_name, as_customer_name)

//dw_auto_report_emails_error.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

//Collect email_addresses for ls_customer_name into ls_email_addresses[]
For ll_row_emails = 1 To ll_rows_emails
	ls_email_address = dw_auto_report_emails_error.Object.email_address[ll_row_emails]
	as_email_addresses[UpperBound(as_email_addresses[]) + 1] = ls_email_address
Next
end subroutine

public function integer wf_auto_combined_4novelis (string as_report_name, long al_customer_ids[], string as_email_addresses[], string as_customer_name);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_auto_combined_4novelis
Returns:		integer
Arguments:	value	string	as_report_name
				value	long		al_customer_ids[]
				value	string	as_email_addresses[]
				value	string	as_customer_name
*/

Integer					li_rtn = 1
Long						ll_inserted_row, ll_i
DateTime					ldt_current_date_time
String					ls_run_message, ls_email_address
String					ls_email_addresses[]
Boolean					lb_archive_files = False, lb_unmatched_coils = False
w_inventory_reports	lw_inventory_reports

ls_run_message = "Novelis report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
Open(lw_inventory_reports)

This.SetFocus() //Keep w_inventory_reports on the background

If IsValid(lw_inventory_reports) Then
	li_rtn = lw_inventory_reports.wf_auto_combined_4novelis(al_customer_ids[])
	
	If li_rtn = 1 Then //OK
		ls_run_message = "Novelis report created. Starting Novelis report email ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
		
		wf_send_user_emails_4novelis(as_email_addresses[], lw_inventory_reports, al_customer_ids[], lb_unmatched_coils)
	Else
		If li_rtn = -2 Then //Unmatched coils
			lb_unmatched_coils = True
			ls_run_message = "Novelis report created. Mismatched coils."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
			
			wf_get_email_addresses_error(as_report_name, as_customer_name, ls_email_addresses[])
			
			wf_send_user_emails_4novelis(ls_email_addresses[], lw_inventory_reports, al_customer_ids[], lb_unmatched_coils)
		Else
			ls_run_message = "Novelis report failed. Contact abis support."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	End If
End If

If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
Return li_rtn
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Endd
end function

public function integer wf_auto_report_4others (string as_report_name, long al_customer_ids[], string as_email_addresses[]);//Alex_Other customers_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_auto_report_4others
Returns:		integer
Arguments:	value	long		al_customer_ids[]
				value	string	as_report_name
				value	string	as_email_addresses[]
*/

Integer					li_rtn = 1, li_rtn_pdf, li_rtn_xls
Long						ll_inserted_row, ll_i
DateTime					ldt_current_date_time
String					ls_run_message, ls_email_address, ls_customer_name, ls_email_addresses[]
String					ls_report_name, ls_customer_name_list
Boolean					lb_last_iteration = False, lb_first_iteration, lb_unmatched_coils
w_inventory_reports	lw_inventory_reports
nv_test					lnv_test

Boolean					lw_inventory_reports_valid

ls_run_message = "Other customers report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lnv_test) Then Destroy lnv_test
lnv_test = Create nv_test

lb_unmatched_coils = lnv_test.of_unmatched_coils_auto(al_customer_ids[]) = -1

If IsValid(lnv_test) Then Destroy lnv_test

If lb_unmatched_coils Then //Unmatched coils found
	select	ltrim(rtrim(customer_name))
	into		:ls_customer_name
	from		dbo.auto_report_customers
	where		customer_id = :al_customer_ids[1]
	using		sqlca;
	
	wf_get_email_addresses_error(as_report_name, ls_customer_name, ls_email_addresses[])
	as_email_addresses[] = ls_email_addresses[]
End If

If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
Open(lw_inventory_reports)

This.SetFocus() //Keep w_inventory_reports on the background

If IsValid(lw_inventory_reports) Then
	li_rtn_pdf = lw_inventory_reports.wf_auto_pdf_4others(al_customer_ids[])
	
	If li_rtn_pdf = 1 Then //OK
		ls_customer_name_list = wf_get_customer_names(al_customer_ids[])
	
		If lb_unmatched_coils Then
			ls_run_message = "PDF report created for " + ls_customer_name_list + ". Mismatched coil status found. Starting XLS report for " + ls_customer_name_list + "..."
		Else
			ls_run_message = "PDF report created for " + ls_customer_name_list + ". Starting XLS report for " + ls_customer_name_list + "..."
		End If
		
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	Else
		ls_run_message = "PDF report failed for " + ls_customer_name_list + ". Starting XLS report for " + ls_customer_name_list + "..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	End If

	li_rtn_xls = lw_inventory_reports.wf_auto_xls_4others(al_customer_ids[])
	
	If li_rtn_xls = 1 Then //OK
		If lb_unmatched_coils Then
			ls_run_message = "XLS report created for " + ls_customer_name_list + ". Mismatched coil status found. Starting report email for " + ls_customer_name_list + "..."
		Else
			ls_run_message = "XLS report created for " + ls_customer_name_list + ". Starting report email for " + ls_customer_name_list + "..."
		End If
		
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	Else
		ls_run_message = "XLS report failed for " + ls_customer_name_list + ". Starting XLS report for " + ls_customer_name_list + "..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	End If
	
	If li_rtn_pdf = 1 Or li_rtn_xls = 1 Then //At least 1 report is OK
		For ll_i = 1 To UpperBound(as_email_addresses[])
			ls_email_address = as_email_addresses[ll_i]
			
			If ll_i = 1 Then
				lb_first_iteration = True
			Else
				lb_first_iteration = False
			End If
			
			If ll_i >= UpperBound(as_email_addresses[]) Then
				lb_last_iteration = True
			Else //ll_i < UpperBound(as_email_addresses[])
				lb_last_iteration = False
			End If
	
			li_rtn = lw_inventory_reports.wf_auto_email_4others(	al_customer_ids[], &
																					ls_email_address, &
																					lb_first_iteration, &
																					lb_last_iteration &
																				)
			
			Choose Case li_rtn
				Case 1 //OK
					ls_run_message = "Report email for " + ls_customer_name_list + " emailed successfully to " + ls_email_address
					li_rtn = wf_insert_auto_run_log(ls_run_message)
				Case -2 //No files created. Nothing to email
					ls_run_message = "No report files for other customers created. Nothing to email to " + ls_email_address + " Contact abis support."
					li_rtn = wf_insert_auto_run_log(ls_run_message)
				Case Else //Error
					ls_run_message = "Report email for " + ls_customer_name_list + " to " + ls_email_address + " failed. Contact abis support."
					li_rtn = wf_insert_auto_run_log(ls_run_message)
			End Choose
		Next
	Else //Both, PDF and XLS failed
		ls_run_message = "Other customers PDF and XLS reports failed" + ls_email_address
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	End If
End If

//TEST ONLY Begin
//lw_inventory_reports_valid = IsValid(lw_inventory_reports)
//li_rtn = wf_insert_auto_run_log("lw_inventory_reports_valid = " + String(lw_inventory_reports_valid))
//TEST ONLY End

If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)

Return li_rtn
//Alex_Other customers_Auto_Combined_Report. 03/02/2018. Endd
end function

public function integer wf_coils_processed_report (string as_report_name, long al_customer_ids[], string as_email_addresses[]);//wf_coils_processed_report(ls_report_name, ll_customer_ids[], ls_email_addresses[])
/*
Function:	wf_coils_processed_report
Returns:		integer
Arguments:	value	string	as_report_name
				value	long		al_customer_ids[]
				value	string	as_email_addresses[]
*/

//RelativeDate(1990-01-31,  - 10)

Integer					li_rtn = 1
Boolean					lb_rtn
Date						ld_today, ld_yesterday
DateTime					ldt_from, ldt_to
String					ls_today, ls_yesterday, ls_time_from, ls_time_to, ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_i
w_inventory_reports	lw_inventory_reports
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "Coils Processed Report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

ld_today = Date(String(Today(), "mm/dd/yyyy"))
ld_yesterday = Date(String(RelativeDate(today(), - 1), "mm/dd/yyyy"))

lt_time_from = Time("04:01:00")
lt_time_to = Time("03:59:59")

ldt_from = DateTime(ld_yesterday, lt_time_from)
ldt_to = DateTime(ld_today, lt_time_to)

ll_rows = dw_coils_processed.Retrieve(ldt_from, ldt_to)

If ll_rows < 0 Then
	ls_run_message = "DB error in function wf_coils_processed_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Coils_Processed_Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"
li_rtn = dw_coils_processed.SaveAs(ls_file, Excel!, True) //"True" is to include headings

If li_rtn = 1 Then
	
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_file_name_2email[1] = ls_file
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached Coils Processed Report for date period from " + String(ldt_from) + " to " + String(ldt_to)
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_coils_produced(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

Return li_rtn
end function

public function string wf_get_customer_names (long al_customer_ids[]);/*
Function:	wf_get_customer_names
Returns:		string	<== List of customer names
Arguments:	value	long	al_customer_ids[]
*/

Long	ll_i, ll_customer_id
String	ls_customer_name, ls_customer_name_list

For ll_i = 1 To UpperBound(al_customer_ids[])
	ll_customer_id = al_customer_ids[ll_i]
	
	select	customer_short_name
	into		:ls_customer_name
	from		customer
	where		customer_id = :ll_customer_id
	using		sqlca;
	
	If IsNull(ls_customer_name) Then ls_customer_name = ""
	
	ls_customer_name_list = ls_customer_name_list + ls_customer_name + ", "
Next

//Remove the last comma
ls_customer_name_list = Left(ls_customer_name_list, Len(ls_customer_name_list) - 2)

Return ls_customer_name_list
end function

public function integer wf_coil_inventory_report_863 (string as_email_addresses[]);//Alex Gerlants. 11/20/2018. Begin
/*
Function:	wf_coil_inventory_report_863
Returns:		integer
Arguments:	value	string	as_email_addresses[]
*/

//RelativeDate(1990-01-31,  - 10)

Integer					li_rtn = 1
Boolean					lb_rtn
String					ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_i
w_inventory_reports	lw_inventory_reports

 String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "`Coil Inventory 863 Report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

dw_report_inv_cust_coils_863.SetTransObject(sqlca)
ll_rows = dw_report_inv_cust_coils_863.Retrieve()

If ll_rows < 0 Then
	ls_run_message = "DB error in function wf_coil_inventory_report_863. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Coil_Inventory_863_Report" + ".xls"
li_rtn = dw_report_inv_cust_coils_863.SaveAs(ls_file, Excel!, True) //"True" is to include headings

If li_rtn = 1 Then
	
	f_excel_open_xls_saveas_xlsx_cust(ls_file, ls_file_xlsx, il_customer_ids[], sqlca) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_file_name_2email[1] = ls_file
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached`Coil Inventory 863 Report"
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_coil_863(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

Return li_rtn
//Alex Gerlants. 11/20/2018. End
end function

public function integer wf_coils_weight_zeroed_out_report (string as_email_addresses[]);//Alex Gerlants. coils_weight_zeroed_out. Begin
/*
Function:	wf_coils_weight_zeroed_out_report
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]							
*/

Integer					li_rtn = 1
Boolean					lb_rtn
Transaction				ltr
DataStore				lds_abis_ini
Date						ld_date_from, ld_date_to
String					ls_key, ls_date_from, ls_date_to, ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "Coils Weight Zeroed Out report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

lds_abis_ini = Create DataStore
lds_abis_ini.DataObject = "d_abis_ini"
lds_abis_ini.SetTransObject(sqlca)

ll_rows = lds_abis_ini.Retrieve("coils_weight_zeroed_out_report")

If ll_rows > 0 Then
	For ll_row = 1 To ll_rows
		ls_key = lds_abis_ini.Object.key[ll_row]
		
		If Lower(ls_key) = "date_from" Then
			ls_date_from = lds_abis_ini.Object.value[ll_row]
		ElseIf Lower(ls_key) = "date_to" Then
			ls_date_to = lds_abis_ini.Object.value[ll_row]
		Else
			ls_date_from = "01/01/2016"
			ls_date_to = "12/31/2026"
		End If
	Next
Else
	ls_date_from = "01/01/2016"
	ls_date_to = "12/31/2026"
End If

If IsDate(ls_date_from) Then
	ld_date_from = Date(ls_date_from)
Else
	ld_date_from = Date("01/01/2016")
End If

If IsDate(ls_date_to) Then
	ld_date_to = Date(ls_date_to)
Else
	ld_date_to = Date("12/31/2026")
End If

ltr = create transaction
ltr.dbms = ProfileString(gs_ini_file,"Database","DBMS","")
ltr.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
ltr.LogID = gs_LogID
ltr.LogPass = gs_LogPass

connect using ltr;

If ltr.sqlcode <> 0 Then 
	ls_run_message = "Database error in wf_coils_weight_zeroed_out_report for w_run_report while trying to connect to database. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
   Return -1
End If

//Connection successful. Run stored procedure p_coils_weight_zeroed_out.
//It will populate table coils_weight_zeroed_out.
//dw_coils_weight_zeroed_out will retrieve all rows from this table.
declare p_proc procedure for p_coils_weight_zeroed_out (:ld_date_from, :ld_date_to) using ltr;

execute p_proc;

if ltr.sqldbCode <> 0 then 
	ls_run_message = "Stored Procedure p_coils_weight_zeroed_out failed in wf_coils_weight_zeroed_out_report for w_run_report."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
	Return -1
end if

fetch p_proc into :li_rtn; 

close p_proc;

If li_rtn = 1 Then
	dw_coils_weight_zeroed_out.SetTransObject(sqlca)
	ll_rows = dw_coils_weight_zeroed_out.Retrieve()
	
	//---
	
	If ll_rows < 0 Then
		ls_run_message = "Retrieve DB error in function wf_coils_weight_zeroed_out_report for w_run_report. Cannot run ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
		Return -1
	End If
	
	//Alex Gerlants. 09/28/2020. Begin
	If  ll_rows > 1 Then
		ls_run_message = "Starting to fix first job in a jobset..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	
		li_rtn = wf_fix_first_job_in_jobset()
	End If
	//Alex Gerlants. 09/28/2020. End
	
	//ll_rows >= 0 at this point...Good
	If Right(is_email_folder, 1) <> "\" Then
		is_email_folder = is_email_folder + "\"
	End If
	
	ls_file = is_email_folder + "Coils Weight Zeroed Out Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

	//dw_coils_weight_zeroed_out.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
	
	li_rtn = dw_coils_weight_zeroed_out.SaveAs(ls_file, Excel!, True) //"True" is to include headings
	
	If li_rtn = 1 Then
		f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
		ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

		ls_run_message = "Coils Weight Zeroed Out report saved in " + ls_file + ". Starting QR report email ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	
		If ll_rows > 0 Then //Alex Gerlants. 11/24/2020. Send only if there are rows in the report
			ls_file_name_2email[1] = ls_file
			If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
			Open(lw_inventory_reports)
			
			ls_body = "Please find attached Coils Weight Zeroed Out Report for date period from " + String(ld_date_from) + " to " + String(ld_date_to)
			
			For ll_i = 1 To UpperBound(as_email_addresses[])
				ls_email_address = as_email_addresses[ll_i]
				
				lb_rtn = lw_inventory_reports.wf_send_smtp_email_coils_weight_zeroed(ls_body, ls_file_name_2email[], ls_email_address)
				
				If lb_rtn Then
					ls_run_message = ls_file + " successfully emailed to " + ls_email_address
					li_rtn = wf_insert_auto_run_log(ls_run_message)
				Else
					ls_run_message = ls_file + " email to " + ls_email_address + " failed."
					li_rtn = wf_insert_auto_run_log(ls_run_message)
				End If
			Next
		
			lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
		End If //Alex Gerlants. 11/24/2020
		
		If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	End If
	
	//---
	
End If




Return li_rtn
//Alex Gerlants. coils_weight_zeroed_out. End
end function

public function integer wf_qr_report (string as_email_addresses[]);//Alex Gerlants. QR_Report. Begin
/*
Function:	wf_qr_report
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]							
*/

Integer					li_rtn = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
Date						ld_date_from, ld_date_to
String					ls_today, ls_month, ls_day, ls_year, ls_month_2select, ls_year_2select
String					ls_day_from = "01", ls_day_to, ls_add_2sql
String					ls_days_leap[] = {"31","29","31","30","31","30","31","31","30","31","30","31"}
String					ls_days_not_leap[] = {"31","28","31","30","31","30","31","31","30","31","30","31"}
String					ls_key, ls_date_from, ls_date_to, ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
String					ls_sql, ls_sql_new
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
DataStore				lds_qr_report
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "QR report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lds_qr_report) Then Destroy lds_qr_report
lds_qr_report = Create DataStore
lds_qr_report.DataObject = "d_report_qr"
lds_qr_report.SetTransObject(sqlca)

//This report has to run on the first of every month.
//The data are from the first day of the previous month to the last day of the previous month.

ls_today = String(Today(), "mm/dd/yyyy")

//ls_today = "03/01/2018" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ls_month = Left(ls_today, 2)
ls_day = Mid(ls_today, 4, 2)
ls_year = Right(ls_today, 4)

If Mod(Integer(ls_year), 4) = 0 Then
	lb_leap_year_2select = True
Else
	lb_leap_year_2select = False
End If

If ls_month = "01" Then
	ls_month_2select = "12" //December of previous year
	ls_year_2select = String(Integer(ls_year) - 1, "00") //Previous year
Else
	ls_month_2select = String(Integer(ls_month) - 1, "00") //Previous month of current year
	ls_year_2select = ls_year //Current year
End If

If lb_leap_year_2select Then
	ls_day_to = ls_days_leap[Integer(ls_month_2select)]
Else
	ls_day_to = ls_days_not_leap[Integer(ls_month_2select)]
End If

ls_date_from = ls_month_2select + "/" + ls_day_from + "/" + ls_year_2select
ls_date_to = ls_month_2select + "/" + ls_day_to + "/" + ls_year_2select

ls_add_2sql = " where coil.date_received between " + &
						"to_date('" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss')" + &
						" and to_date('" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss')" + &
						" order by coil.coil_abc_num, coil.coil_org_num, coil_quality_flaw_mapping.starting_position, coil_quality_flaw_mapping.ending_position"

ls_sql = lds_qr_report.GetSqlSelect()

If ls_sql <> "" Then //OK
	ls_sql_new = ls_sql + ls_add_2sql
	li_rtn = lds_qr_report.SetSqlSelect(ls_sql_new)
	
	If IsNull(li_rtn) Then li_rtn = -1
		
	If li_rtn = -1 Then
		ls_run_message = "Error mofifying SQL in wf_qr_report for w_run_report (lds_qr_report.SetSqlSelect(ls_sql_new)). Cannot run ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
		Return -1
	End If
Else
	ls_run_message = "Error mofifying SQL in wf_qr_report for w_run_report (lds_qr_report.GetSqlSelect()). Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

ll_rows = lds_qr_report.Retrieve()

If ll_rows < 0 Then
	ls_run_message = "Retrieve DB error in function wf_qr_report for w_run_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "QR Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_qr_report.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn = lds_qr_report.SaveAs(ls_file, Excel!, True) //"True" is to include headings

If li_rtn = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
		
	ls_run_message = "QR report saved in " + ls_file + ". Starting QR report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
		
	ls_file_name_2email[1] = ls_file
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached QR Report for date period from " + ls_date_from + " to " + ls_date_to
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_qr_report(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

If IsValid(lds_qr_report) Then Destroy lds_qr_report

Return li_rtn
//Alex Gerlants. QR_Report. End
end function

public function integer wf_aleris_skid_count_report_m (string as_email_addresses[], long al_customer_ids[]);//Alex Gerlants. Aleris_Skid_Count_Shipment_Report. 05/10/2019. Begin
/*
Function:	wf_aleris_skid_count_report_m
				This report has to run on Monday.
				The data are from the previous Monday to Sunday (7 days)
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]	
				value	long		al_customer_ids[]
*/

Integer					li_rtn = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
String					ls_customer_id, ls_customer_ids
String					ls_sql, ls_sql_new
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
String					ls_date_from, ls_date_to, ls_run_message, ls_add_2sql
Long						ll_rows, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
DataStore				lds_skid_count_report
str_all_data_types	lstr_all_data_types
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "Aleris Skid Count Shipment report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If UpperBound(al_customer_ids[]) > 0 Then
	For li_i = 1 To UpperBound(al_customer_ids[])
		ls_customer_id = String(al_customer_ids[li_i])
		ls_customer_ids = ls_customer_ids + ls_customer_id + ", "
	Next
	
	//Remove the last comma
	ls_customer_ids = Left(ls_customer_ids, Len(ls_customer_ids) - 2)
Else
	Return li_rtn //Nothing to do here
End If

If IsValid(lds_skid_count_report) Then Destroy lds_skid_count_report
lds_skid_count_report = Create DataStore
lds_skid_count_report.DataObject = "d_report_skid_count_shipment_all_detail"
lds_skid_count_report.SetTransObject(sqlca)

//Get first and last day of the previous month
lstr_all_data_types = f_get_last_month_begin_end_dates()
ls_date_from = lstr_all_data_types.string_var[1]
ls_date_to = lstr_all_data_types.string_var[2]

ls_add_2sql = " where shipment.customer_id in (" + ls_customer_ids + ") and shipment.shipment_actualed_date_time " + &
						"between to_date('" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss')" + &
						" and to_date('" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss')" + &
						" order by shipment.packing_list, shipment.bill_of_lading, order_item.enduser_part_num, sheet_skid.sheet_skid_num"

ls_sql = lds_skid_count_report.GetSqlSelect()

If ls_sql <> "" Then //OK
	ls_sql_new = ls_sql + ls_add_2sql
	li_rtn = lds_skid_count_report.SetSqlSelect(ls_sql_new)
	
	If IsNull(li_rtn) Then li_rtn = -1
		
	If li_rtn = -1 Then
		ls_run_message = "Error mofifying SQL in wf_aleris_skid_count_report_m for w_run_report (lds_skid_count_report.SetSqlSelect(ls_sql_new)). Cannot run ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
		Return -1
	End If
Else
	ls_run_message = "Error mofifying SQL in wf_aleris_skid_count_report_m for w_run_report (lds_skid_count_report.GetSqlSelect()). Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

ll_rows = lds_skid_count_report.Retrieve()

If ll_rows < 0 Then
	ls_run_message = "Retrieve DB error in function wf_aleris_skid_count_report_m for w_run_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Aleris Skid Count Shipment Monthly Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_skid_count_report.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn = lds_skid_count_report.SaveAs(ls_file, Excel!, True) //"True" is to include headings

If li_rtn = 1 Then
	f_excel_open_xls_saveas_xlsx_cust(ls_file, ls_file_xlsx, il_customer_ids[], sqlca) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

	ls_run_message = "Aleris Skid Count Shipment Monthly Report saved in " + ls_file + ". Starting Aleris Skid Count Shipment Monthly Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
		
	ls_file_name_2email[1] = ls_file
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached Aleris Skid Count Shipment Monthly Report for date period from " + ls_date_from + " to " + ls_date_to
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_aleris_report(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

If IsValid(lds_skid_count_report) Then Destroy lds_skid_count_report

Return li_rtn
//Alex Gerlants. Aleris_Skid_Count_Shipment_Report. 05/10/2019. End
end function

public function integer wf_aleris_skid_count_report_w (string as_email_addresses[], long al_customer_ids[]);//Alex Gerlants. Aleris_Skid_Count_Shipment_Report. 05/10/2019. Begin
/*
Function:	wf_aleris_skid_count_report_w
				This report has to run on the first of every month.
				The data are from the first day of the previous month to the last day of the previous month.
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]	
				value	long		al_customer_ids[]
*/

Integer					li_rtn = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
Date						ld_today, ld_date_from, ld_date_to
String					ls_customer_id, ls_customer_ids
String					ls_sql, ls_sql_new
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
String					ls_date_from, ls_date_to, ls_run_message, ls_add_2sql
Long						ll_rows, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
DataStore				lds_skid_count_report
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "Aleris Skid Count Shipment report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If UpperBound(al_customer_ids[]) > 0 Then
	For li_i = 1 To UpperBound(al_customer_ids[])
		ls_customer_id = String(al_customer_ids[li_i])
		ls_customer_ids = ls_customer_ids + ls_customer_id + ", "
	Next
	
	//Remove the last comma
	ls_customer_ids = Left(ls_customer_ids, Len(ls_customer_ids) - 2)
Else
	Return li_rtn //Nothing to do here
End If

If IsValid(lds_skid_count_report) Then Destroy lds_skid_count_report
lds_skid_count_report = Create DataStore
lds_skid_count_report.DataObject = "d_report_skid_count_shipment_all_detail"
lds_skid_count_report.SetTransObject(sqlca)

ld_today = Today() //Monday
ld_date_from = RelativeDate(ld_today, -7) //Previous Monday
ld_date_to = RelativeDate(ld_today, -1) //Sunday

ls_date_from = String(ld_date_from, "mm/dd/yyyy")
ls_date_to = String(ld_date_to, "mm/dd/yyyy")

ls_add_2sql = " where shipment.customer_id in (" + ls_customer_ids + ") and shipment.shipment_actualed_date_time " + &
						"between to_date('" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss')" + &
						" and to_date('" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss')" + &
						" order by shipment.packing_list, shipment.bill_of_lading, order_item.enduser_part_num, sheet_skid.sheet_skid_num"

ls_sql = lds_skid_count_report.GetSqlSelect()

If ls_sql <> "" Then //OK
	ls_sql_new = ls_sql + ls_add_2sql
	li_rtn = lds_skid_count_report.SetSqlSelect(ls_sql_new)
	
	If IsNull(li_rtn) Then li_rtn = -1
		
	If li_rtn = -1 Then
		ls_run_message = "Error mofifying SQL in wf_aleris_skid_count_report_m for w_run_report (lds_skid_count_report.SetSqlSelect(ls_sql_new)). Cannot run ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
		Return -1
	End If
Else
	ls_run_message = "Error mofifying SQL in wf_aleris_skid_count_report_m for w_run_report (lds_skid_count_report.GetSqlSelect()). Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

ll_rows = lds_skid_count_report.Retrieve()

If ll_rows < 0 Then
	ls_run_message = "Retrieve DB error in function wf_aleris_skid_count_report_m for w_run_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Aleris Skid Count Shipment Weekly Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_skid_count_report.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn = lds_skid_count_report.SaveAs(ls_file, Excel!, True) //"True" is to include headings

If li_rtn = 1 Then
	f_excel_open_xls_saveas_xlsx_cust(ls_file, ls_file_xlsx, il_customer_ids[], sqlca) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_run_message = "Aleris Skid Count Shipment Weekly report saved in " + ls_file + ". Starting Aleris Skid Count Shipment Weekly Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
		
	ls_file_name_2email[1] = ls_file
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached Aleris Skid Count Shipment Weekly Report for date period from " + ls_date_from + " to " + ls_date_to
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_aleris_report(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

If IsValid(lds_skid_count_report) Then Destroy lds_skid_count_report

Return li_rtn
//Alex Gerlants. Aleris_Skid_Count_Shipment_Report. 05/10/2019. End
end function

public function integer wf_onhold_status_updates_report (string as_email_addresses[]);//Alex Gerlants. OnHoldReport. 09/27/2019. Begin
/*
Function:	wf_onhold_status_updates_report
				This report has to run on Monday.
				The data are from the first day of the previous month to the last day of the previous month.
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]	
*/

Integer					li_rtn = 1, li_rtn_tracking = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
Date						ld_today, ld_date_from, ld_date_to
DateTime					ldt_from, ldt_to
Time						lt_time_from = Time("00:00:00"), lt_time_to = Time("23:59:59")
String					ls_customer_id, ls_customer_ids
String					ls_sql, ls_sql_new
String					ls_file_name_2email[], ls_file, ls_file_tracking, ls_body, ls_email_address
String					ls_date_from, ls_date_to, ls_run_message, ls_add_2sql
Long						ll_rows, ll_rows_tracking, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
DataStore				lds_onhold_report, lds_onhold_report_tracking
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "On-hold status updates report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

//If UpperBound(al_customer_ids[]) > 0 Then
//	For li_i = 1 To UpperBound(al_customer_ids[])
//		ls_customer_id = String(al_customer_ids[li_i])
//		ls_customer_ids = ls_customer_ids + ls_customer_id + ", "
//	Next
//	
//	//Remove the last comma
//	ls_customer_ids = Left(ls_customer_ids, Len(ls_customer_ids) - 2)
//Else
//	Return li_rtn //Nothing to do here
//End If

If IsValid(lds_onhold_report_tracking) Then Destroy lds_onhold_report_tracking
lds_onhold_report_tracking = Create DataStore
lds_onhold_report_tracking.DataObject = "d_onhold_report_tracking"
lds_onhold_report_tracking.SetTransObject(sqlca)

If IsValid(lds_onhold_report) Then Destroy lds_onhold_report
lds_onhold_report = Create DataStore
lds_onhold_report.DataObject = "d_onhold_report"
lds_onhold_report.SetTransObject(sqlca)

ld_today = Today() //Monday

//ld_date_from = RelativeDate(ld_today, -7) //Previous Monday
//ld_date_to = RelativeDate(ld_today, -1) //Sunday

ld_date_from = RelativeDate(ld_today, -1) //Previous day //Alex Gerlants. 12/17/2019
ld_date_to = RelativeDate(ld_today, -1) //Previous day //Alex Gerlants. 12/17/2019

ldt_from = DateTime(ld_date_from, lt_time_from)
ldt_to = DateTime(ld_date_to, lt_time_to)

ls_date_from = String(ld_date_from, "mm/dd/yyyy")
ls_date_to = String(ld_date_to, "mm/dd/yyyy")

//ls_add_2sql = " where shipment.customer_id in (" + ls_customer_ids + ") and shipment.shipment_actualed_date_time " + &
//						"between to_date('" + ls_date_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss')" + &
//						" and to_date('" + ls_date_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss')" + &
//						" order by shipment.packing_list, shipment.bill_of_lading, order_item.enduser_part_num, sheet_skid.sheet_skid_num"
//
//ls_sql = lds_onhold_report.GetSqlSelect()
//
//If ls_sql <> "" Then //OK
//	ls_sql_new = ls_sql + ls_add_2sql
//	li_rtn = lds_onhold_report.SetSqlSelect(ls_sql_new)
//	
//	If IsNull(li_rtn) Then li_rtn = -1
//		
//	If li_rtn = -1 Then
//		ls_run_message = "Error mofifying SQL in wf_onhold_status_updates_report for w_run_report (lds_onhold_report.SetSqlSelect(ls_sql_new)). Cannot run ..."
//		li_rtn = wf_insert_auto_run_log(ls_run_message)
//		Return -1
//	End If
//Else
//	ls_run_message = "Error mofifying SQL in wf_onhold_status_updates_report for w_run_report (lds_onhold_report.GetSqlSelect()). Cannot run ..."
//	li_rtn = wf_insert_auto_run_log(ls_run_message)
//	Return -1
//End If

ll_rows = lds_onhold_report.Retrieve(ldt_from, ldt_to)

If ll_rows < 0 Then
	ls_run_message = "Retrieve DB error in function wf_onhold_status_updates_report for w_run_report while retrieving lds_onhold_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

ll_rows_tracking = lds_onhold_report_tracking.Retrieve(ldt_from, ldt_to)

If ll_rows_tracking < 0 Then
	ls_run_message = "Retrieve DB error in function wf_onhold_status_updates_report for w_run_report while retrieving lds_onhold_report_tracking. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 and ll_rows_tracking >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "OnHold_Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"
ls_file_tracking = is_email_folder + "OnHold_Report_Tracking_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_onhold_report.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn = lds_onhold_report.SaveAs(ls_file, Excel!, True) //"True" is to include headings
li_rtn_tracking = lds_onhold_report_tracking.SaveAs(ls_file_tracking, Excel!, True) //"True" is to include headings

If li_rtn = 1 And li_rtn_tracking = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	f_excel_open_xls_saveas_xlsx(ls_file_tracking, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file_tracking = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_run_message = "OnHold_Report saved in " + ls_file + ". Starting OnHold_Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
	ls_run_message = "OnHold_Report Tracking saved in " + ls_file_tracking + ". Starting OnHold Tracking Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
		
	ls_file_name_2email[1] = ls_file
	ls_file_name_2email[2] = ls_file_tracking
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached On-Hold Status Reports for date period from " + ls_date_from + " to " + ls_date_to
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_onhold_report(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " and " + ls_file_tracking + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " and " + ls_file_tracking + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

If IsValid(lds_onhold_report) Then Destroy lds_onhold_report

Return li_rtn
//Alex Gerlants. OnHoldReport. 09/27/2019. End
end function

public function integer wf_onhold_status_updates_report_monthly (string as_email_addresses[]);//Alex Gerlants. OnHoldReport. 09/27/2019. Begin
/*
Function:	wf_onhold_status_updates_report_monthly
				This report has to run on Monday.
				The data are from the first day of the previous month to the last day of the previous month.
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]	
*/

Integer					li_rtn = 1, li_rtn_tracking = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
Date						ld_today, ld_date_from, ld_date_to
DateTime					ldt_from, ldt_to
Time						lt_time_from = Time("00:00:00"), lt_time_to = Time("23:59:59")
String					ls_customer_id, ls_customer_ids
String					ls_sql, ls_sql_new
String					ls_file_name_2email[], ls_file, ls_file_tracking, ls_body, ls_email_address
String					ls_date_from, ls_date_to, ls_run_message, ls_add_2sql
Long						ll_rows, ll_rows_tracking, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
DataStore				lds_onhold_report, lds_onhold_report_tracking
str_all_data_types	lstr_all_data_types
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "On-hold status updates report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

//If UpperBound(al_customer_ids[]) > 0 Then
//	For li_i = 1 To UpperBound(al_customer_ids[])
//		ls_customer_id = String(al_customer_ids[li_i])
//		ls_customer_ids = ls_customer_ids + ls_customer_id + ", "
//	Next
//	
//	//Remove the last comma
//	ls_customer_ids = Left(ls_customer_ids, Len(ls_customer_ids) - 2)
//Else
//	Return li_rtn //Nothing to do here
//End If

If IsValid(lds_onhold_report_tracking) Then Destroy lds_onhold_report_tracking
lds_onhold_report_tracking = Create DataStore
lds_onhold_report_tracking.DataObject = "d_onhold_report_tracking"
lds_onhold_report_tracking.SetTransObject(sqlca)

If IsValid(lds_onhold_report) Then Destroy lds_onhold_report
lds_onhold_report = Create DataStore
lds_onhold_report.DataObject = "d_onhold_report"
lds_onhold_report.SetTransObject(sqlca)

ld_today = Today() //Monday

//ld_date_from = RelativeDate(ld_today, -7) //Previous Monday
//ld_date_to = RelativeDate(ld_today, -1) //Sunday

//ld_date_from = RelativeDate(ld_today, -1) //Previous day //Alex Gerlants. 12/17/2019
//ld_date_to = RelativeDate(ld_today, -1) //Previous day //Alex Gerlants. 12/17/2019
//
//ldt_from = DateTime(ld_date_from, lt_time_from)
//ldt_to = DateTime(ld_date_to, lt_time_to)
//
//ls_date_from = String(ld_date_from, "mm/dd/yyyy")
//ls_date_to = String(ld_date_to, "mm/dd/yyyy")

//---
//Get first and last day of the previous month
lstr_all_data_types = f_get_last_month_begin_end_dates()
ls_date_from = lstr_all_data_types.string_var[1]
ls_date_to = lstr_all_data_types.string_var[2]

ldt_from = DateTime(Date(ls_date_from), Time("00:00:00"))
ldt_to = DateTime(Date(ls_date_to), Time("23:59:59"))
//---

ll_rows = lds_onhold_report.Retrieve(ldt_from, ldt_to)

If ll_rows < 0 Then
	ls_run_message = "Retrieve DB error in function wf_onhold_status_updates_report for w_run_report while retrieving lds_onhold_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

ll_rows_tracking = lds_onhold_report_tracking.Retrieve(ldt_from, ldt_to)

If ll_rows_tracking < 0 Then
	ls_run_message = "Retrieve DB error in function wf_onhold_status_updates_report for w_run_report while retrieving lds_onhold_report_tracking. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 and ll_rows_tracking >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "OnHold_Report_Monthly_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"
ls_file_tracking = is_email_folder + "OnHold_Report_Tracking_Monthly_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_onhold_report.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn = lds_onhold_report.SaveAs(ls_file, Excel!, True) //"True" is to include headings
li_rtn_tracking = lds_onhold_report_tracking.SaveAs(ls_file_tracking, Excel!, True) //"True" is to include headings

If li_rtn = 1 And li_rtn_tracking = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	f_excel_open_xls_saveas_xlsx(ls_file_tracking, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file_tracking = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_run_message = "OnHold_Report saved in " + ls_file + ". Starting OnHold_Report_Monthly email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
	ls_run_message = "OnHold_Report Tracking saved in " + ls_file_tracking + ". Starting OnHold Tracking Monthly Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
		
	ls_file_name_2email[1] = ls_file
	ls_file_name_2email[2] = ls_file_tracking
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached On-Hold Status Monthly Reports for date period from " + ls_date_from + " to " + ls_date_to
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_onhold_report_monthly(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " and " + ls_file_tracking + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " and " + ls_file_tracking + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

If IsValid(lds_onhold_report) Then Destroy lds_onhold_report

Return li_rtn
//Alex Gerlants. OnHoldReport. 09/27/2019. End
end function

public function integer wf_inv_coils_skids_scrap_skids (string as_email_addresses[]);//Alex Gerlants. OnHoldReport. 09/27/2019. Begin
/*
Function:	wf_inv_coils_skids_scrap_skids
				This report has to run on Monday.
				The data are from the first day of the previous month to the last day of the previous month.
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]	
*/

Integer					li_rtn, li_rtn_coils = 1, li_rtn_skids = 1, li_rtn_scrap_skids = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
Date						ld_today, ld_date_from, ld_date_to
DateTime					ldt_from, ldt_to
Time						lt_time_from = Time("00:00:00"), lt_time_to = Time("23:59:59")
String					ls_customer_id, ls_customer_ids
String					ls_sql, ls_sql_new
String					ls_file_name_2email[], ls_file_coils, ls_file_skids, ls_file_scrap_skids, ls_body, ls_email_address
String					ls_date_from, ls_date_to, ls_run_message, ls_add_2sql
Long						ll_rows_coils, ll_rows_skids, ll_rows_scrap_skids, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
DataStore				lds_report_inv_abc_coils, lds_report_inv_abc_skids, lds_report_inv_abc_scrap_skids
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "Inventory coils, skids, scrap skids report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lds_report_inv_abc_coils) Then Destroy lds_report_inv_abc_coils
lds_report_inv_abc_coils = Create DataStore
lds_report_inv_abc_coils.DataObject = "d_report_inv_abc_coils_2" //New datawindow
lds_report_inv_abc_coils.SetTransObject(sqlca)

If IsValid(lds_report_inv_abc_skids) Then Destroy lds_report_inv_abc_skids
lds_report_inv_abc_skids = Create DataStore
lds_report_inv_abc_skids.DataObject = "d_report_inv_abc_skids_2"
lds_report_inv_abc_skids.SetTransObject(sqlca)

If IsValid(lds_report_inv_abc_scrap_skids) Then Destroy lds_report_inv_abc_scrap_skids
lds_report_inv_abc_scrap_skids = Create DataStore
lds_report_inv_abc_scrap_skids.DataObject = "d_report_inv_abc_scrap_skids_2"
lds_report_inv_abc_scrap_skids.SetTransObject(sqlca)

//---

ll_rows_coils = lds_report_inv_abc_coils.Retrieve()

If ll_rows_coils > 0 Then
	wf_remove_coil_duplicates(lds_report_inv_abc_coils)
Else
	If ll_rows_coils < 0 Then
		ls_run_message = "Retrieve DB error in function wf_inv_coils_skids_scrap_skids for w_run_report while retrieving lds_report_inv_abc_coils. Cannot run ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
		Return -1
	End If
End If

ll_rows_skids = lds_report_inv_abc_skids.Retrieve()

If ll_rows_skids > 0 Then
	lds_report_inv_abc_skids.SetSort("sheet_skid_sheet_skid_display_num A")
	lds_report_inv_abc_skids.Sort()
	
	wf_remove_skid_duplicates(lds_report_inv_abc_skids)
	wf_specs(lds_report_inv_abc_skids)	
	ls_sql = lds_report_inv_abc_skids.GetSqlSelect()
Else
	If ll_rows_skids < 0 Then
		ls_run_message = "Retrieve DB error in function wf_inv_coils_skids_scrap_skids for w_run_report while retrieving d_report_inv_abc_skids. Cannot run ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
		Return -1
	End If
End If

ll_rows_scrap_skids = lds_report_inv_abc_scrap_skids.Retrieve()

If ll_rows_scrap_skids > 0 Then
	wf_remove_scrap_skid_duplicates(lds_report_inv_abc_scrap_skids)
	wf_specs_scrap_skids(lds_report_inv_abc_scrap_skids)
Else
	If ll_rows_scrap_skids < 0 Then
		ls_run_message = "Retrieve DB error in function wf_inv_coils_skids_scrap_skids for w_run_report while retrieving lds_report_inv_abc_scrap_skids. Cannot run ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
		Return -1
	End If
End If

If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file_coils = is_email_folder + "Inv_Coils_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"
ls_file_skids = is_email_folder + "Inv_Skids_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"
ls_file_scrap_skids = is_email_folder + "Inv_Scrap_Skids_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_onhold_report.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn_coils = lds_report_inv_abc_coils.SaveAs(ls_file_coils, Excel!, True) //"True" is to include headings

If li_rtn_coils = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file_coils, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file_coils = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
End If

li_rtn_skids = lds_report_inv_abc_skids.SaveAs(ls_file_skids, Excel!, True) //"True" is to include headings

If li_rtn_skids = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file_skids, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file_skids = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
End If

li_rtn_scrap_skids = lds_report_inv_abc_scrap_skids.SaveAs(ls_file_scrap_skids, Excel!, True) //"True" is to include headings

If li_rtn_scrap_skids = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file_scrap_skids, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file_scrap_skids = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
End If

If li_rtn_coils = 1 And li_rtn_skids = 1 And li_rtn_scrap_skids = 1 Then
	ls_run_message = "Inventory coils_report saved in " + ls_file_coils
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
	ls_run_message = "Inventory skids Report saved in " + ls_file_skids
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
	ls_run_message = "Inventory scrap skids report saved in " + ls_file_scrap_skids
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
	ls_run_message = "Starting Inventory coils, skids, scrap skids report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
		
	ls_file_name_2email[1] = ls_file_coils
	ls_file_name_2email[2] = ls_file_skids
	ls_file_name_2email[3] = ls_file_scrap_skids
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached Inventory coils, skids, scrap skids reports."
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_coils_skids_scrap_skids(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file_coils + ", " + ls_file_skids + ", " + ls_file_scrap_skids + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file_coils + ", " + ls_file_skids + ", " + ls_file_scrap_skids + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

If IsValid(lds_report_inv_abc_coils) Then Destroy lds_report_inv_abc_coils
If IsValid(lds_report_inv_abc_skids) Then Destroy lds_report_inv_abc_skids
If IsValid(lds_report_inv_abc_scrap_skids) Then Destroy lds_report_inv_abc_scrap_skids

Return li_rtn
//Alex Gerlants. OnHoldReport. 09/27/2019. End
end function

public function integer wf_remove_coil_duplicates (ref datastore ads);//Alex Gerlants. 02/06/2020.inv coils skids scrap skids report. Begin
/*
Remove rows with duplicate coil_org_num
Function:	wf_remove_coil_duplicates
				Remove rows with duplicate combination of coil_org_num and coil_abc_num
Returns:		integer
Arguments:	reference	datastore	ads
*/

Long		ll_rows, ll_row
Integer	li_rtn = 1
String	ls_coil_coil_org_num_prev, ls_coil_coil_org_num
String	ls_coil_coil_abc_num_prev, ls_coil_coil_abc_num
String	ls_key, ls_key_prev

ll_rows = ads.RowCount()
If ll_rows <= 0 Then Return 0

li_rtn = ads.SetSort("coil_coil_org_num Asc, coil_coil_abc_num Asc")
li_rtn = ads.Sort()

//ls_coil_coil_org_num_prev = ""
ls_key_prev = ""

For ll_row = ll_rows To 1 Step -1
	ls_coil_coil_org_num = ads.Object.coil_coil_org_num[ll_row]
	ls_coil_coil_abc_num = String(ads.Object.coil_coil_abc_num[ll_row])
	
	ls_key = ls_coil_coil_org_num + ls_coil_coil_abc_num
	
	//If ls_coil_coil_org_num = ls_coil_coil_org_num_prev Then
	If ls_key = ls_key_prev Then
		ads.DeleteRow(ll_row)
	End If
	
	//ls_coil_coil_org_num_prev = ls_coil_coil_org_num
	ls_key_prev = ls_key
Next

ll_rows = ads.RowCount()

Return li_rtn
//Alex Gerlants. 02/06/2020.inv coils skids scrap skids report. End
end function

public subroutine wf_specs (ref datastore ads);//Alex_Inventory_Report_Coils_Skids_ScrapSkids. 02/06/2020. Begin
/*
Function:	wf_specs
Returns:		none
Arguments:	reference	datastore	ads
*/

Long ll_row, ll_c
Long ll_job, ll_bal_due
String ls_spec

ll_row = ads.RowCount()

If ll_row > 0 Then
	For ll_c = 1 To ll_row
		ll_job = ads.GetItemNumber(ll_c, "ab_job_ab_job_num")
		ls_spec = wf_job_spec(ll_job)
		ads.SetItem(ll_c, "cspec_t", ls_spec)
	Next
End If

ads.ResetUpdate()
//Alex_Inventory_Report_Coils_Skids_ScrapSkids. 02/06/2020. End
end subroutine

public function string wf_job_spec (long al_job);//Alex_Inventory_Report_Coils_Skids_ScrapSkids. 02/06/2020. Begin
/*
Function:	wf_job_spec
Returns:		string
Arguments:	value	long	al_job
*/

SetPointer(HourGlass!)

String ls_spec
Long ll_order
Int li_item
String ls_shape
Real lr_l, lr_s, lr_w, lr_gauge

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT sheet_type, gauge INTO :ls_shape, :lr_gauge
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

ls_spec = String(lr_gauge, "#.#####")
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_width INTO :lr_l, :lr_w
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") 
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_l, "#####.#####") 
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		
	//Alex Gerlants. 10/14/2020. Skid_Recap_Report_Fix. Begin
	Case "LIFTGATE"
		select	li_width, li_length
		into		:lr_w, :lr_l
		from		liftgate_shape
		where		order_abc_num = :ll_order AND order_item_num = :li_item
		using		sqlca;
		
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
		
	Case "REINFORCEMENT"
		select	re_width, re_length
		into		:lr_w, :lr_l
		from		reinforcement
		where		order_abc_num = :ll_order AND order_item_num = :li_item
		using		sqlca;
		
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	//Alex Gerlants. 10/14/2020. Skid_Recap_Report_Fix. End
	
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + " X " + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE ELSE
		ls_spec = ls_spec + " X " + "VAR"
END CHOOSE	

RETURN ls_spec
//Alex_Inventory_Report_Coils_Skids_ScrapSkids. 02/06/2020. End
end function

public subroutine wf_specs_scrap_skids (ref datastore ads);//Alex_Inventory_Report_Coils_Skids_ScrapSkids. 02/06/2020. Begin
/*
Function:	wf_specs_scrap_skids
Returns:		none
Arguments:	reference	datastore	ads
*/

//The commented out block of code below is production code.
//It removes duration from duplicate scrap skids.
//At this point, duplicate skids are removed in wf_remove_scrap_skid_duplicates().
//Thus we simply update duration for each row.

Long ll_rows, ll_row, ll_days
Date ld_skiddate

ll_rows = ads.RowCount()

For ll_row = 1 To ll_rows
	ld_skiddate = Date(ads.Object.scrap_skid_scrap_date[ll_row])
	ll_days = DaysAfter(ld_skiddate, Today())
	ads.Object.duration[ll_row] = ll_days
Next

ads.ResetUpdate()

//---------------------------------------------------
//Long ll_row, ll_c
//Long ll_days, ll_skid, ll_pskid, ll_nskid
//Date ld_skiddate
//
//ll_row = ads.RowCount()
//
//If ll_row <= 0 Then Return
//
//ll_skid = ads.GetItemNumber(1, "scrap_skid_scrap_skid_num")	
//ld_skiddate = Date(ads.GetItemDateTime(1, "scrap_skid_scrap_date"))
//ll_days = DaysAfter(ld_skiddate, Today())
//ads.SetItem(1, "duration", ll_days)
//ll_pskid = ll_skid
//
//If ll_row > 1 Then
//	For ll_c = 2 To ll_row
//		ll_skid = ads.GetItemNumber(ll_c, "scrap_skid_scrap_skid_num")
//		If ll_skid = ll_pskid Then
//			SetNULL(ll_days)
//			ads.SetItem(ll_c, "duration", ll_days)
//		Else
//			ll_pskid = ll_skid
//			ld_skiddate = Date(ads.GetItemDateTime(ll_c, "scrap_skid_scrap_date"))
//			ll_days = DaysAfter(ld_skiddate, Today())
//			ads.SetItem(ll_c, "duration", ll_days)
//		End If
//	Next
//End If
//
//ads.ResetUpdate()
//Alex_Inventory_Report_Coils_Skids_ScrapSkids. 02/06/2020. End
end subroutine

public function integer wf_remove_skid_duplicates (ref datastore ads);//Alex Gerlants. 02/06/2020.inv coils skids scrap skids report. Begin
/*
Remove rows with duplicate sheet_skid_sheet_skid_display_num
Function:	wf_remove_skid_duplicates
Returns:		integer
Arguments:	reference	datastore	ads
*/

Long		ll_rows, ll_row
Integer	li_rtn = 1
String	ls_sheet_skid_display_num_prev, ls_sheet_skid_display_num

ll_rows = ads.RowCount()
If ll_rows <= 0 Then Return 0

li_rtn = ads.SetSort("sheet_skid_sheet_skid_display_num Asc")
li_rtn = ads.Sort()

ls_sheet_skid_display_num_prev = ""

For ll_row = ll_rows To 1 Step -1
	ls_sheet_skid_display_num = ads.Object.sheet_skid_sheet_skid_display_num[ll_row]
	
	If ls_sheet_skid_display_num = ls_sheet_skid_display_num_prev Then
		ads.DeleteRow(ll_row)
	End If
	
	ls_sheet_skid_display_num_prev = ls_sheet_skid_display_num
Next

ll_rows = ads.RowCount()

Return li_rtn
//Alex Gerlants. 02/06/2020.inv coils skids scrap skids report. End
end function

public function integer wf_remove_scrap_skid_duplicates (ref datastore ads);//Alex Gerlants. 02/06/2020.inv coils skids scrap skids report. Begin
/*
Remove rows with duplicate scrap_skid_scrap_skid_display_num
Function:	wf_remove_scrap_skid_duplicates
Returns:		integer
Arguments:	reference	datastore	ads
*/

Long		ll_rows, ll_row
Integer	li_rtn = 1
String	ls_scrap_skid_display_num_prev, ls_scrap_skid_display_num

ll_rows = ads.RowCount()
If ll_rows <= 0 Then Return 0

li_rtn = ads.SetSort("scrap_skid_scrap_skid_display_num Asc")
li_rtn = ads.Sort()

ls_scrap_skid_display_num_prev = ""

For ll_row = ll_rows To 1 Step -1
	ls_scrap_skid_display_num = ads.Object.scrap_skid_scrap_skid_display_num[ll_row]
	
	If ls_scrap_skid_display_num = ls_scrap_skid_display_num_prev Then
		ads.DeleteRow(ll_row)
	End If
	
	ls_scrap_skid_display_num_prev = ls_scrap_skid_display_num
Next

ll_rows = ads.RowCount()

Return li_rtn
//Alex Gerlants. 02/06/2020.inv coils skids scrap skids report. End
end function

public function integer wf_aluminum_content_blank_report (string as_email_addresses[]);//Alex Gerlants. Aluminum_Content_Blank_Report. 03/12/2020. Begin
/*
Function:	wf_aluminum_content_blank_report
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]	
*/

Integer					li_rtn = 1
Boolean					lb_rtn
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
String					ls_run_message
Long						ll_rows, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
DataStore				lds_aluminum_content_blank_report

//Alex Gerlants. 04/22/2020. Begin
String					ls_sql_current, ls_sql_add, ls_sql_new
String					ls_day, ls_month, ls_year_current, ls_year_1_earlier
Integer					li_day, li_month, li_year_current
String					ls_date_current, ls_date_1_year_earlier
String					ls_time_from, ls_time_to, ls_dttm_from, ls_dttm_to
//Alex Gerlants. 04/22/2020. End

String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "Novelis Aluminum Content Blank report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lds_aluminum_content_blank_report) Then Destroy lds_aluminum_content_blank_report
lds_aluminum_content_blank_report = Create DataStore
lds_aluminum_content_blank_report.DataObject = "d_aluminum_content_blank_report"
li_rtn = lds_aluminum_content_blank_report.SetTransObject(sqlca)

//Alex Gerlants. 04/22/2020. Begin
li_day = Day(Today())

If li_day < 10 Then 
	ls_day = "0" + String(li_day)
Else
	ls_day = String(li_day)
End If

li_month = Month(Today())

If li_month < 10 Then 
	ls_month = "0" + String(li_month)
Else
	ls_month = String(li_month)
End If

li_year_current = Year(Today())
ls_year_current = String(li_year_current)
ls_year_1_earlier = String(li_year_current - 1)

ls_date_current = ls_month + "/" + ls_day + "/" + ls_year_current
ls_date_1_year_earlier = ls_month + "/" + ls_day + "/" + ls_year_1_earlier

If Left(ls_date_1_year_earlier, 6) = "02/29/" Then //Leap year
	ls_date_1_year_earlier = "02/28/" + Right(ls_date_1_year_earlier, 4)
End If

ls_time_from = "00:00:00"
ls_time_to = "23:59:59"

ls_dttm_from = ls_date_1_year_earlier + " " + ls_time_from
ls_dttm_to = ls_date_current + " " + ls_time_to

ls_sql_current = lds_aluminum_content_blank_report.GetSqlSelect()

ls_sql_add = 	"~n~rwhere lower(customer.customer_short_name) like '%novelis%'" + &
					"~n~rand coil.coil_entry_date between to_date('" + ls_dttm_from + "', 'mm/dd/yyyy hh24:mi:ss') and to_date( '" + ls_dttm_to + "', 'mm/dd/yyyy hh24:mi:ss')" + &
					"~n~rand coil.net_wt_balance > 0" + &
					"~n~rand (data_in_863.al is null or to_number(nvl(al, 0), '9999.9999') < 90.000 or to_number(nvl(al, 0), '9999.9999') > 100.00)" + &
					"~n~rorder by customer.customer_short_name, coil.coil_entry_date, data_in_863.coil_num"

ls_sql_new = ls_sql_current + ls_sql_add

lds_aluminum_content_blank_report.SetSqlSelect(ls_sql_new)
//Alex Gerlants. 04/22/2020. End

ll_rows = lds_aluminum_content_blank_report.Retrieve()

If ll_rows < 0 Then
	ls_run_message = "Retrieve DB error in function wf_aluminum_content_blank_report for w_run_report while retrieving lds_aluminum_content_blank_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 and ll_rows_tracking >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Novelis_Aluminum_Content_Blank_Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_aluminum_content_blank_report.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn = lds_aluminum_content_blank_report.SaveAs(ls_file, Excel!, True) //"True" is to include headings

If li_rtn = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

	ls_run_message = "Novelis_Aluminum_Content_Blank_Report saved in " + ls_file
	li_rtn = wf_insert_auto_run_log(ls_run_message)
		
	If ll_rows > 0 Then //Alex Gerlants. 04/22/2020. Attached file only if there are rows there
		ls_file_name_2email[1] = ls_file
	//End If //Alex Gerlants. 04/22/2020
	
		If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
		Open(lw_inventory_reports)
		
		If ll_rows > 0 Then //Alex Gerlants. 04/22/2020
			ls_body = "Please find attached Novelis Aluminum Content Blank Report for coil entry date between " + ls_date_1_year_earlier + " and " + ls_date_current
		Else //Alex Gerlants. 04/22/2020
			ls_body = "No data retrieved for coil entry date between " + ls_date_1_year_earlier + " and " + ls_date_current //Alex Gerlants. 04/22/2020
		End If //Alex Gerlants. 04/22/2020
		
		For ll_i = 1 To UpperBound(as_email_addresses[])
			ls_email_address = as_email_addresses[ll_i]
			
			lb_rtn = lw_inventory_reports.wf_send_smtp_email_alum_cont_report(ls_body, ls_file_name_2email[], ls_email_address)
			
			If lb_rtn Then
				ls_run_message = ls_file + " successfully emailed to " + ls_email_address
				li_rtn = wf_insert_auto_run_log(ls_run_message)
			End If
		Next
		
		lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
		
		If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	End If //Alex Gerlants. 11/30/2020
End If

If IsValid(lds_aluminum_content_blank_report) Then Destroy lds_aluminum_content_blank_report

Return li_rtn
//Alex Gerlants. Aluminum_Content_Blank_Report. 03/12/2020. . End
end function

public function integer wf_fix_first_job_in_jobset ();//Alex Gerlants. 09/28/2020. Begin
/*
Function:	wf_fix_first_job_in_jobset
				The first job/coil in chain has wrong current_wt, process_end_wt, process_coil_status, shift_process_status
				In this function, I am updating process_coil table for the first job/coil in a multi-job set.
				I am copying process_quantity from the second job/coil in chain, and update current_wt and process_end_wt for the first job/coil in chain.
				I also update process_coil_status and shift_process_status for the first job/coil in chain.
Returns:		integer	 1 If OK
							-1 If DB error
Arguments:	none
*/

Integer		li_rtn = 1
Long			ll_rows_coils_2fix, ll_rows_first_job_coil_2fix, ll_row_coil_2fix, ll_row_first_job_coil_2fix, ll_coil_abc_num
Long			ll_process_quantity, ll_ab_job_2fix, ll_found_row
String		ls_run_message, ls_find_string
DataStore	lds_coils_2fix, lds_first_job_coil_2fix

lds_coils_2fix = Create DataStore
lds_coils_2fix.DataObject = "d_coils_2fix"
lds_coils_2fix.SetTransObject(sqlca)

lds_first_job_coil_2fix = Create DataStore
lds_first_job_coil_2fix.DataObject = "d_first_job_coil_2fix"
lds_first_job_coil_2fix.SetTransObject(sqlca)

ll_rows_coils_2fix = lds_coils_2fix.Retrieve()

If ll_rows_coils_2fix < 0 Then //DB error
	ls_run_message = "Database error in wf_fix_first_job_in_jobset for w_run_report while trying to retrieve data from table coils_weight_zeroed_out. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
   Return -1
End If

//lds_coils_2fix.SetSort("coil_abc_num D")
//lds_coils_2fix.Sort()

For ll_row_coil_2fix = 1 To ll_rows_coils_2fix
	ll_coil_abc_num = lds_coils_2fix.Object.coil_abc_num[ll_row_coil_2fix]
	
	ll_rows_first_job_coil_2fix = lds_first_job_coil_2fix.Retrieve(ll_coil_abc_num)
	
	If ll_rows_first_job_coil_2fix < 0 Then //DB error
			ls_run_message = "Database error in wf_fix_first_job_in_jobset for w_run_report while trying to retrieve data from table process_coil for ABC coil " + String(ll_coil_abc_num) + ". Cannot run ..."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
			
			Return -1
	End If
	
	If ll_rows_first_job_coil_2fix > 1 Then
		ll_ab_job_2fix = lds_first_job_coil_2fix.Object.ab_job_num[1] //This is the first job that has wrong current_wt, process_end_wt, process_coil_status, shift_process_status
		ll_process_quantity = lds_first_job_coil_2fix.Object.process_quantity[2]
		
		update	process_coil
		set		current_wt = :ll_process_quantity,
					process_end_wt = :ll_process_quantity,
					process_coil_status = 7,
					shift_process_status = 7
		where		ab_job_num = :ll_ab_job_2fix
		and		coil_abc_num = :ll_coil_abc_num
		using		sqlca;
		
		If sqlca.sqlcode = 0 Then //OK
			commit using sqlca;
			
			ls_find_string = "coil_abc_num = " + String(ll_coil_abc_num) + " and ab_job_num = " + String(ll_ab_job_2fix)
			ll_found_row = dw_coils_weight_zeroed_out.Find(ls_find_string, 1, dw_coils_weight_zeroed_out.RowCount())
			
			If ll_found_row > 0 Then
				dw_coils_weight_zeroed_out.Object.corrected[ll_found_row] = "Y"
				
				ls_run_message = "Job " + String(ll_ab_job_2fix) + " fixed"
				li_rtn = wf_insert_auto_run_log(ls_run_message)
			End If
		Else //DB error
			ls_run_message = "Database error in wf_fix_first_job_in_jobset for w_run_report while trying to update table process_coil for ABC Coil " + &
																							String(ll_coil_abc_num) + " and AB Job " + String(ll_ab_job_2fix) + ". Cannot run ..."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
			
			Return -1
		End If
	End If
Next

Return li_rtn
//Alex Gerlants. 09/28/2020. End
end function

public function integer wf_recapped_jobs_without_870_report (string as_email_addresses[]);//Alex Gerlants. 1092_Alex_Recapped_Jobs_Without_870. 12/13/2021. Begin
/*
Function:	wf_recapped_jobs_without_870_report
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]							
*/

Integer					li_rtn = 1
Boolean					lb_rtn
DataStore				lds_recapped_jobs_without_870
DateTime					ldt_date_from, ldt_date_to
String					ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_i
w_inventory_reports	lw_inventory_reports
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "Recapped Jobs Without 870 report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lds_recapped_jobs_without_870) Then Destroy lds_recapped_jobs_without_870
lds_recapped_jobs_without_870 = Create DataStore
lds_recapped_jobs_without_870.DataObject = "d_recapped_jobs_without_870"
lds_recapped_jobs_without_870.SetTransObject(sqlca)

ldt_date_from = DateTime(Today(), Time("00:00:00"))
ldt_date_to = DateTime(Today(), Now())

ll_rows = lds_recapped_jobs_without_870.Retrieve(ldt_date_from, ldt_date_to)

	
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Recapped Jobs Without 870 report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_recapped_jobs_without_870.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn = lds_recapped_jobs_without_870.SaveAs(ls_file, Excel!, True) //"True" is to include headings

If li_rtn = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_run_message = "Recapped Jobs Without 870 report saved in " + ls_file + ". Starting Recapped Jobs Without 870 report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)

	If ll_rows > 0 Then //Alex Gerlants. 11/24/2020. Send only if there are rows in the report
		ls_file_name_2email[1] = ls_file
		If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
		Open(lw_inventory_reports)
		
		ls_body = "Please find attached Recapped Jobs Without 870 report for date period from " + String(ldt_date_from) + " to " + String(ldt_date_to)
		
		For ll_i = 1 To UpperBound(as_email_addresses[])
			ls_email_address = as_email_addresses[ll_i]
			
			lb_rtn = lw_inventory_reports.wf_send_smtp_email_recapped_jobs_no_870(ls_body, ls_file_name_2email[], ls_email_address)
			
			If lb_rtn Then
				ls_run_message = ls_file + " successfully emailed to " + ls_email_address
				li_rtn = wf_insert_auto_run_log(ls_run_message)
			Else
				ls_run_message = ls_file + " email to " + ls_email_address + " failed."
				li_rtn = wf_insert_auto_run_log(ls_run_message)
			End If
		Next
	
		lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	End If //Alex Gerlants. 11/24/2020
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

Return li_rtn
//Alex Gerlants. 1092_Alex_Recapped_Jobs_Without_870. 12/13/2021. End
end function

public function integer wf_abco_backlog_report (string as_email_addresses[]);//Alex Gerlants. 1327_abco_backlog_report. 10/07/2021. Begin
/*
Function:	wf_abco_backlog_report
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]							
*/

Integer					li_rtn = 1, li_rtn_rowscopy
Boolean					lb_rtn, lb_rtn_rowscopy
DataStore				lds_abco_backlog_report
DateTime					ldt_date_from, ldt_date_to
String					ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_i
w_inventory_reports	lw_inventory_reports
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "ABCo Backlog Report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lds_abco_backlog_report) Then Destroy lds_abco_backlog_report
lds_abco_backlog_report = Create DataStore
lds_abco_backlog_report.DataObject = "d_abco_backlog_report"
lds_abco_backlog_report.SetTransObject(sqlca)

ldt_date_from = DateTime(Today(), Time("00:00:00"))
ldt_date_to = DateTime(Today(), Now())

ll_rows = lds_abco_backlog_report.Retrieve(ldt_date_from, ldt_date_to)

If ll_rows > 0 Then //Do not send email if there is nothing to report
	li_rtn_rowscopy = lds_abco_backlog_report.RowsCopy(1, lds_abco_backlog_report.RowCount(), Primary!, dw_abco_backlog_report, 1, Primary!)
	ll_rows = dw_abco_backlog_report.RowCount()
	
	wf_exporttoexcel_backlog( dw_abco_backlog_report, dw_abco_backlog_report.RowCount(), ls_file )
		
	If Right(is_email_folder, 1) <> "\" Then
		is_email_folder = is_email_folder + "\"
	End If
	
	If li_rtn = 1 Then
		f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
		ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
		
		ls_run_message = "ABCo Backlog report saved in " + ls_file + ". Starting ABCo Backlog report email ..."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	
		//If ll_rows > 0 Then //Alex Gerlants. 11/24/2020. Send only if there are rows in the report
			ls_file_name_2email[1] = ls_file
			If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
			Open(lw_inventory_reports)
			
			ls_body = "Please find attached ABCo Backlog report. Job due dates: before or equal to current date"
			
			For ll_i = 1 To UpperBound(as_email_addresses[])
				ls_email_address = as_email_addresses[ll_i]
				
				lb_rtn = lw_inventory_reports.wf_send_smtp_email_abco_backlog_report(ls_body, ls_file_name_2email[], ls_email_address)
				
				If lb_rtn Then
					ls_run_message = ls_file + " successfully emailed to " + ls_email_address
					li_rtn = wf_insert_auto_run_log(ls_run_message)
				Else
					ls_run_message = ls_file + " email to " + ls_email_address + " failed."
					li_rtn = wf_insert_auto_run_log(ls_run_message)
				End If
			Next
		
			lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
		//End If //Alex Gerlants. 11/24/2020
		
		If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	End If
End If

Return li_rtn
//Alex Gerlants. 1327_abco_backlog_report. . 10/07/2021. End
end function

public subroutine wf_excel_open_xls_saveas_xlsx_backlog (string as_file_in_xls, string as_file_out_xlsx);//Alex Gerlants. 10/07/2021. 1327_abco_backlog_report. Begin
/* 
Function:	wf_excel_open_xls_saveas_xlsx_backlog
Returns:		none
Arguments:	value			string		as_file_in_xls
				reference	string		as_file_out_xlsx
*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_file_name, ls_email_file, ls_file_in, ls_file_out, ls_file_archive
//String		ls_work_folder, as_email_folder, ls_archive_folder 
String		ls_date, ls_time, ls_date_time
Integer		li_rtn, li_filenum
Long			ll_pos
Boolean		lb_rtn
Any			la_rtn

If Lower(Right(as_file_in_xls, 4)) = "xlsx" Then //Do not convert if as_file_in_xls is already converted into .XLSX
	as_file_out_xlsx = as_file_in_xls
	Return
End If

SetPointer( HourGlass! )

//ls_file_in = as_file_in_xls

lole_OLE = CREATE OleObject
li_rtn = lole_OLE.ConnectToNewObject('excel.application')

If li_rtn = 0 Then
	lole_OLE.Application.DisplayAlerts = "False"
	la_rtn = lole_OLE.Workbooks.Open(as_file_in_xls)
	lole_OLE.Visible=FALSE
	
	
	//lole_Sheet.Range("A1:N8").Select
	//lole_Sheet.Application.Selection.EntireRow.Insert 
	
	lole_OLE.cells[20,4] = "Total Weight"
	
	as_file_out_xlsx = Left(as_file_in_xls, Len(as_file_in_xls) - 3) + "xlsx"
	
	FileDelete(as_file_in_xls)
	FileDelete(as_file_out_xlsx)
	
	lole_OLE.ActiveWorkbook.SaveAs(as_file_out_xlsx, 51) //xlsx
	
	lole_OLE.Application.DisplayAlerts = "False"
End If

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

Garbagecollect()

//lb_rtn = FileDelete(ls_file_in)

SetPointer( Arrow! )
//Alex Gerlants. 10/07/2021. 1327_abco_backlog_report. End
end subroutine

public subroutine wf_exporttoexcel_backlog (datawindow adw_dw, long al_rows, ref string as_file_out);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	wf_exporttoexcel_backlog
Returns:		none
Arguments:	value			datawindow	adw_dw
				value			long			al_rows	
				reference	string		as_file_out
*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_wt
String		ls_range 
String		ls_sum_processed, ls_sum_scrap_net
String		ls_sum_net_wt, ls_sum_tare_wt, ls_sum_theo_wt
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder, ls_run_date
Date 			ld_today
Time 			ld_now
Integer		li_answer

//Return //Disable this function for now ...

uo_save_as_excel	luo_save_as_excel

luo_save_as_excel = Create uo_save_as_excel

ll_report_rows = adw_dw.RowCount()

If ll_report_rows <= 0 Then Return

//ls_run_date = is_run_date_t

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

luo_save_as_excel.GetColumns( adw_DW, ls_Columns )

ll_Cols = UpperBound( ls_Columns )

FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		luo_save_as_excel.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( luo_save_as_excel.inttocolumn( 1 ) + "1:" + luo_save_as_excel.inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( luo_save_as_excel.inttocolumn( 1 ) + ":" + luo_save_as_excel.inttocolumn( ll_cols ) ).EntireColumn.AutoFit


//Column Headings
lole_OLE.cells[1,1] = "Due Date"
lole_OLE.cells[1,2] = "Customer Name"
lole_OLE.cells[1,3] = "Job Number"
lole_OLE.cells[1,4] = "Job Weight"
lole_OLE.cells[1,5] = "Job Status"
lole_OLE.cells[1,6] = "Line"

//Insert Lines for Header & Miscellaneous Details (2 lines above columnar data)
lole_Sheet.Range("A1:N2").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,1] = "ABCo Backlog Report"
lole_Sheet.Range("A1:A1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

select sum(ab_job.job_process_quantity)
into		:ll_total_wt
from     ab_job
         join customer_order on customer_order.order_abc_num = ab_job.order_abc_num
         join customer on customer.customer_id = customer_order.orig_customer_id
         join ab_job_status_desc on ab_job_status_desc.ab_job_status_code = ab_job.job_status
         left outer join production_sheet_item on ab_job.ab_job_num = production_sheet_item.ab_job_num
where    ab_job.job_status = 2
and      ab_job.job_process_quantity is not null
and      production_sheet_item.prod_item_net_wt is null
and      ab_job.due_date <= sysdate
using		sqlca;

lole_OLE.cells[2,1] = "Total Job Weight: " + String(ll_total_wt)
lole_Sheet.Range("A2:A2").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[1,5] = String(Today())
lole_Sheet.Range("E1:E1").Select
lole_OLE.Selection.Font.Bold = True




//----------------------------------------------------------------------------------------------------

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

////Delete extra columns	
//lole_Sheet.Columns("O:T").Select
//lole_OLE.Selection.Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:F" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

//lole_Sheet.Range("F4:F" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.HorizontalAlignment = -4131 //Right justify

//lole_Sheet.Range("G4:H" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//
//lole_Sheet.Range("I4:K" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify
//
//lole_Sheet.Range("L4:L" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

////Change date format for a column
//lole_Sheet.Range("C9:C" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.NumberFormat = "mm/dd/yyyy"

//Change number format for a column
//lole_Sheet.Range("H9:I" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.NumberFormat = "###,###,###.###"

//lole_Sheet.Range("E9:E" + String(ll_report_rows + 9)).Select
//lole_OLE.Selection.NumberFormat = "###,###,###.00"

//Underline column headers
lole_Sheet.Range("A9:L9").Select
lole_OLE.Selection.Font.Underline = True

////Underline the 3 totals columns
//lole_OLE.Application.range ("E" + String(ll_report_rows + 9) + ":G" + String(ll_report_rows + 9)).borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.ColumnWidth = 18.3

lole_Sheet.Range("B4:B4").Select
lole_OLE.Selection.ColumnWidth = 21.1

lole_Sheet.Range("C4:C4").Select
lole_OLE.Selection.ColumnWidth = 21.1

lole_Sheet.Range("D4:D4").Select
lole_OLE.Selection.ColumnWidth = 21.1

lole_Sheet.Range("E4:E4").Select
lole_OLE.Selection.ColumnWidth = 18.3

//---

//ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")
ls_folder = is_email_folder

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "ABCo Backlog Report" + "_" + ls_today + ls_now + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

as_file_out = ls_file
lole_sheet.SaveAs(as_file_out, Excel8!)
	
lole_OLE.DisconnectObject()
DESTROY lole_OLE
//Alex Gerlants. 05/02/2016. End
end subroutine

public function integer wf_qr_flaw_report (string as_email_addresses[], string as_customer_name);//Alex Gerlants. 1112_qr_flaw_report. 11/04/2021. Begin
/*
Function:	wf_qr_flaw_report
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]	
				value	string	as_customer_name
*/

Integer					li_rtn = 1, li_rtn_rowscopy
Boolean					lb_rtn, lb_rtn_rowscopy
DataStore				lds_qr_flaw_report
Date						ld_from
DateTime					ldt_date_from, ldt_date_to
String					ls_run_message
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_i, ll_row_inserted
w_inventory_reports	lw_inventory_reports
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report

ls_run_message = "qr_flaw_report Report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lds_qr_flaw_report) Then Destroy lds_qr_flaw_report
lds_qr_flaw_report = Create DataStore
lds_qr_flaw_report.DataObject = "d_qr_flaw_report"
lds_qr_flaw_report.SetTransObject(sqlca)

ld_from = RelativeDate(Today(), -1) //Previous day

//ld_from = Date("10/29/2021") //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ldt_date_from = DateTime(ld_from, Time("0:00:00"))
ldt_date_to = DateTime(ld_from, Time("23:59:59"))

//ll_rows = lds_qr_flaw_report.Retrieve(ldt_date_from, ldt_date_to)

dw_qr_flaw_report.SetTransObject(sqlca)
ll_rows = dw_qr_flaw_report.Retrieve(as_customer_name, ldt_date_from, ldt_date_to)

//If ll_rows > 0 Then //Do not send email if there is nothing to report
//li_rtn_rowscopy = lds_qr_flaw_report.RowsCopy(1, lds_qr_flaw_report.RowCount(), Primary!, dw_qr_flaw_report, 1, Primary!)
//ll_rows = dw_qr_flaw_report.RowCount()

If ll_rows <= 0 Then //Nothing to report
	ll_row_inserted = dw_qr_flaw_report.InsertRow(0)
	
	If ll_row_inserted > 0 Then
		dw_qr_flaw_report.Object.ind[ll_row_inserted] = 0
		dw_qr_flaw_report.Object.no_data_message[ll_row_inserted] = "No data retrieved. Nothing to report."
	End If
End If

wf_exporttoexcel_qr_flaw( dw_qr_flaw_report, dw_qr_flaw_report.RowCount(), ls_file, as_customer_name, String(ld_from) )
	
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

If li_rtn = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_run_message = "qr_flaw_report report saved in " + ls_file + ". Starting qr_flaw_report report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)

	ls_file_name_2email[1] = ls_file
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	If ll_rows <= 0 Then //Nothing to report
		ls_body = "Please find attached qr_flaw_report report for " + String(ld_from) + "~n~rNo data retrieved. Nothing to report."
	Else //There are data to report
		ls_body = "Please find attached qr_flaw_report report for " + String(ld_from)
	End If
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_qr_flaw_report(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next

	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]

	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

Return li_rtn
//Alex Gerlants. 1112_qr_flaw_report. 11/04/2021. End
end function

public subroutine wf_exporttoexcel_qr_flaw (datawindow adw_dw, long al_rows, ref string as_file_out, string as_customer_name, string as_select_date);//Alex Gerlants. 1112_qr_flaw_report. 11/04/2021. Begin
/*
Function:	wf_exporttoexcel_qr_flaw
Returns:		none
Arguments:	value			datawindow	adw_dw
				value			long			al_rows	
				reference	string		as_file_out
				value			string		as_customer_name
				value			string		as_select_date <== Date the data are selected for
*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_Columns[]
Long 			ll_report_rows, ll_Row, ll_Col, ll_Cols, ll_total_wt
String		ls_range 
String		ls_sum_processed, ls_sum_scrap_net
String		ls_sum_net_wt, ls_sum_tare_wt, ls_sum_theo_wt
Boolean		lb_rtn, lb_directoryexists

String 		ls_file, ls_today, ls_now, ls_folder, ls_run_date
Date 			ld_today
Time 			ld_now
Integer		li_answer
String		ls_no_data_message

ls_no_data_message = adw_dw.Object.no_data_message[1]

//Return //Disable this function for now ...

uo_save_as_excel	luo_save_as_excel

luo_save_as_excel = Create uo_save_as_excel

ll_report_rows = adw_dw.RowCount()

If ll_report_rows <= 0 Then Return

//ls_run_date = is_run_date_t

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

luo_save_as_excel.GetColumns( adw_DW, ls_Columns )

ll_Cols = UpperBound( ls_Columns )

FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		luo_save_as_excel.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( luo_save_as_excel.inttocolumn( 1 ) + "1:" + luo_save_as_excel.inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( luo_save_as_excel.inttocolumn( 1 ) + ":" + luo_save_as_excel.inttocolumn( ll_cols ) ).EntireColumn.AutoFit

If ls_no_data_message = "No data retrieved. Nothing to report." Then
	lole_OLE.cells[3,1] = "No data retrieved. Nothing to report."
	
	lole_Sheet.Range("A3:A3").Select
	lole_OLE.Selection.Font.Bold = True
	lole_OLE.Selection.Font.Size = 12 //Change font size
Else
	//Column Headings
	lole_OLE.cells[1,1] = "Coil Abc Num"
	lole_OLE.cells[1,2] = "Cust_Coil Num"
	lole_OLE.cells[1,3] = "Starting Position"
	lole_OLE.cells[1,4] = "Ending Position"
	lole_OLE.cells[1,5] = "Flaw Description"
	lole_OLE.cells[1,6] = "Starting Position Uom"
	lole_OLE.cells[1,7] = "Ending Position Uom"
	lole_OLE.cells[1,8] = "Flaw Handling"
	lole_OLE.cells[1,9] = "Date Received"
	lole_OLE.cells[1,10] = "Sampling Required"
End If

//Insert Lines for Header & Miscellaneous Details (2 lines above columnar data)
lole_Sheet.Range("A1:N2").Select
lole_Sheet.Application.Selection.EntireRow.Insert 

lole_OLE.cells[1,1] = "QR Flaw Report. " + as_customer_name + ". " + as_select_date
lole_Sheet.Range("A1:A1").Select
lole_OLE.Selection.Font.Bold = True
lole_OLE.Selection.Font.Size = 24 //Change font size
lole_OLE.Selection.Font.Underline = True

lole_OLE.cells[1,7] = "Run Date: " + String(Today())
lole_Sheet.Range("G1:G1").Select
lole_OLE.Selection.Font.Bold = True

//----------------------------------------------------------------------------------------------------

SetPointer(HourGlass!)
ld_today = Today()
ld_now = Now()
ls_today = String(ld_today,"yymmdd")
ls_now = String(ld_now,"hhmmss")

////Delete extra columns	
lole_Sheet.Columns("K:L").Select
lole_OLE.Selection.Delete

//Justify
//lole_OLE.Selection.HorizontalAlignment = -4108 //Center
//lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify
//lole_OLE.Selection.HorizontalAlignment = -4152 //Right justify

lole_Sheet.Range("A4:F" + String(ll_report_rows + 9)).Select
lole_OLE.Selection.HorizontalAlignment = -4131 //Left justify

//Underline column headers
lole_Sheet.Range("A9:L9").Select
lole_OLE.Selection.Font.Underline = True

////Underline the 3 totals columns
//lole_OLE.Application.range ("E" + String(ll_report_rows + 9) + ":G" + String(ll_report_rows + 9)).borders(4).LineStyle = 1

//Increase column width
lole_Sheet.Range("A4:A4").Select
lole_OLE.Selection.ColumnWidth = 18.3

lole_Sheet.Range("B4:B4").Select
lole_OLE.Selection.ColumnWidth = 35.4

lole_Sheet.Range("C4:C4").Select
lole_OLE.Selection.ColumnWidth = 21.1

lole_Sheet.Range("D4:D4").Select
lole_OLE.Selection.ColumnWidth = 21.1

lole_Sheet.Range("E4:E4").Select
lole_OLE.Selection.ColumnWidth = 18.3

////Delete extra columns	
//lole_Sheet.Columns("O:T").Select
//lole_OLE.Selection.Delete

If ls_no_data_message = "No data retrieved. Nothing to report." Then
	lole_Sheet.Rows("2:2").Select
	//lole_OLE.Selection.Delete Shift:=xlUp
	lole_OLE.Selection.Delete
	
	lole_Sheet.Rows("2:2").Select
	lole_OLE.Selection.Delete
End If

//---

//ls_folder = ProfileString(gs_ini_file, "EMAIL","email_out","c:\temp\")
ls_folder = is_email_folder

If Right(ls_folder, 1) <> "\" Then ls_folder = ls_folder + "\"
ls_file = ls_folder + "QR Flaw Report" + "_" + ls_today + ls_now + ".xls"

//Check if ls_folder exists.
lb_directoryexists = DirectoryExists(ls_folder)

If Not lb_directoryexists Then //Folder ls_folder doesn't exist
	CreateDirectory(ls_folder) //Create ls_folder
End If

as_file_out = ls_file
lole_sheet.SaveAs(as_file_out, Excel8!)
	
lole_OLE.DisconnectObject()
DESTROY lole_OLE
//Alex Gerlants. 1112_qr_flaw_report. 11/04/2021. End
end subroutine

protected function integer wf_const_bg_coil_report (string as_email_addresses[], long al_customer_ids[]);//Alex Gerlants. 1426_Constellium Recvd Report. 01/18/2022. Begin
/*
Function:	wf_const_bg_coil_report
				This report has to run on Monday.
				The data are from the first day of the previous month to the last day of the previous month.
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]	
				value	long		al_customer_ids[]
*/

Integer					li_rtn = 1, li_rtn_entry_date = 1
Integer					li_i
Boolean					lb_rtn, lb_leap_year_2select
Date						ld_today, ld_date_from, ld_date_to
DateTime					ldt_from, ldt_to
Time						lt_time_from = Time("00:00:00"), lt_time_to = Time("23:59:59")
String					ls_customer_id, ls_customer_ids
String					ls_sql, ls_sql_new
String					ls_file_name_2email[], ls_file, ls_file_coil_received, ls_body, ls_email_address
String					ls_date_from, ls_date_to, ls_run_message, ls_add_2sql, ls_add_2sql_processed
Long						ll_rows, ll_rows_entry_date, ll_row, ll_i
w_inventory_reports	lw_inventory_reports
DataStore				lds_const_bg_coil_processed_wt, lds_const_bg_coil_entry_date
str_all_data_types	lstr_all_data_types
String					ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
String					ls_customer_id_string, ls_left_part, ls_right_part
String					ls_sql_orig_coil_processed, ls_sql_orig_coil_entry_date
String					ls_sql_new_coil_processed, ls_sql_new_coil_entry_date, ls_today, ls_month, ls_day, ls_year, ls_year_from
Long						ll_customer_id, ll_pos

ls_run_message = "Constellium Recvd Report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lds_const_bg_coil_processed_wt) Then Destroy lds_const_bg_coil_processed_wt
lds_const_bg_coil_processed_wt = Create DataStore
lds_const_bg_coil_processed_wt.DataObject = "d_const_bg_coil_processed_wt"
lds_const_bg_coil_processed_wt.SetTransObject(sqlca)

If IsValid(lds_const_bg_coil_entry_date) Then Destroy lds_const_bg_coil_entry_date
lds_const_bg_coil_entry_date = Create DataStore
lds_const_bg_coil_entry_date.DataObject = "d_const_bg_coil_entry_date"
lds_const_bg_coil_entry_date.SetTransObject(sqlca)

ls_sql_orig_coil_processed = lds_const_bg_coil_processed_wt.GetSqlSelect()
ls_sql_orig_coil_entry_date = lds_const_bg_coil_entry_date.GetSqlSelect()

ll_pos = Pos(ls_sql_orig_coil_processed, "group by", 1)

If ll_pos > 0 Then
	ls_left_part = Left(ls_sql_orig_coil_processed, ll_pos - 1)
	ls_right_part = Right(ls_sql_orig_coil_processed, Len(ls_sql_orig_coil_processed) - ll_pos + 1)
End If

For li_i = 1 To UpperBound(al_customer_ids[])
	ll_customer_id = al_customer_ids[li_i]
	ls_customer_id_string = ls_customer_id_string + String(ll_customer_id) + ","
Next

//Remove the last comma
ls_customer_id_string = Left(ls_customer_id_string, Len(ls_customer_id_string) - 1)

//Get first and last day of the previous month
//Get same date of the previuos year
ls_today = String(Today(), "mm/dd/yyyy")
ls_month = Left(ls_today, 2)
ls_day = Mid(ls_today, 4, 2)
ls_year = Right(ls_today, 4)
ls_year_from = String(Integer(ls_year) - 1)
ls_date_from = ls_month + "/" + "01" + "/" + ls_year_from

lstr_all_data_types = f_get_last_month_begin_end_dates()
//ls_date_from = lstr_all_data_types.string_var[1]
ls_date_to = lstr_all_data_types.string_var[2]

ldt_from = DateTime(Date(ls_date_from), Time("00:00:00"))
ldt_to = DateTime(Date(ls_date_to), Time("23:59:59"))

ls_add_2sql = " where coil.customer_id in (" + ls_customer_id_string + ")" + " and coil.coil_entry_date between " + "to_date('" + String(ldt_from) + "', 'mm/dd/yyyy hh24:mi:ss')" + " and to_date('" + String(ldt_to) + "', 'mm/dd/yyyy hh24:mi:ss')"
ls_add_2sql_processed = " where coil.customer_id in (" + ls_customer_id_string + ")" + " and production_sheet_item.prod_item_date between " + "to_date('" + String(ldt_from) + "', 'mm/dd/yyyy hh24:mi:ss')" + " and to_date('" + String(ldt_to) + "', 'mm/dd/yyyy hh24:mi:ss')"

ls_sql_new_coil_processed = ls_left_part + " " + ls_add_2sql_processed + " " + ls_right_part + " order by to_date(to_char(production_sheet_item.prod_item_date, 'mm/dd/yyyy'), 'mm/dd/yyyy') desc, coil.coil_org_num"
ls_sql_new_coil_entry_date = ls_sql_orig_coil_entry_date +  ls_add_2sql + " order by to_date(to_char(coil.coil_entry_date, 'mm/dd/yyyy'), 'mm/dd/yyyy') desc, coil.coil_org_num"

lds_const_bg_coil_processed_wt.SetSqlSelect(ls_sql_new_coil_processed)
lds_const_bg_coil_entry_date.SetSqlSelect(ls_sql_new_coil_entry_date)

ll_rows = lds_const_bg_coil_processed_wt.Retrieve(ldt_from, ldt_to)

If ll_rows < 0 Then
	ls_run_message = "Retrieve DB error in function wf_const_bg_coil_report for w_run_report while retrieving lds_const_bg_coil_processed_wt. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

ll_rows_entry_date = lds_const_bg_coil_entry_date.Retrieve(ldt_from, ldt_to)

If ll_rows_entry_date < 0 Then
	ls_run_message = "Retrieve DB error in function wf_const_bg_coil_report for w_run_report while retrieving lds_const_bg_coil_entry_date. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Const_Proc_Wt_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"
ls_file_coil_received = is_email_folder + "Const_Recv_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"

//lds_const_bg_coil_processed_wt.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rtn = lds_const_bg_coil_processed_wt.SaveAs(ls_file, Excel!, True) //"True" is to include headings
li_rtn_entry_date = lds_const_bg_coil_entry_date.SaveAs(ls_file_coil_received, Excel!, True) //"True" is to include headings

If li_rtn = 1 And li_rtn_entry_date = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	f_excel_open_xls_saveas_xlsx(ls_file_coil_received, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file_coil_received = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_run_message = "Constellium Coil Wt Report saved in " + ls_file + ". Starting Constellium Coil Recvd Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	
	ls_run_message = "Constellium Coil Recvd Report saved in " + ls_file_coil_received + ". Starting Constellium Coil Recvd Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
		
	ls_file_name_2email[1] = ls_file
	ls_file_name_2email[2] = ls_file_coil_received
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	ls_body = "Please find attached Constellium Coil Reports for date period between " + ls_date_from + " and " + ls_date_to
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_const_coil_report(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " and " + ls_file_coil_received + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " and " + ls_file_coil_received + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next
	
	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]
	
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

If IsValid(lds_const_bg_coil_processed_wt) Then Destroy lds_const_bg_coil_processed_wt
If IsValid(lds_const_bg_coil_entry_date) Then Destroy lds_const_bg_coil_entry_date

Return li_rtn
//Alex Gerlants. 1426_Constellium Recvd Report. 01/18/2022. End
end function

public function integer wf_arconic_mtd_report (string as_email_addresses[], long al_customer_ids[]);//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. Begin
/*
Function:	wf_arconic_mtd_report
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]
				value	long		al_customer_ids[]
*/

Integer					li_rtn = 1, li_rtn_rowscopy
Boolean					lb_rtn, lb_rtn_rowscopy
DataStore				lds_arconic_mtd_report
Date						ld_from
DateTime					ldt_date_from, ldt_date_to
String					ls_run_message, ls_today, ls_month, ls_year, ls_from, ls_to
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_i, ll_row_inserted, ll_customer_id
w_inventory_reports	lw_inventory_reports
String					ls_file_xlsx, ls_customer_id_string, ls_add_2sql, ls_sql_orig, ls_sql_new

ls_run_message = "Arconic MTD Report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

If IsValid(lds_arconic_mtd_report) Then Destroy lds_arconic_mtd_report
lds_arconic_mtd_report = Create DataStore
lds_arconic_mtd_report.DataObject = "d_arconic_mtd_report"

ls_today = String(Today(), "mm/dd/yyyy")
ls_month = Left(ls_today, 2)
ls_year = Right(ls_today, 4)
ls_from = ls_month + "/" + "01" + "/" + ls_year
//ldt_date_from = DateTime(Date(ls_from), Time("00:00:00"))

ls_to = ls_today
//ldt_date_to = DateTime(Today(), Now())

For ll_i = 1 To UpperBound(al_customer_ids[])
	ll_customer_id = al_customer_ids[ll_i]
	ls_customer_id_string = ls_customer_id_string + String(ll_customer_id) + ","
Next

//Remove the last comma
ls_customer_id_string = Left(ls_customer_id_string, Len(ls_customer_id_string) - 1)

ls_add_2sql = " where customer_order.orig_customer_id in (" + ls_customer_id_string + ")"
ls_add_2sql = ls_add_2sql + " and (ab_job.time_date_finished between to_date('" + ls_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss')" + " and to_date('" + ls_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss')" + ")"
ls_add_2sql = ls_add_2sql + " order by customer.customer_short_name, ab_job.ab_job_num desc" 

ls_sql_orig = lds_arconic_mtd_report.GetSqlSelect()
ls_sql_new = ls_sql_orig + ls_add_2sql
li_rtn = lds_arconic_mtd_report.SetSqlSelect(ls_sql_new)
ls_sql_new = lds_arconic_mtd_report.GetSqlSelect()

If IsNull(li_rtn) Then li_rtn = -1
		
If li_rtn = -1 Then
	ls_run_message = "Error mofifying SQL in wf_arconic_mtd_report for w_run_report (lds_arconic_mtd_report.SetSqlSelect(ls_sql_new)). Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

/*
where    customer_order.orig_customer_id in (1027, 50, 2784) 
and      ab_job.time_date_finished between :adt_from and :adt_to
order by customer.customer_short_name, ab_job.ab_job_num desc
*/

lds_arconic_mtd_report.SetTransObject(sqlca)
ll_rows = lds_arconic_mtd_report.Retrieve()

If ll_rows > 0 Then
	wf_update_processed_wt_4arconic(lds_arconic_mtd_report)
	wf_insert_customer_wt_4arconic(lds_arconic_mtd_report)
End If

If ll_rows < 0 Then
	ls_run_message = "DB error in function wf_arconic_mtd_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Arconic_MTD_Report" + ".xls"
li_rtn = lds_arconic_mtd_report.SaveAs(ls_file, Excel!, True) //"True" is to include headings

//ld_from = RelativeDate(Today(), -1) //Previous day

//ld_from = Date("10/29/2021") //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

//ldt_date_from = DateTime(ld_from, Time("0:00:00"))
//ldt_date_to = DateTime(ld_from, Time("23:59:59"))

//ll_rows = lds_arconic_mtd_report.Retrieve(ldt_date_from, ldt_date_to)

//dw_qr_flaw_report.SetTransObject(sqlca)
//ll_rows = dw_qr_flaw_report.Retrieve(as_customer_name, ldt_date_from, ldt_date_to)

//If ll_rows > 0 Then //Do not send email if there is nothing to report
//li_rtn_rowscopy = lds_arconic_mtd_report.RowsCopy(1, lds_arconic_mtd_report.RowCount(), Primary!, dw_qr_flaw_report, 1, Primary!)
//ll_rows = dw_qr_flaw_report.RowCount()

//If ll_rows <= 0 Then //Nothing to report
//	ll_row_inserted = dw_qr_flaw_report.InsertRow(0)
//	
//	If ll_row_inserted > 0 Then
//		dw_qr_flaw_report.Object.ind[ll_row_inserted] = 0
//		dw_qr_flaw_report.Object.no_data_message[ll_row_inserted] = "No data retrieved. Nothing to report."
//	End If
//End If

//wf_exporttoexcel_qr_flaw( dw_qr_flaw_report, dw_qr_flaw_report.RowCount(), ls_file, as_customer_name, String(ld_from) )
//	
//If Right(is_email_folder, 1) <> "\" Then
//	is_email_folder = is_email_folder + "\"
//End If

If li_rtn = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_run_message = "Arconic MTD Report saved in " + ls_file + ". Starting Arconic MTD Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)

	ls_file_name_2email[1] = ls_file
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	If ll_rows <= 0 Then //Nothing to report
		ls_body = "Please find attached Arconic MTD Report for " + String(ld_from) + "~n~rNo data retrieved. Nothing to report."
	Else //There are data to report
		ls_body = "Please find attached Arconic MTD Report for date period between " + ls_from + " 00:00:00" + " and " + ls_to + " 23:59:59"
	End If
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_arconic_mtd_report(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next

	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]

	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

If IsValid(lds_arconic_mtd_report) Then Destroy lds_arconic_mtd_report

Return li_rtn
//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. End
end function

public function integer wf_arconic_mtd_report_dw (string as_email_addresses[], long al_customer_ids[]);//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. Begin
/*
Function:	wf_arconic_mtd_report_dw
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	string	as_email_addresses[]
				value	long		al_customer_ids[]
*/

Integer					li_rtn = 1, li_rtn_rowscopy
Boolean					lb_rtn, lb_rtn_rowscopy
//DataStore				dw_arconic_mtd_report
Date						ld_from
DateTime					ldt_date_from, ldt_date_to
String					ls_run_message, ls_today, ls_month, ls_year, ls_from, ls_to
String					ls_file_name_2email[], ls_file, ls_body, ls_email_address
Time						lt_time_from, lt_time_to
Long						ll_rows, ll_i, ll_row_inserted, ll_customer_id
w_inventory_reports	lw_inventory_reports
String					ls_file_xlsx, ls_customer_id_string, ls_add_2sql, ls_sql_orig, ls_sql_new

ls_run_message = "Arconic MTD Report run started."
li_rtn = wf_insert_auto_run_log(ls_run_message)

//If IsValid(dw_arconic_mtd_report) Then Destroy dw_arconic_mtd_report
//dw_arconic_mtd_report = Create DataStore
//dw_arconic_mtd_report.DataObject = "d_arconic_mtd_report"

ls_today = String(Today(), "mm/dd/yyyy")
ls_month = Left(ls_today, 2)
ls_year = Right(ls_today, 4)
ls_from = ls_month + "/" + "01" + "/" + ls_year
//ldt_date_from = DateTime(Date(ls_from), Time("00:00:00"))

ls_to = ls_today
//ldt_date_to = DateTime(Today(), Now())

For ll_i = 1 To UpperBound(al_customer_ids[])
	ll_customer_id = al_customer_ids[ll_i]
	ls_customer_id_string = ls_customer_id_string + String(ll_customer_id) + ","
Next

//Remove the last comma
ls_customer_id_string = Left(ls_customer_id_string, Len(ls_customer_id_string) - 1)

ls_add_2sql = " where customer_order.orig_customer_id in (" + ls_customer_id_string + ")"
ls_add_2sql = ls_add_2sql + " and (ab_job.time_date_finished between to_date('" + ls_from + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss')" + " and to_date('" + ls_to + " 23:59:59', 'mm/dd/yyyy hh24:mi:ss')" + ")"
ls_add_2sql = ls_add_2sql + " order by customer.customer_short_name, ab_job.ab_job_num desc" 

ls_sql_orig = dw_arconic_mtd_report.GetSqlSelect()
ls_sql_new = ls_sql_orig + ls_add_2sql
li_rtn = dw_arconic_mtd_report.SetSqlSelect(ls_sql_new)
ls_sql_new = dw_arconic_mtd_report.GetSqlSelect()

If IsNull(li_rtn) Then li_rtn = -1
		
If li_rtn = -1 Then
	ls_run_message = "Error mofifying SQL in wf_arconic_mtd_report for w_run_report (dw_arconic_mtd_report.SetSqlSelect(ls_sql_new)). Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

/*
where    customer_order.orig_customer_id in (1027, 50, 2784) 
and      ab_job.time_date_finished between :adt_from and :adt_to
order by customer.customer_short_name, ab_job.ab_job_num desc
*/

dw_arconic_mtd_report.SetTransObject(sqlca)
ll_rows = dw_arconic_mtd_report.Retrieve()

If ll_rows < 0 Then
	ls_run_message = "DB error in function wf_arconic_mtd_report. Cannot run ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)
	Return -1
End If

//ll_rows >= 0 at this point...Good
If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

ls_file = is_email_folder + "Arconic_MTD_Report" + ".xls"
li_rtn = dw_arconic_mtd_report.SaveAs(ls_file, Excel!, True) //"True" is to include headings

//ld_from = RelativeDate(Today(), -1) //Previous day

//ld_from = Date("10/29/2021") //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

//ldt_date_from = DateTime(ld_from, Time("0:00:00"))
//ldt_date_to = DateTime(ld_from, Time("23:59:59"))

//ll_rows = dw_arconic_mtd_report.Retrieve(ldt_date_from, ldt_date_to)

//dw_qr_flaw_report.SetTransObject(sqlca)
//ll_rows = dw_qr_flaw_report.Retrieve(as_customer_name, ldt_date_from, ldt_date_to)

//If ll_rows > 0 Then //Do not send email if there is nothing to report
//li_rtn_rowscopy = dw_arconic_mtd_report.RowsCopy(1, dw_arconic_mtd_report.RowCount(), Primary!, dw_qr_flaw_report, 1, Primary!)
//ll_rows = dw_qr_flaw_report.RowCount()

//If ll_rows <= 0 Then //Nothing to report
//	ll_row_inserted = dw_qr_flaw_report.InsertRow(0)
//	
//	If ll_row_inserted > 0 Then
//		dw_qr_flaw_report.Object.ind[ll_row_inserted] = 0
//		dw_qr_flaw_report.Object.no_data_message[ll_row_inserted] = "No data retrieved. Nothing to report."
//	End If
//End If

//wf_exporttoexcel_qr_flaw( dw_qr_flaw_report, dw_qr_flaw_report.RowCount(), ls_file, as_customer_name, String(ld_from) )
//	
//If Right(is_email_folder, 1) <> "\" Then
//	is_email_folder = is_email_folder + "\"
//End If

If li_rtn = 1 Then
	f_excel_open_xls_saveas_xlsx(ls_file, ls_file_xlsx) //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	ls_file = ls_file_xlsx //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
	
	ls_run_message = "Arconic MTD Report saved in " + ls_file + ". Starting Arconic MTD Report email ..."
	li_rtn = wf_insert_auto_run_log(ls_run_message)

	ls_file_name_2email[1] = ls_file
	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
	Open(lw_inventory_reports)
	
	If ll_rows <= 0 Then //Nothing to report
		ls_body = "Please find attached Arconic MTD Report for " + String(ld_from) + "~n~rNo data retrieved. Nothing to report."
	Else //There are data to report
		ls_body = "Please find attached Arconic MTD Report for " + String(ld_from)
	End If
	
	For ll_i = 1 To UpperBound(as_email_addresses[])
		ls_email_address = as_email_addresses[ll_i]
		
		lb_rtn = lw_inventory_reports.wf_send_smtp_email_qr_flaw_report(ls_body, ls_file_name_2email[], ls_email_address)
		
		If lb_rtn Then
			ls_run_message = ls_file + " successfully emailed to " + ls_email_address
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		Else
			ls_run_message = ls_file + " email to " + ls_email_address + " failed."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
		End If
	Next

	lw_inventory_reports.wf_move_files(ls_file_name_2email[]) //Archive ls_file_name_2email[]

	If IsValid(lw_inventory_reports) Then Close(lw_inventory_reports)
End If

//If IsValid(dw_arconic_mtd_report) Then Destroy dw_arconic_mtd_report

Return li_rtn
//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. End
end function

public subroutine wf_update_processed_wt_4arconic (ref datastore ads);//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. Begin
/*
Function:	wf_update_processed_wt_4arconic
Returns:		none
Arguments:	reference	datastore	ads
*/


Long 		ll_row, ll_c
Long 		ll_job, ll_coil, ll_pwt, ll_status
Long 		ll_wt, ll_wt1, ll_wt2, ll_shift_end_wt

ll_row = ads.RowCount()

IF ll_row > 0 THEN
	FOR ll_c = 1 TO ll_row
		ll_job = ads.GetItemNumber(ll_c, "abco_job_num")
		ll_coil = ads.GetItemNumber(ll_c, "abco_coil_num")
		
		SELECT process_quantity, process_end_wt, process_coil_status INTO :ll_wt, :ll_shift_end_wt, :ll_status
		FROM process_coil
		WHERE (coil_abc_num = :ll_coil) AND (ab_job_num = :ll_job)
		USING SQLCA;
		IF IsNULL(ll_wt) THEN ll_wt = 0

		IF IsNULL(ll_shift_end_wt) THEN
			SELECT net_wt_balance INTO :ll_wt1
			FROM coil
			WHERE coil_abc_num = :ll_coil
			USING SQLCA;
			IF ISNULL(ll_wt1) THEN ll_wt1 = 0
		ELSE
			ll_wt1 = ll_shift_end_wt
		END IF

		SELECT MAX(process_quantity) INTO :ll_wt2
		FROM process_coil
		WHERE (coil_abc_num = :ll_coil) AND (process_quantity < :ll_wt)
		USING SQLCA;
		IF IsNULL(ll_wt2) THEN ll_wt2 = 0

		ll_pwt = ll_wt - MAX(ll_wt1, ll_wt2)
		
		IF ll_status = 2 THEN //new coil not being processed
			ads.SetItem(ll_c, "processed_weight", 0)
		ELSE //being processed
			ads.SetItem(ll_c, "processed_weight", ll_pwt)
		END IF
	NEXT
END IF
//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. End
end subroutine

public subroutine wf_insert_customer_wt_4arconic (ref datastore ads);//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. Begin
/*
Function:	wf_insert_customer_wt_4arconic
Returns:		none
Arguments:	reference	datastore	ads
*/


Long 		ll_row, ll_c, ll_processed_weight, ll_recovered_weight
Long 		ll_job, ll_coil, ll_pwt, ll_status
Long 		ll_wt, ll_wt1, ll_wt2, ll_shift_end_wt, ll_ontime
Long		ll_row_inserted
LongLong	ll_total_wt_4customer, ll_total_recovered_wt_4customer
String	ls_customer_name, ls_customer_name_prev


ll_row = ads.RowCount()

If ll_row > 0 THEN
	ls_customer_name_prev = ads.GetItemString(1, "customer_name") //Intialize customer total process weight
	
	FOR ll_c = 1 TO ll_row
		ls_customer_name = ads.GetItemString(ll_c, "customer_name")

		If ls_customer_name_prev <> ls_customer_name Then
			ll_row_inserted = ads.InsertRow(ll_c)
			
			If ll_row_inserted > 0 Then
				ads.Object.part_program_name[ll_row_inserted] = "Total Weights for customer " + ls_customer_name_prev
				ads.Object.processed_weight[ll_row_inserted] = ll_total_wt_4customer
				ads.Object.recovered_weight[ll_row_inserted] = ll_total_recovered_wt_4customer
				ll_total_wt_4customer = 0
				ll_total_recovered_wt_4customer = 0
				ll_c = ll_row_inserted + 1
			End If
		End If
		
		ll_processed_weight = ads.GetItemNumber(ll_c, "processed_weight")
		If IsNull(ll_processed_weight) Then ll_processed_weight = 0
		ll_total_wt_4customer = ll_total_wt_4customer + ll_processed_weight
		
		ll_recovered_weight = ads.GetItemNumber(ll_c, "recovered_weight")
		If IsNull(ll_recovered_weight) Then ll_recovered_weight = 0
		ll_total_recovered_wt_4customer = ll_total_recovered_wt_4customer + ll_recovered_weight
		
		ls_customer_name_prev = ls_customer_name
	NEXT
	
	//Last row
	ll_processed_weight = ads.GetItemNumber(ll_c, "processed_weight")
	If IsNull(ll_processed_weight) Then ll_processed_weight = 0
	ll_total_wt_4customer = ll_total_wt_4customer + ll_processed_weight
	
	ll_recovered_weight = ads.GetItemNumber(ll_c, "recovered_weight")
	If IsNull(ll_recovered_weight) Then ll_recovered_weight = 0
	ll_total_recovered_wt_4customer = ll_total_recovered_wt_4customer + ll_recovered_weight
	
	//Insert for last customer
	ll_row_inserted = ads.InsertRow(0) //Insert row at the end
			
	If ll_row_inserted > 0 Then
		ads.Object.part_program_name[ll_row_inserted] = "Total Weighst for customer " + ls_customer_name
		ads.Object.processed_weight[ll_row_inserted] = ll_total_wt_4customer
		ads.Object.recovered_weight[ll_row_inserted] = ll_total_recovered_wt_4customer
	End If
END IF
//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. End
end subroutine

on w_run_report.create
int iCurrent
call super::create
this.dw_arconic_mtd_report=create dw_arconic_mtd_report
this.dw_qr_flaw_report=create dw_qr_flaw_report
this.dw_abco_backlog_report=create dw_abco_backlog_report
this.dw_qr_report=create dw_qr_report
this.dw_coils_weight_zeroed_out=create dw_coils_weight_zeroed_out
this.dw_report_inv_cust_coils_863=create dw_report_inv_cust_coils_863
this.cb_coils_proc_manual_run=create cb_coils_proc_manual_run
this.dw_coils_processed=create dw_coils_processed
this.dw_auto_report_emails_error=create dw_auto_report_emails_error
this.cb_novelis_manual_run=create cb_novelis_manual_run
this.cb_start_stop_timer=create cb_start_stop_timer
this.dw_auto_report_emails=create dw_auto_report_emails
this.dw_auto_report_customers=create dw_auto_report_customers
this.dw_auto_report_schedule=create dw_auto_report_schedule
this.dw_report_auto_run_log=create dw_report_auto_run_log
this.st_timer_start_stop=create st_timer_start_stop
this.dw_edi_alert=create dw_edi_alert
this.cb_close=create cb_close
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_arconic_mtd_report
this.Control[iCurrent+2]=this.dw_qr_flaw_report
this.Control[iCurrent+3]=this.dw_abco_backlog_report
this.Control[iCurrent+4]=this.dw_qr_report
this.Control[iCurrent+5]=this.dw_coils_weight_zeroed_out
this.Control[iCurrent+6]=this.dw_report_inv_cust_coils_863
this.Control[iCurrent+7]=this.cb_coils_proc_manual_run
this.Control[iCurrent+8]=this.dw_coils_processed
this.Control[iCurrent+9]=this.dw_auto_report_emails_error
this.Control[iCurrent+10]=this.cb_novelis_manual_run
this.Control[iCurrent+11]=this.cb_start_stop_timer
this.Control[iCurrent+12]=this.dw_auto_report_emails
this.Control[iCurrent+13]=this.dw_auto_report_customers
this.Control[iCurrent+14]=this.dw_auto_report_schedule
this.Control[iCurrent+15]=this.dw_report_auto_run_log
this.Control[iCurrent+16]=this.st_timer_start_stop
this.Control[iCurrent+17]=this.dw_edi_alert
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.r_1
end on

on w_run_report.destroy
call super::destroy
destroy(this.dw_arconic_mtd_report)
destroy(this.dw_qr_flaw_report)
destroy(this.dw_abco_backlog_report)
destroy(this.dw_qr_report)
destroy(this.dw_coils_weight_zeroed_out)
destroy(this.dw_report_inv_cust_coils_863)
destroy(this.cb_coils_proc_manual_run)
destroy(this.dw_coils_processed)
destroy(this.dw_auto_report_emails_error)
destroy(this.cb_novelis_manual_run)
destroy(this.cb_start_stop_timer)
destroy(this.dw_auto_report_emails)
destroy(this.dw_auto_report_customers)
destroy(this.dw_auto_report_schedule)
destroy(this.dw_report_auto_run_log)
destroy(this.st_timer_start_stop)
destroy(this.dw_edi_alert)
destroy(this.cb_close)
destroy(this.r_1)
end on

event timer;call super::timer;Integer	li_rtn
Long		ll_i, ll_rows, ll_row, ll_customer_id
String	ls_now_hour, ls_now_hour_minute, ls_date, ls_day_name
String	ls_today, ls_now, ls_empty[]
String	ls_report_name, ls_run_message
String	ls_find_string, ls_customer_name, ls_email_address, ls_email_addresses[]
Long		ll_rows_customers, ll_row_customers, ll_rows_schedule, ll_row_schedule, ll_rows_emails, ll_row_emails
Long		ll_customer_ids[], ll_empty[]
Long		ll_found_row, ll_start_find

String	ls_day[], ls_month_name[], ls_month_name_today
Integer	li_month_today, li_i, li_day_num

Boolean	lb_last_day_of_month = False
Date		ld_tomorrow
Integer	li_month_tomorrow

li_month_today = Month(Today())

ld_tomorrow = RelativeDate(Today(), 1)
li_month_tomorrow = Month(ld_tomorrow)

If li_month_tomorrow > li_month_today Then
	lb_last_day_of_month = True					//This is in case if users want to run report on the last day of a month
End If

//---

ll_rows_schedule = dw_auto_report_schedule.RowCount()

If ll_rows_schedule <= 0 Then Return

ls_date = String(Today(), "mm/dd/yyyy")
ls_day_name = DayName(Date(ls_date))
li_day_num = Integer(Mid(ls_date, 4, 2))

ls_now_hour = Left(String(Now(), "hh:mm:ss"), 2)
ls_now_hour_minute = Left(String(Now(), "hh:mm:ss"), 5)

//This is to test aleris skid count shipment report monthly
//li_day_num = 1 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
//ls_now_hour_minute = "05:15" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

//This is to test aleris skid count shipment report weekly
//ls_day_name = "monday" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
//ls_now_hour_minute = "05:11" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ll_start_find = 1
ls_find_string = "(Lower(run_day_name) = '" + Lower(ls_day_name) + "' and run_time = '" + ls_now_hour_minute + "')" + " or (run_time = '" + ls_now_hour_minute + "' and run_day_num = '" + String(li_day_num) + "')"

If lb_last_day_of_month Then
	ls_find_string = ls_find_string +  + " or (run_time = '" + ls_now_hour_minute + "' and run_day_num = 'last_day')"
End If

//ls_find_string = "(Lower(run_day_name) = 'monday' and run_time = '10:00') or (run_time = '10:19' and run_day_num = '7')" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

dw_auto_report_schedule.SelectRow(0, False)

For ll_row_schedule = 1 To ll_rows_schedule
	
	If IsValid(w_inventory_reports) Then Close(w_inventory_reports)
	
	ll_customer_ids[] = ll_empty[]
	ls_email_addresses[] = ls_empty[]
	
	If ll_start_find > ll_rows_schedule Then
		dw_auto_report_schedule.SelectRow(0, False)
		Exit
	End If
	
	ll_found_row = dw_auto_report_schedule.Find(ls_find_string, ll_start_find, ll_rows_schedule)
	
	If ll_found_row <= 0 Then
		dw_auto_report_schedule.SelectRow(0, False)
		Exit
	End If
	
	If ll_found_row > 0 Then //Row found. Have to run report
	
		dw_auto_report_schedule.ScrollToRow(ll_found_row)
		dw_auto_report_schedule.SelectRow(0, False)
		dw_auto_report_schedule.SelectRow(ll_found_row, True)
	
		ll_start_find = ll_found_row + 1

		ls_report_name = dw_auto_report_schedule.Object.report_name[ll_found_row]
		If IsNull(ls_report_name) Then ls_report_name = ""
		
		If ls_report_name = "" Then
			ls_run_message = "Report name not populated. Cannot run ..."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
			Return
		End If

		ls_customer_name = dw_auto_report_schedule.Object.customer_name[ll_found_row]
		If IsNull(ls_customer_name) Then ls_customer_name = ""
		
		If ls_customer_name = "" Then
			ls_run_message = "Customer name not populated. Cannot run ..."
			li_rtn = wf_insert_auto_run_log(ls_run_message)
			Return
		End If

		wf_get_customer_ids(ls_customer_name, ll_customer_ids[])
		il_customer_ids[] = ll_customer_ids[] //Alex Gerlants. 05/26/2021. 1194_Change_Excel_Type_863_Report
		wf_get_email_addresses(ls_report_name, ls_customer_name, ls_email_addresses[])
		
		//wf_coils_processed_report(ls_report_name, ll_customer_ids[], ls_email_addresses[]) //TEST ONLY TEST ONLY TEST ONLY
		
		//ls_report_name = "coils inventory report_863" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
		
		Choose Case Lower(ls_report_name)
			Case "inventory report"
				If Lower(ls_customer_name) = "novelis" or Lower(ls_customer_name) = "alex" Then //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
				//If Lower(ls_customer_name) = "novelis" Then
					li_rtn = wf_auto_combined_4novelis(ls_report_name, ll_customer_ids[], ls_email_addresses[], ls_customer_name)
				Else //All other customers
					li_rtn = wf_auto_report_4others(ls_report_name, ll_customer_ids[], ls_email_addresses[])
				End If
			Case "coils processed report"
				wf_coils_processed_report(ls_report_name, ll_customer_ids[], ls_email_addresses[])
			Case "coils inventory report_863"
				wf_coil_inventory_report_863(ls_email_addresses[])
			Case "coils weight zeroed out report"
				wf_coils_weight_zeroed_out_report(ls_email_addresses[])
			Case "qr report"
				wf_qr_report(ls_email_addresses[])
			Case "aleris skid count shipment report monthly"	
				wf_aleris_skid_count_report_m(ls_email_addresses[], ll_customer_ids[])
			Case "aleris skid count shipment report weekly"	
				wf_aleris_skid_count_report_w(ls_email_addresses[], ll_customer_ids[])
			Case "onhold report"
				//ls_email_addresses[] = ls_empty[] //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
				//ls_email_addresses[1] = "agerlants@albl.com" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
				
				wf_onhold_status_updates_report(ls_email_addresses[])
			Case "onhold report monthly"	
				wf_onhold_status_updates_report_monthly(ls_email_addresses[])
			//Alex Gerlants. 02/06/2020.inv coils skids scrap skids report. Begin
			Case  "inv coils skids scrap skids report"
				wf_inv_coils_skids_scrap_skids(ls_email_addresses[])
			//Alex Gerlants. 02/06/2020.inv coils skids scrap skids report. End
			
			//Alex Gerlants. Aluminum_Content_Blank_Report. 03/12/2020. Begin
			Case "novelis aluminum content blank report"
				wf_aluminum_content_blank_report(ls_email_addresses[])
			//Alex Gerlants. Aluminum_Content_Blank_Report. 03/12/2020. End
			
			//Alex Gerlants. 1092_Alex_Recapped_Jobs_Without_870. 12/13/2021. Begin
			Case "recapped jobs without 870 report"
				wf_recapped_jobs_without_870_report(ls_email_addresses[])
			//Alex Gerlants. 1092_Alex_Recapped_Jobs_Without_870. 12/13/2021. End
			
			//Alex Gerlants. 1327_abco_backlog_report. 10/07/2021. Begin
			Case "abco_backlog_report"
				wf_abco_backlog_report(ls_email_addresses[])
			//Alex Gerlants. 1327_abco_backlog_report. 10/07/2021. End
			
			//Alex Gerlants. 1112_qr_flaw_report. 11/04/2021. Begin
			Case "qr_flaw_report"
				wf_qr_flaw_report(ls_email_addresses[], Upper(ls_customer_name))
			//Alex Gerlants. 1112_qr_flaw_report. 11/04/2021. End
			
			//Alex Gerlants. 1426_Constellium-BG Coil Received Report. 01/18/2022. Begin
			Case "constellium-bg coil received report"
				wf_const_bg_coil_report(ls_email_addresses[], ll_customer_ids[])
			//Alex Gerlants. 1426_Constellium-BG Coil Received Report. 01/18/2022. End
			
			//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. Begin
			Case "arconic mtd report"
				wf_arconic_mtd_report(ls_email_addresses[], ll_customer_ids[])
			//Alex Gerlants. 1458_Arconic_MTD_Report. 02/09/2022. End
		End Choose
	End If
Next

end event

event open;call super::open;Integer				li_rtn
Long					ll_rows, ll_row_inserted
Boolean				lb_enable_timer_button
DataWindowChild	ldwc

dw_report_auto_run_log.SetTransObject(sqlca)

dw_auto_report_schedule.SetTransObject(sqlca)
dw_auto_report_customers.SetTransObject(sqlca)
dw_auto_report_emails.SetTransObject(sqlca)
dw_auto_report_emails_error.SetTransObject(sqlca)
dw_coils_processed.SetTransObject(sqlca)

ll_rows = dw_auto_report_schedule.Retrieve()

If ll_rows <= 0 Then
	MessageBox("Report cannot run", 	"Auto report cannot run because schedule in table auto_report_schedule is not setup." + &
												"~n~rPlease contact abis support.")
End If

lb_enable_timer_button = Upper(ProfileString(gs_ini_file,"AUTO_INVENTORY_REPORT","enable_timer_button","n")) = "Y" //from lion.ini file

If lb_enable_timer_button Then
	cb_start_stop_timer.Enabled = True //In lion.ini, section = [AUTO_INVENTORY_REPORT], key = enable_timer_button = y
Else
	cb_start_stop_timer.Enabled = False //In lion.ini, section = [AUTO_INVENTORY_REPORT], key = enable_timer_button = n; or entry does not exist.
End If

il_timer_interval_seconds = Long(f_get_ini_value('auto_inventory_report', 'timer_control', 'timer_interval_seconds', '57'))


is_email_folder = f_get_ini_value("inventory_reports","smtp_email","email_folder","C:\temp\email\")

If Right(is_email_folder, 1) <> "\" Then
	is_email_folder = is_email_folder + "\"
End If

is_archive_folder = f_get_ini_value("inventory_reports","smtp_email","archive_folder","C:\temp\archive")

If Right(is_archive_folder, 1) <> "\" Then
	is_archive_folder = is_archive_folder + "\"
End If

//Alex_Auto_Start_Auto_Inventory_Report. 10/22/2018. Begin
If gs_auto_start_auto_report = "Y" Then
	cb_start_stop_timer.Event Clicked()
End If
//Alex_Auto_Start_Auto_Inventory_Report. 10/22/2018. End



end event

event pfc_postopen;call super::pfc_postopen;This.Width = 5000
This.Height = 1338
end event

type dw_arconic_mtd_report from datawindow within w_run_report
integer x = 5197
integer y = 1360
integer width = 549
integer height = 320
integer taborder = 90
string title = "none"
string dataobject = "d_arconic_mtd_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_qr_flaw_report from datawindow within w_run_report
integer x = 5197
integer y = 1235
integer width = 549
integer height = 112
integer taborder = 90
string title = "none"
string dataobject = "d_qr_flaw_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;Long		ll_sqldbcode
String	ls_sqlerrtext

ll_sqldbcode = sqldbcode
ls_sqlerrtext = sqlerrtext
end event

type dw_abco_backlog_report from datawindow within w_run_report
integer x = 5197
integer y = 1107
integer width = 549
integer height = 109
integer taborder = 80
string title = "none"
string dataobject = "d_abco_backlog_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_qr_report from datawindow within w_run_report
integer x = 5186
integer y = 906
integer width = 1119
integer height = 176
integer taborder = 90
string title = "none"
string dataobject = "d_qr_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_coils_weight_zeroed_out from datawindow within w_run_report
integer x = 5186
integer y = 723
integer width = 1119
integer height = 176
integer taborder = 80
string title = "none"
string dataobject = "d_coils_weight_zeroed_out"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_report_inv_cust_coils_863 from datawindow within w_run_report
boolean visible = false
integer x = 1876
integer y = 1069
integer width = 549
integer height = 320
integer taborder = 70
string dataobject = "d_report_inv_cust_coils_863"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_coils_proc_manual_run from commandbutton within w_run_report
integer x = 618
integer y = 1021
integer width = 530
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coils Proc.Manual Run"
end type

event clicked;Integer	li_rtn, li_answer
Long		ll_customer_ids[]
String	ls_customer_name = "all", ls_email_addresses[], ls_report_name = "coils processed report"
Boolean	lb_save

lb_save = cb_start_stop_timer.Enabled
cb_start_stop_timer.Enabled = False

//If This.Checked = True Then
	li_answer = MessageBox("Are you sure?", "This will run Coils Processed Report, and email it to users." + &
				"~n~rDo you want to continue?", Question!, YesNo!, 2)
	
	If li_answer = 1 Then //Yes
		wf_get_customer_ids(ls_customer_name, ll_customer_ids[])
		wf_get_email_addresses(ls_report_name, ls_customer_name, ls_email_addresses[])
		li_rtn = wf_coils_processed_report(ls_report_name, ll_customer_ids[], ls_email_addresses[])
		//This.Checked = False
		cb_start_stop_timer.Enabled = lb_save
	Else
		//This.Checked = False
		cb_start_stop_timer.Enabled = lb_save
	End If
//End If
end event

type dw_coils_processed from datawindow within w_run_report
integer x = 5186
integer y = 541
integer width = 1119
integer height = 176
integer taborder = 70
string title = "none"
string dataobject = "d_coils_processed"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_auto_report_emails_error from datawindow within w_run_report
integer x = 5186
integer y = 365
integer width = 1119
integer height = 176
integer taborder = 60
string title = "none"
string dataobject = "d_auto_report_emails_error"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_novelis_manual_run from commandbutton within w_run_report
integer x = 51
integer y = 1021
integer width = 530
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Novelis Manual Run"
end type

event clicked;Integer	li_rtn, li_answer
Long		ll_customer_ids[]
String	ls_customer_name = "novelis", ls_email_addresses[], ls_report_name = "inventory report"
Boolean	lb_save

lb_save = cb_start_stop_timer.Enabled
cb_start_stop_timer.Enabled = False

//If This.Checked = True Then
	li_answer = MessageBox("Are you sure?", "This will run Novelis Combined Inventory Report, and email it to Novelis users." + &
				"~n~rDo you want to continue?", Question!, YesNo!, 2)
	
	If li_answer = 1 Then //Yes
		wf_get_customer_ids(ls_customer_name, ll_customer_ids[])
		wf_get_email_addresses(ls_report_name, ls_customer_name, ls_email_addresses[])
		li_rtn = wf_auto_combined_4novelis(ls_report_name, ll_customer_ids[], ls_email_addresses[], ls_customer_name)
		//This.Checked = False
		cb_start_stop_timer.Enabled = lb_save
	Else
		//This.Checked = False
		cb_start_stop_timer.Enabled = lb_save
	End If
//End If
end event

type cb_start_stop_timer from commandbutton within w_run_report
integer x = 1302
integer y = 1021
integer width = 530
integer height = 90
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Start Timer"
boolean default = true
end type

event clicked;If This.Text = "Start Timer" Then
	This.Text = "Stop Timer"
	
	st_timer_start_stop.Visible = True
	st_timer_start_stop.Text = "Timer Started"
	Timer(il_timer_interval_seconds) //il_timer_interval_seconds is populated in Open event for this window: w_run_report
	//Timer(57)
	cb_novelis_manual_run.Enabled = False
	cb_coils_proc_manual_run.Enabled = False
Else //This.Text = "Stop Timer"
	This.Text = "Start Timer"
	
	st_timer_start_stop.Text = "Timer Stopped"
	Timer(0) //Stop Timer
	cb_novelis_manual_run.Enabled = True
	cb_coils_proc_manual_run.Enabled = True
End If
end event

type dw_auto_report_emails from datawindow within w_run_report
integer x = 5186
integer y = 186
integer width = 1119
integer height = 176
integer taborder = 50
string title = "none"
string dataobject = "d_auto_report_emails"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_auto_report_customers from datawindow within w_run_report
integer x = 5186
integer y = 29
integer width = 1119
integer height = 176
integer taborder = 40
string title = "none"
string dataobject = "d_auto_report_customers"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_auto_report_schedule from datawindow within w_run_report
integer x = 2893
integer y = 3
integer width = 2048
integer height = 982
integer taborder = 20
string title = "none"
string dataobject = "d_auto_report_schedule"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_report_auto_run_log from datawindow within w_run_report
integer x = 48
integer y = 234
integer width = 2812
integer height = 746
integer taborder = 30
string title = "none"
string dataobject = "d_report_auto_run_log"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_timer_start_stop from statictext within w_run_report
integer x = 922
integer width = 1200
integer height = 154
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 65535
string text = "Timer Stopped"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_edi_alert from datawindow within w_run_report
boolean visible = false
integer x = 117
integer y = 205
integer width = 2955
integer height = 742
integer taborder = 20
string title = "none"
string dataobject = "d_edi_alert"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_run_report
integer x = 2428
integer y = 1021
integer width = 443
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

type r_1 from rectangle within w_run_report
long linecolor = 65535
integer linethickness = 3
long fillcolor = 65535
integer x = 1284
integer y = 1002
integer width = 475
integer height = 131
end type

