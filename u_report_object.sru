$PBExportHeader$u_report_object.sru
$PBExportComments$parent report object for all other individule report objects
forward
global type u_report_object from n_cst_dwsrv
end type
end forward

global type u_report_object from n_cst_dwsrv
event type integer ue_createreport ( long al_shipment,  long al_item,  long al_job )
event type integer ue_setupreport ( )
event type integer ue_groupdwprint ( long al_shipment )
event type any ue_custom_display ( )
event type integer ue_groupdwprint_4skid ( long al_shipment,  long al_sheet_skid_num )
end type
global u_report_object u_report_object

type variables
Public:
String is_objectname
Int li_allowsetup  // 1  -- yse   0 -- no
Int li_argumenttype 
// 1  - shipment
// 2 - item
// 3 - job
s_dw_info istr_dw

Protected:

end variables

forward prototypes
public function integer of_retrieve (long al_shipment)
public function integer of_allowsetup ()
public function string of_getreportobject ()
public function integer of_setupreport ()
public function integer of_argumenttype ()
public subroutine of_savereport ()
public function integer of_printshippingreport (long al_shipment)
public function integer of_printshippingreport_4skid (long al_shipment, long al_sheet_skid_num)
end prototypes

event ue_createreport;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		ue_createreport
//
//	Access:    		Public
//
//	Arguments: 		Long
//						al_shipment - shipment's packing list number
//						al_item - item number
//						al_job - job number
//
//	Returns:   		Integer
//   					1 if success
//						< 0  if there are errors
//
//	Description:  fill data into report
//
//////////////////////////////////////////////////////////////////////////////
RETURN 1
end event

event ue_setupreport;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		ue_setupreport
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		Integer
//						1 -- success
//						other -- failed
//
//	Description:  setup a report
//
//////////////////////////////////////////////////////////////////////////////
RETURN 1
end event

event ue_groupdwprint;//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		ue_groupdwprint
//
//	Arguments: 		Long
//						shipment's packing list
//
//	Returns:   		Integer
//   					1 if it succeeds 
//						others if an error occurs.
//
//	Description:  Print more than one datawindow here
//
//////////////////////////////////////////////////////////////////////////////
RETURN 1
end event

event ue_custom_display;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		ue_custom_display
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		s_dw_info userobject
//
//	Description:  setup report display window
//
//////////////////////////////////////////////////////////////////////////////
RETURN istr_dw
end event

event type integer ue_groupdwprint_4skid(long al_shipment, long al_sheet_skid_num);Return 1 //Alex Gerlants. Reprint_Barcode_Button. 05/07/2019
end event

public function integer of_retrieve (long al_shipment);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Retrieve
//
//	Access:    		Public
//
//	Arguments: 		Long
//					shipment's packing list
//
//	Returns:   		Integer
//   					1 if it succeeds and -1 if an error occurs.
//
//	Description:  Retrieves (using 'pfc_retrieve' event) the datawindows in the
//					  window, starting with the requesting datawindow.
//
//////////////////////////////////////////////////////////////////////////////
Long ll_item, ll_job
// Retrieve the requesting datawindow.
CHOOSE CASE of_argumenttype()
	CASE 1   //shipment
		IF idw_requestor.Retrieve(al_shipment) = -1 Then Return -1
		IF this.Event ue_createreport(al_shipment, 0, 0) < 1 THEN Return -2
	CASE 2  //item
		CONNECT USING SQLCA;
		SELECT sheet_skid_num INTO :ll_item
		FROM sheet_packing_item
		WHERE packing_list = :al_shipment
		USING SQLCA;
		IF idw_requestor.Retrieve(ll_item) = -1 Then Return -3
		IF this.Event ue_createreport(al_shipment, ll_item, 0) < 1 THEN Return -4
	CASE 3  //job
		CONNECT USING SQLCA;
		SELECT sheet_skid_num INTO :ll_item
		FROM sheet_packing_item
		WHERE packing_list = :al_shipment
		USING SQLCA;
		SELECT ab_job_num INTO :ll_job
		FROM sheet_skid
		WHERE sheet_skid_num = :ll_item
		USING SQLCA;
		IF idw_requestor.Retrieve(al_shipment, ll_job) = -1 Then Return -5
		IF this.Event ue_createreport(al_shipment, 0, ll_job) < 1 THEN Return -6
END CHOOSE	
idw_requestor.AcceptText()
idw_requestor.ResetUpdate()
Return 1
end function

public function integer of_allowsetup ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_allowsetup
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		Integer
//   					1 if report needs setup
//						0 if no setup allowed in this report
//
//	Description:  indicated whether report allow setup
//
//////////////////////////////////////////////////////////////////////////////
Return li_allowsetup
end function

public function string of_getreportobject ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_allowsetup
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		String
//			    		-- report datawindw object name
//
//	Description:  report's datawindow object
//
//////////////////////////////////////////////////////////////////////////////

RETURN is_objectname
end function

public function integer of_setupreport ();/////////////////////////////////////////////////////////////////////////////
//	Function:  		of_setupreport
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		Integer
//   					1 if report needs setup
//						other if no setup allowed in this report
//
//	Description:  setup current report
//
//////////////////////////////////////////////////////////////////////////////

RETURN this.Event ue_setupreport()
end function

public function integer of_argumenttype ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_argumenttype
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		Integer
//						1 -- shipment packing list number  -- default
//
//	Description:  indicated what kind of argument current report is baed on
//
//////////////////////////////////////////////////////////////////////////////
RETURN li_argumenttype
end function

public subroutine of_savereport ();/////////////////////////////////////////////////////////////////////////////
//	Function:  		of_savereport
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		None
//
//	Description:  save current displaced report
//
//////////////////////////////////////////////////////////////////////////////

String ls_title, ls_from

ls_from = string(Date(Today()),"mmddyyyy") + String(Now(), "hhmm")

ls_title = ProfileString(gs_ini_file, "REPORT","file_path","c:\temp")+'\' +ls_from +".PSR"

IF idw_requestor.SaveAs(ls_title, PSReport!, FALSE) =-1 THEN
  	MessageBox("Quotation DataStore SaveAs", "Error") 
	RETURN
END IF

MessageBox("Success", "File has been saved as " + ls_title + " Successfully!" )


end subroutine

public function integer of_printshippingreport (long al_shipment);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_printshippingreport
//
//	Access:    		Public
//
//	Arguments: 		Long
//					shipment's packing list
//
//	Returns:   		Integer
//   					1 if it succeeds 
//						others if an error occurs.
//
//	Description:  Send current shipping report to printer
//
//////////////////////////////////////////////////////////////////////////////
RETURN this.Event ue_groupdwprint(al_shipment)
end function

public function integer of_printshippingreport_4skid (long al_shipment, long al_sheet_skid_num);//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. Begin
Integer	li_rtn

li_rtn = This.Event ue_groupdwprint_4skid(al_shipment, al_sheet_skid_num)

Return li_rtn
//Alex Gerlants. Reprint_Barcode_Button. 05/07/2019. End
end function

on u_report_object.destroy
call super::destroy
end on

on u_report_object.create
call super::create
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Constructor
//
//
//////////////////////////////////////////////////////////////////////////////
//is_objectname = ""
li_allowsetup = 0
li_argumenttype = 1 

end event

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Destructor
//
//	Description:  	Service Cleanup.
//
//////////////////////////////////////////////////////////////////////////////


end event

