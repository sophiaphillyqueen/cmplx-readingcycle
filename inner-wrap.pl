use strict;
use argola;

my $file_chosen = 0;
my $chosen_file; # The file of source]
my $file_cont_raw;
my $year_a;
my $mont_a;
my $daym_a;
my $year_n;
my $mont_n;
my $daym_n;
my $dayw_n;
my $cursec;

# We now set the current date as the default starting date:
{
  my $lc_sdat;
  $lc_sdat = `date +%Y-%m-%d`; chomp($lc_sdat); # -%w
  ($year_a,$mont_a,$daym_a) = split(quotemeta("-"),$lc_sdat);
}


sub opt_file {
  if ( $file_chosen > 5 )
  {
    die "\nIllegal duplicate use of -file option:\n\n";
  }
  
  $chosen_file = &argola::getrg();
  
  $file_chosen = 10;
}
&argola::setopt("-file","opt_file");

sub opt_date {
  $year_a = &argola::getrg();
  $mont_a = &argola::getrg();
  $daym_a = &argola::getrg();
  &frig($year_a);
  &frig($mont_a);
  &frig($daym_a);
}
&argola::setopt("-date","opt_date");


&argola::runopts();


if ( $file_chosen < 0 )
{
  die "\nNO FILE CHOSEN (use -file option)\n\n";
}



# This is the part where we load the file's contents:
{
  my $lc_cm;
  $lc_cm = "cat";
  &argola::wraprg_lst($lc_cm,$chosen_file);
  $file_cont_raw = `$lc_cm`;
}

# Get the current time:
$cursec = `date +%s`; chomp($cursec);
&zambodate();
sub zambodate {
  my $lc_a;
  $lc_a = `date -j -f $cursec +%Y-%m-%d-%w`; chomp($lc_a);
  ($year_n,$mont_n,$daym_n,$dayw_n) = split(quotemeta("-"),$lc_a);
  &frig($year_n);
  &frig($mont_n);
  &frig($daym_n);
  &frig($dayw_n);
}
sub frig {
  my $lc_a;
  $lc_a = int($_[0] + 0.2);
  $_[0] = $lc_a;
}


