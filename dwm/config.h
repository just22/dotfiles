/* See LICENSE file for copyright and license details. */

/* appearance */
static const char *fonts[] = {
	"DejaVu Sans Mono:size=9"
};
static const char dmenufont[]       = "DejaVu Sans Mono:size=9";

/* Default colorscheme */
/*
static const char normbordercolor[] = "#444444";
static const char normbgcolor[]     = "#222222";
static const char normfgcolor[]     = "#bbbbbb";
static const char selbordercolor[]  = "#005577";
static const char selbgcolor[]      = "#005577";
static const char selfgcolor[]      = "#eeeeee";
*/

/* Base16 chalk color scheme */
/*
static const char normbordercolor[] = "#3d3d3d"; // brightblack
static const char normbgcolor[]     = "#9c9c9c"; // white
static const char normfgcolor[]     = "#fcfcfc"; // brightwhite
static const char selbordercolor[]  = "#cf4f88"; // brightred
static const char selbgcolor[]      = "#fcfcfc"; // brightwhite
static const char selfgcolor[]      = "#121212"; // black
*/

/* Solarized dark color scheme */
/*
static const char normbordercolor[] = "#587e75"; // base01
static const char normbgcolor[]     = "#002b36"; // base03
static const char normfgcolor[]     = "#839496"; // base0
static const char selbordercolor[]  = "#dc322f"; // red
static const char selbgcolor[]      = "#073642"; // base02
static const char selfgcolor[]      = "#dc322f"; // red
//static const char selfgcolor[]      = "#6c71c4"; // violet
*/

/* Solarized light color scheme */
static const char normbordercolor[] = "#eee8d5"; // base02
static const char normbgcolor[]     = "#eee8d5"; // base2
static const char normfgcolor[]     = "#293a1a"; // cyan
static const char selbordercolor[]  = "#dc322f"; // red
static const char selbgcolor[]      = "#2aa198"; // base01
static const char selfgcolor[]      = "#fdf6e3"; // base03

static const unsigned int borderpx       = 1;   /* border pixel of windows */
static const unsigned int snap           = 32;  /* snap pixel */
static const int showbar                 = 1;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "S" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class	instance	title	                tags mask	isfloating	monitor */
	{ "Gimp",	NULL,		NULL,			0,		True,		-1 },
	{ "Firefox",	"Navigator",	NULL,			1 << 4,		False,		-1 },
	{ "Firefox",	"Browser",	NULL,			1 << 4,		True,		-1 },
	{ "Firefox",	"Places",	NULL,			1 << 4,		True,		-1 },
	{ "Firefox",	"Toplevel",	NULL,			0,		True,		-1 },
	{ "Claws-mail",	"claws-mail",	NULL,			1 << 3,		False,		-1 },
	{ "XConsole",	NULL,		NULL,			1 << 5,		False,		-1 },
	{ "Xmessage",	NULL,		NULL,			0,		True,		-1 },
	{ "XTerm",	NULL,		"System log",		1 << 5,		False,		-1 },
	{ "XTerm",	NULL,		"Process monitor",	1 << 5,		False,		-1 },
	{ "XTerm",	NULL,		"System stats",		1 << 5,		False,		-1 },
	{ "XTerm",	NULL,		"Screenshot",		0,		True,		-1 },
	{ "XCalc",	"xcalc",	NULL,			0,		True,		-1 },
	{ "XLoad",	"xload",	NULL,			0,		True,		-1 },
	{ "XClock",	"xclock",	NULL,			0,		True,		-1 },
	{ "XBiff",	"xbiff",	NULL,			0,		True,		-1 },
	{ "Clock",	"oclock",	NULL,			0,		True,		-1 },
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
static const char *dmenucmd[]		= { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]		= { "xterm", NULL };
static const char *tmuxcmd[]		= { "xterm", "-e", "tmux attach-session -d || tmux new-session", NULL };
static const char *logoutcmd[]		= { "dmenu-session-logout", NULL };
static const char *lowervolcmd[]	= { "mixerctl", "-q", "outputs.master=-10", NULL };
static const char *mutecmd[]		= { "mixerctl", "-q", "-t", "outputs.master.mute", NULL };
static const char *raisevolcmd[]	= { "mixerctl", "-q", "outputs.master=+10", NULL };
static const char *setdisplaycmd[]	= { "dmenu-xrandr", NULL };
static const char *suspendcmd[]		= { "zzz", NULL };
static const char *hibernatecmd[]	= { "ZZZ", NULL };
static const char *browsercmd[]		= { "firefox-launcher", NULL };
static const char *mailclientcmd[]	= { "xterm", "-title", "Mutt E-Mail Client", "-e", "mutt", NULL };
static const char *lockcmd[]		= { "xscreensaver-command", "-lock", NULL };
static const char *filemanagercmd[]	= { "xterm", "-e", "ranger", NULL };
static const char *filebrowsercmd[]	= { "dmenu-filebrowser", NULL };
static const char *playercmd[]		= { "play-url", "-g", "-d", "-p", NULL };
static const char *winsearchcmd[]	= { "win_search", NULL };
static const char *tmuxpanesearchcmd[]	= { "tmux_pane_search", NULL };
static const char *calccmd[]		= { "dmenu-calc", NULL };
static const char *timercmd[]		= { "dmenu-timer", NULL };
static const char *rootmenucmd[]	= { "dmenu-root", NULL };
static const char *perfpolicycmd[]	= { "dmenu-perf", NULL };

static Key keys[] = {
	/* modifier                     key                         function        argument */
	{ MODKEY,                       XK_F2,                      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_d,                       spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return,                  spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_t,                       spawn,          {.v = tmuxcmd } },
	{ MODKEY,                       XK_a,                       togglebar,      {0} },
	{ MODKEY,                       XK_Tab,                     focusstack,     {.i = +1 } },
	//{ MODKEY,                       XK_i,                       incnmaster,     {.i = +1 } },
	//{ MODKEY,                       XK_d,                       incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_Left,                    setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_Up,                      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_Right,                   setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Down,                    setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return,                  zoom,           {0} },
	{ MODKEY,                       XK_backslash,               view,           {0} },
	{ MODKEY,                       XK_grave,                   view,           {0} },
	{ MODKEY,                       XK_x,                       killclient,     {0} },
	{ MODKEY,                       XK_v,                       setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,                       setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_h,                       setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_o,                       setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_space,                   togglefloating, {0} },
	{ MODKEY,                       XK_comma,                   focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,                  focusmon,       {.i = +1 } },
	{ MODKEY,                       XK_agrave,                  view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_agrave,                  tag,            {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_comma,                   tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,                  tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                                       0)
	TAGKEYS(                        XK_2,                                       1)
	TAGKEYS(                        XK_3,                                       2)
	TAGKEYS(                        XK_4,                                       3)
	TAGKEYS(                        XK_5,                                       4)
	TAGKEYS(                        XK_6,                                       5)
	TAGKEYS(                        XK_0,                                       6)
	{ MODKEY,                       XK_q,                       quit,           {0} },
	{ MODKEY|ShiftMask,             XK_q,                       spawn,          {.v = logoutcmd} },
	{ 0,                            XF86XK_AudioLowerVolume,    spawn,          {.v = lowervolcmd} },
	{ MODKEY|ControlMask,           XK_v,                       spawn,          {.v = lowervolcmd} },
	{ 0,                            XF86XK_AudioMute,           spawn,          {.v = mutecmd} },
	{ MODKEY|ControlMask,           XK_m,                       spawn,          {.v = mutecmd} },
	{ 0,                            XF86XK_AudioRaiseVolume,    spawn,          {.v = raisevolcmd} },
	{ MODKEY|ControlMask|ShiftMask, XK_v,                       spawn,          {.v = raisevolcmd} },
	{ 0,                            XF86XK_Display,             spawn,          {.v = setdisplaycmd} },
	{ MODKEY|ShiftMask,             XK_d,                       spawn,          {.v = setdisplaycmd} },
	{ MODKEY|ShiftMask,             XK_s,                       spawn,          {.v = suspendcmd} },
	{ MODKEY|ShiftMask,             XK_h,                       spawn,          {.v = hibernatecmd} },
	{ Mod1Mask|ControlMask,         XK_Delete,                  spawn,          {.v = lockcmd} },
	{ MODKEY|ShiftMask,             XK_b,                       spawn,          {.v = browsercmd} },
	{ MODKEY|ShiftMask,             XK_m,                       spawn,          {.v = mailclientcmd} },
	{ MODKEY|ShiftMask,             XK_f,                       spawn,          {.v = filemanagercmd} },
	{ MODKEY|ShiftMask,             XK_c,                       spawn,          {.v = calccmd} },
	{ MODKEY|ShiftMask,             XK_r,                       spawn,          {.v = timercmd} },
	{ MODKEY,                       XK_f,                       spawn,          {.v = filebrowsercmd} },
	{ MODKEY|ShiftMask,             XK_p,                       spawn,          {.v = playercmd} },
	{ MODKEY,                       XK_w,                       spawn,          {.v = winsearchcmd} },
	{ MODKEY,                       XK_t,                       spawn,          {.v = tmuxpanesearchcmd} },
	{ MODKEY,                       XK_r,                       spawn,          {.v = rootmenucmd} },
	{ MODKEY|ControlMask,           XK_c,                       spawn,          {.v = perfpolicycmd} },
};

/* button definitions */
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

