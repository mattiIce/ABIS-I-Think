$PBExportHeader$w_inventory_reports.srw
forward
global type w_inventory_reports from w_sheet
end type
type dw_report_auto_run_log from datawindow within w_inventory_reports
end type
type cb_totals from commandbutton within w_inventory_reports
end type
type cb_email_comb from commandbutton within w_inventory_reports
end type
type cb_create_comb from commandbutton within w_inventory_reports
end type
type st_6 from statictext within w_inventory_reports
end type
type st_5 from statictext within w_inventory_reports
end type
type st_4 from statictext within w_inventory_reports
end type
type cb_start_fresh from commandbutton within w_inventory_reports
end type
type cb_4 from commandbutton within w_inventory_reports
end type
type cb_archive_folder from commandbutton within w_inventory_reports
end type
type sle_archive_folder from singlelineedit within w_inventory_reports
end type
type dw_abis_ini from datawindow within w_inventory_reports
end type
type st_3 from statictext within w_inventory_reports
end type
type st_2 from statictext within w_inventory_reports
end type
type sle_email_address from singlelineedit within w_inventory_reports
end type
type cb_unselect from commandbutton within w_inventory_reports
end type
type cb_close from commandbutton within w_inventory_reports
end type
type st_1 from statictext within w_inventory_reports
end type
type cb_run_bat from commandbutton within w_inventory_reports
end type
type cb_2 from commandbutton within w_inventory_reports
end type
type dw_report_inv_cust_coils from datawindow within w_inventory_reports
end type
type cb_1 from commandbutton within w_inventory_reports
end type
type cb_email from commandbutton within w_inventory_reports
end type
type cb_create_xls from commandbutton within w_inventory_reports
end type
type cb_files from commandbutton within w_inventory_reports
end type
type lb_files from listbox within w_inventory_reports
end type
type dw_name from datawindow within w_inventory_reports
end type
type cb_create_pdf from commandbutton within w_inventory_reports
end type
type dw_customer_short_list from datawindow within w_inventory_reports
end type
end forward

global type w_inventory_reports from w_sheet
integer width = 3478
integer height = 1763
string title = "All Together"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
dw_report_auto_run_log dw_report_auto_run_log
cb_totals cb_totals
cb_email_comb cb_email_comb
cb_create_comb cb_create_comb
st_6 st_6
st_5 st_5
st_4 st_4
cb_start_fresh cb_start_fresh
cb_4 cb_4
cb_archive_folder cb_archive_folder
sle_archive_folder sle_archive_folder
dw_abis_ini dw_abis_ini
st_3 st_3
st_2 st_2
sle_email_address sle_email_address
cb_unselect cb_unselect
cb_close cb_close
st_1 st_1
cb_run_bat cb_run_bat
cb_2 cb_2
dw_report_inv_cust_coils dw_report_inv_cust_coils
cb_1 cb_1
cb_email cb_email
cb_create_xls cb_create_xls
cb_files cb_files
lb_files lb_files
dw_name dw_name
cb_create_pdf cb_create_pdf
dw_customer_short_list dw_customer_short_list
end type
global w_inventory_reports w_inventory_reports

type variables
Boolean	ib_pdf_done, ib_xls_done
//String	is_customer_short_name_pdf, is_customer_short_name_xls

//SMTP email variables
n_smtp 	in_smtp

//Populated in Open event for w_inventory_reports
String	is_from_email //Sender email address
String	is_from_name //Sender name
String	is_server //SMTP server IP address
Integer	ii_port //SMTP port
String	is_send_email //Recipient email address
String	is_send_name //Recipient name
String	is_logfile //Log file where we record SMTP email messages if email fails
String	is_subject //Email subject line
String	is_email_folder //Windows folder where the files to attach to email are
String	is_file_name_2email //Beginning part of file name(s) to email
String	is_work_folder //Work folder where work files are created and deleted after they are used
String	is_archive_folder //Folder where the emailed files are archived
String	is_combine_bat_file //Bat file to combine pdf and xls file
String	is_taskkill_bat_file //Bat file to kill AcroRd32.exe tasks. They slow XLS creation
Boolean	ib_debugviewer = False

//---

//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
Boolean		ib_xls_done_comb
//String		is_email_addresses[]

//Diagnostic variables
Long			il_rows_coils, il_rows_scrap, il_rows_skids, il_rows_combined
Long			il_sum_skid_pieces, il_sum_item_pieces, il_sum_coil_net_wt, il_sum_coil_net_wt_balance
Long			il_sum_scrap_net_wt, il_sum_scrap_tare_wt
Long			il_sum_skid_net_wt, il_sum_item_net_wt
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. end

String		is_attached_file_name[]



end variables

forward prototypes
public function boolean wf_send_smtp_email (string as_body, string as_attached_file_name[])
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public function string inttocolumn (integer ai_col)
public function integer wf_exporttoexcel (datawindow adw[], string as_filename)
public subroutine excel_open_csv_saveas_xls ()
public subroutine ws_populate_abis_ini_variables (long al_rows)
public function integer wf_insert_update_abis_ini ()
public function integer wf_load_work_files (string as_folder, string as_file_name, string as_file_extension)
public function boolean wf_delete_work_files (string as_file_extension)
public function integer wf_load_email_files (string as_folder, string as_file_name)
public function boolean wf_delete_email_files ()
public subroutine wf_rename_files (ref string as_attached_file_name[])
public subroutine wf_move_files (string as_attached_file_name[])
public subroutine wf_get_customer (ref long al_customer_id, ref string as_customer_short_name)
public function boolean wf_report_4multiple_customers ()
public function boolean wf_report_4multiple_customers (ref string as_customer_short_name)
public subroutine wf_get_selected_customers (ref long al_customer_id[], ref string as_customer_short_name[])
public function integer wf_combine_data (ref datastore ads_report_inv_cust_coils_comb, ref datastore ads_report_inv_cust_scrap_skids_comb, ref datastore ads_report_inv_cust_skids_comb, ref datastore ads_comb, long al_customer_id[])
public function integer wf_coil_info_4scrap_retrieve (ref datastore ads_coil_info_4scrap, string as_customer_id_string)
public subroutine wf_rename_files_comb (ref string as_attached_file_name[])
public subroutine wf_delete_emailed_files (string as_file_name_2email[])
public function string wf_get_recipient_email ()
public subroutine wf_popualate_email_addresses (string as_email_addresses[])
public function boolean wf_send_smtp_email_auto (string as_body, string as_attached_file_name[], string as_email_address)
public function integer wf_insert_auto_run_log (string as_run_message)
public subroutine wf_get_customer_names (ref long al_customer_id[], ref string as_customer_short_name[])
public function integer wf_auto_combined_4novelis (long al_customer_ids[])
public function integer wf_auto_pdf_4others (long al_customer_ids[])
public function integer wf_auto_xls_4others (long al_customer_ids[])
public function integer wf_auto_email_4novelis (string as_email_address, boolean ab_archive_files, boolean ab_unmatched_coils)
public function string wf_unmatched_coils_list_auto (long al_customer_id[])
public function string wf_get_customer_name (long al_customer_id)
public function integer wf_auto_email_4others (long al_customer_ids[], string as_email_address, boolean ab_first_iteration, boolean ab_last_iteration)
public function boolean wf_send_smtp_email_coils_produced (string as_body, string as_attached_file_name[], string as_email_address)
public subroutine wf_get_customer_names_other (long al_customer_id[], ref string as_customer_short_name[])
public function boolean wf_send_smtp_email_coil_863 (string as_body, string as_attached_file_name[], string as_email_address)
public function boolean wf_send_smtp_email_coils_weight_zeroed (string as_body, string as_attached_file_name[], string as_email_address)
public function boolean wf_send_smtp_email_qr_report (string as_body, string as_attached_file_name[], string as_email_address)
public function boolean wf_send_smtp_email_aleris_report (string as_body, string as_attached_file_name[], string as_email_address)
public function boolean wf_send_smtp_email_onhold_report (string as_body, string as_attached_file_name[], string as_email_address)
public function boolean wf_send_smtp_email_onhold_report_monthly (string as_body, string as_attached_file_name[], string as_email_address)
end prototypes

event type string ue_whoami();Return "w_inventory_reports"
end event

public function boolean wf_send_smtp_email (string as_body, string as_attached_file_name[]);/*
Function:	wf_send_smtp_email
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject(is_subject)
in_smtp.of_SetBody(as_body, False)
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

If lb_Return Then
	MessageBox("SendMail", "Mail successfully sent!")
Else
	MessageBox("SendMail Error", in_smtp.of_GetLastError())
End If

Return lb_Return


end function

public subroutine getcolumns (datawindow adw_dw, ref string as_columns[]);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	getcolumns
				Get a list of all the columns in the DW
				Note this function could be replaced with
				a function that allows the developer to specify
				the column names to be exported.
Returns:		none
Arguments:	value	datawindow	adw_dw
				reference	string	as_columns[]
*/

Long ll_I, ll_Cols
String	ls_column_name

ll_Cols = Long( adw_DW.Describe( 'datawindow.column.count' ) )
FOR ll_I = ll_cols TO 1 STEP -1
	ls_column_name = adw_DW.Describe( '#' + String( ll_I ) + '.Name' )
	as_columns[ ll_I ] = ls_column_name
NEXT

////Alex Gerlants. 05/02/2016. End
end subroutine

public function any getdata (datawindow adw_dw, long al_row, string as_column);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	getdata
Returns:		any
Arguments:	value	datawindow	adw_dw
				value	long			al_row
				value	string		as_column
*/

Long ll_Col
Any la_A

IF al_Row > adw_DW.RowCount() THEN RETURN ""
ll_Col = Long( adw_DW.Describe( as_Column + ".ID" ) )
IF ll_Col > 0 THEN &
   la_A = adw_DW.object.data.primary.current[ al_Row, ll_Col ]

RETURN la_A
//Alex Gerlants. 05/02/2016. End
end function

public function string inttocolumn (integer ai_col);//Alex Gerlants. 05/02/2016. Begin
/*
Function:	inttocolumn
				Convert a column number into a spreadsheet column reference
Returns:		string
Arguments:	value	integer	ai_col
*/

String ls_Col
Integer li_Min, li_Max

IF ai_col <= 0 THEN RETURN ""

// calc the major/minor letters
li_Max = ai_col / 26
li_Min = ai_col - ( li_Max * 26 )

// Convert min and max to letters
IF li_Max > 0 THEN
	ls_Col = Char( 64 + li_Max )
END IF

ls_Col += String( Char( 64 + li_Min ) )

RETURN ls_Col
//Alex Gerlants. 05/02/2016. End
end function

public function integer wf_exporttoexcel (datawindow adw[], string as_filename);LONG				ll_UpperBound, ll_ctr, ll_OLEReturn, ll_last
STRING			ls_fileName, ls_sheetName
OLEOBJECT   	lole_Excel
OLEOBJECT		lole_MainWorkBook, lole_BufferWorkBook
OLEOBJECT   	lole_sheet
Integer			li_return

ll_UpperBound = UpperBound(adw)

IF ll_UpperBound <=0 THEN RETURN -1

lole_Excel = CREATE OLEOBJECT
lole_MainWorkBook = CREATE OLEOBJECT
lole_BufferWorkBook = CREATE OLEOBJECT
lole_sheet = CREATE OLEOBJECT

SETPOINTER(HourGlass!)

// Open application
ll_OLEReturn = lole_Excel.ConnectToNewObject("excel.application")

IF ll_OLEReturn < 0 THEN
	//f_Msg(f_ErrStr(50062,"Excel.Application"))
	li_return = -1
ELSE
	// New Excel workbook
	lole_MainWorkBook = lole_excel.WorkBooks.Add() 
	
	ll_last = lole_MainWorkBook.Worksheets.count
	
	DO WHILE ll_last < ll_UpperBound 
		lole_MainWorkBook.Worksheets.Add
		ll_last = lole_MainWorkBook.Worksheets.count
	LOOP
	
	FOR ll_ctr = 1 TO ll_UpperBound
		// Save As 
		//ls_sheetName = f_If(adw[ll_ctr].Title = "", adw[ll_ctr].DataObject, adw[ll_ctr].Title)
		//ls_sheetName = f_global_replace(ls_sheetName, ' ', '_')
		//ls_fileName = f_getostempdir() + ls_sheetName + ".txt"
		//adw[ll_ctr].SaveAsFormattedText(ls_fileName, EncodingANSI!, "~t", "", "~r~n", TRUE)
	//	adw[ll_ctr].SaveAs(as_filename, EXCEL8!, TRUE)
	
		// Open in Excel
		lole_BufferWorkBook = lole_excel.WorkBooks.Open(ls_fileName) 
		lole_BufferWorkBook.Worksheets(1).Cells.Select
		lole_Excel.CutCopyMode = False
		lole_BufferWorkBook.Worksheets(1).Cells.Copy
		
		// Paste to sheet
		lole_MainWorkBook.Activate
		lole_sheet = lole_MainWorkBook.WorkSheets(ll_ctr)
		lole_sheet.Name = ls_sheetName
		lole_sheet.Paste
		lole_sheet.Cells.EntireColumn.AutoFit
			
		//  clear from clipboard
		lole_Excel.CutCopyMode = False
		
		// Close
		lole_BufferWorkBook.CLOSE(FALSE)
		
		// Delete temporary file
	//	FileDelete ( ls_fileName )
	NEXT
	
	lole_Excel.Visible = TRUE
	
	lole_MainWorkBook.saveAs(as_filename)
	
	// Clean up
	lole_Excel.DisconnectObject()
	lole_MainWorkBook.DisconnectObject()
	lole_BufferWorkBook.DisconnectObject()
	lole_sheet.DisconnectObject()
	
	li_return = 1
END IF

DESTROY lole_Excel
DESTROY lole_MainWorkBook
DESTROY lole_BufferWorkBook
DESTROY lole_sheet

SETPOINTER(Arrow!)
RETURN li_return

end function

public subroutine excel_open_csv_saveas_xls ();/* 
Function:	excel_open_csv_saveas_xls
Returns:		none
Arguments:	none

*/

// Export the data to Excel
OleObject 	lole_OLE, lole_Sheet
String 		ls_file_name, ls_email_file, ls_file_in, ls_file_out, ls_file_archive
String		ls_work_folder, ls_email_folder, ls_archive_folder 
String		ls_date, ls_time, ls_date_time
Integer		li_rtn, li_filenum
Long			ll_pos
Boolean		lb_rtn
Any			la_rtn

SetPointer( HourGlass! )

ls_work_folder = is_work_folder
If Right(is_work_folder, 1) <> "\" Then is_work_folder = is_work_folder + "\"

ls_email_folder = is_email_folder
If Right(ls_email_folder, 1) <> "\" Then ls_email_folder = ls_email_folder + "\"

ls_archive_folder = is_archive_folder
If Right(ls_archive_folder, 1) <> "\" Then ls_archive_folder = ls_archive_folder + "\"

ls_file_name = "Inventory_all.csv"

ls_file_in = ls_work_folder + ls_file_name

lole_OLE = CREATE OleObject
li_rtn = lole_OLE.ConnectToNewObject('excel.application')

If li_rtn = 0 Then
	lole_OLE.Application.DisplayAlerts = "False"
	la_rtn = lole_OLE.Workbooks.Open(ls_file_in)
	lole_OLE.Visible=FALSE
	
	ls_file_out = Left(ls_file_in, Len(ls_file_in) - 3) + "xls"
	
	FileDelete(ls_file_out)
	
	//MessageBox("excel_open_csv_saveas_xls for w_inventory_reports", "Before saveas. ls_file_out = " + ls_file_out)
	
	lole_OLE.ActiveWorkbook.SaveAs(ls_file_out, 56) //excel8 <== xls
	
	//MessageBox("excel_open_csv_saveas_xls for w_inventory_reports", "After saveas. ls_file_out = " + ls_file_out)
	
	lole_OLE.Application.DisplayAlerts = "False"
End If

lole_OLE.Application.quit()
lole_OLE.DisconnectObject()

DESTROY lole_OLE

Garbagecollect()

//---

ls_date = String(Today(), "mmddyyyy")
ls_time = String(Now(), "hhmmss")
ls_date_time = ls_date + "_" + ls_time

ll_pos = Pos(ls_file_out, "Inventory_all.xls", 1)

If ll_pos > 0 Then
	ls_email_file = Left(ls_file_out, ll_pos - 1) + "email\" + "Inventory_" + ls_date_time + ".xls"
	li_filenum = FileCopy(ls_file_out, ls_email_file, True) //True - Override if file exists
	
	ls_file_archive = ls_archive_folder + Right(ls_email_file, Len(ls_email_file) - Len(ls_email_folder))
End If

If li_filenum = 1 Then //OK
	lb_rtn = FileDelete(ls_file_in)
	//lb_rtn = FileDelete(ls_file_out)
	//li_rtn = FileMove(ls_file_out, ls_file_archive)
End If

SetPointer( Arrow! )

end subroutine

public subroutine ws_populate_abis_ini_variables (long al_rows);/*
Function:	ws_populate_abis_ini_variables
Returns:		none
Arguments:	value		long	al_rows <== Number of rows in dw_abis_ini
*/

Long		ll_row
Integer	li_rtn
String	ls_port, ls_send_email

//Alex Gerlants. 08/08/2017.
//Added gs_albl_email_address instead of "@albl.com" to the code below.
//gs_albl_email_address is retrieved from abis_ini in ue_default for w_mylogon in silverdome.pbl
If IsNull(gs_albl_email_address) Then gs_albl_email_address = ""
If gs_albl_email_address = "" Then gs_albl_email_address = "@albl.com"

Choose Case al_rows
	Case Is > 0 //abis_ini has rows for inventory_reports
		is_server = f_get_ini_value("inventory_reports","smtp_email","server","192.168.3.67")
		
		ls_port = f_get_ini_value("inventory_reports","smtp_email","port","25")
		
		If IsNumber(ls_port) Then
			ii_port = Integer(ls_port)
		Else
			ii_port = 25
		End If
		
		is_send_email = f_get_ini_value("inventory_reports","smtp_email","UserEmail","rsedam" + gs_albl_email_address)
		sle_email_address.Text = Lower(is_from_name) + gs_albl_email_address
		
		is_send_name = f_get_ini_value("inventory_reports","smtp_email","send_name","User")
		is_logfile = f_get_ini_value("inventory_reports","smtp_email","logfile","c:\temp\SMTP_Email_LogFile.txt")
		is_subject = f_get_ini_value("inventory_reports","smtp_email","subject","Inventory Reports")
		is_file_name_2email = f_get_ini_value("inventory_reports","smtp_email","file_name_2email","Inventory")
		
		is_email_folder = f_get_ini_value("inventory_reports","smtp_email","email_folder","C:\temp\email\")
		
		If Right(is_email_folder, 1) <> "\" Then
			is_email_folder = is_email_folder + "\"
		End If
		
		is_work_folder = f_get_ini_value("inventory_reports","smtp_email","work_folder","C:\temp")
		
		If Right(is_work_folder, 1) <> "\" Then
			is_work_folder = is_work_folder + "\"
		End If
		
		is_archive_folder = f_get_ini_value("inventory_reports","smtp_email","archive_folder","C:\temp\archive")
		
		If Right(is_archive_folder, 1) <> "\" Then
			is_archive_folder = is_archive_folder + "\"
		End If
		
		sle_archive_folder.Text = is_archive_folder
		
		is_combine_bat_file = f_get_ini_value("inventory_reports","smtp_email","combine_bat_file","C:\abis\combpdf.bat")
		
		is_taskkill_bat_file = f_get_ini_value("inventory_reports","smtp_email","taskkill_bat_file","C:\abis\taskkill.bat")

	Case 0 //abis_ini has no rows for inventory_reports
		//Assign defaults to instance variables
		is_server = "192.168.3.67"
		ii_port = 25
		ls_send_email = "rsedam" + gs_albl_email_address
		is_send_email = ls_send_email
		sle_email_address.Text = Lower(is_from_name) + gs_albl_email_address
		is_send_name = "User"
		is_logfile = "c:\temp\SMTP_Email_LogFile.txt"
		is_subject = "Inventory Reports"
		is_file_name_2email = "Inventory"
		is_email_folder = "C:\temp\email\"
		is_work_folder = "C:\temp\"
		is_archive_folder = "C:\temp\archive\"
		sle_archive_folder.Text = is_archive_folder
		is_combine_bat_file = "C:\abis\combpdf.bat"
		is_taskkill_bat_file = "C:\abis\taskkill.bat"
		
		li_rtn = wf_insert_update_abis_ini() //Insert these defaults into dw_abis_ini, and update to DB
		
	Case Is < 0 //DB error
		//Assign defaults to instance variables
		is_server = "192.168.3.67"
		ii_port = 25
		ls_send_email = "rsedam" + gs_albl_email_address
		sle_email_address.Text = Lower(is_from_name) + gs_albl_email_address
		is_send_name = "User"
		is_logfile = "c:\temp\SMTP_Email_LogFile.txt"
		is_subject = "Inventory Reports"
		is_file_name_2email = "Inventory"
		is_email_folder = "C:\temp\email\"
		is_work_folder = "C:\temp\"
		is_archive_folder = "C:\temp\archive\"
		sle_archive_folder.Text = is_archive_folder
		is_combine_bat_file = "C:\abis\combpdf.bat"
		is_taskkill_bat_file = "C:\abis\taskkill.bat"
		
End Choose
end subroutine

public function integer wf_insert_update_abis_ini ();Integer	li_rtn = 1
Long		ll_inserted_row

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_server = "192.168.3.67"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "server"
	dw_abis_ini.Object.value[ll_inserted_row] = is_server
	dw_abis_ini.Object.description[ll_inserted_row] = "SMTP server IP address"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//ii_port = 25
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "port"
	dw_abis_ini.Object.value[ll_inserted_row] = String(ii_port)
	dw_abis_ini.Object.description[ll_inserted_row] = "SMTP port"
End If

	

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//ls_send_email = "rsedam@albl.com"
	//sle_email_address.Text = ls_send_email
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "useremail"
	dw_abis_ini.Object.value[ll_inserted_row] = is_send_email
	dw_abis_ini.Object.description[ll_inserted_row] = "User Email address to send to"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_send_name = "User"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "send_name"
	dw_abis_ini.Object.value[ll_inserted_row] = is_send_name
	dw_abis_ini.Object.description[ll_inserted_row] = "Name of SMTP email recipient"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_logfile = "P:\Email_Errors_LogFiles\SMTP_Email_LogFile.txt"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "logfile"
	dw_abis_ini.Object.value[ll_inserted_row] = is_logfile
	dw_abis_ini.Object.description[ll_inserted_row] = "Log file where we record SMTP email messages if email fails"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_subject = "Inventory Reports"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "subject"
	dw_abis_ini.Object.value[ll_inserted_row] = is_subject
	dw_abis_ini.Object.description[ll_inserted_row] = "SMTP email subject line"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_file_name_2email = "Inventory"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "file_name_2email"
	dw_abis_ini.Object.value[ll_inserted_row] = is_file_name_2email
	dw_abis_ini.Object.description[ll_inserted_row] = "Beginning part of file name to email"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_email_folder = "C:\temp\email\"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "email_folder"
	dw_abis_ini.Object.value[ll_inserted_row] = is_email_folder
	dw_abis_ini.Object.description[ll_inserted_row] = "Windows folder where the files to attach to email are"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_work_folder = "C:\temp\"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "work_folder"
	dw_abis_ini.Object.value[ll_inserted_row] = is_work_folder
	dw_abis_ini.Object.description[ll_inserted_row] = "Work folder where work files are created and deleted after they are used"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_archive_folder = "C:\temp\archive\"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "archive_folder"
	dw_abis_ini.Object.value[ll_inserted_row] = is_archive_folder
	dw_abis_ini.Object.description[ll_inserted_row] = "Folder where the emailed files are archived"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_combine_bat_file = "C:\abis\combpdf.bat"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "combine_bat_file"
	dw_abis_ini.Object.value[ll_inserted_row] = is_combine_bat_file
	dw_abis_ini.Object.description[ll_inserted_row] = "Bat file to combine pdf and xls file"
End If

ll_inserted_row = dw_abis_ini.InsertRow(0)

If ll_inserted_row > 0 Then
	//is_taskkill_bat_file = "C:\abis\taskkill.bat"
	dw_abis_ini.Object.process[ll_inserted_row] = 'inventory_reports'
	dw_abis_ini.Object.section[ll_inserted_row] = 'smtp_email'
	
	dw_abis_ini.Object.key[ll_inserted_row] = "taskkill_bat_file"
	dw_abis_ini.Object.value[ll_inserted_row] = is_taskkill_bat_file
	dw_abis_ini.Object.description[ll_inserted_row] = "Bat file to kill AcroRd32.exe tasks. They slow XLS creation"
End If

li_rtn = dw_abis_ini.Update()

If li_rtn = 1 Then //OK
	commit using sqlca;
Else //DB error
	rollback using sqlca;
End If

Return li_rtn
end function

public function integer wf_load_work_files (string as_folder, string as_file_name, string as_file_extension);/*
Function:	wf_load_work_files
Returns:		integer
Arguments:	value	string	as_folder
				value	string	as_file_name
				value	string	as_file_extension
*/

Boolean	lb_rtn
String	ls_filename, ls_notetext, ls_attached_file_name[]
Integer	li_totalitems, li_i

If Right(as_folder, 1) <> "\" Then as_folder = as_folder + "\"

//Load file into lb_files
lb_files.DirList(as_folder + as_file_name + "*." + as_file_extension, 0)

li_totalitems = lb_files.TotalItems()

Return li_totalitems
end function

public function boolean wf_delete_work_files (string as_file_extension);/*
Function:	wf_delete_work_files
Returns:		boolean
Arguments:	value	string	as_file_extension
*/

Long		li_totalitems
String	ls_filename
Integer	li_rtn = 1, li_i
Boolean	lb_rtn = True

//Delete from work folder all .pdf and .csv work files created before
li_totalitems = wf_load_work_files(is_work_folder, "Coils", as_file_extension) //Load "Coils*.*" file names into lb_files

If li_totalitems > 0 Then
	For li_i =1 To li_totalitems
		lb_files.SelectItem(li_i)
		ls_filename = lb_files.SelectedItem()
		ls_filename = is_work_folder + ls_filename
		
		lb_rtn = FileDelete(ls_filename)
		If Not lb_rtn Then lb_rtn = False
	Next
End If

li_totalitems = wf_load_work_files(is_work_folder, "Skids", as_file_extension) //Load Skids*.* file names into lb_files

If li_totalitems > 0 Then
	For li_i =1 To li_totalitems
		lb_files.SelectItem(li_i)
		ls_filename = lb_files.SelectedItem()
		ls_filename = is_work_folder + ls_filename
		
		lb_rtn = FileDelete(ls_filename)
		If Not lb_rtn Then lb_rtn = False
	Next
End If

li_totalitems = wf_load_work_files(is_work_folder, "Scrap", as_file_extension) //Load Scrap*.* file names into lb_files

If li_totalitems > 0 Then
	For li_i =1 To li_totalitems
		lb_files.SelectItem(li_i)
		ls_filename = lb_files.SelectedItem()
		ls_filename = is_work_folder + ls_filename
		
		lb_rtn = FileDelete(ls_filename)
		If Not lb_rtn Then lb_rtn = False
	Next
End If

Return lb_rtn
end function

public function integer wf_load_email_files (string as_folder, string as_file_name);/*
Function:	wf_load_email_files
Returns:		integer
Arguments:	value	string	as_folder
				value	string	as_file_name
*/

Boolean	lb_rtn
String	ls_filename, ls_notetext, ls_attached_file_name[]
Integer	li_totalitems, li_i

If Right(as_folder, 1) <> "\" Then as_folder = as_folder + "\"

//Load file into lb_files
lb_files.DirList(as_folder + as_file_name + "_*.*", 0)

li_totalitems = lb_files.TotalItems()

Return li_totalitems


end function

public function boolean wf_delete_email_files ();/*
Function:	wf_delete_email_files
Returns:		boolean
Arguments:	none
*/

Long		li_totalitems
String	ls_filename
Integer	li_rtn = 1, li_i
Boolean	lb_rtn = True

//Delete from email folder all .PDF email files created before
li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email) //Load file names into lb_files

If li_totalitems > 0 Then
	For li_i =1 To li_totalitems
		lb_files.SelectItem(li_i)
		ls_filename = lb_files.SelectedItem()
		ls_filename = is_email_folder + ls_filename
		
		lb_rtn = FileDelete(ls_filename)
		If Not lb_rtn Then lb_rtn = False
	Next
End If

Return lb_rtn
end function

public subroutine wf_rename_files (ref string as_attached_file_name[]);/*
Function:	wf_rename_files
Returns:		none
Arguments:	reference	string	as_attached_file_name[]
*/

Integer	li_totalitems, li_i, li_rtn, li_pos
Boolean	lb_report_4multiple_customers
Long		ll_customer_id[]
String	ls_filename, ls_new_filename, ls_customer_short_name, ls_customer_name_arr[]

lb_report_4multiple_customers = wf_report_4multiple_customers(ls_customer_short_name) //Alex Gerlants. 06/08/2017
	
li_totalitems = UpperBound(as_attached_file_name[])

For li_i = 1 To li_totalitems
	ls_filename = as_attached_file_name[li_i]
	li_pos = Pos(ls_filename, "Inventory", 1)
	
	If li_pos > 0 Then
		If lb_report_4multiple_customers Then
			ls_customer_short_name = Upper(ls_customer_short_name)
			ls_new_filename = Replace(ls_filename, li_pos, 9, ls_customer_short_name)
			as_attached_file_name[li_i] = ls_new_filename
			li_rtn = FileMove(ls_filename, ls_new_filename) //Rename
		Else
			//wf_get_customer(ll_customer_id, ls_customer_short_name)
			wf_get_selected_customers(ll_customer_id[], ls_customer_name_arr[])
		
		
			If UpperBound(ll_customer_id[]) > 0 Then
				If UpperBound(ll_customer_id[]) = 1 Then
					If Lower(Right(ls_filename, 3)) = "xls" Then
						ls_new_filename = Replace(ls_filename, li_pos, 9, Trim(ls_customer_name_arr[1]))
					Else //Lower(Right(ls_filename, 3)) = "pdf"
						ls_new_filename = Replace(ls_filename, li_pos, 9, Trim(ls_customer_name_arr[1]))
					End If
				Else //UpperBound(ll_customer_id[]) > 1
					If Lower(Right(ls_filename, 3)) = "xls" Then
						ls_new_filename = Replace(ls_filename, li_pos, 9, "MIXED CUSTOMERS")
					Else //Lower(Right(ls_filename, 3)) = "pdf"
						ls_new_filename = Replace(ls_filename, li_pos, 9, "MIXED CUSTOMERS")
					End If
				End If
				
				li_rtn = FileMove(ls_filename, ls_new_filename) //Rename
				
				If li_rtn = 1 Then //OK in FileMove
					as_attached_file_name[li_i] = ls_new_filename
				End If
			End if
		End If
	End If
Next
end subroutine

public subroutine wf_move_files (string as_attached_file_name[]);/*
Function:	wf_move_files
Returns:		none
Arguments:	reference	string	as_attached_file_name[]
*/

Integer	li_totalitems, li_i, li_rtn
Long		ll_pos, ll_pos_save, ll_start
String	ls_filename, ls_new_filename

li_totalitems = UpperBound(as_attached_file_name[])

For li_i = 1 To li_totalitems
	ls_filename = as_attached_file_name[li_i]
	
	ll_start = 1
	ll_pos = Pos(ls_filename, "\", ll_start)
	
	Do While ll_pos > 0
		ll_pos_save = ll_pos
		ll_start = ll_pos + 1 
		ll_pos = Pos(ls_filename, "\", ll_start)
	Loop
	
	If ll_pos_save > 0 Then
		ls_new_filename = Replace(ls_filename, 1, ll_pos_save, is_archive_folder)
	End If
	
	li_rtn = FileMove(ls_filename, ls_new_filename) //Move
Next
end subroutine

public subroutine wf_get_customer (ref long al_customer_id, ref string as_customer_short_name);/*
Function:	wf_get_customer
Returns:		none
Arguments:	reference	long		al_customer_id
				reference	string	as_customer_short_name
*/

Long	ll_rows, ll_selected_row


ll_rows = dw_customer_short_list.RowCount()

If ll_rows > 0 Then
	ll_selected_row = dw_customer_short_list.GetSelectedRow(0)

	If ll_selected_row > 0 Then
		al_customer_id = dw_customer_short_list.Object.customer_id[ll_selected_row]
		as_customer_short_name = Trim(dw_customer_short_list.Object.customer_short_name[ll_selected_row])
	End If
Else
	al_customer_id = 0
	as_customer_short_name = ""
End If
end subroutine

public function boolean wf_report_4multiple_customers ();//Alex Gerlants. 06/08/2017. Begin
/*
Function:	wf_report_4multiple_customers
Returns:		boolean <== True 	if user is running reports for multiple customers
								False if user is running reports for one customer
Arguments:									
*/

Boolean	lb_report_4multiple_customers
String	ls_customer_short_name
Long		ll_selected_row

dw_name.AcceptText()
ls_customer_short_name = Trim(dw_name.Object.name[1])
If IsNull(ls_customer_short_name) Then ls_customer_short_name = ""

ll_selected_row = dw_customer_short_list.GetSelectedRow(0)

lb_report_4multiple_customers = False

If ls_customer_short_name <> "" And ll_selected_row = 0 Then //User wants to create report for all customers that have ls_customer_short_name in their customer.customer_short_name
	lb_report_4multiple_customers = True
End If

Return lb_report_4multiple_customers
//Alex Gerlants. 06/08/2017. End
end function

public function boolean wf_report_4multiple_customers (ref string as_customer_short_name);//Alex Gerlants. 06/08/2017. Begin
/*
Function:	wf_report_4multiple_customers
Returns:		boolean <== True 	if user is running reports for multiple customers
								False if user is running reports for one customer
Arguments:	reference	string	as_customer_short_name								
*/

Boolean	lb_report_4multiple_customers
Long		ll_selected_row

dw_name.AcceptText()
as_customer_short_name = Trim(dw_name.Object.name[1])
If IsNull(as_customer_short_name) Then as_customer_short_name = ""

ll_selected_row = dw_customer_short_list.GetSelectedRow(0)

lb_report_4multiple_customers = False

If as_customer_short_name <> "" And ll_selected_row = 0 Then //User wants to create report for all customers that have ls_customer_short_name in their customer.customer_short_name
	lb_report_4multiple_customers = True
End If

Return lb_report_4multiple_customers
//Alex Gerlants. 06/08/2017. End
end function

public subroutine wf_get_selected_customers (ref long al_customer_id[], ref string as_customer_short_name[]);//Alex Gerlants. 06/08/2017. Begin
/*
Function:	wf_get_selected_customers
Returns:		none
Arguments:	reference	long		al_customer_id[]
				reference	string	as_customer_short_name[]
*/

Long		ll_rows, ll_row, ll_customer_id_temp, ll_selected_row, ll_empty[]
String	ls_customer_short_name_temp, ls_empty[]

//First, delete all items from the input arrays.
al_customer_id[] = ll_empty[]
as_customer_short_name[] = ls_empty[]

ll_rows = dw_customer_short_list.RowCount()
	
If ll_rows > 0 Then
	ll_selected_row = dw_customer_short_list.GetSelectedRow(0)
	
	Do While ll_selected_row > 0
		ll_customer_id_temp = dw_customer_short_list.Object.customer_id[ll_selected_row]
		ls_customer_short_name_temp = dw_customer_short_list.Object.customer_short_name[ll_selected_row]
		
		al_customer_id[UpperBound(al_customer_id[]) + 1] = ll_customer_id_temp
		as_customer_short_name[UpperBound(as_customer_short_name[]) + 1] = ls_customer_short_name_temp
		
		ll_selected_row = dw_customer_short_list.GetSelectedRow(ll_selected_row)
	Loop
End If
//Alex Gerlants. 06/08/2017. End
end subroutine

public function integer wf_combine_data (ref datastore ads_report_inv_cust_coils_comb, ref datastore ads_report_inv_cust_scrap_skids_comb, ref datastore ads_report_inv_cust_skids_comb, ref datastore ads_comb, long al_customer_id[]);//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
/*
Function:	wf_combine_data
Returns:		integer
Arguments:	reference	datastore	ads_report_inv_cust_coils_comb
				reference	datastore	ads_report_inv_cust_scrap_skids_comb
				reference	datastore	ads_report_inv_cust_skids_comb
				reference	datastore	ads_comb
				value			long			al_customer_id[]
*/
Integer		li_rtn = 1, li_rtn_coil_info
DataStore	lds_customer_list, lds_coil_info_4scrap
String		ls_find_string
Long			ll_found_row, ll_coil_customer_id, ll_inserted_row

Long			ll_rows, ll_row, ll_i, ll_skid_pieces, ll_item_pieces
String		ls_customer_id_temp, ls_customer_id_string, ls_coil_abc_num
String		ls_material_type, ls_customer_short_name, ls_enduser, ls_status
String		ls_skid_number, ls_coil_org_num, ls_coil_mid_num, ls_coil_lot_number
String		ls_coil_alloy, ls_coil_temper, ls_ddate, ls_weight_uom
String		ls_material_number, ls_enduser_part_number, ls_ab_job_number
String		ls_skid_pieces, ls_item_pieces
String		ls_coil_gauge, ls_coil_width, ls_coil_cash_date
String		ls_reference, ls_net_wt, ls_coil_net_weight_balance, ls_duration
Long			ll_coil_abc_num, ll_coil_abc_num_prev, ll_weight, ll_coil_net_weight_balance, ll_duration, ll_net_wt
Long			ll_scrap_skid_scrap_tare_wt, ll_item_net_wt
Decimal		ldc_coil_gauge, ldc_coil_width

lds_coil_info_4scrap = Create DataStore
lds_coil_info_4scrap.DataObject = "d_coil_info_4scrap"
lds_coil_info_4scrap.SetTransObject(sqlca)

For ll_i = 1 To UpperBound(al_customer_id[])
	ls_customer_id_temp = String(al_customer_id[ll_i])
	ls_customer_id_string = ls_customer_id_string + ls_customer_id_temp + ", "
Next

//Remove the last comma
If ls_customer_id_string <> "" Then
	ls_customer_id_string = Left(ls_customer_id_string, Len(ls_customer_id_string) - 2)
End If

li_rtn_coil_info = wf_coil_info_4scrap_retrieve(lds_coil_info_4scrap, ls_customer_id_string)

If li_rtn_coil_info = -1 Then //Error in wf_coil_info_4scrap_retrieve()
	ls_coil_abc_num = ""
	ls_coil_org_num = ""
	ls_coil_mid_num = ""
	ls_coil_gauge = ""
	ls_coil_width = ""
	ls_material_number = ""
End If

lds_customer_list = Create DataStore
lds_customer_list.DataObject = "d_customer_list"
lds_customer_list.SetTransObject(sqlca)

lds_customer_list.Retrieve()

ll_rows = ads_report_inv_cust_coils_comb.RowCount()
il_rows_coils = ll_rows

ls_material_type = "Coils"
ll_coil_abc_num_prev = 0

ads_report_inv_cust_coils_comb.SetSort("coil_coil_abc_num Asc, coil_coil_org_num Asc")
ads_report_inv_cust_coils_comb.Sort()

For ll_row = 1 To ll_rows
	ll_inserted_row = ads_comb.InsertRow(0)
	
	If ll_inserted_row > 0 Then
		ads_comb.Object.material_type[ll_inserted_row] = ls_material_type
		
		ll_coil_customer_id = ads_report_inv_cust_coils_comb.Object.coil_customer_id[ll_row]
		ls_find_string = "customer_id = " + String(ll_coil_customer_id)
		ll_found_row = lds_customer_list.Find(ls_find_string, 1, lds_customer_list.RowCount())
		
		If ll_found_row > 0 Then
			ls_customer_short_name = Trim(lds_customer_list.Object.customer_short_name[ll_found_row])
		Else
			ls_customer_short_name = ""
		End If
		
		ads_comb.Object.customer_short_name[ll_inserted_row] = ls_customer_short_name
		
		//ls_enduser = Trim(ads_report_inv_cust_coils_comb.Object.enduser_name[ll_row])
		//ads_comb.Object.enduser[ll_inserted_row] = ls_enduser
		
		ls_status = ads_report_inv_cust_coils_comb.Object.coil_status_desc[ll_row]
		ads_comb.Object.status[ll_inserted_row] = ls_status
		
		ls_skid_number = ""
		ads_comb.Object.skid_number[ll_inserted_row] = ls_skid_number
		
		ll_coil_abc_num = ads_report_inv_cust_coils_comb.Object.coil_coil_abc_num[ll_row]
		ls_coil_abc_num = String(ll_coil_abc_num)
		ads_comb.Object.coil_abc_number[ll_inserted_row] = ls_coil_abc_num
		
		ls_coil_org_num = ads_report_inv_cust_coils_comb.Object.coil_coil_org_num[ll_row]
		ads_comb.Object.coil_org_number[ll_inserted_row] = ls_coil_org_num
		
		ls_coil_mid_num = ads_report_inv_cust_coils_comb.Object.coil_coil_mid_num[ll_row]
		ads_comb.Object.coil_mid_number[ll_inserted_row] = ls_coil_mid_num

		ls_coil_lot_number = ads_report_inv_cust_coils_comb.Object.coil_lot_num[ll_row]
		ads_comb.Object.coil_lot_number[ll_inserted_row] = ls_coil_lot_number
		
		ls_coil_alloy = ads_report_inv_cust_coils_comb.Object.coil_coil_alloy2[ll_row]
		ads_comb.Object.coil_alloy[ll_inserted_row] = ls_coil_alloy
		
		ls_coil_temper = ads_report_inv_cust_coils_comb.Object.coil_coil_temper[ll_row]
		ads_comb.Object.coil_temper[ll_inserted_row] = ls_coil_temper
		
		ls_reference = ads_report_inv_cust_coils_comb.Object.customer_order_reference[ll_row]
		ads_comb.Object.reference[ll_inserted_row] = ls_reference
		
		ls_ddate = ads_report_inv_cust_coils_comb.Object.coil_date_received[ll_row]
		ads_comb.Object.ddate[ll_inserted_row] = ls_ddate
		
		ls_net_wt = ads_report_inv_cust_coils_comb.Object.coil_net_wt[ll_row]
		ads_comb.Object.weight[ll_inserted_row] = Long(ls_net_wt)
		
		ls_coil_net_weight_balance = ads_report_inv_cust_coils_comb.Object.coil_net_wt_balance[ll_row]
		ads_comb.Object.net_weight_balance[ll_inserted_row] = Long(ls_coil_net_weight_balance)
		
		ls_weight_uom = "LBS"
		ads_comb.Object.weight_uom[ll_inserted_row] = ls_weight_uom
		
		ls_coil_gauge = String(ads_report_inv_cust_coils_comb.Object.coil_coil_gauge[ll_row])
		ads_comb.Object.coil_gauge[ll_inserted_row] = ls_coil_gauge
		
		ls_coil_width = String(ads_report_inv_cust_coils_comb.Object.coil_coil_width[ll_row])
		ads_comb.Object.coil_width[ll_inserted_row] = ls_coil_width
		
		ls_material_number = ads_report_inv_cust_coils_comb.Object.coil_material_num[ll_row]
		ads_comb.Object.material_number[ll_inserted_row] = ls_material_number
		
		ls_duration = ads_report_inv_cust_coils_comb.Object.duration[ll_row]
		ads_comb.Object.duration[ll_inserted_row] = ls_duration
		
		ls_ab_job_number = ""
		ads_comb.Object.ab_job_number[ll_inserted_row] = ls_ab_job_number
		
		ls_enduser_part_number = ""
		ads_comb.Object.enduser_part_number[ll_inserted_row] = ls_enduser_part_number
		
		ll_skid_pieces = 0
		ads_comb.Object.skid_pieces[ll_inserted_row] = ll_skid_pieces
		
		ll_item_pieces = 0
		ads_comb.Object.item_pieces[ll_inserted_row] = ll_item_pieces
		
		ls_coil_cash_date = ads_report_inv_cust_coils_comb.Object.coil_cash_date[ll_row]
		ads_comb.Object.coil_cash_date[ll_inserted_row] = ls_coil_cash_date
		
		//These totals below are to compare the numbers with the "All Together" report
		If ll_coil_abc_num <> ll_coil_abc_num_prev Then
			il_sum_coil_net_wt = il_sum_coil_net_wt + ll_net_wt
			il_sum_coil_net_wt_balance = il_sum_coil_net_wt_balance + ll_coil_net_weight_balance
		End If
		
		ll_coil_abc_num_prev = ll_coil_abc_num
	End If
Next

//ads_report_inv_cust_scrap_skids_comb.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ll_rows = ads_report_inv_cust_scrap_skids_comb.RowCount()
il_rows_scrap = ll_rows

ls_material_type = "Scrap"

For ll_row = 1 To ll_rows
	ll_inserted_row = ads_comb.InsertRow(0)
	
	If ll_inserted_row > 0 Then
		
		If li_rtn_coil_info = 1 Then //OK in wf_coil_info_4scrap_retrieve()
			ll_coil_abc_num = ads_report_inv_cust_scrap_skids_comb.Object.return_scrap_item_coil_abc_num[ll_row]
			If IsNull(ll_coil_abc_num) Then ll_coil_abc_num = 0
			
			If ll_coil_abc_num > 0 Then
				ls_coil_abc_num = String(ll_coil_abc_num)
				
				ls_find_string = "coil_abc_num = " + String(ll_coil_abc_num)
				ll_found_row = lds_coil_info_4scrap.Find(ls_find_string, 1, lds_coil_info_4scrap.RowCount())
				
				If ll_found_row > 0 Then
					ls_coil_org_num = Trim(lds_coil_info_4scrap.Object.coil_org_num[ll_found_row])
					ls_coil_mid_num = Trim(lds_coil_info_4scrap.Object.coil_mid_num[ll_found_row])
					ls_coil_gauge = String(lds_coil_info_4scrap.Object.coil_gauge[ll_found_row])
					ls_coil_width = String(lds_coil_info_4scrap.Object.coil_width[ll_found_row])
					ls_material_number = Trim(lds_coil_info_4scrap.Object.material_num[ll_found_row])
					ls_coil_cash_date = Trim(lds_coil_info_4scrap.Object.cash_date[ll_found_row])
				Else
					ls_customer_short_name = ""
				End If
			Else
				ls_coil_abc_num = ""
				ls_coil_org_num = ""
				ls_coil_mid_num = ""
				ls_coil_gauge = ""
				ls_coil_width = ""
				ls_material_number = ""
				ls_coil_cash_date = ""
			End If
		End If
		
		ads_comb.Object.material_type[ll_inserted_row] = ls_material_type
		
		ls_customer_short_name = Trim(ads_report_inv_cust_scrap_skids_comb.Object.customer_customer_short_name[ll_row])
		ads_comb.Object.customer_short_name[ll_inserted_row] = ls_customer_short_name
		
		ls_enduser = ""
		//ads_comb.Object.enduser[ll_inserted_row] = ls_enduser
		
		ls_status = ads_report_inv_cust_scrap_skids_comb.Object.scrap_status_desc[ll_row]
		ads_comb.Object.status[ll_inserted_row] = ls_status
		
		ls_skid_number = ads_report_inv_cust_scrap_skids_comb.Object.scrap_skid_scrap_skid_display_num[ll_row]
		ads_comb.Object.skid_number[ll_inserted_row] = ls_skid_number
		
		//ll_coil_abc_num = ads_report_inv_cust_scrap_skids_comb.Object.return_scrap_coil_abc_num[ll_row]
		ads_comb.Object.coil_abc_number[ll_inserted_row] = ls_coil_abc_num
		
		//ls_coil_org_num = ""
		ads_comb.Object.coil_org_number[ll_inserted_row] = ls_coil_org_num
		
		//ls_coil_mid_num = ""
		ads_comb.Object.coil_mid_number[ll_inserted_row] = ls_coil_mid_num

		ls_coil_lot_number = ads_report_inv_cust_scrap_skids_comb.Object.coil_lot_num[ll_row]
		ads_comb.Object.coil_lot_number[ll_inserted_row] = ls_coil_lot_number
		
		ls_coil_alloy = ads_report_inv_cust_scrap_skids_comb.Object.scrap_skid_scrap_alloy2[ll_row]
		ads_comb.Object.coil_alloy[ll_inserted_row] = ls_coil_alloy
		
		ls_coil_temper = ads_report_inv_cust_scrap_skids_comb.Object.scrap_skid_scrap_temper[ll_row]
		ads_comb.Object.coil_temper[ll_inserted_row] = ls_coil_temper
		
		ls_reference = ads_report_inv_cust_scrap_skids_comb.Object.scrap_skid_scrap_cust_po[ll_row]
		ads_comb.Object.reference[ll_inserted_row] = ls_reference
		
		ls_ddate = String(ads_report_inv_cust_scrap_skids_comb.Object.scrap_skid_scrap_date[ll_row])
		ads_comb.Object.ddate[ll_inserted_row] = ls_ddate
		
		//ll_net_wt = ads_report_inv_cust_scrap_skids_comb.Object.scrap_skid_scrap_net_wt[ll_row]
		ll_net_wt = Long(ads_report_inv_cust_scrap_skids_comb.Object.return_scrap_item_return_item_net_wt[ll_row])
		il_sum_scrap_net_wt = il_sum_scrap_net_wt + ll_net_wt

		ll_scrap_skid_scrap_tare_wt = Long(ads_report_inv_cust_scrap_skids_comb.Object.scrap_skid_scrap_tare_wt[ll_row])
		il_sum_scrap_tare_wt = il_sum_scrap_tare_wt + ll_scrap_skid_scrap_tare_wt
		
		ads_comb.Object.weight[ll_inserted_row] = ll_scrap_skid_scrap_tare_wt
		ads_comb.Object.net_weight_balance[ll_inserted_row] = ll_net_wt
		
		ls_weight_uom = "LBS"
		ads_comb.Object.weight_uom[ll_inserted_row] = ls_weight_uom
		
		//ldc_coil_gauge = ads_report_inv_cust_scrap_skids_comb.Object.coil_coil_gauge[ll_row]
		ads_comb.Object.coil_gauge[ll_inserted_row] = ls_coil_gauge
		
		//ldc_coil_width = ads_report_inv_cust_scrap_skids_comb.Object.coil_coil_width[ll_row]
		ads_comb.Object.coil_width[ll_inserted_row] = ls_coil_width
		
		//ls_material_number = ads_report_inv_cust_scrap_skids_comb.Object.coil_material_number[ll_row]
		ads_comb.Object.material_number[ll_inserted_row] = ls_material_number
		
		ls_duration = ads_report_inv_cust_scrap_skids_comb.Object.duration[ll_row]
		ads_comb.Object.duration[ll_inserted_row] = ls_duration
		
		ls_ab_job_number = String(ads_report_inv_cust_scrap_skids_comb.Object.scrap_skid_scrap_ab_job_num[ll_row])
		ads_comb.Object.ab_job_number[ll_inserted_row] = ls_ab_job_number
		
		ls_enduser_part_number = ""
		ads_comb.Object.enduser_part_number[ll_inserted_row] = ls_enduser_part_number
		
		ll_skid_pieces = 0
		ads_comb.Object.skid_pieces[ll_inserted_row] = ll_skid_pieces
		
		ll_item_pieces = 0
		ads_comb.Object.item_pieces[ll_inserted_row] = ll_item_pieces
		
		ads_comb.Object.coil_cash_date[ll_inserted_row] = ls_coil_cash_date

	End If
Next

//ads_report_inv_cust_skids_comb.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

ll_rows = ads_report_inv_cust_skids_comb.RowCount()
il_rows_skids = ll_rows

ls_material_type = "Skids"

For ll_row = 1 To ll_rows
	ls_status = ads_report_inv_cust_skids_comb.Object.skid_status_desc[ll_row]
	If IsNull(ls_status) Then ls_status = ""
	If Lower(ls_status) = "prerecap" Then Continue //Do not include skids in status "PreReCap" in this report
	
	ll_inserted_row = ads_comb.InsertRow(0)
	
	If ll_inserted_row > 0 Then
		ads_comb.Object.material_type[ll_inserted_row] = ls_material_type
		
//		//Customer
//		ll_coil_customer_id = ads_report_inv_cust_skids_comb.Object.customer_order_orig_customer_id[ll_row]
//		ls_find_string = "customer_id = " + String(ll_coil_customer_id)
//		ll_found_row = lds_customer_list.Find(ls_find_string, 1, lds_customer_list.RowCount())
//		
//		If ll_found_row > 0 Then
//			ls_customer_short_name = Trim(lds_customer_list.Object.customer_short_name[ll_found_row])
//		Else
//			ls_customer_short_name = ""
//		End If
//		
//		//Enduser
//		ll_coil_customer_id = ads_report_inv_cust_skids_comb.Object.customer_order_enduser_id[ll_row]
//		ls_find_string = "customer_id = " + String(ll_coil_customer_id)
//		ll_found_row = lds_customer_list.Find(ls_find_string, 1, lds_customer_list.RowCount())
//		
//		If ll_found_row > 0 Then
//			ls_enduser = Trim(lds_customer_list.Object.customer_short_name[ll_found_row])
//		Else
//			ls_enduser = ""
//		End If
		
		If li_rtn_coil_info = 1 Then //OK in wf_coil_info_4scrap_retrieve()
			ll_coil_abc_num = ads_report_inv_cust_skids_comb.Object.production_sheet_item_coil_abc_num[ll_row]
			If IsNull(ll_coil_abc_num) Then ll_coil_abc_num = 0
			
			If ll_coil_abc_num > 0 Then
				ls_coil_abc_num = String(ll_coil_abc_num)
				
				ls_find_string = "coil_abc_num = " + String(ll_coil_abc_num)
				ll_found_row = lds_coil_info_4scrap.Find(ls_find_string, 1, lds_coil_info_4scrap.RowCount())
				
				If ll_found_row > 0 Then
					ls_coil_org_num = Trim(lds_coil_info_4scrap.Object.coil_org_num[ll_found_row])
					ls_coil_mid_num = Trim(lds_coil_info_4scrap.Object.coil_mid_num[ll_found_row])
					ls_coil_gauge = String(lds_coil_info_4scrap.Object.coil_gauge[ll_found_row])
					ls_coil_width = String(lds_coil_info_4scrap.Object.coil_width[ll_found_row])
					ls_material_number = Trim(lds_coil_info_4scrap.Object.material_num[ll_found_row])
					ls_coil_alloy = Trim(lds_coil_info_4scrap.Object.coil_alloy2[ll_found_row])
					ls_coil_cash_date = Trim(lds_coil_info_4scrap.Object.cash_date[ll_found_row])
				Else
					ls_customer_short_name = ""
				End If
			Else
				ls_coil_abc_num = ""
				ls_coil_org_num = ""
				ls_coil_mid_num = ""
				ls_coil_gauge = ""
				ls_coil_width = ""
				ls_material_number = ""
				ls_coil_alloy = ""
				ls_coil_cash_date = ""
			End If
		End If
		
		ls_customer_short_name = Trim(ads_report_inv_cust_skids_comb.Object.customer_short_name[ll_row])
		ads_comb.Object.customer_short_name[ll_inserted_row] = ls_customer_short_name
		
		ls_enduser = Trim(ads_report_inv_cust_skids_comb.Object.enduser_name[ll_row])
		//ads_comb.Object.enduser[ll_inserted_row] = ls_enduser
		
		ls_status = ads_report_inv_cust_skids_comb.Object.skid_status_desc[ll_row]
		ads_comb.Object.status[ll_inserted_row] = ls_status
		
		ls_skid_number = ads_report_inv_cust_skids_comb.Object.sheet_skid_sheet_skid_display_num[ll_row]
		ads_comb.Object.skid_number[ll_inserted_row] = ls_skid_number
		
		ls_coil_abc_num = String(ads_report_inv_cust_skids_comb.Object.production_sheet_item_coil_abc_num[ll_row])
		ads_comb.Object.coil_abc_number[ll_inserted_row] = ls_coil_abc_num
		
		ls_coil_org_num = String(ads_report_inv_cust_skids_comb.Object.coil_coil_org_num[ll_row])
		ads_comb.Object.coil_org_number[ll_inserted_row] = ls_coil_org_num
		
		//ls_coil_mid_num = ""
		ads_comb.Object.coil_mid_number[ll_inserted_row] = ls_coil_mid_num

		ls_coil_lot_number = ads_report_inv_cust_skids_comb.Object.coil_lot_num[ll_row]
		ads_comb.Object.coil_lot_number[ll_inserted_row] = ls_coil_lot_number
		
		//ls_coil_alloy = ads_report_inv_cust_skids_comb.Object.cspec_t[ll_row]
		ads_comb.Object.coil_alloy[ll_inserted_row] = ls_coil_alloy
		
		//ls_coil_temper = ads_report_inv_cust_skids_comb.Object.scrap_skid_scrap_temper[ll_row]
		ads_comb.Object.coil_temper[ll_inserted_row] = ls_coil_temper
		
		ls_reference = ads_report_inv_cust_skids_comb.Object.order_item_enduser_part_num[ll_row]
		ads_comb.Object.reference[ll_inserted_row] = ls_reference
		
		ls_ddate = String(ads_report_inv_cust_skids_comb.Object.sheet_skid_skid_date[ll_row])
		ads_comb.Object.ddate[ll_inserted_row] = ls_ddate
		
		ll_net_wt = Long(ads_report_inv_cust_skids_comb.Object.sheet_skid_sheet_net_wt[ll_row])
		ads_comb.Object.weight[ll_inserted_row] = ll_net_wt
		il_sum_skid_net_wt = il_sum_skid_net_wt + ll_net_wt
		
		ll_item_net_wt = Long(ads_report_inv_cust_skids_comb.Object.production_sheet_item_prod_item_net_wt[ll_row])
		ads_comb.Object.net_weight_balance[ll_inserted_row] = ll_item_net_wt
		il_sum_item_net_wt = il_sum_item_net_wt + ll_item_net_wt
		
		ls_weight_uom = "LBS"
		ads_comb.Object.weight_uom[ll_inserted_row] = ls_weight_uom
		
		//ldc_coil_gauge = ads_report_inv_cust_skids_comb.Object.coil_coil_gauge[ll_row]
		ads_comb.Object.coil_gauge[ll_inserted_row] = ls_coil_gauge
		
		//ldc_coil_width = ads_report_inv_cust_skids_comb.Object.coil_coil_width[ll_row]
		ads_comb.Object.coil_width[ll_inserted_row] = ls_coil_width
		
		ls_material_number = ads_report_inv_cust_skids_comb.Object.material[ll_row]
		ads_comb.Object.material_number[ll_inserted_row] = ls_material_number
		
		ls_duration = ads_report_inv_cust_skids_comb.Object.duration[ll_row]
		ads_comb.Object.duration[ll_inserted_row] = ls_duration
		
		ls_ab_job_number = String(ads_report_inv_cust_skids_comb.Object.ab_job_ab_job_num[ll_row])
		ads_comb.Object.ab_job_number[ll_inserted_row] = ls_ab_job_number
		
		ls_enduser_part_number = ads_report_inv_cust_skids_comb.Object.order_item_enduser_part_num[ll_row]
		ads_comb.Object.enduser_part_number[ll_inserted_row] = ls_enduser_part_number
		
		//ls_skid_pieces = String(ads_report_inv_cust_skids_comb.Object.sheet_skid_skid_pieces[ll_row])
		ll_skid_pieces = ads_report_inv_cust_skids_comb.Object.sheet_skid_skid_pieces[ll_row]
		ads_comb.Object.skid_pieces[ll_inserted_row] = ll_skid_pieces
		il_sum_skid_pieces = il_sum_skid_pieces + ll_skid_pieces
		
		ll_item_pieces = ads_report_inv_cust_skids_comb.Object.production_sheet_item_prod_item_pieces[ll_row]
		ads_comb.Object.item_pieces[ll_inserted_row] = ll_item_pieces
		il_sum_item_pieces = il_sum_item_pieces + ll_item_pieces
		
		ads_comb.Object.coil_cash_date[ll_inserted_row] = ls_coil_cash_date
	End If
Next

il_rows_combined = ads_comb.RowCount()

//MessageBox("Totals",	"Coil rows: " + String(il_rows_coils) + "~n~r" + &
//							"Scrap rows: " + String(il_rows_scrap) + "~n~r" + &
//							"Skid rows: " + String(il_rows_skids) + "~n~r" + &
//							"Combined rows: " + String(il_rows_combined) + "~n~r~n~r" + &
//							"Coils~n~r" + &
//							"Sum Coil Net Wt: " + String(il_sum_coil_net_wt) + "~n~r" + &
//							"Sum Coil Net Wt Balance: " + String( il_sum_coil_net_wt_balance) + "~n~r~n~r" + &
//							"Scrap~n~r" + &
//							"Sum Scrap Net Wt: " + String(il_sum_scrap_net_wt) + "~n~r" + &
//							"Sum Scrap Tare Wt: " + String(il_sum_scrap_tare_wt) + "~n~r~n~r" + &
//							"Skids~n~r" + &
//							"Sum Skid Net Wt: " + String(il_sum_skid_net_wt) + "~n~r" + &
//							"Sum Item Net Wt: " + String(il_sum_item_net_wt) + "~n~r" + &
//							"Sum Skid Pieces: " + String(il_sum_skid_pieces) + "~n~r" + &
//							"Sum Item Pieces: " + String(il_sum_item_pieces) &
//							)

If IsValid(lds_coil_info_4scrap) Then Destroy lds_coil_info_4scrap
If IsValid(lds_customer_list) Then Destroy lds_customer_list

Return li_rtn
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. End
end function

public function integer wf_coil_info_4scrap_retrieve (ref datastore ads_coil_info_4scrap, string as_customer_id_string);//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
/*
Function:	wf_coil_info_4scrap_retrieve
Returns:		integer
Arguments:	reference	datastore	ads_coil_info_4scrap
				value			string		as_customer_id_string
*/

Integer	li_rtn = 1
Long		ll_rows
String	ls_sql_orig, ls_sql_add, ls_sql_new

ls_sql_orig = ads_coil_info_4scrap.GetSqlSelect()

If ls_sql_orig <> "" Then //OK
	ls_sql_add = "  and ( customer.customer_id in (" + as_customer_id_string + ") )"
	ls_sql_new = ls_sql_orig + ls_sql_add
	li_rtn = ads_coil_info_4scrap.SetSqlSelect(ls_sql_new)
	
	If li_rtn = 1 Then //OK
		ll_rows = ads_coil_info_4scrap.Retrieve()
		
		If ll_rows < 0 Then //DB error
			li_rtn = -1
		End If
	End If
Else
	li_rtn = -1
End If

Return li_rtn
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. End
end function

public subroutine wf_rename_files_comb (ref string as_attached_file_name[]);//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
/*
Function:	wf_rename_files_comb
Returns:		none
Arguments:	reference	string	as_attached_file_name[]
*/

Integer	li_totalitems, li_i, li_rtn, li_pos
Boolean	lb_report_4multiple_customers
Long		ll_customer_id[], ll_pos
String	ls_filename, ls_new_filename, ls_customer_short_name, ls_customer_name_arr[]
String	ls_prefix, ls_suffix

lb_report_4multiple_customers = wf_report_4multiple_customers(ls_customer_short_name) //Alex Gerlants. 06/08/2017
	
li_totalitems = UpperBound(as_attached_file_name[])

For li_i = 1 To li_totalitems
	ls_filename = as_attached_file_name[li_i]
	li_pos = Pos(ls_filename, "Inventory", 1)
	
	If li_pos > 0 Then
		wf_get_selected_customers(ll_customer_id[], ls_customer_name_arr[])
	
		If UpperBound(ll_customer_id[]) > 0 Then
			ls_customer_short_name = Upper(Left(Trim(ls_customer_name_arr[1]), 1)) + Lower(Mid(ls_customer_name_arr[1], 2, 6))
			
			ll_pos = Pos(ls_filename, "Inventory_Combined_Report", 1)
			
			If ll_pos > 0 Then
				ls_prefix = Left(ls_filename, ll_pos + 25)
				ls_suffix = Right(ls_filename, Len(ls_filename) - (ll_pos + 26))
				
				ls_new_filename = ls_prefix + "for_" + ls_customer_short_name + "_" + ls_suffix
			Else
				ls_new_filename = "Inventory Combined Report for Novelis"
			End if
			
			li_rtn = FileMove(ls_filename, ls_new_filename) //Rename
			
			If li_rtn = 1 Then //OK in FileMove
				as_attached_file_name[li_i] = ls_new_filename
			End If
		End if
	End If
Next
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. End
end subroutine

public subroutine wf_delete_emailed_files (string as_file_name_2email[]);//Alex Gerlants. Customer_Shipment_Rpt_All_Together. Begin
/*
Function:	wf_delete_emailed_files
Returns:		none
Arguments:	value	string	as_file_name_2email[]
*/

Integer	li_i
String	ls_file

For li_i = 1 To UpperBound(as_file_name_2email[])
	ls_file = as_file_name_2email[li_i]
	
	FileDelete(ls_file)
Next
//Alex Gerlants. Customer_Shipment_Rpt_All_Together. End
end subroutine

public function string wf_get_recipient_email ();Return is_send_email //Alex_Novelis_Auto_Combined_Report. 03/02/2018.
end function

public subroutine wf_popualate_email_addresses (string as_email_addresses[]);////
///*
//Function:	wf_popualate_email_addresses
//Returns:		none
//Arguments:	value 	string	as_email_addresses[]
//*/
//
//is_email_addresses[] = as_email_addresses[]
end subroutine

public function boolean wf_send_smtp_email_auto (string as_body, string as_attached_file_name[], string as_email_address);/*
Function:	wf_send_smtp_email_auto
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
				value	string	as_email_address			<== Email address to send to
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject(is_subject)
in_smtp.of_SetBody(as_body, False)

is_from_email = "albl_inventory_reports@albl.com" //Email address "from"
is_from_name = "ALBL Inventory Reports" //Name "from"
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
//ls_send_email = "agerlant@gmail.com"
//ls_send_email = "agerlants@albl.com"

ls_send_email = as_email_address
is_send_email = ls_send_email

in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return


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

public subroutine wf_get_customer_names (ref long al_customer_id[], ref string as_customer_short_name[]);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_get_customer_names
Returns:		none
Arguments:	reference	long		al_customer_id[]
				reference	string	as_customer_short_name[]
*/

//Long		ll_rows, ll_row, ll_customer_id_temp, ll_selected_row, ll_empty[]
Long		ll_customer_id_temp, ll_empty[]
String	ls_customer_short_name_temp, ls_empty[]

String	ls_find_string
Long		ll_i, ll_found_row

//First, delete all items from the input arrays.
al_customer_id[] = ll_empty[]
as_customer_short_name[] = ls_empty[]

al_customer_id[1] = 1153
al_customer_id[2] = 1459

For ll_i = 1 To UpperBound(al_customer_id[])
	ll_customer_id_temp = al_customer_id[ll_i]
	
	ls_find_string = "customer_id = " + String(ll_customer_id_temp)
	
	ll_found_row = dw_customer_short_list.Find(ls_find_string, 1, dw_customer_short_list.RowCount())
	
	If ll_found_row > 0 Then
		ls_customer_short_name_temp = dw_customer_short_list.Object.customer_short_name[ll_found_row]
		as_customer_short_name[UpperBound(as_customer_short_name[]) + 1] = ls_customer_short_name_temp
	End If
Next
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end subroutine

public function integer wf_auto_combined_4novelis (long al_customer_ids[]);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_auto_combined_4novelis
Returns:		integer
Argumants:	value	long		al_customer_ids[]
*/

Boolean	lb_rtn, lb_report_4multiple_customers, lb_unmatched_coils = False
String	ls_filename, ls_notetext, ls_attached_file_name[], ls_customer_short_name
String	ls_customer_name_arr[], ls_customer_string, ls_file
Long		ll_rows, ll_filteredcount, ll_row, ll_customer_id_temp, ll_customer_ids[]
Long		ll_selected_row, ll_i
Integer	li_rtn = 1
nv_test	lnv_test

DataStore	lds_report_inv_cust_coils_comb, lds_report_inv_cust_scrap_skids_comb, lds_report_inv_cust_skids_comb
DataStore	lds_comb

If IsValid(lds_report_inv_cust_coils_comb) Then Destroy lds_report_inv_cust_coils_comb
lds_report_inv_cust_coils_comb = Create DataStore
lds_report_inv_cust_coils_comb.DataObject = "d_report_inv_cust_coils_comb"

If IsValid(lds_report_inv_cust_scrap_skids_comb) Then Destroy lds_report_inv_cust_scrap_skids_comb
lds_report_inv_cust_scrap_skids_comb = Create DataStore
lds_report_inv_cust_scrap_skids_comb.DataObject = "d_report_inv_cust_scrap_skids_comb"

If IsValid(lds_report_inv_cust_skids_comb) Then Destroy lds_report_inv_cust_skids_comb
lds_report_inv_cust_skids_comb = Create DataStore
lds_report_inv_cust_skids_comb.DataObject = "d_report_inv_cust_skids_comb"

lds_comb =  Create DataStore
lds_comb.DataObject = "d_report_combined_inventory"

ib_xls_done_comb = False

//---------------------------------
//Initialize  test variables
//Displayed when cb_totals clicked
il_rows_coils = 0
il_rows_scrap = 0
il_rows_skids = 0
il_rows_combined = 0
il_sum_coil_net_wt = 0
il_sum_coil_net_wt_balance = 0
il_sum_scrap_net_wt = 0
il_sum_scrap_tare_wt = 0
il_sum_skid_net_wt = 0
il_sum_item_net_wt = 0
il_sum_skid_pieces = 0
il_sum_item_pieces = 0
//---------------------------------

li_rtn = Run(is_taskkill_bat_file, Minimized!) //Kill AcroRd32.exe processes. They slow down XLS creation

wf_delete_work_files("csv")
wf_delete_work_files("pdf")
wf_delete_email_files()

ib_xls_done = False
ib_xls_done_comb = False

//Alex Gerlants. 06/08/2017. Begin
If IsValid(lnv_test) Then Destroy nv_test
lnv_test = Create nv_test
lnv_test.of_set_work_folder(is_work_folder) //Set work folder in lnv_test

ll_customer_ids[] = al_customer_ids[]

If UpperBound(ll_customer_ids[]) > 0 Then
	ls_customer_short_name = ""

	li_rtn = lnv_test.of_report_inv_cust_coils_comb_auto(ll_customer_ids[], lds_report_inv_cust_coils_comb)
	
	If li_rtn = -2 Then lb_unmatched_coils = True

	//If li_rtn =  1 Then
		li_rtn = lnv_test.of_report_inv_cust_scrap_skids_comb(ll_customer_ids[], lds_report_inv_cust_scrap_skids_comb)
		
		//ll_rows = lds_report_inv_cust_scrap_skids_comb.RowCount()
		lds_report_inv_cust_scrap_skids_comb.SetSort("scrap_skid_scrap_skid_display_num Asc")
		lds_report_inv_cust_scrap_skids_comb.Sort()
		
		If li_rtn =  1 Then
			li_rtn = lnv_test.of_report_inv_cust_skids_comb(ll_customer_ids[], lds_report_inv_cust_skids_comb)
			
			//ll_rows = lds_report_inv_cust_skids_comb.RowCount()
			lds_report_inv_cust_skids_comb.SetSort("sheet_skid_sheet_skid_display_num Asc")
			lds_report_inv_cust_skids_comb.Sort()
			
			If li_rtn = 1 Then
				//Transfer data from the 3 _comb datastores into lds_comb
				wf_combine_data	(	lds_report_inv_cust_coils_comb, &
											lds_report_inv_cust_scrap_skids_comb, &
											lds_report_inv_cust_skids_comb, &
											lds_comb, &
											ll_customer_ids[] &
										)
				is_file_name_2email = "Inventory"
				
				If Right(is_email_folder, 1) <> "\" Then
					is_email_folder = is_email_folder + "\"
				End If

				ls_file = is_email_folder + "Inventory_Combined_Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"
				
				li_rtn = lds_comb.SaveAs(ls_file, Excel!, True) //"True" is to include headings
				
				If li_rtn = 1 Then //OK
					ib_xls_done_comb = True
				End if
			End If
		End If
	//End If
End If

If IsValid(lnv_test) Then Destroy nv_test
If IsValid(lds_report_inv_cust_coils_comb) Then Destroy lds_report_inv_cust_coils_comb
If IsValid(lds_report_inv_cust_scrap_skids_comb) Then Destroy lds_report_inv_cust_scrap_skids_comb
If IsValid(lds_report_inv_cust_skids_comb) Then Destroy lds_report_inv_cust_skids_comb
If IsValid(lds_comb) Then Destroy lds_comb

If lb_unmatched_coils Then
	Return -2
Else
	Return li_rtn
End If
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end function

public function integer wf_auto_pdf_4others (long al_customer_ids[]);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_auto_pdf_4others
Returns:		value	long		al_customer_ids[]
Argumants:	none
*/

//Boolean	lb_rtn, lb_report_4multiple_customers
String	ls_filename, ls_notetext, ls_attached_file_name[]
Long		ll_rows, ll_filteredcount, ll_row, ll_customer_id_temp
Long		ll_selected_row, ll_i
Integer	li_rtn = 1
String	ls_customer_short_name, ls_customer_string, ls_customer_name_arr[]
String	ls_run_message
nv_test	lnv_test

wf_delete_work_files("pdf")
wf_delete_email_files()

ib_pdf_done = False
ib_xls_done_comb = False


If IsValid(lnv_test) Then Destroy nv_test
lnv_test = Create nv_test
lnv_test.of_set_work_folder(is_work_folder) //Set work folder in lnv_test
	
If UpperBound(al_customer_ids[]) > 0 Then
	ls_customer_short_name = ""
	
	li_rtn = lnv_test.of_report_inv_cust_coils_auto(al_customer_ids[], ls_customer_short_name, "pdf") //New function: of_report_inv_cust_coils_auto
	
	If li_rtn = 1 Then
		li_rtn = lnv_test.of_report_inv_cust_skids(al_customer_ids[], ls_customer_short_name, "pdf")
		
		If li_rtn = 1 Then
			li_rtn = lnv_test.of_report_inv_cust_scrap_skids(al_customer_ids[], ls_customer_short_name, "pdf")
		End If
	End If
	
	For ll_i = 1 To UpperBound(ls_customer_name_arr[])
		ls_customer_string = ls_customer_string + "~n~r~t" + Trim(ls_customer_name_arr[ll_i])
	Next
	
	If li_rtn = 1 Then
		ib_pdf_done = True
		
		If UpperBound(al_customer_ids[]) > 0 Then
			If UpperBound(ls_customer_name_arr[]) <= 0 Then
				wf_get_customer_names_other(al_customer_ids[], ls_customer_name_arr[])
			End If
		
			If UpperBound(al_customer_ids[]) = 1 Then
				ls_run_message = "PDF for other customer " + Upper(Trim(ls_customer_name_arr[1])) + " created successfully"
				li_rtn = wf_insert_auto_run_log(ls_run_message)
			Else
				ls_run_message = "PDF for other customers " + Upper(ls_customer_string) + " created successfully"
				li_rtn = wf_insert_auto_run_log(ls_run_message)
			End If
		End If
	Else
		ls_run_message = "Error creating PDF for other customers. Please call application support."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	End If
End If

If IsValid(lnv_test) Then Destroy nv_test

Return li_rtn
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end function

public function integer wf_auto_xls_4others (long al_customer_ids[]);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_auto_xls_4others
Returns:		integer
Argumants:	value	long		al_customer_ids[]
*/

//Boolean	lb_rtn, lb_report_4multiple_customers
String	ls_filename, ls_notetext, ls_attached_file_name[], ls_customer_short_name
String	ls_customer_name_arr[], ls_customer_string, ls_run_message
Long		ll_rows, ll_filteredcount, ll_row, ll_customer_id_temp, ll_customer_id[]
Long		ll_selected_row, ll_i
Integer	li_rtn = 1
nv_test	lnv_test

li_rtn = Run(is_taskkill_bat_file, Minimized!) //Kill AcroRd32.exe processes. They slow down XLS creation

wf_delete_work_files("csv")
wf_delete_email_files()

ib_xls_done = False
ib_xls_done_comb = False

If IsValid(lnv_test) Then Destroy nv_test
lnv_test = Create nv_test
lnv_test.of_set_work_folder(is_work_folder) //Set work folder in lnv_test
	
If UpperBound(al_customer_ids[]) > 0 Then
	ls_customer_short_name = ""

	li_rtn = lnv_test.of_report_inv_cust_coils_auto(al_customer_ids[], ls_customer_short_name, "xls")

	If li_rtn =  1 Then
		li_rtn = lnv_test.of_report_inv_cust_scrap_skids(al_customer_ids[], ls_customer_short_name, "xls")
		
		If li_rtn =  1 Then
			li_rtn = lnv_test.of_report_inv_cust_skids(al_customer_ids[], ls_customer_short_name, "xls")
		End If
	End If
	
	For ll_i = 1 To UpperBound(ls_customer_name_arr[])
		ls_customer_string = ls_customer_string + "~n~r~t" + Trim(ls_customer_name_arr[ll_i])
	Next
	
	If li_rtn = 1 Then
		ib_xls_done = True
		
		If UpperBound(al_customer_ids[]) > 0 Then
			
			If UpperBound(ls_customer_name_arr[]) <= 0 Then
				wf_get_customer_names_other(al_customer_ids[], ls_customer_name_arr[])
			End If
			
			If UpperBound(al_customer_ids[]) = 1 Then
				ls_run_message = "XLS for customer " + Upper(Trim(ls_customer_name_arr[1])) + " created successfully"
				li_rtn = wf_insert_auto_run_log(ls_run_message)
			Else
				ls_run_message = "XLS for other customers " + Upper(ls_customer_string) + " created successfully"
				li_rtn = wf_insert_auto_run_log(ls_run_message)
			End If
		End If
	Else
		ls_run_message = "Error creating XLS for other customers. Please call application support."
		li_rtn = wf_insert_auto_run_log(ls_run_message)
	End If
End If

If IsValid(lnv_test) Then Destroy nv_test

Return li_rtn
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end function

public function integer wf_auto_email_4novelis (string as_email_address, boolean ab_archive_files, boolean ab_unmatched_coils);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_auto_email_4novelis
Returns:		integer
Arguments:	value	string	as_email_address	<== 	Email address to email to
				value	boolean	ab_archive_files	<== 	It controls when to move files from ls_attached_file_name[] to archive folder.
																 	Because this function is called in a loop from w_run_report, the attached files
																 	are moved to acrhive folder when the last iteration in w_run_report is done.
				value	boolean	ab_unmatched_coils
*/

//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
Boolean	lb_rtn
Boolean	lb_report_4multiple_customers //Alex Gerlants. 06/08/2017
String	ls_filename, ls_notetext, ls_attached_file_name[], ls_customer_short_name
String	ls_subject_save, ls_customer_name_arr[], ls_customer_name_temp, ls_customer_name_string
String	ls_subject, ls_email_address, ls_run_message
String	ls_customer_names
String	ls_unmatched_coils_list
Integer	li_totalitems, li_i, li_rtn = 1, li_j

Integer	li_counter = 0
Boolean	lb_fileexists = False
Pointer 	oldpointer
Long		ll_customer_id, ll_customer_id_arr[], ll_i

oldpointer = SetPointer(HourGlass!)

//Load file into lb_files
li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email)

If li_totalitems <= 0 Then
	//Wait for 7 seconds
	Sleep(7) 
	
	//Try again
	li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email)
End If

If li_totalitems > 0 Then
	//Get file names from lb_files to attach to email
	For li_i = 1 To li_totalitems
		lb_files.SelectItem(li_i)
		ls_filename = lb_files.SelectedItem()
		ls_filename = is_email_folder + ls_filename
		ls_attached_file_name[UpperBound(ls_attached_file_name[]) + 1] = ls_filename
	Next
	
	wf_rename_files_comb(ls_attached_file_name[])
	
	//Email ls_filename
	ls_notetext = ""
	ls_subject_save = is_subject //Save is_subject
	is_subject = f_get_ini_value("inventory_reports","smtp_email","subject","Inventory Reports")
	ls_subject = "Inventory Combined Report"

	//wf_get_selected_customers(ll_customer_id_arr[], ls_customer_name_arr[])
	wf_get_customer_names(ll_customer_id_arr[], ls_customer_name_arr[])
	
	For li_j = 1 To UpperBound(ls_customer_name_arr[])
		ls_customer_name_temp = ls_customer_name_arr[li_j]
		ls_customer_names = ls_customer_names + Trim(ls_customer_name_temp) + ", "
	Next
	
	//Remove the last comma
	ls_customer_names = Left(ls_customer_names, Len(ls_customer_names) - 2)
	
	If ab_unmatched_coils Then
		ls_unmatched_coils_list = wf_unmatched_coils_list_auto(ll_customer_id_arr[])
		
		ls_notetext = "Please find attached Inventory Combined Report for " + ls_customer_names + ". ~n~rCoils with mismatched status:~n~r" + ls_unmatched_coils_list
		is_subject = ls_subject + " for " + Left(Upper(ls_customer_name_arr[1]), 7) + ". Mismatched coil status found."
	Else
		ls_notetext = "Please find attached Inventory Combined Report for " + Left(Upper(ls_customer_name_arr[1]), 7)
		is_subject = ls_subject + " for " +  Left(Upper(ls_customer_name_arr[1]), 7)
	End If
	
	If UpperBound(ls_attached_file_name[]) > 0 Then

		lb_rtn = wf_send_smtp_email_auto(ls_notetext, ls_attached_file_name[], as_email_address)
		
		//Move files in ls_attached_file_name[] to c:\temp\archive
		If ab_archive_files Then
			wf_move_files(ls_attached_file_name[])
		End If
		
		ib_xls_done_comb = False
	End If
End If

is_subject = ls_subject_save //Restore is_subject
SetPointer(oldpointer)

Return li_rtn
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end function

public function string wf_unmatched_coils_list_auto (long al_customer_id[]);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_unmatched_coils_list_auto
Returns:		string	<== Unmatched coils list
Arguments:	value			long		al_customer_id[]
*/

Integer		li_rtn = 1
DataStore	lds_unmatched_coils
Long			ll_i, ll_customer_id_temp, ll_coil_abc_num_temp, ll_rows, ll_row
String		ls_customer_name_temp, ls_unmatched_coils_list

lds_unmatched_coils = Create DataStore
lds_unmatched_coils.DataObject = "d_unmatched_coils"
lds_unmatched_coils.SetTransObject(sqlca)

ls_unmatched_coils_list = ""

For ll_i = 1 To UpperBound(al_customer_id[])
	ll_customer_id_temp = al_customer_id[ll_i]

	ll_rows = lds_unmatched_coils.Retrieve(ll_customer_id_temp, ll_customer_id_temp)
	
	If ll_rows >= 0 Then
		ls_customer_name_temp = wf_get_customer_name(ll_customer_id_temp)
		
		For ll_row = 1 To ll_rows
			ll_coil_abc_num_temp = lds_unmatched_coils.Object.coil_abc_num[ll_row]
			ls_unmatched_coils_list = ls_unmatched_coils_list + ls_customer_name_temp + ": " + String(ll_coil_abc_num_temp) + "~n~r"
		Next
	Else //DB error
		li_rtn = -1
		ls_unmatched_coils_list = "Database error occurred in wf_unmatched_coils_list_auto for w_inventory_reports while retrieving data for unmatched coils."
		Exit
	End If
Next

//If li_rtn = 1 Then //OK
//	If Len(ls_unmatched_coils_list) > 0 Then
//		//Remove the last comma
//		ls_unmatched_coils_list = Left(ls_unmatched_coils_list, Len(ls_unmatched_coils_list) - 2)
//	End If
//End If

Return ls_unmatched_coils_list
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end function

public function string wf_get_customer_name (long al_customer_id);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_get_customer_name
Returns:		string	<== customer name
Arguments:	value			long		al_customer_id
*/

String	ls_customer_name
	
select	rtrim(ltrim(customer_short_name))
into		:ls_customer_name
from		customer
where		customer_id = :al_customer_id
using		sqlca;

Return ls_customer_name
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End	
end function

public function integer wf_auto_email_4others (long al_customer_ids[], string as_email_address, boolean ab_first_iteration, boolean ab_last_iteration);//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
/*
Function:	wf_auto_email_4others
Returns:		integer
Arguments:	value			long		al_customer_ids[]
				value			string	as_email_address			<== Email address to email to
				value			boolean	ab_first_iteration
				value			boolean	ab_last_iteration			<== It controls when to move files from ls_attached_file_name[]
																				 to archive folder Because this function is called in a loop from
																				 w_run_report, 
																		 		 The attached files are moved to acrhive folder when the las
																				 iteration in w_run_report is done.
*/

Boolean	lb_rtn
Boolean	lb_report_4multiple_customers //Alex Gerlants. 06/08/2017
String	ls_filename, ls_notetext, ls_attached_file_name[], ls_customer_short_name
String	ls_subject_save, ls_customer_name_arr[], ls_customer_name_temp, ls_customer_name_string
String	ls_unmatched_coils_list, ls_customer_name_list
Integer	li_totalitems, li_i

Integer	li_rtn = 1, li_counter = 0
Boolean	lb_fileexists = False
//Pointer 	oldpointer //Declare a pointer variable
Long		ll_customer_id, ll_customer_id_arr[], ll_i

//oldpointer = SetPointer(HourGlass!)

ls_unmatched_coils_list = wf_unmatched_coils_list_auto(al_customer_ids[])

//Get customer name list
For li_i = 1 To UpperBound(al_customer_ids[])
	ls_customer_name_temp = wf_get_customer_name(al_customer_ids[li_i])
	ls_customer_name_list = ls_customer_name_list + ls_customer_name_temp + ", "
Next

//Remove thhe last comma
ls_customer_name_list = Left(ls_customer_name_list, Len(ls_customer_name_list) - 2)

If ab_first_iteration Then
	If ib_xls_done Or ib_pdf_done Then
		li_rtn = Run(is_combine_bat_file, Minimized!) //Combine the 3 reports in C:\abis\combpdf.bat
		//ib_pdf_done = False
	Else
		//MessageBox("Nothing to do", "Please create PDF and/or XLS to email", StopSign!)
		//dw_name.SetFocus()
		//Return -2
	End If
	
	//If ib_xls_done Then
		lb_fileexists = FileExists(is_work_folder + "Inventory_all.csv")
		
		If lb_fileexists Then
			excel_open_csv_saveas_xls()
		Else
			//Wait for 7 seconds
			Sleep(7) 
		
			//Try again
			lb_fileexists = FileExists(is_work_folder + "Inventory_all.csv")
			
			If lb_fileexists Then
				excel_open_csv_saveas_xls()
				//ib_xls_done = False
			End if
		End If
	//End If
	
	//Load file into lb_files
	li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email)
	
	If li_totalitems <= 0 Then
		//Wait for 7 seconds
		Sleep(7) 
		
		//Try again
		li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email)
	End If
	
	If li_totalitems > 0 Then
		//Get file names from lb_files to attach to email
		For li_i = 1 To li_totalitems
			lb_files.SelectItem(li_i)
			ls_filename = lb_files.SelectedItem()
			ls_filename = is_email_folder + ls_filename
			ls_attached_file_name[UpperBound(ls_attached_file_name[]) + 1] = ls_filename
		Next
		
		wf_rename_files(ls_attached_file_name[])

		is_attached_file_name[] = ls_attached_file_name[]
	End If
End If
	
//Email ls_filename
ls_subject_save = is_subject //Save is_subject
is_subject = f_get_ini_value("inventory_reports","smtp_email","subject","Inventory Reports")
	
If Len(ls_unmatched_coils_list) > 0 Then //There are coils with unmatched status
	ls_notetext = "Please find attached Inventory Report for " + ls_customer_name_list + "~n~rCoils with mismatched status:~n~r" + ls_unmatched_coils_list
	is_subject = is_subject +  " for " + ls_customer_name_list + ". Mismatched coil status found."
Else //OK
	ls_notetext = "Please find attached Inventory Report for " + ls_customer_name_list
	is_subject = is_subject +  " for " + ls_customer_name_list
End If

If UpperBound(is_attached_file_name[]) > 0 Then
	lb_rtn = wf_send_smtp_email_auto(ls_notetext, is_attached_file_name[], as_email_address)
	
	//Move files in is_attached_file_name[] to c:\temp\archive
	If ab_last_iteration Then
		wf_move_files(is_attached_file_name[])
		
		ib_xls_done = False
		ib_pdf_done = False
	End If
Else //UpperBound(is_attached_file_name[]) = 0
	ls_notetext = "No data retrieved for " + ls_customer_name_list
	lb_rtn = wf_send_smtp_email_auto(ls_notetext, is_attached_file_name[], as_email_address)
End If

is_subject = ls_subject_save //Restore is_subject

Return li_rtn
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End
end function

public function boolean wf_send_smtp_email_coils_produced (string as_body, string as_attached_file_name[], string as_email_address);/*
Function:	wf_send_smtp_email_coils_produced
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
				value	string	as_email_address			<== Email address to send to
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject("Coils Processed Report")
in_smtp.of_SetBody(as_body, False)

is_from_email = "albl_coils_processed_report@albl.com" //Email address "from"
is_from_name = "ALBL Coils Processed Report" //Name "from"
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
//ls_send_email = "agerlant@gmail.com"
//ls_send_email = "agerlants@albl.com"

ls_send_email = as_email_address
is_send_email = ls_send_email

in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return


end function

public subroutine wf_get_customer_names_other (long al_customer_id[], ref string as_customer_short_name[]);//Alex_Novelis_Auto_Combined_Report. 06/05/2018. Begin
/*
Function:	wf_get_customer_names_other
Returns:		none
Arguments:	value			long		al_customer_id[]
				reference	string	as_customer_short_name[]
*/

//Long		ll_rows, ll_row, ll_customer_id_temp, ll_selected_row, ll_empty[]
Long		ll_customer_id_temp, ll_empty[]
String	ls_customer_short_name_temp, ls_empty[]

String	ls_find_string
Long		ll_i, ll_found_row

//First, delete all items from the input array.
as_customer_short_name[] = ls_empty[]

For ll_i = 1 To UpperBound(al_customer_id[])
	ll_customer_id_temp = al_customer_id[ll_i]
	
	ls_find_string = "customer_id = " + String(ll_customer_id_temp)
	
	ll_found_row = dw_customer_short_list.Find(ls_find_string, 1, dw_customer_short_list.RowCount())
	
	If ll_found_row > 0 Then
		ls_customer_short_name_temp = dw_customer_short_list.Object.customer_short_name[ll_found_row]
		as_customer_short_name[UpperBound(as_customer_short_name[]) + 1] = ls_customer_short_name_temp
	End If
Next
//Alex_Novelis_Auto_Combined_Report. 06/05/2018. End
end subroutine

public function boolean wf_send_smtp_email_coil_863 (string as_body, string as_attached_file_name[], string as_email_address);/*
Function:	wf_send_smtp_email_coil_863
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
				value	string	as_email_address			<== Email address to send to
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject("Coil Inventory 863 Report")
in_smtp.of_SetBody(as_body, False)

is_from_email = "albl_coil_inventory_863_report@albl.com" //Email address "from"
is_from_name = "ALBL Coil Inventory 863 Report" //Name "from"
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
//ls_send_email = "agerlant@gmail.com"
//ls_send_email = "agerlants@albl.com"

ls_send_email = as_email_address
is_send_email = ls_send_email

in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return


end function

public function boolean wf_send_smtp_email_coils_weight_zeroed (string as_body, string as_attached_file_name[], string as_email_address);//Alex Gerlants. coils_weight_zeroed_out. Begin
/*
Function:	wf_send_smtp_email_coils_weight_zeroed
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
				value	string	as_email_address			<== Email address to send to
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject("Coils Weight Zeroed Out Report")
in_smtp.of_SetBody(as_body, False)

is_from_email = "albl_coils_weight_zeroed_out@albl.com" //Email address "from"
is_from_name = "ALBL Coils Weight Zeroed Out Report" //Name "from"
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
//ls_send_email = "agerlant@gmail.com"
//ls_send_email = "agerlants@albl.com"

ls_send_email = as_email_address
is_send_email = ls_send_email

in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return
//Alex Gerlants. coils_weight_zeroed_out. End

end function

public function boolean wf_send_smtp_email_qr_report (string as_body, string as_attached_file_name[], string as_email_address);//Alex Gerlants. coils_weight_zeroed_out. Begin
/*
Function:	wf_send_smtp_email_qr_report
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
				value	string	as_email_address			<== Email address to send to
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject("QR Report")
in_smtp.of_SetBody(as_body, False)

is_from_email = "qr_report@albl.com" //Email address "from"
is_from_name = "QR Report" //Name "from"
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
//ls_send_email = "agerlant@gmail.com"
//ls_send_email = "agerlants@albl.com"

ls_send_email = as_email_address
is_send_email = ls_send_email

in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return
//Alex Gerlants. coils_weight_zeroed_out. End

end function

public function boolean wf_send_smtp_email_aleris_report (string as_body, string as_attached_file_name[], string as_email_address);//Alex Gerlants. coils_weight_zeroed_out. Begin
/*
Function:	wf_send_smtp_email_aleris_report
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
				value	string	as_email_address			<== Email address to send to
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject("Aleris Skid Count Shipment Report")
in_smtp.of_SetBody(as_body, False)

is_from_email = "Aleris_Report@albl.com" //Email address "from"
is_from_name = "Aleris Report" //Name "from"
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
//ls_send_email = "agerlant@gmail.com"
//ls_send_email = "agerlants@albl.com"

ls_send_email = as_email_address
is_send_email = ls_send_email

in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return
//Alex Gerlants. coils_weight_zeroed_out. End

end function

public function boolean wf_send_smtp_email_onhold_report (string as_body, string as_attached_file_name[], string as_email_address);//Alex Gerlants. 09/27/2019. On-Hold. Begin
/*
Function:	wf_send_smtp_email_onhold_report
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
				value	string	as_email_address			<== Email address to send to
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject("On-Hold Report")
in_smtp.of_SetBody(as_body, False)

is_from_email = "On-Hold_Report@albl.com" //Email address "from"
is_from_name = "On-Hold Report" //Name "from"
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
//ls_send_email = "agerlant@gmail.com"
//ls_send_email = "agerlants@albl.com"

ls_send_email = as_email_address
is_send_email = ls_send_email

in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return
//Alex Gerlants. 09/27/2019. On-Hold. End

end function

public function boolean wf_send_smtp_email_onhold_report_monthly (string as_body, string as_attached_file_name[], string as_email_address);//Alex Gerlants. 09/27/2019. On-Hold. Begin
/*
Function:	wf_send_smtp_email_onhold_report_monthly
Returns:		boolean
Arguments:	value	string	as_body						<== Email body text
				value	string	as_attached_file_name[]	<== Files to attach to email.
				value	string	as_email_address			<== Email address to send to
*/

UInt 		lui_port
Boolean	lb_Return
Integer	li_i, li_number_of_files
String	ls_filename, ls_send_email

lui_port = Long(ii_port)

// *** Set email properties *********************
in_smtp.of_ResetAll()
in_smtp.of_SetPort(lui_port)
in_smtp.of_SetServer(is_server)
in_smtp.of_SetLogFile(True, is_logfile)
in_smtp.of_SetDebugViewer(ib_debugviewer)
in_smtp.of_SetSubject("On-Hold Report Monthly")
in_smtp.of_SetBody(as_body, False)

is_from_email = "On-Hold_Report_Monthly@albl.com" //Email address "from"
is_from_name = "On-Hold Report Monthly" //Name "from"
in_smtp.of_SetFrom(is_from_email, is_from_name)

ls_send_email = sle_email_address.Text
//ls_send_email = "agerlant@gmail.com"
//ls_send_email = "agerlants@albl.com"

ls_send_email = as_email_address
is_send_email = ls_send_email

in_smtp.of_AddAddress(ls_send_email, is_send_name)

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If

// *** Add any attachments **********************
li_number_of_files = UpperBound(as_attached_file_name[])

For li_i = 1 To li_number_of_files
	ls_filename = as_attached_file_name[li_i]
	in_smtp.of_AddAttachment(ls_filename)
Next

// *** send the message *************************
lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

Return lb_Return
//Alex Gerlants. 09/27/2019. On-Hold. End

end function

on w_inventory_reports.create
int iCurrent
call super::create
this.dw_report_auto_run_log=create dw_report_auto_run_log
this.cb_totals=create cb_totals
this.cb_email_comb=create cb_email_comb
this.cb_create_comb=create cb_create_comb
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.cb_start_fresh=create cb_start_fresh
this.cb_4=create cb_4
this.cb_archive_folder=create cb_archive_folder
this.sle_archive_folder=create sle_archive_folder
this.dw_abis_ini=create dw_abis_ini
this.st_3=create st_3
this.st_2=create st_2
this.sle_email_address=create sle_email_address
this.cb_unselect=create cb_unselect
this.cb_close=create cb_close
this.st_1=create st_1
this.cb_run_bat=create cb_run_bat
this.cb_2=create cb_2
this.dw_report_inv_cust_coils=create dw_report_inv_cust_coils
this.cb_1=create cb_1
this.cb_email=create cb_email
this.cb_create_xls=create cb_create_xls
this.cb_files=create cb_files
this.lb_files=create lb_files
this.dw_name=create dw_name
this.cb_create_pdf=create cb_create_pdf
this.dw_customer_short_list=create dw_customer_short_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report_auto_run_log
this.Control[iCurrent+2]=this.cb_totals
this.Control[iCurrent+3]=this.cb_email_comb
this.Control[iCurrent+4]=this.cb_create_comb
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.cb_start_fresh
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cb_archive_folder
this.Control[iCurrent+11]=this.sle_archive_folder
this.Control[iCurrent+12]=this.dw_abis_ini
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.sle_email_address
this.Control[iCurrent+16]=this.cb_unselect
this.Control[iCurrent+17]=this.cb_close
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.cb_run_bat
this.Control[iCurrent+20]=this.cb_2
this.Control[iCurrent+21]=this.dw_report_inv_cust_coils
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.cb_email
this.Control[iCurrent+24]=this.cb_create_xls
this.Control[iCurrent+25]=this.cb_files
this.Control[iCurrent+26]=this.lb_files
this.Control[iCurrent+27]=this.dw_name
this.Control[iCurrent+28]=this.cb_create_pdf
this.Control[iCurrent+29]=this.dw_customer_short_list
end on

on w_inventory_reports.destroy
call super::destroy
destroy(this.dw_report_auto_run_log)
destroy(this.cb_totals)
destroy(this.cb_email_comb)
destroy(this.cb_create_comb)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.cb_start_fresh)
destroy(this.cb_4)
destroy(this.cb_archive_folder)
destroy(this.sle_archive_folder)
destroy(this.dw_abis_ini)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_email_address)
destroy(this.cb_unselect)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.cb_run_bat)
destroy(this.cb_2)
destroy(this.dw_report_inv_cust_coils)
destroy(this.cb_1)
destroy(this.cb_email)
destroy(this.cb_create_xls)
destroy(this.cb_files)
destroy(this.lb_files)
destroy(this.dw_name)
destroy(this.cb_create_pdf)
destroy(this.dw_customer_short_list)
end on

event open;call super::open;String	ls_port, ls_send_email
Long		ll_rows, ll_row

dw_name.InsertRow(0)
SetFocus(dw_name)

is_from_email = gnv_app.of_GetUserId() + gs_albl_email_address //Email address "from"
//is_from_email = "inventoryreports@albl.com" //Email address "from"

is_from_name = gnv_app.of_GetUserId() //Name "from"
//is_from_name = "ALBL Inventory Reports" //Name "from"

dw_customer_short_list.SetTransObject(sqlca)
dw_customer_short_list.Retrieve()

dw_abis_ini.SetTransObject(sqlca)
ll_rows = dw_abis_ini.Retrieve("inventory_reports")

dw_report_auto_run_log.SetTransObject(sqlca)

ws_populate_abis_ini_variables(ll_rows)

wf_delete_work_files("pdf")
wf_delete_work_files("csv")
wf_delete_email_files()

ib_pdf_done = False
ib_xls_done = False
ib_xls_done_comb = False

//Create the 3 required folders if they don't exist
If Not DirectoryExists(is_work_folder) Then
	CreateDirectory(is_work_folder)
End If

If Not DirectoryExists(is_email_folder) Then
	CreateDirectory(is_email_folder)
End If

If Not DirectoryExists(is_archive_folder) Then
	CreateDirectory(is_archive_folder)
End If

cb_totals.Visible = False



end event

event pfc_postopen;call super::pfc_postopen;This.Width = 1800
This.Height = 1800
end event

type dw_report_auto_run_log from datawindow within w_inventory_reports
integer x = 1971
integer y = 582
integer width = 110
integer height = 237
integer taborder = 60
string title = "none"
string dataobject = "d_report_auto_run_log"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_totals from commandbutton within w_inventory_reports
integer x = 1342
integer y = 464
integer width = 410
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Display Totals"
end type

event clicked;If il_rows_combined > 0 Then	
	MessageBox("Totals",	"Coil rows: " + String(il_rows_coils) + "~n~r" + &
								"Scrap rows: " + String(il_rows_scrap) + "~n~r" + &
								"Skid rows: " + String(il_rows_skids) + "~n~r" + &
								"Combined rows: " + String(il_rows_combined) + "~n~r~n~r" + &
								"Coils~n~r" + &
								"Sum Coil Net Wt: " + String(il_sum_coil_net_wt) + "~n~r" + &
								"Sum Coil Net Wt Balance: " + String( il_sum_coil_net_wt_balance) + "~n~r~n~r" + &
								"Scrap~n~r" + &
								"Sum Scrap Net Wt: " + String(il_sum_scrap_net_wt) + "~n~r" + &
								"Sum Scrap Tare Wt: " + String(il_sum_scrap_tare_wt) + "~n~r~n~r" + &
								"Skids~n~r" + &
								"Sum Skid Net Wt: " + String(il_sum_skid_net_wt) + "~n~r" + &
								"Sum Item Net Wt: " + String(il_sum_item_net_wt) + "~n~r" + &
								"Sum Skid Pieces: " + String(il_sum_skid_pieces) + "~n~r" + &
								"Sum Item Pieces: " + String(il_sum_item_pieces) &
								)
Else
	MessageBox("Cannot display totals", "Please create report first", StopSign!)								
End If								
end event

type cb_email_comb from commandbutton within w_inventory_reports
integer x = 1342
integer y = 352
integer width = 410
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Email Combined"
end type

event clicked;//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
Boolean	lb_rtn
Boolean	lb_report_4multiple_customers //Alex Gerlants. 06/08/2017
String	ls_filename, ls_notetext, ls_attached_file_name[], ls_customer_short_name
String	ls_subject_save, ls_customer_name_arr[], ls_customer_name_temp, ls_customer_name_string
String	ls_subject
Integer	li_totalitems, li_i

Integer	li_rtn, li_counter = 0
Boolean	lb_fileexists = False
Pointer 	oldpointer
Long		ll_customer_id, ll_customer_id_arr[], ll_i

oldpointer = SetPointer(HourGlass!)

If Not ib_xls_done_comb Then
	MessageBox("Nothing to do", "Please create combined XLS to email", StopSign!)
	dw_name.SetFocus()
	Return
End If

//Load file into lb_files
li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email)

If li_totalitems <= 0 Then
	//Wait for 7 seconds
	Sleep(7) 
	
	//Try again
	li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email)
End If

If li_totalitems > 0 Then
	//Get file names from lb_files to attach to email
	For li_i = 1 To li_totalitems
		lb_files.SelectItem(li_i)
		ls_filename = lb_files.SelectedItem()
		ls_filename = is_email_folder + ls_filename
		ls_attached_file_name[UpperBound(ls_attached_file_name[]) + 1] = ls_filename
	Next
	
	wf_rename_files_comb(ls_attached_file_name[])
	
	//Email ls_filename
	ls_notetext = ""
	ls_subject_save = is_subject //Save is_subject
	is_subject = f_get_ini_value("inventory_reports","smtp_email","subject","Inventory Reports")
	ls_subject = "Inventory Combined Report"

	wf_get_selected_customers(ll_customer_id_arr[], ls_customer_name_arr[])
	
	ls_notetext = "Please find attached Inventory Combined Report for " + Left(Upper(ls_customer_name_arr[1]), 7)
	is_subject = ls_subject + " for " +  Left(Upper(ls_customer_name_arr[1]), 7)
	
	If UpperBound(ls_attached_file_name[]) > 0 Then
		lb_rtn = wf_send_smtp_email(ls_notetext, ls_attached_file_name[])
		
		//Move files in ls_attached_file_name[] to c:\temp\archive
		wf_move_files(ls_attached_file_name[])
		
		ib_xls_done_comb = False
	Else
		MessageBox("Nothing to do", "Please create combined XLS to email")
		dw_name.SetFocus()
	End If
Else
	MessageBox("Nothing to do", "Please create combined XLS to email")
	dw_name.SetFocus()
End If

is_subject = ls_subject_save //Restore is_subject
SetPointer(oldpointer)
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
end event

type cb_create_comb from commandbutton within w_inventory_reports
integer x = 1342
integer y = 250
integer width = 410
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Create Combined"
end type

event clicked;//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. Begin
Boolean	lb_rtn, lb_report_4multiple_customers
String	ls_filename, ls_notetext, ls_attached_file_name[], ls_customer_short_name
String	ls_customer_name_arr[], ls_customer_string, ls_file
Long		ll_rows, ll_filteredcount, ll_row, ll_customer_id_temp, ll_customer_id[]
Long		ll_selected_row, ll_i
Integer	li_rtn
nv_test	lnv_test

DataStore	lds_report_inv_cust_coils_comb, lds_report_inv_cust_scrap_skids_comb, lds_report_inv_cust_skids_comb
DataStore	lds_comb

If IsValid(lds_report_inv_cust_coils_comb) Then Destroy lds_report_inv_cust_coils_comb
lds_report_inv_cust_coils_comb = Create DataStore
lds_report_inv_cust_coils_comb.DataObject = "d_report_inv_cust_coils_comb"

If IsValid(lds_report_inv_cust_scrap_skids_comb) Then Destroy lds_report_inv_cust_scrap_skids_comb
lds_report_inv_cust_scrap_skids_comb = Create DataStore
lds_report_inv_cust_scrap_skids_comb.DataObject = "d_report_inv_cust_scrap_skids_comb"

If IsValid(lds_report_inv_cust_skids_comb) Then Destroy lds_report_inv_cust_skids_comb
lds_report_inv_cust_skids_comb = Create DataStore
lds_report_inv_cust_skids_comb.DataObject = "d_report_inv_cust_skids_comb"

lds_comb =  Create DataStore
lds_comb.DataObject = "d_report_combined_inventory"

ib_xls_done_comb = False

//---------------------------------
//Initialize  test variables
//Displayed when cb_totals clicked
il_rows_coils = 0
il_rows_scrap = 0
il_rows_skids = 0
il_rows_combined = 0
il_sum_coil_net_wt = 0
il_sum_coil_net_wt_balance = 0
il_sum_scrap_net_wt = 0
il_sum_scrap_tare_wt = 0
il_sum_skid_net_wt = 0
il_sum_item_net_wt = 0
il_sum_skid_pieces = 0
il_sum_item_pieces = 0
//---------------------------------

li_rtn = Run(is_taskkill_bat_file, Minimized!) //Kill AcroRd32.exe processes. They slow down XLS creation

wf_delete_work_files("csv")
wf_delete_work_files("pdf")
wf_delete_email_files()

ib_xls_done = False
ib_xls_done_comb = False

//Alex Gerlants. 06/08/2017. Begin
If IsValid(lnv_test) Then Destroy nv_test
lnv_test = Create nv_test
lnv_test.of_set_work_folder(is_work_folder) //Set work folder in lnv_test

wf_get_selected_customers(ll_customer_id[], ls_customer_name_arr[])

If UpperBound(ll_customer_id[]) > 0 Then
	ls_customer_short_name = ""

	li_rtn = lnv_test.of_report_inv_cust_coils_comb(ll_customer_id[], lds_report_inv_cust_coils_comb)

	If li_rtn =  1 Then
		li_rtn = lnv_test.of_report_inv_cust_scrap_skids_comb(ll_customer_id[], lds_report_inv_cust_scrap_skids_comb)
		
		//ll_rows = lds_report_inv_cust_scrap_skids_comb.RowCount()
		lds_report_inv_cust_scrap_skids_comb.SetSort("scrap_skid_scrap_skid_display_num Asc")
		lds_report_inv_cust_scrap_skids_comb.Sort()
		
		If li_rtn =  1 Then
			li_rtn = lnv_test.of_report_inv_cust_skids_comb(ll_customer_id[], lds_report_inv_cust_skids_comb)
			
			//ll_rows = lds_report_inv_cust_skids_comb.RowCount()
			lds_report_inv_cust_skids_comb.SetSort("sheet_skid_sheet_skid_display_num Asc")
			lds_report_inv_cust_skids_comb.Sort()
			
			If li_rtn = 1 Then
				//Transfer data from the 3 _comb datastores into lds_comb
				wf_combine_data	(	lds_report_inv_cust_coils_comb, &
											lds_report_inv_cust_scrap_skids_comb, &
											lds_report_inv_cust_skids_comb, &
											lds_comb, &
											ll_customer_id[] &
										)
				is_file_name_2email = "Inventory"
				
				If Right(is_email_folder, 1) <> "\" Then
					is_email_folder = is_email_folder + "\"
				End If

				ls_file = is_email_folder + "Inventory_Combined_Report_" + String(DateTIme(Today(), Now()), "mmddyyyy_hhmmss") + ".xls"
				
				//li_rtn = lds_comb.SaveAs(ls_file, Excel8!, True) //"True" is to include headings
				li_rtn = lds_comb.SaveAs(ls_file, Excel!, True) //"True" is to include headings
				
				If li_rtn = 1 Then //OK
					ib_xls_done_comb = True
					
					For ll_i = 1 To UpperBound(ls_customer_name_arr[])
						ls_customer_string = ls_customer_string + "~n~r~t" + Trim(ls_customer_name_arr[ll_i])
					Next
				
					If UpperBound(ll_customer_id[]) = 1 Then
						MessageBox("Combined XLS created", "Combined XLS~n~r" + ls_file + "~n~rfor customer " + Upper(Trim(ls_customer_name_arr[1])) + "~n~rcreated successfully")
					Else
						MessageBox("Combined XLS created", "Combined XLS~n~r" + ls_file + "~n~rfor customers " + Upper(ls_customer_string) + "~n~rcreated successfully")
					End If
				End if
			End If
		End If
	End If
Else //No customer selected
	MessageBox("Nothing to do", "Please select customer(s)", StopSign!)
	dw_name.SetFocus()
End If

If IsValid(lnv_test) Then Destroy nv_test
If IsValid(lds_report_inv_cust_coils_comb) Then Destroy lds_report_inv_cust_coils_comb
If IsValid(lds_report_inv_cust_scrap_skids_comb) Then Destroy lds_report_inv_cust_scrap_skids_comb
If IsValid(lds_report_inv_cust_skids_comb) Then Destroy lds_report_inv_cust_skids_comb
If IsValid(lds_comb) Then Destroy lds_comb
//Alex Gerlants. Novelis Inv. Combined Report. 08/01/2017. End
end event

type st_6 from statictext within w_inventory_reports
integer x = 2761
integer y = 96
integer width = 530
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unselect all customers"
boolean focusrectangle = false
end type

type st_5 from statictext within w_inventory_reports
integer x = 728
integer y = 714
integer width = 497
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unselect all customers"
boolean focusrectangle = false
end type

type st_4 from statictext within w_inventory_reports
integer x = 728
integer y = 666
integer width = 421
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete all work files"
boolean focusrectangle = false
end type

type cb_start_fresh from commandbutton within w_inventory_reports
integer x = 731
integer y = 794
integer width = 410
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Start Fresh"
end type

event clicked;wf_delete_work_files("pdf")
wf_delete_work_files("csv")
wf_delete_email_files()
dw_customer_short_list.SelectRow(0, False) //Unselect all rows
end event

type cb_4 from commandbutton within w_inventory_reports
integer x = 2476
integer y = 3
integer width = 410
integer height = 102
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save As Default"
end type

event clicked;String	ls_email_address

ls_email_address = sle_email_address.Text

If ls_email_address <> "" Then
	update	dbo.abis_ini
	set		value = :ls_email_address
	where    process = 'inventory_reports'
	and	 	section = 'smtp_email'
	and 		lower(key) = 'useremail'
	using		sqlca;
	
	If sqlca.sqlcode = 0 Then
		commit using sqlca;
		MessageBox("Update Success", "Successfully updated default Email Address")
	Else //DB error
		rollback using sqlca;
		MessageBox("DB Error", "Database error occurred while trying to update User Email on table abis_ini" + &
					"~n~rDB Error:~n~r" + sqlca.sqlerrtext, StopSign!)
	End If
End If
end event

type cb_archive_folder from commandbutton within w_inventory_reports
integer x = 1342
integer y = 1459
integer width = 410
integer height = 102
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save As Default"
end type

event clicked;String	ls_archive_folder
Integer	li_rtn, li_answer

ls_archive_folder = sle_archive_folder.Text

If Not DirectoryExists(ls_archive_folder) Then
	li_answer = MessageBox("Folder does not exist", "Please create it first")
	Return
End If

If ls_archive_folder <> "" Then
	update	dbo.abis_ini
	set		value = :ls_archive_folder
	where    process = 'inventory_reports'
	and	 	section = 'smtp_email'
	and 		lower(key) = 'archive_folder'
	using		sqlca;
	
	If sqlca.sqlcode = 0 Then
		commit using sqlca;
		MessageBox("Update Success", "Successfully updated default Archive Folder")
	Else //Db error
		rollback using sqlca;
		MessageBox("DB Error", "Database error occurred while trying to update Archive Folder on table abis_ini" + &
					"~n~rDB Error:~n~r" + sqlca.sqlerrtext, StopSign!)
	End If
End If
end event

type sle_archive_folder from singlelineedit within w_inventory_reports
integer x = 29
integer y = 1562
integer width = 1726
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_abis_ini from datawindow within w_inventory_reports
integer x = 2107
integer y = 717
integer width = 1317
integer height = 512
integer taborder = 50
string title = "none"
string dataobject = "d_abis_ini"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_inventory_reports
integer x = 29
integer y = 1510
integer width = 322
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Archive Folder"
boolean focusrectangle = false
end type

type st_2 from statictext within w_inventory_reports
integer x = 731
integer y = 986
integer width = 413
integer height = 61
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Email Address"
boolean focusrectangle = false
end type

type sle_email_address from singlelineedit within w_inventory_reports
integer x = 731
integer y = 1062
integer width = 1024
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_unselect from commandbutton within w_inventory_reports
integer x = 2860
integer y = 147
integer width = 322
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Unselect All"
end type

event clicked;dw_customer_short_list.SelectRow(0, False)
dw_name.SetFocus()
end event

type cb_close from commandbutton within w_inventory_reports
integer x = 1342
integer y = 1251
integer width = 410
integer height = 90
integer taborder = 50
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

type st_1 from statictext within w_inventory_reports
integer x = 29
integer width = 936
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inventory Reports"
boolean focusrectangle = false
end type

type cb_run_bat from commandbutton within w_inventory_reports
integer x = 2107
integer y = 589
integer width = 263
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run BAT"
end type

event clicked;Integer	li_rtn, li_totalitems, li_i
Boolean	lb_fileexists = False
String	ls_filename

//Delete from email folder all email files created before
li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email) //Load file names into lb_files

If li_totalitems > 0 Then
	For li_i =1 To li_totalitems
		lb_files.SelectItem(li_i)
		ls_filename = lb_files.SelectedItem()
		ls_filename = is_email_folder + ls_filename
		
		FileDelete(ls_filename)
	Next
End If

If ib_xls_done Or ib_pdf_done Then
	li_rtn = Run(is_combine_bat_file) //Combine the 3 reports in combined.pdf
	ib_pdf_done = False
Else
	MessageBox("Nothing to do", "Please create PDF and/or XLS", StopSign!)
End If

If ib_xls_done Then
	Do Until lb_fileexists //Wait until CSV file created
		lb_fileexists = FileExists(is_work_folder + "Inventory_all.csv")
	Loop
	
	excel_open_csv_saveas_xls()
	
	ib_xls_done = False
End If


end event

type cb_2 from commandbutton within w_inventory_reports
integer x = 3101
integer y = 589
integer width = 322
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cells"
end type

event clicked;Integer		li_rtn
String		ls_range, ls_clipboard
Any			la_value
OleObject 	lole_OLE, lole_workbook, lole_sheet, lole_range
OleObject 	lole_sheet2, lole_range2
//---
OleObject 	lole_Excel
OleObject 	lole_MainWorkBook, lole_TempWorkBook
//OleObject 	lole_sheet
//---
Long			ll_excel_rows = 47, ll_OLEReturn, ll_col = 9, ll_rows = 47


//lole_Excel = CREATE OLEOBJECT
//lole_MainWorkBook = CREATE OLEOBJECT
//lole_TempWorkBook = CREATE OLEOBJECT
//lole_sheet = CREATE OLEOBJECT
//
//
//ll_OLEReturn = lole_Excel.ConnectToNewObject("excel.application")
//
//IF ll_OLEReturn < 0 THEN
//    //......................
//    RETURN -1
//END IF














lole_OLE = create oleobject

li_rtn = lole_OLE.ConnectToNewObject("excel.application")

if li_rtn <> 0 then
   MessageBox( "Error", 'Error running MS Excel api.')
   destroy lole_OLE
else
	//lole_OLE.Workbooks.Add
	//lole_sheet2 = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]
	
	
  	lole_OLE.WorkBooks.Open("C:\temp\Coils1.xls") 

  	lole_workbook = lole_OLE.application.workbooks(1)
  	lole_sheet = lole_workbook.worksheets(1)
  
  	//---
  

  
  	//---

	//  // Set the cell value
	//  lole_sheet.cells(1,11).value = "Some value" //it is cells(line, column)
	la_value = lole_sheet.cells(1,9).value
	la_value = lole_sheet.cells(5,2).value
	la_value = lole_sheet.cells(5,3).value

  	//example to work on a range of cells
	  
	lole_OLE.Worksheets(1).Range("A1:S47").Copy //Copies to ClipBoard
	  
	ls_range = "A1:S" + string(ll_excel_rows)
	lole_range = lole_sheet.Range(ls_range)
	lole_range.Select
	lole_range.Copy
	lole_range.Locked = True
  
  	//---
	//lole_range2 = lole_sheet2.Range(ls_range)
  	//lole_range2.Select
	//lole_Sheet2.Application.Selection.EntireRow.Insert
	//---
  
  	ls_clipboard = ClipBoard()
  
  	// Save
  	//lole_workbook.save() //Clears ClipBoard
  
  	//---
	lole_Sheet2 = Create OleObject
	  
	lole_OLE.Workbooks.Add
	lole_sheet2 = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]
	
	lole_range2 = lole_sheet2.Range(ls_range)
	lole_range2.Select
	lole_Sheet2.Application.Selection.EntireRow.Insert
	lole_Sheet2.Paste
	
	lole_sheet2.SaveAs("C:\temp\Coils_Combined.xls", Excel8!)
  	//---
  
  	// Quit
  	lole_OLE.application.quit()
  	lole_OLE.DisconnectObject()

  	Destroy lole_OLE
	Garbagecollect()
end if
end event

type dw_report_inv_cust_coils from datawindow within w_inventory_reports
integer x = 2107
integer y = 1306
integer width = 1317
integer height = 589
integer taborder = 40
string dataobject = "d_report_inv_cust_coils"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_inventory_reports
integer x = 2750
integer y = 589
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Excel to DW"
boolean cancel = true
end type

event clicked;OLEObject  	excel 
DataStore	lds_report_inv_cust_coils

Integer    li_RetValue, li_rtn 
Boolean    lb_sheet_rtn 
Long       ll_cnt 
String     ls_ClipBoard 

excel = create OLEObject 

lds_report_inv_cust_coils = Create DataStore
lds_report_inv_cust_coils.DataObject = "d_report_inv_cust_coils"
li_rtn = lds_report_inv_cust_coils.SetTransObject(sqlca)

li_rtn = excel.ConnectToNewObject("excel.application") 
IF li_rtn <> 0 THEN 
    MessageBox('Excel error','can not run Excel Program') 
    DESTROY excel 
    RETURN 0 
END IF 

excel.WorkBooks.Open( "C:\temp\Coils1.xls" ) 
excel.Application.Visible = false 
excel.windowstate = 2 // 1 : Normal, 2 : Minimize, 3 : Maximize 

lb_sheet_rtn = excel.worksheets(1).Activate 

ls_ClipBoard =  Clipboard() //Store current clipboard Data 

//Copy to clipboard - Take enough Range. .. 
//Or use the UsedRange property. 
//If data has header row, use correct starting range.. (B1:... )
excel.Worksheets(1).Range("A5:S45").Copy  
ll_cnt = dw_report_inv_cust_coils.importclipboard(Text!) 

Clipboard(ls_ClipBoard) //Restore clipboard 

IF ll_cnt <= 1 THEN 
    Messagebox("Inf", "Could not find .") 
END IF 

excel.Application.Quit 
excel.DisConnectObject() 

Destroy excel 

Garbagecollect()

//---





end event

type cb_email from commandbutton within w_inventory_reports
integer x = 731
integer y = 464
integer width = 410
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Email Files"
end type

event clicked;Boolean	lb_rtn
Boolean	lb_report_4multiple_customers //Alex Gerlants. 06/08/2017
String	ls_filename, ls_notetext, ls_attached_file_name[], ls_customer_short_name
String	ls_subject_save, ls_customer_name_arr[], ls_customer_name_temp, ls_customer_name_string
Integer	li_totalitems, li_i

Integer	li_rtn, li_counter = 0
Boolean	lb_fileexists = False
Pointer 	oldpointer // Declares a pointer variable
Long		ll_customer_id, ll_customer_id_arr[], ll_i

oldpointer = SetPointer(HourGlass!)

If ib_xls_done Or ib_pdf_done Then
	li_rtn = Run(is_combine_bat_file, Minimized!) //Combine the 3 reports in C:\abis\combpdf.bat
	//ib_pdf_done = False
Else
	MessageBox("Nothing to do", "Please create PDF and/or XLS to email", StopSign!)
	dw_name.SetFocus()
	Return
End If

If ib_xls_done Then
	lb_fileexists = FileExists(is_work_folder + "Inventory_all.csv")
	
	If lb_fileexists Then
		excel_open_csv_saveas_xls()
	Else
		//Wait for 7 seconds
		Sleep(7) 
	
		//Try again
		lb_fileexists = FileExists(is_work_folder + "Inventory_all.csv")
		
		If lb_fileexists Then
			excel_open_csv_saveas_xls()
			//ib_xls_done = False
		End if
	End If
End If

//Load file into lb_files
li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email)

If li_totalitems <= 0 Then
	//Wait for 7 seconds
	Sleep(7) 
	
	//Try again
	li_totalitems = wf_load_email_files(is_email_folder, is_file_name_2email)
End If

If li_totalitems > 0 Then
	//Get file names from lb_files to attach to email
	For li_i = 1 To li_totalitems
		lb_files.SelectItem(li_i)
		ls_filename = lb_files.SelectedItem()
		ls_filename = is_email_folder + ls_filename
		ls_attached_file_name[UpperBound(ls_attached_file_name[]) + 1] = ls_filename
	Next
	
	wf_rename_files(ls_attached_file_name[])
	
	//Email ls_filename
	ls_notetext = ""
	ls_subject_save = is_subject //Save is_subject
	is_subject = f_get_ini_value("inventory_reports","smtp_email","subject","Inventory Reports")
	
	lb_report_4multiple_customers = wf_report_4multiple_customers(ls_customer_short_name) //Alex Gerlants. 06/08/2017
	
	If lb_report_4multiple_customers Then
		ls_customer_short_name = Upper(ls_customer_short_name)
		is_subject = f_get_ini_value("inventory_reports","smtp_email","subject","Inventory Reports")
		ls_notetext = "Please find attached file(s) for customer " + ls_customer_short_name
		is_subject = is_subject + " for customer " + ls_customer_short_name
	Else
		//wf_get_customer(ll_customer_id, ls_customer_short_name)
		wf_get_selected_customers(ll_customer_id_arr[], ls_customer_name_arr[])
		
		For ll_i = 1 To UpperBound(ls_customer_name_arr[])
			ls_customer_name_temp = ls_customer_name_arr[ll_i]
			ls_customer_name_string = ls_customer_name_string + Upper(ls_customer_name_temp + ", ")
		Next
		
		//Remove the last comma
		ls_customer_name_string = Left(ls_customer_name_string, Len(ls_customer_name_string) -2)

		If UpperBound(ls_customer_name_arr[]) = 1 Then
			ls_notetext = "Please find attached file(s) for " + Upper(ls_customer_name_arr[1])
			is_subject = is_subject + " for " + Upper(ls_customer_name_arr[1])
		Else
			ls_notetext = "Please find attached file(s) for MIXED customers"
			is_subject = is_subject + " for MIXED customers"
		End If
	End If
	
	If UpperBound(ls_attached_file_name[]) > 0 Then
		lb_rtn = wf_send_smtp_email(ls_notetext, ls_attached_file_name[])
		
		//Move files in ls_attached_file_name[] to c:\temp\archive
		//wf_move_files(ls_attached_file_name[])
		wf_delete_emailed_files(ls_attached_file_name[])
		
		ib_xls_done = False
		ib_pdf_done = False
	Else
		MessageBox("Nothing to email", "Please create PDF and/or XLS to email")
		dw_name.SetFocus()
	End If
Else
	MessageBox("Nothing to email", "Please create PDF and/or XLS to email")
	dw_name.SetFocus()
End If

is_subject = ls_subject_save //Restore is_subject
SetPointer(oldpointer)
end event

type cb_create_xls from commandbutton within w_inventory_reports
integer x = 731
integer y = 352
integer width = 410
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Create XLS"
end type

event clicked;Boolean	lb_rtn, lb_report_4multiple_customers
String	ls_filename, ls_notetext, ls_attached_file_name[], ls_customer_short_name
String	ls_customer_name_arr[], ls_customer_string
Long		ll_rows, ll_filteredcount, ll_row, ll_customer_id_temp, ll_customer_id[]
Long		ll_selected_row, ll_i
Integer	li_rtn
nv_test	lnv_test

li_rtn = Run(is_taskkill_bat_file, Minimized!) //Kill AcroRd32.exe processes. They slow down XLS creation

wf_delete_work_files("csv")
wf_delete_email_files()

ib_xls_done = False
ib_xls_done_comb = False

lb_report_4multiple_customers = wf_report_4multiple_customers(ls_customer_short_name) //Alex Gerlants. 06/08/2017

//Alex Gerlants. 06/08/2017. Begin
If IsValid(lnv_test) Then Destroy nv_test
lnv_test = Create nv_test
lnv_test.of_set_work_folder(is_work_folder) //Set work folder in lnv_test

If lb_report_4multiple_customers Then
	ll_customer_id[1] = -99
	
	li_rtn = lnv_test.of_report_inv_cust_coils(ll_customer_id[], ls_customer_short_name, "xls")
	
	If li_rtn =  1 Then
		li_rtn = lnv_test.of_report_inv_cust_scrap_skids(ll_customer_id[], ls_customer_short_name, "xls")
		
		If li_rtn =  1 Then
			li_rtn = lnv_test.of_report_inv_cust_skids(ll_customer_id[], ls_customer_short_name, "xls")
		End If
	End If
	
	If li_rtn = 1 Then
		ib_xls_done = True
		MessageBox("XLS created", "XLS for customer " + Upper(Trim(ls_customer_short_name)) + "~n~rcreated successfully")
	Else
		MessageBox("Error creating XLS", "Creating PDF failed")
	End If
Else
//Alex Gerlants. 06/08/2017. End
	wf_get_selected_customers(ll_customer_id[], ls_customer_name_arr[])
	
	If UpperBound(ll_customer_id[]) > 0 Then
		ls_customer_short_name = ""
	
		li_rtn = lnv_test.of_report_inv_cust_coils(ll_customer_id[], ls_customer_short_name, "xls")
	
		If li_rtn =  1 Then
			li_rtn = lnv_test.of_report_inv_cust_scrap_skids(ll_customer_id[], ls_customer_short_name, "xls")
			
			If li_rtn =  1 Then
				li_rtn = lnv_test.of_report_inv_cust_skids(ll_customer_id[], ls_customer_short_name, "xls")
			End If
		End If
		
		For ll_i = 1 To UpperBound(ls_customer_name_arr[])
			ls_customer_string = ls_customer_string + "~n~r~t" + Trim(ls_customer_name_arr[ll_i])
		Next
		
		If li_rtn = 1 Then
			ib_xls_done = True
			
			If UpperBound(ll_customer_id[]) = 1 Then
				MessageBox("XLS created", "XLS for customer " + Upper(Trim(ls_customer_name_arr[1])) + "~n~rcreated successfully")
			Else
				MessageBox("XLS created", "XLS for customers " + Upper(ls_customer_string) + "~n~rcreated successfully")
			End If
		Else
			MessageBox("Error creating XLS", "Error creating XLS failed. ~n~rPlease call application support.")
		End If
		
	Else //No customer selected
		MessageBox("Nothing to do", "Please select customer(s)", StopSign!)
		dw_name.SetFocus()
	End If
End If //Alex Gerlants. 06/08/2017

If IsValid(lnv_test) Then Destroy nv_test
end event

type cb_files from commandbutton within w_inventory_reports
integer x = 2399
integer y = 589
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Files"
end type

event clicked;Boolean	lb_rtn
String	ls_filename, ls_notetext, ls_attached_file_name[]

//Load file into lb_files
lb_files.DirList("C:\temp\email\Inventory_*.pdf", 0)

//Get file name from lb_files
lb_files.SelectItem(1)
ls_filename = lb_files.SelectedItem()

//Email ls_filename

ls_notetext = "Please find attached"
ls_attached_file_name[1] = "C:\temp\email\" + ls_filename
lb_rtn = wf_send_smtp_email(ls_notetext, ls_attached_file_name[])

If lb_rtn Then
	FileDelete("C:\temp\email\" + ls_filename)
End If
end event

type lb_files from listbox within w_inventory_reports
integer x = 2107
integer y = 128
integer width = 1317
integer height = 435
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_name from datawindow within w_inventory_reports
integer x = 29
integer y = 128
integer width = 673
integer height = 102
integer taborder = 20
string title = "none"
string dataobject = "d_name"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String	ls_data, ls_filter_string, ls_rtn
Integer	li_rtn
Long		ll_rows, ll_filteredcount

ls_data = Lower(data)

//MessageBox("EditChanged event for dw_name", "ls_data = " + ls_data)

If Len(ls_data) > 0 Then
	ls_filter_string = "Lower(customer_short_name) like '" + ls_data + "%'"
Else
	ls_filter_string = ""
End If


li_rtn = dw_customer_short_list.SetFilter(ls_filter_string)
li_rtn = dw_customer_short_list.Filter()

ll_rows = dw_customer_short_list.RowCount()
ll_filteredcount = dw_customer_short_list.FilteredCount()

//MessageBox("EditChanged event for dw_name of w_inventory_reports", &
//	"ll_rows = " + String(ll_rows) + &
//	"~n~rll_filteredcount = " + String(ll_filteredcount))


end event

type cb_create_pdf from commandbutton within w_inventory_reports
integer x = 731
integer y = 250
integer width = 410
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Create PDF"
end type

event clicked;Boolean	lb_rtn, lb_report_4multiple_customers
String	ls_filename, ls_notetext, ls_attached_file_name[]
Long		ll_rows, ll_filteredcount, ll_row, ll_customer_id_temp, ll_customer_id[]
Long		ll_selected_row, ll_i
Integer	li_rtn
String	ls_customer_short_name, ls_customer_string, ls_customer_name_arr[]
nv_test	lnv_test

wf_delete_work_files("pdf")
wf_delete_email_files()

ib_pdf_done = False
ib_xls_done_comb = False

lb_report_4multiple_customers = wf_report_4multiple_customers(ls_customer_short_name) //Alex Gerlants. 06/08/2017

//Alex Gerlants. 06/08/2017. Begin
If IsValid(lnv_test) Then Destroy nv_test
lnv_test = Create nv_test
lnv_test.of_set_work_folder(is_work_folder) //Set work folder in lnv_test
		
If lb_report_4multiple_customers Then
	ll_customer_id[1] = -99
	
	li_rtn = lnv_test.of_report_inv_cust_coils(ll_customer_id[], ls_customer_short_name, "pdf")
	
	If li_rtn = 1 Then
		li_rtn = lnv_test.of_report_inv_cust_skids(ll_customer_id[], ls_customer_short_name, "pdf")
		
		If li_rtn = 1 Then
			li_rtn = lnv_test.of_report_inv_cust_scrap_skids(ll_customer_id[], ls_customer_short_name, "pdf")
		End if
	End If
	
	If li_rtn = 1 Then
		ib_pdf_done = True
		MessageBox("PDF created", "PDF for customer " + Upper(ls_customer_short_name) + " created successfully")
	Else
		MessageBox("Error creating PDF", "Error creating PDF for customer " + ls_customer_short_name + &
																									"~n~rPlease call application support")
	End If
Else
//Alex Gerlants. 06/08/2017. End

	wf_get_selected_customers(ll_customer_id[], ls_customer_name_arr[])
	
	If UpperBound(ll_customer_id[]) > 0 Then
		ls_customer_short_name = ""
		
		li_rtn = lnv_test.of_report_inv_cust_coils(ll_customer_id[], ls_customer_short_name, "pdf")
		
		If li_rtn = 1 Then
			li_rtn = lnv_test.of_report_inv_cust_skids(ll_customer_id[], ls_customer_short_name, "pdf")
			
			If li_rtn = 1 Then
				li_rtn = lnv_test.of_report_inv_cust_scrap_skids(ll_customer_id[], ls_customer_short_name, "pdf")
			End If
		End If
		
		For ll_i = 1 To UpperBound(ls_customer_name_arr[])
			ls_customer_string = ls_customer_string + "~n~r~t" + Trim(ls_customer_name_arr[ll_i])
		Next
		
		If li_rtn = 1 Then
			ib_pdf_done = True
			
			If UpperBound(ll_customer_id[]) = 1 Then
				MessageBox("PDF created", "PDF for customer " + Upper(Trim(ls_customer_name_arr[1])) + "~n~rcreated successfully")
			Else
				MessageBox("PDF created", "PDF for customers " + Upper(ls_customer_string) + "~n~rcreated successfully")
			End If
		Else
			MessageBox("Error creating PDF", "Creating PDF failed. ~n~rPlease call application support.")
		End If
	Else //No customer selected
		MessageBox("Nothing to do", "Please select customer(s)", StopSign!)
		dw_name.SetFocus()
	End If
End If //Alex Gerlants. 06/08/2017

If IsValid(lnv_test) Then Destroy nv_test
end event

type dw_customer_short_list from datawindow within w_inventory_reports
integer x = 29
integer y = 256
integer width = 673
integer height = 1229
integer taborder = 10
string title = "none"
string dataobject = "d_customer_short_list_rpt"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String 	ls_old_sort, ls_column, ls_name
//String	ls_name_temp, ls_coltype
Char 		lc_sort
Long		ll_Col, ll_calendar_x
Boolean	lb_dttm_column_clicked

ls_name = dwo.Name

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)

	/* Get old sort, If any. */
	ls_old_sort = This.Describe("Datawindow.Table.sort")

	//Check whether previously sorted column and currently clicked column are same or not. 
	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
	//If both are not same, simply sort it by Ascending order.
	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
		lc_sort = Right(ls_old_sort, 1)

		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		  
		This.SetSort(ls_column + " " + lc_sort)
	Else
		This.SetSort(ls_column + " A")
	End If

	This.Sort()
End If

//---

//Allow user to select one row only
If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		//This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If	


end event

