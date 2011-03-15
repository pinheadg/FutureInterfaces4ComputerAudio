#!/usr/bin/perl
#
# Survey report script

use warnings;
use strict;

# Decoder of gesture interface expertise
my @gesture_expertise =
(
  "illegal",
  "use_touch_cellphone",
  "use_touch_audioplayer",
  "use_touch_tablet",
  "use_touch_software"
);

# Decoder of audio production expertise
my @audioproduction_expertise =
(
  "illegal",
  "producer_hobby",
  "student_audio",
  "professional_part_time",
  "professional_full_time",
  "educator",
  "developer",
  "researcher"
  "other"
);

# Decoder of gender
my @gender =
(
  "illegal",
  "female",
  "male"
);

# Decoder of age
my @age =
(
  "illegal",
  "25 or less",
  "26 to 35",
  "36 to 45",
  "46 to 55",
  "56 or more"
);

# Decoder of gesture names
my @gesture_name =
(
  "illegal",
  "digit", "down-left", "down", "down-right", "down-up",
  "sign-x", "left", "left-down", "left-right", "sign-+",
  "left-up", "letter", "multi-pinch-horizontal", "multi-pinch-vertical", "tap-hold",
  "tap-double", "multi-spread-horizontal", "multi-spread-vertical", "right", "right-down",
  "right-left", "tap", "right-up", "rotate-clockwise", "rotate-counterclockwise",
  "up", "up-down", "up-left", "up-right", "triangle"
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

# Data accumulators
my $persons = scalar(@ARGV);
my %lang_acc = ( "en" => 0, "de" => 0 );
my @gestexp_acc;
my @gestexp_comments;
my @audprodexp_acc;
my @audprodexp_comments;
my @gender_acc;
my @age_acc;
my @comments;

# Initialize accumulators
foreach(@gesture_expertise) { push(@gestexp_acc, 0); }
foreach(@audioproduction_expertise) { push(@audprodexp_acc, 0); }
foreach(@gender) { push(@gender_acc, 0); }
foreach(@age) { push(@age_acc, 0); }

# Initialize function-gesture accumulator
my %fg_acc;

foreach my $k (keys(%functions))
{
  for(my $i = 0; $i < scalar(@gesture_name); $i++)
  {
    push(@{$fg_acc{$k}}, 0);
  }
}



# For every file specified ...
foreach(@ARGV)
{
#  print $_ . "\n";

  open(EMAIL, "<$_")
    or die "Could not open file " . $_ . "\n";


  # Process lines
  while(<EMAIL>)
  {
#    print $_;

    chomp;

    if(!m/^#/)
    {
      next;
    }

    if(m/#1#([\d,]+)?/)
    {
      if($1)
      {
        foreach my $d (split(/\,/, $1))
        {
            $gestexp_acc[$d]++;
        }
      }

      # Store language information
      if(m/^#en#1#/)
      {
        $lang_acc{"en"}++;
      }
      elsif(m/^#1#/)
      {
        $lang_acc{"de"}++;
      }
      else
      {
        print "Strange answer!\n";
      }
    }
    elsif(m/^#2#(.+)?/)
    {
      if($1)
      {
        push(@gestexp_comments, $1);
      }
    }
    elsif(m/^#3#(\d)/)
    {
      $audprodexp_acc[$1]++;
    }
    elsif(m/^#4#(.+)?/)
    {
      if($1)
      {
        push(@audprodexp_comments, $1);
      }
    }
    elsif(m/^#5#(\d)/)
    {
      $gender_acc[$1]++;
    }
    elsif(m/^#6#(\d)/)
    {
      $age_acc[$1]++;
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

        # Store results
        my $function_index = $1;
        my $gesture_index = $2;

        @{$fg_acc{$function_index}}[$gesture_index]++;

        # Store unprocessed rest
        $_ = $3;
      }
    }
    elsif(m/^#8#(.+)?/)
    {
      if($1)
      {
        push(@comments, $1);
      }
    }
    elsif(m/^#9#/)
    {
      # Nothing here, just a strange paragraph
    }
    else
    {
      print STDERR "Strange line: $_\n";
    }
  }


  close(EMAIL)
    or die "Could not close file\n";
}

print "\n\n\n\n";

# Print report

print "Survey report:\n";
print "--------------\n";
print "\n";

print "$persons persons completed the survey.\n\n";

my $lang_en = $lang_acc{"en"};
my $lang_de = $lang_acc{"de"};
print "$lang_en took the English version.\n";
print "$lang_de took the German version.\n";
print "\n";

for(my $i = 1; $i < scalar(@gestexp_acc); $i++)
{
  my $gestexp = $gestexp_acc[$i];

  print "$gestexp participants have gesture expertise " .
        "$gesture_expertise[$i].\n";
}

print "\n";

if(scalar(@gestexp_comments) > 0)
{
  print "Comments follow:\n";
  foreach my $comment (@gestexp_comments)
  {
    print " * $comment\n";
  }

  print "----\n";
  print "\n";
}

for(my $i = 1; $i < scalar(@audprodexp_acc); $i++)
{
  my $audprodexp = $audprodexp_acc[$i];

  print "$audprodexp participants have audio production expertise " .
        "$audioproduction_expertise[$i].\n";
}

print "\n";

if(scalar(@audprodexp_comments) > 0)
{
  print "Comments follow:\n";
  foreach my $comment (@audprodexp_comments)
  {
    print " * $comment\n";
  }

  print "----\n";
  print "\n";
}

for(my $i = 1; $i < scalar(@gender_acc); $i++)
{
  print "$gender_acc[$i] participants are " .
        "$gender[$i].\n";
}

print "\n";

for(my $i = 1; $i < scalar(@age_acc); $i++)
{
  print "$age_acc[$i] participants are in the age group " .
        "$age[$i].\n";
}

print "\n";

print "Preferred gestures:\n\n";

foreach my $function (keys(%fg_acc))
{
  my %rev_index = ();

  # Print function name
  print "Function: " . $functions{$function} . "\n";

  my @gestures_chosen = $fg_acc{$function};

  for(my $i = 0; $i < scalar(@gesture_name); $i++)
  {
    my $gesture = $gesture_name[$i];
    my $gesture_chosen = $gestures_chosen[0][$i];

    # Eleminate zero times chosen gestures
    if($gesture_chosen > 0)
    {
      print "$gesture_chosen: $gesture\n";
    }
  }

  print "\n";
}

print "\n";

if(scalar(@comments) > 0)
{
  print "Miscellaneous comments follow:\n";
  foreach my $comment (@comments)
  {
    print " * $comment\n";
  }

  print "----\n";
  print "\n";
}


