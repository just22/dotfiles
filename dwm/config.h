/* See LICENSE file for copyright and license details. */

/* custom function declarations */
static void bstack(Monitor *m);

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray             = 1;   /* 0 means no systray */
static const int showbar                 = 1;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */
static const char statussep         = ';';      /* separator between status bar text */
static const char *fonts[]          = { "DejaVu Sans Mono:size=9" };
static const char dmenufont[]       = "DejaVu Sans Mono:size=9";

/* Solarized theme */
static const char col_base0[]       = "#839496";
static const char col_base2[]       = "#eee8d5";
static const char col_base01[]      = "#2aa198";
static const char col_base03[]      = "#fdf6e3";
static const char col_cyan[]        = "#293a1a";
static const char col_red[]         = "#dc322f";
static const char *colors[][3]      = {
	/*               fg          bg          border   */
	[SchemeNorm] = { col_cyan,   col_base2,  col_base0 },
	[SchemeSel]  = { col_base03, col_base01, col_red },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class		instance		title			tags mask	isfloating	position	monitor */
	{ "Arandr",             NULL,	        	NULL,			0,		True,		5,		-1 },
	{ "Clock",		"oclock",		NULL,			0,		True,		5,		-1 },
	{ "Dialog",             NULL,                   NULL,	                0,		True,		5,		-1 },
	{ "Pinentry-gtk-2",	NULL,	        	NULL,			0,		True,		5,		-1 },
	{ "Sound",	        "sound",		NULL,			0,		True,		9,		-1 },
	{ "Toplevel",		NULL,	        	NULL,			0,		True,		5,		-1 },
	{ "XCalc",		NULL,			NULL,			0,		True,		5,		-1 },
	{ "XClock",		NULL,			NULL,			0,		True,		5,		-1 },
	{ "XLoad",		NULL,			NULL,			0,		True,		5,		-1 },
	{ NULL,			NULL,			"Process monitor",	1 << 8,		False,		5,		-1 },
	{ NULL,			NULL,			"Screenshot",		0,		True,		5,		-1 },
	{ NULL,			NULL,			"System log",		1 << 8,		False,		5,		-1 },
	{ NULL,			NULL,			"System stats",		1 << 8,		False,		5,		-1 },
	{ NULL,			NULL,			"Window's properties",	0,		True,		5,		-1 },
	{ NULL,			NULL,			"cmixer",		0,		True,		5,		-1 },
	{ "Xdialog",		NULL,			NULL,			0,		True,		5,		-1 },
	{ "Xmessage",		NULL,			NULL,			0,		True,		5,		-1 },
	{ NULL,		        "Qt-subapplication",	NULL,			0,		True,		5,		-1 },
	{ NULL,			NULL,			"Event Tester",		0,		True,		5,		-1 },
	{ "Gsimplecal",		NULL,			NULL,			0,		True,		9,		-1 },
	{ NULL,			NULL,			"Error",		0,		True,		5,		-1 },
	{ NULL,			NULL,			"Warning",		0,		True,		5,		-1 },
	{ NULL,			NULL,			"Removables",		0,		True,		5,		-1 },
	{ NULL,			NULL,			"Calculator",		0,		True,		5,		-1 },
};

/* layout(s) */
static const float mfact     = 0.5;    /* factor of master area size [0.05..0.95] */
static const int   nmaster     = 1;    /* number of clients in master area */
static const int   resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "TTT",      bstack },
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
static const char *dmenucmd[]		= { "dmenu_run", "-p", "Run:", "-m", dmenumon, "-fn", dmenufont, "-nb", col_base2, "-nf", col_cyan, "-sb", col_base01, "-sf", col_base03, NULL };
static const char *termcmd[]		= { "x-terminal-emulator", NULL };
static const char *browsercmd[]		= { "x-www-browser", NULL };
static const char *calcmd[]		= { "gsimplecal", NULL };
static const char *calccmd[]		= { "dmenu-calc", NULL };
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
static const char *filebrowsercmd[]	= { "dmenu-filebrowser", NULL };
static const char *filemanagercmd[]	= { "x-filemanager", NULL };
static const char *helpcmd[]	        = { "x-terminal-emulator", "-T", "dwm man page", "-e", "man dwm", NULL };
static const char *hibernatecmd[]	= { "ZZZ", NULL };
static const char *kbdlayoutcmd[]	= { "dmenu-kbd", NULL };
static const char *mixercmd[]		= { "x-terminal-emulator", "-g", "110x25", "-e", "cmixer", NULL };
static const char *startcmd[]		= { "dmenu-start", NULL };
static const char *lockcmd[]		= { "slock", NULL };
static const char *logoutcmd[]		= { "x-session-logout", NULL };
static const char *lowervolcmd[]	= { "sndioctl", "-q", "output.level=-0.1", NULL };
static const char *lprcmd[]		= { "dmenu-lpr", NULL };
static const char *mailclientcmd[]	= { "x-email-client", NULL };
static const char *mutecmd[]		= { "sndioctl", "-q", "-t", "outputs.mute", NULL };
static const char *perfpolicycmd[]	= { "dmenu-perf", NULL };
static const char *playercmd[]		= { "play-url", "-p", NULL };
static const char *raisevolcmd[]	= { "sndioctl", "-q", "output.level=+0.1", NULL };
static const char *setdisplaycmd[]	= { "dmenu-xrandr", NULL };
static const char *setwinlabelcmd[]	= { "dmenu-setwinlabel", NULL };
static const char *shadecmd[]	        = { "wmctrl", "-r", ":ACTIVE:", "-b", "add,shaded",  NULL };
static const char *suspendcmd[]		= { "zzz", NULL };
static const char *timercmd[]		= { "dmenu-timer", NULL };
static const char *tmuxcmd[]		= { "x-terminal-emulator", "-e", "tmux attach-session -d || tmux new-session", NULL };
static const char *tmuxpanesearchcmd[]	= { "tmux_pane_search", NULL };
static const char *winsearchcmd[]	= { "win_search", "-t", NULL };
static const char *xautolockcmd[]	= { "dmenu-xautolock", NULL };
static const char *xpropcmd[]		= { "activewin_xprop", NULL };

/* See /usr/X11R6/include/X11/keysymdef.h (or /usr/include/X11/keysymdef.h) */
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
	{ MODKEY,                       XK_minus,                   hide,           {0} },
	{ MODKEY,                       XK_comma,                   focusmon,       {.i = -1} },
	{ MODKEY,                       XK_period,                  focusmon,       {.i = +1} },
	{ MODKEY,                       XK_Tab,                     focusstack,     {.i = +1} },
	{ MODKEY|ControlMask,           XK_d,                       incnmaster,     {.i = -1} },
	{ MODKEY|ControlMask,           XK_i,                       incnmaster,     {.i = +1} },
	{ MODKEY,                       XK_x,                       killclient,     {0} },
	{ MODKEY,                       XK_Down,                    setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Left,                    setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_Right,                   setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Up,                      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_h,                       setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_m,                       setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_v,                       setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ControlMask,           XK_q,                       quit,           {0} },
	{ MODKEY|ShiftMask,             XK_agrave,                  tag,            {.ui = ~0} },
	{ MODKEY|ShiftMask,             XK_comma,                   tagmon,         {.i = -1} },
	{ MODKEY|ShiftMask,             XK_period,                  tagmon,         {.i = +1} },
	{ MODKEY,                       XK_a,                       togglebar,      {0} },
	{ MODKEY,                       XK_space,                   togglefloating, {0} },
	{ MODKEY,                       XK_agrave,                  view,           {.ui = ~0} },
	{ MODKEY,                       XK_grave,                   view,           {0} },
	{ MODKEY,                       XK_backslash,               view,           {0} },
	{ MODKEY,                       XK_Return,                  zoom,           {0} },

        /* Common WM actions */
	{ MODKEY,                       XK_F1,                      spawn,          {.v = helpcmd } },
	{ 0,                            XK_Menu,                    spawn,          {.v = startcmd } },
	{ MODKEY,                       XK_d,                       spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_f,                       spawn,          {.v = filebrowsercmd} },
	{ MODKEY,                       XK_minus,                   spawn,          {.v = shadecmd} },
	{ MODKEY,                       XK_p,                       spawn,          {.v = xpropcmd} },
	{ MODKEY,                       XK_t,                       spawn,          {.v = tmuxpanesearchcmd} },
	{ MODKEY,                       XK_w,                       spawn,          {.v = winsearchcmd} },
	{ MODKEY|ShiftMask,             XK_w,                       spawn,          {.v = setwinlabelcmd} },

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
	{ MODKEY|ShiftMask,             XK_v,                       spawn,          {.v = mixercmd} },
	{ MODKEY,                       XK_KP_0,                    spawn,          {.v = mutecmd} },
	{ MODKEY,                       XK_KP_Insert,               spawn,          {.v = mutecmd} },
	{ MODKEY,                       XK_KP_Subtract,             spawn,          {.v = lowervolcmd} },
	{ MODKEY,                       XK_KP_Add,                  spawn,          {.v = raisevolcmd} },

        /* Multimedia keys */
	{ 0,                            XF86XK_AudioMute,           spawn,          {.v = mutecmd} },
	{ 0,                            XF86XK_AudioLowerVolume,    spawn,          {.v = lowervolcmd} },
	{ 0,                            XF86XK_AudioRaiseVolume,    spawn,          {.v = raisevolcmd} },
	{ 0,                            XF86XK_Display,             spawn,          {.v = setdisplaycmd} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            ControlMask,    Button1,        tag,            {0} },
	{ ClkTagBar,            ControlMask,    Button3,        toggletag,      {0} },
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button2,        setlayout,      {.v = &layouts[0]} },
	{ ClkLtSymbol,          ControlMask,    Button2,        setlayout,      {.v = &layouts[3]} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        switchstext,    {0} },
	{ ClkWinTitle,          0,              Button3,        spawn,          {.v = startcmd} },
	{ ClkStatusText,        0,              Button1,        spawn,          {.v = calcmd} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
};


/* custom function implementations */

void
bstack(Monitor *m) {
	int w, h, mh, mx, tx, ty, tw;
	unsigned int i, n;
	Client *c;

	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++);
	if (n == 0)
		return;
	if (n > m->nmaster) {
		mh = m->nmaster ? m->mfact * m->wh : 0;
		tw = m->ww / (n - m->nmaster);
		ty = m->wy + mh;
	} else {
		mh = m->wh;
		tw = m->ww;
		ty = m->wy;
	}
	for (i = mx = 0, tx = m->wx, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++) {
		if (i < m->nmaster) {
			w = (m->ww - mx) / (MIN(n, m->nmaster) - i);
			resize(c, m->wx + mx, m->wy, w - (2 * c->bw), mh - (2 * c->bw), 0);
			mx += WIDTH(c);
		} else {
			h = m->wh - mh;
			resize(c, tx, ty, tw - (2 * c->bw), h - (2 * c->bw), 0);
			if (tw != m->ww)
				tx += WIDTH(c);
		}
	}
}
