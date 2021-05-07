%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IDENTIFICATION
%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{templates/bathreport}[Bath Report]

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CLASS DETAILS
%%%%%%%%%%%%%%%%%%%%%%%%%%

% defaults to one-side, but passing 'twoside' in page-layout will change things accordingly
\LoadClass[openright,11pt]{report}

\newif\ifmc@nobind
\mc@nobindfalse
\DeclareOption{nobind}{\mc@nobindtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MARGINS
%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifmc@nobind
\usepackage[includeheadfoot,hmargin={2.5cm, 2.5cm}, vmargin={2cm,2cm}, headsep=.8cm, footskip=1.2cm]{geometry} % no bind
\else
\usepackage[includehead, hmargin={3.6cm, 2.6cm}, vmargin={2.5cm,2.7cm}, headsep=.8cm, footskip=1.2cm]{geometry} % bind
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARAGRAPH SPACING
%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\parskip}{0pt plus 1pt} % spacing between paragraphs
\setlength{\parfillskip}{0pt plus .7\textwidth} % min horizontal spacing at end of paragraph (avoid flush-right paragraph endings)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LINE SPACING
%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\singlebaselineskip}
\setlength{\singlebaselineskip}{\baselineskip}
% for separate abstract page
\newlength{\abstractseparatelineskip}  
\setlength{\abstractseparatelineskip}{10pt plus1pt minus1pt}
\newlength{\abstractseparateparskip} 
\setlength{\abstractseparateparskip}{0pt plus 1pt}
% front matter - abstract, acknowledgments, ToC
\newlength{\frontmatterbaselineskip}
\setlength{\frontmatterbaselineskip}{17pt plus1pt minus1pt}
% main body text
\newlength{\textbaselineskip}
\setlength{\textbaselineskip}{22pt plus2pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%
% DECLARE DOCUMENT VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\date#1{\gdef\@date{#1}}
\def\course#1{\gdef\@course{#1}}
\def\department#1{\gdef\@department{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}}
\newcommand{\university}{University of Bath}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%

% general maths and typesetting
\usepackage{amsmath} % maths stuff
\usepackage{amssymb} % maths symbols
\usepackage{amsthm} % define theorem-like structures
\usepackage{textcomp} % text companion fonts
\usepackage{microtype} % micro-typographic extensions 
\usepackage{nicefrac, xfrac} % in-line fractions
% JEM: for crazy multi character set quotes and Unicode and all
\usepackage{lmodern} % latin modern fonts
\usepackage[LGR,TS1,T1]{fontenc} % font encoding
\usepackage[utf8]{inputenc} % input encoding
\usepackage[UKenglish]{babel} % write in British English
\usepackage{csquotes} % inline and display quotations
\hyphenpenalty=500 % penalise hyphens (note: can't use hyphenat package as it doesn't work with babel)
\def\longs{{\fontencoding{TS1}\selectfont s}} % long s symbol

% tables
\usepackage[font=small,labelfont=bf]{caption} % nicer captions
\usepackage{multicol,multirow,array} % make rows/cols span several rows/cols
\usepackage{rotating} % landscape tables
\usepackage{dcolumn} % allow table cols aligned by decimal point
\newcolumntype{d}[3]{D{.}{\cdot}{#1} }
% packages used by kableExtra
\usepackage{booktabs}
\usepackage{longtable}
\usepackage{array}
\usepackage{multirow}
\usepackage{wrapfig}
\usepackage{colortbl}
\usepackage{pdflscape}
\usepackage{tabu}
\usepackage{threeparttable}
\usepackage{threeparttablex}
\usepackage[normalem]{ulem}
\usepackage{makecell}
\usepackage{float}

% graphics
\usepackage{pdfpages} % insert multi-page PDFs as graphics
\usepackage{color, xcolor} % further colours beyond color package
\usepackage{graphicx} % adds functionality to graphics package

% lists
\usepackage{enumitem} % can change list spacing

% correction highlighting
\usepackage{soul}

%links
\usepackage{hyperref}
\hypersetup{
    hidelinks=$hidelinks$,
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,      
    urlcolor=cyan,
    citecolor=green,
    pdfpagelabels,
    bookmarks=true,
    pdfpagemode=FullScreen}

% appendices
\usepackage{appendix} % to format appendicies

% bibliography
\usepackage{notoccite} % prevent issues with citations in section headers messing things up

% ToC
\usepackage[nottoc]{tocbibind} % insert the bibliography, LoF, etc into the ToC

% mini ToC
\usepackage[nohints,tight]{minitoc} % Generates mini tables of contents per chapter
	\setcounter{minitocdepth}{2} 
% make minitoc not be multiple-spaced.
\let\oldmtc@verse\mtc@verse
\renewcommand{\mtc@verse}[1]{\oldmtc@verse{#1}\setlength{\baselineskip}{\z@}}

% quotes at beginning of chapters
\usepackage[grey,utopia]{quotchap} 

% headers and footers
\usepackage{fancyhdr}
\setlength{\headheight}{15pt}
\fancyhf{} % clear the header and footers
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter. #1}{\thechapter. #1}}
\renewcommand{\sectionmark}[1]{\markright{\thesection. #1}} 
\renewcommand{\headrulewidth}{1pt} % set weight of horizontal rule below header

% date and time
\usepackage[useregional]{datetime2}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENVIRONMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%


% theorem environments
%\theoremstyle{plain}
%\newtheorem{theorem}{Theorem}
%\newtheorem{corollary}[theorem]{Corollary}
%\newtheorem{lemma}[theorem]{Lemma}
%\newtheorem{proposition}[theorem]{Proposition}

%\theoremstyle{definition}
%\newtheorem{definition}[theorem]{Definition}
%\newtheorem{example}[theorem]{Example}
%\newtheorem*{remark}{Remark}

% ensure front matter is always single col even in a double column doc
\newenvironment{alwayssingle}{%
       \@restonecolfalse
       \if@twocolumn\@restonecoltrue\onecolumn
       \else\if@openright\cleardoublepage\else\clearpage\fi
       \fi}%
       {\if@restonecol\twocolumn
       \else\newpage\thispagestyle{empty}\fi}

% title page
\renewcommand{\maketitle}{%
\begin{alwayssingle}\null
    \renewcommand{\footnotesize}{\small}
    \renewcommand{\footnoterule}{\relax}
    \thispagestyle{empty}

  \begin{center}
    {\Huge {\bfseries {\@title}} \par}\vspace*{10mm}
    {\crest\par}\vspace*{25mm}
    {{\huge \@author} \par}\vspace*{10mm}
    {{\large \@date}\par}\vspace*{2mm}
    {{\large Supervised by \@supervisor} \par}\vspace*{2mm}
    {{\large\@department} \par}\vspace*{2mm}
    {{\large\university} \par}\vspace*{2mm}

  \end{center}
  \vfill
  \par\null
\end{alwayssingle}}

% dedication
\newenvironment{dedication}
{\begin{alwayssingle}
  \thispagestyle{empty}
  \vspace*{\fill} \begin{center}}
{\end{center}\vspace*{\fill}\vspace*{\fill} \end{alwayssingle}}

% acknowledgements
\newenvironment{acknowledgements}%
{   \begin{alwayssingle}\chapter*{Acknowledgements}
    \thispagestyle{empty}
	\pagestyle{empty}
	\setlength{\baselineskip}{\frontmatterbaselineskip}
}
{\end{alwayssingle}}

% abstract
\renewenvironment{abstract}%
{   \begin{alwayssingle}\chapter*{Abstract}
    \thispagestyle{empty}
    \pagestyle{empty}
   \setlength{\baselineskip}{\frontmatterbaselineskip}}
{\end{alwayssingle}}

% separate abstract
\newenvironment{abstractseparate} {\newgeometry{margin=3.3cm}\thispagestyle{empty}\begin{alwayssingle}
 \begin{center}
    {\Large \bfseries \@title \par}
    {{\large \vspace*{2ex} \@author} \par}
    \vspace*{1ex}
    {{\@department} \par}
    {\university \par}
    {\@date \par} 
\vfill
  {\Large \bfseries  Abstract}
  \end{center}
\vspace{1ex}
   \setlength{\baselineskip}{\abstractseparatelineskip} 
   \setlength{\parskip}{\abstractseparateparskip}} 
{\vfill\end{alwayssingle}\restoregeometry}

% roman pages - lowercase roman for front matter, arabic (starting at 1) for body
\newenvironment{romanpages}
{\cleardoublepage\setlength{\baselineskip}{\frontmatterbaselineskip}\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
{\cleardoublepage\setcounter{page}{1}\renewcommand{\thepage}{\arabic{page}}}

% figure placement on page - prevent too many figures on their own pages (% http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/LatexTips.html#captfont)
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}
% allow flexible spacing after figures, to reduce other stretching
\setlength{\textfloatsep}{20pt plus15pt minus4pt}

% verse, quote, quotation (rename the internal commands for the \begin{...} and \end{...} environment commands)
\let\@ldquote=\quote
\let\@ldendquote=\endquote
\renewenvironment{quote}
   {\@ldquote\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendquote}
   
\let\@ldqttn=\quotation
\let\@ldendqttn=\endquotation
\renewenvironment{quotation}
   {\@ldqttn\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendqttn}
   
\let\@ldverse=\verse
\let\@ldendverse=\endverse
\renewenvironment{verse}
   {\@ldverse\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendverse}

% list of abbreviations
\usepackage{calc}
\newcommand{\t@cfill}{\cleaders\hbox{$\m@th \mkern\@dotsep mu . \mkern\@dotsep mu$}\hfill}
\newcommand{\abbrl@bel}[1]{\makebox[\labelwidth][l]{\textbf{#1}\ \t@cfill}}
\newenvironment{mclistof}[2]{%
   \chapter*{#1}%
   \addcontentsline{toc}{chapter}{#1}
   \begin{list}{}%
   {\renewcommand{\makelabel}{\abbrl@bel}%
    \setlength{\labelwidth}{#2}%
    \setlength{\leftmargin}{\labelwidth+\labelsep}%
    \setlength{\itemsep}{0pt}%
    \markboth{#1}{#1}%
   }}
   {\end{list}\mtcaddchapter}

% lists
% pandoc puts lists in 'tightlist' command when no space between bullet points in Rmd file
\providecommand{\tightlist}{% 
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
   
% section header spacing
\usepackage{titlesec}
\titlespacing\subsubsection{0pt}{24pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}

% chapter page spacing
\renewcommand{\chapterheadstartvskip}{\vspace*{40pt}}
\renewcommand{\chapterheadendvskip}{\vspace{30pt}}

% fix paragraph spacing within quotes for multi-par quotes
\renewenvironment{savequote}[1][8cm]{%
\begin{lrbox}{\@quotebox}
\begin{minipage}[t]{#1}\footnotesize\slshape%
\setlength{\parskip}{6px}}{%
\unskip\end{minipage}\end{lrbox}
\global\setbox\@quotebox\copy\@quotebox
\global\let\@printcites\@iprintcites
\ignorespacesafterend}
\renewcommand{\qauthor}[1]{\par
{\raggedleft\upshape #1\qquad\hbox{}\par}\bigskip}

% make headers in these sections aren't uppercase
\let\@ldtoc\tableofcontents
\renewcommand*\tableofcontents{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldtoc}}
\let\@ldlof\listoffigures
\renewcommand*\listoffigures{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldlof}}
\let\@ldlot\listoftables
\renewcommand*\listoftables{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldlot}}
\let\@ldbib\bibliography
\renewcommand*\bibliography[1]{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldbib{#1}}}

% for highlighting corrections
\newlength{\mccurrentbaselineskip}
\newlength{\mccurrentparskip}
\newlength{\mccurrentparindent}
\newif\ifcorrections
\newif\ifm@csection
\m@csectionfalse
\correctionsfalse
% colour of corrections
\colorlet{shadecolor}{blue!20}
% framing/border around corrections
\usepackage{framed}
\OuterFrameSep=-9pt
\newenvironment{correction}
{\ifcorrections\colorlet{shadecolor}{blue!20}\if@nobreak\m@csectiontrue\fi\begin{shaded}\ifm@csection\noindent\ignorespaces\fi\fi}
{\ifcorrections\end{shaded}\m@csectionfalse\ifx\@captype\@undefined\@nobreakfalse\fi\fi}
% shading of corrections
\usepackage{soul}
\sethlcolor{shadecolor}
\newcommand{\mccorrect}[1]{\ifcorrections\hl{#1}\else#1\fi}

% combine all the commands used to start appendices
% \appendixpage creates a page that says 'Appendices' before the appendices
\newcommand{\startappendices}
  {\appendix\adjustmtc\noappendicestocpagenum\addappheadtotoc\appendixpage} 
