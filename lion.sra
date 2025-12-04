$PBExportHeader$lion.sra
forward
global type lion from application
end type
global n_tr_abc01 sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
n_cst_lionappmanager gnv_app
n_cst_logonattrib	gnv_logonattrib
String gs_sql_search_string[ ]

String gs_ini_file
String gs_downtime_ini_file
String gs_Sketch_file
String gs_Sketch_bmp_file
String gs_efSketch_file
String gs_Maint_Parts_file

String gs_LogID
String gs_LogPass


Long gl_message
Long gl_customer
Long gl_session
s_order_and_item gstr_order
connection g_connection
int gi_screen
int gi_dual_mode
CONSTANT integer COM1 = 0
CONSTANT integer COM2 = 1
CONSTANT integer COM3 = 2
CONSTANT integer COM4 = 3
CONSTANT integer COM5 = 4
CONSTANT integer COM6 = 5
CONSTANT integer COM7 = 6
CONSTANT integer COM8 = 7
CONSTANT integer COM9 = 8

// Parity Codes

CONSTANT integer WSC_NoParity = 0
CONSTANT integer WSC_OddParity = 1
CONSTANT integer WSC_EvenParity = 2
CONSTANT integer WSC_MarkParity = 3
CONSTANT integer WSC_SpaceParity = 4

// Stop Bit Codes

CONSTANT integer WSC_OneStopBit  = 0
CONSTANT integer WSC_One5StopBit = 1
CONSTANT integer WSC_TwoStopBits = 2

// Word Length Codes

CONSTANT integer WSC_WordLength5 = 5
CONSTANT integer WSC_WordLength6 = 6
CONSTANT integer WSC_WordLength7 = 7
CONSTANT integer WSC_WordLength8 = 8

// baud codes

CONSTANT integer WSC_Baud110 = 0
CONSTANT integer WSC_Baud300 = 1
CONSTANT integer WSC_Baud1200 = 2
CONSTANT integer WSC_Baud2400 = 3
CONSTANT integer WSC_Baud4800 = 4
CONSTANT integer WSC_Baud9600 = 5
CONSTANT integer WSC_Baud19200 = 6
CONSTANT integer WSC_Baud38400 = 7
CONSTANT integer WSC_Baud57600 = 8
CONSTANT integer WSC_Baud115200 = 9

// SioGetError Masks

CONSTANT integer WSC_RXOVER = 1
CONSTANT integer WSC_OVERRUN = 2
CONSTANT integer WSC_PARITY = 4
CONSTANT integer WSC_FRAME = 8
CONSTANT integer WSC_BREAK = 16
CONSTANT integer WSC_TXFULL = 256

// Command codes

CONSTANT integer WSC_ASSERT_BREAK = 65
CONSTANT integer WSC_CANCEL_BREAK = 67
CONSTANT integer WSC_DETECT_BREAK = 68

CONSTANT integer WSC_SET_LINE = 83
CONSTANT integer WSC_CLEAR_LINE = 67
CONSTANT integer WSC_READ_LINE = 82

// Return codes

CONSTANT integer IE_BADID = -1
CONSTANT integer IE_OPEN = -2
CONSTANT integer IE_NOPEN = -3
CONSTANT integer IE_MEMORY = -4
CONSTANT integer IE_DEFAULT = -5
CONSTANT integer IE_HARDWARE = -10
CONSTANT integer IE_BYTESIZE = -11
CONSTANT integer IE_BAUDRATE = -12
CONSTANT integer WSC_NO_DATA = -100
CONSTANT integer WSC_BUSY  = -100
CONSTANT integer WSC_RANGE = -101
CONSTANT integer WSC_ABORTED = -102
CONSTANT integer WSC_WIN32ERR = -103
CONSTANT integer WSC_EXPIRED = -104
CONSTANT integer WSC_BUFFERS = -105
CONSTANT integer WSC_THREAD  = -106
CONSTANT integer WSC_TIMEOUT = -107
CONSTANT integer WSC_KEYCODE = -108

// SioFlow Commands

CONSTANT integer WSC_HARDWARE_FLOW_CONTROL = 72
CONSTANT integer WSC_SOFTWARE_FLOW_CONTROL = 83
CONSTANT integer WSC_NO_FLOW_CONTROL       = 78

// SioSetInteger Commands

CONSTANT integer WSC_WAIT_ON_PUTS = 87
CONSTANT integer WSC_SET_BURST = 66
CONSTANT integer WSC_GET_HANDLE = 72
CONSTANT integer WSC_SIGNAL = 83
CONSTANT long 	  WSC_KEY_CODE = 539633696

String	gs_albl_email_address //Alex Gerlants. 08/08/2017
String gs_auto_start_auto_report//Alex_Auto_Start_Auto_Inventory_Report. 10/22/2018
end variables
global type lion from application
string appname = "lion"
end type
global lion lion

type prototypes
Function integer SioDone(integer Port) library  "WSC32.DLL"
FUNCTION int SioBaud(int Port,Uint Baud) LIBRARY "WSC32.DLL"
FUNCTION int SioBrkSig(int Port,char cmd) LIBRARY "WSC32.DLL"
FUNCTION int SioCTS(int Port) LIBRARY "WSC32.DLL"
FUNCTION int SioDCD(int Port) LIBRARY "WSC32.DLL"
FUNCTION int SioDebug(int Parm) LIBRARY "WSC32.DLL"
FUNCTION int SioDSR(int Port) LIBRARY "WSC32.DLL"
FUNCTION int SioDTR(int Port,char cmd) LIBRARY "WSC32.DLL"
FUNCTION int SioEvent(int Port,int Mask) LIBRARY "WSC32.DLL"
FUNCTION int SioFlow(int Port,char cmd) LIBRARY "WSC32.DLL"
Function char SioGetc(integer Port) library "WSC32.DLL";
FUNCTION int SioGets(int Port,REF string str,Uint cnt) LIBRARY "WSC32.DLL"
FUNCTION int SioInfo(char cmd) LIBRARY "WSC32.DLL"
FUNCTION int SioKeyCode(long keycode) LIBRARY "WSC32.DLL"
FUNCTION int SioParms(int Port,int Parity,int Stopbits,int DataBits) LIBRARY "WSC32.DLL"
FUNCTION int SioPutc(int Port,char chardata) LIBRARY "WSC32.DLL"
FUNCTION int SioPuts(int Port,REF string str,uint cnt) LIBRARY "WSC32.DLL"
FUNCTION int SioRead(int Port,int Reg) LIBRARY "WSC32.DLL"
FUNCTION int SioReset(int Port,int RxQueSize,int TxQueSize) LIBRARY "WSC32.DLL"
FUNCTION int SioRI(int Port) LIBRARY "WSC32.DLL"
FUNCTION int SioRTS(int Port,char cmd) LIBRARY "WSC32.DLL"
FUNCTION int SioRxClear(int Port) LIBRARY "WSC32.DLL"
FUNCTION int SioRxQue(int Port) LIBRARY "WSC32.DLL"
FUNCTION int SioStatus(int Port,uint Mask) LIBRARY "WSC32.DLL"
FUNCTION int SioTxClear(int Port) LIBRARY "WSC32.DLL"
FUNCTION int SioTxQue(int Port) LIBRARY "WSC32.DLL"
FUNCTION int SioUnGetc(int Port,char chardata) LIBRARY "WSC32.DLL"
FUNCTION int SioWinError(REF string str,int cnt) LIBRARY "WSC32.DLL"
FUNCTION int SioGetReg(ref string Buffer, uint BufLen) LIBRARY "WSC32.DLL"
PUBLIC FUNCTION unsignedlong FindWindow (long classname, string windowname) LIBRARY "user32.dll" ALIAS FOR FindWindowA
PUBLIC FUNCTION int SetForegroundWindow (unsignedlong hwnd) LIBRARY "user32.dll" ALIAS FOR SetForegroundWindowA

subroutine sleep_ms ( long al_milliseconds ) library "kernel32.dll" alias for "Sleep" //Alex Gerlants. 06/12/2019. Ship_Print_Delay

end prototypes

on lion.create
appname="lion"
message=create message
sqlca=create n_tr_abc01
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on lion.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event close;gnv_app.Event pfc_Close()
destroy gnv_app
end event

event connectionbegin;gnv_app = CREATE n_cst_appmanager
Return gnv_app.Event pfc_connectionbegin(userid,password,connectstring)
end event

event connectionend;gnv_app.Event pfc_connectionend()
destroy gnv_app
end event

event idle;gnv_app.Event pfc_idle()
end event

event open;Boolean	lb_show_menu_auto_report //Alex_Novelis_Auto_Combined_Report. 03/02/2018

n_cst_win32sdk	lnv_sdk
long	ll_winhandle
string ls_application
If Not IsValid( lnv_sdk ) Then
	lnv_sdk	=	Create n_cst_win32sdk
End if	

ll_winhandle	=	lnv_sdk.of_FindWindowByTitle( "Aluminum Blanking Co. Integrated System" )

If ll_winhandle > 0 Then
	
	lnv_sdk.of_BringToTop( ll_winhandle )
	lnv_sdk.of_ShowWindow( ll_winhandle )
	destroy lnv_sdk
	Return
	
End If

// Added 04/25/2016 - Patrick Reynolds
gs_ini_file = "C:\abis\LION.INI"

// Added 05/27/2016 - Patrick Reynolds
gs_downtime_ini_file = "C:\abis\downtime.ini"
gs_LogID = "dbo"
gs_LogPass = "obd#157"

//Patrick Reynolds Added 07/19/2016
gs_Sketch_file = "C:\abis\Sketch.jpg"
gs_Sketch_bmp_file = "C:\abis\Sketch.bmp"
gs_efSketch_file = "C:\abis\efSketch.jpg"
gs_Maint_Parts_file = "C:\abis\Maint_Parts.jpg"


// ls_application = ProfileString(gs_ini_file,"APPLICATION","location","office")
ls_application = ProfileString(gs_ini_file,"APPLICATION","location","office")

if ls_application = "shop" then
	
	unsignedlong hwnd
	hwnd = FindWindow( 0, "DAS")
	if hwnd = 0 then
			gnv_app = CREATE n_cst_lionappmanager
			gnv_app.Event pfc_open(commandline)
			return
	else
   	// open the previous instance window and halt
   	SetForegroundWindow( hwnd )
   	HALT CLOSE
	end if
else
	gnv_app = CREATE n_cst_lionappmanager
	gnv_app.Event pfc_open(commandline)
end if


//Alex_Novelis_Auto_Combined_Report. 03/02/2018. Begin
lb_show_menu_auto_report = Upper(ProfileString(gs_ini_file,"AUTO_INVENTORY_REPORT","show_menu_auto_report", "n")) = "Y" //from lion.ini file

If lb_show_menu_auto_report Then
	m_lion_sys_frame.m_reports.m_23.Visible = True
Else
	m_lion_sys_frame.m_reports.m_23.Visible = False
End If
//Alex_Novelis_Auto_Combined_Report. 03/02/2018. End

end event

event systemerror;gnv_app.Event pfc_systemerror()
end event

