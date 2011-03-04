% This is aes130.cls for the AES 130th convention
% A skeleton class to load the main class aes.cls
\ProvidesClass{aes130}
         [2004/06/14 v1.01  AES 130th convention paper style]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{aes}}
%%%130th Convention - London, UK - May 13-16, 2011
\ProcessOptions
\def\AEScontype{Convention}%
\def\AESconname{130th \AEScontype}%
\def\AEScondate{2011 May 13--16}%
\def\AESconplace{London, UK}%
\def\AESconRHname{AES 130${}^{\mbox{\scriptsize th}}$ Convention}%
\def\AESconRHdate{2011 May 13--16}%
\def\AESconRHplace{London, UK}%
\LoadClass{aes}[2006/04/02]
\endinput
