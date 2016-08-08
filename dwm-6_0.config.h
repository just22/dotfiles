// ---------------------------------------------------------------------
//  $Id$
//
//  dwm configuration file
//  See LICENSE file for copyright and license details
// ---------------------------------------------------------------------

// XF86 Key symbols
#include <X11/XF86keysym.h>

// Appearance
static const char font[] = "-*-stlarch-medium-r-*-*-10-*-*-*-*-*-*-*" "," "-xos4-terminus-medium-*-*-*-12-*-*-*-*-*-iso10646-1";
//static const char font[] = "DejaVu Sans Mono:style=Book:pixelsize=10";
//static const char font[] = "-xos4-terminus-medium-*-*-*-12-*-*-*-*-*-iso10646-1";

// Base16 chalk color scheme
static const char normbordercolor[] = "#3d3d3d"; // brightblack
static const char normbgcolor[]     = "#9c9c9c"; // white
static const char normfgcolor[]     = "#121212"; // black
static const char selbordercolor[]  = "#cf4f88"; // brightred
static const char selbgcolor[]      = "#e0e0e0"; // brightwhite
static const char selfgcolor[]      = "#121212"; // black

// Solarized color scheme
//static const char normbordercolor[] = "#587e75"; // base01
//static const char normbgcolor[]     = "#002b36"; // base03
//static const char normfgcolor[]     = "#839496"; // base0
//static const char selbordercolor[]  = "#dc322f"; // red
//static const char selbgcolor[]      = "#073642"; // base02
//static const char selfgcolor[]      = "#dc322f"; // red
////static const char selfgcolor[]      = "#6c71c4"; // violet

static const unsigned int borderpx       = 1;     // border pixel of windows
static const unsigned int snap           = 32;    // snap pixel
static const unsigned int systrayspacing = 0;     // systray spacing
static const Bool         showsystray    = True;  // False means no systray
static const Bool         showbar        = True;  // False means no bar
static const Bool         topbar         = False; // False means bottom bar

// Tagging
static const char *tags[] = { "1-Txt", "2-GUI", "3-Aux", "4-M/N", "5-Web", "6-Adm" };

static const Rule rules[] = {
   // class             instance            title                   tags mask   isfloating  monitor
   { "Gimp",            NULL,               NULL,                   0,          True,       -1 },
   { "XTerm",           "xterm",            "mutt",                 1 << 3,     False,      -1 },
   { "XTerm",           "xterm",            "newsbeuter",           1 << 3,     False,      -1 },
   { "Firefox",         "Navigator",        NULL,                   1 << 4,     False,      -1 },
   { "Firefox",         "Browser",          NULL,                   1 << 4,     True,       -1 },
   { "Firefox",         "Places",           NULL,                   1 << 4,     True,       -1 },
   { "XConsole",        NULL,               NULL,                   1 << 5,     False,      -1 },
   { "Arandr",          NULL,               NULL,                   0,          True,       -1 },
   { "Xmessage",        NULL,               NULL,                   0,          True,       -1 },
};

// Layout(s)
static const float mfact       = 0.65;  // factor of master area size [0.05..0.95]
static const int   nmaster     = 1;     // number of clients in master area
static const Bool  resizehints = False; // True means respect size hints in tiled resizals

static const Layout layouts[] = {
//   symbol      arrange function
   { "[]=",      tile },        // First entry is the default
   { "><>",      NULL },        // No layout function means floating behavior
   { "[M]",      monocle },
   { "TTT",      bstack },
   { "===",      bstackhoriz },
};

// Key definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
   { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
   { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
   { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
   { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

// Helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// Commands
static const char *dmenucmd[]       = { "/usr/local/bin/dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]        = { "/usr/X11R6/bin/xterm", NULL };
static const char *tmuxcmd[]        = { "/usr/X11R6/bin/xterm", "-e", "/usr/bin/tmux attach-session -d || /usr/bin/tmux new-session", NULL };
static const char *emacscmd[]       = { "/usr/bin/mg", NULL };
static const char *killdwmsesscmd[] = { "/home/just22/bin/kill-dwm-session", NULL };
static const char *lowervolcmd[]    = { "/home/just22/bin/volume-handler", "down", "12", NULL };
static const char *mutecmd[]        = { "/home/just22/bin/volume-handler", "toggle_mute", "NULL", NULL };
static const char *raisevolcmd[]    = { "/home/just22/bin/volume-handler", "up", "12", NULL };
static const char *setdisplaycmd[]  = { "/usr/local/bin/arandr", NULL };
static const char *suspendcmd[]     = { "/usr/sbin/apm", "-z", NULL };
//static const char *hibernatecmd[]   = { "/usr/sbin/apm", "-Z", NULL };
static const char *browsercmd[]     = { "/usr/local/bin/firefox", NULL };
static const char *mailclientcmd[]  = { "/usr/X11R6/bin/xterm", "-title", "mutt", "-e", "/usr/local/bin/mutt", NULL };
//static const char *newsreadercmd[]  = { "/usr/X11R6/bin/xterm", "-title", "newsbeuter", "-e", "newsbeuter-dwm", NULL };
static const char *lockcmd[]        = { "/usr/X11R6/bin/xlock", NULL };
static const char *filemanagercmd[] = { "/usr/X11R6/bin/xterm", "-e", "mc", NULL };
//static const char *torrentcmd[]     = { "/usr/X11R6/bin/xterm", "-title", "rTorrent", "-e", "/usr/local/bin/rtorrent", NULL };
static const char *torrentcmd[]     = { "/usr/local/bin/transmission-gtk", NULL };
static const char *videoplayercmd[] = { "/usr/local/bin/gnome-mplayer", NULL };
//static const char *xkbmapcmd[]      = { "/home/just22/bin/swxkbmap", NULL };
//static const char *wifimgrcmd[]     = { "sudo", "wpa_gui", NULL };

static Key keys[] = {
   // modifier                      key                         function        argument
   { MODKEY,                        XK_F2,                      spawn,          {.v = dmenucmd } },
   { MODKEY|ShiftMask,              XK_Return,                  spawn,          {.v = termcmd } },
   { MODKEY|ShiftMask,              XK_t,                       spawn,          {.v = tmuxcmd } },
   { MODKEY|ShiftMask,              XK_e,                       spawn,          {.v = emacscmd } },
   { MODKEY,                        XK_b,                       togglebar,      {0} },
   { MODKEY,                        XK_k,                       focusstack,     {.i = +1 } },
   { MODKEY,                        XK_j,                       focusstack,     {.i = -1 } },
   { MODKEY,                        XK_i,                       incnmaster,     {.i = +1 } },
   { MODKEY,                        XK_d,                       incnmaster,     {.i = -1 } },
   { MODKEY,                        XK_Left,                    setmfact,       {.f = -0.05} },
   { MODKEY,                        XK_Up,                      setmfact,       {.f = -0.05} },
   { MODKEY,                        XK_Right,                   setmfact,       {.f = +0.05} },
   { MODKEY,                        XK_Down,                    setmfact,       {.f = +0.05} },
   { MODKEY,                        XK_Return,                  zoom,           {0} },
   { MODKEY,                        XK_Tab,                     view,           {0} },
   { MODKEY,                        XK_x,                       killclient,     {0} },
   { MODKEY,                        XK_t,                       setlayout,      {.v = &layouts[0]} },
   { MODKEY,                        XK_f,                       setlayout,      {.v = &layouts[1]} },
   { MODKEY,                        XK_m,                       setlayout,      {.v = &layouts[2]} },
   { MODKEY,                        XK_h,                       setlayout,      {.v = &layouts[3]} },
   { MODKEY,                        XK_o,                       setlayout,      {.v = &layouts[4]} },
   { MODKEY,                        XK_space,                   togglefloating, {0} },
   { MODKEY,                        XK_comma,                   focusmon,       {.i = -1 } },
   { MODKEY,                        XK_period,                  focusmon,       {.i = +1 } },
   { MODKEY,                        XK_agrave,                  view,           {.ui = ~0 } },
   { MODKEY|ShiftMask,              XK_agrave,                  tag,            {.ui = ~0 } },
   { MODKEY|ShiftMask,              XK_comma,                   tagmon,         {.i = -1 } },
   { MODKEY|ShiftMask,              XK_period,                  tagmon,         {.i = +1 } },
   TAGKEYS(                         XK_1,                                       0)
   TAGKEYS(                         XK_2,                                       1)
   TAGKEYS(                         XK_3,                                       2)
   TAGKEYS(                         XK_4,                                       3)
   TAGKEYS(                         XK_5,                                       4)
   TAGKEYS(                         XK_6,                                       5)
   { MODKEY,                        XK_q,                       quit,           {0} },
   { MODKEY|ShiftMask,              XK_q,                       spawn,          {.v = killdwmsesscmd} },
   { 0,                             XF86XK_AudioLowerVolume,    spawn,          {.v = lowervolcmd} },
   { 0,                             XF86XK_AudioMute,           spawn,          {.v = mutecmd} },
   { 0,                             XF86XK_AudioRaiseVolume,    spawn,          {.v = raisevolcmd} },
   { 0,                             XF86XK_Display,             spawn,          {.v = setdisplaycmd} },
   { MODKEY|ShiftMask,              XK_d,                       spawn,          {.v = setdisplaycmd} },
   { MODKEY|ShiftMask,              XK_s,                       spawn,          {.v = suspendcmd} },
//   { MODKEY|ShiftMask,              XK_h,                       spawn,          {.v = hibernatecmd} },
   { MODKEY|ShiftMask,              XK_Delete,                  spawn,          {.v = lockcmd} },
   { MODKEY|ShiftMask,              XK_b,                       spawn,          {.v = browsercmd} },
   { MODKEY|ShiftMask,              XK_m,                       spawn,          {.v = mailclientcmd} },
//   { MODKEY|ShiftMask,              XK_n,                       spawn,          {.v = newsreadercmd} },
   { MODKEY|ShiftMask,              XK_f,                       spawn,          {.v = filemanagercmd} },
   { MODKEY|ShiftMask,              XK_p,                       spawn,          {.v = torrentcmd} },
   { MODKEY|ShiftMask,              XK_v,                       spawn,          {.v = videoplayercmd} },
//   { MODKEY|ShiftMask,              XK_k,                       spawn,          {.v = xkbmapcmd} },
//   { MODKEY|ShiftMask,              XK_w,                       spawn,          {.v = wifimgrcmd} },
};

// Mouse button definitions
// Click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin
static Button buttons[] = {
   // click                event mask      button          function        argument
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

