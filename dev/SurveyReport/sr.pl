#!/usr/bin/perl
#
# Survey report script

use warnings;
use strict;

# Decoder of gesture interface expertise
my @gesture_expertise =
(
  "illegal",
  "use_cellphone",
  "use_audioplayer",
  "use_tablet",
  "use_computer",
  "illegal"
);

# Decoder of audio production expertise
my @audioproduction_expertise =
(
  "illegal",
  "student_audio",
  "student_media",
  "producer_professional",
  "producer_hobby",
  "illegal"
);

# Decoder of gender
my @gender =
(
  "illegal",
  "female",
  "male",
  "illegal"
);

# Decoder of age
my @age =
(
  "illegal",
  "25 or less",
  "26 to 35",
  "36 to 45",
  "46 to 55",
  "56 or more",
  "illegal"
);

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

# Decoder of functions
my %functions =
(
  "p1"  => "Go one bar forward",
  "p2"  => "Go one bar backward",
  "p3"  => "Jump to beginning",
  "p4"  => "Jump to end",
  "p5"  => "Fit selected track to window",
  "p6"  => "Fit selected region to window",
  "p7"  => "Fit all tracks to window: vertical",
  "p8"  => "Fit all tracks to window: horizontal",
  "p9"  => "Recall zoom preset",
  "p10" => "Cut selected region",
  "p11" => "Copy selected region",
  "p12" => "Paste previously cut or copied region",
  "p13" => "Duplicate selected region",
  "p14" => "Delete selected region",
  "p15" => "Split selected region",
  "p16" => "Glue selected regions together",
  "p17" => "Toggle metronome",
  "p18" => "Undo last action",
  "p19" => "Redo action undone last",
  "p20" => "Select all",
  "p21" => "Increase value of a control",
  "p22" => "Decrease value of a control"
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

  open(EMAIL, "<$_")
    or die "Could not open file " . $_ . "\n";


  # Process lines
  while(<EMAIL>)
  {
    chomp;

    print $_ . "\n";

    if(m/^#1#([\d,])+/)
    {
      my $gie = $1;
      print "Gestural interface experience: $gie\n";
    }
    elsif(m/^#7#(.+)$/)
    {
      # Store function-gesture-pairs
      $_ = $1;

      # Cut into single function-gesture-pairs
      while(1)
      {
        my $found = m/^(p\d+),im(\d+);(.+)$/;

        if(!$found)
        {
          last;
        }

        print "$1\n";
        print "$2\n";
        print "$3\n";

        # Store unprocessed rest
        $_ = $3;
      }
    }
  }


  close(EMAIL)
    or die "Could not close file\n";
}

