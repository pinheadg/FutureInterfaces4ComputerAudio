#!/usr/bin/perl
#
# Survey report script

use warnings;
use strict;

# If no arguments specified, die with message
if(scalar(@ARGV) == 0)
{
  die "Usage: sr.pl file1 file2 ... filen\n";
}

