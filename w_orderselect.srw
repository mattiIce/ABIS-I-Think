$PBExportHeader$w_orderselect.srw
$PBExportComments$Lists the orders of a customer for selection
forward
global type w_orderselect from w_abncwindow
end type
type dw_choices from datawindow within w_orderselect
end type
type cb_retrieve from commandbutton within w_orderselect
end type
type cb_new from commandbutton within w_orderselect
end type
type cb_cancel from commandbutton within w_orderselect
end type
type cb_context_help from commandbutton within w_orderselect
end type
end forward

global type w_orderselect from w_abncwindow
int X=206
int Y=157
int Width=2474
int Height=1177
WindowType WindowType=response!
boolean TitleBar=true
string Title="Order Selection"
long BackColor=8421504
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event uevent_ctrlmenu_close pbm_syscommand
dw_choices dw_choices
cb_retrieve cb_retrieve
cb_new cb_new
cb_cancel cb_cancel
cb_context_help cb_context_help
end type
global w_orderselect w_orderselect

type variables
// This window-level instance variable declares
// a structure (using a structure object definition).
// It is used to hold the values that were passed
// to this window through the PowerObjectParm.

s_selectinfo istr_passed

// This instance variable is used with the window's
// timer event to flash a message on and off in the
// dw_choices control.

integer ii_messageflash

// This instance variable is used in the window's Close
// Query event to indicate that the request to close 
// the Order Selection window came from another 
// window (typically the Order Entry window). This 
// variable is set in the wf_close_external function of
// the Order Selection window.

boolean ib_close_external
end variables

forward prototypes
public subroutine wf_close_external ()
end prototypes

event uevent_ctrlmenu_close;call w_abncwindow::uevent_ctrlmenu_close;/* Event profile
	
	Name:			uevent_ctrlmenu_close
	Applies to:	w_orderselect
	Kind:			User
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  SAMPLE SCRIPT --                                             /
//                   Trapping Windows messages via user events   /
//                                                               /
//  The following script is not used in the application, but it  /
//  is provided to show you a technique for trapping Microsoft   /
//  Windows-specific messages with user events.                  /
//                                                               /
//////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////
////                                                            /
//// This user event is mapped to the event ID pbm_syscommand   /
//// (which is the Window's message wm_syscommand).  As a       /
//// result, it is triggered when the user selects a menu item  /
//// from the window's Control (System) menu or when the user   /
//// clicks the window's Maximize or Minimize button.           /
////                                                            /
//// In this particular case, we want to see if the user has    /
//// chosen the Close menu item from the Control menu.  If so,  /
//// and if this is the user's first time in the Order          /
//// Selection response window, we want to close the Order      /
//// Entry window as well as the Order Selection window.        /
////                                                            /
//// (This script uses a value passed from the Order Entry      /
//// window to see if the user is making an initial order       /
//// selection.)                                                /
////                                                            /
/////////////////////////////////////////////////////////////////
//
//	// An integer representing the system command that the 
//	// user issued is returned to the application from 
//	// Windows in the wordparm property of the Message 
//	// system object.
//	//
//	// Before we can use this value, we must perform a 
//	// computation (dividing it by 16 and then multiplying
//	// it by 16) to clean it up.  (Note: The need to do this 
//	// wordparm clean-up is unique to pbm_syscommand.)
//	//
//	// We assign the cleaned-up result to a local variable.
//
//unsignedinteger lui_system_command
//
//lui_system_command = (message.wordparm / 16) * 16
//
//
//	// Now test to see if the returned system command is
//	// the Close menu item from the window's Control (System)
//	// menu.  The integer that represents this Close menu
//	// item (cs_close) is 61536.
//	//
//	// Also test whether this is the user's first time in 
//	// in the Order Selection window.
//
//IF lui_system_command = 61536 AND &
//	istr_passed.b_first_time = true THEN
//
//	Close (w_orderentry) 
//
//END IF

end event

public subroutine wf_close_external ();//////////////////////////////////////////////////////////////////
//                                                               /
//  Function name: wf_close_external                             /
//                                                               /
//  Of object: w_orderselect                                     /
//                                                               /
//  Purpose: A public function that is called by other windows   /
//           to close the w_orderselect window.                  /
//                                                               /
//  Requirements:  None                                          /
//                                                               /
//  Arguments:  None                                             /
//                                                               /
//  Return values:  None                                         /
//                                                               /
//////////////////////////////////////////////////////////////////


	// Set a flag (the instance variable ib_close_external) to 
	// indicate that the request to close the Order Selection 
	// window came from another window (typically the Order Entry 
	// window). This flag is then tested in the w_orderselect 
	// window's CloseQuery event script.

ib_close_external = true


	// Now close the w_orderselect window.

Close (this)

end subroutine

event closequery;call w_abncwindow::closequery;/* Event profile
	
	Name:			CloseQuery
	Applies to:	w_orderselect
	Kind:			System
	Processing:	Tests a couple of flags to determine how to handle
					the window close operation.

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  ib_close_external flag --                                    /
//                                                               /
//  Test this flag to determine if the request to close the      /
//  w_orderselect window came from another window (typically     /
//  w_orderentry). This flag is set when another window calls    /
//  the public function wf_close_external of w_orderselect.      /
//                                                               /
//  If ib_close_external is TRUE, then leave this script and     /
//  proceed to close the w_orderselect window.                   /
//                                                               /
//////////////////////////////////////////////////////////////////


IF ib_close_external = true THEN

	RETURN

END IF


//////////////////////////////////////////////////////////////////
//                                                               /
//  istr_passed.b_first_time flag --                             /
//                                                               /
//  Test this flag (which is passed from the w_orderentry        /
//  window) to determine if the user is making an initial        /
//  order selection:                                             /
//                                                               /
//  *  If yes, then close both the Order Selection window and    /
//		 the Order Entry window.                                   /
//                                                               /
//  *  If no, then just leave this script and proceed to close   /
// 	 the Order Selection window. This will enable the user     /
// 	 to go back to work on the Order Entry window.             /
//                                                               /
//////////////////////////////////////////////////////////////////


IF istr_passed.b_first_time = true THEN

	Close (w_orderentry)     // This will automatically close
								    // the Order Selection window too.
ELSE

	RETURN

END IF

end event

event open;call w_abncwindow::open;/* Event profile
	
	Name:			Open
	Applies to:	w_orderselect
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  Populate a structure (defined as a structure object and      /
//  declared as an instance variable) with the values passed     /
//  from the OrderEntry window through the PowerObjectParm of    /
//  the Message object.                                          /
//                                                               /
//  Important: The same structure object definition (in this     /
//  case s_selectinfo) must be used by the window (w_orderentry) /
//  that is passing the PowerObjectParm and by the window        /
//  (w_orderselect) that is receiving the PowerObjectParm.       /
//                                                               /
//////////////////////////////////////////////////////////////////


istr_passed = message.powerobjectparm

	//	Next, tell the application which transaction object to use
	// for the dw_choices DataWindow control.

dw_choices.SetTransObject(sqlca)

	// Retrieve all the order header rows for the customer whose Id 
	// was passed from the Customer window.

dw_choices.Retrieve(istr_passed.i_custid)

end event

event timer;call w_abncwindow::timer;/* Event profile
	
	Name:			Timer
	Applies to:	w_orderselect
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  When the customer has no rows in the dw_choices control,     /
//  this event is triggered every .5 seconds to switch a message /
//  on and off.  (See RetrieveEnd event script of dw_choices.)   /
//                                                               /
//////////////////////////////////////////////////////////////////


IF ii_messageflash = 1 THEN
   
   ii_messageflash = 2
	dw_choices.Modify &
		("order_header_order_entrydate_t.Text = ''")
	
ELSE
 
   ii_messageflash = 1
	dw_choices.Modify &
		("order_header_order_entrydate_t.Text = 'No orders on file!'")

		// Now randomly change the color of the message text.

	long ll_newcolor
	string ls_colorinfo

	ll_newcolor = RGB (Rand(255),Rand(255),Rand(255))

	ls_colorinfo = "order_header_order_entrydate_t.Color = '" +&
						string (ll_newcolor) + "'"
	dw_choices.Modify (ls_colorinfo)

END IF

end event

on w_orderselect.create
int iCurrent
call w_abncwindow::create
this.dw_choices=create dw_choices
this.cb_retrieve=create cb_retrieve
this.cb_new=create cb_new
this.cb_cancel=create cb_cancel
this.cb_context_help=create cb_context_help
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_choices
this.Control[iCurrent+2]=cb_retrieve
this.Control[iCurrent+3]=cb_new
this.Control[iCurrent+4]=cb_cancel
this.Control[iCurrent+5]=cb_context_help
end on

on w_orderselect.destroy
call w_abncwindow::destroy
destroy(this.dw_choices)
destroy(this.cb_retrieve)
destroy(this.cb_new)
destroy(this.cb_cancel)
destroy(this.cb_context_help)
end on

type p_1 from w_abncwindow`p_1 within w_orderselect
int X=755
end type

type dw_choices from datawindow within w_orderselect
int X=65
int Y=329
int Width=1802
int Height=641
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ordselect"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;/* Event profile
	
	Name:			RowFocusChanged
	Applies to:	w_orderselect.dw_choices
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  The following code highlights the current row in the         /
//  DataWindow control.                                          /
//                                                               /
//  First, unhighlight all rows.                                 /
//                                                               /
//////////////////////////////////////////////////////////////////

this.SelectRow(0,false)


//////////////////////////////////////////////////////////////////
//                                                               /
//  Then, highlight the current row.                             /
//                                                               /
//  Note: it is possible that the current row of the dw_choice   /
//  DataWindow control might not contain an actual order header  /
//  row.  That's because the associated DataWindow allows for    /
//  an outer join (in case the customer has no orders).  In this /
//  case, we don't want to highlight that row.                   /
//                                                               /
//////////////////////////////////////////////////////////////////

integer li_orderid
li_orderid = this.GetItemNumber (this.GetRow(),"order_header_order_id")

IF not IsNull(li_orderid) THEN

	this.SelectRow(this.GetRow(),true)

END IF

end event

event retrieveend;/* Event profile
	
	Name:			RetrieveEnd
	Applies to:	w_orderselect.dw_choices
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  The DataWindow associated with the dw_choices DataWindow     /
//  control is defined to allow an outer join.  This means if    /
//  the customer has no orders, dw_choices will still display    /
//  a row -- this row will contain customer info (from the       /
//  Customer table) but it will have null values in its order    /
//  header columns.                                              /
//                                                               /
//  The following code tests to see if the customer has no       /
//  orders in dw_choices (indicated by the current row having    /
//  a null order id).  In this case, disable the control and     /
//  modify how it appears.                                       /
//                                                               /
//////////////////////////////////////////////////////////////////

integer li_orderid
li_orderid = this.GetItemNumber (this.GetRow(),"order_header_order_id")


IF IsNull(li_orderid) THEN
	
	this.enabled = false

		//	Change the color of the DataWindow's background to 
		// light gray.
	
	this.Modify("DataWindow.Color = 12632256")

		// Next, make the columns in the detail band invisible.

	this.Modify("order_header_order_entrydate.Visible = '0'")
	this.Modify("order_header_order_id.Visible = '0'")
	this.Modify("order_header_order_totalcost.Visible = '0'")
	this.Modify("order_header_order_balance.Visible = '0'")
	this.Modify("order_header_order_status.Visible = '0'")

		// Clear the column header text from the header band.  
		// Use the first column header to display a message instead.

	this.Modify &
		("order_header_order_entrydate_t.Text = 'No orders on file!'")
	this.Modify("order_header_order_id_t.Text = ''")
	this.Modify("order_header_order_totalcost_t.Text = ''")
	this.Modify("order_header_order_balance_t.Text = ''")
	this.Modify("order_header_order_status_t.Text = ''")

		// Switch off italic for the column header being used to 
		// display the message and make its background white.

	this.Modify &
		("order_header_order_entrydate_t.Font.Italic='0'")
	this.Modify &
		("order_header_order_entrydate_t.Background.Color='16777215'")

		// And switch the background mode from transparent to opaque
		// so that this color change can be seen.

	this.Modify &
		("order_header_order_entrydate_t.Background.Mode='0'")

		// Now make the message text bold and centered.

	this.Modify &
		("order_header_order_entrydate_t.Font.Weight='700'")
	this.Modify &
		("order_header_order_entrydate_t.Alignment='2'")

		// And make the border around the message text 3D Lowered.

	this.Modify &
		("order_header_order_entrydate_t.Border='5'")


		// Trigger the Order Selection window's timer to make the 
		// "No order on file!" message flash on and off.

	randomize (0) 	// Initializes the random number generator
						// for future use (in the window's Timer
						// event script).
	ii_messageflash = 1
	Timer(.5,parent)


		// Also disable the Retrieve Order commandbutton.
		  
	cb_retrieve.enabled = false

END IF

end event

event doubleclicked;/* Event profile
	
	Name:			DoubleClicked
	Applies to:	w_orderselect.dw_choices
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  If the user double-clicks on an order row in dw_choices,     /
//  we want to process that order just as if they clicked        /
//  the Retrieve Order commandbutton.                            /
//                                                               /
//////////////////////////////////////////////////////////////////


	// To begin, find out which row (if any) the user clicked.
	// You can get this value from the Row argument of the 
	// DoubleClicked event.	

long ll_clickrow

ll_clickrow = row


	//	If the user did click on a row (and not on some other
	// part of the DataWindow control), then execute the 
	// Clicked event script of the Retrieve Order command
	// button.

IF NOT ll_clickrow = 0 THEN  
	
	cb_retrieve.TriggerEvent (clicked!)

END IF

end event

type cb_retrieve from commandbutton within w_orderselect
int X=1953
int Y=457
int Width=430
int Height=109
int TabOrder=30
boolean BringToTop=true
string Text="&Retrieve Order"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/* Event profile
	
	Name:			Clicked
	Applies to:	w_orderselect.cb_retrieve
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  Call a public function of the Order Entry window             /
//  (named wf_oldorder_selected) that closes the Order           /
//  Selection window and then opens an existing order in         /
//  the Order Entry window.                                      /
//                                                               /
//  The function requires 4 arguments:  the ID of the            /
//  selected order, the fullname of the current customer,        /
//  their phone number, and their discount percent.              /
//  We get these values from the dw_choices DataWindow           /
//  control of the Order Selection window.                       /
//                                                               /
//////////////////////////////////////////////////////////////////


string ls_fullname, ls_phone
integer li_discount, li_orderid
long ll_currow


	//  Get the values we need for function arguments from
	//  dw_choices.  First, get the order ID from the current
	//  row of dw_choices:

ll_currow = dw_choices.GetRow()
li_orderid = dw_choices.GetItemNumber (ll_currow,"order_header_order_id")


	// Now get the other values that we need from dw_choices. 
	// Note that Fullname refers to the calculated field
	// in the header band that concatenates the customer's
	// first and last names.  The other two columns are in the 
	// DataWindow buffer (retrieved from the Customer table), but
	// are not displayed.

ls_fullname = dw_choices.GetItemString &
									(1,"fullname")

ls_phone = dw_choices.GetItemString &
									(1,"customer_cust_phone")

li_discount = dw_choices.GetItemNumber &
									(1,"customer_cust_discount_percent")


	// Now call the function and pass the values.

w_orderentry.wf_oldorder_selected &
									(li_orderid, ls_fullname, &
									 ls_phone, li_discount)

end event

type cb_new from commandbutton within w_orderselect
int X=1953
int Y=325
int Width=430
int Height=109
int TabOrder=20
boolean BringToTop=true
string Text="&New Order"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/* Event profile
	
	Name:			Clicked
	Applies to:	w_orderselect.cb_new
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  Call a public function of the Order Entry window             /
//  (named wf_neworder_selected) that closes the Order           /
//  Selection window and then opens a new order in the           /
//  Order Entry window.                                          /
//                                                               /
//  The function requires 3 arguments: the fullname of the       /
//  current customer, their phone number, and their              /
//  discount percent.  We get these values from the              /
//  dw_choices DataWindow control of the Order Selection         /
//  window.                                                      /
//                                                               /
//////////////////////////////////////////////////////////////////


string ls_fullname, ls_phone
integer li_discount


	// Get the values we need for function arguments from 
	// dw_choices.  Note that Fullname refers to the calculated
	// field in the header band that concatenates the customer's
	// first and last names.  The other two columns are in the 
	// DataWindow buffer (retrieved from the Customer table), but
	// are not displayed.

ls_fullname = dw_choices.GetItemString &
									(1,"fullname")

ls_phone = dw_choices.GetItemString &
									(1,"customer_cust_phone")

li_discount = dw_choices.GetItemNumber &
									(1,"customer_cust_discount_percent")


	// Now call the function and pass the values.

w_orderentry.wf_neworder_selected &
									(ls_fullname, ls_phone, li_discount)

end event

type cb_cancel from commandbutton within w_orderselect
int X=1953
int Y=589
int Width=430
int Height=109
int TabOrder=40
boolean BringToTop=true
string Text="Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/* Event profile
	
	Name:			Clicked
	Applies to:	w_orderselect.cb_cancel
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  This script closes the Order Selection window without        /
//  selecting a new or existing order.                           /
//                                                               /
//  Note: If the user presses Cancel when making an initial      /
//        order selection, we also want to close the Order       /
//        Entry window. See the CloseQuery event of the          /
//        Order Selection window for details.                    /
//                                                               /
//////////////////////////////////////////////////////////////////


Close (parent)

end event

type cb_context_help from commandbutton within w_orderselect
int X=1953
int Y=721
int Width=430
int Height=109
int TabOrder=50
boolean BringToTop=true
string Text="&Help"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/* Event profile
	
	Name:			Clicked
	Applies to:	w_orderselect.cb_context_help
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  This script implements context-sensitive help in the Order   /
//  Selection response window. If the user clicks the Help       /
//  commandbutton in this window, we want to open the            /
//  application's online Help file and display the topic that    /
//  discusses how to select and add orders.                      /
//                                                               /
//  One way to get to the particular topic we want is to search  /
//  for a keyword that has been defined for this topic in the    /
//  Help file. In this case, we can search for the keyword:      /
//  "adding orders".                                             /
//                                                               /
//  To do all of this, call the public function uf_do_help of    /
//  the u_activity_manager user object (referenced via           /
//  guo_global_vars.iuo_com_actman). The uf_do_help function     /
//  is overloaded in u_activity_manager, having three different  /
//  implementations (each with a different signature). The       /
//  implementation of uf_do_help that we want to call here takes /
//  one argument: a string that specifies the keyword to search  /
//  for.                                                         /
//                                                               /
//////////////////////////////////////////////////////////////////

guo_global_vars.iuo_com_actman.uf_do_help("adding orders")

end event

