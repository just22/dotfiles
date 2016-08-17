nmap <buffer> <leader>i ggi
        \% ----------------------------------------------------------------------<CR>
        \% Document title and short description<CR>
        \% ----------------------------------------------------------------------<CR>
        \<CR>
        \<CR>
        \% ----------------------------------------------------------------------<CR>
        \% Preamble<CR>
        \%<CR>
        \\documentclass[a4paper,11pt,utf8]{beamer}<CR>
        \\usetheme{Madrid}<CR>
        \\setbeamercovered{transparent}<CR>
        \<CR>
        \\usepackage[USenglish]{babel}<CR>
        \\usepackage[T1]{fontenc}<CR>
        \\usepackage[utf8]{inputenc}<CR>
        \\usepackage{datetime}<CR>
        \\usepackage{graphicx}<CR>
        \<CR>
        \\newdateformat{monthyeardate}{%<CR>
        \        \monthname[\THEMONTH] \THEYEAR}<CR>
        \<CR><Esc>i
        \\title[Short title]{Long title}<CR>
        \<CR>
        \\subtitle[]{A  very breaf description of the presentation's contents}<CR>
        \<CR>
        \\author[A. De Laurenzis]{Alessandro DE LAURENZIS \\%<CR>
        \                         \texttt{alessandro.de-laurenzis@st.com}}<CR><Esc>i
        \\institute[STMicroelectronics]{STMicroelectronics \\%<CR>
        \                               AMS - Analog, MEMS and Sensors Division \\%<CR><Esc>i
        \                               Product Development - Digital design team}<CR><Esc>i
        \\date{\monthyeardate\today}<CR>
        \<CR>
        \<CR>
        \% ----------------------------------------------------------------------<CR>
        \% Document body<CR>
        \%<CR>
        \\begin{document}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \titlepage<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Outline}<CR><Esc>i
        \        \tableofcontents[pausesections]<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\AtBeginSubsection{<CR><Esc>i
        \        \begin{frame}<CR><Esc>i
        \                \frametitle{Next Topic}<CR><Esc>i
        \                \tableofcontents[currentsubsection]<CR><Esc>i
        \        \end{frame}<CR><Esc>i
        \}<CR>
        \<CR>
        \% ----------------------------------------------------------------------<CR>
        \\section{Section 1}<CR>
        \<CR>
        \% ----------------------------------<CR>
        \\subsection{Subsection 1.1}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame 1.1.1}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame 1.1.2}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \% ----------------------------------<CR>
        \\subsection{Subsection 1.2}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame 1.2.1}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame 1.2.2}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \% ----------------------------------------------------------------------<CR>
        \\section{Section 2}<CR>
        \<CR>
        \% ----------------------------------<CR>
        \\subsection{Subsection 2.1}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame 2.1.1}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame 2.1.2}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \% ----------------------------------<CR>
        \\subsection{Subsection 2.2}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame 2.2.1}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame 2.2.2}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\end{document}<CR>
        \% ----------------------------------------------------------------------<Esc>gg
nmap <buffer> <leader>S o
        \% ----------------------------------------------------------------------<CR>
        \\section{Section X}<CR>
        \<CR>
        \% ----------------------------------<CR>
        \\subsection{Subsection X.1}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame X.1.1}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame X.1.2}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \% ----------------------------------<CR>
        \\subsection{Subsection X.2}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame X.2.1}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame X.2.2}<CR><Esc>i
        \\end{frame}<CR><Esc>

nmap <buffer> <leader>s o
        \% ----------------------------------<CR>
        \\subsection{Subsection X.Y}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame X.Y.1}<CR><Esc>i
        \\end{frame}<CR>
        \<CR>
        \\begin{frame}<CR>
        \        \frametitle{Frame X.Y.2}<CR><Esc>i
        \\end{frame}<CR><Esc>

nmap <buffer> <leader>f o
        \\begin{frame}<CR>
        \        \frametitle{Frame X.Y.Z}<CR><Esc>i
        \\end{frame}<CR><Esc>

nmap <buffer> <leader>ff o
        \\begin{frame}[fragile]<CR>
        \        \frametitle{Frame X.Y.Z}<CR><Esc>i
        \        \begin{verbatim}
        \        \end{verbatim}
        \\end{frame}<CR><Esc>

imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv
imap <buffer> (( \eqref{
