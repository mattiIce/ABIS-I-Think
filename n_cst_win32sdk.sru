$PBExportHeader$n_cst_win32sdk.sru
$PBExportComments$win app control
forward
global type n_cst_win32sdk from nonvisualobject
end type
end forward

global type n_cst_win32sdk from nonvisualobject
end type
global n_cst_win32sdk n_cst_win32sdk

type prototypes
FUNCTION  boolean  ShowWindow( long  winhandle, int wincommand ) Library "user32.dll"
FUNCTION  BOOLEAN BringWindowToTop(  ulong  HWND  ) Library "user32.dll"
FUNCTION  long        FindWindowA( ulong  Winhandle, string wintitle ) Library "user32.dll"
end prototypes

forward prototypes
public function long of_findwindowbytitle (string as_wintitle)
public function boolean of_showwindow (long al_winhandle)
public function long of_findwindowbytitle (string as_wintitle)
public function boolean of_showwindow (long al_winhandle)
public function boolean of_bringtotop (unsignedlong al_winhandle)
end prototypes

public function long of_findwindowbytitle (string as_wintitle);

Return FindWindowA( 0, as_wintitle )


end function

public function boolean of_showwindow (long al_winhandle);

Return ShowWindow( al_winhandle, 5 )
end function

public function boolean of_bringtotop (unsignedlong al_winhandle);

Return BringWindowToTop( al_winhandle )
end function

on n_cst_win32sdk.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_win32sdk.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

