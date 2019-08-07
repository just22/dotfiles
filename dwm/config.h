/* See LICENSE file for copyright and license details. */

/* appearance */
static const char *fonts[] = {
	"DejaVu Sans Mono:size=9"
};
static const char dmenufont[]       = "DejaVu Sans Mono:size=9";

/* Solarized light color scheme */
static const char normbordercolor[] = "#eee8d5"; // base02
static const char normbgcolor[]     = "#eee8d5"; // base2
static const char normfgcolor[]     = "#293a1a"; // cyan
static const char selbordercolor[]  = "#dc322f"; // red
static const char selbgcolor[]      = "#2aa198"; // base01
static const char selfgcolor[]      = "#fdf6e3"; // base03

static const unsigned int borderpx       = 2;   /* border pixel of windows */
static const unsigned int snap           = 32;  /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor
                                                  >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor
                                                   0: dis/lyay systray on the last monitor */
static const int showsystray             = 1;   /* 0 means no systray */
static const int showbar                 = 1;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class		instance		title	                tags mask	isfloating	monitor */
	{ "Arandr",             NULL,	        	NULL,			0,		True,		-1 },
	{ "Clock",		"oclock",		NULL,			0,		True,		-1 },
	{ "Dialog",	        "__tk__messagebox",	"SimVision Exit",	0,		True,		-1 },
	{ "Firefox",		"Browser",	        NULL,			1 << 4,		True,		-1 },
	{ "Firefox",		"Navigator",	        NULL,			1 << 4,		False,		-1 },
	{ "Firefox",		"Places",	        NULL,			1 << 4,		True,		-1 },
	{ "Firefox",		"Toplevel",	        NULL,			0,		True,		-1 },
	{ "Gimp",		NULL,			NULL,			0,		True,		-1 },
	{ "Pinentry-gtk-2",	NULL,	        	NULL,			0,		True,		-1 },
	{ "Sound",	        "sound",		NULL,			0,		True,		-1 },
	{ "Toplevel",		NULL,	        	NULL,			0,		True,		-1 },
	{ "XBiff",		"xbiff",		NULL,			0,		True,		-1 },
	{ "XCalc",		"xcalc",		NULL,			0,		True,		-1 },
	{ "XClock",		"xclock",		NULL,			0,		True,		-1 },
	{ "XConsole",		NULL,			NULL,			1 << 8,		False,		-1 },
	{ "XLoad",		"xload",		NULL,			0,		True,		-1 },
	{ "XTerm",		NULL,			"Process monitor",	1 << 8,		False,		-1 },
	{ "XTerm",		NULL,			"Screenshot",		0,		True,		-1 },
	{ "XTerm",		NULL,			"System log",		1 << 8,		False,		-1 },
	{ "XTerm",		NULL,			"System stats",		1 << 8,		False,		-1 },
	{ "XTerm",		NULL,			"Window's properties",	0,		True,		-1 },
	{ "XTerm",		NULL,			"cmixer",		0,		True,		-1 },
	{ "Xdialog",		"Xdialog",		NULL,			0,		True,		-1 },
	{ "Xmessage",		NULL,			NULL,			0,		True,		-1 },
};

/* layout(s) */
static const float mfact       = 0.5;  /* factor of master area size [0.05..0.95] */
static const int   nmaster     = 1;    /* number of clients in master area */
static const int   resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
};

/* XF86 Key symbols */
#include <X11/XF86keysym.h>

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *browsercmd[]		= { "x-www-browser", NULL };
static const char *calccmd[]		= { "dmenu-calc", NULL };
static const char *dmenucmd[]		= { "dmenu_run", "-p", "Run:", "-m", dmenumon,
                                                "-fn", dmenufont, "-nb", normbgcolor,
                                                "-nf", normfgcolor, "-sb", selbgcolor,
                                                "-sf", selfgcolor, NULL };
static const char *filebrowsercmd[]	= { "dmenu-filebrowser", NULL };
static const char *filemanagercmd[]	= { "xterm", "-e", "ranger", NULL };
static const char *helpcmd[]	        = { "xterm", "-title", "dwm man page", "-e", "man -m ~/share/man dwm", NULL };
static const char *hibernatecmd[]	= { "ZZZ", NULL };
static const char *kbdlayoutcmd[]	= { "dmenu-kbd", NULL };
static const char *launchercmd[]	= { "dmenu-launchers", NULL };
static const char *lockcmd[]		= { "slock", NULL };
static const char *logoutcmd[]		= { "dmenu-session-logout", NULL };
static const char *lowervolcmd[]	= { "mixerctl", "-q", "outputs.master=-10", NULL };
static const char *lprcmd[]		= { "dmenu-lpr", NULL };
static const char *mailclientcmd[]	= { "x-email-client", NULL };
static const char *mutecmd[]		= { "mixerctl", "-q", "-t", "outputs.master.mute", NULL };
static const char *perfpolicycmd[]	= { "dmenu-perf", NULL };
static const char *playercmd[]		= { "play-url", "-p", NULL };
static const char *raisevolcmd[]	= { "mixerctl", "-q", "outputs.master=+10", NULL };
static const char *setdisplaycmd[]	= { "dmenu-xrandr", NULL };
static const char *slstatuscmd[]	= { "slstatus-switch", NULL };
static const char *suspendcmd[]		= { "zzz", NULL };
static const char *termcmd[]		= { "xterm", NULL };
static const char *timercmd[]		= { "dmenu-timer", NULL };
static const char *tmuxcmd[]		= { "xterm", "-e", "tmux attach-session -d || tmux new-session", NULL };
static const char *tmuxpanesearchcmd[]	= { "tmux_pane_search", NULL };
static const char *winsearchcmd[]	= { "win_search", NULL };
static const char *xautolockcmd[]	= { "dmenu-xautolock", NULL };
static const char *xpropcmd[]		= { "activewin_xprop", NULL };
static const char *execF3cmd[]		= { "exec-F3", NULL };
static const char *execF4cmd[]		= { "exec-F4", NULL };
static const char *execF5cmd[]		= { "exec-F5", NULL };
static const char *execF6cmd[]		= { "exec-F6", NULL };
static const char *execF7cmd[]		= { "exec-F7", NULL };
static const char *execF8cmd[]		= { "exec-F8", NULL };
static const char *execF9cmd[]		= { "exec-F9", NULL };
static const char *execF10cmd[]		= { "exec-F10", NULL };
static const char *execF11cmd[]		= { "exec-F11", NULL };
static const char *execF12cmd[]		= { "exec-F12", NULL };

/* See /usr/X11R6/include/X11/keysymdef.h */
static Key keys[] = {
	/* modifier                     key                         function        argument */
	TAGKEYS(                        XK_1,                                       0)
	TAGKEYS(                        XK_2,                                       1)
	TAGKEYS(                        XK_3,                                       2)
	TAGKEYS(                        XK_4,                                       3)
	TAGKEYS(                        XK_5,                                       4)
	TAGKEYS(                        XK_6,                                       5)
	TAGKEYS(                        XK_7,                                       6)
	TAGKEYS(                        XK_8,                                       7)
	TAGKEYS(                        XK_9,                                       8)
	TAGKEYS(                        XK_0,                                       9)
	{ MODKEY,                       XK_comma,                   focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,                  focusmon,       {.i = +1 } },
	{ MODKEY,                       XK_Tab,                     focusstack,     {.i = +1 } },
	{ MODKEY|ControlMask,           XK_d,                       incnmaster,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_i,                       incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_x,                       killclient,     {0} },
	{ MODKEY,                       XK_Down,                    setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Left,                    setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_Right,                   setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Up,                      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_h,                       setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_m,                       setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_o,                       setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_v,                       setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_q,                       quit,           {0} },
	{ MODKEY,                       XK_minus,                   tag,            {.ui = 1 << 9} },
	{ MODKEY|ShiftMask,             XK_agrave,                  tag,            {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_comma,                   tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,                  tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_a,                       togglebar,      {0} },
	{ MODKEY,                       XK_space,                   togglefloating, {0} },
	{ MODKEY,                       XK_plus,                    toggleview,     {.ui = 1 << 9} },
	{ MODKEY,                       XK_agrave,                  view,           {.ui = ~0 } },
	{ MODKEY,                       XK_grave,                   view,           {0} },
	{ MODKEY,                       XK_backslash,               view,           {0} },
	{ MODKEY,                       XK_Return,                  zoom,           {0} },

        /* Common WM actions */
	{ MODKEY,                       XK_F1,                      spawn,          {.v = helpcmd } },
	{ MODKEY,                       XK_F2,                      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_d,                       spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_f,                       spawn,          {.v = filebrowsercmd} },
	{ MODKEY,                       XK_p,                       spawn,          {.v = xpropcmd} },
	{ MODKEY,                       XK_r,                       spawn,          {.v = launchercmd} },
	{ MODKEY,                       XK_s,                       spawn,          {.v = slstatuscmd} },
	{ MODKEY,                       XK_t,                       spawn,          {.v = tmuxpanesearchcmd} },
	{ MODKEY,                       XK_w,                       spawn,          {.v = winsearchcmd} },

        /* External  applications */
	{ MODKEY|ShiftMask,             XK_Return,                  spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_b,                       spawn,          {.v = browsercmd} },
	{ MODKEY|ShiftMask,             XK_c,                       spawn,          {.v = calccmd} },
	{ MODKEY|ShiftMask,             XK_d,                       spawn,          {.v = setdisplaycmd} },
	{ MODKEY|ShiftMask,             XK_f,                       spawn,          {.v = filemanagercmd} },
	{ MODKEY|ShiftMask,             XK_m,                       spawn,          {.v = mailclientcmd} },
	{ MODKEY|ShiftMask,             XK_p,                       spawn,          {.v = playercmd} },
	{ MODKEY|ShiftMask,             XK_r,                       spawn,          {.v = timercmd} },
	{ MODKEY|ShiftMask,             XK_q,                       spawn,          {.v = logoutcmd} },
	{ MODKEY|ShiftMask,             XK_t,                       spawn,          {.v = tmuxcmd } },
	{ MODKEY|ShiftMask,             XK_x,                       spawn,          {.v = xautolockcmd} },

	/* Configurable keys (site dependent) */
	{ MODKEY,                       XK_F3,                      spawn,          {.v = execF3cmd} },
	{ MODKEY,                       XK_F4,                      spawn,          {.v = execF4cmd} },
	{ MODKEY,                       XK_F5,                      spawn,          {.v = execF5cmd} },
	{ MODKEY,                       XK_F6,                      spawn,          {.v = execF6cmd} },
	{ MODKEY,                       XK_F7,                      spawn,          {.v = execF7cmd} },
	{ MODKEY,                       XK_F8,                      spawn,          {.v = execF8cmd} },
	{ MODKEY,                       XK_F9,                      spawn,          {.v = execF9cmd} },
	{ MODKEY,                       XK_F10,                     spawn,          {.v = execF10cmd} },
	{ MODKEY,                       XK_F11,                     spawn,          {.v = execF11cmd} },
	{ MODKEY,                       XK_F12,                     spawn,          {.v = execF12cmd} },

        /* Heritages... */
	{ Mod1Mask|ControlMask,         XK_Delete,                  spawn,          {.v = lockcmd} },

        /* System specific */
	{ MODKEY|ControlMask,           XK_c,                       spawn,          {.v = perfpolicycmd} },
	{ MODKEY|ShiftMask,             XK_h,                       spawn,          {.v = hibernatecmd} },
	{ MODKEY|ShiftMask,             XK_k,                       spawn,          {.v = kbdlayoutcmd} },
	{ MODKEY|ShiftMask,             XK_l,                       spawn,          {.v = lprcmd} },
	{ MODKEY|ShiftMask,             XK_s,                       spawn,          {.v = suspendcmd} },

        /* Volume control */
	{ MODKEY|ControlMask,           XK_m,                       spawn,          {.v = mutecmd} },
	{ MODKEY|ControlMask,           XK_v,                       spawn,          {.v = lowervolcmd} },
	{ MODKEY|ControlMask|ShiftMask, XK_v,                       spawn,          {.v = raisevolcmd} },

        /* Multimedia keys */
	{ 0,                            XF86XK_AudioLowerVolume,    spawn,          {.v = lowervolcmd} },
	{ 0,                            XF86XK_AudioMute,           spawn,          {.v = mutecmd} },
	{ 0,                            XF86XK_AudioRaiseVolume,    spawn,          {.v = raisevolcmd} },
	{ 0,                            XF86XK_Display,             spawn,          {.v = setdisplaycmd} },
};

/* Mouse actions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

