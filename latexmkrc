#!/usr/bin/env perl
$latex            = 'uplatex -shell-escape';
$bibtex           = 'upbibtex';
$dvipdf           = 'dvipdfmx -o %D %S';
$max_repeat       = 5;
$pdf_mode	  = 3; # generates pdf via dvipdfmx

# Prevent latexmk from removing PDF after typeset.
# This enables Skim to chase the update in PDF automatically.
$pvc_view_file_via_temporary = 0;

# Use evince as a previewer
$pdf_previewer    = "evince";
$preview_continuous_mode = 1;
