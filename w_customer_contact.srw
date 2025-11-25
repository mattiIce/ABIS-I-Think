$PBExportHeader$w_customer_contact.srw
$PBExportComments$<main>input/display customer/contact detail information, inherited from  pfemain.pbl
forward
global type w_customer_contact from w_sheet
end type
type dw_name from datawindow within w_customer_contact
end type
type st_1 from statictext within w_customer_contact
end type
type cb_ok from u_cb within w_customer_contact
end type
type cb_next from u_cb within w_customer_contact
end type
type dw_customer_list from u_dw within w_customer_contact
end type
type cb_print from u_cb within w_customer_contact
end type
type cb_close from u_cb within w_customer_contact
end type
type tab_cust from tab within w_customer_contact
end type
type tabpage_cust_info from userobject within tab_cust
end type
type dw_cust_detail from u_dw within tabpage_cust_info
end type
type tabpage_cust_info from userobject within tab_cust
dw_cust_detail dw_cust_detail
end type
type tabpage_contact from userobject within tab_cust
end type
type dw_contact_list from u_dw within tabpage_contact
end type
type dw_contact_detail from u_dw within tabpage_contact
end type
type cb_contact_new from u_cb within tabpage_contact
end type
type cb_contact_remove from u_cb within tabpage_contact
end type
type cb_contact_prev from u_cb within tabpage_contact
end type
type cb_contact_next from u_cb within tabpage_contact
end type
type tabpage_contact from userobject within tab_cust
dw_contact_list dw_contact_list
dw_contact_detail dw_contact_detail
cb_contact_new cb_contact_new
cb_contact_remove cb_contact_remove
cb_contact_prev cb_contact_prev
cb_contact_next cb_contact_next
end type
type tab_cust from tab within w_customer_contact
tabpage_cust_info tabpage_cust_info
tabpage_contact tabpage_contact
end type
type cb_prev from u_cb within w_customer_contact
end type
type cb_new from commandbutton within w_customer_contact
end type
end forward

global type w_customer_contact from w_sheet
integer x = 4
integer y = 3
integer width = 2534
integer height = 2355
string title = "Customer/Contact"
string menuname = "m_cust_cont"
boolean maxbox = false
boolean resizable = false
event ue_retrievelinkage ( )
event type string ue_whoami ( )
event ue_read_only ( )
event type integer ue_next ( )
event type integer ue_prior ( )
dw_name dw_name
st_1 st_1
cb_ok cb_ok
cb_next cb_next
dw_customer_list dw_customer_list
cb_print cb_print
cb_close cb_close
tab_cust tab_cust
cb_prev cb_prev
cb_new cb_new
end type
global w_customer_contact w_customer_contact

type variables
integer 	ii_contact_new_flag

//Alex Gerlants. 08/03/2016. Begin
Boolean	ib_desadv_req_changed

//SMTP email variables
n_smtp 	in_smtp

//Populated in Open event for w_customer_contact
String	is_from_email //Sender email address
String	is_from_name //Sender name
String	is_server //SMTP server IP address
Integer	ii_port //SMTP port
String	is_send_email //Recipient email address
String	is_send_name //Recipient name
String	is_logfile //Log file where we record SMTP email messages if email fails
String	is_subject //Email subject line
Boolean	ib_debugviewer = False
//Alex Gerlants. 08/03/2016. End

Boolean	ib_edi_req_changed //Alex Gerlants. 09/01/2016

//Alex Gerlants. CAR. 10/04/2017. Begin
Boolean	ib_customer_added
Long		il_new_customer_rows[]

String	is_from_email_new_customer //Sender email address
String	is_from_name_new_customer //Sender name
String	is_server_new_customer //SMTP server IP address
Integer	ii_port_new_customer //SMTP port
String	is_send_email_new_customer //Recipient email address
String	is_send_name_new_customer //Recipient name
String	is_logfile_new_customer //Log file where we record SMTP email messages if email fails
String	is_subject_new_customer //Email subject line
Boolean	ib_debugviewer_new_customer = False
//Alex Gerlants. CAR. 10/04/2017. End
end variables

forward prototypes
public function long wf_getnew_id (string id_name)
public subroutine wf_send_email_2support (string as_notetext)
public subroutine wf_send_smtp_email_2support (string as_body, string as_reason)
public function integer wf_check_4empty_name (ref long al_row_2delete)
end prototypes

event ue_retrievelinkage;call super::ue_retrievelinkage;IF dw_customer_list.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_customer_contact::ue_retrievelinkage" )
ELSE
	SQLCA.of_Commit()
	dw_customer_list.SetFocus()
End IF

tab_cust.Visible = TRUE

end event

event ue_whoami;RETURN "w_customer_contact"
end event

event ue_read_only;dw_customer_list.Object.DataWindow.ReadOnly = "YES"
tab_cust.tabpage_cust_info.dw_cust_detail.Object.DataWindow.ReadOnly = "YES"
tab_cust.tabpage_contact.dw_contact_list.Object.DataWindow.ReadOnly = "YES"
tab_cust.tabpage_contact.dw_contact_detail.Object.DataWindow.ReadOnly = "YES"

tab_cust.tabpage_contact.cb_contact_new.Enabled = FALSE
tab_cust.tabpage_contact.cb_contact_remove.Enabled = FALSE
cb_new.Enabled = FALSE
cb_ok.Enabled = FALSE

m_cust_cont.m_file.m_new.Disable()
m_cust_cont.m_file.m_save.Disable()


end event

event ue_next;long ll_row
Int li_rc
IF tab_cust.tabpage_contact.dw_contact_list.Event pfc_UpdatesPending() = 1 THEN
	li_rc = MessageBox("Question", "Save contact information now, otherwise you may lost all new information!", Question!, YesNo!, 1)	
	IF li_rc = 1 THEN
		this.Event pfc_Save()
	END IF
END IF

ll_row = dw_customer_list.GetRow()
dw_customer_list.SelectRow(0, FALSE)
dw_customer_list.SetRow(ll_row + 1)
dw_customer_list.SelectRow((ll_row + 1), TRUE)
dw_customer_list.Event pfc_RowChanged()

RETURN 1
end event

event ue_prior;long ll_row
Int li_rc
IF tab_cust.tabpage_contact.dw_contact_list.Event pfc_UpdatesPending() = 1 THEN
	li_rc = MessageBox("Question", "Save contact information now, otherwise you may lost all new information!", Question!, YesNo!, 1)	
	IF li_rc = 1 THEN
		this.Event pfc_Save()
	END IF
END IF

ll_row = dw_customer_list.GetRow()
dw_customer_list.SelectRow(0, FALSE)
dw_customer_list.SetRow(ll_row - 1)
dw_customer_list.SelectRow((ll_row - 1), TRUE)
dw_customer_list.Event pfc_RowChanged()

RETURN 1
end event

public function long wf_getnew_id (string id_name);Long ll_int_next_id
String ls_col_name

CHOOSE CASE id_name
CASE "Customer"
	ls_col_name = 'customer_id_seq'
	SELECT customer_id_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;
CASE "Customer_Contact"
	ls_Col_name = 'customer_contact_id_seq'
	SELECT customer_contact_id_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;
CASE ELSE
	Return -1
END CHOOSE

// generate next id using oracle sequence 
UPDATE sequence_key
SET sequence_curval = :ll_int_next_id
WHERE sequence_name = :ls_col_name
USING SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Database Error", SQLCA.SQLErrText, Exclamation!)
	ROLLBACK using SQLCA;
	Return -2
ELSE
	COMMIT using SQLCA;
END IF

Return ll_int_next_id

end function

public subroutine wf_send_email_2support (string as_notetext);//Alex Gerlants. 08/03/2016. Begin
/*
Function:	wf_send_email_2support
Returns:		none
Arguments:	value	string	as_notetext
*/

Integer	li_rtn, li_file_number
Long		ll_i, ll_change_count
String	ls_err_msg, ls_filename, ls_current_date_time, ls_customer, ls_customers
String	ls_subject, ls_recipient

MailSession ims_mailsess
MailReturncode imrc_returncode
MailMessage imm_mailmessage
MailRecipient imrp_mailrecipient

ls_recipient = "it-support@albl.com"
//ls_recipient = "agerlants@albl.com"
ls_subject = "GM Despatch Advice added"
ls_current_date_time = String(DateTime(Today(), Now()), "mmddyyyy_hhmmss")
ls_filename = "P:\Dev\Dev\Email_Errors_LogFiles\Email_Error_" + ls_current_date_time + ".txt"

////TEST ONLY Begin
//li_file_number = FileOpen(ls_filename, LineMode!, Write!)
//
//ls_err_msg = "Email send failed. Test message." + &
//				"~n~r Recipient: " + ls_recipient + &
//				"~n~r Subject: " + ls_subject + &
//				"~n~r Body: " + as_notetext
//				
//FileWrite(li_file_number, ls_err_msg)
//FileClose (li_file_number)
////TEST ONLY End

Ims_mailsess = create MailSession

Imrc_returncode = ims_mailsess.maillogon(maildownload!)
	
If imrc_returncode <> mailreturnsuccess! Then
    Messagebox ("Warning", "Click OK on next screen to enable e-mail")
    Imrc_returncode = ims_mailsess.maillogon(maildownload!)
    If imrc_returncode <> mailreturnsuccess! Then
          ls_err_msg = 	"Email session could not be established." + &
			 					"~n~r Recipient: " + ls_recipient + &
								"~n~r Subject: " + ls_subject + &
								"~n~r Body: " + as_notetext
			 
			 li_file_number = FileOpen(ls_filename, LineMode!, Write!)
			 FileWrite(li_file_number, ls_err_msg)
			 FileClose (li_file_number)
			 
			 Return
	End if
End if

//imrp_mailrecipient.name = "it_support@albl.com"
imrp_mailrecipient.name = ls_recipient
Imm_mailmessage.recipient[1] = imrp_mailrecipient
Imm_mailmessage.subject = ls_subject
Imm_mailmessage.receiptrequested = False
Imm_mailmessage.notetext = as_notetext
Imrc_returncode = ims_mailsess.mailsend(imm_mailmessage)

If imrc_returncode <> mailreturnsuccess! Then
	 ls_err_msg =	"Email send failed" + &
						"~n~r Recipient: " + ls_recipient + &
						"~n~r Subject: " + ls_subject + &
						"~n~r Body: " + as_notetext
	 
	 li_file_number = FileOpen(ls_filename, LineMode!, Write!)
	 FileWrite(li_file_number, ls_err_msg)
	 FileClose (li_file_number)
	 
    Return
Else
    //Messagebox ("Message", "Email sent")
End if

Ims_mailsess.maillogoff()
Destroy ims_mailsess

//Alex Gerlants. 08/03/2016. End
end subroutine

public subroutine wf_send_smtp_email_2support (string as_body, string as_reason);//Alex Gerlants. 08/03/2016. Begin
/*
Function:	wf_send_smtp_email_2support
Returns:		none
Arguments:	value	string	as_body
				value	string	as_reason <== //Alex Gerlants. CAR. 10/04/2017. New argument
*/

UInt 		lui_port, lui_port_new_customer
Boolean	lb_Return

lui_port = Long(ii_port)
lui_port_new_customer = ii_port_new_customer

// *** Set email properties *********************
in_smtp.of_ResetAll()

If as_reason = "desadv" Then //Alex Gerlants. CAR. 10/04/2017
	in_smtp.of_SetPort(lui_port)
	in_smtp.of_SetServer(is_server)
	in_smtp.of_SetLogFile(True, is_logfile)
	in_smtp.of_SetDebugViewer(ib_debugviewer)
	in_smtp.of_SetSubject(is_subject)
	in_smtp.of_SetBody(as_body, False)
	in_smtp.of_SetFrom(is_from_email, is_from_name)
	in_smtp.of_AddAddress(is_send_email, is_send_name)
	
	// *** send the message *************************
	lb_Return = in_smtp.of_SendMail()
//Alex Gerlants. CAR. 10/04/2017. Begin
ElseIf as_reason = "new_customer" Then
	in_smtp.of_SetPort(lui_port_new_customer)
	in_smtp.of_SetServer(is_server_new_customer)
	in_smtp.of_SetLogFile(True, is_logfile_new_customer)
	in_smtp.of_SetDebugViewer(ib_debugviewer_new_customer)
	in_smtp.of_SetSubject(is_subject_new_customer)
	in_smtp.of_SetBody(as_body, False)
	in_smtp.of_SetFrom(is_from_email, is_from_name_new_customer)
	in_smtp.of_AddAddress(is_send_email_new_customer, is_send_name_new_customer)
	
	// *** send the message *************************
	lb_Return = in_smtp.of_SendMail()
End If
//Alex Gerlants. CAR. 10/04/2017. end

//// *** set Userid/Password if required **********
//If of_getreg("Auth", "N") = "Y" Then
//	ls_uid = of_getreg("Userid", "")
//	ls_pwd = of_getreg("Password", "")
//	in_smtp.of_SetLogin(ls_uid, ls_pwd)
//End If
//
//// *** add any attachments **********************
//li_max = lb_attachments.TotalItems()
//For li_idx = 1 To li_max
//	ls_filename = lb_attachments.Text(li_idx)
//	in_smtp.of_AddAttachment(ls_filename)
//Next

// *** send the message *************************
//lb_Return = in_smtp.of_SendMail()

//If lb_Return Then
//	MessageBox("SendMail", "Mail successfully sent!")
//Else
//	MessageBox("SendMail Error", in_smtp.of_GetLastError())
//End If

//Alex Gerlants. 08/03/2016. End
end subroutine

public function integer wf_check_4empty_name (ref long al_row_2delete);//Alex Gerlants. CAR. 10/04/2017. Begin
/*
Function:	wf_check_4empty_name
Returns:		integer		 1 if the last row in dw_customer_list has customer_full_name and customer_short_name populated
								-1 if the last row in dw_customer_list has customer_full_name and/or customer_short_name not populated
Arguments:	reference	long	al_row_2delete	<== 	Row that is inserted into dw_customer_list, but never populated.
																	Thus we delete this row before saving
*/
String	ls_customer_full_name, ls_customer_short_name
Long		ll_row
Integer	li_rtn = 1

dw_customer_list.AcceptText()
ll_row = dw_customer_list.RowCount()

ls_customer_full_name = dw_customer_list.Object.customer_full_name[ll_row]
If IsNull(ls_customer_full_name) Then ls_customer_full_name = ""
ls_customer_short_name = dw_customer_list.Object.customer_short_name[ll_row]
If IsNull(ls_customer_short_name) Then ls_customer_short_name = ""

If ls_customer_full_name = "" Or ls_customer_short_name = "" Then li_rtn = -1

Return li_rtn
//Alex Gerlants. CAR. 10/04/2017. end
end function

on w_customer_contact.create
int iCurrent
call super::create
if this.MenuName = "m_cust_cont" then this.MenuID = create m_cust_cont
this.dw_name=create dw_name
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_next=create cb_next
this.dw_customer_list=create dw_customer_list
this.cb_print=create cb_print
this.cb_close=create cb_close
this.tab_cust=create tab_cust
this.cb_prev=create cb_prev
this.cb_new=create cb_new
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_name
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_next
this.Control[iCurrent+5]=this.dw_customer_list
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.tab_cust
this.Control[iCurrent+9]=this.cb_prev
this.Control[iCurrent+10]=this.cb_new
end on

on w_customer_contact.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_name)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_next)
destroy(this.dw_customer_list)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.tab_cust)
destroy(this.cb_prev)
destroy(this.cb_new)
end on

event open;call super::open;s_security_data  	lds_sec
String	ls_port //Alex Gerlants. 08/03/2016

IF f_security_door("Customer Information") < 0 THEN
	OpenWithParm(w_security_check, "Customer Information")
	lds_sec = Message.PowerObjectParm
	IF lds_sec.security_level < 0 THEN
		Close(this)
		RETURN 0
	END IF
END IF

//Alex Gerlants. 08/03/2016. Begin
is_from_email = gnv_app.of_GetUserId() + "@albl.com" //Email address "from"
is_from_name = gnv_app.of_GetUserId() //Name "from"

is_server = f_get_ini_value("desadv_req","smtp_email","server","192.168.3.67") //From table abis_ini

ls_port = f_get_ini_value("desadv_req","smtp_email","port","25")

If IsNumber(ls_port) Then
	ii_port = Integer(ls_port)
Else
	ii_port = 25
End If

is_send_email = f_get_ini_value("desadv_req","smtp_email","SupportEmail","it-support@albl.com")
is_send_name = f_get_ini_value("desadv_req","smtp_email","send_name","Support")
is_logfile = f_get_ini_value("desadv_req","smtp_email","logfile","P:\Email_Errors_LogFiles\SMTP_Email_LogFile.txt")
is_subject = f_get_ini_value("desadv_req","smtp_email","subject","GM Despatch Advice (DESADV) added")
//Alex Gerlants. 08/03/2016. End

//Alex Gerlants. CAR. 10/04/2017. Begin
is_from_email_new_customer = gnv_app.of_GetUserId() + "@albl.com" //Email address "from"
is_from_name_new_customer = gnv_app.of_GetUserId() //Name "from"

is_server_new_customer = f_get_ini_value("new_customer","smtp_email","server","192.168.3.67") //From table abis_ini

ls_port = f_get_ini_value("new_customer","smtp_email","port","25")

If IsNumber(ls_port) Then
	ii_port_new_customer = Integer(ls_port)
Else
	ii_port_new_customer = 25
End If

is_send_email_new_customer = f_get_ini_value("new_customer","smtp_email","SupportEmail","it-support@albl.com")
is_send_name_new_customer = f_get_ini_value("new_customer","smtp_email","send_name","Support")
is_logfile_new_customer = f_get_ini_value("new_customer","smtp_email","logfile","P:\Email_Errors_LogFiles\SMTP_Email_LogFile.txt")
is_subject_new_customer = f_get_ini_value("new_customer","smtp_email","subject","New Customer(s) added")
//Alex Gerlants. CAR. 10/04/2017. End

// customer list
dw_customer_list.of_SetLinkage(TRUE)

//contact list
tab_cust.tabpage_contact.dw_contact_list.of_SetLinkage( TRUE ) 
tab_cust.tabpage_contact.dw_contact_list.inv_Linkage.of_SetMaster(dw_customer_list)
IF NOT tab_cust.tabpage_contact.dw_contact_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & contact list in win w_customer_contact!" )
ELSE
	tab_cust.tabpage_contact.dw_contact_list.inv_Linkage.of_Register( "customer_id", "customer_id" ) 
	tab_cust.tabpage_contact.dw_contact_list.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_customer_list.inv_Linkage.of_SetTransObject(sqlca) 
this.Event ue_retrievelinkage()

tab_cust.tabpage_contact.dw_contact_list.ShareData(tab_cust.tabpage_contact.dw_contact_detail)
dw_customer_list.ShareData(tab_cust.tabpage_cust_info.dw_cust_detail)

dw_customer_list.ScrollToRow(dw_customer_list.RowCount())
dw_customer_list.ScrollToRow(1)

ib_desadv_req_changed = False //Alex Gerlants. 08/03/2016
ib_edi_req_changed = False //Alex Gerlants. 09/01/2016

dw_name.InsertRow(0) //Alex Gerlants. 09/25/2017
SetFocus(dw_name) //Alex Gerlants. 09/25/2017



end event

event pfc_new;SetPointer(HourGlass!)

dw_customer_list.Event pfc_addRow()

Return 


end event

event pfc_save;Integer 	li_return
Long		ll_i, ll_rows //Alex Gerlants. 08/03/2016
String	ls_desadv_req_prev, ls_desadv_req_current, ls_customer_list //Alex Gerlants. 08/03/2016
String	ls_edi_req_prev, ls_edi_req_current //Alex Gerlants. 09/01/2016
String	ls_customer_id, ls_customer_full_name //Alex Gerlants. 08/03/2016
String	ls_recipient, ls_subject, ls_notetext //Alex Gerlants. 08/03/2016
Boolean	lb_desadv_req_added //Alex Gerlants. 08/03/2016
Boolean	lb_edi_req_added, lb_changed //Alex Gerlants. 09/01/2016

String	ls_customer_list_new_customer //Alex Gerlants. CAR. 10/04/2017
Long		ll_row, ll_row_2delete, ll_temp[] //Alex Gerlants. CAR. 10/04/2017
String	ls_communication_code //Alex Gerlants. CAR_10042017

//Alex Gerlants. CAR. 10/04/2017. Begin
Integer	li_rtn

li_rtn = wf_check_4empty_name(ll_row_2delete)

If li_rtn = -1 Then
	dw_customer_list.DeleteRow(ll_row_2delete)
	
	//Remove the last element from il_new_customer_rows[]
	For ll_i = 1 To UpperBound(il_new_customer_rows[]) - 1
		ll_temp[UpperBound(ll_temp[]) + 1] = il_new_customer_rows[ll_i]
	Next
	
	il_new_customer_rows[] = ll_temp[]
End If
//Alex Gerlants. CAR. 10/04/2017. End

dw_customer_list.AcceptText()
tab_cust.tabpage_cust_info.dw_cust_detail.AcceptText()
tab_cust.tabpage_contact.dw_contact_list.AcceptText()
tab_cust.tabpage_contact.dw_contact_detail.AcceptText()

//Alex Gerlants. 08/03/2016. Begin
If ib_desadv_req_changed Or ib_edi_req_changed Then //User changed desadv_req on one or more rows
	//Check on what rows desadv_req is different from the value on database, and build string of user names to email to Support
	lb_desadv_req_added = False
	lb_edi_req_added = False

	ll_rows = tab_cust.tabpage_cust_info.dw_cust_detail.RowCount()
	
	For ll_i = 1 To ll_rows
		lb_changed = False
		
		ls_desadv_req_prev = tab_cust.tabpage_cust_info.dw_cust_detail.GetItemString(ll_i, "desadv_req", Primary!, True)
		If IsNull(ls_desadv_req_prev) Then ls_desadv_req_prev = "N"
		ls_desadv_req_current = tab_cust.tabpage_cust_info.dw_cust_detail.GetItemString(ll_i, "desadv_req", Primary!, False)
		If IsNull(ls_desadv_req_current) Then ls_desadv_req_current = "N"
		
		If ls_desadv_req_current = "Y" And (ls_desadv_req_current <> ls_desadv_req_prev) Then
			//desadv_req is different from the value on database
			lb_desadv_req_added = True
			lb_changed = True
		End If
		
		//---
		
		ls_edi_req_prev = tab_cust.tabpage_cust_info.dw_cust_detail.GetItemString(ll_i, "edi_req", Primary!, True)
		If IsNull(ls_edi_req_prev) Then ls_edi_req_prev = "N"
		ls_edi_req_current = tab_cust.tabpage_cust_info.dw_cust_detail.GetItemString(ll_i, "edi_req", Primary!, False)
		If IsNull(ls_edi_req_current) Then ls_edi_req_current = "N"
		
		If ls_edi_req_current = "Y" And (ls_edi_req_current <> ls_edi_req_prev) Then
			//edi_req is different from the value on database
			lb_edi_req_added = True
			lb_changed = True
		End If
		
		If lb_changed Then
			ls_customer_id = String(tab_cust.tabpage_cust_info.dw_cust_detail.Object.customer_id[ll_i])
			If IsNull(ls_customer_id) Then ls_customer_id = ""
			ls_customer_full_name = tab_cust.tabpage_cust_info.dw_cust_detail.Object.customer_full_name[ll_i]
			If IsNull(ls_customer_full_name) Then ls_customer_full_name = ""
			
			ls_customer_list = ls_customer_list + "~n~r" + ls_customer_id + " - " + ls_customer_full_name
		End If
	Next
End If
//Alex Gerlants. 08/03/2016. End		

li_return = dw_customer_list.inv_linkage.of_GetUpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -1
ELSEIF li_return = 0 THEN
	//No Change
	Return 0
END IF

li_return = dw_customer_list.inv_linkage.of_UpdateTopDown()
IF li_return <> 1 THEN
	ROLLBACK using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN 
		MessageBox("Rollback Error", SQLCA.SQLErrText )
	ELSE
		MessageBox("Update Failed", "But Rollback succeeded" )
	END IF
ELSE
	COMMIT using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText )
		Return -2
	END IF
	dw_customer_list.inv_linkage.of_ResetUpdate()
	
	//Alex Gerlants. CAR. 10/04/2017. Begin
	If ib_customer_added Then
		
		For ll_i = 1 To UpperBound(il_new_customer_rows[])
			ll_row = il_new_customer_rows[ll_i]
			
			ls_customer_id = String(tab_cust.tabpage_cust_info.dw_cust_detail.Object.customer_id[ll_row])
			If IsNull(ls_customer_id) Then ls_customer_id = ""
			ls_customer_full_name = tab_cust.tabpage_cust_info.dw_cust_detail.Object.customer_full_name[ll_row]
			If IsNull(ls_customer_full_name) Then ls_customer_full_name = ""
			
			ls_customer_list_new_customer = ls_customer_list_new_customer + "~n~r" + ls_customer_id + " - " + ls_customer_full_name + ", "
		Next
		
		//Remove the last comma
		ls_customer_list_new_customer = Left(ls_customer_list_new_customer, Len(ls_customer_list_new_customer) - 2)
		
		//ls_recipient = "agerlants@albl.com"
		//is_send_email = "agerlants@albl.com"
		
		ls_notetext = "New customer(s) added: " + ls_customer_list_new_customer + &
								"~n~rPlease ask the user if this is an ASN destination customer. If it is:" + &
								"~n~rFor a new Novelis destination customer, we have to add customer_id to database function f_edi_856." + &
								"~n~rEdit the function, and search for the following string, and add customer_id to the line below." + &
								"~n~rIF ((l_des_sh_cust_id IN -- if the destination we are shipping to is in this list..." + &
								"~n~rAfter the change, please compile the function."
		ls_notetext = "Server: " + sqlca.servername + "~n~r " + ls_notetext
		//is_subject = "New customer(s) added"
		
		wf_send_smtp_email_2support(ls_notetext, "new_customer")
	End If
	//Alex Gerlants. CAR. 10/04/2017. End
	
	//Alex Gerlants. 08/03/2016. Begin
	ib_desadv_req_changed = False
	ib_edi_req_changed = False
	
	If lb_desadv_req_added Or lb_edi_req_added Then
		//ls_recipient = "it-support@albl.com"
		//ls_recipient = "agerlants@albl.com"
		//ls_subject = "GM Despatch Advice added"
		ls_notetext = "EDI Required and/or GM Despatch Advice (DESADV) added for the following customers: " + ls_customer_list
		
		ls_notetext = "Server: " + sqlca.servername + "~n~r " + ls_notetext
		
		wf_send_smtp_email_2support(ls_notetext, "desadv")
	End If
	//Alex Gerlants. 08/03/2016. End
	
	ib_customer_added = False //Alex Gerlants. CAR. 10/04/2017
	
END IF

Return 1
end event

event pfc_print;long ll_row,ll_customer
Int li_rc

SetPointer(HourGlass!)
ll_row = dw_customer_list.GetRow()
IF ll_row > 0 THEN
	ll_customer = dw_customer_list.GetItemNumber(ll_row, "customer_id", Primary!,TRUE)
ELSE
	ll_customer = 0
END IF

Open(w_report_customer_list)

Return 1
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Customer Information") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type dw_name from datawindow within w_customer_contact
integer x = 37
integer width = 673
integer height = 102
integer taborder = 12
string dataobject = "d_name"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String	ls_data, ls_filter_string, ls_rtn
Integer	li_rtn
Long		ll_rows, ll_filteredcount

ls_data = Lower(data)

If Len(ls_data) > 0 Then
	ls_filter_string = "Lower(customer_short_name) like '" + ls_data + "%'"
Else
	ls_filter_string = ""
End If


li_rtn = dw_customer_list.SetFilter(ls_filter_string)
li_rtn = dw_customer_list.Filter()

dw_customer_list.SetSort("customer_short_name Asc")
dw_customer_list.Sort()


end event

type st_1 from statictext within w_customer_contact
integer x = 742
integer y = 26
integer width = 574
integer height = 54
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "<== Type Customer Name"
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_customer_contact
string tag = "Save Change "
integer x = 2121
integer y = 240
integer width = 351
integer height = 93
integer taborder = 30
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;Parent.event pfc_save()
end event

type cb_next from u_cb within w_customer_contact
string tag = "Next item"
integer x = 2121
integer y = 458
integer width = 351
integer height = 93
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "&Next"
end type

event clicked;RETURN Parent.Event ue_next()
end event

type dw_customer_list from u_dw within w_customer_contact
integer x = 37
integer y = 122
integer width = 2052
integer height = 765
integer taborder = 10
string dataobject = "d_customer_list"
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetBase(TRUE)
SetRowFocusIndicator(Hand!)





end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row
Int li_rc

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

tab_cust.tabpage_cust_info.dw_cust_detail.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event pfc_addrow;call super::pfc_addrow;Long 		ll_row, ll_new_id
String	ls_rtn

ll_row = this.GetRow()
IF ll_row < 1 THEN Return -1

ll_new_id = f_get_next_value("customer_id_seq")
this.SetItem(ll_row, "customer_id", ll_new_id)
this.SetItem(ll_row, "customer_type", 1 )

ib_customer_added = True //Alex Gerlants. CAR. 10/04/2017
il_new_customer_rows[UpperBound(il_new_customer_rows[]) + 1] = ll_row //Alex Gerlants. CAR. 10/04/2017

//ls_rtn = This.Modify("customer_full_name.Pointer='IBeam!'" //Alex Gerlants. CAR. 10/04/2017)
//ls_rtn = This.Modify("customer_short_name.Pointer='IBeam!'") //Alex Gerlants. CAR. 10/04/2017

Return ll_new_id

end event

type cb_print from u_cb within w_customer_contact
string tag = "print"
integer x = 2121
integer y = 566
integer width = 351
integer height = 93
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "P&rint"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_customer_contact
string tag = "Exit"
integer x = 2121
integer y = 675
integer width = 351
integer height = 93
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(parent)
end event

type tab_cust from tab within w_customer_contact
integer x = 29
integer y = 899
integer width = 2465
integer height = 1315
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean fixedwidth = true
boolean raggedright = true
boolean boldselectedtext = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_cust_info tabpage_cust_info
tabpage_contact tabpage_contact
end type

on tab_cust.create
this.tabpage_cust_info=create tabpage_cust_info
this.tabpage_contact=create tabpage_contact
this.Control[]={this.tabpage_cust_info,&
this.tabpage_contact}
end on

on tab_cust.destroy
destroy(this.tabpage_cust_info)
destroy(this.tabpage_contact)
end on

type tabpage_cust_info from userobject within tab_cust
integer x = 99
integer y = 13
integer width = 2352
integer height = 1290
long backcolor = 8421376
string text = "Customer Info"
long tabtextcolor = 33554432
long tabbackcolor = 8421376
long picturemaskcolor = 536870912
dw_cust_detail dw_cust_detail
end type

on tabpage_cust_info.create
this.dw_cust_detail=create dw_cust_detail
this.Control[]={this.dw_cust_detail}
end on

on tabpage_cust_info.destroy
destroy(this.dw_cust_detail)
end on

type dw_cust_detail from u_dw within tabpage_cust_info
event type long ue_retrievedddw ( string as_column )
integer x = 48
integer y = 10
integer width = 2289
integer height = 1290
integer taborder = 2
string dataobject = "d_customer_detail_list"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	Return dddw_cni.Retrieve()
END IF
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	Return dddw_cni.Retrieve()
END IF
end event

event constructor;DataWindowChild ldddw_cni

IF this.GetChild("customer_state", ldddw_cni) = -1 THEN
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("customer_state", ldddw_cni)
END IF
IF this.GetChild("bill_to_state", ldddw_cni) = -1 THEN
	Return -2
ELSE
	this.Event pfc_PopulateDDDW("bill_to_state", ldddw_cni)
END IF
IF this.GetChild("parent_id", ldddw_cni) = -1 THEN
	Return -3
ELSE
	this.Event pfc_PopulateDDDW("parent_id", ldddw_cni)
END IF

end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event losefocus;call super::losefocus;AcceptText()

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN 
	Return -1  
ELSE   
	Return adwc_obj.Retrieve() 
END IF

end event

event itemchanged;call super::itemchanged;////Alex Gerlants. 08/03/2016. Begin
//String	ls_column_name
//String	ls_cash_date_on_bol, ls_use_package_num
//
//ls_column_name = dwo.name
//
//If ls_column_name = "desadv_req" Then ib_desadv_req_changed = True
////Alex Gerlants. 08/03/2016. End
//
//If ls_column_name = "edi_req" Then ib_edi_req_changed = True //Alex Gerlants. 09/01/2016
//
////Alex Gerlants. 08/22/2018. Force Cash Date. Begin
//If ls_column_name = "cash_date_on_bol" Or ls_column_name = "use_package_num" Then
//	//If these 2 columns are on, this is an error because they are on the same spot on BOL.
//	//Thus, issue an error message to user
//	ls_use_package_num = Upper(This.Object.use_package_num[row])
//	ls_cash_date_on_bol = Upper(This.Object.cash_date_on_bol[row])
//	
//	//I am checking if either of the 2 columns are "N" because after a click, it changes to "Y"
//	If (ls_use_package_num = "N" And ls_cash_date_on_bol = "Y") Or&
//													(ls_use_package_num = "Y" And ls_cash_date_on_bol = "N") Then
//		MessageBox("Data input error", "'Use Package Number' and 'Cash Date on BOL' " + &
//				"~n~rOnly one of them may be checked ON " + &
//				"because these 2 values appear on the same spot on BOL." + &
//				"~n~rPlease uncheck one of them before saving.", StopSign!)
//	End If
//End If
////Alex Gerlants. 08/22/2018. Force Cash Date. End
end event

type tabpage_contact from userobject within tab_cust
integer x = 99
integer y = 13
integer width = 2352
integer height = 1290
long backcolor = 12639424
string text = "Contact Persons"
long tabtextcolor = 33554432
long tabbackcolor = 12639424
long picturemaskcolor = 536870912
dw_contact_list dw_contact_list
dw_contact_detail dw_contact_detail
cb_contact_new cb_contact_new
cb_contact_remove cb_contact_remove
cb_contact_prev cb_contact_prev
cb_contact_next cb_contact_next
end type

on tabpage_contact.create
this.dw_contact_list=create dw_contact_list
this.dw_contact_detail=create dw_contact_detail
this.cb_contact_new=create cb_contact_new
this.cb_contact_remove=create cb_contact_remove
this.cb_contact_prev=create cb_contact_prev
this.cb_contact_next=create cb_contact_next
this.Control[]={this.dw_contact_list,&
this.dw_contact_detail,&
this.cb_contact_new,&
this.cb_contact_remove,&
this.cb_contact_prev,&
this.cb_contact_next}
end on

on tabpage_contact.destroy
destroy(this.dw_contact_list)
destroy(this.dw_contact_detail)
destroy(this.cb_contact_new)
destroy(this.cb_contact_remove)
destroy(this.cb_contact_prev)
destroy(this.cb_contact_next)
end on

type dw_contact_list from u_dw within tabpage_contact
integer x = 48
integer y = 3
integer width = 1510
integer height = 464
integer taborder = 2
string dataobject = "d_contact_list"
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(Hand!)
end event

event pfc_addrow;call super::pfc_addrow;long ll_new_contact_id
Long ll_cur_cust_id
Long ll_row, ll_cust_row
Integer li_rc

//ll_new_contact_id = wf_getnew_id("Customer_Contact")
//messageBox("new id", string(ll_new_contact_id) )
ll_new_contact_id = f_get_next_value("customer_contact_id_seq")

ll_row = GetRow()
li_rc = SetItem(ll_row,"contact_id",ll_new_contact_id )
ll_cust_row = dw_customer_list.GetRow()
ll_cur_cust_id = dw_customer_list.GetItemNumber(ll_cust_row, "Customer_id", Primary!, TRUE)
li_rc = SetItem(ll_row, "customer_id", ll_cur_cust_id )

//li_rc = inv_linkage.of_Update(TRUE,TRUE)
//dw_contact_detail.Retrieve(ll_new_contact_id)

Return ll_new_contact_id

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

tab_cust.tabpage_contact.dw_contact_detail.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

type dw_contact_detail from u_dw within tabpage_contact
integer x = 48
integer y = 474
integer width = 2267
integer height = 480
integer taborder = 2
string dataobject = "d_customer_contact_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve(1)
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event losefocus;call super::losefocus;AcceptText()

end event

type cb_contact_new from u_cb within tabpage_contact
integer x = 1609
integer y = 54
integer width = 351
integer height = 93
integer taborder = 2
string facename = "Arial"
string text = "&New "
end type

event clicked;call super::clicked;SetPointer(HourGlass!)
dw_contact_list.Event pfc_addRow()
dw_contact_detail.SetFocus()
ii_contact_new_flag = 1
end event

type cb_contact_remove from u_cb within tabpage_contact
integer x = 1968
integer y = 54
integer width = 351
integer height = 93
integer taborder = 2
boolean bringtotop = true
string facename = "Arial"
string text = "&Remove"
end type

event clicked;call super::clicked;integer li_rc

SetPointer(HourGlass!)
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	dw_contact_list.inv_rowmanager.of_DeleteRow(0)
END IF

end event

type cb_contact_prev from u_cb within tabpage_contact
integer x = 1609
integer y = 173
integer width = 351
integer height = 93
integer taborder = 2
boolean bringtotop = true
string facename = "Arial"
string text = "&Prev"
end type

event clicked;call super::clicked;long row

row = dw_contact_list.GetRow()
dw_contact_list.SelectRow(0, FALSE)
dw_contact_list.SetRow(row - 1)
dw_contact_list.SelectRow((row - 1), TRUE)
dw_contact_list.Event pfc_RowChanged()

end event

type cb_contact_next from u_cb within tabpage_contact
integer x = 1968
integer y = 173
integer width = 351
integer height = 93
integer taborder = 2
boolean bringtotop = true
string facename = "Arial"
string text = "&N&ext"
end type

event clicked;call super::clicked;long row

row = dw_contact_list.GetRow()
dw_contact_list.SelectRow(0, FALSE)
dw_contact_list.SetRow(row + 1)
dw_contact_list.SelectRow((row + 1), TRUE)
dw_contact_list.Event pfc_RowChanged()

end event

type cb_prev from u_cb within w_customer_contact
string tag = "Previous item"
integer x = 2121
integer y = 349
integer width = 351
integer height = 93
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
string text = "&Prev"
end type

event clicked;RETURN Parent.Event ue_prior()
end event

type cb_new from commandbutton within w_customer_contact
integer x = 2121
integer y = 131
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&New"
end type

event clicked;//Alex Gerlants. CAR. 10/04/2017. Begin
Integer	li_rtn
long		ll_row //Not used here. it is used in pfc_save for w_customer_contact

li_rtn = wf_check_4empty_name(ll_row)
If li_rtn = -1 Then Return
//Alex Gerlants. CAR. 10/04/2017. End


////Alex Gerlants. CAR. 10/04/2017. Begin
//String	ls_customer_full_name, ls_customer_short_name
//Long		ll_row
//
//dw_customer_list.AcceptText()
//ll_row = dw_customer_list.RowCount()
//
//ls_customer_full_name = dw_customer_list.Object.customer_full_name[ll_row]
//If IsNull(ls_customer_full_name) Then ls_customer_full_name = ""
//ls_customer_short_name = dw_customer_list.Object.customer_short_name[ll_row]
//If IsNull(ls_customer_short_name) Then ls_customer_short_name = ""
//
//If ls_customer_full_name = "" Or ls_customer_short_name = "" Then Return
////Alex Gerlants. CAR. 10/04/2017. end


Parent.Event pfc_new()

end event

