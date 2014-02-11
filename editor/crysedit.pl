#!/usr/bin/perl -w



if ( $#ARGV < 2 ) { showusage() };

$source = $ARGV[0];
$output = $ARGV[1];
$include = "&";
$exclude = "#";
$comment = "C ";
$strip = 0;
$code = "DEF";

foreach $i (@ARGV[2..$#ARGV])    {
 
     if ( $i =~ m/code=(...)$/ ) {
          $code = $1;
     } elsif ( $i =~ m/incl=(.)$/ ) {
          $include = $1;
     } elsif ( $i =~ m/excl=(.)$/ ) {
          $exclude = $1;
     } elsif ( $i =~ m/comm=(..?)/ ) {
          $comment = $1;
     } elsif ( $i =~ m/^strip$/ ) {
          $strip = 1;
     } else {
          print "\n Unrecognised option '$i' in command line:\n\n crysedit.pl @ARGV \n\n";
          showusage();
     }
 }

 print "Source file: $source\n";
 print "Output file: $output\n"; 
 print "Platform code: $code\n";
 print "Source file comments: $comment\n";
 print "Exclude marker for lines for given platform: $exclude\n";
 print "Include marker for lines for given platform: $include\n";
 print "Strip comments = $strip\n";

 open(my $fhi, '<', "$source") or die "Could not open source. $!";
 open(my $fho, '>', "$output") or die "Could not open output for writing. $!";
 
 while (<$fhi>) { 

     my $line = $_;
     chomp($line);
#   &&&&GIDGILWXSMAC    ! 0-2, 3-5, 6-8, 9-11
#    &&&GIDWXSMAC       ! 0-2, 3-5, 6-8
#     &&WXSMAC
#      &GID


     if($line =~ m/^(\Q$include\E+)(.*)$/ ) {
         $icount = length($1) - 1;
         $remainder = $2;
         foreach $i ( 0..$icount)  {
             $three = substr( $remainder,$i*3,3);
             if ($three =~ m/$code/ ) {
              print "Matched $i include $code\n";
              print $fho substr( $remainder,$icount*3+3) . "\n";
             }
         }
     }
     elsif($line =~ m/^($exclude+)(.*)$/ ) {
         $icount = length($1) - 1;
         $remainder = $2;
         $found = 0;
         foreach $i ( 0..$icount)  {
             $three = substr( $remainder,$i*3,3);
             if ($three =~ m/$code/ ) {
                print "Matched $i exclude $code\n";
                $found = 1;
             }
         }
         print $found . "\n";
         if ( $found == 0 ) {
            print substr( $remainder,$icount*3+3) . "\n";
            print $fho substr( $remainder,$icount*3+3) . "\n";
         }
     }
     elsif(($strip == 1) && ( $line =~ m/^$comment/ )) {
        #do nothing
     } else {
              print $fho "$line\n";
     }
 }
 close ($fhi);
 close ($fho); 
 


 exit();



print (" using $CRYSEXE \n");

# Either clean up, or run the tests.

  if (TRUE eq contains("-c", @ARGV))
  {
    print "Doing clean up\n";
    cleanUp(@cleanup);
  }
  else
  {
    $starttime = time();
    print "Running tests...\n";
    runTest();
    print "\nTime taken: " . ( time() - $starttime ) . " seconds.\n";
  }


  exit $exitcode;

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

sub showusage #print command line usage info and exit
{
    print "Usage:\n";
    print " crysedit.pl <source> <output> code=XXX [incl=A] [excl=B] [comm=CD] [strip]\n\n";
    print "XXX is the three letter platform code (e.g. GID, GIL, MAC, WXS, INW, etc)\n";
    print "A is a one character marker that identifies lines to include for given platforms";
    print "B is a one character marker that identifies lines to exclude for given platforms";
    print "CD is a two character marker that identifies lines which are comments in source";
    print "strip indicates that comments should be removed from output";
    exit(-2);
}

sub cleanUp   # Delete unwanted output files
{
    my (@cleanUpFile) = @_;          # Set to first arg of subroutine.
    my @bfiles = glob ("bfile*.*");  # Get all the bfiles in current dir.
    push @bfiles, @cleanUpFile;      # Append list of files to delete.
    foreach $bfile (@bfiles) {
        unlink $bfile || print ("Could not delete $bfile");
    }
}

sub contains     # Is this $element in the array of tokens?
{
    my ($element, @array) = @_;
    foreach $i (@array)    {
        if ($i eq $element) { return TRUE; }
    }
    return FALSE;
}



sub obscureMachinePrecision() {

	use File::Copy;
	$new_file = "$CROUTPUT.temp";
	copy($CROUTPUT, $new_file);

	open(my $fhi, '<', "$CROUTPUT.temp") or die $!;
        open(my $fho, '>', "$CROUTPUT") or die $!;
        while (<$fhi>) { 
	   my $line = $_;
           chomp($line);
# su_max shift often has too much precision to be stable across platforms
	   if($line =~ m/^(_refine_ls_shift\/su_max *\d*.\d\d\d\d\d)\d\d *$/ ) {
              print $fho "$1\n";
# su_max shift often has too much precision to be stable across platforms
	   } elsif($line =~ m/^(_refine_ls_shift\/su_mean *\d*.\d\d\d\d\d)\d\d *$/ ) {
              print $fho "$1\n";
# Version number in CIF changes
	   } elsif($line =~ m/^_audit_creation_method CRYSTALS.*$/ ) {
              print $fho "_audit_creation_method CRYSTALS\n";
           } else {
              print $fho "$line\n";
	   }
 	}
        close ($fhi);
        close ($fho); 
        unlink ($fhi);
}


sub runTest      # Run each .tst file through both versions of CRYSTALS.
{
    foreach $currentFileName (@files)
    {
	$CRYUSEFILE=$currentFileName;
        $name = $currentFileName;   
        $name =~ s\.tst\\g;           # Remove the .tst extension.
	
        $CROUTPUT="$name.out";        # Set environment variable
        unlink "$CROUTPUT";
        unlink "crfilev2.dsc";
        print("Running Crystals (release version) on $name.tst\n");
        `$CRYSEXE`;                   # Run it
	
	
        obscureMachinePrecision();


        if (TRUE ne contains("-l", @ARGV)) {
            print("Removing bfiles (use '-l' to leave in place)\n");
	    cleanUp(@cleanup);
	}
        print `fc $CROUTPUT $COMPCODE.org/$CROUTPUT`;
        
        print "$?";
        if ( "$?" != "0" ) {
           $exitcode = 1;
        }	
	
#        $CROUTPUT="$name.d.out";      # Set environment variable
#        print("Deleting files... ");
# 	unlink "$CROUTPUT";
# 	unlink "crfilev2.dsc";
#        print("Running Crystals (debug version) on $name.tst\n");
#        `$CRYSDEXE`;                  # Run it
#	
#        if (TRUE ne contains("-l", @ARGV)) {
#            print("Removing bfiles (use '-l' to leave in place)\n");
#	    cleanUp(@cleanup);
#	}
#	print("Doing diff!\n");
#        print `diff $CROUTPUT $COMPCODE.org/$CROUTPUT > diffs/$name.d.diff`;
    }
}

