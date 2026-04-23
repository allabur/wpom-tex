\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wpom-upv}[2026/04/15 Working Papers on Operations Management - Universitat Politecnica de Valencia. Versioned from Editorial UPV. Author: Alberto Lacort]
\LoadClass[10pt,onecolumn]{article}

% ======================================================================
% 1. CLASS OPTIONS
% ======================================================================

\RequirePackage{ifthen}

\newboolean{distanciesEquacions}\setboolean{distanciesEquacions}{true}
\newboolean{anonymous}\setboolean{anonymous}{false}
\newboolean{preprint}\setboolean{preprint}{false}

\DeclareOption{nomathskip}{\setboolean{distanciesEquacions}{false}}
\DeclareOption{anonymous}{\setboolean{anonymous}{true}}
\DeclareOption{preprint}{\setboolean{preprint}{true}}
\DeclareOption*{\ClassWarning{wpom-upv}{Unknown option: \CurrentOption}}

\ExecuteOptions{}
\ProcessOptions\relax

% ======================================================================
% 2. CORE PACKAGES
% ======================================================================

\RequirePackage[english]{babel}
\RequirePackage[table]{xcolor}
\RequirePackage{tikz}
\RequirePackage{graphicx}
\RequirePackage{calc}
\RequirePackage{xspace}
\RequirePackage[section]{placeins}  % floats stay within their section

% --- Preprint watermark (every page) ------------------------------------
\ifthenelse{\boolean{preprint}}{%
  \RequirePackage{eso-pic}%
  \AddToShipoutPictureBG{%
    \AtPageCenter{%
      \makebox(0,0){%
        \rotatebox{55}{%
          \textcolor{black!8}{%
            \fontsize{80pt}{80pt}\selectfont\sffamily\bfseries PREPRINT%
          }%
        }%
      }%
    }%
  }%
}{}

% ======================================================================
% 3. FONT
% ======================================================================
% Change \WPOMfont to switch the journal typeface.
%   Computer Modern (LaTeX default):  \def\WPOMfont{cm}
%   Times New Roman:                  \def\WPOMfont{times}

\def\WPOMfont{times}   % <-- edit here to change the font

\ifthenelse{\equal{\WPOMfont}{times}}{%
	\RequirePackage{newtxtext}   % Times New Roman text
	\RequirePackage{newtxmath}   % matching math font
}{}  % otherwise: Computer Modern (LaTeX default)

\renewcommand{\normalsize}{\fontsize{10pt}{12pt}\selectfont}
\renewcommand{\familydefault}{\rmdefault}

% ======================================================================
% 4. ACCENT COLOUR
% ======================================================================
% Change here to restyle the journal in one line.

\colorlet{WPOMaccent}{blue!75!black}   % <-- WPOM blue (edit to change)

% ======================================================================
% 5. HYPERLINKS AND ORCID
% ======================================================================

\RequirePackage{xurl}        % allow URL line-breaks at any character
\RequirePackage{hyperref}
\hypersetup{
	colorlinks,
	linkcolor  = WPOMaccent,
	citecolor  = WPOMaccent,
	urlcolor   = WPOMaccent,
	bookmarksnumbered,
	breaklinks,
	}

\RequirePackage{orcidlink}

% ======================================================================
% 6. PAGE LAYOUT
% ======================================================================

\RequirePackage{geometry}

\geometry{
	a4paper, twoside,
	hmargin  = {3cm,3cm},
	top      = 2cm,       % header top edge: 2 cm from page top
	bottom   = 2cm,       % footer bottom edge: 2 cm from page bottom
	includehead, includefoot,
	headheight  = 42pt,   % fancyhdr requires at least ~42pt for two-line headers
	headsep     = 0.5cm,
	footskip    = 1.5cm,
	footnotesep = 1.0cm,
	}

% ======================================================================
% 7. PARAGRAPH AND SPACING SETTINGS
% ======================================================================

\setlength{\parskip}{2ex}
\setlength{\parindent}{0pt}

\linespread{1.0}

\setlength{\widowpenalty}{0pt}
\setlength{\clubpenalty}{0pt}

\raggedbottom

% ======================================================================
% 8. JOURNAL METADATA
% ======================================================================
% Default values – override in main.tex with \renewcommand.

\newcommand{\WPOMvolume}{17}
\newcommand{\WPOMnumber}{1}
\newcommand{\WPOMyear}{2026}
\newcommand{\WPOMpages}{1--20}  % e.g. {1--20}

% ======================================================================
% 9. RUNNING-HEAD AND FOOTER COMMANDS
% ======================================================================

% \authorsHeader{A. Smith, B. Jones} – authors shown in running head.
% Initialised to empty; auto-built from \author (see Section 12).
\newcommand{\authorsHeaderText}{}
\newcommand{\authorsHeader}[1]{\renewcommand{\authorsHeaderText}{#1}}
\let\autoresEncabezado\authorsHeader  % kept for backward compatibility

\newcommand{\journalHeader}[1]{\newcommand{\journalHeaderText}{#1}}
\newcommand{\journalLogo}[1]{\newcommand{\journalLogoHeader}{#1}}

\newcommand{\doi}[1]{%
	\ifdefined\doiHeader
		\renewcommand{\doiHeader}{#1}%
	\else
		\newcommand{\doiHeader}{#1}%
	\fi
	}
\doi{}

\newcommand{\received}[1]{\newcommand{\receivedHeader}{#1}}
\newcommand{\accepted}[1]{\newcommand{\acceptedHeader}{#1}}
\newcommand{\published}[1]{\newcommand{\publishedHeader}{#1}}

% ======================================================================
% 10. PAGE STYLE: HEADERS AND FOOTERS
% ======================================================================

\RequirePackage{fancyhdr}
\pagestyle{fancy}

\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}{}}

\fancyhf{}

% Both pages: paper title (line 1) + APA authors (line 2, suppressed in anonymous mode)
\fancyhead[C]{%
	\fontsize{9pt}{11pt}\selectfont\itshape\nouppercase\paperShortTitleInternal%
	\ifthenelse{\boolean{anonymous}}{}{%
		\\%
		\fontsize{9pt}{11pt}\selectfont\itshape\nouppercase\authorsHeaderText}%
	}

% All pages footer: CC logo (left) | journal info (center) | page number (right)
\fancyfoot[L]{%
	\raisebox{-2pt}{\href{https://creativecommons.org/licenses/by/4.0/}{\includegraphics[height=12pt]{logos/cc-by}}}%
	}
\fancyfoot[C]{%
	\footnotesize\color{black!60}%
	\ifthenelse{\boolean{preprint}}{%
		\textit{WPOM} -- Preprint%
	}{%
		\textit{WPOM},
		Vol.~\WPOMvolume%
	}%
	}
\fancyfoot[R]{\footnotesize\color{black!60}\thepage}

% First-page style: journal logo (left) + journal info (right), same footer
\fancypagestyle{plain}{%
	\fancyhf{}
	\fancyhead[R]{\journalHeaderText}
	\fancyhead[L]{%
		\ifdefined\journalLogoHeader
			\journalLogoHeader%
		\fi
		}
	\fancyfoot[L]{%
		\raisebox{-2pt}{\href{https://creativecommons.org/licenses/by/4.0/}{\includegraphics[height=12pt]{logos/cc-by}}}%
		}
	\ifthenelse{\boolean{preprint}}{%
		\fancyfoot[C]{\footnotesize\color{black!60}\textit{WPOM} -- Preprint}%
	}{}%
	\fancyfoot[R]{\footnotesize\color{black!60}\thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
	}

\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}

% ======================================================================
% 11. JOURNAL BRANDING (logo and header box – first page)
% ======================================================================

\journalLogo{%
	\tikz\node[overlay,below right, yshift=3.5mm]{
		\includegraphics[
			height=1.5cm
			]{logos/wpom-logo}%
		};%
	}

\journalHeader{%
	\tikz\node[overlay,below left, yshift=2mm]{%
		\parbox{.5\textwidth}{\raggedleft%
			% \scriptsize%
      \fontsize{10pt}{12pt}\selectfont%
			Working Papers on Operations Management\\
			\ifthenelse{\boolean{preprint}}{%
				\textbf{Preprint -- Not peer reviewed}\\
				ISSN: 1989-9068%
			}{%
				Vol.~\WPOMvolume\\
				ISSN: 1989-9068%
				\ifdefined\doiHeader\\ [8pt]
					\href{\doiHeader}{\doiHeader}%
				\fi%
			}\\[1ex]
			}
		};
	}

% ======================================================================
% 12. PAPER TITLE COMMANDS
% ======================================================================

\newcommand{\paperShortTitleInternal}{}

\newcommand{\paperShortTitle}[2]{%
	\renewcommand{\paperShortTitleInternal}{#1}%
	}

\newcommand{\paperTitle}[2]{%
	\ifthenelse{\equal{\paperShortTitleInternal}{}}
		{\renewcommand{\paperShortTitleInternal}{#1}}
		{}
	\title{\vspace*{2cm}#1#2}%
	}

% Optional Spanish title – shown below the main title, bold + italic
\newcommand{\paperTitleESInternal}{}
\newcommand{\paperTitleES}[1]{\renewcommand{\paperTitleESInternal}{#1}}

% ======================================================================
% 13. CORRESPONDING AUTHOR (line below affiliations)
% ======================================================================

\newcommand{\corrauthorEmail}{}
\newcommand{\@corrnote}{%
	\ifthenelse{\boolean{anonymous}}{}{%
		\ifx\corrauthorEmail\empty\else
			{\footnotesize\noindent
			 \textsuperscript{*}Corresponding author:
			 \href{mailto:\corrauthorEmail}{\corrauthorEmail}\par}%
		\fi
	}%
	}

% ======================================================================
% 14. AUTHOR AND AFFILIATION BLOCK (based on authblk.sty)
% ======================================================================

\newcommand\Authfont{\bfseries}
\newcommand\Affilfont{\normalfont\fontsize{9pt}{11pt}\selectfont}
\newcommand\Authsep{, }
\newcommand\Authands{, and }
\newcommand\Authand{ and }
\newlength{\affilsep}\setlength{\affilsep}{1em}
\newlength{\@affilsep}
\newcounter{Maxaffil}
\setcounter{Maxaffil}{2}

\newcounter{authors}
\newcounter{affil}
\newif\ifnewaffil \newaffiltrue
\newcommand\AB@authnote[1]{\textsuperscript{\normalfont#1}}
\newcommand\AB@affilnote[1]{\textsuperscript{\normalfont#1}}
\providecommand\textsuperscript[1]{$^{#1}$}
\newcommand\AB@blk@and{\protect\Authfont\protect\AB@setsep}
\newcommand\AB@pand{\protect\and \protect\Authfont \protect\AB@setsep}
\@namedef{@sep1}{}
\@namedef{@sep2}{\Authand}
\newcommand\AB@affilsep{\protect\Affilfont}
\newcommand\AB@affilsepx{;\space\protect\Affilfont}
\newcommand\AB@setsep{\setlength{\@affilsep}{\affilsep}}
\newcommand\AB@resetsep{\setlength{\@affilsep}{\z@}}
\newcommand\AB@authlist{}
\newcommand\AB@affillist{}
\newcommand\AB@authors{}
\newcommand\AB@empty{}
\xdef\AB@author{\noexpand\AB@blk@and\@author}
\renewcommand\author[2][]%
      {\ifnewaffil\addtocounter{affil}{1}%
       \edef\AB@thenote{\arabic{affil}}\fi
      \if\relax#1\relax\def\AB@note{\AB@thenote}\else\def\AB@note{#1}%
        \setcounter{Maxaffil}{0}\fi
      \ifnum\value{authors}>1\relax
      \@namedef{@sep\number\c@authors}{\Authsep}\fi
      \addtocounter{authors}{1}%
      \begingroup
          \let\protect\@unexpandable@protect \let\and\AB@pand
          \def\thanks{\protect\thanks}\def\footnote{\protect\footnote}%
         \@temptokena=\expandafter{\AB@authors}%
         {\def\\{\protect\\[\@affilsep]\protect\Affilfont
              \protect\AB@resetsep}%
              \xdef\AB@author{\AB@blk@and#2}%
       \ifnewaffil\gdef\AB@las{}\gdef\AB@lasx{\protect\Authand}\gdef\AB@as{}%
           \xdef\AB@authors{\the\@temptokena\AB@blk@and}%
       \else
          \xdef\AB@authors{\the\@temptokena\AB@as\AB@au@str}%
          \global\let\AB@las\AB@lasx\gdef\AB@lasx{\protect\Authands}%
          \gdef\AB@as{\Authsep}%
       \fi
       \gdef\AB@au@str{#2}}%
         \@temptokena=\expandafter{\AB@authlist}%
         \let\\=\authorcr
         \xdef\AB@authlist{\the\@temptokena
           \protect\@nameuse{@sep\number\c@authors}%
           \protect\Authfont#2\AB@authnote{\AB@note}}%
      \endgroup
      \ifnum\value{authors}>2\relax
      \@namedef{@sep\number\c@authors}{\Authands}\fi
      \newaffilfalse
}
\newcommand\authorcr{\protect\\ \protect\Authfont \protect\AB@setsep}%
\newcommand\affil[2][]%
   {\newaffiltrue\let\AB@blk@and\AB@pand
      \if\relax#1\relax\def\AB@note{\AB@thenote}\else\def\AB@note{#1}%
        \setcounter{Maxaffil}{0}\fi
      \begingroup
        \let\protect\@unexpandable@protect
        \def\thanks{\protect\thanks}\def\footnote{\protect\footnote}%
        \@temptokena=\expandafter{\AB@authors}%
        {\def\\{\protect\\\protect\Affilfont}\xdef\AB@temp{#2}}%
         \xdef\AB@authors{\the\@temptokena\AB@las\AB@au@str
         \protect\\[\affilsep]\protect\Affilfont\AB@temp}%
         \gdef\AB@las{}\gdef\AB@au@str{}%
        {\def\\{, \ignorespaces}\xdef\AB@temp{#2}}%
        \@temptokena=\expandafter{\AB@affillist}%
        \xdef\AB@affillist{\the\@temptokena \AB@affilsep
          \AB@affilnote{\AB@note}\protect\Affilfont\AB@temp}%
      \endgroup
       \let\AB@affilsep\AB@affilsepx
}
\def\@author{}
\renewcommand\@author{\ifx\AB@affillist\AB@empty\AB@author\else
      \ifnum\value{affil}>\value{Maxaffil}\def\rlap##1{##1}%
    \AB@authlist\\[1.5ex]\AB@affillist
    \else  \AB@authors\fi\fi}
\let\AB@maketitle=\maketitle
\def\maketitle
  {{\renewenvironment{tabular}[2][]{\begin{flushleft}}
                                   {\end{flushleft}}
  \AB@maketitle}}

% Author separators (English)
\renewcommand\Authsep{, }
\renewcommand\Authand{ and }
\renewcommand\Authands{ and }

% ======================================================================
% 15. \author WRAPPER: {Firstname}{Lastname}[orcid-id][email]
% ======================================================================
% - [affil]    : affiliation label (required bracket, use [] for none)
% - {Firstname}: first name
% - {Lastname} : last name
% - [orcid-id] : optional – shows ORCID icon next to the name
% - [email]    : optional – marks corresponding author; adds * and footnote
%
% Running head "F. Lastname, F. Lastname, ..." is built automatically.

\let\authblk@author\author   % save authblk's \author

% ------------------------------------------------------
% Initial extraction helpers
%
% \@wpom@setini{word} → \@wpom@ini = first character  (for running head)
% \@wpom@mkini{given names} → \@wpom@iniAPA = all initials, e.g. "J. S."
%   (for APA citation: supports "John", "John Steven", "Maria Jose", etc.)
%   Note: pass full given names, not pre-abbreviated initials.

\def\@wpom@setini#1#2\@nil{\xdef\@wpom@ini{#1}}
\def\@wpom@ini@char#1#2\@nil{\xdef\@wpom@inicur{#1}}

\newcommand{\@wpom@iniAPA}{}

\def\@wpom@mkini#1{%
  \renewcommand{\@wpom@iniAPA}{}%
  \@wpom@ini@words#1 \@wpom@stop%
}
% Process space-separated words; \@wpom@stop is the sentinel.
\def\@wpom@ini@words#1 #2\@wpom@stop{%
  \@wpom@ini@char#1\@nil%                     % extract first char → \@wpom@inicur
  \ifx\@wpom@iniAPA\@empty
    \xdef\@wpom@iniAPA{\@wpom@inicur.}%
  \else
    \xdef\@wpom@iniAPA{\@wpom@iniAPA~\@wpom@inicur.}%
  \fi
  \def\@wpom@rest{#2}%
  \ifx\@wpom@rest\@empty\else
    \@wpom@ini@words#2\@wpom@stop%            % recurse for remaining words
  \fi
}

% APA author list for "How to cite": "Surname, N. M., Surname, N., & Surname, N."
% Built incrementally: each new author shifts the previous "last" into "prev".
% At print time: \@wpom@apa@prev, & \@wpom@apa@last
\let\@wpom@apa@prev\@empty  % all authors except the last
\let\@wpom@apa@last\@empty  % the current last author

\def\author{\@ifnextchar[{\@wpom@author@a}{\@wpom@author@a[]}}

\def\@wpom@author@a[#1]#2#3{%
  % Extract initials from given names
  \def\@wpom@tmp{#2}%
  \expandafter\@wpom@setini\@wpom@tmp\@nil   % \@wpom@ini = first char (running head)
  \@wpom@mkini{#2}                            % \@wpom@iniAPA = all initials (APA)
  % Running head uses the same APA list as How to cite.
  % It is assembled in \@wpom@author@done once \@wpom@apa@* are updated.
  % Check for optional [orcid]
  \@ifnextchar[{\@wpom@author@orcid[#1]{#2}{#3}}{\@wpom@author@done[#1]{#2}{#3}{}{}}%
}

\def\@wpom@author@orcid[#1]#2#3[#4]{%
  % Check for optional [email]
  \@ifnextchar[{\@wpom@author@email[#1]{#2}{#3}{#4}}{\@wpom@author@done[#1]{#2}{#3}{}{#4}}%
}

\def\@wpom@author@email[#1]#2#3#4[#5]{%
  \@wpom@author@done[#1]{#2}{#3}{#5}{#4}%
}

% Final dispatcher: #4=email, #5=orcid
\def\@wpom@author@done[#1]#2#3#4#5{%
  \def\@wpom@email{#4}%
  \def\@wpom@orcid{#5}%
  \ifx\@wpom@email\@empty\else
    \renewcommand{\corrauthorEmail}{#4}%
  \fi
  % Build APA citation list: "Lastname, I. M."
  % Shift previous last → prev, new entry becomes last
  \ifx\@wpom@apa@last\@empty
    \xdef\@wpom@apa@last{#3, \@wpom@iniAPA}%
  \else
    \ifx\@wpom@apa@prev\@empty
      \xdef\@wpom@apa@prev{\@wpom@apa@last}%
    \else
      \xdef\@wpom@apa@prev{\@wpom@apa@prev, \@wpom@apa@last}%
    \fi
    \xdef\@wpom@apa@last{#3, \@wpom@iniAPA}%
  \fi
  % Rebuild running head from APA list: "Surname, N., Surname, N., & Surname, N."
  \ifx\@wpom@apa@prev\@empty
    \xdef\authorsHeaderText{\@wpom@apa@last}%
  \else
    \xdef\authorsHeaderText{\@wpom@apa@prev, \& \@wpom@apa@last}%
  \fi
  % ORCID icon first, then * for corresponding author
  \authblk@author[#1]{#2~#3%
    \ifx\@wpom@orcid\@empty\else\protect\,\protect\orcidlink{\@wpom@orcid}\fi
    \ifx\@wpom@email\@empty\else\protect\textsuperscript{*}\fi
  }%
}

% ======================================================================
% 16. TITLE BLOCK (\maketitle)
% ======================================================================

\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevent figures from appearing at the top of the first page
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

\def\@maketitle{%
  \newpage
  \null
  \vskip -1em%
  \let \footnote \thanks
    % Main title – centred
    {\centering\bfseries\Large \@title \par}%
    % Optional Spanish title – centred, bold + italic
    \ifthenelse{\equal{\paperTitleESInternal}{}}{%
      \vskip 0.5em%
    }{%
      \vskip 0.3em%
      {\centering\bfseries\itshape\large \paperTitleESInternal \par}%
      \vskip 0.5em%
    }%
    % Author names and affiliations – suppressed in anonymous mode
    \ifthenelse{\boolean{anonymous}}{}{%
      \begin{minipage}{\textwidth}%
        \centering\normalsize\bfseries\lineskip .25em%
        \AB@authlist\par
      \end{minipage}%
      \vskip 0.5em%
      \begin{minipage}{\textwidth}%
        \normalsize\def\rlap##1{##1}%
        \AB@affillist\par
        \vskip 0.25em
        \@corrnote\par
      \end{minipage}%
    }%
  \par
  \vskip 0em

  % Received / Accepted / Published dates – suppressed in anonymous and preprint modes
  \ifthenelse{\boolean{anonymous}\OR\boolean{preprint}}{}{%
    \raggedright
    {\footnotesize\itshape
    \ifdefined\receivedHeader Received: \receivedHeader\fi
    \ifdefined\acceptedHeader \quad Accepted: \acceptedHeader\fi
    \ifdefined\publishedHeader \quad Published: \publishedHeader\fi
    }%
  }%

  \par
  \vskip 0em

  % "How to cite" box – suppressed in anonymous mode; preprint notice shown in preprint mode
  \ifthenelse{\boolean{anonymous}}{}{%
    \ifthenelse{\boolean{preprint}}{%
      \centering
      \fboxsep=6pt\fboxrule=0pt
      \fcolorbox{black!10}{black!10}{%
        \parbox{\dimexpr\textwidth-12pt\relax}{%
          \textbf{Preprint notice}:
          This is a preprint and has not been peer reviewed.
          The final published version may differ.
          Please cite the published version when available.
        }}%
    }{%
      \centering
      \fboxsep=6pt\fboxrule=0pt
      \newlength{\ampleHowToCite}\setlength{\ampleHowToCite}{\textwidth-12pt}
      \fcolorbox{black!10}{black!10}{%
        \parbox{\ampleHowToCite}{%
          \textbf{How to cite}:
          \@wpom@apa@prev\ifx\@wpom@apa@prev\@empty\else, \& \fi\@wpom@apa@last\
          (\WPOMyear).
          \paperShortTitleInternal.
          \textit{WPOM-Working Papers on Operations Management},
          \textit{\WPOMvolume}(\WPOMnumber)%
          \ifthenelse{\equal{\WPOMpages}{}}{}{, \WPOMpages}.
          \ifdefined\doiHeader \href{\doiHeader}{\doiHeader}\fi
        }}%
    }%
  }

  \par
  \vskip +1.5em

  }

% ======================================================================
% 17. HIGHLIGHTS ENVIRONMENT
% ======================================================================
% Optional – 3 to 5 bullet points before the abstract.
% Leave out the environment entirely if not used.

\RequirePackage{mdframed}

\newenvironment{highlights}
{%
	\vspace{-2ex}
	% Same horizontal margins as the abstract's \begin{quote}:
	% \list{}{\rightmargin\leftmargin} with \leftmargin=\leftmargini
	\list{}{\leftmargin\leftmargini\rightmargin\leftmargini
		\topsep\z@\parsep\z@\partopsep\z@}%
	\item\relax
	\begin{mdframed}[
		topline    = false,
		rightline  = false,
		bottomline = false,
		linecolor  = WPOMaccent,
		linewidth  = 3pt,
		leftmargin = 0pt,
		innerleftmargin  = 10pt,
		innerrightmargin = 4pt,
		innertopmargin   = 4pt,
		innerbottommargin = 4pt,
		backgroundcolor = black!3,
		skipabove = 0pt,
		skipbelow = 0pt,
		]
	{\footnotesize\bfseries\color{WPOMaccent} Highlights}\par\vspace{2pt}
	\begin{itemize}[leftmargin=1.2em,itemsep=1pt,parsep=0pt,topsep=2pt]
	\footnotesize
}
{%
	\end{itemize}
	\end{mdframed}
	\endlist
	\vspace{0.5ex}
}

% ======================================================================
% 18. ABSTRACT AND RESUMEN ENVIRONMENTS
% ======================================================================

\renewenvironment{abstract}
{%
  \if@twocolumn\else\vspace{-5ex}\begin{quote}\fi
  \rule{\linewidth}{0.2pt}\\[0ex]%
  \itshape\textbf{Abstract}%
  \par
}
{%
  \par\vspace{-0.5ex}\rule{\linewidth}{0.2pt}%
  \if@twocolumn\else\end{quote}\fi
}

% \keywords is used inside both abstract and resumen
\newcommand{\keywords}{\textbf{Keywords}}

% Optional Spanish abstract (for papers written in Spanish).
% The abstract's closing rule serves as the divider between the two blocks;
% resumen only adds a closing rule at its own end.
\newenvironment{resumen}
{%
  \if@twocolumn\vspace{0ex}\else\vspace{-5ex}\begin{quote}\fi
  \itshape\textbf{Resumen}%
  \par
}
{%
  \par\vspace{-0.5ex}\rule{\linewidth}{0.2pt}%
  \if@twocolumn\vspace{1ex}\else\end{quote}\fi
}

% ======================================================================
% 19. SECTION HEADINGS
% ======================================================================

\RequirePackage[
	raggedright,
	compact,
	clearempty,      % Make even blank pages truly empty
	]{titlesec}

\titleformat{\section}
	[hang]
	{\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
	{\fontsize{13}{15}\bfseries\thesection}
	{.75em}
	{\fontsize{13}{15}\bfseries}

\titleformat{\subsection}
	[hang]
	{\vspace{1.5ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
	{\fontsize{10}{12}\bfseries\thesubsection}
	{.5em}
	{\fontsize{10}{12}\bfseries}
	[\vspace{-1ex}]

\titleformat{\subsubsection}
	[hang]
	{\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
	{\normalsize\itshape\thesubsubsection}
	{.5em}
	{\normalsize\itshape}
	[\vspace{-0.75ex}]

% ======================================================================
% 20. APPENDIX
% ======================================================================
% Sections formatted as "Appendix A", numbered A.1, A.2, ...

\let\originalappendix\appendix
\renewcommand{\appendix}{%
	\originalappendix
	\titleformat{\section}
		[hang]
		{\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
		{\fontsize{13}{15}\bfseries Appendix~\thesection}
		{.75em}
		{\fontsize{13}{15}\bfseries}
	}

% ======================================================================
% 21. AUTHOR-FACING PARAGRAPH HEADINGS (blind-review blocks)
% ======================================================================
% \authorblock{Title} – paragraph-level heading (bold, 10pt, no number)
%   used for Acknowledgments, Conflict of interests, Author Contributions.
%   Adds a footnote reminding authors to remove the block for blind review.

\newcommand{\authorblock}[1]{%
  \ifthenelse{\boolean{anonymous}}{}{%
    \vspace{2ex}%
    \noindent{\bfseries #1}%
    \par\vspace{0.25ex}%
  }%
}

% ======================================================================
% 22. TABLE NOTES
% ======================================================================
% \tablenote{text} – place immediately after \end{tabularx} (or similar),
% inside the table float. Renders as justified footnotesize text, left-aligned,
% spanning the full column width.

\newcommand{\tablenote}[1]{%
  \par\vspace{2pt}%
  \noindent\parbox{\columnwidth}{\footnotesize\raggedright #1}%
}

% ======================================================================
% 23. LIST SPACING
% ======================================================================

\RequirePackage{enumitem}
\setlist[1]{partopsep=-1ex,parsep=\parskip,itemsep=0\parskip}
\setlist[2]{partopsep=-1ex,parsep=\parskip,itemsep=0\parskip}

% ======================================================================
% 22. CAPTION FORMATTING
% ======================================================================

\RequirePackage{caption}
\RequirePackage{threeparttable}  % table notes at the natural width of the table

\DeclareCaptionFont{wpomcap}{\fontsize{8.5pt}{10pt}\selectfont\bfseries}
\captionsetup{font=wpomcap,labelfont=wpomcap,textfont=wpomcap,labelsep=period}

% Style for threeparttable notes: same footnotesize as \tablenote
\appto\TPTnoteSettings{\footnotesize\raggedright}

% ======================================================================
% 23. MATH SPACING AND EQUATION NUMBERING
% ======================================================================

\RequirePackage{mathtools}

% Equation numbers include the section counter:
%   body text  → (1), (2), (3), …
%   Appendix A → (A.1), (A.2), …
%   Appendix B → (B.1), (B.2), …
% In the body: plain sequential numbering — (1), (2), Figure 1, Table 1…
% In appendices: section-prefixed — (A.1), Figure A.1, Table A.1…
% Achieved by hooking into \appendix rather than using \numberwithin globally.
\g@addto@macro\appendix{%
  \numberwithin{equation}{section}%
  \numberwithin{figure}{section}%
  \numberwithin{table}{section}%
}

\ifdistanciesEquacions

	\AtBeginDocument
	% Vertical spacing around displayed equations

	% For short displayed equations
	\abovedisplayshortskip = -1.0ex plus 0ex minus 0.25ex
	\belowdisplayshortskip = 2.0ex plus 1ex minus 0.0ex

	% For multi-line displayed equations
	\abovedisplayskip = -1.0ex plus 0ex minus 0.25ex
	\belowdisplayskip = 2.0ex plus 1ex minus 0.0ex

\else

	\AtBeginDocument

\fi

% ======================================================================
% 25. BIBLIOGRAPHY (APA 7th ed. style via biblatex + biber)
% ======================================================================
% Applied at \begin{document} so biblatex is already loaded.

\AtBeginDocument{%
  %--- Spacing and indentation ------------------------------------------
  % APA 7th: double-spaced entries with hanging indent.
  % In journal layout we use a compact equivalent: small gap + 1.5em hang.
  \setlength{\bibitemsep}{4pt plus 1pt}%
  \setlength{\bibhang}{1.5em}%
  %--- Body font for the list -------------------------------------------
  % Same size as body text; no special treatment.
  \renewcommand{\bibfont}{\normalfont\normalsize}%
  %--- DOI/URL display --------------------------------------------------
  % APA 7th: show DOI as https://doi.org/… hyperlink; suppress plain URLs
  % for items that have a DOI (handled by biblatex-apa; url=false in
  % \usepackage options suppresses bare URLs globally).
  %--- "References" heading: unnumbered section, no appendix prefix -----
  \defbibheading{bibintoc}[\refname]{%
    \section*{#1}%
    \addcontentsline{toc}{section}{#1}%
  }%
  \defbibheading{bibliography}[\refname]{%
    \section*{#1}%
  }%
}

% APA 7th formatting tweaks applied after biblatex-apa is loaded.
% (These must be outside \AtBeginDocument so they patch the right macros.)

% Volume in bold for journal articles (APA 7th: italic volume number).
% biblatex-apa already italicises the volume; no override needed.

% Suppress "In:" prefix before booktitle in @incollection entries
% (APA uses "In E. Editor (Ed.), Book title")  — biblatex-apa handles this.

% Ensure "&" (not "and") between last two authors in the reference list.
% biblatex-apa sets \finalnamedelim to "\&" by default; make it explicit.
\AtBeginDocument{%
  \DefineBibliographyExtras{english}{%
    \def\finalnamedelim{\addspace\&\addspace}%
  }%
}
