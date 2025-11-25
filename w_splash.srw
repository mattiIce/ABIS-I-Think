$PBExportHeader$w_splash.srw
$PBExportComments$Extension Splash window
forward
global type w_splash from pfc_w_splash
end type
end forward

global type w_splash from pfc_w_splash
end type
global w_splash w_splash

on w_splash.create
call super::create
end on

on w_splash.destroy
call super::destroy
end on

type st_copyright from pfc_w_splash`st_copyright within w_splash
end type

type st_version from pfc_w_splash`st_version within w_splash
end type

type st_application from pfc_w_splash`st_application within w_splash
integer textsize = -18
fontcharset fontcharset = ansi!
end type

type gb_allaround from pfc_w_splash`gb_allaround within w_splash
end type

type ln_1 from pfc_w_splash`ln_1 within w_splash
end type

type ln_2 from pfc_w_splash`ln_2 within w_splash
end type

type ln_3 from pfc_w_splash`ln_3 within w_splash
end type

type ln_4 from pfc_w_splash`ln_4 within w_splash
end type

type p_splash from pfc_w_splash`p_splash within w_splash
end type

