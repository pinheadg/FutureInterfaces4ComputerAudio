#!/usr/bin/perl
#
# Survey report script

use warnings;
use strict;

# Decoder of gesture names
my @gesture_name =
(
  "illegal",
  "digit", "down-left", "down", "down-right", "down-up",
  "down-up-down", "left", "left-down", "left-right", "left-right-left",
  "left-up", "letter", "multi-pinch-horizontal", "multi-pinch-vertical", "multi-rotate-clockwise",
  "multi-rotate-counterclockwise", "multi-spread-horizontal", "multi-spread-vertical", "right", "right-down",
  "right-left", "right-left-right", "right-up", "rotate-clockwise", "rotate-counterclockwise",
  "up", "up-down", "up-down-up", "up-left", "up-right",
  "illegal"
);


# If no arguments specified, die with message
if(scalar(@ARGV) == 0)
{
  die "Usage: sr.pl file1 file2 ... filen\n";
}

# For every file specified ...
foreach(@ARGV)
{
  print $_ . "\n";
}

