C $Log: not supported by cvs2svn $
C Revision 1.198  2013/03/14 15:54:55  djw
C Much extended absolute configuration analysis, including the Parsons Quotient test.  More reflection filters added to #TON
C
C Revision 1.196  2012/11/02 10:30:17  djw
C Weight the Dobs/Dcalc plot with 1/sigmasq and convert gradient to pseudo-Flack and esd.
C
C Revision 1.195  2012/09/21 14:01:50  djw
C High-light warning that absolute configuration is not determined
C
C Revision 1.194  2012/07/12 10:22:06  rich
C Remove first comment line - latest checkin caused some problem with DF compiler.
C
C Revision 1.193  2012/07/12 08:39:27  rich
C Correct index of JLOAD (was out of range).
C
C Revision 1.192  2012/07/11 13:46:49  djw
C Add output message when Hooft parameter does not compute
C
C Revision 1.191  2012/05/17 09:06:46  djw
C Remove then restore dividing Friedel differences by sigma.  The scaled graphs look better. We might still want to add plot of Friedel averages.
C Add new routine to create a minimal cif for use in Mercury
C
C Revision 1.190  2012/05/11 12:52:14  rich
C Fix date order on Intel platform. Expand year to four digits in CIF output on all platforms.
C
C Revision 1.189  2012/02/03 09:47:17  djw
C REmove debugging print to unit 133
C
C Revision 1.188  2012/01/06 10:21:22  rich
C Format change to HTML summary output of serial numbers.
C
C Revision 1.187  2012/01/05 16:15:00  rich
C Allow atom serial numbers up to 9999999 in the CIF.
C
C Revision 1.186  2011/11/18 10:37:47  djw
C make crystal class and solution method all-lower case, correct keywords for hydrogen tratment
C
C Revision 1.185  2011/11/03 09:20:59  rich
C Extend output format statements.
C
C Revision 1.184  2011/10/20 10:22:54  djw
C Bug reported by Ibby.  Values for Tmax Tmin should not be given if absorption method was "none"
C
C Revision 1.183  2011/09/21 14:34:14  rich
C Fix CIF output to use data reduction option from L30 (not instrument type).
C
C Revision 1.182  2011/09/01 13:09:56  djw
C Create subroutine XCIF2 in PUNCH.FPP to output LIST 2 in cif format for use in fcf (and in cif) files
C
C Revision 1.181  2011/08/31 15:42:56  rich
C Removed uninitialised variables from #TON
C
C Revision 1.180  2011/08/12 14:09:18  djw
C Create a psuedo-esd from the least-squares weight for Simon P.  Fraught with dangers. Uncomment some of the writes to 123 to see
C how the estimated sigma compares with the actual sigma.
C The npp looks good with natural sigmas, but has a non-unit slope with pseudo-sigmas.
C Conversion of weight to pseudo-sigma depends upon the kind of refinement (F or Fsq)
C
C It's been tested on a handfull of structures, and luckily, except for the slope of the npp plot. there is not much difference in the Hoof
C parameters.
C
C Revision 1.179  2011/07/27 12:04:08  djw
C JU and JV were used before they were initialised. The results was never used.
C
C Revision 1.178  2011/06/13 14:24:37  djw
C Increase word length for unidentifed radiation
C
C Revision 1.177  2011/05/23 16:07:58  rich
C For abs config normal probability plot, use weight instead of sigma.
C Fix axis on normal normal probability plot.
C
C Revision 1.176  2011/05/11 13:28:53  rich
C During #TON output HKL and -H-K-L indices (after SysAb collection) in order to
C allow omission of both observations from L28.
C
C Revision 1.175  2011/04/04 09:19:05  djw
C Set the corrct type oh hydrogen treatment in the body of the cif based on the LIST 5 entries if set
C
C Revision 1.174  2011/03/22 11:29:56  rich
C Double slashes dealt with properly. Fixed squashed CIF format.
C
C Revision 1.173  2011/03/21 13:57:22  rich
C Update files to work with gfortran compiler.
C
C Revision 1.172  2011/03/14 15:35:54  djw
C Report H treatment in cif as "mixed"
C
C Revision 1.171  2011/02/15 16:24:43  djw
C Increase figure filed for Tmin/max, get correct program refernce for multi-scan data with Bruker and Agilent software
C
C Revision 1.170  2011/02/11 12:00:31  djw
C remove esd from both D-H and H-A to keep Ton happy
C
C Revision 1.169  2011/02/04 17:37:23  djw
C Remember to swap round esd flag ih H atoms in hydrogen bond are swapped
C
C Revision 1.168  2011/01/20 15:39:43  djw
C Tidy up output
C
C Revision 1.167  2010/11/03 15:23:28  djw
C Include superflip as solve method in cif, plot Do/sigma in Absolute configuration Fo/Fc plot
C
C Revision 1.166  2010/09/20 14:57:23  djw
C Add info about SUpernova
C
C Revision 1.165  2010/07/30 09:19:40  djw
C Edit caption in  Ton code
C
C Revision 1.164  2010/07/16 11:35:31  djw
C Enable XPCHLX to output lists 12 and 16 to the cif file.  This means carrying the I/O chanel (as NODEV)
C in XPCHLX,XPCHLH,PPCHND and XPCHUS.
C Fixed oversight in distangle for esds of H-bonds
C
C Revision 1.163  2010/07/13 14:11:24  djw
C Compute wRD etc using w = 1/sigmasq.
C Correct unpaired reflection count
C Sort out H-bind esds for compatibility with PLATON
C
C Revision 1.162  2010/06/29 12:00:43  djw
C Trap potential zero divide in calculation of P(2)
C
C Revision 1.161  2010/06/24 08:00:09  djw
C Ancient bug - TYPE(4)+SERIAL(4)+() is 10  (not 8) characters
C
C Revision 1.160  2010/06/17 15:32:38  djw
C Load L25 if it exists because it may be needed by KSYSAB.
C Output Flack info to NCAWU
C
C Revision 1.159  2010/05/06 10:04:16  djw
C Set reflections used for hklf5 twinned data (cannot be merged in CRYSTALS), output special shapes in a Brian McMahon-friendly format
C
C Revision 1.158  2010/04/26 15:11:56  djw
C Sets UNIT weights for restraints
C
C Revision 1.157  2010/03/04 15:14:50  djw
C Set esd for Flack restriants to sigma(D)
C
C Revision 1.156  2010/01/18 16:19:10  djw
C Increase figure field for cell edges too
C
C Revision 1.155  2010/01/13 13:41:27  djw
C Increase field size for beta
C
C Revision 1.154  2009/12/23 08:31:57  djw
C In TON add column with noise added to Dfc
C
C Revision 1.153  2008/12/14 17:03:17  djw
C Enable the centric reflections to be identified and counted
C
C Revision 1.152  2009/12/07 10:54:20  djw
C Update headers for PUNCH output in #TON (Experimental)
C
C Revision 1.151  2009/11/13 09:17:04  djw
C Correct intrument details and type in cif generator
C
C Revision 1.150  2009/10/21 10:36:49  djw
C Add a comment about the PREFLACK parameter
C
C Revision 1.149  2009/10/13 16:44:08  djw
C Change Audit Date to make PLATON happy, change cif comment to make intention clearer
C
C Revision 1.148  2009/09/02 08:42:12  djw
C Fix typo
C
C Revision 1.147  2009/09/02 07:03:37  djw
C Remove debugging print, correct Flack refernce
C
C Revision 1.146  2009/07/31 12:43:54  djw
C Remove a spurious message about weights
C
C Revision 1.145  2009/07/24 14:01:21  djw
C Compute FRIEDIF, create Friedel restraints
C
C Revision 1.144  2009/07/02 09:19:13  djw
C Increate format statement for CRITER, and use CRITER as thshold for writing out RESTRAINTS
C
C Revision 1.143  2009/06/17 13:45:10  djw
C Correct inof about merge in LIST 30.
C Also, early version of FLack restraint
C
C Revision 1.142  2009/05/08 15:09:31  djw
C Create SYMCODE subroutine for X-tal type codes
C
C Revision 1.141  2009/05/01 08:45:39  djw
C Fix cif text for SHELX weights
C
C Revision 1.140  2009/04/28 09:51:44  djw
C Compute mean(abs(shift/su)) for CIF compliance.  Store in STORE(L30RF+11), in place of total minimisation function, which was never used
C
C Revision 1.139  2009/04/27 16:35:18  djw
C Add references for GEMINI
C
C Revision 1.138  2009/04/08 07:34:06  djw
C Increase number of decimal places in SIZE
C
C Revision 1.137  2009/02/05 11:39:52  djw
C Tidy up output for the absolute configuration code.  Enable O/P of Friedel pairs, average and difference
C
C Revision 1.136  2009/01/21 17:06:54  djw
C Add keyword to enable output of Friedel Pairs
C
C Revision 1.135  2008/12/18 16:39:25  djw
C Create subroutine for computing correlation coefficients
C
C Revision 1.134  2008/11/21 16:05:06  djw
C Improvements in formatting output, trap negative sqrts and zero denominators
C
C Revision 1.133  2008/11/19 18:31:38  djw
C Do plots and statistics for NPP and Fo/Fc in Spek/Hooft code
C
C Revision 1.132  2008/10/29 09:13:56  djw
C Add 'Scientific notation' output of probabilities
C
C Revision 1.131  2008/10/14 17:20:29  djw
C increase number of sig fig output from Flack and Spek parameters
C
C Revision 1.130  2008/10/01 11:03:21  djw
C Include support for outlier elimination (See PLATON)
C
C Revision 1.129  2008/09/22 12:30:17  rich
C Escape backslashes in strings on unix versions
C
C Revision 1.128  2008/09/08 14:04:42  djw
C test
C
C Revision 1.127  2008/09/08 10:18:32  djw
C Enable/inhibit punching of ADP info from XPRAXI
C
C Revision 1.126  2008/09/08 07:15:47  djw
C More Benford updates
C
C Revision 1.125  2008/05/30 10:07:53  djw
C Insert comment if Flack has been refined but Friedel pairs were later merged
C
C Revision 1.124  2008/03/31 14:54:08  djw
C Move the Firedel flag in SYST into the JCODE slot. Previously (in corrections of phase) it zapped Fourier maps
C
C Revision 1.123  2008/03/07 16:09:48  djw
C changes to help with the correct computation of Fourier maps from twinned crystals.  THe old COPY67 subroutine did not pack the data properly unless the keys were the default keys.  The job is now done
C
C Revision 1.122  2008/01/25 14:36:47  djw
C Enable Kallow in #Ton
C
C Revision 1.121  2008/01/10 15:50:40  djw
C update link top Tons code
C
C Revision 1.120  2007/12/17 18:04:16  djw
C XTON moved into results
C
C Revision 1.119  2007/10/09 07:02:08  djw
C use mean C-C esd, output more R-factors, support multi-structure cifs, support APEX2
C
C Revision 1.118  2007/04/05 14:46:45  djw
C More h-bond nonsense
C
C Revision 1.117  2007/04/04 08:23:56  djw
C Put Rint as fraction, not %
C
C Revision 1.116  2007/03/08 11:58:41  djw
C Fix format
C
C Revision 1.115  2006/12/05 12:37:33  arie
C Adding Superflip, Sir2002, Sir2004 to structure solution package list in CIF goodies
C
C Revision 1.114  2006/12/04 15:22:18  arie
C *** empty log message ***
C
C Revision 1.113  2006/11/23 12:50:58  djw
C Bugs spotted by Pascal Parios
C
C Revision 1.112  2006/10/06 08:58:51  djw
C Put Rint on correct scale in HTML output
C
C Revision 1.111  2006/08/02 06:21:49  djw
C special shapes and other changes from Judith Flippenanderson
C
C Revision 1.110  2006/06/13 10:02:03  djw
C More cif goodies suggested by Judy Flippen Anderson
C
C Revision 1.109  2006/04/19 08:08:59  djw
C More cif changes for Cleggie
C
C Revision 1.108  2006/02/16 15:37:37  djw
C Compress the HTML Publish file
C
C Revision 1.107  2006/01/06 10:08:57  djw
C Fixes to cif output of torsion angles
C
C Revision 1.106  2005/11/16 11:25:06  djw
C Skip LIST 6 items for cif if there is no LIST 6
C
C Revision 1.105  2005/10/25 16:32:06  djw
C Fix the number of decimal places in H-bond info to keep Bill happy
C
C Revision 1.104  2005/07/26 09:25:42  djw
C More Cleggy cif goodies
C
C Revision 1.103  2005/05/20 08:49:44  djw
C Inhibit h-bond header if there are no H bonds
C
C Revision 1.102  2005/03/07 09:07:40  djw
C Correct Error in short SHELDRICK weight formula
C
C Revision 1.101  2005/02/25 17:25:20  stefan
C 1. Added some preprocessor if defined lines for the mac version.
C
C Revision 1.100  2005/02/01 15:43:06  djw
C Extra dot.
C
C Revision 1.99  2005/01/23 08:29:12  rich
C Reinstated CVS change history for all FPP files.
C History for very recent (January) changes may be lost.
C
C Revision 1.4  2005/01/17 14:03:40  rich
C Bring new repository into line with old (Remove esd from H atoms and report
C angles to 1dp; Fix dps for H geom in CIF; Put H bond DA distance in CIF; reformat
C SHELX weights for Clegg's sake).
C
C Revision 1.3  2004/12/20 11:43:41  rich
C Fix for WXS version.
C
C Revision 1.2  2004/12/13 16:16:08  rich
C Changed GIL to _GIL_ etc.
C
C Revision 1.1.1.1  2004/12/13 11:16:07  rich
C New CRYSTALS repository
C
C Revision 1.94  2004/11/16 16:20:30  rich
C Oops. Try writing valid FORTRAN.
C Fix another unescaped backslash in SHELX weight format statement.
C
C Revision 1.93  2004/11/16 16:18:36  rich
C Need to escape backslash on unix.
C
C Revision 1.92  2004/11/16 16:16:02  rich
C Allow \ instead of # in reftab.dat
C
C Revision 1.91  2004/11/03 14:47:10  djw
C Tidy up SHELX weight text in cif
C
C Revision 1.90  2004/10/20 10:28:14  rich
C Minor patch: HBONDS: If no h-bonds found put 10 dots on the next line so that the CIF syntax
C is correct.
C
C Revision 1.89  2004/08/17 15:56:47  djw
C Append H bonds to cif
C
C Revision 1.88  2004/08/09 16:37:08  djw
C Output SHELX weights in compact form
C
C Revision 1.87  2004/07/12 15:32:11  stefan
C Replaces a reference to 'H   ' which Richard added with a constant already declared in the function.
C This was to fix a type mismatch problem on the mac and Mandrake.
C
C Revision 1.86  2004/07/08 15:23:28  rich
C Added H-treatment options to the end of L30's CIF block. The default is
C UNKNOWN, and if left unchanged, this will cause the CIF generator to
C actually work out the appropriate keyword. It does this using the REFINE
C flag (Offset 15 in List 5), and can distinguish between NONE (no H present),
C CONSTR (for riding and rigid group refinement), REFALL, REFU, REFXYZ (for
C those types), MIXED (if any H differs from any other), and NOREF (for
C no refinement of any H). Happy Acta'ing.
C
C Revision 1.85  2004/06/17 10:30:01  rich
C Comment out some unused routines.
C
C Revision 1.84  2004/06/10 16:15:10  djw
C Change back to computing cell properties from L5, but include L29 values in CIF as comments
C
C Revision 1.83  2004/06/10 07:52:24  djw
C Tidy up loose ends in cif output for absorption correction.  NOTE that the keywords PSIMIN/MAX have been replaced by ANALMIN/MAX.
C
C Revision 1.82  2004/06/08 14:16:56  djw
C Show given and found formulae in cif. Output given (as opposed to found) as data items.  Variable IEPROP set if L5 and L29 differ
C
C Revision 1.81  2004/05/13 14:40:51  rich
C Many, many changes to the CIF. It's better.
C
C Revision 1.80  2004/04/29 16:08:19  djw
C Fix bug intriduced while ifxinh riding H esds
C
C Revision 1.79  2004/04/27 16:16:56  djw
C add switch to Parameters to inhibit printing esds on riding H atoms
C
C Revision 1.78  2004/04/20 11:16:42  rich
C One extra dp on the R_int value for anyone trying to publish in Acta E.
C
C Revision 1.77  2004/02/18 14:20:21  rich
C In XDATER, change order from American to UK (reqd to get CIF audit_creation_date
C in the correct order).
C Use current version number to add a version suffix to the audit_creation_method
C key in the CIF.
C
C Revision 1.76  2004/02/17 09:47:01  rich
C Avoid putting assembly and group numbers in CIF if the PART entry appears to
C be invalid (>999999). This can occur with OLD L5's since the xwrite5 script
C used to use the PART slot as temporary storage space.
C
C Revision 1.75  2004/02/16 14:17:04  rich
C Output list of missing reflections to GUI during #THLIM calculation, if
C requested.
C
C Revision 1.74  2004/02/13 14:51:12  rich
C Move TMIN calculation to before the place where it is used. Doh.
C
C Revision 1.73  2004/02/04 16:58:00  stefan
C Changes for Mac command line version
C
C Revision 1.72  2003/12/05 14:58:33  rich
C Correct CIF data names for disordered parts.
C
C Revision 1.71  2003/11/13 14:06:02  rich
C Change element names to mixed case in summary and HTML output.
C
C Revision 1.70  2003/11/06 15:50:08  rich
C Added to the CIF atom loop_:
C
C   _atom_site_disorder_assembly
C   _atom_site_disorder_group
C
C  These keys take the value of the assembly and group bits of the part
C  key in L5 respectively. Otherwise, just a '.'
C
C Revision 1.69  2003/11/05 15:48:36  rich
C Increase maximum field length of distance and angle output in CIF from
C 10 to 12 characters. Otherwise it truncates to the left.
C
C Change the _atom_site_refinement_flags into three separate data items
C _atom_site_refinement_flags_posn, _atom_site_refinement_flags_adp and
C _atom_site_refinement_flags_occupancy.
C
C Revision 1.68  2003/11/04 16:14:01  rich
C If F000 is integer, output as integer.
C
C Revision 1.67  2003/11/04 15:58:26  rich
C 1) Move 'Sheldrick geometric definitions' to correct place
C in the CIF.
C
C 2) Values with esd of (10) no longer displayed as (1).
C
C 3) Very small esds now checked against ZEROSQ instead of ZERO.
C
C Revision 1.66  2003/11/03 10:42:38  rich
C Make \PARAM output a list of twin element scales if present,
C along with their ESD's. Also output to CIF, but using the
C _oxford prefix, as the twin data names aren't defined yet.
C
C Revision 1.65  2003/10/31 09:22:14  rich
C New #PARAM/LAYOUT parameter, 'ESD'. Yes by default, no causes esd
C calcs to be skipped, and L11 is not required.
C
C Revision 1.64  2003/10/22 10:01:49  djw
C New routine for decimal numbers in output tables. For H atoms without sus, 1 decimal point for angles, 2 for distances
C
C Revision 1.63  2003/09/10 21:18:28  djw
C Correct mis-formatting of Sheldrick weighting formula in .cifs
C
C Revision 1.62  2003/09/03 20:58:56  rich
C g77 compiler does not allow addressing of sections of array using string
C notation. Fixed.
C
C Revision 1.61  2003/07/01 16:43:34  rich
C Change IOR intrinsics to OR, similarly: IAND -> AND, INOT -> NOT. The "I"
C prefix is for INTEGER*2 (16 bit) types only, so could overflow when fed
C data from CRYSTALS' store. The unprefixed versions take any type and return
C the same type.
C
C Revision 1.60  2003/06/27 11:56:17  rich
C Add an atom_site_refinement_flags item to the atom list in the CIF. Use
C the data in the REF slot of list 5 to fill in the details.
C
C Revision 1.59  2003/06/26 09:09:05  djw
C Change P3 to P6 while thinking about other changes
C
C Revision 1.58  2003/06/24 13:01:04  djw
C Change SHELX weighting text to keep Acta happy
C
C Revision 1.57  2003/06/19 16:29:50  rich
C
C Store, in L30, the number of restraints that L16 is generating.
C
C Output, to the CIF, the _refine_ls_number_restraints for info.
C
C Revision 1.56  2003/05/27 10:24:04  djw
C Line over-run fixed.
C
C Revision 1.55  2003/05/23 15:00:14  djw
C Full expression for weigting schemes 14&15
C
C Revision 1.54  2003/05/07 12:18:55  rich
C
C RIC: Make a new platform target "WXS" for building CRYSTALS under Windows
C using only free compilers and libraries. Hurrah, but it isn't very stable
C yet (CRYSTALS, not the compilers...)
C
C Revision 1.53  2003/04/01 13:48:51  rich
C XTHLIM could go into an infinite loop in certain cases (certain cells?). Limit
C loops for optimising MAXH,K,L to 400 iterations.
C
C Revision 1.52  2003/03/25 14:02:35  rich
C Move DELRHOMIN/MAX back to their original locations in LIst 30.
C
C Revision 1.51  2003/02/20 16:05:21  rich
C Ridiculous number of changes - mainly additions apropos the HTML output.
C
C Revision 1.50  2003/02/19 13:35:25  djw
C Add Oxford Diffraction to list of known instruments for Jean Claude
C
C Revision 1.49  2003/02/17 13:28:43  djw
C Remove writes to .mon from FOURIER, save Rho and positions in LIST 30 CIFEXTRA (was in REFINEMENT), adjust output of 30
C
C Revision 1.48  2003/02/14 17:09:02  djw
C Extend codes to work wih list 6 and list 7.  Note that sfls, calc and
C recine have the parameter ityp06, which corresponds to the types
C pickedip for lists 6 and 7  from the command file
C
C Revision 1.47  2003/01/15 13:52:49  rich
C Remove all output to NCAWU.
C
C Fix return path for SPRT5P so that it doesn't try to print
C the overall parameters on the way out if there was an error.
C This occasionally crashed if you did a #PARAM without having
C an up-to-date LIST22.
C
C Revision 1.46  2003/01/14 10:20:49  rich
C Name clash in volume esd function fixed. (A).
C Escape backslashes in report of phi and omega scans.
C
C Revision 1.45  2002/12/03 13:55:48  rich
C Remove debugging statement.
C
C Revision 1.44  2002/11/07 17:35:13  rich
C THLIM upgraded so that it works. (With Friedel unmerged data and data
C that hasn't been SYSTEMATIC'd). It now also writes things to the listing
C file (missing reflection indices) and draws graphs.
C
C Revision 1.43  2002/11/06 12:58:22  rich
C If the theta_full value in L30 is negative, then the program will use its absolute
C value as theta_full and compute the completeness, rather than trying to find
C an optimum theta_full.
C
C Revision 1.42  2002/10/31 13:22:58  rich
C Some indenting to try to work out esd code.
C A DVF fix to fix compiler moan (consant passed as subroutine arg, then
C modified in subroutine).
C No calls to ZMORE allowed in DVF version.
C
C Revision 1.41  2002/10/07 11:03:06  rich
C EnCIFer compatibility.
C
C Revision 1.40  2002/08/30 14:36:15  richard
C Added pressure to L30. Only appears in CIF if non-zero.
C
C Revision 1.39  2002/07/22 14:37:31  Administrator
C Try to fix LIST 4 in cif
C
C Revision 1.38  2002/07/16 14:20:22  richard
C Fix format overflow when cell is bigger than 10,000 cubic Angstroms
C
C Revision 1.37  2002/07/15 13:14:29  richard
C For F000, use electron in cell count, as this is the SHELX standard, and while
C the CIF definition allows dispersive terms to be included, it only confuses
C referees.
C
C Revision 1.36  2002/07/15 12:04:36  richard
C Three things:
C F000 ignores F' and F'' if anomolous correction is off in L23 - awaiting confirmation
C from Ton about this.
C Call new code to work out completeness and theta_full.
C Put _chemical_absolute_configuration into the CIF during space group output.
C '.' for centro or 'unk' for non-centro. Leave it for the user to change if they
C think they've discovered something about the configuration.
C
C Revision 1.35  2002/06/07 16:01:59  richard
C Some things:
C
C (1) Tidied the CIF up, with spaces between groups of related items and that sort of thing.
C
C (2) Call XSFLSB at start to update L30 calc-R,Rw,sigma and number.
C
C (3) Calculate ZPRIME from L2 and L30 Z value, if L30 Z value is non-zero. Use this
C to give desired formula.
C
C (4) Quote three groups of R-factors: _ref, _all and _gt. The _gt threshold is the
C same as the L28 threshold if present, otherwise it is I>4u(I).
C
C Revision 1.34  2002/05/31 14:41:09  Administrator
C Update SHELX SPECIAL output
C
C Revision 1.33  2002/04/16 10:04:50  Administrator
C re-Fix atom types to be mixed case
C
C Revision 1.32  2002/04/12 13:52:02  Administrator
C Ensure refernce for absorption correction output
C
C Revision 1.31  2002/03/17 14:53:38  richard
C RIC: If refine_diff_density min or max are both within 0.000001 of 0.0, then
C replace with ? in the CIF file.
C
C Revision 1.30  2002/03/01 11:33:41  Administrator
C Correct and improve presntation of weighting scheme in .cif file
C
C Revision 1.29  2002/02/27 19:30:18  ckp2
C RIC: Increase lengths of lots of strings to 256 chars to allow much longer paths.
C RIC: Ensure consistent use of backslash after CRYSDIR:
C
C Revision 1.28  2002/01/14 12:11:45  Administrator
C Correct format of FLACK parameter output
C
C Revision 1.27  2001/12/14 16:56:53  ckp2
C Put cell volume su into CIF file. SU is based only on cell parameter esd's not full
C variance-covariance matrix but cifcheck can only use these too, so the results
C will tally.
C
C Revision 1.26  2001/09/26 11:36:50  Administrator
C No atom site type in summary file. CIF only.
C
C Revision 1.25  2001/09/11 11:19:16  ckp2
C In the Windows version, stop the CHAR(12) from printing in the PUNCH file.
C
C Revision 1.24  2001/09/07 14:24:54  ckp2
C CIF tidy.
C 1) Any writes directly to the CIF file (NCFPU1) are formatted so that
C the data lines up at column 35.
C 2) Any writes via the XPCIF subroutine are subject to the following rules:
C If there is a CIF dataname at the start of the line (an underscore) then any
C data following it is moved to column 35 provided that:
C a) There is some data there.
C b) This will not result in the data running past column 80.
C c) The CIF dataname is shorter than 35 characters.
C
C The CIF looks much easier to read as a result.
C
C Revision 1.23  2001/08/15 08:23:34  ckp2
C Two new scan types for LIST 30. Six new absorption correction types.
C (Currently these new types all store min+max in PSIMIN and PSIMAX).
C
C Revision 1.22  2001/08/09 07:29:40  ckp2
C It helps if _atom_site_type_symbol is uppercase for certain programs. (WinGX).
C
C Revision 1.21  2001/07/19 11:57:25  ckp2
C Add an _atom_site_type_symbol to CIF output.
C
C Make number format longer for torsion angle CIF output
C so that 3 digit negative numbers will not crash the program.
C
C Revision 1.20  2001/07/11 09:37:36  ckpgroup
C Move test for outputting absorption details
C
C Revision 1.19  2001/06/13 14:47:06  richard
C Tweak order of calculation so that List 5 always returns exactly the same
C molecular weight as List 29. (Number of multiplications reduced).
C
C Revision 1.18  2001/06/04 16:04:33  richard
C Fix display of su's in overall parameters in #PARA/END
C
C Revision 1.17  2001/04/11 15:27:18  CKP2
C Fix xsymop so that .CIF entries tally
C
C Revision 1.16  2001/03/28 12:46:13  CKP2
C DJW  Fix up site occupancies in LIST 5 part of cif output so that the
C effects of crystallogrpahic occupancy are explicitly removed. This is
C not explained in any CIFDIC, but is stated in current Notes for
C Authors.
C
C Revision 1.15  2001/03/09 10:29:24  richard
C Tweak to XPCIF to stop it crashing.
C
C Revision 1.14  2001/03/09 08:55:23  CKP2
C  Missed a call in XPCIF
C
C Revision 1.13  2001/03/05 17:29:01  CKP2
C Fix cif punching of character constants
C
C Revision 1.12  2001/03/02 17:04:34  CKP2
C More cif patches
C
C Revision 1.11  2001/02/27 18:15:52  CKP2
C DJW move call to PRC17 from PP5CO to calling routine because of clash
C with SELECT - probably due to incorrect use of STORE by something. List
C 2 in memeory was corrupt
C
C Revision 1.10  2001/02/26 09:49:59  richard
C Change log at top of file.
C
C
CODE FOR SPRT6P
      SUBROUTINE SPRT6P
C--MAIN ROUTINE FOR LIST 6P
C
C  NCOL   NUMBER OF COLUMNS PER PAGE
C  NLIN   NUMBER OF LINES PER PAGE
C  NSPAC  NUMBER OF SPACE AFTER EACH COLUMN
C  NSKIP  NUMBER OF CHARACTERS TO SKIP BEFORE THE FIRST COLUMN
C  SCALE5  THE SCALE FACTOR TO BE APPLIED TO /FC/.
C  IBAR    THE MAXIMUM NUMBER OF LINES PER PAGE.
C  LST    NUMBER OF CHARACTER PER COLUMN
C  LSTX   NUMBER OF CHARACTERS PER LINE
C  LW      THE NUMBER OF ENTRIES PER COLUMN.
C      L28SKP    USE (0) OR NOT USE (-1) LIST 28
C
C  Z       THE SCALE FACTOR FOR /FO/.
C  Y       THE CONVERSION FROM RADIANS TO DEGREES.
C
C  JA     START OF THE PAGE ASSEMBLY AREA
C  JB     ADDRESS OF THE LAST ENTRY IN THE PAGE ASSEMBLY AREA
C  JC     CURRENT ADDRESS IN THE PAGE ASSEMBLY AREA
C
C--FORMAT OF THE ASSEMBLY AREA :
C
C  0  TYPE OF ENTRY :
C      -1  BLANKS
C       0  NEW K,L PAIR
C       1  /FO/ENTRY
C  1  H  OR  K
C  2  /FO/ OR L
C  3  /FC/ OR NOT USED
C  4  PHASE OR NOT USED
C
C--
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCS.INC'
C
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XWORK.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XLISTI.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XIOBUF.INC'
C
      INCLUDE 'XLST01.INC'
      INCLUDE 'QSTORE.INC'
C
C--READ THE CONTROL DIRECTIVES AND SET UP THE DEFAULT VALUES
      IN = 0
      IF(JDIR6P(ITYP06))1850,1000,1000
C--LOAD LIST 5 AND FIND THE SCALE FACTOR
1000  CONTINUE
C--FIND THE TYPE OF LISTS   IULN IS USUALY 6
      IULN=KTYP06(ITYP06)
      CALL XRSL
      CALL XCSAE
      CALL XFAL01
C-- CHECK IF THERE IS A LIST 5 TO LOAD
      IF(KEXIST(5) .GE. 1 ) THEN
C--THERE IS A LIST 5  -  LOAD IT
        CALL XFAL05
        IF ( IERFLG .LT. 0 ) GO TO 1850
C--SET THE SCALE FACTOR
        Z = SCALE5 / STORE(L5O)
      ELSE
        Z = SCALE5
      ENDIF
      Y=360./TWOPI
C--SET UP LIST 6 FOR PROCESSING
      CALL XFAL06(IULN, 0)
      IF ( IERFLG .LT. 0 ) GO TO 1850
C--SET UP THE PAGE ASSEMBLY AREA
      JA=NFL
      LN=6
      IREC=6001
      JB=KCHNFL(NCOL*NLIN*LW)-LW
C--START OF THE REFLECTION FETCHING LOOP
      IF (L28SKP .EQ. -1) THEN
      IF(KLDRNR(1))1850,1050,1050
C--SET UP THE CURRENT K,L PAIR FLAGS
      ELSE
      IF (KFNR(0)) 1850, 1050, 1050
      ENDIF
1050  CONTINUE
      A=STORE(M6+1)
      B=STORE(M6+2)
C--SET THE END OF REFLECTION FLAG OFF
      JZ=0
C--SET THE NEW K,L PAIR FLAG ON
      JY=1
C--SET ALL THE ASSEMBLY FLAGS TO INDICATE BLANKS
1100  CONTINUE
      JC=JA
      DO 1150 I=JA,JB,LW
      ISTORE(I)=-1
1150  CONTINUE
C--SET UP THE PAGE CONTROL FLAGS
      JD=NLIN
      JE=NCOL
C--OUTPUT ONE BLANK LINE AT THE TOP OF EACH COLUMN
1200  CONTINUE
      IN=JBLAS(IN)
C--CHECK IF THIS IS A NEW K,L PAIR
1250  CONTINUE
      IF(JY)1300,1300,1450
C--K,L PAIR HAS NOT CHANGED  -  CHECK IF THIS IS THE TOP OF THE PAGE
1300  CONTINUE
      IF(NLIN-JD-1)1350,1350,1400
C--OUTPUT ONE BLANK LINE IN THIS COLUMN
1350  CONTINUE
      IF(JBLAS(IN))1550,1400,1550
C--STORE THE CURRENT H, /FO/ ETC.
1400  CONTINUE
      IF(JHFFS(IN))1850,1250,1550
C--K,L PAIR HAS JUST CHANGED  -  OUTPUT A BLANK LINE
1450  CONTINUE
      IF(JBLAS(IN))1550,1500,1550
C--STORE THE NEW K,L PAIR INFORMATION
1500  CONTINUE
      IF(JKLS(IN))1550,1350,1550
C--END OF A COLUMN  -  CHECK IF THIS THE END OF THE REFLECTIONS
1550  CONTINUE
      IF(JZ)1600,1600,1650
C--ONLY THE END OF A COLUMN  -  CHANGE COLUMNS
1600  CONTINUE
      JE=JE-1
      JD=NLIN
C--CHECK IF THERE ARE ANY MORE COLUMNS ON THIS PAGE
      IF(JE)1650,1650,1200
C--END OF THE PAGE  -  PRINT THE RESULTS
1650  CONTINUE
      CALL SPRINT
C--CHECK FOR THE END OF THE REFLECTION FETCHING LOOP
      IF(JZ)1100,1100,1700
C--END OF THE REFLECTIONS  -  EXIT
1700  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTRF .GT. 0 ) WRITE ( NCWU,'(A)' ) CHAR(12)
      ENDIF
#if !defined(_GID_) && !defined(_GIL_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      IF ( IPCHRF .GT. 0 ) WRITE ( NCPU ,'(A)' ) CHAR(12)
#endif
1720  CONTINUE
      CALL XOPMSG ( IOPPPR , IOPLSE , 6 )
      CALL XTIME2(2)
      RETURN
C
C--ERROR ROUTINES
1850  CONTINUE
C
C -- ERRORS
      CALL XOPMSG ( IOPPPR , IOPLSP , 6 )
      GO TO 1720
      END
C
CODE FOR JDIR6P
      FUNCTION JDIR6P(ITYP06)
C--READ DIRECTIVES FOR PRINT LIST 6P
C
C--RETURN VALUES OF 'JDIR6P' ARE :
C
C  -1  ERRORS FOUND.
C   0  ALL OKAY.
C
C   ITYP06 CODE FOR LIST TYPE 
C      1== 6
C      2== 7
C--
C
      PARAMETER(IPROCS=10)
      DIMENSION PROCS(IPROCS)
C
C
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'XPTCS.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XIOBUF.INC'
C
C
      EQUIVALENCE (PROCS(1),NCOL)
C
C--SET THE INITIAL RETURN VALUE
      JDIR6P=0
C--INITIALISE THE TIMING
      CALL XTIME1(2)
C--READ THE DIRECTIVES AND PARAMETERS
      IF (KRDDPV (PROCS, IPROCS) .LT. 0) GOTO 1150
C--DIRECTIVES INPUT OKAY  
C----- GET THE LIST TYPE
      ITYP06 =ILST
C  CALCULATE THE LINE LENGTH
      LST=18
      LW=5
      LSTX=NSKIP+NCOL*(LST+NSPAC)
C--SET UP THE MAXIMUM LINE LENGTH
      IBAR=IPAGE(3)
C--CHECK THE LINE LENGTH
      IF(IBAR-LSTX)1050,1200,1200
C--LINE LENGTH IS TOO LARGE
1050  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1100)IBAR
      WRITE ( CMON,1100) IBAR
      CALL XPRVDU(NCVDU, 1,0)
1100  FORMAT(' More than',I5,'  characters on a line')
C--ERROR EXIT FOR THIS ROUTINE
1150  CONTINUE
      JDIR6P=-1
1200  CONTINUE
      RETURN
      END
C
CODE FOR JBLAS
      FUNCTION JBLAS(IN)
C--STORE BLANK SPACE FOR ONE LINE IN THE CURRENT COLUMN
C
C--RETURN VALUES ARE :
C
C  0  OKAY
C  1  END OF COLUMN
C
C--
C
      INCLUDE 'XPTCS.INC'
      INCLUDE 'XWORKA.INC'
C
      IDWZAP = IN
      JBLAS=0
C--MOVE THE POINTER TO THIS COLUMN
      JC=JC+LW
      JD=JD-1
C--CHECK FOR THE END OF THE COLUMN
      IF(JD)1000,1000,1050
C--SET THE END OF COLUMN FLAG
1000  CONTINUE
      JBLAS=1
1050  CONTINUE
      RETURN
      END
C
CODE FOR JKLS
      FUNCTION JKLS(IN)
C--STORE THE NEW K,L PAIR INFORMATION
C
C--RETURN VALUES ARE :
C
C  0  OKAY
C  1  END OF COLUMN
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCS.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XLST06.INC'
C
      INCLUDE 'QSTORE.INC'
C
      IDWZAP = IN
      JKLS=0
C--CLEAR THE NEW K,L PAIR FLAG
      JY=0
C--STORE THE NEW INFORMATION
      ISTORE(JC)=0
      ISTORE(JC+1)=NINT(STORE(M6+1))
      ISTORE(JC+2)=NINT(STORE(M6+2))
      JC=JC+LW
      JD=JD-1
C--CHECK FOR THE END OF THIS COLUMN
      IF(JD)1000,1000,1050
1000  CONTINUE
      JKLS=1
1050  CONTINUE
      RETURN
      END
C
CODE FOR JHFFS
      FUNCTION JHFFS(IN)
C--STORE H INDEX, FO, FC AND PHASE
C
C--RETURN VALUES ARE :
C  0  OKAY
C  1  END OF REFLECTIONS, AND THUS END OF COLUMN
C
C--THIS ROUTINE IS RESPONSIBLE FOR FETCHING THE NEXT REFLECTION
C
C--
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCS.INC'
      INCLUDE 'XWORK.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XIOBUF.INC'
C
      INCLUDE 'QSTORE.INC'
C
C
#if defined (_HOL_)
      DATA IFO/2HFO/,IFC/2HFC/
#else
      DATA IFO/'FO'/,IFC/'FC'/
#endif
C
      IDWZAP = IN
      JHFFS=0
      ISTORE(JC)=1
      ISTORE(JC+1)=NINT(STORE(M6))
      F=STORE(M6+3)*Z
C--CHECK THAT /FO/ IS NOT TOO LARGE
      IF(9999.-F)1500,1000,1000
1000  CONTINUE
      ISTORE(JC+2)=NINT(F)
      F=STORE(M6+5)*SCALE5
C--CHECK THAT /FC/ IS NOT TOO LARGE
      IF(9999.-F)1550,1050,1050
1050  CONTINUE
      ISTORE(JC+3)=NINT(F)
      F=STORE(M6+6)*Y
      IF(F)1100,1150,1150
1100  CONTINUE
      F=F+360.
1150  CONTINUE
      ISTORE(JC+4)=NINT(F)
      JC=JC+LW
      JD=JD-1
      IF(JD)1200,1200,1250
1200  CONTINUE
      JHFFS=1
1250  CONTINUE
C--FETCH NEXT REFLECTION
      IF (L28SKP .EQ. -1) THEN
      IF(KLDRNR(1))1300,1350,1350
C--SET THE END OF REFLECTION FLAG
      ELSE
      IF (KFNR(0)) 1300, 1350, 1350
      ENDIF
1300  CONTINUE
      JZ=1
      JHFFS=1
      GOTO 1700
C--CHECK IF K HAS CHANGED
1350  CONTINUE
      IF(ABS(A-STORE(M6+1))-0.5)1400,1450,1450
C--CHECK IF L HAS CHANGED
1400  CONTINUE
      IF(ABS(B-STORE(M6+2))-0.5)1700,1450,1450
C--NEW K,L PAIR  -  SET THE FLAGS AND RETURN
1450  CONTINUE
      JY=1
      A=STORE(M6+1)
      B=STORE(M6+2)
      GOTO 1700
C
C--ERROR BECAUSE /FO/ IS TOO LARGE TO PRINT
1500  CONTINUE
      IT=IFO
      GOTO 1600
C--ERROR BECAUSE /FC/ IS TOO LARGE
1550  CONTINUE
      IT=IFC
C--PRINT THE ERROR MESSAGE
1600  CONTINUE
      JHFFS=-1
      CALL XERHDR(0)
      IF (ISSPRT .EQ. 0)
     1 WRITE(NCWU,1650)IT,F,STORE(M6),STORE(M6+1),STORE(M6+2)
      WRITE ( CMON, 1650)IT,F,STORE(M6), STORE(M6+1), STORE(M6+2)
      CALL XPRVDU(NCVDU, 1,0)
1650  FORMAT(' **** /',A2,'/ Greater then 9999 :',F12.0,
     2 '  for the reflection ',3F5.0,' ****')
1700  CONTINUE
      RETURN
      END
C
CODE FOR SPRINT
      SUBROUTINE SPRINT
C--PRINT LIST 6P
C
C
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
      DIMENSION LINEA(120)
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCS.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XCHARS.INC'
C
      INCLUDE 'QSTORE.INC'
C
      JC=JA-LW
      JF=LW*NLIN
      IF (ISSPRT .EQ. 0) THEN
      IF( ILSTRF .GT. 0) WRITE(NCWU, '(A)') CHAR(12)
      ENDIF
#if !defined(_GID_) && !defined(_GIL_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      IF( IPCHRF .GT. 0) WRITE(NCPU, '(A)') CHAR(12)
C--CLEAR THE PRINT LINE TO BLANKS
#endif
      CALL XMVSPD(IB,LINEA(1),LSTX)
      JD=0
C
C--PRINT THE NEXT LINE
1050  CONTINUE
      JL=NSKIP+NSPAC
      JE=0
1150  CONTINUE
C--CLEAR THE TEMP. LINE AREA
      CALL XMVSPD(IB,LIN(1),LST)
C--CHECK IF THIS IS THE FIRST LINE
      IF(JD)1200,1200,1250
C--SET UP THE HEADING
1200  CONTINUE
      CALL STEST
      GOTO 1400
C--CHECK THE TYPE OF THE NEXT ARGUMENT
1250  CONTINUE
      JG=JC+JF*JE
      IF(ISTORE(JG))1400,1300,1350
C--CHANGE OF KL PAIR
1300  CONTINUE
      CALL SKL(JG)
      GOTO 1400
C--SET UP /FO/ ETC.
1350  CONTINUE
      CALL SHFF(JG)
C--TRANSFER FROM TEMP. PERMANENT STORAGE
1400  CONTINUE
      CALL XMOVE(LIN(1),LINEA(JL),LST)
C--CHECK IF WE HAVE ALL THE COLUMNS
      JL=JL+NSPAC+LST
      JE=JE+1
      IF(NCOL-JE)1450,1450,1150
C--PRINT THE LINE
1450  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTRF .GT. 0 ) WRITE(NCWU,1500) (LINEA(I),I=1,LSTX)
      ENDIF
      IF ( IPCHRF .GT. 0 ) WRITE(NCPU,1500) (LINEA(I),I=1,LSTX)
1500  FORMAT(1X,160A1)
C--CHECK IF WE HAVE FINISHED THE PAGE
      JC=JC+LW
      JD=JD+1
      IF(NLIN-JD)1550,1050,1050
1550  CONTINUE
      RETURN
      END
C
CODE FOR STEST
      SUBROUTINE STEST
C--FORM THE TEST PARTIAL LINE
C
C
      DIMENSION IH(7)
C
C
      INCLUDE 'XPTCS.INC'
C
C
#if defined (_HOL_)
      DATA IH(1)/1HH/
      DATA IH(2)/1HF/
      DATA IH(3)/1HO/
      DATA IH(4)/1HC/
      DATA IH(5)/1HP/
      DATA IH(6)/1H//
      DATA IH(7)/1HI/
#else
      DATA IH(1)/'H'/
      DATA IH(2)/'F'/
      DATA IH(3)/'O'/
      DATA IH(4)/'C'/
      DATA IH(5)/'P'/
      DATA IH(6)/'/'/
      DATA IH(7)/'I'/
#endif
C
      LIN(4)=IH(1)
      LIN(6)=IH(6)
      LIN(7)=IH(2)
      LIN(8)=IH(3)
      LIN(9)=IH(6)
      LIN(11)=IH(6)
      LIN(12)=IH(2)
      LIN(13)=IH(4)
      LIN(14)=IH(6)
      LIN(16)=IH(5)
      LIN(17)=IH(1)
      LIN(18)=IH(7)
      RETURN
      END
C
CODE FOR SKL
      SUBROUTINE SKL(IN)
C--FORM THE K L PARTIAL LINE
C
      INCLUDE 'ISTORE.INC'
C
      DIMENSION IHKL(3)
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCS.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XWORKA.INC'
C
      INCLUDE 'QSTORE.INC'
C
C
#if defined (_HOL_)
      DATA IHKL(1)/1HK/
      DATA IHKL(2)/1HL/
      DATA IHKL(3)/1H=/
#else
      DATA IHKL(1)/'K'/
      DATA IHKL(2)/'L'/
      DATA IHKL(3)/'='/
#endif
C
      LIN(1)=IA
      LIN(2)=IA
      LIN(4)=IHKL(1)
      LIN(5)=IHKL(3)
      IND=ISTORE(IN+1)
      J=8
      CALL SUBALF(J,IND,LIN)
      LIN(11)=IHKL(2)
      LIN(12)=IHKL(3)
      IND=ISTORE(IN+2)
      J=15
      CALL SUBALF(J,IND,LIN)
      LIN(17)=IA
      LIN(18)=IA
      RETURN
      END
C
CODE FOR SHFF
      SUBROUTINE SHFF(IN)
C--FORM THE H,FO,FC,PHASE PARTIAL LINE
C
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCS.INC'
C
      INCLUDE 'QSTORE.INC'
C
      IND=ISTORE(IN+1)
      J=4
      CALL SUBALF(J,IND,LIN)
      IND=ISTORE(IN+2)
      J=9
      CALL SUBALF(J,IND,LIN)
      IND=ISTORE(IN+3)
      J=14
      CALL SUBALF(J,IND,LIN)
      IND=ISTORE(IN+4)
      J=18
      CALL SUBALF(J,IND,LIN)
      RETURN
      END
C
CODE FOR SPRT5P
      SUBROUTINE SPRT5P
C--PRINT LIST 5P
C
C  IFIR    THE NUMBER OF BLANKS AT THE START OF EACH LINE.
C  MINX    THE FIRST LINE ON A PAGE TO BE USED TO PRINT COORDS.
C  MINU    THE FIRST LINE ON A PAGE TO BE USED TO PRINT U[IJ].
C  LINEX   THE LAST LINE PLUS ONE ON A PAGE USED TO PRINT COORDS.
C  LINEU   THE LAST LINE PLUS ONE ON A PAGE USED TO PRINT U[IJ].
C  NSTA    THE NUMBER OF CHARACTERS FOR THE TYPE AND SERIAL NUMBER.
C  NXF     NUMBER OF CHARACTERS FOR THE TOTAL COORD. FIELD.
C  NXD     NUMBER OF CHARACTERS AFTER THE DECIMAL POINT FOR COORDS.
C  NUF     NUMBER OF CHARACTERS FOR THE TOTAL U[IJ] FIELD.
C  NUD     NUMBER OF CHARACTERS AFTER THE DECIMAL POINT FOR U[IJ].
C  NOP     DECIMAL POINT INDICATOR :
C          0  PARAMETERS CONTAIN A DECIMAL POINT.
C          1  PARAMETERS DO NOT CONTAIN A DECIMAL POINT.
C
C  NAP     DOUBLE LINE SPACING INDCIATOR :
C
C          -1  SINGLE LINE SPACING.
C           0  DOUBLE LINE SPACING.
C
C  ICC     CHOOSE INDICATOR :
C
C           1  SYSTEM DOES NOT CHOOSE THE NUMBER OF SIGNIFICANT FIGURES.
C          -1  SYSTEM CHOOSES THE NUMBER OF SIGNIFICANT FIGURES TO PRINT
C
C  IBAR    THE LINE WIDTH.
C
C      ISELCO      SELECTION FUNCTION FOR COORDINATES :-
C
C            1      ALL
C            2      NONE
C            3      ONLY
C            4      EXCLUDE
C            5      SEPARATE
C
C      TYPECO      TYPE USED IN SELECTION OF COORDINATES. '    '
C                  INDICATES 'MATCH ALL'
C
C      ISELAN , TYPEAN      AS ABOVE BUT CONTROL SELECTION OF U'S
C
C      IDSPCO , IDSPAN      CONTROL WHETHER COORDS. / ANISO T.F.'S
C                           ARE DISPLAYED ON MONITOR CHANNEL
C
C      LSTAXS      CONTROL PRINTING BY 'XPRAXI'
C            0      NO PRINT
C            1      PRINT
C
C      IPESD - whether to print ESD's 0=NO, 1=YES, 2=EXCLUDING RIDING H
C
C
C
C--
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST11.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XLST23.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XAPK.INC'
C
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'QSTORE.INC'
C
      DATA IPPSEP / 5 / , IPPNBT / 1 /
C--READ THE INPUT DIRECTIVES
      IN = 0
      IF (  JDIR5P ( IN )  .LT.  0  ) GO TO 9910
C--INPUT WENT OKAY  -  CLEAR THE CORE AGAIN
      CALL XRSL
      CALL XCSAE
C--LOAD A FEW LISTS
      CALL XFAL01
      CALL XFAL05
      CALL XFAL23
cdjwfeb2001
        toler = store(l23sp+5)
        call xprc17 (0, 0, TOLER, -1)
cdjwfeb2001
      IF ( IPESD .NE. 0 ) THEN     !FORM THE ABSOLUTE LIST 12
        JQ=0
        JS=1
        CALL XFAL12(JS,JQ,JR,JN)
        IF ( IERFLG .LT. 0 ) GO TO 2450
C--LINK LISTS 5 AND 12
        I=KSET52(0,-1)
        IF ( IERFLG .LT. 0 ) GO TO 2450
C--BRING DOWN THE MATRIX
        CALL XFAL11(1,1)
        IF (IERFLG .LT. 0) GOTO 2450
        AMULT=STORE(L11P+17)/STORE(L11P+16)
      END IF
      IBASE=NFL
      JBASE = IBASE
      K = KCHNFL ( 4 * N5)
C----- WORK SPACE FOR SAPPLY - THAT CHECKS WE DONT RUN INTO LFL
      JS = NFL
C----- SET AUXILLIARY LIST 5 ADDRESSES
      L5A=L5
      N5A=N5
      MD5A=MD5
      M5A=L5
      CALL XPRAXI( 1, 1, JBASE, L5A, MD5A, N5A, LSTAXS, 0, 0)
      IF ( IERFLG .LT. 0 ) GO TO 2450
C -- PRINT TYPE / SERIAL / X / Y / Z / U[ISO]
C
      IUIJ = 0
C -- DETERMINE WHICH SETS OF COORDS MUST BE PRINTED
      CALL XPPSEL ( ISELCO , TYPECO , ISEL , TYPE )
C -- CALL ROUTINE TO PRINT COORDS. TWO CALLS FOR 'SEPARATE'
      CALL XPP5CO ( ISEL , TYPE )
      IF ( ISELCO .EQ. IPPSEP ) CALL XPP5CO ( IPPNBT , TYPECO )
      IF ( IERFLG .LT. 0 ) GO TO 2450
C
      IF ( IUIJ .LE. 0 ) GO TO 2270
C
C -- PRINT TYPE / SERIAL / U'IJS
C
      CALL XPPSEL ( ISELAN , TYPEAN , ISEL , TYPE )
      CALL XPP5AN ( ISEL , TYPE )
      IF ( ISELAN .EQ. IPPSEP ) CALL XPP5AN ( IPPNBT , TYPEAN )
      IF ( IERFLG .LT. 0 ) GO TO 2450
2270  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
        IF(ILSTCO .GT. 0) WRITE(NCWU,'(A)')CHAR(12)
      ENDIF
#if !defined(_GID_) && !defined(_GIL_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      IF(IPCHCO .EQ. 1) WRITE(NCPU,'(A)')CHAR(12)
C
C----- OUTPUT THE OVERALL PARAMETERS
#endif
      MCFUNC = 1
      CALL XPP5OV(MCFUNC)
C----- OUTPUT THE TWIN SCALE PARAMETERS
      CALL XPP5TW(MCFUNC)
CRIC0103 - Exit path - don't output parameters after errors - might be no L12.
2300  CONTINUE
      CALL XOPMSG ( IOPPPR , IOPLSE , 5 )
      CALL XTIME2 ( 2 )
      RETURN
C
2450  CONTINUE
      CALL XOPMSG ( IOPPPR , IOPLSP , 5 )
      GO TO 2300
9910  CONTINUE
      CALL XOPMSG ( IOPPPR , IOPCMI , 0 )
      GO TO 2450
C
      END
C
CODE FOR JDIR5P
      FUNCTION JDIR5P(IN)
C--READ DIRECTIVES FOR PRINT LIST 5P
C
C--RETURN VALUES OF 'JDIR5P' ARE :
C
C  -1  ERRORS.
C   0  ALL OKAY.
C
C--
C
      INCLUDE 'TSSCHR.INC'
      PARAMETER (LPROCS = 27)
      DIMENSION PROCS(LPROCS)
C
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XIOBUF.INC'
C
C
      EQUIVALENCE (PROCS(1),IFIR)
C
      IDWZAP = IN
C--SET THE INITIAL RETURN VALUE
      JDIR5P=0
C--INITIALISE THE TIMING
      CALL XTIME1(2)
C--READ THE DIRECTIVES
      IF (  KRDDPV ( PROCS , LPROCS )  .LT.  0  ) GO TO 1150
C--CHECK THE WIDTH OF A COORD. PAGE
      LSTX=NSTA+NXF*3+NUF
      IF(IBAR-LSTX-IFIR)1050,1200,1200
C--FIELD WIDTH IS WRONG
1050  CONTINUE
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1100)IBAR
      WRITE ( CMON, 1100) IBAR
      CALL XPRVDU(NCVDU, 1,0)
1100  FORMAT(' More than',I5,'  characters on a line')
C--GENERAL ERRORS
1150  CONTINUE
      JDIR5P=-1
      GOTO 1400
C--CHECK THE WIDTH OF AN ANISO PAGE
1200  CONTINUE
      LSTX=NSTA+NUF*6
      IF(IBAR-LSTX-IFIR)1050,1250,1250
C--SET UP THE NUMBER OF LINES PER PAGE
1250  CONTINUE
      LINEX=  NPLINE
      LINEU=  NPLINE
C--SET THE FLAG FOR THE FIRST COORD. LINE ON A PAGE
      MINX=5
C--SET THE FLAG FOR THE FIRST U[IJ] LINE, ASSUMING A4 ACROSS
      MINU=11
C--CHECK IF AN ANISO PAGE WILL FIT DOWN AN A4 PAGE
      IF(LSTX-68)1300,1300,1350
C--THIS WILL FIT DOWN AN A4 PAGE
1300  CONTINUE
      MINU=MINX
      LINEU=LINEX
C--SET THE FIELD WIDTH FLAGS
1350  CONTINUE
      NXD=ISIGN(NXD,ICC)
      NUD=ISIGN(NUD,ICC)
C----- IF COORDDS IN CIF FORMAT, SO ALSO ANISO
      IF (IPCHCO .EQ. 2)  IPCHAN = 2
1400  CONTINUE
      RETURN
      END
C
C
C
CODE FOR XPPSEL
      SUBROUTINE XPPSEL ( ISELCM , TYPECM , ISELRQ , TYPERQ )
C
C -- SELECT ON THE BASIS OF THE COMMAND GIVEN THE SELECTION
C    PARAMETERS. ISELCM AND TYPECM ARE THE VALUES DERIVED FROM THE
C    COMMAND PROCESSOR.
C    ISELRQ AND TYPERQ ARE THE VALUES THAT SHOULD BE PASSED TO XPP5CO
C
      INCLUDE 'XOPVAL.INC'
C
      EQUIVALENCE (IALATM,ALLATM)
      SAVE IALATM
#if !defined(_HOL_) 
      DATA IALATM / '    ' /
#else
      DATA IALATM /4H     /
#endif
      DATA IPPNBT / 1 / , IPPABT / 2 /
C
      TYPERQ = TYPECM
C
      GO TO ( 1100 , 1200 , 1300 , 1400 , 1500 , 9910 ) , ISELCM
      GO TO 9910
C
1100  CONTINUE
C -- 'ALL'
      TYPERQ = ALLATM
      ISELRQ = IPPNBT
      GO TO 8000
1200  CONTINUE
C -- 'NONE'
      TYPERQ = ALLATM
      ISELRQ = IPPABT
      GO TO 8000
1300  CONTINUE
C -- 'ONLY'
      ISELRQ = IPPNBT
      GO TO 8000
1400  CONTINUE
C -- 'EXCLUDE'
      ISELRQ = IPPABT
      GO TO 8000
1500  CONTINUE
C -- 'SEPARATE'
      ISELRQ = IPPABT
      GO TO 8000
C
8000  CONTINUE
      RETURN
C
9910  CONTINUE
      CALL XOPMSG ( IOPCRY , IOPINT , 0 )
      RETURN
      END
C
C
C
CODE FOR XPP5CO
      SUBROUTINE XPP5CO ( IFUNC , TYPE )
C -- PUBLICATION PRINT OF COORDINATES SELECTED FROM LIST 5 ON THE BASIS
C    OF 'IFUNC' AND 'TYPE'
C
C      IFUNC : -
C      1      'NONE BUT'      ATOM MUST MATCH 'TYPE' TO BE PRINTED
C      2      'ALL BUT'       ATOM MUST NOT MATCH 'TYPE' TO BE PRINTED
C
C      'TYPE' IS THE TYPE OF ATOM TO BE PRINTED. THE VALUE '    ' WILL
C      MATCH EVERY ATOM ( I.E. ALL BUT , '    ' WOULD PRINT NOTHING )
C
C
C      IDSPHD      0      NO HEADING PRINTED ON MONITOR CHANNEL
C                  1      HAS BEEN PRINTED
C
C      NL                 NUMBER OF LINES PRINTED. INITIALLY SET AT
C                         END OF PAGE.
C
      CHARACTER CLINE *160, CTEM *4, CHTML*20, CSGRD*4, CTU*2, CP*1
      character cspec *7
      CHARACTER CASDA*4, CASDG*4
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      DIMENSION LINEC(118), KDEV(4)
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST11.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XLST23.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XAPK.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'XSSCHR.INC'
      INCLUDE 'XFLAGS.INC'
C
      INCLUDE 'QSTORE.INC'
C
      LOGICAL LHFIXD(3)
C
      EQUIVALENCE (IALATM,ALLATM)
      SAVE IALATM
#if !defined(_HOL_) 
      DATA IALATM / '    ' /
#else
      DATA IALATM /4H     /
#endif
      SAVE KHYD 
      SAVE KDET 
#if !defined(_HOL_) 
      DATA KHYD /'H   '/
      DATA KDET /'D   '/
#else
      DATA KHYD /4HH   /
      DATA KDET /4HD   /
C
C
#endif
CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)
C -- SET INITIAL VALUES.
cdjw feb2001
        iupdat = istore(l23sp+1)
        toler = store(l23sp+5)
C
      IDSPHD = 0
      M5=L5
      M12=L12
      M5A=L5+2
      NL=LINEX

C
C----- CAPTIONS FOR CIF FILE
      IF (IPCHCO .EQ. 2) THEN
        IF (ISSUEQ .EQ. 1) THEN
          WRITE(NCFPU1, 890)
890       FORMAT(/
     1 '# Uequiv = arithmetic mean of Ui i.e. Ueqiv = (U1+U2+U3)/3')
        ELSE
          WRITE(NCFPU1, 891)
891       FORMAT(/
     1 '# Uequiv = geometric mean of Ui i.e. Ueqiv = (U1*U2*U3)**1/3')
        ENDIF

        WRITE(NCFPU1,903)
903    FORMAT(/'# Replace last . with number of unfound hydrogen',
     1 ' atoms attached to an atom.')

        WRITE(NCFPU1,904)
904     FORMAT(/'# ..._refinement_flags_... ',/
     1 '# . no refinement constraints',T41,
     2 'S special position constraint on site' ,/
     3 '# G rigid group refinement of site' ,T41,
     4 'R riding atom' ,/
     5 '# D distance or angle restraint on site' ,T41,
     6 'T thermal displacement constraints' ,/
     7 '# U Uiso or Uij restraint (rigid bond)' ,T41,
     8 'P partial occupancy constraint'/)

        WRITE( NCFPU1, 900)
900     FORMAT ( /'loop_'/'_atom_site_label'/'_atom_site_type_symbol'/
     1 '_atom_site_fract_x'/
     1 '_atom_site_fract_y'/'_atom_site_fract_z')
        IF (ISSUEQ .EQ. 1) THEN
          WRITE(NCFPU1, '(A)') '_atom_site_U_iso_or_equiv'
        ELSE
          WRITE(NCFPU1, '(A)') '_atom_site_U_equiv_geom_mean'
        ENDIF
        WRITE( NCFPU1, 902)
902     FORMAT ('_atom_site_occupancy'/
     1 '_atom_site_adp_type'  /
     1 '_atom_site_refinement_flags_posn'  /
     1 '_atom_site_refinement_flags_adp'  /
     1 '_atom_site_refinement_flags_occupancy'  /
     1 '_atom_site_disorder_assembly'  /
     1 '_atom_site_disorder_group'  /
cdjwapr2010     1 '_oxford_atom_site_special_shape' /
     2 '_atom_site_attached_hydrogens' )

      ELSE IF (IPCHCO .EQ. 3) THEN    !HEADERS FOR HTML TABLE

        WRITE (NCPU,'(''<H2>Parameters</H2>'')')
        WRITE( NCPU, 910)
910     FORMAT ('<FONT SIZE="-1"><TABLE BORDER="1"><TR>',
     1  '<TD align="center">Label</TD>',/,
     1  '<TD align="center"><em>x</em></TD>',/,
     2  '<TD align="center"><em>y</em></TD>',/,
     3  '<TD align="center"><em>z</em></TD>')
        IF (ISSUEQ .EQ. 1) THEN
          WRITE(NCPU, '(A)')
     1     '<TD align="center">U<sub>iso/equiv</sub></TD>'
        ELSE
          WRITE(NCPU, '(A)') 
     1     '<TD align="center">U<sub>iso/equiv(geometric)</sub></TD>'
        ENDIF
        WRITE( NCPU, 911)
911     FORMAT ('<TD align="center">Occupancy</TD></TR>')
      ENDIF

      iuij = 0
C--LOOP OVER THE ATOMS
      DO K=1,N5
C--CALCULATE THE E.S.D.'S AND STORE THEM IN BPD
        MD5A=M5+NKA-1
        N5A=NKA-2
cdjw99[
c      U=STORE(M5+3)
C -- SET ANISO ATOMS FLAG IF APPROPRIATE
c      IF ( ABS(U) .LT. UISO ) IUIJ = 1
cdjw99]
C -- CHECK FOR MATCH
        MATCH = -1
        IF ( TYPE .EQ. STORE(M5) ) MATCH = 1
        IF ( TYPE .EQ. ALLATM ) MATCH = 1
        IF ( IFUNC .EQ. 2 ) MATCH = -MATCH
        IF ( MATCH .LE. 0 ) GO TO 1585
C
cdjw99[
C-C-C-USE OF ISOTROPIC T-FACTOR INSTEAD OF PURE FLAG
c        BUFF(2)=STORE(M5+7)
cdjw99]
C----- J IS DUMMY
        IF ( IPESD .NE. 0 ) THEN
          CALL SAPPLY (J)
        ELSE
          DO JXF=1,11
            BPD(JXF)=0.0
          END DO
        END IF
C--CLEAR THE OUTPUT BUFFER
        CALL XMVSPD(IB,LINEA(1),118)
        J=IFIR
CDJW0402 CONVERT ATOM NAME TO MIXED CASE
        WRITE(CTEM,'(A4)') ISTORE(M5)
        CALL XCCLWC (CTEM(2:), CTEM(2:))
        READ (CTEM,'(A4)') ISTORE(M5)
        IF (IPCHCO .EQ. 3) THEN  
          WRITE(CHTML,'(A4,I6)') ISTORE(M5),NINT(STORE(M5+1))
          CALL XCCLWC (CHTML(2:), CHTML(2:))
          CALL XCRAS(CHTML,NHTML)
          WRITE(NCPU,912)CHTML(1:NHTML)
912       FORMAT('<TR><TD>',A,'</TD>')
        END IF
C--OUTPUT THE TYPE AND SERIAL NUMBER
        CALL SA41(J,ISTORE(M5),LINEA)
        IND=NINT(STORE(M5+1))
        IBUFF=ISTORE(M5)
        JBUFF=IND
        CALL SUBZED(J,IND,LINEA,IPCHCO)
C-C-C-OUTPUT THE FLAG OF ATOM
cnov98      CALL SNUM(STORE(M5+3),0.0,1,0,10,LINEA)
C--UPDATE THE CURRENT POSITION FLAG
        J=MAX(J+1,IFIR+NSTA) ! Don't overwrite big numbers.
c        J=IFIR+NSTA
C--RIC01 Add in atom_site_type_symbol
        IF (IPCHCO .EQ. 2) CALL SA41(J,ISTORE(M5),LINEA)
C--SET UP THE FLAGS FOR THE PASS OVER THE COORDS.
        MP=M5+4
        MPD=3
        IP=3
C--LOOP OVER THE COORDS.
        DO L=1,3
C-DJW-APR-04
C Check if riding H ESD to be omitted                      
        IF ( ( AND(ISTORE(M5+15),KBREFB(3)).GT.0 ) .AND.                 
     1  ((ISTORE(M5).EQ.KHYD).OR.(ISTORE(M5).EQ.KDET)) )THEN              
          IF (IPESD .eq. 2) BPD(MPD) = 0.0                                               
        ENDIF
C
          LOJ = J+6
          J=J+NXF
c          WRITE(123,*)NXF
          CALL SNUM(STORE(MP),BPD(MPD),NXD,NOP,J,LINEA)
          IF (IPCHCO .EQ. 3) THEN  
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
            WRITE(CHTML,'(80A1)') LINEA(LOJ:J+4)
#else
            WRITE(CHTML,'(80A1)') (LINEA(JR),JR=LOJ,J+4)
c            CALL XCRAS(CHTML,NHTML)
#endif
            WRITE(NCPU,913)CHTML(1:)
913         FORMAT('<TD>',A,'</TD>')
          END IF
          BUFF(IP)=STORE(MP)
          IP=IP+1
          MP=MP+1
          MPD=MPD+1
        END DO
cdjw99[
C--CHECK IF THIS ATOM IS ANISO OR ISO
        cspec = 'error'
        if (nint(store(m5+3)) .eq. 0) then
c----- aniso
C----- CALCULATE U[EQUIV]
          CTEM = 'Uani'
          cspec = '.'
          BUFF(2)= STORE(JBASE)
C----- SET ESD=0.
          BPD(2)=0.
C----- INDICATE THAT THERE ARE SOME U[ANISO] TO PRINT
          IUIJ=1
1150      CONTINUE
        else if (nint(store(m5+3)) .eq. 1) then
          CTEM = 'Uiso'
          cspec = '.'
          BUFF(2)= STORE(m5+7)
          bpd(2) = bpd(6)
        else if (nint(store(m5+3)) .eq. 2) then
          CTEM = 'Uiso'
          cspec = 'Sphere'
          BUFF(2)= STORE(m5+7)
          bpd(2) = bpd(6)

        else if (nint(store(m5+3)) .eq. 3) then
          CTEM = 'Uiso'
          cspec = 'Rod'
          BUFF(2)= STORE(m5+7)
          bpd(2) = bpd(6)


        else if (nint(store(m5+3)) .eq. 4) then
          CTEM = 'Uiso'
          cspec = 'Annulus'
          BUFF(2)= STORE(m5+7)
          bpd(2) = bpd(6)

        else
         ctem ='none'

        endif
        JBASE = JBASE + 4
        LOJ = J+6
        J=J+NUF
C----- PRINT THE ISO OR EQUIV TEMPERATURE FACTOR
        CALL SNUM(BUFF(2),BPD(2),NUD,NOP,J,LINEA)
        IF (IPCHCO .EQ. 3) THEN
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
          WRITE(CHTML,'(80A1)') LINEA(LOJ:J+4)
#else
          WRITE(CHTML,'(80A1)') (LINEA(JR),JR=LOJ,J+4)
c          CALL XCRAS(CHTML,NHTML)
#endif
          WRITE(NCPU,913)CHTML(1:)
        END IF
cdjw99]
C----- GET THE OCCUPANCY
        LOJ = J+6
        J = J + NUF
        CALL XMOVE (LINEA, LINEC, 118)
cdjwmar2001 - Notes for Authors - dont include crystallographic
c             occupancy contribution - keep code for future
        if (iupdat .ge.0) then
c            w = store(m5+2)*store(m5+13)
            w = store(m5+2)
        else
            w = store(m5+2)/store(m5+13)
        endif
        CALL SNUM ( W, BPD(1), NUD, NOP, J, LINEC)
        IF (IPCHCO .EQ. 3) THEN  
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
          WRITE(CHTML,'(80A1)') LINEC(LOJ:J+4)
#else
          WRITE(CHTML,'(80A1)') (LINEC(JR),JR=LOJ,J+4)
c          CALL XCRAS(CHTML,NHTML)
#endif
          WRITE(NCPU,913)CHTML(1:)//'</TR>'
        END IF
C-C-C-SET OCC TO BE PRINTED ON SCREEN AFTER \PARAMETERS-COMMAND
C-C-C-(NOT IN CONTEXT WITH SPECIAL ATOMS, NEXT LINE MAY BE DELETED)
        BUFF(1)=W
        IF ( ABS (1.0 - W) .GT. ZERO) THEN
          CALL SNUM ( W, BPD(1), NUD, NOP, J, LINEA)
        ENDIF
C-C-C-OUTPUT THE FLAG OF ATOM
cdjwnov98      CALL SNUM(STORE(M5+3),0.0,1,0,(IFIR+9),LINEA)
C--CHECK FOR DOUBLE SPACING
1200    CONTINUE
        IF(NAP)1300,1250,1250
C--PRINT THE BLANK LINE
1250    CONTINUE
        IF (ISSPRT .EQ. 0) THEN
          IF ( ILSTCO .GT. 0 ) WRITE ( NCWU , 1550 )
        ENDIF
        IF ( IPCHCO .GT. 0 ) WRITE ( NCPU , 1550 )
        NL=NL+1
C--CHECK FOR THE END OF A PAGE
1300    CONTINUE
        IF(NL-LINEX)1500,1350,1350
C--END OF THE PAGE  -  START A NEW PAGE
1350    CONTINUE
        IF (ISSPRT .EQ. 0) THEN
          IF ( ILSTCO .GT. 0 ) WRITE( NCWU , '(A)') CHAR(12)
        ENDIF
#if !defined(_GID_) && !defined(_GIL_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      IF ( IPCHCO .EQ. 1 ) WRITE(NCPU, '(A)') CHAR(12)
#endif
        CALL STATX(LINEB)
        CALL STXYZ(LINEB)
        IF (ISSPRT .EQ. 0) THEN
          IF ( ILSTCO .GT. 0 ) WRITE( NCWU ,1450) LINEB
        ENDIF
        IF (IPCHCO .EQ. 1) THEN
          CLINE = ' '
          WRITE(CLINE,'(160A1)' ) LINEB
          CALL XCTRIM (CLINE,NCHAR)
          WRITE(NCPU,'(//A/)') CLINE(1:NCHAR)
1450      FORMAT (2X,118A1)
        ENDIF
        NL=MINX
        GOTO 1200
C--PRINT THE CURRENT LINE
1500    CONTINUE
        IF (ISSPRT .EQ. 0) THEN
          IF ( ILSTCO .GT. 0 ) WRITE( NCWU ,1550) LINEA
        ENDIF
        CLINE = ' '
        IF (IPCHCO .EQ. 1) THEN
C----- ORDINARY PUNCH LISTING
            WRITE(CLINE,'(160A1)') LINEA
            IST = KCCNEQ (CLINE, 1, ' ')+1
            CALL XCCLWC (CLINE(IST:), CLINE(IST:))
            CALL XCTRIM (CLINE,NCHAR)
            WRITE(NCPU,'(A)') CLINE(1:NCHAR)
        ELSE IF (IPCHCO .EQ. 2) THEN
C----- CIF PUNCH LISTING

C Work out the _atom_site_refinement_flags_posn for this atom.
            NSGRD = 0
            WRITE(CSGRD(1:1),'(A)') '.'  ! Default is '.'
            DO MFLG = 4,1,-1
              IF ( AND (KBREFB(MFLG),ISTORE(M5+15)) .GT. 0 ) THEN
                NSGRD=NSGRD+1
                WRITE(CSGRD(NSGRD:NSGRD),'(A1)')KBCIFF(MFLG:MFLG)
              END IF
            END DO
            NSGRD = MAX(NSGRD,1)  ! Ensure at least one char is printed
C Work out the _atom_site_refinement_flags_adp for this atom.
            NSGTU = 0
            WRITE(CTU(1:1),'(A)') '.'  ! Default is '.'
            DO MFLG = 5,6
              IF ( AND (KBREFB(MFLG),ISTORE(M5+15)) .GT. 0 ) THEN
                NSGTU=NSGTU+1
                WRITE(CTU(NSGTU:NSGTU),'(A1)')KBCIFF(MFLG:MFLG)
              END IF
            END DO
            NSGTU = MAX(NSGTU,1)  ! Ensure at least one char is printed
C Work out the _atom_site_refinement_flags_occupancy for this atom.
            WRITE(CP(1:1),'(A)') '.'  ! Default is '.'
            IF ( AND (KBREFB(7),ISTORE(M5+15)) .GT. 0 ) THEN
              WRITE(CP(1:1),'(A)') 'P' 
            END IF
            CALL PRTGRP(ISTORE(M5+14),IPRT,IGRP,1)
            WRITE(CASDA(1:1),'(A)') '.' !Atom site disorder assembly
            NASDA = 1
            IF ( IGRP .NE. 0 .AND. ABS (IGRP) .LE. 999
     1                       .AND. ABS (IPRT) .LE. 999) THEN
               WRITE(CASDA,'(I4)') IGRP
               NASDA = 4
            END IF
            WRITE(CASDG(1:1),'(A)') '.' !Atom site disorder group
            NASDG = 1
            IF ( IPRT .NE. 0 .AND. ABS(IGRP) .LE. 999
     1                       .AND. ABS(IPRT) .LE. 999 ) THEN
               WRITE(CASDG,'(I4)') IPRT
               NASDG = 4
            END IF
C
            WRITE(CLINE,'(160A1)') LINEC
C Ensure second character of element type is lowercase.
C RIC01 Find second space in string:
            ISTRIC = MAX(1,KCCEQL(CLINE,1,' '))+1
            ISTRIC = MAX(1,KCCNEQ(CLINE,ISTRIC,' '))+1
            IST    = MAX(1,KCCEQL(CLINE,ISTRIC,' '))
C            IST = KCCNEQ (CLINE, 1, ' ')+1
            CALL XCCLWC (CLINE(IST:), CLINE(IST:))
            CALL XCTRIM (CLINE,NCHAR)
            CLINE(NCHAR+1:NCHAR+4) = CTEM
            CALL XCREMS( CLINE, CLINE, NCHAR)
            WRITE(CLINE(NCHAR+1:),'(6(1X,A))') 
     1      CSGRD(1:NSGRD),CTU(1:NSGTU),CP,CASDA(1:NASDA),
     2      CASDG(1:NASDG)
            CALL XCREMS( CLINE, CLINE, NCHAR)
            write(cline(nchar+1:),'(3(1x,a))')
cdjwapr10     1      cspec(1:),'.'
     1      '.'
            CALL XCREMS( CLINE, CLINE, NCHAR)
            WRITE(NCFPU1,'(A)') CLINE(1:NCHAR)
        ENDIF
1550    FORMAT(2X,118A1)
        NL=NL+1
C -- DISPLAY ON MONITOR CHANNEL IF REQUIRED.
        IF ( IDSPCO .LE. 0 ) GO TO 1585
        IF ( IDSPHD .GT. 0 ) GO TO 1570
        WRITE ( CMON  , 1581 )
        CALL XPRVDU(NCVDU, 1,0)
        IDSPHD = 1
1570    CONTINUE
        WRITE ( CMON  , 1582 ) IBUFF , JBUFF , BUFF
        CALL XPRVDU(NCVDU, 1,0)
1581    FORMAT ( 1X , 'Type' , 4X , 'Serial' , 8X , 'Occ' , 5X ,
     2 'U(iso)' , 9X , 'Coordinates' )
1582    FORMAT ( 1X , A4 , 4X , I6 , 4X , 5 ( F8.4 , 2X ) )
C
1585    CONTINUE
C -- UPDATE THE ATOM INFORMATION FOR THE NEXT ATOM
        IF (IPESD .NE. 0 ) M12=ISTORE(M12)
        M5=M5+MD5
        M5A=M5A+MD5
      END DO
      IF ( IPCHCO .EQ. 3 ) WRITE(NCPU,'(''</TABLE></FONT>'')')

      CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)

      RETURN
      END


CODE FOR XPP5AN
      SUBROUTINE XPP5AN ( IFUNC , TYPE )
C
C
C -- PUBLICATION PRINT OF U'IJS SELECTED FROM LIST 5 ON THE BASIS
C    OF 'IFUNC' AND 'TYPE'
C
C      IFUNC : -
C      1      'NONE BUT'      ATOM MUST MATCH 'TYPE' TO BE PRINTED
C      2      'ALL BUT'       ATOM MUST NOT MATCH 'TYPE' TO BE PRINTED
C
C      'TYPE' IS THE TYPE OF ATOM TO BE PRINTED. THE VALUE '    ' WILL
C      MATCH EVERY ATOM ( I.E. ALL BUT , '    ' WOULD PRINT NOTHING )
C
      DIMENSION KDEV(4)
c----- nspbuf - a buffer for special shape lines
      parameter (nspbuf=5)
cdjwapr10      character *84 cspbuf(nspbuf)
      character *94 cspbuf(nspbuf)
      character *8 cshape(3)
      CHARACTER *160 CLINE
      CHARACTER *4 CTEM
      CHARACTER *20 CHTML
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST11.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XAPK.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'XSSCHR.INC'
C
      INCLUDE 'QSTORE.INC'
C
      EQUIVALENCE (IALATM,ALLATM)
      SAVE IALATM
#if !defined(_HOL_) 
      DATA IALATM / '    ' /
#else
      DATA IALATM /4H     /
C
#endif
cdjwapr10
      cshape(1)=' Sphere'
      cshape(2)=' Rod'
      cshape(3)=' Annulus'
c
1450  FORMAT ( // , 2X , 118A1 )
1460  FORMAT(15X,A6,6X,A4,8X,A5,7X,A5)
1550  FORMAT ( 2X , 118A1 )
C
CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)
c----- clear the special shape buffer
      jspbuf = 0
      do 1, j=1,nspbuf
      cspbuf(j)(:) = ' '
1     continue

      M5=L5
      IF ( IPESD .NE. 0 ) M12=L12
      M5A=L5+2
C--INDICATE THAT WE HAVE JUST OUTPUT A PAGE
      NL=LINEU
      IDSPHD = 0
C----- CAPTIONS FOR CIF FILE
      IF (IPCHAN .EQ. 2) THEN
        WRITE( NCFPU1, 900)
900     FORMAT ('loop_'/'_atom_site_aniso_label'/
     1 '_atom_site_aniso_U_11'/'_atom_site_aniso_U_22'/
     2 '_atom_site_aniso_U_33'/'_atom_site_aniso_U_23'/
     3 '_atom_site_aniso_U_13'/'_atom_site_aniso_U_12' )
      ELSE IF (IPCHAN .EQ. 3) THEN    !HEADERS FOR HTML TABLE

        WRITE (NCPU,'(''<H2>Thermal Parameters</H2>'')')
        WRITE( NCPU, 910)
910     FORMAT ('<FONT SIZE="-1"><TABLE BORDER="1"><TR>',
     1  '<TD align="center">Label</TD>',/,
     1  '<TD align="center">U<sub>11<sub></TD>',/,
     1  '<TD align="center">U<sub>22<sub></TD>',/,
     1  '<TD align="center">U<sub>33<sub></TD>',/,
     1  '<TD align="center">U<sub>23<sub></TD>',/,
     1  '<TD align="center">U<sub>13<sub></TD>',/,
     1  '<TD align="center">U<sub>12<sub></TD>')
      ENDIF
C
C--LOOP OVER THE ATOMS
C
      DO 2250 K=1,N5
      MD5A=M5+NKA-1
      N5A=NKA-2
C--CHECK IF THIS ATOM HAS AN ANISO TEMPERATURE FACTOR
C-C-C-CHECK IF THIS ATOM HAS AN ANISO T.F. OR A SPECIAL PARAMETER
      U=STORE(M5+3)
C      IF ( ABS(U) .GE. UISO ) GO TO 2200
C-C-C-THE LAST STATEMENT MIGHT CAUSE DIFFICULTIES WITH DATA OF OLD
C-C-C-FORMAT ! IN THIS CASE USE THE FOLLOWING:
C      IF ((ABS(U) .GE. UISO) .AND. (ABS(NINT(U)) .LT. 2.0)) GO TO 2200
      iflag = ABS(NINT(U))
      IF ( iflag .eq. 1 ) GO TO 2200
C -- CHECK FOR MATCH
      MATCH = -1
      IF ( TYPE .EQ. STORE(M5) ) MATCH = 1
      IF ( TYPE .EQ. ALLATM ) MATCH = 1
      IF ( IFUNC .EQ. 2 ) MATCH = - MATCH
      IF ( MATCH .LE. 0 ) GO TO 2200
C
C--CALCULATE THE E.S.D.'S
C--CLEAR THE LINE BUFFER
C----- J IS DUMMY
      IF ( IPESD .NE. 0 ) THEN
        CALL SAPPLY (J)
      ELSE
        DO JXF = 1,11
          BPD(JXF) = 0.0
        END DO
      END IF
      CALL XMVSPD(IB,LINEA(1),118)
C--OUTPUT THE ATOM TYPE AND SERIAL NUMBER
      J=IFIR
CDJW0402 CONVERT ATOM NAME TO MIXED CASE
      WRITE(CTEM,'(A4)') ISTORE(M5)
      CALL XCCLWC (CTEM(2:), CTEM(2:))
      READ (CTEM,'(A4)') ISTORE(M5)
C
      CALL SA41(J,ISTORE(M5),LINEA)
      IND=NINT(STORE(M5+1))
      CALL SUBZED(J,IND,LINEA, IPCHAN)
c      J=IFIR+NSTA
      J=MAX(J+1,IFIR+NSTA) ! Don't overwrite big numbers.

      IF (IPCHCO .EQ. 3) THEN  
          WRITE(CHTML,'(A4,I6)') ISTORE(M5),NINT(STORE(M5+1))
          CALL XCCLWC (CHTML(2:), CHTML(2:))
          CALL XCRAS(CHTML,NHTML)
          WRITE(NCPU,912)CHTML(1:NHTML)
912       FORMAT('<TR><TD>',A,'</TD>')
      END IF
C-C-C-OUTPUT THE FLAG OF ATOM
cnov98      CALL SNUM(STORE(M5+3),0.0,1,0,(IFIR+9),LINEA)
C--LOOP OVER THE PARAMETERS
      MP=M5+7
      MPD=6
      if (iflag .eq. 0) then
            ll = 6
      else if (iflag .eq. 2) then
            ll = 2
      else if (iflag .eq. 3) then
            ll = 4
      else if (iflag .eq. 4) then
            ll = 4
      endif
      DO 1750 L=1,ll
      LOJ = J + 6
      J=J+NUF
      CALL SNUM(STORE(MP),BPD(MPD),NUD,NOP,J,LINEA)
      IF (IPCHCO .EQ. 3) THEN  
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
          WRITE(CHTML,'(80A1)') LINEA(LOJ:J+4)
#else
          WRITE(CHTML,'(80A1)') (LINEA(JR),JR=LOJ,J+4)
#endif
          WRITE(NCPU,913)CHTML(1:)
913       FORMAT('<TD>',A,'</TD>')
      END IF

      MP=MP+1
      MPD=MPD+1
1750  CONTINUE

      if (iflag .ge. 2) then
c---- save special shape
            if (jspbuf .lt. nspbuf) then
                  jspbuf = jspbuf + 1
                  write(cspbuf(jspbuf)(:),'(i1,80a1)')
     1            iflag, (linea(jr), jr=1,80)
            else
                   write(cmon,'(a)') 'Too many special shapes'
                   call xprvdu(ncvdu, 1,0)
            endif
            goto 2200
      endif

      IF ( IPCHAN .EQ. 3 ) WRITE(NCPU,'(''</TR>'')')
C--CHECK FOR DOUBLE SPACING
1800  CONTINUE
      IF(NAP)1900,1850,1850
C--WRITE THE BLANK LINE
1850  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTAN .GT. 0 ) WRITE( NCWU ,1550)
      ENDIF
      IF ( IPCHAN .GT. 0 ) WRITE(NCPU,1550)
      NL=NL+1
C--CHECK FOR THE END OF THE PAGE
1900  CONTINUE
      IF(NL-LINEU)2150,1950,1950
C--NEW PAGE
1950  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTAN .GT. 0 ) WRITE( NCWU , '(A)') CHAR(12)
      ENDIF
#if !defined(_GID_) && !defined(_GIL_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      IF ( IPCHAN .EQ. 1 ) WRITE(NCPU, '(A)') CHAR(12)
#endif
      CALL STATX(LINEB)
      CALL STUIJ(LINEB)
      IF(MINX-MINU)2000,2100,2000
2000  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
C      IF ( ILSTAN .GT. 0 ) WRITE( NCWU ,2050) LINEB
       IF ( ILSTAN .GT. 0 ) THEN
        WRITE( NCWU ,2050) LINEB
        WRITE( NCWU ,1460) 'U(iso)','Size','D/100','A/100'
       ENDIF
      ENDIF
      IF ( IPCHAN .EQ. 1 ) THEN
        CLINE = ' '
        WRITE(CLINE,'(160A1)') LINEB
        IST = KCCNEQ (CLINE, 1, ' ')+1
        CALL XCCLWC (CLINE(IST:), CLINE(IST:))
        CALL XCTRIM (CLINE,NCHAR)
        WRITE(NCPU,'(//A)') CLINE(1:NCHAR)
        WRITE(NCPU,1460) 'U(iso)','Size','D/100','A/100'
        write(ncpu,'(1x)')
      ENDIF
2050  FORMAT(2X,118A1)
      NL=MINU
      GOTO 1800
2100  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
       IF ( ILSTAN .GT. 0 ) THEN
        WRITE( NCWU ,1450) LINEB
        WRITE(NCWU,1460) 'U(iso)','Size','D/100','A/100'
       ENDIF
      ENDIF
      IF ( IPCHAN .EQ. 1 ) THEN
        CLINE = ' '
        WRITE(CLINE,'(160A1)') LINEB
        IST = KCCNEQ (CLINE, 1, ' ')+1
        CALL XCCLWC (CLINE(IST:), CLINE(IST:))
        CALL XCTRIM (CLINE,NCHAR)
        WRITE(NCPU,'(A)') CLINE(1:NCHAR)
       IF ( ILSTAN .GT. 0 ) THEN
        WRITE( NCWU ,1450) LINEB
        WRITE(NCWU,1460) 'U(iso)','Size','D/100','A/100'
       ENDIF
      ENDIF
      NL=MINU
      GOTO 1800
C--PRINT THE CURRENT LINE
2150  CONTINUE
      IF (ISSPRT .EQ. 0) THEN
      IF ( ILSTAN .GT. 0 ) WRITE( NCWU ,1550) LINEA
      ENDIF
      IF ( IPCHAN .GE. 1 ) THEN
        CLINE = ' '
        WRITE(CLINE,'(160A1)') LINEA
        IST = KCCNEQ (CLINE, 1, ' ')+1
        CALL XCCLWC (CLINE(IST:), CLINE(IST:))
        CALL XCTRIM (CLINE,NCHAR)
      ENDIF
      IF ( IPCHAN .EQ. 1 ) THEN
        WRITE(NCPU,'(A)') CLINE(1:NCHAR)
      ELSE IF (IPCHAN .EQ. 2) THEN
        CALL XCREMS( CLINE, CLINE, NCHAR)
        WRITE(NCFPU1,'(A)') CLINE(1:NCHAR)
      ENDIF
      NL=NL+1
C -- DISPLAY ON MONITOR CHANNEL IF REQUIRED.
      IF ( IDSPAN .LE. 0 ) GO TO 2200
      IF ( IDSPHD .GT. 0 ) GO TO 2170
      WRITE ( CMON , 2172 )
      CALL XPRVDU(NCVDU, 1,0)
      IDSPHD = 1
2170  CONTINUE
      JBUFF = NINT ( STORE(M5+1) )
      WRITE ( CMON , 2173 ) STORE(M5) , JBUFF ,
     2 ( STORE(J) , J =  M5+7 , M5+12 )
      CALL XPRVDU(NCVDU, 1,0)
2172  FORMAT ( 1X , 'Type' , 4X , 'Serial' , 16X , 'U(II)''s' , 24X ,
     2 'U(IJ)''s' )
2173  FORMAT ( 1X , A4 , 4X , I6 , 4X , 6 ( F8.4 , 2X ) )
C
2200  CONTINUE
      IF ( IPESD .NE. 0 ) M12=ISTORE(M12)
      M5=M5+MD5
      M5A=M5A+MD5
C
2250  CONTINUE
      MD5A=MD5
      IF ( IPCHAN .EQ. 3 ) WRITE(NCPU,'(''</TABLE></FONT>'')')
c
c     
      if ((ipchan .eq. 2) .and. (jspbuf .gt. 0)) then
c--- write special shapes to cif file
        write(ncfpu1,3000)
3000    format(/ 
     1  '# special_uiso is a measure of the thickness of the shape'/
     2  '# special_size is the length of the line'/
     3  '# or the radius of the annulus or sphere'/
     4  '# special_declination and azimuth define the direction'/
     5  '# of the line or normal to the annulus'/
     6  '# Because CHECKCIF rejects occupancies greater than unity'/
     7  '# it will generate incorrect formulae, and derived values')
        WRITE( NCFPU1, 3001)
3001    FORMAT ('loop_'/
     1 '_oxford_atom_site_label'/
     2 '_oxford_atom_site_special_uiso'/
     2 '_oxford_atom_site_special_size'/
     3 '_oxford_atom_site_special_declination'/
     4 '_oxford_atom_site_special_azimuth'/
     4 '_oxford_atom_site_special_shape')
c
        do 3100 j = 1,jspbuf
        read(cspbuf(j), '(i1,a)') iflag,cmon(1)
        call xctrim(cmon(1), nchar)
        if (iflag .eq. 2) write(cmon(1)(nchar+1:),'(a)') ' . . '
        call xcrems(cmon(1), cmon(1), nchar)
        write(cmon(1)(nchar+1:),'(a8)') cshape(iflag-1)(:)
        call xcrems(cmon(1), cmon(1), nchar)
        write(ncfpu1,'(a)') cmon(1)(1:nchar)
3100    continue

      endif

C
      CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)
      RETURN
      END
C
C
CODE FOR XPP5OV
      SUBROUTINE XPP5OV ( IFUNC  )
C -- PUBLICATION PRINT OF OVERALL PARAM SELECTED FROM LIST 5
C    ON THE BASIS OF 'IFUNC'
C
C      IFUNC : -
C      1      OVERALL PARAMETERS
C      2      NOT YET USED
C
C
C
C      IDSPHD      0      NO HEADING PRINTED ON MONITOR CHANNEL
C                  1      HAS BEEN PRINTED
C
C      NL                 NUMBER OF LINES PRINTED. INITIALLY SET AT
C                         END OF PAGE.
C
      DIMENSION KDEV(4)
      CHARACTER *80 CTEMP
      CHARACTER *76 CREFMK

      CHARACTER *80 CLINE
      CHARACTER *80 CFORM, CBUF
      CHARACTER *10 COVER(6)
      CHARACTER *32 CCIF(2)
      INCLUDE 'TSSCHR.INC'
C
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST11.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XOPK.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'XSSCHR.INC'
C
      INCLUDE 'QSTORE.INC'
C
      DATA COVER / 'Scale  ', 'Du(iso) ', 'Ou(iso) ',
     2  'Polarity', 'Flack  ', 'Extinction'/
C
      DATA CCIF /
     3      '_refine_ls_extinction_coef','_oxford_refine_ls_scale' /
C
#if !defined(_GID_) && !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      IFUNC = IFUNC
CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
#endif
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)
C -- SET INITIAL VALUES.
      NOD = -3
      NOF = 10
C
      M5 = L5O
      M5A = L5O
      M12 = L12O
      NL = LINEX
C
C--CALCULATE THE E.S.D.'S AND STORE THEM IN BPD
      MD5A = M5+NKO-1
      N5A = NKO
C
      JP = 1
      IF ( IPESD .NE. 0 ) THEN
        CALL XPESD ( 1, JP)
      ELSE
        CALL XZEROF (BPD, 11)
      END IF
C
C--CLEAR THE OUTPUT BUFFER
      CALL XMVSPD(IB,LINEA(1),118)
      J=4
C--SET UP THE FLAGS FOR THE PASS OVER THE PARAMETERS
      MP=M5A
      MPD=1
      IP=1
C--LOOP OVER THE PARAMETERS
      DO 2050 L=1,N5A
      J = J + NOF
      CALL SNUM(STORE(MP), BPD(MPD), NOD, 0, J, LINEA)
      IP=IP+1
      MP=MP+1
      MPD=MPD+1
2050  CONTINUE
      WRITE (CLINE,2055) (LINEA(L), L=1,78)
2055  FORMAT(2X,78A1)
      CALL XCTRIM (CLINE, NLINE)
C----- BUILD UP A FORMAT STATEMENT
      WRITE (CFORM, 2410) NOF, NOF
2410  FORMAT( '(' ,I4, 'X, 6A',I4, ')' )
      IF (ISSPRT .EQ. 0) THEN
        IF ( ILSTCO .GT. 0 )  THEN
            WRITE( NCWU, CFORM) COVER
            WRITE( NCWU , '(A)') CLINE(1:NLINE)
        ENDIF
      ENDIF
      IF ( IPCHCO .EQ. 1 )  THEN
            WRITE(NCPU, CFORM) COVER
            WRITE( NCPU , '(A)') CLINE(1:NLINE)
      ELSE IF (IPCHCO .EQ. 2) THEN
C----- CIF OUTPUT OF EXTINCTION
            MP = L5O+5
C--       CLEAR THE OUTPUT BUFFER
            CALL XMVSPD(IB,LINEA(1),118)
            J = 15
C----- CHECK FOR ESD PRESENT, OR NON-INTEGER VALUE
            IF (((ABS(BPD(6)) .GT. ZERO)) .OR.
     1      (ABS(NINT(STORE(MP))-STORE(MP)) .GT. ZERO) ) THEN
             CALL SNUM(STORE(MP), BPD(6), NOD, 0, J, LINEA)
             WRITE(CBUF, '(2X,32A1)') (LINEA(J),J=1,32)
             CALL XCTRIM (CBUF, N)
             WRITE (CLINE, '(A,A)') CCIF(1), CBUF(1:N)
             CALL XCREMS ( CLINE, CLINE, N)
             WRITE(NCFPU1, '(/A)') CLINE(1:N)
             WRITE(NCFPU1,2556)
2556        FORMAT ('_refine_ls_extinction_method ', /,4X,
     1      '''Larson (1970), Equation 22''')
            ELSE
              WRITE(NCFPU1,2557)
2557        FORMAT (/'_refine_ls_extinction_method ', /,4X,'''None''')
            ENDIF
C----- CIF OUTPUT OF SCALE
            MP = L5O
C--    CLEAR THE OUTPUT BUFFER
            CALL XMVSPD(IB,LINEA(1),118)
            J = 15
C----- CHECK FOR ESD PRESENT, OR NON-INTEGER VALUE
            CALL SNUM(STORE(MP), BPD(1), NOD, 0, J, LINEA)
            WRITE(CBUF, '(2X,32A1)') (LINEA(J),J=1,32)
            CALL XCTRIM (CBUF, N)
            WRITE (CLINE, '(A,A)') CCIF(2), CBUF(1:N)
            CALL XCREMS ( CLINE, CLINE, N)
            WRITE(NCFPU1, '(A)') CLINE(1:N)
      ENDIF
C -- DISPLAY ON MONITOR CHANNEL
      WRITE ( CMON , 2560 )
      CALL XPRVDU(NCVDU, 1,0)
      WRITE ( CMON , CFORM) COVER
      CALL XPRVDU(NCVDU, 1,0)
      WRITE ( CMON , 2561 )( STORE(I), I = M5A, M5A+N5A-1),
     1 (BPD(I), I=1,6)
      CALL XPRVDU(NCVDU, 2,0)
2560  FORMAT (/,' Over-all Parameters')
2561  FORMAT ( 6X, 6F10.3)
C
      RETURN
9910  CONTINUE
      WRITE ( CMON, '(A)') 'ERROR in overall parameter print'
      CALL XPRVDU(NCVDU, 1,0)
      RETURN
      END

CODE FOR XPP5TW
      SUBROUTINE XPP5TW ( IFUNC )
C -- PUBLICATION PRINT OF OVERALL PARAM SELECTED FROM LIST 5
C    ON THE BASIS OF 'IFUNC'
C
C      IFUNC : -
C      1      TWIN SCALE PARAMETERS
C      2      NOT YET USED
C
C      IDSPHD      0      NO HEADING PRINTED ON MONITOR CHANNEL
C                  1      HAS BEEN PRINTED
C
C      NL                 NUMBER OF LINES PRINTED. INITIALLY SET AT
C                         END OF PAGE.
C
      DIMENSION KDEV(4)
      CHARACTER *80 CLINE
      CHARACTER *80 CFORM, CBUF
      INCLUDE 'TSSCHR.INC'
C
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST11.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XOPK.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'XSSCHR.INC'
C
      INCLUDE 'QSTORE.INC'
C
C
C
#if !defined(_GID_) && !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      IFUNC = IFUNC

#endif
      IF ( MD5ES .EQ. 0 ) RETURN

CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)
C -- SET INITIAL VALUES.
      NOD = -3

      NOF = 10

      M5 = L5ES
      M5A = L5ES
      M12 = L12ES
      MD5A = MD5ES
      N5A = N5ES

      NL = LINEX

C--CALCULATE THE E.S.D.'S AND STORE THEM IN BPD

      JP = 1
      IF ( IPESD .NE. 0 ) THEN
        CALL XPESD ( 2, JP)
      ELSE
        CALL XZEROF (BPD, 11)
      END IF

C
C--CLEAR THE OUTPUT BUFFER
      CALL XMVSPD(IB,LINEA(1),118)
      J=4
C--SET UP THE FLAGS FOR THE PASS OVER THE PARAMETERS
      MP=M5A
      MPD=1
      IP=1

2410  FORMAT (1X,'Twin element scales')
      IF (ISSPRT .EQ. 0) THEN
        IF ( ILSTCO .GT. 0 )  THEN
            WRITE( NCWU, 2410)
        END IF
      END IF
      IF ( IPCHCO .EQ. 1 )  THEN
            WRITE(NCPU, 2410)
      ELSE IF (IPCHCO .EQ. 2) THEN
            WRITE(NCFPU1,2557)
2557        FORMAT(/,'loop_',/,4X,'_oxford_twin_element_scale_factors')
      END IF
      WRITE ( CMON , 2410 )
      CALL XPRVDU(NCVDU, 1,0)

C--LOOP OVER THE PARAMETERS
      DO L=1,MD5A
C--CLEAR THE OUTPUT BUFFER
        CALL XMVSPD(IB,LINEA(1),118)
        J= 4 + NOF
        CALL SNUM(STORE(MP), BPD(MPD), NOD, 0, J, LINEA)
        IP=IP+1
        MP=MP+1
        MPD=MPD+1

        WRITE (CLINE,'(2X,78A1)') (LINEA(KL), KL=1,78)
        CALL XCTRIM (CLINE, NLINE)

        IF ( (ISSPRT .EQ. 0) .AND. ( ILSTCO .GT. 0 ) ) THEN
            WRITE( NCWU , '(A)') CLINE(1:NLINE)
        ENDIF

        IF ( IPCHCO .EQ. 1 )  THEN
            WRITE( NCPU , '(A)') CLINE(1:NLINE)
        ELSE IF (IPCHCO .EQ. 2) THEN
            WRITE( NCFPU1 , '(A)') CLINE(1:NLINE)
        ENDIF

        WRITE ( CMON , '(A)' ) CLINE(1:NLINE)
        CALL XPRVDU(NCVDU, 1,0)
      END DO


      RETURN
9910  CONTINUE
      WRITE ( CMON, '(A)') 'ERROR in twin scale parameter print'
      CALL XPRVDU(NCVDU, 1,0)
      RETURN
      END
C
C
CODE FOR XPESD
      SUBROUTINE XPESD (ITYPE, ISTART)
C
C----- COMPUTE PARAMETER ESDS FOR A COMPLETE RECORD
C      ITYPE RECORD TYPE 1 = OVERALL
C                        2 = ATOM
C      ISTART             START ADDRESS IN RECORD FOR FIRST VARIABLE
C                        1 FOR OVERALL
C                       -1 FOR ATOMS (ITEMS -1 AND 0 ARE TYPE AND SERIAL
C
C  JS  SET ON ENTRY FOR WORK SPACE
c
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST11.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XOPK.INC'
      INCLUDE 'XIOBUF.INC'
C
      INCLUDE 'QSTORE.INC'
C
      CALL XZEROF (BPD, 11)
      L12A = ISTORE(M12+1)
      IF (L12A .GT. 0) THEN
        MD12A=ISTORE(L12A+1)
        JU=ISTORE(L12A+2)
        JV=ISTORE(L12A+3)
        JT=ISTORE(L12A+4)         !Number unrefined at start of record
cdjw JAN 2013. offset needed when SCALE not refined
        JP = ISTART + JT
C--SEARCH FOR THE CONTRIBUTIONS TO EACH PARAMETER IN TURN
        DO JW=JU,JV,MD12A
          IF(ISTORE(JW))1800,1800,1200
1200  CONTINUE
          JX=JW
          JY=L12A
          JR=JS
          JZ=0
C--CHECK IF THIS PART FOR THIS PARAMETER HAS BEEN REFINED
1250  CONTINUE
          IF(ISTORE(JX))1550,1550,1300
C--ADD THE CONTRIBUTIONS INTO THE STACK
1300  CONTINUE
          IF ( ( JR+4 )  .GE.   LFL ) GOTO 9910
          ISTORE(JR)=ISTORE(JX)
          ISTORE(JR+2)=KBLCK(ISTORE(JR))
          ISTORE(JR+1)=M12B
          STORE(JR+3)=1.
          IF(ISTORE(JY+1)-1)1450,1500,1450
1450  CONTINUE
          STORE(JR+3)=STORE(JX+1)
1500  CONTINUE
          JR=JR+4
          JZ=JZ+1
C--CARRY ONTO THE NEXT PART
1550  CONTINUE
          JY=ISTORE(JY)
          IF(JY)1700,1700,1600
C--MOVE ONTO THE NEXT PART
1600  CONTINUE
          JX=ISTORE(JY+2)+ISTORE(JY+1)*(JT-ISTORE(JY+4))
          IF(JX-ISTORE(JY+2))1550,1250,1650
1650  CONTINUE
          IF(ISTORE(JY+3)-JX)1550,1250,1250
1700  CONTINUE
          IF(JZ)1800,1800,1750
C--CALCULATE THE E.S.D.
1750  CONTINUE
          BPD(JP)=XVAR(JS,JZ,4,JR)
          IF ( IERFLG .LT. 0 ) GO TO 9900
          IF(BPD(JP) .LT. 0.0 ) THEN
            IF (ITYPE .EQ. 1 ) THEN
              IF (ISSPRT .EQ. 0)
     1        WRITE(NCWU,1770) STORE(M5), STORE(M5+1), BPD(JP)
              WRITE ( CMON, 1770) STORE(M5), STORE(M5+1), BPD(JP)
              CALL XPRVDU(NCVDU, 1,0)
1770  FORMAT(1X,' Negative e.s.d for atom ',A4,F6.0,F12.10)
            ELSE
              IF (ISSPRT .EQ. 0)
     1        WRITE(NCWU,1771) JP, BPD(JP)
              WRITE ( CMON, 1771) JP, BPD(JP)
              CALL XPRVDU(NCVDU, 1,0)
1771  FORMAT(1X,' Negative e.s.d for overall parameter ',
     1 I6, F12.10)
            ENDIF
            BPD(JP) = 0.0
          ENDIF
1790  CONTINUE
          BPD(JP)=SQRT(BPD(JP)*AMULT)
1800  CONTINUE
          JT=JT+1
          JP=JP+1
        END DO
      ENDIF
      GOTO 9999
9900  CONTINUE
9910  CONTINUE
      WRITE ( CMON,'(A)') ' Error computing parameter e.s.d '
      CALL XPRVDU(NCVDU, 1,0)
9999  CONTINUE
      RETURN
      END
C
C
C
CODE FOR XVAR
      FUNCTION XVAR(LS,NS,NW,LF)
C--CALCULATE THE VARIANCE FROM THE PARAMETERS IN THE GIVEN STACK
C
C  LS  ADDRESS OF THE FIRST WORD OF THE STACK
C  NS  NUMBER OF ENTRIES IN THE STACK
C  NW  NUMBER OF WORDS PER STACK ENTRY
C  LF  ADDRESS OF THE NEXT FREE LOCATION THAT MAY BE USED
C
C--FORMAT OF THE STACK :
C
C  0  LEAST SQUARES PARAMETER NUMBER
C  1  ADDRESS OF THE BLOCK INFORMATION FOR THIS PARAMETER
C  2  ADDRESS OF THE DIAGONAL ELEMENT FOR THIS PARAMETER
C  3  COEFFICIENT FOR THIS PARAMETER
C
C--THIS PATTERN IS REPEATED 'NS' TIMES STARTING FROM 'LS' EVERY 'NW' WOR
C  'LF' IS THE FIRST FREE LOCATION  -  USED FOR WORK SPACE
C  WORK SPACE IS NS*NS+2*NS
C
C--
      INCLUDE 'TYPE11.INC'
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XSTR11.INC'
      INCLUDE 'XERVAL.INC'
C
      INCLUDE 'QSTORE.INC'
      INCLUDE 'QSTR11.INC'
C
C--SET UP A FEW POINTERS
      N=LS
      IA=LF
      L=LF+NS*NS
C--CHECK THE CORE
      IF ( L + NS + NS - LFL )  1050 , 1050 , 9910
1050  CONTINUE
      IB=L
C--FORM THE VARIANCE-COVARIANCE MATRIX
      DO 1500 I=1,NS
      K=ISTORE(N+2)
C--STORE THE DIAGONAL ELEMENTS
      STORE(IA)=STR11(K)
      STORE(IB)=STORE(N+3)
      IB=IB+1
C--CHECK IF THIS IS THE LAST PARAMETER
      IF(I-NS)1100,1550,1550
1100  CONTINUE
      IC=IA+NS
      IA=IA+1
      ID=I+1
      M=N+NW
C--SET UP THE OFF-DIAGONAL TERMS
      DO 1450 J=ID,NS
C--CHECK IF THE TWO PARAMETERS ARE IN THE SAME BLOCK
      IF(ISTORE(N+1)-ISTORE(M+1))1150,1200,1150
C--SET UP ZERO COVARIANCES FOR PARAMETERS IN DIFFERENT BLOCKS
1150  CONTINUE
      STORE(IA)=0.0
      STORE(IC)=0.0
      GOTO 1400
C--COMPUTE THE ADDRESS OF THE OFF-DIAGONAL TERM IN THE L.S. MATRIX
1200  CONTINUE
      K=ISTORE(N)-ISTORE(M)
      IF(K)1250,1250,1300
1250  CONTINUE
      K=ISTORE(N+2)-K
      GOTO 1350
1300  CONTINUE
      K=ISTORE(M+2)+K
1350  CONTINUE
      STORE(IA)=STR11(K)
      STORE(IC)=STR11(K)
1400  CONTINUE
      M=M+NW
      IA=IA+1
      IC=IC+NS
1450  CONTINUE
      IA=IA+I
      N=N+NW
1500  CONTINUE
1550  CONTINUE
C--PERFORM THE CALCULATIONS
      I=L+NS
      CALL XMLTMM(STORE(LF),STORE(L),STORE(I),NS,NS,1)
      CALL XMLTTM(STORE(L),STORE(I),STORE(LF),1,NS,1)
      XVAR=STORE(LF)
      RETURN
C
9900  CONTINUE
C -- ERRORS
      XVAR = 0
      RETURN
9910  CONTINUE
C -- CORE OVERFLOW
      CALL XICA
      CALL XERHND ( IERERR )
      GO TO 9900
C
      END
C
C
C
CODE FOR SA41
      SUBROUTINE SA41(J,IND,IVET)
C
C
      DIMENSION IVET(118)
C
C
      INCLUDE 'XCHARS.INC'
C
C
      CALL XARS(IND,IVET(J))
      DO 1000 I=1,4
      IF(IVET(J).EQ.IB)GOTO 1050
      J=J+1
1000  CONTINUE
1050  CONTINUE
      RETURN
      END
C
CODE FOR STATX
      SUBROUTINE STATX(IVET)
C
C
      DIMENSION IVET(118)
      DIMENSION IK(8)
C
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XCHARS.INC'
C
C
#if defined (_HOL_)
      DATA IK(1)/1HA/
      DATA IK(2)/1Ht/
      DATA IK(3)/1Ho/
      DATA IK(4)/1Hm/
      DATA IK(5)/1H /
      DATA IK(6)/1H /
      DATA IK(7)/1H /
      DATA IK(8)/1H /
#else
      DATA IK(1)/'A'/
      DATA IK(2)/'t'/
      DATA IK(3)/'o'/
      DATA IK(4)/'m'/
      DATA IK(5)/' '/
      DATA IK(6)/' '/
      DATA IK(7)/' '/
      DATA IK(8)/' '/
#endif
C
      CALL XMVSPD(IB,IVET(1),118)
      J=IFIR
      IVET(J)=IK(1)
      IVET(J+1)=IK(2)
      IVET(J+2)=IK(3)
      IVET(J+3)=IK(4)
      IVET(J+3)=IK(4)
      IVET(J+7)=IK(5)
      IVET(J+8)=IK(6)
      IVET(J+9)=IK(7)
      IVET(J+10)=IK(8)
      RETURN
      END
C
CODE FOR STUIJ
      SUBROUTINE STUIJ(IVET)
C
C
      DIMENSION IVET(118)
      DIMENSION IK(3)
C
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XCHARS.INC'
C
C
#if defined (_HOL_)
      DATA IK(1)/1HU/
      DATA IK(2)/1H(/
      DATA IK(3)/1H)/
#else
      DATA IK(1)/'U'/
      DATA IK(2)/'('/
      DATA IK(3)/')'/
#endif
C
      J=NSTA-IABS(NUD)+1+IFIR
      DO 1000 I=1,6
      J=J+NUF
      IVET(J)=IK(1)
      IVET(J+1)=IK(2)
      IVET(J+4)=IK(3)
1000  CONTINUE
      J=NSTA-IABS(NUD)+1+IFIR
      DO 1050 I=1,3
      J=J+NUF
      N=I+1
      IVET(J+2)=NUMB(N)
      IVET(J+3)=NUMB(N)
1050  CONTINUE
      J=J+NUF
      IVET(J+2)=NUMB(3)
      IVET(J+3)=NUMB(4)
      J=J+NUF
      IVET(J+2)=NUMB(2)
      IVET(J+3)=NUMB(4)
      J=J+NUF
      IVET(J+2)=NUMB(2)
      IVET(J+3)=NUMB(3)
      RETURN
      END
C
CODE FOR STXYZ
      SUBROUTINE STXYZ(IVET)
C
C
      DIMENSION IVET(118)
      DIMENSION IK(16)
C
C
      INCLUDE 'XPTCL.INC'
C
C
#if defined (_HOL_)
      DATA IK(1)/1Hx/
      DATA IK(2)/1H//
      DATA IK(3)/1Ha/
      DATA IK(4)/1Hy/
      DATA IK(5)/1Hb/
      DATA IK(6)/1Hz/
      DATA IK(7)/1Hc/
      DATA IK(8)/1HU/
      DATA IK(9)/1H(/
      DATA IK(10)/1Hi/
      DATA IK(11)/1Hs/
      DATA IK(12)/1Ho/
      DATA IK(13)/1H)/
      DATA IK(14) /1HO/
      DATA IK(15) /1Hc/
      DATA IK(16) /1Hc/
#else
      DATA IK(1)/'x'/
      DATA IK(2)/'/'/
      DATA IK(3)/'a'/
      DATA IK(4)/'y'/
      DATA IK(5)/'b'/
      DATA IK(6)/'z'/
      DATA IK(7)/'c'/
      DATA IK(8)/'U'/
      DATA IK(9)/'('/
      DATA IK(10)/'i'/
      DATA IK(11)/'s'/
      DATA IK(12)/'o'/
      DATA IK(13)/')'/
      DATA IK(14) /'O'/
      DATA IK(15) /'c'/
      DATA IK(16) /'c'/
#endif
C
      J=NSTA+NXF-IABS(NXD)+1+IFIR
      IVET(J)=IK(1)
      IVET(J+1)=IK(2)
      IVET(J+2)=IK(3)
      J=J+NXF
      IVET(J)=IK(4)
      IVET(J+1)=IK(2)
      IVET(J+2)=IK(5)
      J=J+NXF
      IVET(J)=IK(6)
      IVET(J+1)=IK(2)
      IVET(J+2)=IK(7)
      J=J+NUF+IABS(NXD)-IABS(NUD)-1
      IVET(J)=IK(8)
      IVET(J+1)=IK(9)
      IVET(J+2)=IK(10)
      IVET(J+3)=IK(11)
      IVET(J+4)=IK(12)
      IVET(J+5)=IK(13)
      J = J + NUF
      IVET(J) = IK(14)
      IVET(J+1) = IK(15)
      IVET(J+2) = IK(16)
      RETURN
      END
C
C
CODE FOR SAPPLY
      SUBROUTINE SAPPLY (NPAR)
C----- NPAR = NUMBER OF REFINABLE PARAMETERS
C--COMPUTE THE E.S.D.'S OF THE ATOMIC PARAMETERS.
C
C  BPD    LOCATION OF THE E.S.D.'S
C
C--THE FOLLOWING VARIABLES ARE USED :
C
C  JO  SET ON ENTRY
C  JP
C
C  JR
C  JS  SET ON ENTRY FOR WORK SPACE
C  JT
C  JU
C  .
C  .
C  JZ
C
C--REQUIRES M12 SET ON ENTRY
C
C--
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
C
      INCLUDE 'XPTCL.INC'
      INCLUDE 'XWORKA.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST11.INC'
      INCLUDE 'XLST12.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XIOBUF.INC'
C
      INCLUDE 'QSTORE.INC'
C
      NPAR = 0
C--CLEAR THE TEMPORARY STORAGE
      DO 1000 JX=1,11
        BPD(JX)=0.0
1000  CONTINUE
C--CHECK IF ANY COORDINATES HAVE BEEN REFINED
      IF(ISTORE(M12+1))1100,1100,1050

1050  CONTINUE
      L12A=ISTORE(M12+1)
      IF(ISTORE(L12A+3))1100,1150,1150

1100  CONTINUE
      RETURN

1150  CONTINUE
      MD12A=ISTORE(L12A+1)
      JU=ISTORE(L12A+2)
      JV=ISTORE(L12A+3)
      JT=ISTORE(L12A+4)
      JP=JT-1
      NPAR = JV - JU

C--SEARCH FOR THE CONTRIBUTIONS TO EACH PARAMETER IN TURN
      DO JW=JU,JV,MD12A
        IF(ISTORE(JW).GT.0)THEN
          JX=JW
          JY=L12A
          JR=JS
          JZ=0
C--CHECK IF THIS PART FOR THIS PARAMETER HAS BEEN REFINED
1250      CONTINUE
          IF(ISTORE(JX))1550,1550,1300

1300      CONTINUE
C--ADD THE CONTRIBUTIONS INTO THE STACK
            IF ( ( JR+4 )  .GE.   LFL ) GO TO 9910
            ISTORE(JR)=ISTORE(JX)
            ISTORE(JR+2)=KBLCK(ISTORE(JR))
            ISTORE(JR+1)=M12B
            STORE(JR+3)=1.
            IF(ISTORE(JY+1)-1)1450,1500,1450
1450        CONTINUE
              STORE(JR+3)=STORE(JX+1)
1500        CONTINUE
            JR=JR+4
            JZ=JZ+1

1550      CONTINUE
C--CARRY ONTO THE NEXT PART
          JY=ISTORE(JY)
          IF(JY)1700,1700,1600

1600      CONTINUE
C--MOVE ONTO THE NEXT PART
            JX=ISTORE(JY+2)+ISTORE(JY+1)*(JT-ISTORE(JY+4))
            IF(JX-ISTORE(JY+2))1550,1250,1650
1650        CONTINUE
              IF(ISTORE(JY+3)-JX)1550,1250,1250

1700      CONTINUE
          IF(JZ.GT.0)THEN
C--CALCULATE THE E.S.D.
            BPD(JP)=XVAR(JS,JZ,4,JR)
            IF ( IERFLG .LT. 0 ) GO TO 9900
            IF(BPD(JP)) 1760,1790,1790
1760        CONTINUE
            WRITE ( CMON, 1770) STORE(M5), STORE(M5+1), BPD(JP)
            CALL XPRVDU(NCVDU, 1,0)
            IF (ISSPRT .EQ. 0) WRITE(NCWU,'(A)') CMON(1)
1770        FORMAT(1X,' Negative e.s.d for atom ',A4,F6.0,F12.10)
            BPD(JP) = 0.0
1790        CONTINUE
            BPD(JP)=SQRT(BPD(JP)*AMULT)
          END IF
        END IF

        JT=JT+1
        JP=JP+1
      END DO
      GOTO 1100
C
9900  CONTINUE
C -- ERRORS
      RETURN
9910  CONTINUE
      CALL XICA
      CALL XERHND ( IERERR )
      RETURN
C
      END
C
CODE FOR SNUM
      SUBROUTINE SNUM(COOR,ESD,ND,NP,J,IVET)
C--OUTPUT A COORDINATE AND ITS E.S.D.
C
C  COOR  COORDINATE TO INSERT
C  ESD   E.S.D. TO INSERT
C  ND    POWER OF 10 NUMBER MULTIPLIED BY
C  NP    0  WITH DECIMAL POINT
C        1  NO DECIMAL POINT
C  J     ADDRESS IN IVET OF RIGHTMOST CHARACTER IN FIELD
C  IVET  VECTOR FOR PRINTING
C
C--IF 'ND' IS NEGATIVE, THEN THE SUBROUTINE WILL CHOOSE
C  A VALUE FOR 'ND', UNLESS THAT VALUE IS LESS THAN 'ND' AND
C  THE NUMBER IS TO BE PRINTED AS AN INTEGER.
C
C----- SECTION DEALING WITH DECIMAL OUTPUT REWRITTEN oCT2003
C      THE VALUE OF 'ND' IS IGNORED IF THE SIGN IS -VE
C--
C
      CHARACTER *4 CB
      CHARACTER*32 CFORM
      CHARACTER*80 CTEMP
C
      DIMENSION IVET(118)
C
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XCONST.INC'
C
      EQUIVALENCE (JB,CB)
      DATA CB/'    '/
C
C----- WE DONT KNOW HOW BIG IVET IS, BUT WE CAN CLEAR OUT THE LAST
C      /ND/ LOCATIONS
      MODND = ABS(ND)
      CALL XFILL(JB,IVET(j-modnd+1),modnd)
      J1=J
      A=COOR
      B=ESD
      N1=ND
C--CHECK IF WE ARE TO CHOOSE THE NUMBER OF DECIMAL PLACES
      IF(ND)1000,1000,1350
C--WE MUST CHOOSE THE NUMBER OF DECIMAL PLACES  -  UNPACK THE DEFAULT
1000  CONTINUE
      J2=IABS(ND)
      N1=1
      DO 1100 I=1,7
      IF(INT(B*(10.0**N1)+0.0501))1150,1050,1150
C--STILL TOO SMALL
1050  CONTINUE
      N1=N1+1
1100  CONTINUE
C--NO E.S.D. TO PRINT  -  INSERT THE DEFAULT
      N1=J2
      GOTO 1350
C
C--THE NUMBER OF PLACES FOR THE E.S.D. HAS BEEN FOUND
1150  CONTINUE
C----- 'RULE OF 19'
      IF ( (NINT(B*(10.0**(N1+1))) .LE. 19) .AND.
     1     (NINT(B*(10.0**(N1+1))) .GE. 10) ) N1 = N1+1
      J1=J+ND+N1
C--CHECK IF THE DECIMAL POINT IS TO BE PRINTED
      IF(NP)1450,1450,1200
C--NO DECIMAL POINT  -  CHECK THAT ENOUGH PLACES ARE GIVEN
1200  CONTINUE
      IF(J2-N1)1300,1250,1250
C--NOT ENOUGH PLACES  -  INSERT THE DEFAULT
1250  CONTINUE
      J1=J
      N1=J2
      GOTO 1400
C--CHANGE THIS TO A DECIMAL POINT PRINT OF A SPECIAL TYPE
1300  CONTINUE
      B=10.0**J2
      A=COOR*B
      B=ESD*B
      N1=N1-J2
      J1=J+N1+1
      GOTO 1450
C--NORMAL PRINT  -  CHECK IF THIS IS WITH DECIMAL POINT
1350  CONTINUE
      IF(NP)1450,1450,1400
C--PRINT WITHOUT DECIMAL POINT
1400  CONTINUE
      J3=J1+1
      CALL SI(A,N1,ID)
      CALL SUBALF(J1,ID,IVET)
      J2=J1
C--OUTPUT THE SIGN IF NECESSARY
      IF(A .LT.0) IVET(J2)=MINUS
C--OUTPUT THE E.S.D.
      CALL SI(B,N1,ID)
      CALL SUBZED(J3,ID,IVET, 1)
      RETURN
C
C
C--PRINT WITH DECIMAL POINT
1450  CONTINUE
C----- COMPLETELY RE-WRITTEN BY DJW OCT 2003 IN ORDER TO DEAL WITH
C      ESDS GREATER THAN UNITY.
C      METHOD USES INTERNAL WRITES TO BUILD UP A TEXT STRING FORMAT
C      TO TAKE ADVANTAGE OF INTERNAL ROUNDING.  
C      THIS IS THEN MANIPUATED FOR SUS GREATER THAN 2.0 EITHER TO REMOVE
C      THE DECIMAL POINT, OR BACKFILL THE TRAILING ZEROS.
      CTEMP = ' '
      NND= MIN(ABS(ND),N1)
      NND = N1
      IF (B .LE. ZEROSQ) THEN
C----- NO ESD - WRITE TO REQUESTED PRECISION
        WRITE(CFORM,'(A,I2,A,A,A)')  
     1  '(F20.',
     1  ABS(ND),
     1  ')'
        WRITE(CTEMP,CFORM) A
C        
      ELSE IF (B .LT. 2.) THEN
C-----NORMAL PRINT WITH VALUES BOTH SIDES OF THE DECIMAL POINT
        WRITE(CFORM,'(A,I2,A,A,A)')  
     1  '(F20.',
     1  ABS(NND),
     1  ',''('', I20',
     1  ','')''',
     1  ')'
        IE = NINT(B*10**NND)
        WRITE(CTEMP,CFORM) A,IE
      ELSE
C-----ALL THE VALUES ARE TO THE RIGHT OF THE DECIMAL POINT
C     SO DONT PRINT IT.
        IXX = NINT(A)
        IE = NINT(B)
C      WRITE THE NUMBER AND ITS ESD, THEN FIND OUT WHERE THE ACTUAL
C      VALUES BEGIN IN THE STRING.
        WRITE(CTEMP,'(2I10)') IXX,IE
        IK = 11
        DO II = 1,10
          IF (CTEMP(IK:IK) .NE. ' ') EXIT
          IK = IK +1
        ENDDO
        IK = MIN(IK,20)
        IJ = IK-10 
        IF (IK .NE. 20) THEN
C      'RULE OF 19'
            IF (CTEMP(IK:IK) .EQ. '1') THEN
               IF (CTEMP(IK+1:IK+1) .NE. '0') THEN
                    IK=IK+1
                    IJ=IJ+1
                ENDIF
            ENDIF
        ENDIF
C      ROUND THE RESULT RATHER THAN JUST TRUNCATE
        READ(CTEMP(1:10),'(I10)') IXX
        READ(CTEMP(11:20),'(I10)') IE
        IP=10-IJ
        IXX=10**IP*(NINT(FLOAT(IXX)/10**IP))
        IE=10**IP*(NINT(FLOAT(IE)/10**IP))
        WRITE(CTEMP,'(2I10)') IXX,IE
        CTEMP(11:11)='('
        CTEMP(21:21)=')'
      ENDIF
      CALL XCRAS(CTEMP,N)
C----- LOOK FOR '(' OR '.' TO POSITION RESULT IN FIELD
      IP=INDEX(CTEMP,'(')
      IF (IP .EQ. 0) IP=INDEX(CTEMP,'.')
      IP = N-IP
C      WRITE(*,'(A,2I6)') 'J,IP= ',J,IP
      READ(CTEMP(1:N),'(32A1)') (IVET(II+IP),II=J-N,J)        
C
      END
C
C
CODE FOR SUBALF
      SUBROUTINE SUBALF(J,IARG,IVET)
C--TRANSFORM INTEGER NUMBER TO ALPHANUMERIC CHARACHTERS
C
C  J     LAST ADDRESS IN IVET  -  RESET ON EXIT
C  IARG  INTEGER NUMBER
C  IVET  VECTOR FOR PRINTING
C
C--THIS ROUTINE INSERTS THE NUMBER 'IARG' IN THE ARRAY 'IVET'
C  STARTING AT THE POSITION 'J', WHICH IS AT THE RIGHT HAND END
C  OF THE NUMBER STRING.
C  ON EXIT 'J' IS SET TO THE NEXT WORD ON THE LEFT NOT USED.
C
C--
C
C
      DIMENSION IVET(118)
C
      INCLUDE 'XCHARS.INC'
C
C
      IAR=IABS(IARG)
C--FIND THE NEXT CHARACTER FOR THIS NUMBER
1000  CONTINUE
      I=IAR
      IAR=IAR/10
      I=I-IAR*10
      IVET(J)=NUMB(I+1)
      J=J-1
C--CHECK IF THE REMAINDER IS ZERO
      IF(IAR)1050,1050,1000
C--CHECK THE SIGN OF THE ORIGINAL ARGUMENT
1050  CONTINUE
      IF(IARG)1100,1150,1150
1100  CONTINUE
      IVET(J)=MINUS
      J=J-1
1150  CONTINUE
      RETURN
      END
C
CODE FOR SUBZED
      SUBROUTINE SUBZED(J,IARG,IVET, ICODE)
C--TRANSFORM INTEGER NUMBER TO ALPHANUMERIC CHARACTERS
C
C  J      FIRST ADDRESS IN IVET
C  IARG   INTEGER NUMBER
C  IVET   VECTOR FOR PRINTING
C  ICODE  IF .GE. 2, NO BRACKETS
C
C
C
      DIMENSION IVET(118)
C
      INCLUDE 'XCHARS.INC'
C
      IF(IARG)1000,1250,1000
1000  CONTINUE
      IVALUE=IARG
      M=0
      NMX=7
      IF (ICODE .LT. 2) THEN
        IVET(J)=ILB
        J=J+1
      ENDIF
      DO 1200 I=1,NMX
      I1=10**(NMX-I)
      I2=IVALUE/I1
      IF(I2)1050,1050,1100
1050  CONTINUE
      IF(M)1200,1200,1150
1100  CONTINUE
      M=1
1150  CONTINUE
      IVET(J)=NUMB(I2+1)
      J=J+1
      IVALUE=IVALUE-I2*I1
1200  CONTINUE
      IF (ICODE .LT. 2) THEN
        IVET(J)=IRB
        J=J+1
      ENDIF
1250  CONTINUE
      RETURN
      END

cCODE FOR SET0
c      SUBROUTINE SET0(J1,J2,IVET)
cC
cC
c      DIMENSION IVET(118)
cC
c\XCHARS
cC
cC
c      J=J1
c1000  CONTINUE
c      IF(J2-J)1100,1050,1050
c1050  CONTINUE
c      IVET(J)=NUMB(1)
c      J=J+1
c      GOTO 1000
c1100  CONTINUE
c      RETURN
c      END

cCODE FOR SID
c      SUBROUTINE SID(A,N,IX,ID)
cC--CONVERT THE NUMBER 'A' INTO INTEGER AND FRACTIONAL PARTS
cC
cC  A   NUMBER TO CONVERT
cC  N   NUMBER OF DECIMAL PLACES REQUIRED
cC  IX  THE INTEGER PART OF 'A'
cC  ID  THE FRACTIONAL PART OF 'A'
cC
cC--
cC
cC
c      AM = 10.0**IABS(N)
c      X  = FLOAT( NINT(ABS(A)*AM)) / AM
c      IX=INT(X)
c      XD=X-FLOAT(IX)
c      ID=NINT(XD*(10.0**IABS(N)))
c      RETURN
c      END


CODE FOR SI
      SUBROUTINE SI(A,N,ID)
C--EXPRESS THE NUMBER 'A' AS AN INTEGER
C
C  A   THE NUMBER TO CONVERT
C  N   THE NUMBER OF DECIMAL PLACES OF 'A' REQUIRED
C  ID  THE ANSWER
C
C--
C
C
      X=ABS(A)
      ID=NINT(X*(10.0**IABS(N)))
      RETURN
      END
C
C
C
C
C
CODE FOR KCPROP
      FUNCTION KCPROP (A)
C----- COMPUTE PROPERTIES OF CELL
c From l 5
C        A(1) = DENS
C        A(2) = F000
C        A(3) = ABSN
C        A(4) = WEIGHT
C        A(5) = F(electrons)
C
C        A(11) = Freidif
C        A(12) = <D^2>
c
c From L 29
C        A(6) = DENS
C        A(7) = F000
C        A(8) = ABSN
C        A(9) = WEIGHT
C        A(10) = F(electrons)
C
cdjwjul09
      real, dimension(:,:),allocatable :: table 
      integer, dimension(:),allocatable :: type
cdjwjul09
c 
      DIMENSION A(12)
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST02.INC'
      INCLUDE 'XLST03.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST23.INC'
      INCLUDE 'XLST29.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XIOBUF.INC'
C
      INCLUDE 'QSTORE.INC'
C
      KCPROP = 1
      CALL XZEROF (A, 8)
C----- LOAD DATA IF NOT ALREADY IN CORE
      IF (KHUNTR (1,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL01
      IF (KHUNTR (2,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL02
      IF (KHUNTR (3,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL03
      IF (KHUNTR (5,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL05
      IF (KHUNTR (23,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL23
      IF (KHUNTR (29,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL29
c
        WRITE ( CMON, '(A)') ' Recomputing functions of composition'
        CALL XPRVDU(NCVDU, 1,0)
cdjwjul09
c      set up dynamic arrays for formula information
      maxele = n3
      allocate (table(maxele,4))
      allocate (type(maxele))
      nele = 0
cdjwjul09
cdjw feb2001
        iupdat = istore(l23sp+1)
        toler = store(l23sp+5)
c        inomo = ( istore(l23m) * -2 ) + 1 ! 1 for anom, 3 for no anom
        CALL XPRC17 (0, 0, toler, -1)
        IF (IERFLG .LE. 0) GOTO 1600
C----- CLEAR THE CELL PROPERTY DETAILS
        WEIGHT =0.
        ABSN=0.
        F000 = 0.
        FIMAG = 0.0
        FREAL = 0.0
        FELEC = 0.0
        ICHECK=N5
        JCHECK=0
        I29=L29 + (N29-1)*MD29
        I5 = L5 + (N5-1)*MD5
C
        DO 1510 M5=L5,I5,MD5
          CWGHT = 0.0
          CABSN = 0.0
          DO 1521 M29= L29,I29,MD29
            IF (ISTORE(M5) .EQ. ISTORE(M29)) THEN
C----- MATCH
              if (iupdat .ge.0) then
                w = store(m5+2)*store(m5+13)
              else
                w = store(m5+2)
              endif
              WEIGHT = WEIGHT + W * STORE(M29+6)
              ABSN = ABSN + W * STORE(M29+5)
              ICHECK = ICHECK - 1
              exit
            END IF
1521      CONTINUE
c
C----- CHECK LIST 3
          DO M3 = L3, L3+(N3-1)*MD3, MD3
            IF (ISTORE(M5) .EQ. ISTORE(M3)) THEN
              F = 0.0
              DO I = 1, 11, 2
                F = F + STORE(M3+I)
              END DO
c
              ihit = 0
              if (nele .gt. 0) then
                do mele = 1,nele
                    if(istore(m5) .eq. type(mele)) then
                          ihit = mele
                          exit
                    endif
                enddo
              endif
c
              if (ihit .gt. 0) then
                    table(ihit,1) = table(ihit,1) + w
              else
                    nele =  nele + 1
                    type(nele)     = istore(m5)
                    table(nele, 1) = w
                    table(nele, 2) = f
                    table(nele, 3) = store(m3+1)
                    table(nele, 4) = store(m3+2)
              endif
c
              FREAL = FREAL + STORE(M5+2) * STORE(M5+13) * F
              FIMAG=STORE(M5+2)*STORE(M5+13)*STORE(M3+2)
              F = 0.0
              DO I = 3, 11, 2
                F = F + STORE(M3+I)
              END DO
              F = REAL(NINT(F))
              FELEC = FELEC + STORE(M5+2) * STORE(M5+13) * F
              GOTO 1528
            ENDIF
          END DO
C----- NO MATCH -
          JCHECK= JCHECK + 1
          GOTO 1510
1528      CONTINUE
1510    CONTINUE
        F000 = SQRT( FREAL*FREAL + FIMAG*FIMAG )

C----- COMPUTE MU AND M
        IF (ICHECK .NE. 0 ) THEN
          WRITE ( CMON, 1545) ICHECK, 29
          CALL XPRVDU(NCVDU, 1,0)
          IF (ISSPRT .EQ. 0)  WRITE(NCWU,'(A)') CMON(1)(:)
1545    FORMAT(1X,I6,' atoms exists in LIST 5 without details',
     1    ' in LIST ', I3)
          KCPROP = -1
        ENDIF
C
        IF (JCHECK .GT. 0 ) THEN
          WRITE ( CMON, 1545) JCHECK, 3
          CALL XPRVDU(NCVDU, 1,0)
          IF (ISSPRT .EQ. 0)  WRITE(NCWU,'(A)') CMON(1)(:)
          KCPROP = -1
        ENDIF
CNOV97    CONTINUE INSPITE OF ERROR        RETURN
1550  CONTINUE
C----- NUMBER OF ASYMMETRIC UNITS
        ASYM = FLOAT (N2*N2P*(1+IC))
        RVOL = ASYM/ STORE(L1P1+6)
        ABSN = ABSN  * RVOL * 10.
        DENS = WEIGHT * RVOL / 0.60225
        I=5
        WRITE ( CMON, 1555)
        CALL XPRVDU(NCVDU, 1,0)
        WRITE ( CMON, 1560)
        CALL XPRVDU(NCVDU, 1,0)
        WRITE ( CMON, 1570) I,WEIGHT,DENS,ABSN
        CALL XPRVDU(NCVDU, 1,0)
        IF (ISSPRT .EQ. 0) THEN
          WRITE (NCWU,1555)
          WRITE (NCWU,1560)
          WRITE(NCWU,1570)I,WEIGHT,DENS,ABSN
1555      FORMAT(15X,'  molecular weight,',
     1    '  calculated density, absorption coefficient')
1560      FORMAT(40X, '(gm/cm**3)                (cm-1)')
1570      FORMAT(1X,' From LIST ',I4,3X,F12.3,7X,
     1    F12.3,10X,F12.3)
        ENDIF
        A(1) = DENS
        A(2) = F000 * ASYM
        A(3) = ABSN
        A(4) = WEIGHT
        A(5) = FELEC * ASYM
C
        WEIGHT=0.
        ABSN=0.

        DO 1580 M29=L29,I29,MD29
          WEIGHT = WEIGHT + STORE(M29+4)*STORE(M29+6)
          ABSN = ABSN + STORE(M29+4)*STORE(M29+5)
1580    CONTINUE

        ABSN = ABSN * RVOL * 10.
        DENS = WEIGHT * RVOL / 0.60225
        I = 29
        WRITE ( CMON, 1570) I,WEIGHT,DENS,ABSN
        CALL XPRVDU(NCVDU, 1,0)
        IF (ISSPRT .EQ. 0) WRITE(NCWU,'(A)') CMON(1)(:)
        A(6) = DENS
        A(7) = F000 * ASYM
        A(8) = ABSN
        A(9) = WEIGHT
        A(10) = FELEC * ASYM
1600    CONTINUE
c
cdjwjul09
c  compute Flack Friedif etc
c note that Flack's spread sheet uses z rather than f at theta=0
      sumy = 0.
      sumx = 0.
      sumz = 0.
      do j=1,nele
        sum1 = 0.
        sum2 = 0.
        sum3 = 0.
        do i=1,nele
          sum1 = sum1 + table(i,1)*table(i,4)*table(i,4)
          sum2 = sum2 + table(i,1)*table(i,2)*table(i,4)
          sum3 = sum3 + table(i,1)*table(i,2)*table(i,2)
        enddo
        sumy = sumy + table(j,1)*table(j,2)*table(j,2)*sum1
     1          -2.0* table(j,1)*table(j,2)*table(j,4)*sum2
     2              + table(j,1)*table(j,4)*table(j,4)*sum3
        sumx = sumx + table(j,1)*table(j,2)*table(j,2)
        sumz = sumz + table(j,1)*table(j,4)*table(j,4)
      enddo
c
chi * 10^4
      chi=20000. * sqrt(sumy)/(sumx+sumz)
      A(11) = CHI
      A(12) = SUMY
      WRITE ( CMON, '(1x,A,F8.1,3x,A,F10.4)') 
     1 ' Friedif = ',chi,'Estimated Friedel difference = ',sqrt(sumy)
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ. 0)  then
       WRITE(NCWU,'(A)') CMON(1)(:)
       WRITE(NCWU,'(A//)') 
     1 ' f computed from scattering factors, including f-prime'
      ENDIF
      write(cmon,'(//)')
      call xprvdu(ncvdu,2,0)
      deallocate (table)
      deallocate (type)
      RETURN
      END
C
C
CODE FOR XPRTDA
      SUBROUTINE XPRTDA(KEY, IESD, NODEV)
C--PUBLICATION PRINT OF DISTANCES, ANGLES, TORSION ANGLES
C
C
C      KEY      1 = DIST     +10 = CIF  +20 = HTML
C               2 = ANGLES
C               3 = BOTH
C               4 = TORSION
C               5 = H-BOND
C
C  NODEV    THE OUTPUT DEVICE
C
C  IFIR    THE NUMBER OF BLANKS AT THE START OF EACH LINE.
C  MINX    THE FIRST LINE ON A PAGE TO BE USED
C  LINEX   THE LAST LINE PLUS ONE ON A PAGE USED
C  NSTA    THE NUMBER OF CHARACTERS FOR THE TYPE AND SERIAL NUMBER.
C  NXF     NUMBER OF CHARACTERS FOR THE TOTAL VALUE FIELD.
C  NXD     NUMBER OF CHARACTERS AFTER THE DECIMAL POINT
C  NOP     DECIMAL POINT INDICATOR :
C          0  PARAMETERS CONTAIN A DECIMAL POINT.
C          1  PARAMETERS DO NOT CONTAIN A DECIMAL POINT.
C
C  NAP     DOUBLE LINE SPACING INDCIATOR :
C
C          -1  SINGLE LINE SPACING.
C           0  DOUBLE LINE SPACING.
C  ICC     CHOOSE INDICATOR :
C
C           1  SYSTEM DOES NOT CHOOSE THE NUMBER OF SIGNIFICANT FIGURES.
C          -1  SYSTEM CHOOSES THE NUMBER OF SIGNIFICANT FIGURES TO PRINT
C
C  IBAR    THE LINE WIDTH.
C
C
      CHARACTER *1 CODE, ANGLE, DIST
      CHARACTER *160 CLINE
      CHARACTER *4 CTEM
C
      DIMENSION ITYPE(4) , SER(4) , ITEM(3)
      DIMENSION LINEA(118)
C--
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XTAPES.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XIOBUF.INC'
C
      INCLUDE 'QSTORE.INC'
C
C
#if defined (_HOL_)
      DATA KHYD /4HH   /
      DATA KDET /4HD   /
      DATA DIST/1HD/, ANGLE/1HA/
#else
      DATA KHYD /'H   '/
      DATA KDET /'D   '/
      DATA DIST/'D'/, ANGLE/'A'/
#endif
      DATA ITEM(1)/2/, ITEM(2)/3/, ITEM(3)/4/
C----- MAXIMUM NO OF ATOMS
      DATA MITEM/4/
C
C**********************************************************************
      IF (KEY .GT. 20) THEN
            CALL XHTMPR(KEY, IESD, NODEV)
            GOTO 9930
      ELSE IF (KEY .GT. 10) THEN
            CALL XCIFPR(KEY, IESD, NODEV)
            GOTO 9930
      ENDIF
C---  CLEAR THE CORE
      CALL XRSL
      CALL XCSAE
C----- SET THE CONSTANTS
C----- BLANKS AT START OF LINE
      IFIR = 2 
cjun2010      NSTA = 8 !no of characters in type and serial.  Forgot()!
      NSTA = 10
      NFX = 8
      NXD = 2
      NOP = 0
      ICC = -1
      NAP = -1
      IBAR = 72
      LINE = IBAR
C----- PAGE BREAK EVERY 10 PAGES
      LINEX = 66*10
C----- SET MAXIMUM REQUESTED CHARACTERS PER LINE
      KLEN=MITEM*NSTA + 2*NFX + IFIR
C----- PREPARE AN ANGLE BUFFER
      ILEN=3*NSTA + 2*NFX
      JLEN=INT(ILEN+3)/4
      JFIR=INT(IFIR)/4
      IBUF=NFL
C--CHECK THE WIDTH OF A PAGE
      IF(IBAR-KLEN)1050,1200,1200
C--FIELD WIDTH IS WRONG
1050  CONTINUE
      WRITE ( CMON, 1100) IBAR
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU,1100)IBAR
1100  FORMAT(' More than',I5,'  characters on a line')
C-- ERROR
      GOTO 9920
1200  CONTINUE
C--SET THE FLAG FOR THE FIRST LINE ON A PAGE
      MINX=5
C--SET THE FIELD WIDTH FLAGS
      NXD=ISIGN(NXD,ICC)
C
      NL=LINEX
C
      REWIND (MTE)
C--LOOP OVER THE ENTRIES
C
2000  CONTINUE
      CLINE = ' '
      READ ( MTE,END=2700 ) CODE, TERM, ESD,
     1 (ITYPE(I),SER(I),(JUNK,J=1,5),I=1,4)
      IF (CODE .EQ. DIST)  THEN
            NUM = ITEM(1)
      ELSE  IF (CODE .EQ. ANGLE) THEN
            NUM = ITEM(2)
      ELSE
            NUM = ITEM(3)
      ENDIF
C
      IF (IESD .LT. 0) ESD=0.0
C
C--CLEAR THE OUTPUT BUFFER
      CALL XMVSPD(IB,LINEA(1),LINE)
      K=IFIR
      idjw=0
      DO 2020 I=1,NUM
      J=K

      IF( (ITYPE(I).EQ.KHYD).OR.(ITYPE(I).EQ.KDET)) idjw=idjw+1
C convert atom type to mixed case
      WRITE(CTEM,'(A4)') ITYPE(I)
      CALL XCCLWC (CTEM(2:), CTEM(2:))
      READ (CTEM,'(A4)') ITYPE(I)
C Output the type
      CALL SA41 ( J , ITYPE(I) , LINEA )
      IND1=NINT(SER(I))
C----- OUTPUT  SERIAL NUMBER
      CALL SUBZED(J,IND1,LINEA,  1)
C--UPDATE THE CURRENT POSITION FLAG
      K=K+NSTA
c^^^
c^^^      IF (I .LT. NUM) LINEA(K-2) = MINUS
      IF (I .LT. NUM) LINEA(K) = MINUS
      K=K+2
2020  CONTINUE
      J=K + NFX
C----- OUTPUT VALUE AND ESD
      if(idjw .ne. 0) then
            if (code .eq. dist) then 
                 inxd = -2
            else
                 inxd = -1
            endif
      else
            inxd = nxd
      endif
      CALL SNUM(TERM, ESD, INXD, NOP,J,LINEA)
C--CHECK FOR DOUBLE SPACING
2200  CONTINUE
      IF(NAP)2300,2250,2250
C--PRINT THE BLANK LINE
2250  CONTINUE
      IF (CODE .NE. ANGLE .AND. KEY .NE. 2) WRITE(NODEV,2550)
      NL=NL+1
C--CHECK FOR THE END OF A PAGE
2300  CONTINUE
      IF(NL-LINEX)2500,2350,2350
C--END OF THE PAGE  -  START A NEW PAGE
2350  CONTINUE
      IF ( CODE  .NE. ANGLE  .AND.  KEY   .NE. 2    .AND.
     1     NODEV .NE. NCWU   .AND.  NODEV .NE. NCPU      )
     2  WRITE(NODEV, '(A)') CHAR(12)
C----- WRITE SOME LINETHROWS
C--CLEAR THE OUTPUT BUFFER
      IF (CODE .NE. ANGLE .AND. KEY .NE. 2) WRITE(NODEV,2450)
2450  FORMAT(//2X,118A1/)
      NL=MINX
      GOTO 2200
2500  CONTINUE
      IF (CODE .EQ. ANGLE .AND. KEY .GE. 1 ) THEN
C----- COMPRESS AND STORE CURRENT LINE
            JBUF=KSTALL(JLEN)
            CALL XFA4CS(LINEA(IFIR),STORE(JBUF),ILEN)
      ENDIF
      IF (CODE .NE. ANGLE .AND. KEY .NE. 2) THEN
C--PRINT THE DISTANCE OR TORSION  LINE
      CLINE = ' '
      WRITE(CLINE,2550) (LINEA(I),I = 1,KLEN)
      CALL XCTRIM (CLINE,NCHAR)
      WRITE(NODEV,'(A)') CLINE(1:NCHAR)
2550        FORMAT(2X,118A1)
            NL=NL+1
      ENDIF
C -- FETCH INFORMATION FOR THE NEXT ENTRY
C----- ANY MORE ?
      GOTO 2000
2700  CONTINUE
C
      REWIND (MTE)
C
      IF(IBUF .EQ. NFL) GOTO 9930
C------ WRITE OUT THE ANGLE BUFFER
      NL=LINEX
C
      DO 3500 I=IBUF,JBUF,JLEN
      IF (NL.GE.LINEX .AND. NODEV.NE.NCWU .AND. NODEV.NE.NCPU) THEN
            WRITE(NODEV, '(A)') CHAR(12)
            WRITE(NODEV,2450)
            NL=0
        ENDIF
      CLINE = ' '
      WRITE(CLINE,3100) (STORE(J),J=I,I+JLEN-1)
      CALL XCTRIM (CLINE,NCHAR)
      WRITE(NODEV,'(A)') CLINE(1:NCHAR)
        NL=NL+1
3100  FORMAT(2X,20A4)
3500  CONTINUE
C
      GOTO 9930
C
9920  CONTINUE
      CALL XOPMSG ( IOPDIS , IOPLSP , 5 )
9930  CONTINUE
      CALL XOPMSG ( IOPDIS , IOPLSE , 5 )
      CALL XTIME2 ( 2 )
C
      RETURN
      END
CODE FOR XHTMPR
      SUBROUTINE XHTMPR(KEY, IESD, NODEV)
C
C----- PRINT GEOMETRY INFORMATION IN HTML FORMAT
C
      DIMENSION IVEC(20), KDEV(4)
      CHARACTER *80 CLINE, CBUF
      CHARACTER *1 CODE
      CHARACTER *3 CKEY
      CHARACTER CGEOM(3)*8
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XTAPES.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XLST02.INC'
      INCLUDE 'QSTORE.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'XSSCHR.INC'
      DATA CKEY /'DAT'/

      CALL XRSL  ! CLEAR THE STORE
      CALL XCSAE
      CALL XFAL02
      IF (STORE(L2C) .LE. ZERO) THEN
            JA = 1
      ELSE
            JA = 2
      ENDIF

      IPUB = KSTALL (28)

C----- WE NEED JKEY ETC BECAUSE MTE MAY CONTAIN BOTH DISTANCES AND ANGLE

      IF (KEY .EQ. 23) THEN
            JKEY = 0
            NCYC = 2
      ELSE IF (KEY .EQ. 24) THEN
            JKEY = 2
            NCYC = 1
      ELSE
            RETURN
      ENDIF
C
      DO 3000 ICYC = 1, NCYC
        KKEY = JKEY + ICYC

        SELECT CASE (KKEY)
        CASE (1)
          WRITE(NCPU, '(''<H2>Distances</H2>'')')
        CASE (2)
          WRITE(NCPU, '(''<H2>Angles</H2>'')')
        CASE (3)
          WRITE(NCPU, '(''<H2>Torsion</H2>'')')
        END SELECT
        WRITE(NCPU, '(''<FONT SIZE="-1"><TABLE BORDER="1">'')')

        REWIND (MTE)
cdjw0206  Two columns html
        iline=-1
1000    CONTINUE
          CALL XZEROF(STORE(IPUB), 28)
          READ (MTE, END=2500, ERR = 9000) CODE, TERM, ESD,
     1    (STORE(JPUB),STORE(JPUB+1), (ISTORE(KPUB),KPUB=JPUB+2,JPUB+6),
     2    JPUB=IPUB, IPUB+21, 7)
C
C-- GET ADDRESS OF LAST USEFUL ITEM - UP TO 4 (D, A or T)
          JPUB = INDEX (CKEY, CODE)
          IF (JPUB .NE. KKEY) GO TO 1000
          IF (JPUB .NE. 0) THEN
            KPUB = (JPUB * 7) + IPUB
          ELSE
            KPUB=0
          ENDIF
          CLINE = ' '
cdjw0206          WRITE(NCPU,'(''<TR>'')')
         if (iline .le. 0)  WRITE(NCPU,'(''<TR>'')')
1         FORMAT ('<TD>',A,'</TD>')
          DO JPUB = IPUB, KPUB, 7

            WRITE (CBUF, '(A4)') STORE(JPUB)
            CALL XCTRIM (CBUF, N)
            CALL XCCLWC (CBUF(2:N), CBUF(2:N))

            WRITE (CLINE, '(A4,I7)') CBUF(1:N), NINT(STORE(JPUB+1))
            CALL XCRAS( CLINE, J)

C----- CHECK SYMMETRY INFORMATION
cdjwmay09 - replace with a call to SYMCODE (one day)
            IF (
     1       (ISTORE(JPUB+2)+ISTORE(JPUB+3)+ISTORE(JPUB+4)
     2       +ISTORE(JPUB+5)+ISTORE(JPUB+6) .EQ. 2) .AND.
     3      (ABS(ISTORE(JPUB+2))+ABS(ISTORE(JPUB+3))+ABS(ISTORE(JPUB+4))
     4      +ABS(ISTORE(JPUB+5))+ABS(ISTORE(JPUB+6)) .EQ. 2)) THEN
              WRITE(NCPU,1) CLINE(1:J)
            ELSE
              M = 1+
     1         (ABS(ISTORE(JPUB+2))-1) * N2P * JA +
     2         (ISTORE(JPUB+3)-1) * JA +
     3         (-SIGN(1,ISTORE(JPUB+2))+1)/2
              WRITE(CBUF, '(I4)') M
              CALL XCRAS (CBUF, N)
              CLINE(J+2:) = CBUF(1:N)//'_'
              J = J + N + 3
              WRITE(CLINE(J:J+2), '(3I1)') 5+ISTORE(JPUB+4),
     1        5+ISTORE(JPUB+5), 5+ISTORE(JPUB+6)
              WRITE(NCPU,1) CLINE(1:J+2)
            ENDIF
          END DO
C
C----- VALUE AND ESD
          CALL XFILL (IB, IVEC, 20)
          CALL SNUM ( TERM, ESD, -3, 0, 8, IVEC )
          WRITE( CBUF, '(20A1)') (IVEC(I), I=1, 20)
          CALL XCRAS ( CBUF, N)

          SELECT CASE (KKEY)
          CASE (1)
            WRITE(NCPU,1) CBUF(1:N)//'&Aring; '
          CASE (2,3)
            WRITE(NCPU,1) CBUF(1:N)//'&deg; '
          END SELECT
          if(iline .ge. 0)then
             WRITE(NCPU,'(''</TR>'')')
          else
             WRITE(NCPU,'(''<TD width="15%">  </TD>'')')
          endif
          iline = -iline
        GOTO 1000
c
2500    CONTINUE  ! END OF MTE

       WRITE(NCPU,'(''</TABLE></FONT>'')')

3000  CONTINUE

9000  CONTINUE
      RETURN
      END
CODE FOR XCIFPR
      SUBROUTINE XCIFPR(KEY, IESD, NODEV)
C
C----- PRINT GEOMETRY INFORMATION IN CIF FORMAT
C
C      KEY      11 = DIST     
C               12 = ANGLES
C               13 = BOTH
C               14 = TORSION
C               15 = H-BOND
C
      DIMENSION IVEC(20), KDEV(4)
      CHARACTER *80 CLINE, CBUF
      CHARACTER *4 ctemp, cangl, cbond, cbond2
      CHARACTER *4 CKEY
      CHARACTER *1 CODE
      CHARACTER CGEOM(4)*8
      CHARACTER CTEXT(2)*9
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ISTORE.INC'
      INCLUDE 'ICOM30.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XTAPES.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XLST02.INC'
      INCLUDE 'XLST30.INC'
      INCLUDE 'QSTORE.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'XSSCHR.INC'
c
      INCLUDE 'QLST30.INC'

C
      DATA CGEOM /'_bond', '_angle', '_torsion', '_hbond' /
      DATA CTEXT /'_geom', '_distance'/
      DATA CKEY /'DATH'/
      data cangl /'1234'/
      data cbond /'DHA '/
      data cbond2 /'HAA '/
C
CDJWMAY99 - PREAPRE TO APPEND CIF OUTPUT ON FRN1
      CALL XMOVEI(KEYFIL(1,23), KDEV, 4)
      CALL XRDOPN(8, KDEV , CSSCIF, LSSCIF)
      IESD = IESD
      NODEV = NODEV
      if (key .eq. 15) then
            ctemp = cbond
      else
            ctemp = cangl
      endif
C      CLEAR THE STORE
      CALL XRSL
      CALL XCSAE
      CALL XFAL02
      IF (KHUNTR (30,0, IADDL,IADDR,IADDD, -1) .NE. 0) CALL XFAL30
      IF (STORE(L2C) .LE. ZERO) THEN
            JA = 1
      ELSE
            JA = 2
      ENDIF
      IPUB = KSTALL (28)
cdjwmay05
c----- check if there is any H-Bond data in MTE
      if (key .eq. 15) then
        rewind (mte)
1       continue
        READ (MTE, END=9000, ERR = 9000) CODE, TERM, ESD,
     1 (STORE(JPUB),STORE(JPUB+1), (ISTORE(KPUB),KPUB=JPUB+2,JPUB+6),
     2  JPUB=IPUB, IPUB+14, 7), (store(kpub),kpub=ipub+21,ipub+27)
c----- no error - probably some data
       if (code .eq. 'H') goto 2
       goto 1
      endif
2     continue
c
C----- WE NEED JKEY ETC BECAUSE MTE MAY CONTAIN BOTH DISTANCES AND ANGLE
cdjw160804 - jkey & ncyc were not initialised
      jkey = 0
      ncyc = 1
      IF (KEY .EQ. 13) THEN
            JKEY = 0
            NCYC = 2
      ELSE IF (KEY .EQ. 14) THEN
            JKEY = 2
            NCYC = 1
      ELSE IF (KEY .EQ. 15) THEN
            JKEY = 0
            NCYC = 1
      ELSE
            CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)
            RETURN
      ENDIF
C
      DO 3000 ICYC = 1, NCYC
c----- kkey = number of atoms involved - 1
c      lkey = id of geomerty keyword
      KKEY = JKEY + ICYC
      lkey = kkey
      if (key .eq. 15) then
            kkey = 2
            lkey = 4
      endif
      WRITE(NCFPU1, '(A)') 'loop_'
        DO 500 I = 1, KKEY+1
c
          WRITE( CLINE, 510) CGEOM(lKEY), ctemp(I:I)
510   FORMAT( '_geom', A, '_atom_site_label_', A)
          CALL XCRAS ( CLINE, N)
          WRITE (NCFPU1, '(1X,A)') CLINE(1:N)
c
          WRITE( CLINE, 520) CGEOM(lKEY), ctemp(I:I)
520   FORMAT ('_geom', A, '_site_symmetry_', A)
          CALL XCRAS ( CLINE, N)
          WRITE (NCFPU1, '(1X,A)') CLINE(1:N)
500     CONTINUE
c
      if (key .ne. 15) then
       IF (KKEY .EQ. 1) THEN
          WRITE(CLINE, 530) CGEOM(KKEY), '_distance'
       ELSE
          WRITE(CLINE, 530) CGEOM(KKEY)
530       FORMAT ('_geom', A, A)
       ENDIF
       CALL XCRAS ( CLINE, N)
       WRITE (NCFPU1, '(1X,A)') CLINE(1:N)
      endif
c
      if (key .eq. 15) then
        kkey = 2
        write(cline,'(4A)') ctext(1),cgeom(4),cgeom(2),'_DHA'
        call xcras ( cline, n)
        write (ncfpu1, '(1x,a)') cline(1:n)
       do i=1,2
        write(cline,'(6A)') ctext(1),cgeom(4),ctext(2),
     1 '_',cbond(i:i),cbond2(I:I)
        call xcras ( cline, n)
        write (ncfpu1, '(1x,a)') cline(1:n)
       enddo
       write(cline,'(4A)') ctext(1),cgeom(4),ctext(2),'_DA'
       call xcras ( cline, n)
       write (ncfpu1, '(1x,a)') cline(1:n)
      endif
      WRITE(CLINE, 540) CGEOM(LKEY)
540   FORMAT ('_geom', A, '_publ_flag')
      CALL XCRAS ( CLINE, N)
      WRITE (NCFPU1, '(1X,A)') CLINE(1:N)
C
c----- reset kkey to point to 'H'
      if (key .eq. 15) kkey = 4
      NO_HBOND = 0
      if (key .eq. 15) NO_HBOND = 1
      REWIND (MTE)
1000  CONTINUE
      CALL XZEROF(STORE(IPUB), 28)
      if (key .ne. 15) then
       READ (MTE, END=2500, ERR = 9000) CODE, TERM, ESD,
     1 (STORE(JPUB),STORE(JPUB+1), (ISTORE(KPUB),KPUB=JPUB+2,JPUB+6),
     2  JPUB=IPUB, IPUB+21, 7)
      else
       READ (MTE, END=2500, ERR = 9000) CODE, TERM, ESD,
     1 (STORE(JPUB),STORE(JPUB+1), (ISTORE(KPUB),KPUB=JPUB+2,JPUB+6),
     2  JPUB=IPUB, IPUB+14, 7), (store(kpub),kpub=ipub+21,ipub+27)
      endif
C
C----- GET ADDRESS OF LAST USEFUL ITEM - UP TO 4
      JPUB = INDEX (CKEY, CODE)
      IF (JPUB .NE. KKEY) GO TO 1000
      IF (JPUB .NE. 0) THEN
        KPUB = (JPUB * 7) + IPUB
      ELSE
        KPUB=0
      ENDIF
      NO_HBOND = 0
c----- use temporary addresses since we may need to reverse order
      itmp = ipub
      ktmp = kpub
      jtmp = 7
      if (key .eq. 15) then 
c-----   the last record for h-bonds is not an atom
         kpub = ipub + 14
         itmp = Kpub
         ktmp = Ipub
         jtmp = -7
        if (store(ipub+21) .gt. store(ipub+23)) then
c       swap order of atoms
         itmp = Ipub
         ktmp = Kpub
         jtmp = 7
c        +25,26 are spare slots
         call xmove(store(ipub+21), store(ipub+25),2) 
         call xmove(store(ipub+23), store(ipub+21),2) 
         call xmove(store(ipub+25), store(ipub+23),2) 
        endif
      endif
C
      CLINE = ' '
      J = 1
      NOH = 0                           ! NO HYDROGEN YET
      NATOUT = 0                        ! Number of atoms
      DO 2000 JPUB = Itmp, Ktmp, jtmp
        NATOUT = NATOUT + 1
        WRITE (CBUF, '(A4)') STORE(JPUB)   ! ATOM NAME
        CALL XCTRIM (CBUF, N)
        CALL XCCLWC (CBUF(2:N), CBUF(2:N))
        NOH = MAX (NOH, INDEX(CBUF(1:2), 'H '))
C----- REMOVE TRAILING SPACE
        N = N-1
        CLINE(J:J+N-1) = CBUF(1:N)
        J = J + N
C----- ATOM NUMBER
        WRITE(CBUF, '(I7)') NINT(STORE(JPUB+1))
        CALL XCRAS( CBUF, N)
        CLINE(J:J+N-1) = CBUF(1:N)
        J = J+N+1
C
C----- SYMMETRY INFORMATION
c
cdjwmay09 - replace with a call to SYMCODE (one day)
        IF (
     1 (ISTORE(JPUB+2)+ISTORE(JPUB+3)+ISTORE(JPUB+4)
     2  +ISTORE(JPUB+5)+ISTORE(JPUB+6) .EQ. 2) .AND.
     3 (ABS(ISTORE(JPUB+2))+ABS(ISTORE(JPUB+3))+ABS(ISTORE(JPUB+4))
     4  +ABS(ISTORE(JPUB+5))+ABS(ISTORE(JPUB+6)) .EQ. 2)) THEN
C----- IDENTITY
            CLINE(J:J) = '.'
            J = J + 2
        ELSE
            M = 1+
     1         (ABS(ISTORE(JPUB+2))-1) * N2P * JA +
     2         (ISTORE(JPUB+3)-1) * JA +
     3         (-SIGN(1,ISTORE(JPUB+2))+1)/2
            WRITE(CBUF, '(I4)') M
            CALL XCRAS (CBUF, N)
            CLINE(J:J+N) = CBUF(1:N)//'_'
            J = J + N +1
            WRITE(CLINE(J:J+2), '(3I1)') 5+ISTORE(JPUB+4),
     1      5+ISTORE(JPUB+5), 5+ISTORE(JPUB+6)
            J = J+4
        ENDIF
2000  CONTINUE
C
c
C----- VALUE AND ESD
      CALL XFILL (IB, IVEC, 20)
cdjw021204
cdjwjul2010
c     Key=15 for H-bonds. 4th atom slots used for DD1,ED1,D2,ED2,0,0,0
c                              store(ipub+22) == ED1
c Type    0 7  14 DD1 DH 21
c Serial  1 8  15 ED1 DH 22  
c R       2 9  16 DD3 HA 23
c L       3 10 17 ED3 HA 24
C Tx      4 11 18        25
c Ty      5 12 16        26
c Tz      6 12 20        27
c
c
cdjwjan11 should be set in DISTANGL bases on RIDE flag
c      if ((key .eq. 15) .and. (store(ipub+22) .le. zero)) esd = 0.
      if ((noh .gt. 0 ).and.( esd .le. 0.).AND.(NATOUT .GE. 3)) then
cdjwoct05. More fiddles to keep Bill happy
        if (key .eq. 15) then
          CALL SNUM ( TERM, 0., -0, 1, 10, IVEC )
        else
          CALL SNUM ( TERM, 0., -1, 0, 10, IVEC )
        endif
      else
        CALL SNUM ( TERM, ESD, -3, 0, 10, IVEC )
      endif
      WRITE( CBUF, '(20A1)') (IVEC(I), I=1, 20)
      CALL XCRAS ( CBUF, N)
      CLINE(J:J+N-1) = CBUF(1:N)
      J = J + N + 1
      if (key .eq. 15) then
C----- H-bonds AND ESDs
       do itmp =ipub+21, ipub+23, 2
        CALL XFILL (IB, IVEC, 20)
        if (esd .le. 0.) then
          CALL SNUM ( store(itmp), 0.0,  -2, 0, 10, IVEC )
        else
C set esd to 0.0 to keep Ton happy
c          CALL SNUM ( store(itmp),store(itmp+1),  -3, 0, 10, IVEC )
          CALL SNUM ( store(itmp),0.0,  -3, 0, 10, IVEC )
        endif
        WRITE( CBUF, '(20A1)') (IVEC(I), I=1, 20)
        CALL XCRAS ( CBUF, N)
        CLINE(J:J+N-1) = CBUF(1:N)
        J = J + N + 1
       enddo
       dadist = sqrt(
     1  store(ipub+21)*store(Ipub+21) + store(ipub+23)*store(Ipub+23)
     2  -2.*store(ipub+21)*store(Ipub+23)*cos(term*dtr))
c       Use mean c-c esd
        daesd = 1.414*store(l30cf+14)
c        
       call xfill (ib, ivec, 20)
cdjwoct05. More fiddles to keep Bill happy. 
       call snum ( dadist, daesd,  -3, 0, 10, ivec )
       write( cbuf, '(20a1)') (ivec(i), i=1, 20)
       call xcras ( cbuf, n)
       cline(j:j+n-1) = cbuf(1:n)
       j = j + n + 1
c----- LIMIT PRINTING
       if (dadist .le. 4.1) then
        noh = 0
       else
        noh = 1
       endif
      endif
C
      N = INDEX (CLINE(1:J), 'H')
      IF (NOH .LE. 0) THEN
            WRITE(NCFPU1, '(A, 2X,A )') CLINE(1:J), 'yes'
      ELSE
            WRITE(NCFPU1, '(A, 2X,A )') CLINE(1:J), 'no'
      ENDIF
      GOTO 1000
C
2500  CONTINUE

      IF ( NO_HBOND .EQ. 1 ) WRITE(NCFPU1,'(A)')'. . . . . . . . . . .'

3000  CONTINUE
C
9000  CONTINUE
      CALL XRDOPN(7, KDEV , CSSCIF, LSSCIF)
      RETURN
      END
C
CODE FOR XCIFX
      SUBROUTINE XCIFX
CDJWMAR99[      CIF OUTPUT DIRECTED TO NCFPU1, PERMITTING TEXT OUTPUT TO
C               BE SENT TO THE PUNCH UNIT AS A TABLE
C
      PARAMETER (NCOL=2,NROW=49)
      PARAMETER (IDATA=15,IREF=23)
      CHARACTER*35 CPAGE(NROW,NCOL)
      CHARACTER*76 CREFMK
      PARAMETER (IDIFMX=11)
      PARAMETER (IREDMX=7)
      DIMENSION IREFCD(3,IDIFMX)
      DIMENSION IREDCD(IREDMX)
CAVDL more solution packages in cif-goodies
      PARAMETER (ISOLMX=10)
      DIMENSION ISOLCD(ISOLMX)
      PARAMETER (IABSMX=16)
      DIMENSION IABSCD(IABSMX)

C
CDJWMAR99 MANY CHANGES TO BRING UP TO DATE WITH NEW CIFDIC
      PARAMETER (NTERM=4)
      PARAMETER (NNAMES=30)
      DIMENSION A(12), JDEV(4), KDEV(4)
      PARAMETER (NLST=12)
      DIMENSION LSTNUM(NLST), JLOAD(NLST)
      DIMENSION IVEC(16), ESD(6)
      CHARACTER CCELL(3)*1,CANG(3)*5,CSIZE(3)*3,CINDEX(3)*2
      CHARACTER CBUF*80,CTEMP*80,CLINE*80, CHLINE*380
      character *80 ctext(4)
C
      CHARACTER*4 CTYPE
      CHARACTER*15 CINSTR,CDIR,CPARAM,CVALUE,CDEF
      CHARACTER*26 UPPER,LOWER
      CHARACTER*3 CSSUBS(11)
      CHARACTER*17 CWT
      CHARACTER*22 CFM, CFMC ! 'F<sub>obs</sub>&sup2;'
      CHARACTER*35 CMOD
      CHARACTER*6 CSOLVE
cdjwapr09
      INTEGER  IFARG      ! F OR F^2^ FOR WEIGHTING SCHEME
C
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ICOM30.INC'
      INCLUDE 'ICOM31.INC'
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XCOMPD.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'XTAPES.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XSSCHR.INC'
      INCLUDE 'XLISTI.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST02.INC'
      INCLUDE 'XLST03.INC'
      INCLUDE 'XLST04.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XLST13.INC'
      INCLUDE 'XLST23.INC'
      INCLUDE 'XLST25.INC'
      INCLUDE 'XLST28.INC'
      INCLUDE 'XLST29.INC'
      INCLUDE 'XLST30.INC'
      INCLUDE 'XLST31.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'XFLAGS.INC'
C
C
      INCLUDE 'QLST30.INC'
      INCLUDE 'QLST31.INC'
      INCLUDE 'QSTORE.INC'

      V(CA,CB,CC,AL,BE,GA)=CA*CB*CC * SQRT(1-COS(AL)**2-COS(BE)**2-
     1   COS(GA)**2 + 2 * COS(AL) * COS(BE) * COS(GA))
C
c
C UNKNOWN CAD4 MACH3 KAPPACCD DIP SMART IPDS XCALIBUR APEX2 GEMINI
C    1     2       3     4    5     6    7   8        9      10
c SUPERNOVA
C   11
C------ REFERENCE CODES FOR THE DIFFRACTOMETERS
      DATA IREFCD /4,5,6, 13,24,13, 13,24,13, 25,17,17, 15,17,17,
     1 26,27,27, 20,19,20,  37,36,36, 45,45,45, 47,36,36,
     2 48,36,36  /
C UNKNOWN RC93 DENZO SHELX XRED CRYSALIS SAINT
C   1       2    3     4     5      6      7
C------ REFERENCE CODES FOR DATA REDUCTION
      DATA IREDCD /5,24,17,27,19,36,45/
C------ REFERENCE CODES FOR DIRECT METHODS
CAVDLdec06 updating references in reftab.sda with numbers 42, 43, and 44
      DATA ISOLCD /1,18,30,11,22,28,29,42,43,44/
C------ REFERENCE CODES FOR ABSORPTION METHOD
      DATA IABSCD /7,21,16,17,31,32,33,39,40,40,39,7,7,16,45,36/

C
      DATA UPPER/'ABCDEFGHIJKLMNOPQRSTUVWXYZ'/
      DATA LOWER/'abcdefghijklmnopqrstuvwxyz'/
C                  1 2 3 4 5 6  7  8  9  10 11 12
      DATA LSTNUM/1,2,3,4,5,13,23,29,30,31,6,28/
      DATA CCELL/'a','b','c'/
      DATA CANG/'alpha','beta','gamma'/
      DATA CSIZE/'min','mid','max'/
      DATA CINDEX/'h_','k_','l_'/
#if defined (_HOL_)
      DATA ICARB/4HC   /
      DATA KHYD/4HH   /
      DATA KDET/4HD   /
#else
      DATA ICARB/'C   '/
      DATA KHYD/'H   '/
      DATA KDET/'D   '/
#endif
CDJWMAR99      DATA JDEV /'H','K','L','I'/
      DATA CSSUBS /' 21',' 31',' 32',' 41',' 42',' 43',' 61',
     1            ' 62',' 63',' 64',' 65'/
 
1     FORMAT (A)
2     FORMAT ('<TR><TD>',A,'</TD><TD>',A,'</TD></TR>')
9002  FORMAT ('<TD>',A,'</TD><TD>',A,'</TD>')
3     FORMAT ('<TR><TD>',A,'</TD><TD>',F5.2,'</TD></TR>')
9003  FORMAT ('<TD>',A,'</TD><TD>',F5.2,'</TD>')
4     FORMAT ('<TR><TD>',A,'</TD><TD>',I8,'</TD></TR>')
5     FORMAT ('<TR><TD>',A,'</TD><TD>',F10.4,'</TD></TR>')
6     FORMAT ('<TR><TD>',A,'</TD><TD>',I8,A,'</TD></TR>')
9006  FORMAT ('<TD>',A,'</TD><TD>',I8,A,'</TD>')
7     FORMAT ('<TR><TD>',A,'</TD><TD>',F10.2,A,'</TD></TR>')
8     FORMAT ('<TR><TD>',A,'</TD><TD>',F10.3,'</TD></TR>')
9     format ('<TR>')
9009  format ('</TR>')


CRICFEB03: Output one of 0=CIF, 1=PLAIN, 2=HTML
      CALL XCSAE
      I = KRDDPV ( IPUNCH , 1 )
      IF (I.LT.0) THEN
         IF (ISSPRT .EQ. 0) WRITE(NCWU, 51)
         WRITE ( CMON ,51)
         CALL XPRVDU(NCVDU, 1,0)
51       FORMAT(' Error in #CIFOUT directives. ')
         RETURN
      END IF

CDJWMAY99 - OPEN CIF OUTPUT ON FRN1
      IF ( IPUNCH .EQ. 0 ) THEN
         CALL XMOVEI (KEYFIL(1,23),KDEV,4)
         CALL XRDOPN (6,KDEV,CSSCIF,LSSCIF)
      END IF

CRICJUN02 - Last minute SFLS calc to get threshold cutoffs into 30.
      CALL XRSL
      CALL XCSAE

C----- SET REFLECTION LISTING TYPE
      ITYP06 = 1

      IF (KEXIST(33) .LE. 0) THEN
         IF (ISSPRT .EQ. 0) WRITE(NCWU, 1151)
         WRITE ( CMON ,1151)
         CALL XPRVDU(NCVDU, 1,0)
1151     FORMAT(' Calculation of R values cannot proceed ',
     2          'as no refinement has been carried out yet.')
      ELSE
         CALL XSFLSB(-1,ITYP06)
      ENDIF

      CALL XRSL
      CALL XCSAE

C----- CLEAR OUT THE PAGE BUFFER
      DO I=1,NROW
         CPAGE(I,1)=' '
         CPAGE(I,2)=' '
      END DO

      CALL XDATER (CBUF(1:8))

      IF ( IPUNCH .EQ. 0 ) THEN
        WRITE (NCFPU1,'(''data_global '')')
        WRITE (NCFPU1,'(''_audit_creation_date  '',6X, 
     1  ''"20'',3(A2,A))')
     2  CBUF(7:8),'-',CBUF(4:5),'-',CBUF(1:2),'"'
        WRITE (NCFPU1,
     1   '(''_audit_creation_method CRYSTALS_ver_'',F5.2)')
     1    0.01*FLOAT(ISSVER)

C----- OUTPUT A TITLE, FIRST 44 CHARACTERS ONLY
        WRITE (CLINE,'(20A4)') (KTITL(I),I=1,20)
        K=KHKIBM(CLINE)
        CALL XCREMS (CLINE,CLINE,NCHAR)
        CALL XCTRIM (CLINE,NCHAR)
        K=MIN(44,NCHAR-1)
        WRITE (NCFPU1,'(/,''_oxford_structure_analysis_title  '''''',
     1   A,'''''''')') CLINE(1:K)
        WRITE (NCFPU1,'(''_chemical_name_systematic '',T35,''?'')')
        WRITE (NCFPU1,'(''_chemical_melting_point '',T35,''?'',/)')
      ELSE IF ( IPUNCH .EQ. 1 ) THEN
        WRITE (CLINE,'(15A4,3(A2,A))') (KTITL(I),I=1,15),CBUF(7:8),'-',
     1  CBUF(4:5),'-',CBUF(1:2)
        K=KHKIBM(CLINE)
        CALL XCREMS (CLINE,CLINE,NCHAR)
        CALL XCTRIM (CLINE,NCHAR)
        K=MIN(35,NCHAR)
        WRITE (CPAGE(1,1)(:),'(A)') CLINE(1:K)
        IF (NCHAR.GE.36) THEN
          K=MIN(70,NCHAR)
          WRITE (CPAGE(1,2)(:),'(A)') CLINE(36:K)
        END IF

      ELSE IF ( IPUNCH .EQ. 2 ) THEN

        WRITE (NCPU,53)
53      FORMAT(
     1 '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" ',
     2 '"http://www.w3.org/TR/REC-html40/loose.dtd">',/,
     3 '<HTML><HEAD><TITLE>Crystal Structure Report</TITLE>',/,
     4 '<META NAME="Description" CONTENT="Structure Report generated',
     5 'by CRYSTALS.">',/,
     6 '<meta http-equiv="Content-Type" ',
     7 'content="text/html; charset=utf-8">',/,
     8 '</HEAD><BODY>')

        WRITE (NCPU,'(''<P align="right">'',3(A2,A),''</P>'')')
     1                      CBUF(7:8),'-',CBUF(4:5),'-',CBUF(1:2)
        WRITE (CLINE,'(15A4)') (KTITL(I),I=1,15)
        K=KHKIBM(CLINE)
        CALL XCREMS (CLINE,CLINE,NCHAR)
        CALL XCTRIM (CLINE,NCHAR)
        WRITE (NCPU,'(''<P>'',A,''</P>'')') CLINE(1:NCHAR)
      END IF
C###################################################################
      IF ( IPUNCH .EQ. 0 ) THEN
        CALL XPCIF ('#looking for refcif ')
        CALL XPCIF (' ')
C-----  COPY HEADER INFORMATION FROM .CIF FILE
        CALL XMOVEI (KEYFIL(1,2),JDEV,4)
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
        CALL XRDOPN(6,JDEV,'CRYSDIR:script\refcif.dat',25)
#else
        CALL XRDOPN(6,JDEV,'CRYSDIR:script/refcif.dat',25)

#endif
        IF (IERFLG.GE.0) THEN
          CLINE=' '
100       CONTINUE
          READ (NCARU,'(A)',ERR=100,END=150) CLINE
          call xpcif (CLINE)
          GO TO 100
150       CONTINUE
C----- CLOSE THE FILE
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
          CALL XRDOPN(7,JDEV,'CRYSDIR:script\refcif.dat',25)
#else
          CALL XRDOPN(7,JDEV,'CRYSDIR:script/refcif.dat',25)
#endif
        ELSE
          WRITE (CMON,'('' cif header file not available'')')
          CALL XPRVDU (NCVDU,1,0)
          IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
          IERFLG=0
        END IF
      END IF
      CALL XPCIF ('#end of refcif ')

C################################################################
 
C                      1 2 3 4 5 6  7  8  9  10 11 12
C FYI:    DATA LSTNUM /1,2,3,4,5,13,23,29,30,31, 6,28 /

      DO MLST=1,NLST
         JLOAD(MLST)=0                   !INDICATE LIST NOT LOADED
         LSTYPE=LSTNUM(MLST)
         IF (KEXIST(LSTYPE)) 400,300,500
300      CONTINUE
           WRITE (CMON,350) LSTYPE
           CALL XPRVDU (NCVDU,1,0)
350        FORMAT (1X,'List ',I2,' contains errors')
           CYCLE
400      CONTINUE
           WRITE (CMON,450) LSTYPE
450        FORMAT (1X,'List',I2,' does not exist')
           CALL XPRVDU (NCVDU,1,0)
           CYCLE
500      CONTINUE
 
         IF (LSTYPE.EQ.1) THEN
            CALL XFAL01
         ELSE IF (LSTYPE.EQ.2) THEN
            CALL XFAL02
         ELSE IF (LSTYPE.EQ.3) THEN
            CALL XFAL03
         ELSE IF (LSTYPE.EQ.4) THEN
            CALL XFAL04
         ELSE IF (LSTYPE.EQ.5) THEN
            CALL XLDR05 (LSTYPE)
         ELSE IF (LSTYPE.EQ.6) THEN
            IULN = 6
            CALL XFAL06 (IULN, 0)
         ELSE IF (LSTYPE.EQ.10) THEN
            CALL XLDR05 (LSTYPE)
         ELSE IF (LSTYPE.EQ.13) THEN
            CALL XFAL13
         ELSE IF (LSTYPE.EQ.14) THEN
            CALL XFAL14
         ELSE IF (LSTYPE.EQ.23) THEN
            CALL XFAL23
         ELSE IF (LSTYPE.EQ.27) THEN
            CALL XFAL27
         ELSE IF (LSTYPE.EQ.28) THEN
C----- LOADED BY XFAL06          CALL XFAL28
         ELSE IF (LSTYPE.EQ.29) THEN
            CALL XFAL29
         ELSE IF (LSTYPE.EQ.30) THEN
            CALL XFAL30
         ELSE IF (LSTYPE.EQ.31) THEN
      INCLUDE 'IDIM31.INC'
            CALL XLDLST (31,ICOM31,IDIM31,0)
         END IF
 
         IF (IERFLG.GE.0) JLOAD(MLST)=1
      END DO
c we dont need LIST 25, but it it exists, we chould use it
        if (kexist(25) .ge. 1)  then
         if (khuntr (25,0, iaddl,iaddr,iaddd, -1) . lt. 0) call xfal25
        else
         n25=0
        endif
c
C################################################################

      IF ( IPUNCH .GE. 0 ) THEN
C-----  LOAD THE AVAILABLE REFERENCE TABLE
        CALL XMOVEI (KEYFIL(1,2),JDEV,4)
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      CALL XRDOPN(6,JDEV,'CRYSDIR:script\reftab.dat',25)
#else
      CALL XRDOPN(6,JDEV,'CRYSDIR:script/reftab.dat',25)
#endif
        IF (IERFLG.GE.0) THEN
          READ (NCARU,'(i4)') NREFS
          REWIND (NCARU)
          MDREFS=21
          LREFS=NFL
          I=KCHNFL(NREFS*MDREFS)
          CALL XZEROF (ISTORE(LREFS),MDREFS*NREFS)
C 
          I=0
          J=LREFS
200       CONTINUE
          READ (NCARU,'(a)',ERR=200,END=250) CTEMP
#if !defined(_MAC_)
          IF (CTEMP(1:1).EQ.'\') CTEMP(1:1)='#'
#else
          IF (CTEMP(1:1).EQ.'\\') CTEMP(1:1)='#'
#endif
          IF (CTEMP(1:1).EQ.'#') THEN
            READ (CTEMP,'(1x,i3,19a4)') (ISTORE(K),K=J+1,J+MDREFS-1)
            J=J+MDREFS
            I=I+1
          END IF
          GO TO 200
250       CONTINUE
          REWIND (NCARU)
          IF (I.NE.NREFS) THEN
            WRITE (CMON,'(i6,a,i6,a)') I,'references found,',NREFS,' ref
     1erences expected'
            NREFS=I
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)
          END IF
C      CLOSE THE REFERENCES FILE
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
       CALL XRDOPN(7,JDEV,'CRYSDIR:script\reftab.dat', 25)
#else
       CALL XRDOPN(7,JDEV,'CRYSDIR:script/reftab.dat', 25)
#endif
        ELSE
          NREFS = 0
          MDREFS= 1
          LREFS = NFL
          IERFLG = 0
          WRITE (CMON,'('' Reference file not available'')')
          CALL XPRVDU (NCVDU,1,0)
          IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)(:)
        END IF
C-usage example 
c     ival =012
c     ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
c     call xrefpr (istore(lrefs),nrefs,mdrefs)

        IF (I.LE.0) THEN
          WRITE (CMON,'('' Reference '', i4, '' not available'')') IVAL
          CALL XPRVDU (NCVDU,1,0)
        END IF
      END IF


C
C################################################################
C
cdjwdec05  Extinction is printed 
cdjwjun06  only if esd GE zero
      if ((jload(9) .ge. 1) .and. (store(l30cf+8) .ge. zero)) then
            ival =014
            ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
      endif
C---- GET LIST 30 READY FOR UPDATING
      IF (JLOAD(9).LE.0) THEN
         WRITE (CMON,'(A)') 'List 30 not available - cif output abandone
     1d'
         CALL XPRVDU (NCVDU,1,0)
         GO TO 2600
      END IF
C 
C----- LIST 1 AND 31
      IF ( IPUNCH .EQ. 2 ) THEN
         WRITE (NCPU,'(''<H2>Crystal Data</H2>'')')
      END IF

C
      IF (JLOAD(1).GE.1) THEN
C --  CONVERT ANGLES TO DEGREES.

         CIFA = STORE(L1P1)
         CIFB = STORE(L1P1+1)
         CIFC = STORE(L1P1+2)
         CIFAL = STORE(L1P1+3)
         CIFBE = STORE(L1P1+4)
         CIFGA = STORE(L1P1+5)

         STORE(L1P1+3)=RTD*STORE(L1P1+3)
         STORE(L1P1+4)=RTD*STORE(L1P1+4)
         STORE(L1P1+5)=RTD*STORE(L1P1+5)
         CALL XZEROF (ESD,6)
         IF (JLOAD(10).GE.1) THEN
C----- SCALE DOWN THE ELEMENTS OF THE V/CV MATRIX
            SCALE=STORE(L31K)
            M31=L31
            ESD(1)=SQRT(STORE(M31)*SCALE)
            ESD(2)=SQRT(STORE(M31+6)*SCALE)
            ESD(3)=SQRT(STORE(M31+11)*SCALE)
            ESD(4)=SQRT(STORE(M31+15)*SCALE)*RTD
            ESD(5)=SQRT(STORE(M31+18)*SCALE)*RTD
            ESD(6)=SQRT(STORE(M31+20)*SCALE)*RTD
         END IF
         IF ( IPUNCH .EQ. 2 ) THEN
            WRITE (NCPU,'(''<FONT SIZE="-1"><TABLE>'')')
         END IF

         IF ( IPUNCH .EQ. 0 ) THEN
          DO I=0,2
C----- VALUE AND ESD
            CALL XFILL (IB,IVEC,16)
            CALL SNUM (STORE(L1P1+I),ESD(I+1),-2,0,12,IVEC)
            WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CBUF,N)
            WRITE (NCFPU1,600) CCELL(I+1)(1:1),CBUF(1:N)
600         FORMAT ('_cell_length_',A,T35,A)
          END DO
          DO I=0,2
            CALL XFILL (IB,IVEC,16)
cdjwjul05
            CALL SNUM (STORE(L1P1+3+I),ESD(I+4),-2,0,12,IVEC)
            WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CBUF,N)
            J=INDEX(CBUF(1:N),'.')
            IF (J.EQ.0) J=MAX(1,N)
            TEMP=STORE(L1P1+3+I)-INT(STORE(L1P1+3+I))
            IF (TEMP.LE.ZERO) N=MAX(1,J-1)
            WRITE (NCFPU1,650) CANG(I+1)(1:5),CBUF(1:N)
650         FORMAT ('_cell_angle_',A,T35,A)
          END DO
         ELSE
          M1P1=L1P1
          DO I=1,3
C----- VALUE AND ESD
            CALL XFILL (IB,IVEC,16)
            CALL SNUM (STORE(M1P1),ESD(I),-3,0,10,IVEC)
            WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CBUF,N)
            IF ( IPUNCH .EQ. 1 ) THEN
              WRITE (CPAGE(3+I,1)(:),'(A,17X,A)')CCELL(I)(1:1),CBUF(1:N)
            ELSE IF ( IPUNCH .EQ. 2 ) THEN
              WRITE (NCPU,601)     CCELL(I)(1:1), CBUF(1:N)
601           FORMAT('<TR><TD>',A,' =</TD><TD>',A,' &Aring;</TD>')
            END IF

            CALL XFILL (IB,IVEC,16)
            CALL SNUM (STORE(M1P1+3),ESD(I+3),-2,0,10,IVEC)
            WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CBUF,N)
            J=INDEX(CBUF(1:N),'.')
            IF (J.EQ.0) J=MAX(1,N)
            TEMP=STORE(M1P1+3)-INT(STORE(M1P1+3))
            IF (TEMP.LE.ZERO) N=MAX(1,J-1)
            IF ( IPUNCH .EQ. 1 ) THEN
              WRITE (CPAGE(3+I,2)(:),'(A,16X,A)') CANG(I)(1:5),CBUF(1:N)
            ELSE IF ( IPUNCH .EQ. 2 ) THEN
              WRITE (NCPU,602)  CANG(I)(1:LEN_TRIM(CANG(I))),CBUF(1:N)
602           FORMAT('<TD>&',A,'; =</TD><TD>',A,'&deg;</TD></TR>')
            END IF
            M1P1=M1P1+1
          END DO
         END IF




         VOL = V(CIFA,CIFB,CIFC,CIFAL,CIFBE,CIFGA)

         CU=SQRT((VOL-V(CIFA+ESD(1),CIFB,CIFC,CIFAL,CIFBE,CIFGA))**2
     1        + (VOL-V(CIFA,CIFB+ESD(2),CIFC,CIFAL,CIFBE,CIFGA))**2
     2        + (VOL-V(CIFA,CIFB,CIFC+ESD(3),CIFAL,CIFBE,CIFGA))**2
     3        + (VOL-V(CIFA,CIFB,CIFC,CIFAL+ESD(4)*DTR,CIFBE,CIFGA))**2
     4        + (VOL-V(CIFA,CIFB,CIFC,CIFAL,CIFBE+ESD(5)*DTR,CIFGA))**2
     5        + (VOL-V(CIFA,CIFB,CIFC,CIFAL,CIFBE,CIFGA+ESD(6)*DTR))**2)

         CALL XFILL (IB,IVEC,16)
         CALL SNUM (VOL,CU,-2,0,12,IVEC)
         WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
         CALL XCRAS (CBUF,N)
         IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (NCFPU1,750) CBUF(1:N)
750        FORMAT ('_cell_volume ',T35,A)
           CALL XPCIF (' ')
         ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(7,1)(:),'(A,10X,A)') 'Volume',CBUF(1:N)
         ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''</TABLE></FONT>'')')
           WRITE (NCPU,'(''<FONT SIZE="-1"><TABLE>'')')
           write(ncpu,9)
           WRITE (NCPU,9002) 'Volume',CBUF(1:N)//' &Aring;&sup3;'
         END IF
      END IF
C 
C----- LIST 2
C

      Z2 = 1
      IFLACK = 0
      IF (JLOAD(2).GE.1) THEN
         ICENTR=NINT(STORE(L2C))+1
         Z2 = STORE(L2C+3)
C----- CRYSTAL CLASS - FROM LIST 2
         J=L2CC+MD2CC-1
         WRITE (CTEMP,800) (ISTORE(I),I=L2CC,J)
800      FORMAT (4(A4))
         CBUF=' '
cdjwnov2011 - make all text lowercase - requested by ALT
         CALL XCCLWC (CTEMP(1:),CBUF(1:))
c         CBUF(1:1)=CTEMP(1:1)
         CALL XCTRIM (CBUF,J)
         J = J - 1
         IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(3,1)(:),'(A,5X,A)') 'Crystal Class',CBUF(1:J)
         ELSE IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (CLINE,850) CBUF(1:J)
           CALL XPCIF (CLINE)
850        FORMAT ('_symmetry_cell_setting',T35,'''',A,'''')
         ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(
     1       ''<td width="15%"> </td><TD>Crystal Class</TD><TD>'',
     2       A,''</TD></TR>'')') CBUF(1:J)
         END IF
C 
C ----- DISPLAY SPACE GROUP SYMBOL
         J=L2SG+MD2SG-1
         WRITE (CTEMP,900) (ISTORE(I),I=L2SG,J)
900      FORMAT (4(A4,1X))
         CBUF=' '
         CALL XCCLWC (CTEMP(2:),CBUF(2:))
         CBUF(1:1)=CTEMP(1:1)
         CALL XCTRIM (CBUF,J)
         WRITE (CLINE,950) CBUF(1:J)
950      FORMAT ('_symmetry_space_group_name_H-M',T35,'''',A,'''')
951      FORMAT ('_symmetry_space_group_name_Hall',T35,'?')
CRicMay99 Changed 10X to 1X: CPAGE is only 35 chars wide so it is
C         easy to overflow with eg. 17 character spacegroup symbols.
C         This will spoil the formatting. Maybe it would be better
C         to compress whitespace.
         IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(3,2)(:),'(A,1X,A)') 'Space Group',CBUF(1:J)
         ELSE IF ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (CLINE)
           WRITE (CLINE,951)
           CALL XPCIF (CLINE)
         ELSE IF ( IPUNCH .EQ. 2 ) THEN
C Subscript second number in screws: 21,31,32,41 etc.
           DO I=1,4     !Scan four times - more than enough.
             DO K=1,11
                J = KCCEQL(CBUF,1,CSSUBS(K))
                IF ( J .GT. 0 ) THEN
                  CBUF = CBUF(1:J)//CSSUBS(K)(2:2)//
     1             '<sub>'//CSSUBS(K)(3:3)//'</sub>'//CBUF(J+3:)
                END IF
             END DO
           END DO
           write(ncpu,9)
           WRITE (NCPU,9002) 'Space group', CBUF(1:LEN_TRIM(CBUF))
         END IF
 
         IF ( IPUNCH .EQ. 0 ) THEN
C DISPLAY EACH SYMMETRY OPERATOR
            CALL XCIF2(NCFPU1)
         END IF
C
         IF ( IPUNCH .EQ. 0 ) THEN

           IF ( NINT ( STORE(L2C) ) .LE. 0 ) THEN
             IFLACK = 0
           ELSE
             IFLACK = 1
           END IF
         END IF
      END IF


C 
C----- LIST 3
C 
      IF (JLOAD(3).GE.1) THEN
        IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (NCFPU1,1250)
1250     FORMAT(/'loop_'/'_atom_type_symbol'/'_atom_type_scat_dispersion
     1_real'/'_atom_type_scat_dispersion_imag'/'_atom_type_scat_Cromer_M
     2ann_a1'/'_atom_type_scat_Cromer_Mann_b1'/'_atom_type_scat_Cromer_M
     3ann_a2'/'_atom_type_scat_Cromer_Mann_b2'/'_atom_type_scat_Cromer_M
     4ann_a3'/'_atom_type_scat_Cromer_Mann_b3'/'_atom_type_scat_Cromer_M
     5ann_a4'/'_atom_type_scat_Cromer_Mann_b4'/'_atom_type_scat_Cromer_M
     6ann_c'/'_atom_type_scat_source  ')
           DO M3=L3,L3+(N3-1)*MD3,MD3
             WRITE (CTEMP,'(A4)') ISTORE(M3)
             CBUF=CTEMP(2:4)
             CALL XCCLWC (CBUF(1:3),CTEMP(2:4))
             WRITE (NCFPU1,1300) CTEMP(1:4),(STORE(M),M=M3+1,M3+11)
1300         FORMAT (1X,A4,1X,8F9.4,/,3F9.4,1X,
     1       '''International Tables Vol C 4.2.6.8 and 6.1.1.4''')
           END DO
        END IF
      END IF
C 
C----- COMPUTE PROPERTIES OF CELL
C 
      IF (JLOAD(1)*JLOAD(2)*JLOAD(3)*JLOAD(5)*JLOAD(8).NE.0) THEN
C 
C IF IEPROP -VE, THEN MIS-MATCH BETWEEN 5 AND 29.
         IEPROP=KCPROP(A)
C----- SAVE THE GOODIES IN LIST 30
C      LOAD VALUES FROM LIST 5
         IF (JLOAD(9).GE.1) THEN
            STORE(L30GE+1)=A(1)
            STORE(L30GE+2)=A(5)
            STORE(L30GE+3)=A(3)
            STORE(L30GE+4)=A(4)
C
C      LOAD VALUES FROM LIST 29
C            STORE(L30GE+1)=A(6)
C            STORE(L30GE+2)=A(10)
C            STORE(L30GE+3)=A(8)
C            STORE(L30GE+4)=A(9)
         END IF
      END IF
C 

C Sneaky early look at List 30 - need Z.

      Z30 = Z2
      IF ( JLOAD(9).EQ.1 ) THEN
         Z30=STORE(L30GE+5)
C Catch case where Z30 isn't set in L30 - assume = Z2.
         IF ( Z30 .LT. 0.00001 ) Z30 = Z2
      END IF

      NSUM=NINT(Z30)
      IF (AMOD(Z30,1.0).LE.ZERO) THEN
          WRITE (CTEMP,1600) NSUM
      ELSE
          WRITE (CTEMP,1650) Z30
      END IF
      CALL XCRAS (CTEMP,LENGTH)
      IF ( IPUNCH .EQ. 0 ) THEN
        CALL XPCIF (' ')
        CALL XPCIF (' ')
        WRITE (NCFPU1,'(''_cell_formula_units_Z '',T42, A)')
     1  CTEMP(1:LENGTH)
      ELSE IF ( IPUNCH .EQ. 1 ) THEN
        WRITE (CPAGE(7,2)(:),'(A,19X,A)') 'Z ',CTEMP(1:LENGTH)
      ELSE IF ( IPUNCH .EQ. 2 ) THEN
        WRITE (NCPU,'(''<td width="15%"> </td><TD>Z =</TD><TD>'',
     1 A,''</TD></TR>'')')  CTEMP(1:LENGTH)
      END IF

      ZPRIME = Z30 / Z2

C----- CHECK IF LIST 5 LOADED
      IF (JLOAD(5).NE.1) GO TO 1750
C----- CHEMICAL FORMULA
CDJWMAR99[
      IBASE=KSTALL(NTERM*NNAMES)
C
C  FORMULA FROM LIST 29
cdjwjun04
      call xzerof (store(ibase),nterm*nnames)
      istore(ibase)=icarb
      store(ibase+1)=0.0
      istore(ibase+nterm)=KHYD
      store(ibase+nterm+1)=0.0
      nbase=2
      do 1510 m29=l29,l29+(n29-1)*md29,md29
c-----  get the character form of the name, as a unique code
         write (ctype,'(a4)') istore(m29)
         call xcras (ctype,nchar)
         itext=100*index(upper,ctype(1:1))+index(upper,ctype(2:2))
c 
         do j=ibase,ibase+(nbase-1)*nterm,nterm
            if (istore(j).eq.istore(m29)) then
               store(j+1)=store(j+1)+store(m29+4)
               istore(j+2)=j
               istore(j+3)=itext
               go to 1510
            end if
         end do
         j=ibase+nbase*nterm
         istore(j)=istore(m29)
         store(j+1)=store(m29+4)
         istore(j+2)=j
         istore(j+3)=itext
         nbase=nbase+1
1510  continue
c----- now sort on unique code, startting after (possible) h
      i=ibase+2*nterm
      j=max(0,nbase-2)
      k=nterm
      l=4
      call ssorti (i,j,k,l)
      j=1
      cline=' '
      jhtml=1
      chline=' '
      do 1720 i=ibase,ibase+(nbase-1)*nterm,nterm
cdjwmar99]
cDJW nov97
         if (store(i+1).le.zero) go to 1720
         itype=istore(i)
         write (ctype,1550) itype
         call xcras (ctype,length)
         if (length.ge.2) then
            cbuf=ctype(2:length)
            call xcclwc (cbuf(1:length-1),ctype(2:length))
         end if
         sum=store(i+1) / zprime
         nsum=nint(sum)
         if (amod(sum,1.0).le.zero) then
            write (ctemp,1600) nsum
         else
            write (ctemp,1650) sum
         end if
         call xcras (ctype,nchar)
         call xcras (ctemp,length)
         cline(j:)=' '//ctype(1:nchar)//ctemp(1:length)
         chline(jhtml:)=' '//ctype(1:nchar)//'<SUB>'//
     1                       ctemp(1:length)//'</SUB>'
         call xcrems (cline,cline,j)
         call xcrems (chline,chline,jhtml)
         call xctrim (cline,j)
         call xctrim (chline,jhtml)
1720  continue
      if (ipunch .eq. 0) then
       write(ncfpu1,'(1x)')
       write(ncfpu1,'(a,a)') '# Given Formula =', cline(1:j)
       write(ncfpu1,'(4(a,f10.2))')
     1 '# Dc =',a(6),' Fooo =', a(10), ' Mu =', a(8), ' M =', a(9)
      endif
C
cdjwjun04
C - FORMULA FROM LIST 5
      CALL XZEROF (STORE(IBASE),NTERM*NNAMES)
      ISTORE(IBASE)=ICARB
      STORE(IBASE+1)=0.0
      ISTORE(IBASE+NTERM)=KHYD
      STORE(IBASE+NTERM+1)=0.0
      NBASE=2
      DO 1500 M5=L5,L5+(N5-1)*MD5,MD5
C-----  GET THE CHARACTER FORM OF THE NAME, AS A UNIQUE CODE
         WRITE (CTYPE,'(A4)') ISTORE(M5)
         CALL XCRAS (CTYPE,NCHAR)
         ITEXT=100*INDEX(UPPER,CTYPE(1:1))+INDEX(UPPER,CTYPE(2:2))
C 
         DO J=IBASE,IBASE+(NBASE-1)*NTERM,NTERM
            IF (ISTORE(J).EQ.ISTORE(M5)) THEN
               STORE(J+1)=STORE(J+1)+STORE(M5+2)*STORE(M5+13)
               ISTORE(J+2)=J
               ISTORE(J+3)=ITEXT
               GO TO 1500
            END IF
         END DO
         J=IBASE+NBASE*NTERM
         ISTORE(J)=ISTORE(M5)
         STORE(J+1)=STORE(M5+2)*STORE(M5+13)
         ISTORE(J+2)=J
         ISTORE(J+3)=ITEXT
         NBASE=NBASE+1
1500  CONTINUE
C----- NOW SORT ON UNIQUE CODE, STARTTING AFTER (POSSIBLE) H
      I=IBASE+2*NTERM
      J=MAX(0,NBASE-2)
      K=NTERM
      L=4
      CALL SSORTI (I,J,K,L)
      J=1
      CLINE=' '
      JHTML=1
      CHLINE=' '
      DO 1700 I=IBASE,IBASE+(NBASE-1)*NTERM,NTERM
CDJWMAR99]
Cdjw NOV97
         IF (STORE(I+1).LE.ZERO) GO TO 1700
         ITYPE=ISTORE(I)
         WRITE (CTYPE,1550) ITYPE
1550     FORMAT (A4)
         CALL XCRAS (CTYPE,LENGTH)
         IF (LENGTH.GE.2) THEN
            CBUF=CTYPE(2:LENGTH)
            CALL XCCLWC (CBUF(1:LENGTH-1),CTYPE(2:LENGTH))
         END IF
         SUM=STORE(I+1) / ZPRIME
         NSUM=NINT(SUM)
         IF (AMOD(SUM,1.0).LE.ZERO) THEN
            WRITE (CTEMP,1600) NSUM
1600        FORMAT (I8)
         ELSE
            WRITE (CTEMP,1650) SUM
1650        FORMAT (F8.2)
         END IF
         CALL XCRAS (CTYPE,NCHAR)
         CALL XCRAS (CTEMP,LENGTH)
         CLINE(J:)=' '//CTYPE(1:NCHAR)//CTEMP(1:LENGTH)
         CHLINE(JHTML:)=' '//CTYPE(1:NCHAR)//'<sub>'//
     1                       CTEMP(1:LENGTH)//'</sub>'
         CALL XCREMS (CLINE,CLINE,J)
         CALL XCREMS (CHLINE,CHLINE,JHTML)
         CALL XCTRIM (CLINE,J)
         CALL XCTRIM (CHLINE,JHTML)
1700  CONTINUE
      IF (IPUNCH .EQ. 0) THEN
       WRITE(NCFPU1,'(A,A)') '# Found Formula =', cline(1:j)
       WRITE(NCFPU1,'(4(A,F10.2))')
     1 '# Dc =',A(1),' FOOO =', A(5), ' Mu =', A(3), ' M =', A(4)
       WRITE(NCFPU1,'(1x)')
      ENDIF
C

      IF ( IPUNCH .EQ. 0 ) THEN
        WRITE (NCFPU1,'(A,T35,A,A,A)') '_chemical_formula_sum','''',
     1  CLINE(2:MAX(2,J-1)),''''
        WRITE (NCFPU1,'(A,T35,A,A,A)') '_chemical_formula_moiety','''',
     1  CLINE(2:MAX(2,J-1)),''''
        WRITE (NCFPU1,'(''_chemical_compound_source'',T42,''?'')')
      ELSE IF ( IPUNCH .EQ. 1 ) THEN
        K=MIN(27,J)
        WRITE (CPAGE(2,1)(:),'(A,A)') 'Formula ',CLINE(1:K)
        IF (J.GE.28) THEN
          K=MIN(63,J)
          WRITE (CPAGE(2,2)(:),'(A)') CLINE(28:K)
        END IF
      ELSE IF ( IPUNCH .EQ. 2 ) THEN
        WRITE (NCPU,'(''<TR><TD>Formula</TD><TD>'',A,''</TD>'')')
     1   CHLINE(1:JHTML)
      END IF
 
C----- LIST 30
1750  CONTINUE
 
      IF (JLOAD(9).GE.1) THEN
c--   Machine type
c
C     UNKNOWN CAD4 MACH3 KAPPACCD DIP SMART IPDS XCALIBUR APEX2 GEMINI
C        1     2       3     4    5     6    7      8      9      10
c     SUPERNOVA
C       11
C----- PARAMETER 13 ON DIRECTIVE 2 IS A CHATACTER STRING: DIFFRACTOMETER MAKE
        IPARAM=13
        IDIR=2
        IVAL=ISTORE(L30CD+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)
        IDIFNO = IVAL+1

C----- PARAMETER 13 ON DIRECTIVE 1 IS A CHATACTER STRING: REDUCTION NAME
        IPARAM=13
        IDIR=1
        IVAL=ISTORE(L30DR+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)
        IREDNO = IVAL+1
c
c
c
        IF ( IPUNCH .EQ. 0 ) THEN
          WRITE (NCFPU1,'(''_chemical_formula_weight '',T35,F8.2)')
     1    STORE(L30GE+4) / ZPRIME
          IF (IEPROP .LT. 0) THEN
            CALL XPCIF ('# Structure does not match formula')
          ENDIF
          CALL XPCIF (' ')
          CALL XPCIF (' ')
          CLINE(1:18)='_cell_measurement_'
          WRITE (NCFPU1,'(A18, ''reflns_used '',T35,I8)') CLINE(1:18),
     1     NINT(STORE(L30CD+3))
          WRITE (NCFPU1,'(A18, ''theta_min '',T35,I8)') CLINE(1:18),
     1     NINT(STORE(L30CD+4))
          WRITE (NCFPU1,'(A18, ''theta_max '',T35,I8)') CLINE(1:18),
     1     NINT(STORE(L30CD+5))
          WRITE (NCFPU1,'(A18, ''temperature '',T35,I8)') CLINE(1:18),
     1     NINT(STORE(L30CD+6))
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(9,2)(:),'(A,17X,F8.2)') 'Mr ',STORE(L30GE+4)
          WRITE (CPAGE(13,1)(:),'(A,5X,I6,A)') 'Cell from',
     1     NINT(STORE(L30CD+3)),' Reflections'
          WRITE (CPAGE(13,2)(:),'(A,9X,I3,'' to ''I3)') 'Theta range',
     1     NINT(STORE(L30CD+4)),NINT(STORE(L30CD+5))
          WRITE (CPAGE(10,2)(:),'(A,5X,I6)') 'Temperature (K)',
     1     NINT(STORE(L30CD+6))
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(
     1           ''<td width="15%"> </td><TD>M<sub>r</sub></TD><TD>'',
     2           F8.2,''</TD></TR>'')') STORE(L30GE+4) / ZPRIME
           write(ncpu,9)
          WRITE (NCPU,9006) 'Cell determined from',NINT(STORE(L30CD+3)),
     1     ' reflections'
          WRITE (NCPU,'(
     1    ''<td width="15%"> </td><TD>Cell &theta; range =</TD><TD>'',
     2     I3,'' - '',I3,''&deg;</TD></TR>'')')
     3     NINT(STORE(L30CD+4)),NINT(STORE(L30CD+5))
          WRITE (NCPU,6) 'Temperature',NINT(STORE(L30CD+6)),'K'
          IF ( STORE(L30CF+12) .GT. 0.1 ) THEN
           write(ncpu,9)
            WRITE (NCPU,9006) 'Pressure ',NINT(STORE(L30CF+12)),' kPa'
          END IF
        END IF
 
 
        WRITE (CLINE,'(3X,8A4)') (ISTORE(K),K=L30SH,L30SH+MD30SH-1)
        CALL XCCLWC (CLINE(1:),CTEMP(1:))
        CALL XCTRIM (CTEMP,J)

        IF ( IPUNCH .EQ. 0 ) THEN
          CALL XPCIF (' ')
          CBUF(1:15)='_exptl_crystal_'
          WRITE (CLINE,'(A,''description '',T35,A,A,A)') CBUF(1:15),
     1     '''',CTEMP(4:MAX(4,J-1)),''''
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(12,2)(:),'(A,2X,A)') 'Shape',CTEMP(1:J)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TD>Shape</TD><TD>'',A,''</TD></TR>'')')
     1    CTEMP(1:J)
        END IF

        WRITE (CLINE,'(3X,8A4)') (ISTORE(K),K=L30CL,L30CL+MD30CL-1)
        CALL XCCLWC (CLINE(1:),CTEMP(1:))
        CALL XCTRIM (CTEMP,J)
        IF ( IPUNCH .EQ. 0 ) THEN
          WRITE (CLINE,'(A,''colour '',T35,A,A,A)') CBUF(1:15),'''',
     1     CTEMP(4:MAX(4,J-1)),''''
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(12,1)(:),'(A,1X,A)') 'Colour',CTEMP(1:J)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>Colour</TD><TD>'',A,''</TD>'')')
     1     CTEMP(1:J)
        END IF
 
        IF ( IPUNCH .EQ. 0 ) THEN
          DO I=1,3
           IF ( STORE(L30CD+I-1) .GT. ZERO ) THEN
            WRITE(CLINE,'(A,''size_'',A,T35,F6.3)')CBUF(1:15),CSIZE(I),
     1       STORE(L30CD+I-1)
           ELSE
            WRITE(CLINE,'(A,''size_'',A,T35,''?'')')CBUF(1:15),CSIZE(I)
           END IF
           CALL XPCIF (CLINE)
          END DO
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(11,1)(:),'(A,13X,F5.2,''x'',F5.2,''x'',F5.2)')
     1     'Size',STORE(L30CD),STORE(L30CD+1),STORE(L30CD+2)
        ELSE IF ( IPUNCH .EQ.2 ) THEN
          WRITE (NCPU,'(''<td width="15%"> </td><TD>Size</TD><TD>'',
     1   F5.2,'' &times; '',F5.2,'' &times; '',F5.2,'' mm</TD></TR>'')')
     1     STORE(L30CD),STORE(L30CD+1),STORE(L30CD+2)
        END IF

        IF ( IPUNCH .EQ. 0 ) THEN
          CALL XPCIF (' ')
          WRITE (CLINE,'(A,''density_diffrn'',T35,F6.3)') CBUF(1:15),
     1    STORE(L30GE+1)
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(9,1)(:),'(A,17X,F5.2)') 'Dx',STORE(L30GE+1)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>D<sub>x</sub></TD><TD>'',F5.2,
     1    '' Mg m<sup>-3</sup></TD>'')') STORE(L30GE+1)
        END IF
 
        IF ( IPUNCH .EQ. 0 ) THEN
          IF (STORE(L30GE).GT.ZERO) THEN
            WRITE (CLINE,'(A,''density_meas'',T35,F6.3)') CBUF(1:15),
     1       STORE(L30GE)
          ELSE
            WRITE (CLINE,1850) CBUF(1:15),'density_meas','?'
            CALL XPCIF (CLINE)
            WRITE (CLINE,1850) CBUF(1:15),'density_method',
     1      '''not measured'''
            CALL XPCIF (CLINE)
1850        FORMAT (A,A,T35,A)
          END IF
C
          WRITE (CLINE,'(''# Non-dispersive F(000):'')')
          CALL XPCIF (CLINE)
          IF ( MOD(STORE(L30GE+2),1.0) .GT. ZERO ) THEN
            WRITE (CLINE,'(A,''F_000'',T35,F13.3)')CBUF(1:15),
     1           STORE(L30GE+2)
          ELSE
            WRITE (CLINE,'(A,''F_000'',T35,I13)')CBUF(1:15),
     1           NINT(STORE(L30GE+2))
          ENDIF
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<td width="15%"> </td><TD>F000</TD><TD>'',
     1    F13.3,  ''</TD></TR>'')')  STORE(L30GE+2)
        END IF
 
        CBUF(1:15)='_exptl_absorpt_'
 
        IF ( IPUNCH .EQ. 0 ) THEN
          WRITE (CLINE,'(A,''coefficient_mu'',T35,F10.3)')CBUF(1:15),
     1     0.1*STORE(L30GE+3)
          CALL XPCIF (CLINE)
          CALL XPCIF (' ')
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
          WRITE (CPAGE(10,1)(:),'(A,13X,F9.3)') 'Mu',0.1*STORE(L30GE+3)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
          WRITE (NCPU,'(''<TR><TD>&mu;</TD><TD>'',F9.3,
     1        '' mm<sup>-1</sup></TD></TR> '')') 0.1*STORE(L30GE+3)
        END IF


C THE ABSORPTION DETAILS - ASSUME NO PATH ALONG AXIS!
        TMAX=EXP(-0.1*STORE(L30GE+3)*STORE(L30CD))
        TMIN=EXP(-0.1*STORE(L30GE+3)*STORE(L30CD+1))


C----- PARAMETER 9 ON DIRECTIVE 5 IS A CHARACTER STRING: ABSORPTION TYPE
        IPARAM=9
        IDIR=5
        IVAL=ISTORE(L30AB+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)
        IABVAL = MIN (IABSMX, IVAL + 1)
C
C NONE DIFABS EMPIRICAL MULTI-SCAN SADABS SORTAV SHELXA GAUSS ANALYT
C   1     2       3         4         5      6      7     8      9
C NUMER INTEGERATION SPHERICAL CYLINDRICAL PSI-SCAN 
c   10       11         12         13        14
C
        CMON(1) = ' '
        IF (TMIN.GT.3.0) THEN
            WRITE (CMON,'(A)') 'Analytical absorption correction mandato
     1ry for Acta C'
        ELSE IF (TMIN.GT.1.0) THEN
            WRITE (CMON,'(A,A)') 'A psi, empirical, multi-scan or analyt
     1ical absorption ','correction should be applied for Acta C'
        END IF
        IF (CMON(1)(1:1) .NE. ' ') THEN
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
            IF ( IPUNCH .EQ. 0 ) CALL XPCIF('# '//CMON(1)(:))
        ENDIF
C----- NOTE - WE CANNOT USE THE CRYSTALS CHARACTER STRING
        IF (IABVAL.EQ.1) THEN
            CVALUE='none'
            J=-1
        ELSE IF ((IABVAL.EQ.2).OR.(IABVAL.EQ.7)) THEN
            CVALUE='refdelf'
            J=6
        ELSE IF (IABVAL.EQ.3) THEN
            IF (L13DT.EQ.9) THEN
C           AREA DETECTOR
               CVALUE='multi-scan'
               J=4
            ELSE
               CVALUE='psi-scan'
               J=4
            END IF
        ELSE IF ((IABVAL.GE.4).AND.(IABVAL.LE.6)) THEN
C           AREA DETECTOR
            CVALUE='multi-scan'
            J=4
        ELSE IF (IABVAL.EQ.8) THEN
            CVALUE='gaussian'
            J=0
        ELSE IF (IABVAL.EQ.9) THEN
            CVALUE='analytical'
            J=0
        ELSE IF (IABVAL.EQ.10) THEN
            CVALUE='numerical'
            J=0
        ELSE IF (IABVAL.EQ.11) THEN
            CVALUE='integration'
            J=0
        ELSE IF (IABVAL.EQ.12) THEN
            CVALUE='sphere'
            J=2
        ELSE IF (IABVAL.EQ.13) THEN
            CVALUE='cylinder'
            J=2
        ELSE IF (IABVAL.EQ.14) THEN
            CVALUE='psi-scan'
            J=4
        ELSE IF (IABVAL.EQ.15) THEN
            CVALUE='Multi-scan'
            J=4
        ELSE
            CVALUE='?'
            J=-1
        END IF
        IF ( IPUNCH .EQ. 0 ) THEN
              WRITE (CLINE,'(
     1        ''# Sheldrick geometric approximations'',
     1        T35,2F8.2)') TMIN,TMAX
              CALL XPCIF (CLINE)
        END IF
C
C-----    A TMAX/TMIN FIX IN THE ABSENCE OF REAL INFO
        IF (J .NE. -1) THEN
          IF (STORE(L30AB+1+J) .LE. ZERO) THEN
            STORE(L30AB+J)  = TMIN
            STORE(L30AB+1+J) = TMAX
            IF ( IPUNCH .EQ. 0 ) THEN
              WRITE(CLINE,'(A)')
     1        '# No experimental values of Tmin/max available'
              CALL XPCIF(CLINE)
            ENDIF
          ENDIF
        ENDIF
C
        CLINE=' '
        WRITE (CLINE,'( A, ''correction_type '',A)') CBUF(1:15),CVALUE
        IF ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+1,1)(:),'(A,5X,A)') 'Absorption type',
     1      CVALUE
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,2) 'Absorption correction', CVALUE
        END IF
C
        IF (J.GE.0) THEN
          IF ( IPUNCH .ge. 0 ) THEN
            CLINE=' '
            WRITE (CLINE,'( A, ''process_details '')') CBUF(1:15)
            IVAL = IABSCD(IABVAL)
            if(j .eq. 4) then
              if((idifno.eq.6).or.(idifno.eq.9)) then 
c               SADABS
                ival = iabscd(5) 
              else if((idifno.eq.8).or.(idifno.eq.10).or.
     1          (idifno.eq.11)) then
c               Agilent
                ival = iabscd(16)
              else if(idifno.eq.4) then
                ival = iabscd(4)
              endif
            endif
            CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
            CALL XCTRIM (CTEMP,NCHAR)
            IF ( IPUNCH .EQ. 0 ) THEN
             IF ( NCHAR .LE. 45 ) THEN
               WRITE(CLINE(35:),'('''''''',A,'''''''')')CTEMP(2:NCHAR-1)
               CALL XPCIF (CLINE)
             ELSE
              CALL XPCIF (CLINE)
              CALL XPCIF (';')
              WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
              CALL XPCIF (CLINE)
              CALL XPCIF (';')
             END IF
            END IF
            if ( ipunch .eq. 2 ) write(ncpu,9)
            DO I=1,3,2
              IF ( IPUNCH .EQ. 0 ) THEN
                WRITE (CLINE,'(A,''correction_T_'', A, F8.2)')
     1           CBUF(1:15),CSIZE(I),
     2           STORE(L30AB-1+J+(I+1)/2) / STORE(L30AB+1+J) * TMAX
                CALL XPCIF (CLINE)
              ELSE IF ( IPUNCH .EQ. 1 ) THEN
                WRITE (CPAGE(IDATA+1,2)(:),'(A,2X,2F5.2)')
     1           'Transmission range',
     2           STORE(L30AB-1+J+(1+1)/2)/STORE(L30AB+1+J)*TMAX,
     3           STORE(L30AB-1+J+(3+1)/2)/STORE(L30AB+1+J)*TMAX
              ELSE IF ( IPUNCH .EQ. 2 ) THEN

              WRITE (NCPU,'(a,a,a,F8.2)')
     1           '<TD>T<sub>', csize(i), '</sub></TD> <TD>',
     2           STORE(L30AB-1+J+(I+1)/2) / STORE(L30AB+1+J) * TMAX
              write(ncpu,'(a)')'</td>' 
              IF (i .EQ. 1) WRITE(NCPU,'(A)')'<td width="15%"> </td>'
              END IF
            END DO
            if ( ipunch .eq. 2 ) write(ncpu,9009)
          END IF
        ELSE
           IF ( IPUNCH .EQ. 0 ) THEN
c dont output anything if abs correction is 'none', J=-1
c             WRITE (CLINE,'(A,''correction_T_'', A, F8.4)') CBUF(1:15),
c     1        CSIZE(1),TMIN
c             CALL XPCIF (CLINE)
c             WRITE (CLINE,'(A,''correction_T_'', A, F8.4)') CBUF(1:15),
c     1        CSIZE(3),TMAX
c             CALL XPCIF (CLINE)
              CONTINUE
           ELSE IF ( IPUNCH .EQ. 1 ) THEN
             WRITE (CPAGE(IDATA+1,2)(:),'(A,2X,2F5.2)')
     1        'Transmission range',TMIN,TMAX
           ELSE IF ( IPUNCH .EQ. 2 ) THEN
           write(ncpu,9)
             WRITE (NCPU,9003)'T<sub>min</sub>',TMIN
             write(ncpu,'(a)')'<td width="15%"> </td>' 
             WRITE (NCPU,9003)'T<sub>max</sub>',TMAX
           write(ncpu,9009)
           END IF
        END IF




        IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''</TABLE></FONT>'')')
           WRITE (NCPU,'(''<H2>Data Collection</H2>'')')
           WRITE (NCPU,'(''<FONT SIZE="-1"><TABLE>'')')
        END IF
c
cdjw0705
        IF ((IDIFNO.EQ. 4) .AND. (IPUNCH .EQ. 0)) THEN
            WRITE(Cline,'(A)')
     1 '# For a Kappa CCD, set Tmin to 1.0 and'
             CALL XPCIF (CLINE)
            WRITE(Cline,'(A)')
     1 '# Tmax to the ratio of max:min frame scales in scale_all.log'
             CALL XPCIF (CLINE)
        ENDIF
        CALL XCREMS (CVALUE,CVALUE,NCHAR)
        CALL XCTRIM (CVALUE,NCHAR)
        IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA,1)(:),'(A,1X,A)') 'Diffractometer type',
     1     CVALUE(1:NCHAR)
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''<TR><TD>Diffractometer</TD><TD>'',A,
     1       ''</TD></TR>'')')  CVALUE(1:NCHAR)
        ELSE IF ( IPUNCH .EQ. 0 ) THEN
           IF (IDIFNO .EQ. 1) THEN
C- UNKNOWN
             CTEMP='Unknown'
           ELSE IF (IDIFNO .EQ. 2) THEN
C- CAD4
             CTEMP='Enraf-Nonius CAD4'
           ELSE IF (IDIFNO .EQ. 3) THEN
C- MACH3
             CTEMP='Enraf-Nonius Mach3'
           ELSE IF (IDIFNO .EQ. 4) THEN
C- KAPPACCD
             CTEMP='Nonius KappaCCD'
           ELSE IF (IDIFNO .EQ. 5) THEN
C- DIP
             CTEMP='Nonius DIP2000'
           ELSE IF (IDIFNO .EQ. 6) THEN
C- SMART
             CTEMP='Bruker SMART'
           ELSE IF (IDIFNO .EQ. 7) THEN
C- IPDS
             CTEMP='Stoe IPDS'
           ELSE IF (IDIFNO .EQ. 8) THEN
C- XCALIBUR
             CTEMP='Oxford Diffraction XCALIBUR'
           ELSE IF (IDIFNO .EQ. 9) THEN
C- Apex2
             CTEMP='Bruker Kappa Apex2'
           ELSE IF (IDIFNO .EQ. 10) THEN
C- GEMINI
             CTEMP='Oxford Diffraction Gemini'

           ELSE IF (IDIFNO .EQ. 11) THEN
C- SUPERNOVA
             CTEMP='Oxford Diffraction SuperNova'
C- Unknown
           ELSE IF (IDIFNO .GT. IDIFMX) THEN
             WRITE(CMON,'(A)') 'Unknown Diffractometer type'
             CALL XPRVDU(NCVDU,1,0)
             CTEMP='Unknown'
             IDIFNO = 1
           ENDIF
           CALL XCTRIM (CTEMP,NCHAR)
C
           WRITE (CLINE,'(''_diffrn_measurement_device_type'',
     1      T35,'''''''',A,'''''''')') CTEMP(1:NCHAR-1)
           CALL XPCIF (CLINE)
c
           IF (IDIFNO .LE. 3) THEN
            CTEMP = 'Serial'
           ELSE
            CTEMP = 'Area'
           ENDIF
           CALL XCTRIM (CTEMP,NCHAR)
C
           WRITE (CLINE,'(''_diffrn_measurement_device'',
     1      T35,'''''''',A,'''''''')') CTEMP(1:NCHAR-1)
           CALL XPCIF (CLINE)
C
           WRITE (CLINE,'(A)') 
     1     '_diffrn_radiation_monochromator      ''graphite'''
           CALL XPCIF (CLINE)
        END IF
      END IF
C--- END OF LIST 30
C
C    LIST 13
      IF (JLOAD(6).GE.1) THEN
         CBUF(1:8)='''  ?   '''
         IF (NINT(10.*STORE(L13DC)).EQ.7) THEN
#if !defined(_MAC_)
            CBUF(1:8) = '''Mo K\a'''
#else
            CBUF(1:8) = '''Mo K\\a'''
#endif
         ELSE IF (NINT(10.*STORE(L13DC)).EQ.15) THEN
#if !defined(_MAC_)
            CBUF(1:8) = '''Cu K\a'''
#else
            CBUF(1:8) = '''Cu K\\a'''
#endif
         END IF
         IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (NCFPU1,'(''_diffrn_radiation_type       '', T35, A)')
     1      CBUF(1:8)
           WRITE (NCFPU1,'(''_diffrn_radiation_wavelength '', T35,
     1      F12.5)') STORE(L13DC)
         ELSE  IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(8,1)(:),'(A,4X,A)') 'Radiation type',CBUF(2:7)
           WRITE (CPAGE(8,2)(:),'(A,5X,F10.6)')'Wavelength',STORE(L13DC)
         END IF
      END IF

      IF (JLOAD(9).GE.1) THEN
C----- PARAMETER 10 ON DIRECTIVE 2 IS A CHARACTER STRING
C SCAN MODE DETAILS
        IPARAM=10
        IDIR=2
        IVAL=ISTORE(L30CD+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)
        CALL XCTRIM (CVALUE,NCHAR)
        IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA,2)(:),'(A,4X,A)') 'Scan type ',
     1      CVALUE(1:NCHAR)
C RIC2001 New scan types. Use IVAL, not char string.
        ELSE IF ( IPUNCH .EQ. 0 ) THEN
           IF ( IVAL .EQ. 1 ) THEN
#if defined(_MAC_)
            CVALUE = '\\w/2\\q'
#else
            CVALUE = '\w/2\q'
#endif
             CALL XCRAS (CVALUE,J)
           ELSE IF ( IVAL .EQ. 2 ) THEN
#if defined(_MAC_)
            CVALUE = '\\w'
#else
            CVALUE = '\w'
#endif
             CALL XCRAS (CVALUE,J)
           ELSE IF ( IVAL .EQ. 3 ) THEN
             CVALUE = '''\f scans'''
           ELSE IF ( IVAL .EQ. 4 ) THEN
#if defined(_MAC_)
             CVALUE = '''\\f & \\w scans'''
#else
             CVALUE = '''\f & \w scans'''
#endif
           ELSE
             CVALUE = '?'
           END IF
           CLINE=' '
           WRITE (CLINE,'( ''_diffrn_measurement_method '',A)') CVALUE
           CALL XPCIF (CLINE)
           CALL XPCIF (' ')
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           IF ( IVAL .EQ. 1 ) THEN
              WRITE(NCPU,2)'Scan type','2&theta;/&omega; scans'
           ELSE IF ( IVAL .EQ. 2 ) THEN
              WRITE(NCPU,2)'Scan type','&omega; scans'
           ELSE IF ( IVAL .EQ. 3 ) THEN
              WRITE(NCPU,2)'Scan type','&phi; scans'
           ELSE IF ( IVAL .EQ. 4 ) THEN
              WRITE(NCPU,2)'Scan type','&phi; and &omega; scans'
           ELSE
              WRITE(NCPU,2)'Scan type','unknown'
           END IF
        END IF


C
        IF ( IPUNCH .EQ. 0 ) THEN
cdjw0705
          WRITE(Cline,'(A)')
     1 '# If a reference occurs more than once, delete the author'
          CALL XPCIF (CLINE)
          WRITE(Cline,'(A)')
     1 '# and date from subsequent references.'
          CALL XPCIF (CLINE)
c
c
           IVAL = IREFCD(1,IDIFNO)
           CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_data_collection'' )')
           IF ( NCHAR .LE. 45 ) THEN
             WRITE(CLINE(35:),'('''''''',A,'''''''')')CTEMP(2:NCHAR-1)
             CALL XPCIF (CLINE)
           ELSE
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
             WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
           END IF
        END IF
C
        IF ( IPUNCH .EQ. 0 ) THEN
           IVAL = IREFCD(3,IDIFNO)
           CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_cell_refinement '' )') 
           IF ( NCHAR .LE. 45 ) THEN
             WRITE(CLINE(35:),'('''''''',A,'''''''')')CTEMP(2:NCHAR-1)
             CALL XPCIF (CLINE)
           ELSE
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
             WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
           END IF
        END IF
C
C
        IF ( IPUNCH .EQ. 0 ) THEN
           IVAL = IREDCD(IREDNO)
           CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_data_reduction'' )') 
           IF ( NCHAR .LE. 45 ) THEN
             WRITE(CLINE(35:),'('''''''',A,'''''''')')CTEMP(2:NCHAR-1)
             CALL XPCIF (CLINE)
           ELSE
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
             WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
           END IF
        END IF
C----- DIRECT METHODS.
C----- PARAMETER 13 ON DIRECTIVE 6 IS A CHARACTER STRING
        IF ( IPUNCH .EQ. 0 ) THEN
           IPARAM=13
           IDIR=6
           IVAL=ISTORE(L30GE+IPARAM-1)
           IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1                  IVAL,JVAL,VAL,JTYPE)
           ISOLVE = IVAL
           IVAL = ISOLCD(IVAL+1)
           CTEMP = CREFMK(ISTORE(LREFS), NREFS, MDREFS, IVAL)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_structure_solution '' )')
           IF ( NCHAR .LE. 45 ) THEN
             WRITE(CLINE(35:),'('''''''',A,'''''''')')CTEMP(2:NCHAR-1)
             CALL XPCIF (CLINE)
           ELSE
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
             WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
           END IF
        END IF


        IF ( IPUNCH .EQ. 0 ) THEN
           ival=22
           ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_structure_refinement'' )') 
           IF ( NCHAR .LE. 45 ) THEN
             WRITE(CLINE(35:),'('''''''',A,'''''''')')CTEMP(2:NCHAR-1)
             CALL XPCIF (CLINE)
           ELSE
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
             WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
           END IF

           WRITE (CLINE,'(''_computing_publication_material'' )') 
           IF ( NCHAR .LE. 45 ) THEN
             WRITE(CLINE(35:),'('''''''',A,'''''''')')CTEMP(2:NCHAR-1)
             CALL XPCIF (CLINE)
           ELSE
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
             WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
           END IF

           ival=23
           ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
           CALL XCTRIM (CTEMP,NCHAR)
           WRITE (CLINE,'(''_computing_molecular_graphics'' )') 
           IF ( NCHAR .LE. 45 ) THEN
             WRITE(CLINE(35:),'('''''''',A,'''''''')')CTEMP(2:NCHAR-1)
             CALL XPCIF (CLINE)
           ELSE
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
             WRITE (CLINE,'(A )')CTEMP(1:NCHAR)
             CALL XPCIF (CLINE)
             CALL XPCIF (';')
           END IF

        END IF
C


C
        IF ( IPUNCH .EQ. 0 ) THEN
          CALL XPCIF (' ')
          CBUF(1:18)='_diffrn_standards_'
C
          IF (NINT(STORE(L30CD+10)) .GT. 0 ) THEN
           WRITE (CLINE,'(A, ''interval_time '',I8)') CBUF(1:18),
     1      NINT(STORE(L30CD+10))
          ELSE
           WRITE (CLINE,'(A, ''interval_time  .'')') CBUF(1:18)
          END IF
          CALL XPCIF (CLINE)
          IF (NINT(STORE(L30CD+11)) .GT. 0 ) THEN
           WRITE (CLINE,'(A, ''interval_count '',I8)') CBUF(1:18),
     1      NINT(STORE(L30CD+11))
          ELSE
           WRITE (CLINE,'(A, ''interval_count  .'')') CBUF(1:18)
          END IF
          CALL XPCIF (CLINE)
C 
          WRITE (CLINE,'(A, ''number '', I8)') CBUF(1:18),
     1      NINT(STORE(L30CD+7))
          CALL XPCIF (CLINE)
C 
          IF (NINT(STORE(L30CD+7)) .GT. 0 ) THEN
           WRITE (CLINE,'(A, ''decay_% '', F6.2)') CBUF(1:18),
     1      STORE(L30CD+8)
          ELSE
           WRITE (CLINE,'(A, ''decay_%  ?'')') CBUF(1:18)
          END IF
          CALL XPCIF (CLINE)
          CALL XPCIF (' ')
C 
          WRITE (NCFPU1,'(''_diffrn_ambient_temperature '',I10)')
     1      NINT(STORE(L30CD+6))

          IF ( STORE(L30CF+12) .GT. 0.1 ) THEN
             WRITE (NCFPU1,'(''_diffrn_ambient_pressure '',I10)')
     1       NINT(STORE(L30CF+12))
          END IF
C 
          CBUF(1:15)='_diffrn_reflns_'
C 
          CLINE=' '
          WRITE (CLINE,'(A, ''number '', I10)') CBUF(1:15),
     1      NINT(STORE(L30DR))
          CALL XPCIF (CLINE)
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+2,1)(:),'(''Reflections measured '', I8)')
     1      NINT(STORE(L30DR))
           WRITE (CPAGE(14,1)(:),'(''Standard Interval '',I8)')
     1      NINT(STORE(L30CD+11))
           WRITE (CPAGE(14,2)(:),'(''Standard Count '',3X, I8)')
     1      NINT(STORE(L30CD+7))
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
            WRITE (NCPU,4) 'Reflections measured', NINT(STORE(L30DR))
        END IF
 

c      write(ncwu,*)'List 6 total', n6d, store(l30dr), store(l30dr+2),
c     1 store(l30dr+4)
        IF ((n6d .gt. nint(STORE(L30DR+4))) .and. 
     1     (store(l30dr+2).gt. zero)) THEN
           IF (ISSPRT .EQ. 0) WRITE(NCWU,'(a)') 'Friedels Law used'
C----- FRIEDELS LAW USED
           I=2
        ELSE
           I=4
        END IF
cdjwjun09        J=MIN(NINT(STORE(L30DR+I)),NINT(STORE(L30DR)))
        J=NINT(STORE(L30DR+I))
        IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+2,2)(:),
     1      '(''Independent reflections'',I7)') J
           WRITE (CPAGE(IDATA+3,1)(:),'(''Rint '', 14X,F10.4)')
     1      STORE(L30DR+1+I)*.01
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,4) 'Independent reflections', J
           WRITE (NCPU,5) 'Rint ', STORE(L30DR+1+I)
        ELSE IF ( IPUNCH .EQ. 0 ) THEN
           CLINE=' '
           WRITE (CLINE,'(''_reflns_number_total '')')
           CTEMP(1:)=CLINE(1:15)
           WRITE (CLINE(22:),'(I10)') J
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''av_R_equivalents '', F10.3)')
     1      CBUF(1:15), STORE(L30DR+1+I)
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A,I6)')
     1      '# Number of reflections without Friedels Law is ',
     2      NINT(STORE(L30DR+2))
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A,I6)')
     1      '# Number of reflections with Friedels Law is ',
     2      NINT(STORE(L30DR+4))
           CALL XPCIF (CLINE)
C----- TRY FOR A FRIEDEL MERGE ESTIMATE
           IF (STORE(L30DR+2).GT.ZERO) I=2
           IF (JLOAD(2)*JLOAD(1).GE.1) THEN
             TMP= 8. * ( (PI*STORE(L1P1+6)) / (6.*(3-(I/2))*N2P*N2)
     1       *((2. * SIN(DTR*STORE(L30IX+7)))/STORE(L13DC))**3)
             IF (TMP.GT.ZERO) THEN
               WRITE (CLINE,'(A,I6)')
     1          '# Theoretical number of reflections is about',NINT(TMP)
               CALL XPCIF (CLINE)
             END IF
           END IF
           CALL XPCIF (' ')
           CALL XPCIF (' ')
        END IF

        INRIC = 0
        IGLS  = 0

cdjwnov05-check list 6
        if (kexist(6) .gt. 0) then
         CALL XTHLIM (THMIN, THMAX,THMCMP, THBEST,THBCMP,
     1   INRIC,IULN,IGLS)
 
         IF ( IPUNCH .EQ. 0 ) THEN
           CBUF(1:21)='_diffrn_reflns_theta_'
           WRITE (CLINE,'(A,''min '', F10.3)') CBUF(1:21), THMIN
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A,''max '', F10.3)') CBUF(1:21), THMAX
           CALL XPCIF (CLINE)
           CBUF(9:32)='measured_fraction_theta_'
           WRITE (CLINE,'(A,''max '',F10.3)') CBUF(1:32), THMCMP
           CALL XPCIF (CLINE)

           CALL XPCIF (' ')

           CBUF(9:21)='reflns_theta_'
           WRITE (CLINE,'(A,''full '', F10.3)') CBUF(1:21), ABS(THBEST)
           CALL XPCIF (CLINE)
           CBUF(9:32)='measured_fraction_theta_'
           WRITE (CLINE,'(A,''full '',F10.3)') CBUF(1:32), THBCMP
           CALL XPCIF (CLINE)

           CALL XPCIF (' ')
           CALL XPCIF (' ')
           CBUF(1:15)='_diffrn_reflns_'
         ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+3,2)(:),'(''Theta max '', 10X,              
     1     f10.2)') STORE(L30IX+7)
         ELSE IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,5) '&theta;<sub>max</sub>', STORE(L30IX+7)
         END IF
 
C----- RELECTION LIMITS IN DATA COLLECTION
         K=0
         DO I=1,3
           DO J=1,3,2
             IF ( IPUNCH .EQ. 0 ) THEN
               WRITE (CLINE,'(A, ''limit_'',A,A, I10)') CBUF(1:15),
     1          CINDEX(I),CSIZE(J),NINT(STORE(L30IX+K))
               CALL XPCIF (CLINE)
             END IF
             K=K+1
           END DO
           IF ( IPUNCH .EQ. 1 ) THEN
             WRITE (CPAGE(IDATA+I+3,1)(22:),'(2I6)')
     1        NINT(STORE(L30IX+K-2)),NINT(STORE(L30IX+K-1))
           ELSE IF ( IPUNCH .EQ. 2 ) THEN
610      FORMAT('<TR><TD>',A,'</TD><TD>',I4,' &rarr; ',I4,'</TD></TR>')
             WRITE (NCPU,610) CINDEX(I)(1:1)//' = ',
     1       NINT(STORE(L30IX+K-2)),NINT(STORE(L30IX+K-1))
           END IF
         END DO

 
         IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IDATA+4,1)(1:15),'(A)') 'Hmin, Hmax'
           WRITE (CPAGE(IDATA+5,1)(1:15),'(A)') 'Kmin, Kmax'
           WRITE (CPAGE(IDATA+6,1)(1:15),'(A)') 'Lmin, Lmax'
         END IF


         IF ( IPUNCH .EQ. 2 ) THEN
           WRITE (NCPU,'(''</TABLE></FONT>'')')
           WRITE (NCPU,'(''<H2>Refinement</H2>'')')
           WRITE (NCPU,'(''<FONT SIZE="-1"><TABLE>'')')
         END IF

         IF ( IPUNCH .EQ. 0 ) THEN
           IF (JLOAD(12).GE.1) THEN  !REFLECTION LIMITS IN COMPUTATIONS
             JLOAD(11)=1
             M6DTL=L6DTL
             IF (N6DTL.GE.4) THEN
               DO I=1,3    !LOOP OVER EACH INDEX
                  IF (STORE(M6DTL+3)-ZERO) 2250,2150,2150 !CHECK DETAIL SET
2150              CONTINUE   ! PRINT THE DETAILS
                  K=0
                  DO J=1,3,2
                     WRITE (CLINE,'(''_reflns_limit_'',A,A, I10)')
     1                CINDEX(I),CSIZE(J),NINT(STORE(K+M6DTL))
                     K=K+1
                     CALL XPCIF (CLINE)
                  END DO
2250              CONTINUE
                  M6DTL=M6DTL+MD6DTL  !UPDATE FOR THE NEXT PARAMETER
               END DO
             END IF
           END IF
         END IF

         IF ( IPUNCH .EQ. 0 ) THEN
           CBUF(1:22)='_oxford_diffrn_Wilson_'
           CALL XPCIF (' ')
           WRITE (CLINE,'(A, ''B_factor '', F8.2)') CBUF(1:22),
     1     STORE(L30DR+6)
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''scale '', F8.2)') CBUF(1:22),
     1     STORE(L30DR+7)
           CALL XPCIF (CLINE)
         END IF
        endif
cdjwnov05-end of list 6 goodies

        IF ( IPUNCH .EQ. 0 ) THEN
cdjwnov2011 - make all text lowercase - requested by ALT
           CSOLVE ='direct'
           IF(ISOLVE.EQ. 0) THEN
                  CSOLVE='Other'
            ELSE IF (ISOLVE .EQ. 4) THEN
                  CSOLVE='Heavy'
            ELSE IF (ISOLVE .EQ. 6) THEN
                  CSOLVE='Other'
            ELSE IF (ISOLVE .EQ. 7) THEN
                  CSOLVE='Other'
            ENDIF
           CALL XPCIF (' ')
        WRITE (NCFPU1,'(''_atom_sites_solution_primary '',T35,A,
     1   '' #heavy,direct,difmap,geom'')')CSOLVE
        WRITE (NCFPU1,'(''# _atom_sites_solution_secondary '',T35,
     1   ''difmap'')')
        WRITE (NCFPU1,'(''_atom_sites_solution_hydrogens '',T35,
     1   ''difmap'')')
           CALL XPCIF (' ')
           CBUF(1:21)='_refine_diff_density_'
           J=1
           IF( ( ABS(STORE(L30RF+5)) .LT. 0.000001 ) .AND.
     1       ( ABS(STORE(L30RF+5)) .LT. 0.000001 ) ) THEN
             DO K=1,2
               WRITE (CLINE,'(A, A,1X,A)') CBUF(1:21),CSIZE(J), '?'
               CALL XPCIF (CLINE)
               J=J+2
             END DO
           ELSE
             DO K=1,2
               WRITE (CLINE,'(A, A, F10.2)') CBUF(1:21),CSIZE(J),
     1         (STORE(L30RF+4+K))
               CALL XPCIF (CLINE)
               J=J+2
             END DO
           END IF
           CALL XPCIF (' ')
           CALL XPCIF (' ')
           IF ( STORE(L30RF+3) .LT. -9.9 ) THEN
             LCUTUS = 0
           ELSE
             LCUTUS = 1
           END IF


C 
      call xpcif
     1 ('# The current dictionary definitions do not cover the')
      call xpcif
     1 ('# situation where the reflections used for refinement were')
      call xpcif
     1 ('# selected by a user-defined sigma threshold ')
           CALL XPCIF (' ')
           CALL XPCIF (' ')

           CALL XPCIF 
     1     ('# The values actually used during refinement')
#if !defined(_MAC_)
           WRITE(CBUF,'(''I>'',F6.1,''\s(I)'')') STORE(L30RF+3)
#else
           WRITE(CBUF,'(''I>'',F6.1,''\\s(I)'')') STORE(L30RF+3)
#endif
           CALL XCRAS (CBUF,NCHAR)
           WRITE (NCFPU1,'(''_oxford_reflns_threshold_expression_ref '',
     1                    T45,A)')  CBUF(1:NCHAR) 
           CBUF(1:11)='_refine_ls_'
           WRITE (CLINE,'(A, ''number_reflns '', I10)') CBUF(1:11),
     1                    NINT(STORE(L30RF+8))
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''number_restraints '', I10)') CBUF(1:11),
     1                   NINT(STORE(L30CF+13))
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''number_parameters '', I10)') CBUF(1:11),
     1                   NINT(STORE(L30RF+2))
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(''_oxford'',A,''R_factor_ref '',F10.4)') 
     1                   CBUF(1:11), STORE(L30RF+0)*0.01
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''wR_factor_ref '', F10.4)') CBUF(1:11),
     1                   STORE(L30RF+1)*0.01
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''goodness_of_fit_ref '', F10.4)')
     1                   CBUF(1:11),STORE(L30RF+4)
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(A, ''shift/su_max '', F10.7)') CBUF(1:11),
     1            STORE(L30RF+7)
           CALL XPCIF (CLINE)
c-try to catch old DSC files where +11 held minimisation function
           IF (STORE(L30RF+11) .LE. 10.) THEN
            WRITE (CLINE,'(A, ''shift/su_mean '', F10.7)') CBUF(1:11),
     1            STORE(L30RF+11)
            CALL XPCIF (CLINE)
           END IF
           CALL XPCIF (' ')
C
           CALL XPCIF (' ')
           CALL XPCIF 
     1     ('# The values computed with all filters except I/sigma')

           WRITE (CLINE,'(''_oxford_reflns_number_all '', I10)')
     1                  NINT(STORE(L30CF+5))
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(''_refine_ls_R_factor_all '', F10.4)')
     1                  STORE(L30CF+6)*0.01
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(''_refine_ls_wR_factor_all '', F10.4)')
     1                  STORE(L30CF+7)*0.01
           CALL XPCIF (CLINE)
C
           CALL XPCIF (' ')
cdjw may07 - removed so that 2 sigma cut is always shown
c           IF ( LCUTUS .EQ. 0 ) THEN
c             WRITE (NCFPU1,1)
c     1       '# No actual I/u(I) cutoff was used for refinement. The'
c             WRITE (NCFPU1,1)
c     1       '# threshold below is used for "_gt" information ONLY:'
c           ELSE
c             WRITE (NCFPU1,
c     1    '(''# The I/u(I) cutoff below was used for refinement as '')')
c             WRITE (NCFPU1,
c     1      '(''# well as the _gt R-factors:'')')
c           END IF
           CALL XPCIF 
     1     ('# The values computed with a 2 sigma cutoff - a la SHELX')

#if !defined(_MAC_)
           WRITE(CBUF,'(''I>'',F6.1,''\s(I)'')') STORE(L30CF+0)
#else
           WRITE(CBUF,'(''I>'',F6.1,''\\s(I)'')') STORE(L30CF+0)
#endif
           CALL XCRAS (CBUF,NCHAR)
           WRITE (NCFPU1,'(''_reflns_threshold_expression '',T35,A)')
     1                 CBUF(1:NCHAR)
           CBUF(1:11)='_refine_ls_'
           WRITE (CLINE,'(''_reflns_number_gt '', I10)')
     1                 NINT(STORE(L30CF+1))
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(''_refine_ls_R_factor_gt '', F10.4)')
     1                 STORE(L30CF+2)*0.01
           CALL XPCIF (CLINE)
           WRITE (CLINE,'(''_refine_ls_wR_factor_gt '', F10.4)')
     1                 STORE(L30CF+3)*0.01
           CALL XPCIF (CLINE)
           CALL XPCIF (' ')
C
C
        ELSE IF ( IPUNCH .EQ. 1 ) THEN
C 
           WRITE (CPAGE(IREF+3,1)(:),'(A,6X,F10.2)') 'Delta Rho min',
     1      STORE(L30RF+5)
           WRITE (CPAGE(IREF+3,2)(:),'(A,7XF10.2)') 'Delta Rho max',
     1      STORE(L30RF+6)
           WRITE (CPAGE(IREF+4,1)(:),'(A,3X,I10)') 'Reflections used',
     1      NINT(STORE(L30RF+8))
           WRITE (CPAGE(IREF+4,2)(:),'(A,6X,F10.2)') 'sigma(I) limit',
     1      STORE(L30RF+3)
           WRITE (CPAGE(IREF+5,1)(:),'(A,I9)') 'Number of parameters',
     1      NINT(STORE(L30RF+2))
           WRITE (CPAGE(IREF+5,2)(:),'(A,5X,F10.3)') 'Goodness of fit',
     1      STORE(L30RF+4)
           WRITE (CPAGE(IREF+1,1)(:),'(A,11X,F10.3)') 'R-factor',
     1      STORE(L30RF)*0.01
           WRITE (CPAGE(IREF+1,2)(:),'(A,3X,F10.3)')'Weighted R-factor',
     1      STORE(L30RF+1)*0.01
           WRITE (CPAGE(IREF+2,2)(:),'(A,8X,F10.4)') 'Max shift/su',
     1      STORE(L30RF+7)

        ELSE IF ( IPUNCH .EQ. 2 ) THEN
 
           WRITE (NCPU,7) '&Delta;&rho;<sub>min</sub> =',
     1      STORE(L30RF+5), ' e &Aring;<sup>-3</sup>'
           WRITE (NCPU,7) '&Delta;&rho;<sub>max</sub> =',
     1      STORE(L30RF+6), ' e &Aring;<sup>-3</sup>'
           WRITE (NCPU,4) 'Reflections used',NINT(STORE(L30RF+8))
           WRITE (NCPU,7) 'Cutoff: I > ', STORE(L30RF+3), '&sigma;(I)'
           WRITE (NCPU,4) 'Parameters refined',NINT(STORE(L30RF+2))
           WRITE (NCPU,7) 'S = ', STORE(L30RF+4), ''
           WRITE (NCPU,8) 'R-factor', STORE(L30RF)*0.01
           WRITE (NCPU,8) 'weighted R-factor', STORE(L30RF+1)*0.01
           WRITE (NCPU,5) '&Delta;/&sigma;<sub>max</sub>',STORE(L30RF+7)
        END IF
C 
        IF (STORE(L30GE+7).GT.ZEROSQ) THEN
            IF (STORE(L30GE+6).GT.0.5+ZERO) THEN
               WRITE (CMON,2400)
2400           FORMAT ('The Flack parameter is greater than 0.5',
     1         'The structure may need inverting')
               CALL XPRVDU (NCVDU,1,0)
            END IF
C----- PACK UP THE FLACK PARAMETER AND ITS ESD
            CALL XFILL (IB,IVEC,16)
            CALL SNUM (STORE(L30GE+6),STORE(L30GE+7),-0,0,10,IVEC)
            WRITE (CTEMP,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CTEMP,N)
            IF ((ISTORE(L13CD) .EQ. 0) .and. 
     1          (STORE(L30GE+7) .GT. ZERO)) THEN
             WRITE(CLINE,'(A,A)')  
     1       '# The Flack parameter was determined before',
     2       ' Friedel pairs were merged'
             CALL XPCIF (CLINE)
            ENDIF
            CBUF(1:11)='_refine_ls_'
            IF ( IPUNCH .EQ. 0 ) THEN
              WRITE (CLINE,'(A, ''abs_structure_Flack  '', 4X, A )')
     2         CBUF(1:11),CTEMP(1:N)
              CALL XPCIF (CLINE)
            ELSE IF ( IPUNCH .EQ. 1 ) THEN
              WRITE (CPAGE(IREF+7,1)(:),'(A,A)') 'Flack parameter',
     1         CTEMP(1:N)
            ELSE IF ( IPUNCH .EQ. 2 ) THEN
              WRITE (NCPU,2) 'Flack parameter',
     1         CTEMP(1:N)
            END IF
 
            WRITE (CTEMP,'(I12)') MAX(0,NINT(STORE(L30DR+2)-
     1       STORE(L30DR+4)))
            CALL XCRAS (CTEMP,N)
            IF ( IPUNCH .EQ. 0 ) THEN
              WRITE (CLINE,'(A, ''abs_structure_details  '', 4X,          
     1        ''''''Flack (1983), '',                                            
     2        A, '' Friedel-pairs'''''')') CBUF(1:11),CTEMP(1:N)
              CALL XPCIF (CLINE)
              ival =041
              ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
            END IF
        END IF

           WRITE(CLINE,'(A)')
     1'# choose from:  rm (reference molecule of known chirality),'
           CALL XPCIF(CLINE)
           WRITE(CLINE,'(A)')
     1'# ad (anomolous dispersion - Flack), rmad (rm and ad),'
           CALL XPCIF(CLINE)
           WRITE(CLINE,'(A)')
     1'# syn (from synthesis), unk (unknown) or . (not applicable).'
           CALL XPCIF(CLINE)


        IF (STORE(L30GE+7).GT.ZERO) THEN
           WRITE (CLINE,1201) 'ad'
        ELSE
           IF ( IFLACK .EQ. 0 ) THEN
             WRITE (CLINE,1201) 'unk'
           ELSE
             WRITE (CLINE,1201) '.'
           END IF
        END IF
1201    FORMAT ('_chemical_absolute_configuration',T35,'''',A,'''')
        CALL XPCIF(CLINE)
        CALL XPCIF (' ')
C 
C      THE REFINEMENT DETAILS
C----- PARAMETER 13 ON DIRECTIVE 3 IS A CHARACTER STRING
        IPARAM=13
        IDIR=3
        IVAL=ISTORE(L30RF+IPARAM-1)
        IZZZ=KGVAL(CINSTR,CDIR,CPARAM,CVALUE,CDEF,30+3,IDIR,IPARAM,
     1    IVAL,JVAL,VAL,JTYPE)
        IF (IVAL.EQ.1) THEN
            CTYPE='F'
            IFARG = 1
        ELSE
            CTYPE='Fsqd'
            IFARG = 2
        END IF
        CLINE=' '
        IF ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (' ')
           WRITE (CLINE,'( A, ''structure_factor_coef '',A)')
     1      CBUF(1:11), CTYPE
           CALL XPCIF (CLINE)
           WRITE (NCFPU1,'(''_refine_ls_matrix_type '',T35,''full'')')

c 0 UNKNOWN  1 MIXED   2 REFALL  3 REFXYZ  4 REFU  5 NOREF
c 6 UNDEF    7 CONSTR  8 NONE    

           IPARAM  = 19
           IDIR = 9
           IVAL = ISTORE(L30CF+IPARAM-1)
           IF ( IVAL .EQ. 0 ) THEN  ! Work it out from L5 flags.
              IHC = 0
              DO I5 = L5, L5+ (N5-1)*MD5, MD5

                IF ( (ISTORE(I5).EQ.KHYD).OR.(ISTORE(I5).EQ.KDET))THEN
                   IHC = IHC + 1
                   INEW = 5                                      !NoRef
                   IF ( AND(ISTORE(I5+15),KBREFB(3)) .GT. 0) THEN
                      INEW = 7                                   !Riding
                   ELSE IF ( AND(ISTORE(I5+15),KBREFB(2)) .GT. 0) THEN
                     INEW = 7                                    !RigidGroup
                   ELSE IF ( AND(ISTORE(I5+15), KBREFU) .GT. 0) THEN  
                     INEW = 4                                    !RefU
                     IF ( AND(ISTORE(I5+15),KBREFX).GT.0) INEW=1 !Refall
                   ELSE IF ( AND(ISTORE(I5+15),KBREFX) .GT. 0) THEN
                     INEW = 3                                    !RefXYZ
                   END IF

                   IF ( IVAL .NE. INEW ) THEN
                      IF ( IVAL .NE. 0 ) THEN
                         IVAL = 1                                !Mixed
                         EXIT                                    !Stop looping
                      ENDIF
                      IVAL = INEW
                   END IF
                END IF
              END DO
              IF ( IHC .EQ. 0 ) IVAL = 8                         !None
           ENDIF
           IZZZ= KGVAL(CINSTR, CDIR, CPARAM, CVALUE, CDEF,
     1                     33, IDIR, IPARAM, IVAL,   JVAL, VAL, JTYPE)
           CALL XCCLWC (CVALUE(1:), CVALUE(1:))
           CALL XCTRIM(CVALUE,LVALUE)
cdjwnov2011 - change none to undef 
           WRITE (NCFPU1,'(''_refine_ls_hydrogen_treatment '',T35,
     1         A,T50,''#undef, noref, refall,'',/,T50,
     2         ''# refxyz, refU, constr or mixed'')') CVALUE(1:LVALUE)

        ELSE IF ( IPUNCH .EQ. 1 ) THEN
           WRITE (CPAGE(IREF,1)(:),'(A,A)') 'Refinement on ',CTYPE
        ELSE IF ( IPUNCH .EQ. 2 ) THEN
           JFCOEF = IVAL
           IF ( JFCOEF .EQ. 1 ) THEN
             WRITE(NCPU,2)'Refinement on','F'
           ELSE
             WRITE(NCPU,2)'Refinement on','F&sup2;'
           END IF
        END IF
C 
C----- WEIGHTING SCHEME - LIST 4
C 
        IF (JLOAD(4).GT.0) THEN
            ITYPE=ISTORE(L4C)

            IF ( IPUNCH .EQ. 2 ) THEN

              call xsum04(0,ctext)

603   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 2A,F10.3,A,F10.3,'</TD></TR>')
604   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 2A,F10.3,'</TD></TR>')
605   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 2A,F10.3,A,F10.3,A,'</TD></TR>')
606   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 2A,A,6(F10.3,A),'</TD></TR>')
607   FORMAT ('<TR><TD>',A,'</TD><TD>',
     1 A,A,F10.3,A,'</TD></TR>')

              JTYPE = ICON41
              IF (JTYPE .EQ. 3) THEN 
                IF (ISTORE(L23MN+1) .GE. 0) THEN 
                  IF (  (ITYPE .EQ. 10) .OR. (ITYPE .EQ. 11) .OR.
     1                  (ITYPE .EQ. 14) .OR. (ITYPE .EQ. 15) .OR.
     1                  (ITYPE .EQ. 17) .OR. (ITYPE .EQ. 16) ) THEN
                    JTYPE = 2
                  ELSE
                    JTYPE = 1
                    
                  ENDIF
                ELSE
                  JTYPE = 0
                ENDIF
              ENDIF

              CMOD = ' '
              IF ( JTYPE .EQ. 1 )
     1              CMOD = '(1/4F<sub>obs</sub>&sup2;) &times; '

              CFM  = 'F<sub>obs</sub>'
              CFMC = 'F<sub>calc</sub>'
              IF ( JTYPE .EQ. 2 ) THEN
                   CFM  = 'F<sub>obs</sub>&sup2;'
                   CFMC = 'F<sub>calc</sub>&sup2;'
              END IF

              CWT = 'w = '
              IF ( IROBUS .EQ. 1 ) THEN
                 CWT = 'w&prime; ='
                 CMOD = ' '
              END IF

              IF ( IDUNIT .EQ. 1 ) THEN
                 CWT = 'w&prime; ='
                 CMOD = ' '
              END IF

              LMOD = MAX(1,LEN_TRIM(CMOD))
              LFM  = MAX(1,LEN_TRIM(CFM))

              SELECT CASE (ITYPE)

              CASE (1)
                 WRITE(NCPU,603) CWT,CMOD(1:LMOD),
     1           '('//CFM(1:LFM)//'/',STORE(L4),
     1           ')&sup2;, if '//CFM(1:LFM)//' <= ',STORE(L4)
                 WRITE(NCPU,603) CWT,CMOD(1:LMOD),
     1           '(',STORE(L4),
     1           '/'//CFM(1:LFM)//')&sup2;, if '//CFM(1:LFM)//' > ',
     1           STORE(L4)
              CASE (2)  
                 WRITE(NCPU,604) CWT, CMOD(1:LMOD),
     1           '1 if '//CFM(1:LFM)//' <= ',STORE(L4)
                 WRITE(NCPU,603) CWT, CMOD(1:LMOD),
     1           '(',STORE(L4),
     2           '/'//CFM(1:LFM)//')&sup2;, if '//CFM(1:LFM)//' > ',
     3           STORE(L4)
              CASE (3)
                 WRITE(NCPU,605) CWT, CMOD(1:LMOD),
     1            '(1+[('//CFM(1:LFM)//' - ',
     2            STORE(L4+1), ')/', STORE(L4),
     3           ']&sup2;)<sup>-1</sup>'
              CASE (4)
                 WRITE(NCPU,2) CWT,CMOD(1:LMOD)//
     1           '[P<sub>1</sub>&times;'//CFM(1:LFM)//') + '//
     2           'P<sub>2</sub>&times;'//CFM(1:LFM)//'&sup2; + ...'//
     3           ' + P<sub>n</sub>&times;'//CFM(1:LFM)//'<sup>n</sup>]'
     4           //'<sup>-1</sup>'
                 WRITE(NCPU,2) 'P<sub>1</sub> - P<sub>n</sub> = ',
     1           CTEXT(4)
              CASE (5,6)
                 WRITE(NCPU,2) 'w = ',
     1            'user supplied weights - please elaborate.'
              CASE (7)
                 WRITE(NCPU,2) CWT,
     1            CMOD(1:LMOD)//'1/&sigma;('//CFM(1:LFM)//')'
              CASE (8)
                 WRITE(NCPU,2) CWT,CMOD(1:LMOD)//
     1           '1/&sigma;&sup2;('//CFM(1:LFM)//')'
              CASE (9)
                 WRITE(NCPU,2) CWT,CMOD(1:LMOD)//'1'
              CASE (11)
                 WRITE(NCPU,2) CWT,CMOD(1:LMOD)//
     1           '[P<sub>0</sub>T<sub>0</sub>&prime;(x) + '//
     2           'P<sub>1</sub>T<sub>1</sub>&prime;(x) + ...'//
     3           'P<sub>n-1</sub>T<sub>n-1</sub>&prime;(x)]'//
     4           '<sup>-1</sup>,<br>where P<sub>i</sub> are the '//
     5           'coefficients of a Chebychev series in '//
     6           't<sub>i</sub>(x), and x = '//CFM(1:LFM)//'/'//
     7           CFM(1:LFM)//'<sub>max</sub>.'
                 WRITE(NCPU,2) 'P<sub>0</sub> - P<sub>n-1</sub> = ',
     1           CTEXT(4)
              CASE (12)
                 WRITE(NCPU,607) CWT,CMOD(1:LMOD),
     1            '[sin&theta;/&lambda;]<sup>',
     2           STORE(L4),'</sup>'
              CASE (13)
                 WRITE(NCPU,605) 'w =',CMOD(1:LMOD),
     1            '[old-weight] &times; '//
     2            'e<sup>[8&times;(',STORE(L4),'/',STORE(L4+1),
     3            ')&times;(&pi;sin&theta;/&lambda;)&sup2;]</sup>'
              CASE (15)
                 WRITE(NCPU,2) 'w =',CMOD(1:LMOD)//
     1           'w&prime; &times; [1 - (&Delta;F<sub>obs</sub> / '//
     2           '6 &times; &Delta;F<sub>est</sub>)&sup2;]&sup2;'
                 WRITE(NCPU,2) 'w&prime; =',
     1           '[P<sub>0</sub>T<sub>0</sub>&prime;(x) + '//
     2           'P<sub>1</sub>T<sub>1</sub>&prime;(x) + ...'//
     3           'P<sub>n-1</sub>T<sub>n-1</sub>&prime;(x)]'//
     4           '<sup>-1</sup>,<br>where P<sub>i</sub> are the '//
     5           'coefficients of a Chebychev series in '//
     6           't<sub>i</sub>(x), and x = '//CFMC(1:LFM+1)//'/'//
     7           CFMC(1:LFM+1)//'<sub>max</sub>.'
                 WRITE(NCPU,2) 'P<sub>0</sub> - P<sub>n-1</sub> = ',
     1           CTEXT(4)
              CASE (16)
                 IF ( ABS(STORE(L4+2)).LT.ZERO ) THEN
                    CBUF = '1/'
                 ELSE IF (STORE(L4+2).GT.0) THEN
                    WRITE (CBUF,'(A,F10.4,A)') 'e<sup>',STORE(L4+2),
     1              ' &times; (sin(&theta;)/&lambda;)&sup2;</sup>'
                 ELSE
                    WRITE (CBUF,'(A,F10.4,A)') '1 - e<sup>',STORE(L4+2),
     1              ' &times; (sin(&theta;)/&lambda;)&sup2;</sup>'
                 END IF
                 WRITE(NCPU,606) CWT,CMOD(1:LMOD),
     1            CBUF(1:LEN_TRIM(CBUF)),
     1          '[&sigma;&sup2;('//CFM(1:LFM)//') + (',
     2          STORE(L4),' &times; P)&sup2; + ',STORE(L4+1),
     3          ' &times; P + ', STORE(L4+3), ' + ', STORE(L4+4),
     4          ' &times; sin&theta;],<br>P = ',STORE(L4+5),
     5          ' &times; max('//CFM(1:LFM)//',0) + ', 1-STORE(L4+5),
     6          ' &times; '//CFMC(1:LFM+1)
              END SELECT

                       
              CMOD = ' '
              IF ( JTYPE .EQ. 1 )
     1              CMOD = '(1/4F<sub>obs</sub>&sup2;) &times; '
              LMOD = MAX(1,LEN_TRIM(CMOD))

              IF ( ( IROBUS .EQ. 1 ) .AND. ( IDUNIT. EQ. 1 ) ) THEN
                 WRITE(NCPU,605) 'w&prime;&prime; = ',
     1            ' ',
     2            'e<sup>[8&times;(',DUN01,'/',DUN02,
     3            ')&times;(&pi;sin&theta;/&lambda;)&sup2;]</sup>'
                 WRITE(NCPU,607) 'w&prime;&prime;&prime; =',
     1           '[1 - ','(&Delta;F<sub>obs</sub> / ',
     2           ROBTOL,
     3           ' &times; &Delta;F<sub>est</sub>)&sup2;]&sup2;'
                 WRITE(NCPU,2) 'w =', CMOD(1:LMOD)//
     1           'w&prime; &times; w&prime;&prime; &times; '//
     2           'w&prime;&prime;&prime;'
              ELSE IF ( IROBUS .EQ. 1 ) THEN
                 WRITE(NCPU,607) 'w&prime;&prime; =',
     1           '[1 - ','(&Delta;F<sub>obs</sub> / ',
     2           ROBTOL,' &times; &Delta;F<sub>est</sub>)&sup2;]&sup2;'
                 WRITE(NCPU,2) 'w =', CMOD(1:LMOD)//
     1           'w&prime; &times; w&prime;&prime;'
              ELSE IF ( IDUNIT .EQ. 1 ) THEN
                 WRITE(NCPU,605) 'w&prime;&prime; = ',
     1            '',
     2            'e<sup>[8&times;(',DUN01,'/',DUN02,
     3            ')&times;(&pi;sin&theta;/&lambda;)&sup2;]</sup>'
                 WRITE(NCPU,2) 'w =', CMOD(1:LMOD)//
     1           'w&prime; &times; w&prime;&prime;'
              END IF
              WRITE (NCPU,'(''</TABLE></FONT>'')')
            END IF



            IF (ITYPE.EQ.9) THEN
C------ UNIT WEIGHTS
              IF ( IPUNCH .EQ. 0 ) THEN
                CALL XPCIF (' ')
                WRITE (CLINE,'(A)') 
     1 '# WARNING. The IUCr will not accept Unit Weights'
                CALL XPCIF (CLINE)
                CLINE=' '
                WRITE (CLINE,'(A, ''weighting_scheme calc'')')CBUF(1:11)
                CALL XPCIF (CLINE)
              END IF
            ELSE IF ((ITYPE.EQ.5).OR.(ITYPE.EQ.6).OR.(ITYPE.EQ.7).OR.
     1       (ITYPE.EQ.8)) THEN
C------ SIGMA WEIGHTS
              IF ( IPUNCH .EQ. 0 ) THEN
                CLINE=' '
                WRITE (CLINE,'(A, ''weighting_scheme sigma'')')
     1           CBUF(1:11)
                CALL XPCIF (CLINE)
              END IF
            ELSE 
              IF ( IPUNCH .EQ. 0 ) THEN
                CLINE=' '
                WRITE (CLINE,'(A, ''weighting_scheme calc'')')CBUF(1:11)
                CALL XPCIF (CLINE)
              END IF
            ENDIF
            IF ( IPUNCH .EQ. 0 ) THEN
              CLINE=' '
              WRITE (CLINE,'(A, ''weighting_details '')') CBUF(1:11)
              CALL XPCIF (CLINE)
              WRITE (NCFPU1,'('';'')')
              call xsum04(0,ctext)
              ival = 0
              if ((itype .eq. 10) .or.  (itype .eq. 11)) then
                ival = 12
              else if ((itype .eq. 14) .or. (itype .eq. 15)) then
                ival = 35
                ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
                call xctrim (ctemp,nchar)
                write (cline,'(a,a )') ' Method, part 1, ', 
     1          ctemp(1:nchar)
                call xpcif (cline)
                write(cline,'(a,a)')  
     1 ' [weight] = 1.0/[A~0~*T~0~(x)+A~1~*T~1~(x)',
     2 ' ... +A~n-1~]*T~n-1~(x)]'
                call xpcif (cline)
                write (cline,'(a,a)') 
     1 ' where A~i~ are the Chebychev coefficients listed below',
     2 ' and x= Fcalc/Fmax'
                call xpcif (cline)
               write(ctext(3),'(a)') ' A~i~ are:'
               ival = 38
             else if ((itype .eq. 16) .or.  (itype .eq. 17)) then
c
c               SHELX type
                ival = 0
cdjw090804
                if (nint(1000. * store(l4+5)) .ne. 333) then
                 IF (IFARG .EQ. 1) THEN
                   write(cline,'(a)') 
     1             ' P=p(6)*max(Fo,0) + (1-p(6))Fc'
                 ELSE
                   write(cline,'(a)') 
     1             ' P=p(6)*max(Fo^2^,0) + (1-p(6))Fc^2^'
                 ENDIF
                else
                 IF (IFARG .EQ. 1) THEN
                   write(cline,'(a)') 
     1             ' P=(max(Fo,0) + 2Fc)/3'
                 ELSE
                   write(cline,'(a)') 
     1             ' P=(max(Fo^2^,0) + 2Fc^2^)/3'
                 ENDIF
                endif
cdjw011104
                 ctext(3) = ' ,where '//cline
cdjw090804
                if (abs(store(l4+2))+abs(store(l4+3))+abs(store(l4+4))
     1          .le. 0.0) then

                 IF (IFARG .EQ. 1 ) THEN
                  write(ctext(2),'(a,f5.2,a,f5.2,a)')
#if !defined(_MAC_)
     1            ' w=1/[\s^2^(F) + (', store(l4),'P)^2^ +',
#else
     1            ' w=1/[\\s^2^(F) + (', store(l4),'P)^2^ +',
#endif
     2              store(l4+1),'P]'
                  ELSE
                  write(ctext(2),'(a,f5.2,a,f5.2,a)')
#if  !defined(_MAC_)
     1            ' w=1/[\s^2^(F^2^) + (', store(l4),'P)^2^ +',
#else
     1            ' w=1/[\\s^2^(F^2^) + (', store(l4),'P)^2^ +',
#endif
     2              store(l4+1),'P]'
                  ENDIF
                  ctext(4) = ' '
                else
                  write(ctext(3),'(a)') 
     1            ' p(i) are:'
                endif
             endif
              if (ival .ne. 0 ) then     
                ctemp = crefmk(istore(lrefs), nrefs, mdrefs, ival)
                call xctrim (ctemp,nchar)
                write (cline,'(a,a )') ' Method = ', ctemp(1:nchar)
                if (ival .eq. 34) then
                  ctext(3) = 'where '//ctext(1)
                  ctext(1) = ' '
                else
                  call xpcif (cline)
                endif
              else
                call xpcif(ctext(1))
              endif
              if ( len_trim(ctext(2)) .ge. 1) call xpcif(ctext(2))
              if ( len_trim(ctext(3)) .ge. 1) call xpcif(ctext(3))
              if ( len_trim(ctext(4)) .ge. 1) call xpcif(ctext(4))
              write (ncfpu1,'('';'')')
            END IF
        END IF
      END IF
C 

      IF ( IPUNCH .EQ. 0 ) THEN
C - NOW LIST THE REFERENCES
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      CALL XRDOPN(6,JDEV,'CRYSDIR:script\reftab.dat',25)
#else
      CALL XRDOPN(6,JDEV,'CRYSDIR:script/reftab.dat',25)
#endif
         WRITE (CLINE,'(A)') 
     1'# Insert your own references if required - in alphabetical order'
         CALL XPCIF (CLINE)
         WRITE (CLINE,'(A)') 
     1 '_publ_section_references '
         CALL XPCIF (CLINE)
         CALL XPCIF (';')
         CALL XREFPR (ISTORE(LREFS),NREFS,MDREFS)
         CALL XPCIF (';')
      END IF
 
 
2550  CONTINUE

      IF ( IPUNCH .EQ. 1 ) THEN
#if !defined(_GID_) && !defined(_GIL_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
      WRITE (NCPU,'(A)') CHAR(12)
#endif
        WRITE (NCPU,'(5X,2A35)') ((CPAGE(I,J),J=1,NCOL),I=1,NROW)
C----- ONLY 29 LINES USED IN PAGE  - CMON IS CURRENLTY 24
        WRITE (CMON,'(X,2A35)') ((CPAGE(I,J),J=1,NCOL),I=1,24)
        CALL XPRVDU (NCVDU,24,1)
        WRITE (CMON,'(X,2A35)') ((CPAGE(I,J),J=1,NCOL),I=25,29)
        CALL XPRVDU (NCVDU,5,1)
      END IF

C      WRITE LIST 30 BACK TO DISK (after THLIM calc)
      IF (JLOAD(9).GE.1) CALL XWLSTD (30,ICOM30,IDIM30,-1,-1)

      GO TO 2650
C----- ERROR EXIT
2600  CONTINUE
C 
2650  CONTINUE
      IF (IEPROP.NE.1) THEN
         WRITE (CMON,2700)
2700     FORMAT (' Error in computing molecular properties',/' Re-input 
     1expected composition - #SCRIPT INCOMP')
         CALL XPRVDU (NCVDU,2,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A,A)') CMON(1),CMON(2)
      END IF
C----- CLOSE THE 'CIF' OUTPUT FILE
      IF ( IPUNCH .EQ. 0 ) THEN
        CALL XRDOPN (7,KDEV,CSSCIF,LSSCIF)
C      CLOSE THE REFERENCES FILE
#if !defined(_GIL_) && !defined(_LIN_) && !defined(_WXS_)  && !defined(_MAC_) && !defined(_INW_)
       CALL XRDOPN(7,JDEV,'CRYSDIR:script\reftab.dat', 25)
#else
       CALL XRDOPN(7,JDEV,'CRYSDIR:script/reftab.dat', 25)
#endif
      END IF
      RETURN
      END

CODE FOR XPCIF
      SUBROUTINE XPCIF(CLINE)
C----- COMPRESS AND PUNCH THE STRING CLINE
      CHARACTER *(*) CLINE
      CHARACTER *80 CTEMP, CTEMP2
      INCLUDE 'XUNITS.INC'
      CTEMP = ''
      CTEMP2 = ''

      CALL XCREMS (CLINE, CTEMP, NCHAR)
      K = KHKIBM(CTEMP)
      CALL XCTRIM (CTEMP, NCHAR)

C If line starts with _ try to line up data in col 35. (if present).
      IF (CTEMP (1:1) .EQ. '_') THEN
           IDNM = KCCEQL(CLINE,1,' ')
C Check that data will fit into 80 chars if tabbed to col 35.
           IF ( ( NCHAR - IDNM .GT. 45 ) .OR. ( IDNM .GT. 34 ) ) THEN
C It won't:
             WRITE(CTEMP2,'(A)') CTEMP
           ELSE IF ( NCHAR - IDNM .LE. 0 ) THEN
C There is no extra data:
             WRITE(CTEMP2,'(A)') CTEMP
           ELSE
C It will:
             WRITE(CTEMP2,'(A,T35,A)') CTEMP(1:IDNM),CTEMP(IDNM+1:NCHAR)
           ENDIF
      ELSE
           WRITE (CTEMP2,'(A)') CTEMP
      END IF

      CALL XCTRIM (CTEMP2, NCHAR)
      WRITE(NCFPU1, '(A)') CTEMP2(1:NCHAR)
      RETURN
      END

CODE FOR CREFMK
      CHARACTER *(*) FUNCTION CREFMK(ITAB, NTAB, MDTAB, IVAL)
C----- MARK A REFERENCE AS BEING USED
C      RETURNS WITH BRIEF REFERENCE
C      ITAB - TABLE IF IDENTIFIERS AND BRIEF NAMES
C      NTAB AND MDTAB NUMBER OF IDENTIFIERS, LENGTH OF EACH
C      IVAL IDENTIFIER TO BE MARKED AS USED
      DIMENSION ITAB(MDTAB*NTAB)
      CHARACTER *80 CTEMP
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XIOBUF.INC'
      CREFMK = ' '      
      IF (NTAB.LE. 0) GOTO 980
      DO 100 I = 1, 1+(NTAB-1)*MDTAB,MDTAB
       IF (ITAB(I+1) .EQ. IVAL) THEN
            ITAB(I) = 1
             WRITE(CTEMP,'(19A4)') (ITAB(J),J=I+2,I+MDTAB-1) 
             CREFMK = CTEMP
            GOTO 980
       ENDIF
100   CONTINUE
      WRITE(CMON,'('' Reference '', i4, '' not found'')')IVAL
      CALL XPRVDU(NCVDU, 1,0)
      IF (ISSPRT .EQ.0) WRITE(NCWU,'(A)') CMON(1)(:)
980   CONTINUE
      RETURN
      END
C
CODE FOR XREFPR
      SUBROUTINE XREFPR(ITAB, NTAB, MDTAB)
C----- PRINT OUT THE USED-REFERENCES
      DIMENSION ITAB(MDTAB*NTAB)
      CHARACTER *80 CBUF
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XIOBUF.INC'
      REWIND (NCARU)
      IFIRST = 1
      IF (NTAB.LE. 0) GOTO 900
      DO 100 I = 1, 1+(NTAB-1)*MDTAB,MDTAB
        IF (ITAB(I) .EQ. 1) THEN
50        CONTINUE
          READ(NCARU,'(A)',END=900,ERR=900) CBUF
          IF (CBUF(1:1) .EQ. '#') THEN
            READ (CBUF,'(1X,I3)') J
            IF (J .EQ. ITAB(I+1)) THEN
               IF ( IFIRST .EQ. 1 ) THEN
                 IFIRST = 0
               ELSE
                 CALL XPCIF(' ')
               END IF
60             CONTINUE  ! Found reference, copy until blank line.
                 READ(NCARU,'(A)',END=900,ERR=900) CBUF
                 IF ((CBUF(1:1) .EQ. ' ') .OR. (CBUF(1:1) .EQ. '#'))
     1                                                        GOTO 100
                 CALL XPCIF(CBUF)
               GOTO 60
            ENDIF
          ENDIF
          GOTO 50
        ENDIF
100   CONTINUE
      RETURN
900   CONTINUE
#if defined(_GID_) || defined(_GIL_) || defined(_WXS_)  || defined(_MAC_) || defined(_INW_)
      CALL ZMORE ('Premature end',0)
#endif
      RETURN
      END
c
CODE FOR TONSPK
      SUBROUTINE TONSPK (IPLOT,CRITER,ITYP06,IPUNCH,FILTER)
C 
C     TON SPEK'S ENANTIOPOLE
C March 2008
C seriously based on ton's own code with his permission and help
C Requires the user to set up a LIST 7 with the Friedel flag
C set in the JCODE field.
C This can be done with the script COPY67
C 
C      iplot   plot type - None, Do/Dm, Qo/Qm, Ro/Dm 2Ao-Do or NPP
C      Criter  default 99999.
C      ipunch  no/table/restraint/graph  0/1/2/3
C      FILTER(4) - see FILTERS below  
c      thresh  in code 0.5
c      thresh2 in code 3.0
C 
      PARAMETER (NFAILN=6)
      DIMENSION IFAILN(NFAILN)
      CHARACTER*32 CFAILN(NFAILN)
      DIMENSION FILTER(4)
      PARAMETER (NPLT=7)
      DIMENSION IFOPLT(2*NPLT+1), IFCPLT(2*NPLT+1)
      DIMENSION DATC(401)
      DIMENSION TEMP(2)
      DIMENSION APROP(12)
      DIMENSION HFLACK(8)
      dimension  root(2), xcoord(2), ycoord(2), grad(2)
      CHARACTER*1 CSIGN
      CHARACTER*80 LINE
      CHARACTER*40 FORM
      CHARACTER*36 HKLLAB
      CHARACTER*3 CTYPE(2)
      CHARACTER*48 CPLOT
C 
      INCLUDE 'ISTORE.INC'
C 
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XCOMPD.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST02.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XLST23.INC'
      INCLUDE 'XLST28.INC'
      INCLUDE 'XLST30.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'TYPE11.INC'
      INCLUDE 'XSTR11.INC'
      INCLUDE 'XSIZES.INC'
C 
      INCLUDE 'QSTORE.INC'
      INCLUDE 'QSTR11.INC'
C 
      PARAMETER (NLISTS=7)
      DIMENSION LISTS(NLISTS)
      DATA LISTS(1)/5/,LISTS(2)/6/,LISTS(3)/28/,LISTS(4)/30/,LISTS(5)/1/
      DATA LISTS(6)/2/,LISTS(7)/23/
      DATA CTYPE(1)/'Fo '/,CTYPE(2)/'Fsq'/
      DATA CFAILN(1)/'/Do/ > Criterion * /Dm/' /
      DATA CFAILN(2)/ 'Ao >< Am +/- (Filter_1*sig+Dm/2)' /
      DATA CFAILN(3)/ 'Ao,Am < zero' /
      DATA CFAILN(4)/ 'Ao >< Am +/- Filter_2%' /
      DATA CFAILN(5)/ 'Am < Filter_3 * sigma' /
      DATA CFAILN(6)/ 'Dm < Filter_4 * sigma' /
C 
C      set packing constants
      PARAMETER (NPAK=256)
      PARAMETER (NN2=NPAK/2)
      PARAMETER (THRESH=.5)
      PARAMETER (THRESH2 = 3.)

      IERROR=1
C 
      CALL XRSL
      CALL XCSAE
c zero the R factor accumulators
      CALL XZEROF (HFLACK,8)
c
C--FIND OUT IF LISTS EXIST

      IERROR=1
      DO 300 N=1,NLISTS
         LSTNUM=LISTS(N)
         IF (LSTNUM.EQ.0) GO TO 300
         IF (KEXIST(LSTNUM)) 150,50,250
50       CONTINUE
         IF (ISSPRT.EQ.0) WRITE (NCWU,100) LSTNUM
         WRITE (CMON,100) LSTNUM
         CALL XPRVDU (NCEROR,1,0)
100      FORMAT (1X,'List ',I2,' contains errors')
         IERROR=-1
         GO TO 300
150      CONTINUE
         IF (ISSPRT.EQ.0) WRITE (NCWU,200) LSTNUM
         WRITE (CMON,200) LSTNUM
         CALL XPRVDU (NCEROR,1,0)
200      FORMAT (1X,'List',I2,' does not exist')
         IERROR=-1
         GO TO 300
250      CONTINUE
         IF (LSTNUM.EQ.1) THEN
            IF (KHUNTR(1,0,IADDL,IADDR,IADDD,-1).NE.0) CALL XFAL01
         ELSE IF (LSTNUM.EQ.2) THEN
            IF (KHUNTR(2,0,IADDL,IADDR,IADDD,-1).NE.0) CALL XFAL02
         ELSE IF (LSTNUM.EQ.5) THEN
            IF (KHUNTR(5,0,IADDL,IADDR,IADDD,-1).NE.0) CALL XFAL05
         ELSE IF (LSTNUM.EQ.23) THEN
            IF (KHUNTR(23,0,IADDL,IADDR,IADDD,-1).NE.0) CALL XFAL23
         ELSE IF (LSTNUM.EQ.28) THEN
            IF (KHUNTR(28,0,IADDL,IADDR,IADDD,-1).NE.0) CALL XFAL28
         ELSE IF (LSTNUM.EQ.30) THEN
            IF (KHUNTR(30,0,IADDL,IADDR,IADDD,-1).NE.0) CALL XFAL30
         ELSE IF (LSTNUM.EQ.6) THEN
Cdjwsep07 check the type of reflections
            IULN6=KTYP06(ITYP06)
            CALL XFAL06 (IULN6,0)
         END IF
300   CONTINUE
      IF (IERROR.LE.0) GO TO 2350
C 
C----- OUTPUT A TITLE, FIRST 20 CHARACTERS ONLY
C      WRITE(NCFPU1,1320) (KTITL(I),I=1,20)
c
c
      IF  (IPLOT.EQ.1) THEN
         WRITE (cplot,'(a)') ' Do vs Dm scatterplot'
      ELSE IF (IPLOT.EQ.2) THEN
         WRITE (cplot,'(a)') ' Qo vs Qm scatterplot'
      ELSE IF (IPLOT.EQ.3) THEN 
         WRITE (cplot,'(a)') ' Ro vs Dm scatterplot'
      ELSE IF (IPLOT.EQ.4) THEN 
         WRITE (cplot,'(a)') ' Flack 2AoDo scatterplot'
      ELSE
         WRITE (cplot,'(a)')
     1   ' Default DO vs Dm scatterplot not displayed'
      END IF
c
      if(ipunch.eq.3) write(ncpu,'(a)') cplot
c
C 
      SCALE=STORE(L5O)
      SCALE=1./(SCALE*SCALE)
c
cdjwnov12
c      fmax=store(l6dtl+5*md6dtl+1)
c
C----- MULTIPLIER TO CORRECT Fc FOR FLACK PARAMETER VALUE
      PREFLACK=1.-2.*STORE(L30GE+6)
C- COMPUTE Friedif and <D^2>
      I=KCPROP(APROP)
      FRIEDIF=APROP(11)
      IFTYPE = ISTORE(L23MN+1)+2
c      WRITE(123, *)'Refinement type =',CTYPE(IFTYPE)
c      write(123,1)
1     format(6x,'Fsq',10x,'SigFsq',6x,'Est Sig',8x,'Fo',11x,
     1       'SigFo',7x,'1/sqrtW')
C 
C 
C------ SET UP PLOT OUTPUT
      MAX11=ISIZ11
      IF  (IPLOT.EQ.1) THEN
C       Do vs Dm scatter
         WRITE (CMON,'(A,/,A,/,A,/A,/A)') 
     1 '^^PL PLOTDATA _FOFC SCATTER ATTACH _VFOFC KEY',
     2 '^^PL XAXIS TITLE Dm NSERIES=1 LENGTH=2000',
     3 '^^PL YAXIS TITLE Do',
     4 '^^PL SERIES 1 SERIESNAME ''Do'' TYPE SCATTER'
         CALL XPRVDU (NCVDU,4,0)

      ELSE IF (IPLOT.EQ.2) THEN
C       Qo vs Qm scatter
         WRITE (CMON,'(A,/,A,/,A,/A,/A)') 
     1 '^^PL PLOTDATA _FOFC SCATTER ATTACH _VFOFC KEY',
     2 '^^PL XAXIS TITLE Qm NSERIES=1 LENGTH=2000',
     3 '^^PL YAXIS TITLE Qo',
     4 '^^PL SERIES 1 SERIESNAME ''Qo'' TYPE SCATTER'
         CALL XPRVDU (NCVDU,4,0)

      ELSE IF (IPLOT.EQ.3) THEN
C       Ro vs Dm scatter
         WRITE (CMON,'(A,/,A,/,A,/A,/A)') 
     1 '^^PL PLOTDATA _FOFC SCATTER ATTACH _VFOFC KEY',
     2 '^^PL XAXIS TITLE Dm NSERIES=1 LENGTH=2000',
     3 '^^PL YAXIS TITLE Ro',
     4 '^^PL SERIES 1 SERIESNAME ''Ro'' TYPE SCATTER'
         CALL XPRVDU (NCVDU,4,0)
      END IF
C 
CC----- initialise tons accumulators etc
C      accumulators
      RCT=0.0
      RCN=0.0
C      plus and minus accumulators
      NPLS=0
      NMIN=0
C NPP ACCUMULATORS AND POINTERS
      TOP=0.0
      BOTTOM=0.0
      WTOP=0.0
      WBOT=0.0
      SIGTOP=0.0
      n6acc = 0
      l6acc = 1
      m6acc = l6acc
c     signa:noise indices Do, Dm, sigma, Ao, Am
      md6acc = 7
C 
C ACCUMULATORS FOR RESTRAINT R-FACTOR AND AVERAGES
      FLRNUM=0.
      FLRDEN=0.
      RESTNUM=0.
      RESTDEN=0.
C 
C      plus and minus sums
      NPP=0
      NPM=0
      NMM=0
      NMP=0
      XPP=0.
      XPM=0.
      XMM=0.
      XMP=0.
      YPP=0.
      YPM=0.
      YMM=0.
      YMP=0.
      NPFO=0
      NNFO=0
      FOMAX=0.
      FCMAX=0.
      DOMAX = 0.
      DCMAX = 0.
      STNFOM=0.
      STNFCM=0.
      FCMIN=1000000.
      SPFO=0.
      SPFOSQ=0.
      SNFO=0.
      SNFOSQ=0.
      NPFC=0
      NNFC=0
C----- totals for slope and intercept
      xmax=0.
      ymax=0.
      SS=0.
      SX=0.
      SY=0.
      SXX=0.
      SYY=0.
      SXY=0.
C 
      NFOFC = 0
      FSS=0.
      FSX=0.
      FSY=0.
      FSXX=0.
      FSYY=0.
      FSXY=0.
C
      i = LINFIT(1,x,y,wt,a,sa,b,sb,t,tsq,r,rsq,nitem,
     1  root, xcoord, ycoord, grad)

C----- restraint counter
      NREST=0
      SPFC=0.
      SPFCSQ=0.
      SNFC=0.
      SNFCSQ=0.
      SUM=0.
      SUMW=0.
      STEP=0.025
      NSP1=NINT(1.0/STEP)
      NSTP_401=10*NSP1+1
      NSPT_201=5*NSP1+1
      NSPM_161=NSPT_201-NSP1
      NSPP_241=NSPT_201+NSP1
      CALL XZEROF (DATC,NSTP_401)
      CALL XZEROF (IFOPLT,2*NPLT+1)
      CALL XZEROF (IFCPLT,2*NPLT+1)
C yslope is gradient of normal probability plot
C should be about unity anyway.  Will be computed later
      YSLOPE=1.
C 
C 
      IF (IPUNCH.EQ.1) THEN
         WRITE (NCPU,350)
350      FORMAT (3X,'H',3X,'K',3X,'L',11X,'Io+',7X,'Sig',7X,'Ic+',7X,
     1   'Io-',7X,'Sig',7X,'Ic-',X,'    Do   ',2X,'   Dm    ',4X,
     2   ' Ao ',5X,' Am ',5X,'Sig(Do)')
      ELSE IF (IPUNCH.EQ.2) THEN
         WRITE (NCPU,'(A,F9.4,A,F9.4)') 'REM Flack parameter = ', 
     1   STORE(L30GE+6), ' Pre-flack =', preflack
         WRITE (NCPU,400)
400      FORMAT ('REM '5X,'Delata Io',12X,'Sigma',33X,'Delta Ic'24X,
     1   'h  k  l     DIo-DIc/sig')
      else if (ipunch .eq. 3) then
         write(ncpu,'(a)') ' Graph points, Do, Dm, x, y, weight'
      END IF
C 
C     EXCLUDED REFLECTION CATEGORIES
      CALL XZEROF (IFAILN, nfailn)
      IN=0
      NREFIN=0
      LFRIED=0
      NFRIED=0
      MFRIED=0
      NCENTRIC=0
C----- GET REFLECTION(1)
450   CONTINUE
C      ISTAT = KLDRNR (IN)
      ISTAT=KFNR(0)
      IF (ISTAT.LT.0) GO TO 650
      NREFIN=NREFIN+1
      I=NINT(STORE(M6))
      J=NINT(STORE(M6+1))
      K=NINT(STORE(M6+2))
      I1=I
      J1=J
      K1=K
C       pack into h1
      H1=NPAK*NPAK*(I+NN2)+NPAK*(J+NN2)+K+NN2
      FSIGN=STORE(M6+3)
      SIG=STORE(M6+12)
C----- RETURN THE SIGNED STRUCTURE AMPLITUDE AND THE CORRESPONDING SIGMA
C      FROM A SIGNED STRUCTURE FACTOR
      CALL XSQRF (FSQ,FSIGN,FABS,SIGFSQ,SIG)
      FOK1=FSQ*SCALE
      SIG1=SIGFSQ*SCALE
CDJWAUG2011 - 
C-FOR SIMON. CREATE A PSUEDO-SIGMA FROM THE WEIGHT
      if (iftype .eq.1) then
c            refinement on F 
             sigest = 2. * fsign / store(m6+4)
      else
             sigest = 1./ store(m6+4)
      endif
Comment out the next line to use the observed sigma Fsq
c      SIG1 = SCALE*SQRT(SIGEST) 
123   format(3f12.2,3x,3f12.2)
      FCK1=STORE(M6+5)*STORE(M6+5)
      FRIED1=STORE(M6+18)
C 
C----- LOOP OVER REST OF DATA
C 
500   CONTINUE
C GET REFLECTION(2)
C      ISTAT = KLDRNR (IN)
      ISTAT=KFNR(0)
      IF (ISTAT.LT.0) GO TO 649
      NREFIN=NREFIN+1
      I=NINT(STORE(M6))
      J=NINT(STORE(M6+1))
      K=NINT(STORE(M6+2))
C       pack into h2
      H2=NPAK*NPAK*(I+NN2)+NPAK*(J+NN2)+K+NN2
      FSIGN=STORE(M6+3)
      SIG=STORE(M6+12)
C----- RETURN THE SIGNED STRUCTURE AMPLITUDE AND THE CORRESPONDING SIGMA
C      FROM A SIGNED STRUCTURE FACTOR
      CALL XSQRF (FSQ,FSIGN,FABS,SIGFSQ,SIG)
      FOK2=FSQ*SCALE
      SIG2=SIGFSQ*SCALE
CDJWAUG2011 
C-FOR SIMON. CREATE A PSUEDO-SIGMA FROM THE WEIGHT
      if (iftype .eq.1) then
c            refinement on F 
             sigest = 2. * fsign / store(m6+4)
      else
             sigest = 1./ store(m6+4)
      endif
Comment out the next line to use the observed sigma Fsq
c      SIG2 = SCALE*SQRT(SIGEST)
      FCK2=STORE(M6+5)*STORE(M6+5)
      FRIED2=STORE(M6+18)
C 
COMPARE PACKED INDICES
      IF (H1.EQ.H2) THEN
         MFRIED=MFRIED+1
         FokD=FOK1-FOK2
         FckD=FCK1-FCK2
         FokS=0.5*(FOK1+FOK2)
         FckS=0.5*(FCK1+FCK2)
         Qo = FokD/FokS
         Qc = FckD/FckS
         FOMAX=MAX(FOMAX,FokD)
         FCMAX=MAX(FCMAX,FckD)
         FCMIN=MIN(FCMIN,FckD)
         VAM = SIG1*SIG1+SIG2*SIG2
         SIGMAD=SQRT(VAM)
         SIGMAS = 0.5*SIGMAD
         SIGMAQ =SQRT((Fok1*sig2)*(Fok1*sig2) + (Fok2*sig1)*(Fok2*sig1))
         SIGMAQ = SIGMAQ*2./((2.*fOKs)*(2.*fOKs))

c      write(123,'(3(3f12.3,4x))')
c     1 Fokd, fckd, sigmad,
c     2 foks, fcks, sigmas, 
c     3 Qo, Qc, SIGMAQ

C ZH = SIGNAL:NOISE
         ZH=(FckD-FokD)/SIGMAD
         QH=(-FckD-FokD)/SIGMAD
C SIGNAL:NOISE FOR DELTA FO AND FC
         STNFO=FokD/SIGMAD
         STNFC=FckD/SIGMAD
         STNFOM=MAX(STNFOM, STNFO)
         STNFCM=MAX(STNFCM, STNFC)
C 
c  Data for R factors.
C  Accumulate info to RA
         HFLACK(1) = HFLACK(1) + ABS(FokS-FckS)
         HFLACK(2) = HFLACK(2) + ABS(FokS)
C  Accumulate info to RD
         HFLACK(3) = HFLACK(3) + ABS(FokD-FckD)
         HFLACK(4) = HFLACK(4) + ABS(FokD)
C  Accumulate info to RA2
         HFLACK(5) = HFLACK(5) + (FokS-FckS)*(FokS-FckS)/vam
         HFLACK(6) = HFLACK(6) + FokS*FokS/vam
C  Accumulate info to RD2
         HFLACK(7) = HFLACK(7) + (FokD-FckD)*(FokD-FckD)/vam
         HFLACK(8) = HFLACK(8) + FokD*FokD/vam
c
         FLRNUM=FLRNUM+ABS(FokD-PREFLACK*FckD)
         FLRDEN=FLRDEN+ABS(FokD)
C 
         IF (IPUNCH.EQ.1) THEN
            ITEMP=NINT(FRIED1)
            JTEMP=NINT(FRIED2)
            IF (ITEMP.LT.0) ITEMP=10+ITEMP
            IF (JTEMP.LT.0) JTEMP=10+JTEMP
            WRITE (NCPU,'(3i4,2i2, 6f10.2, 5f10.2, 5f10.4)') I,J,K,
     1       ITEMP,JTEMP,FOK1,SIG1,FCK1,FOK2,SIG2,FCK2,FokD,FckD,FokS,
     2       FckS,SIGMAD
C 
         END IF
C 
         NFO=NINT(STNFO)+NPLT+1
         NFO=MAX(NFO,1)
         NFO=MIN(NFO,2*NPLT+1)
         NFC=NINT(STNFC)+NPLT+1
         NFC=MAX(NFC,1)
         NFC=MIN(NFC,2*NPLT+1)
         IFOPLT(NFO)=IFOPLT(NFO)+1
         IFCPLT(NFC)=IFCPLT(NFC)+1
C 
c
c FILTERS
c accept reflections where:
c 1      /Do/ < CRITER * /Dm/
c 2      Fo <> Am+/-(Dm/2+filter(1)*sigma)
c 3      FoS and Fcs > zero
c 4      FoS < FcS+/- FILTER(2)%
c 5      Fcs > FILTER(3)*sigmas
c 6      FcD > FILTER(4)*sigmad
c
c         FckS is average of Fc 
c         FckD is difference of Fc
         ifail = 0
c 1
         if (abs(FokD).ge.criter*abs(FckD)) then
            ifail=ifail+1
            ifailn(1)=ifailn(1) + 1
         endif
c 2
         fcmx = max(fck1,fck2)
         fcmn = min(fck1,fck2)
         if ((fok1.lt. (fcmn-filter(1)*sigmad)) .or.
     1       (fok1.gt. (fcmx+filter(1)*sigmad)) .or.
     2       (fok2.lt. (fcmn-filter(1)*sigmad)) .or.
     1       (fok2.gt. (fcmx+filter(1)*sigmad))) then
            ifail=ifail+1
            ifailn(2)=ifailn(2) + 1
         endif
c 3
         if ((FokS.lt.zero).or.(fcks.lt.zero)) then
            ifail=ifail+1
            ifailn(3)=ifailn(3) + 1
         endif

         tempfilter= 0.1*filter(2)
c 4
         if ((FokS/FckS.gt. 1.+tempfilter)
     1   .or.(FokS/Fcks.lt. 1.0-tempfilter)) then
            ifail=ifail+1
            ifailn(4)=ifailn(4) + 1
         endif
c 5
         if (fcks.lt. filter(3)*sigmas) then
            ifail=ifail+1
            ifailn(5)=ifailn(5) + 1
         endif
c 6
         if (abs(fckd) .lt. (filter(4)*sigmad)) then
            ifail=ifail+1
            ifailn(6)=ifailn(6) + 1
         endif

         if (ifail .eq.0) then
C Store current HKL:
	   IH2 = STORE(M6)
	   IK2 = STORE(M6+1)
	   IL2 = STORE(M6+2)
C Generate Friedel opposite for current HKL:
	   STORE(M6)   = -STORE(M6)
	   STORE(M6+1) = -STORE(M6+1)
	   STORE(M6+2) = -STORE(M6+2)
C Work out canonicalized HKL for the Friedel Opposite
	   CALL KSYSAB(1)
C Store HKL for the opposite:
	   IH3 = STORE(M6)
	   IK3 = STORE(M6+1)
	   IL3 = STORE(M6+2)
C Restore original indices:
	   STORE(M6)   = IH2 
	   STORE(M6+1) = IK2 
	   STORE(M6+2) = IL2
C Done.	
c
C   STORE MAX Do AND Dc FOR FLACK PLOT
           DOMAX = MAX (DOMAX, abs(FOKD))
           DCMAX = MAX (DCMAX, abs(FCKD))
c
C STORE SIGNA:NOISE FOR NORMAL PROBABILITY PLOT
C If you have more than 8.8 million reflections you might be in trouble.
           N6ACC=N6ACC+1
           IF (N6ACC.LE.MAX11/md6acc) THEN
C      Format:   [WDEL,INDICES]
               STR11(M6ACC)=ZH
               STR11(M6ACC+1)=STORE(M6)+STORE(M6+1)*256.+STORE(M6+2)*
     1          65536.
               m6acc = m6acc + md6acc
               str11(m6acc+2) =  fokd
               str11(m6acc+3) =  fckd
               str11(m6acc+4) =  sigmad
               str11(m6acc+5) =  foks
               str11(m6acc+6) =  fcks
           END IF
C 
C COLLECT TOTALS & PROBABILITY DISTRIBUTION DATA FOR FLEQ (SFLEQ)
c
           NFRIED=NFRIED+1
C DATC is x(gamma), YK is gamma
           DO 600 J=1,NSTP_401
               YK=(J-NSPT_201)*STEP
               DATC(J)=DATC(J)-(((YK*FckD-FokD)/SIGMAD)**2)/2
600        CONTINUE
           RCT=RCT+FokD*FckD/SIGMAD
           RCN=RCN+FckD**2/SIGMAD
CDJWnOV-12
C SORT INTO QUADRANTS
           IF (FokD .GT. 0.0) THEN
                  IF(FckD .GT. 0.0) THEN
                        NPP = NPP + 1
                        XPP = XPP + FckD
                        YPP = YPP + FokD
                  ELSE
                        NMP = NMP + 1
                        XMP = XMP + FckD
                        YMP = YMP + FokD
                  ENDIF
           ELSE
                  IF(FckD .GT. 0.0) THEN
                        NPM = NPM + 1
                        XPM = XPM + FckD
                        YPM = YPM + FokD
                  ELSE
                        NMM = NMM + 1
                        XMM = XMM + FckD
                        YMM = YMM + FokD
                  ENDIF
           ENDIF
Cdjwsep08
           IF (FokD.GE.0) THEN
               NPFO=NPFO+1
               SPFO=SPFO+FokD
               SPFOSQ=SPFOSQ+FokD*FokD
           ELSE
               NNFO=NNFO+1
               SNFO=SNFO+FokD
               SNFOSQ=SNFOSQ+FokD*FokD
           END IF
C 
           IF (FckD.GE.0) THEN
               NPFC=NPFC+1
               SPFC=SPFC+FckD
               SPFCSQ=SPFCSQ+FckD*FckD
           ELSE
               NNFC=NNFC+1
               SNFC=SNFC+FckD
               SNFCSQ=SNFCSQ+FckD*FckD
           END IF
C 
           IF (FokD*FckD.GT.0.0) THEN
C  same sign
               NPLS=NPLS+1
           ELSE
C  opposite sign
               NMIN=NMIN+1
           END IF
           IF (FckD.NE.0.0) THEN
               RATIO=FokD/FckD
               IF (SIGMAD.GT.0.0) THEN
                  WGHT=ABS(FckD)/SIGMAD
                  SUM=SUM+WGHT*RATIO
                  SUMW=SUMW+WGHT
               END IF
           END IF
C 
C 
C         totals for Fo/Fc plot 
c          FckS is average of Fc 
c          FckD is difference of Fc
c
c---- corrected for current Flack value
           fcprime = preflack * fckd
c
c---- default is to accumulate for a difference calculation
           wt = 1./(sigmad*sigmad)
           xaxis = fCKd
           yaxis = fOKd
c
           if (iplot.eq.2) then
c            quotient plot
             wt = 1. / (sigmaq*sigmaq)
             xaxis = fckd/fcks
             yaxis = fokd/foks
           endif
c other plots done in second pass later
           xmax=max(xmax,abs(xaxis))
           ymax=max(ymax,abs(yaxis))
           nfofc = nfofc + 1
           if (iplot.eq.3) then
c Plot Do/Dm but compute slope of (Do-Dc) for use during
c plot of (Do-Dc) in second pass
c note that IPLOT 3 is just a linear transformation of IPLOT 1
c so gives the same Flack parameter and esd.
             wt = 1./(sigmad*sigmad)
             xaxis = Fckd
             yaxis = fckd-fokd
           endif
c
           itemp = 
     1 LINFIT(2,XAXIS,YAXIS,wt,a,sa,b,sb,t,tsq,r,rsq,nitem,
     1  root, xcoord, ycoord, grad)
c
           IF (IPUNCH.EQ.2) THEN
C----- multiplier to correct Fc for flack parameter value
C assigned above      PREFLACK = 1. - 2.* STORE(L30GE+6)
C 
Cdjwjul09  Watch out for small/negative average Fo & Fc
            IF ((FokS.GE.THRESH*SIGMAS).AND.(FckS.GE.THRESH*SIGMAS))THEN
             IF (ABS(FokD-FckD) .le. thresh2 * sigmad) THEN
               IF (FckD.LT.ZERO) THEN
                  CSIGN='-'
               ELSE
                  CSIGN='+'
               END IF
               ALT=sigmad
               WRITE (NCPU,550)
     1         FokD,  alt , CSIGN, abs(FckD),
     3         i,j,k,abs(FokD-FckD)/sigmad, (FokD-preflack*FckD)/FckD
550            FORMAT ('restrain ',F9.2,', ',F14.4,' = ',A,
     1         ' ( 1. - ( 2. * enantio ) ) * ',F9.2,20X,3I5,2F9.3)
               NREST=NREST+1
               RESTNUM=RESTNUM+ABS(FokD-PREFLACK*FckD)
               RESTDEN=RESTDEN+ABS(FokD)
             END IF
            END IF
           END IF

           if(ipunch.eq.3) write(ncpu,'(5f14.4)') 
     1     fokd, fckd, xaxis, yaxis, wt
c
           if ((IPLOT.eq.1).or.(IPLOT.EQ.2)) then
c----- Scatter plot 
               write (hkllab,'(3(i4,a))') nint(store(m6)),',',
     1            nint(store(m6+1)),',',nint(store(m6+2))
               call xcrems (hkllab, hkllab,ihkllen)
            if((xaxis.gt.9999990.).or.(yaxis.gt.9999990.)) then
c              number too big for plot
               if(issprt.eq.0) write(ncwu,'(a,a,2(1x,f14.4))') 
     1           'Overflow ', hkllab(1:ihkllen), xaxis, yaxis
            else   
               write (cmon,'(3a,2(1x,f12.4))') 
     1         '^^PL LABEL ''', hkllab(1:ihkllen), 
     2         ''' DATA ',xaxis,yaxis
               call xprvdu (ncvdu,1,0)
            endif
           end if
         else            ! ifail test
c           failing reflections
c             write(123,'(i4,2(3f12.2,3x))')
c     1      ifail,fok1,fck1,sig1,fok2,fck2,sig2
         end if          !end ifail test
C        GET NEXT REFLECTION(1)
         GO TO 450
C 
      ELSE
C----- UNPAIRED
CDJWDEC09
C      CHECK FOR CENTRIC REFLECTIONS
         ITEMP=KTONCENT(I1,J1,K1,NCENTRIC)
         IF (IPUNCH.EQ.1) THEN
            WRITE (NCPU,'(3i4,I2,2X, 3f10.2)') I1,J1,K1,ITEMP,FOK1,
     1       SIG1,FCK1
         END IF
         if (itemp .eq. -1) then
          LFRIED=LFRIED+1
         endif
         I1=I
         J1=J
         K1=K
         H1=H2
         FOK1=FOK2
         SIG1=SIG2
         FCK1=FCK2
         FRIED1=FRIED2
         GO TO 500
C        GET NEXT REFLECTION(2)
      END IF
C 
C---- END OF REFLECTIONS
649   continue
c     last unpaired reflection
      lfried=lfried+1
650   CONTINUE
C---- all refelctions processed.
C---- SPLIT UNPAIRD INTO REAL UNPAIRED AND CENTRIC
c      LFRIED=LFRIED-NCENTRIC
      IF (IPUNCH.EQ.2) THEN
         WRITE (CMON,'(a,i8,a)') 'REM ',NREST,' restraints written out'
         CALL XPRVDU (NCVDU,2,0)
         WRITE (NCPU,'(A)') CMON(1)(:)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(/a)') CMON(1)(:)
         IF(NREST .GT.0) THEN
          WRITE (CMON,'(a,f10.2)') 'REM  restraints R-factor(%) = ',
     1    100.0*restnum/restden
          CALL XPRVDU (NCVDU,2,0)
          WRITE (NCPU,'(A)') CMON(1)(:)
          IF (ISSPRT.EQ.0) WRITE (NCWU,'(/a)') CMON(1)(:)
         ENDIF
      END IF
c
c
c
c
      WRITE (CMON,'(10(a,i7))') ' No of Reflections processed =',
     1  NREFIN
      CALL XPRVDU (NCVDU,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(/A)') CMON(1)(:)
C 
      WRITE (CMON,'(10(a,2x,i7))') ' No of Friedel Pairs found =',
     1  MFRIED,' No of Friedel Pairs used  =',NFRIED
      CALL XPRVDU (NCVDU,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
C 
      WRITE (CMON,'(10(a,i7))') ' No of Unpaired Reflections  =',
     1  LFRIED
      CALL XPRVDU (NCVDU,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
C 
      WRITE (CMON,'(10(a,i7))') ' No of Centric Reflections   =',
     1  NCENTRIC
      CALL XPRVDU (NCVDU,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
C 
      WRITE (CMON,'(A)') 
     1' Flack parameter obtained from original refinement'
      CALL XPRVDU (NCVDU,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
C 
      WRITE (CMON,'(A)') 
     1' Hooft parameter obtained with Flack x set to zero'
      CALL XPRVDU (NCVDU,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
c
c      now Howards goodies
          if(issprt.eq.0) then
            write(ncwu,'(a)')
     1  '   RA   RD    wRA2  wRD2   Friedif  Flack esd'
            write(ncwu,2500) 
     1      100.*HFLACK(1)/HFLACK(2),          
     1      100.*HFLACK(3)/HFLACK(4),          
     1      100.*SQRT(HFLACK(5)/HFLACK(6)),          
     1      100.*SQRT(HFLACK(7)/HFLACK(8)),          
     2      FRIEDIF, STORE(L30GE+6), STORE(L30GE+7)
2500        FORMAT(4F6.1,2X, F8.2, 2F6.2/)
          endif
C 
      WRITE (CMON,'(/)')
      CALL XPRVDU (NCVDU,1,0)
c
      WRITE (cmon,'(a)') cplot
      call xprvdu(ncvdu,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(//a/)') cmon(1)
c
      write(cmon,'(a/a,f10.2,4(2x,a,i1,A,f6.2) )')
     1 ' Reflection Filters',
     2 ' Criterion',criter,('filter_',i,'=',filter(i),i=1,4)
         call xprvdu (ncvdu,2,0)
         if (issprt.eq.0) write (ncwu,'(/A)') cmon(1)(:),cmon(2)(:)
c
      WRITE (CMON,'(a,a,i8,a)') ' Accumulating ',
     1'scatterplot for',NFOFC,' reflections'
      CALL XPRVDU (NCVDU,1,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(/a)') CMON(1)(:)
c
      if (mfried .gt. 0) then
      WRITE (CMON,'(a,f10.2/)') 
     1 ' Current Do-Dm R-factor(%) for these reflections =',
     2 100.*FLRNUM/FLRDEN
      CALL XPRVDU (NCVDU,2,0)
      IF (ISSPRT.EQ.0) WRITE (NCWU,'(/a/)') CMON(1)(:)
      endif
C 
C 
      call outcol(3)
c
C      find slope and intercept of FO/fc plot
      IDJW = LINFIT
     1 (3,X,Y,WT,YCUT,SIGCUT,SLOPE,SIGSLOP,T,TSQ,CORREL,COOD,NFOFC,
     1  root, xcoord, ycoord, grad)

      IF (IDJW .GE. 0) THEN
        WRITE (CMON,700) CORREL, cood,SLOPE,SIGSLOP
700     FORMAT (/ 
     1  ' Correlation coeff and r^2 of Scatter Plot =',
     1  F7.3,F7.3,/27x,
     2  '   Slope, sigma =', F7.3, f7.3)
        CALL XPRVDU (NCVDU,3,0)
        IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)(:nctrim(cmon(1)))
     1  ,cmon(2)(:nctrim(cmon(2))),cmon(3)(:nctrim(cmon(3)))
        WRITE(CMON,701) YCUT, SIGCUT
701     FORMAT(26X, 'Intercept, sigma =', F7.3,F7.3)
        CALL XPRVDU (NCVDU,1,0)
        IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)(:nctrim(cmon(1)))
        if (iplot.eq.3) then
          PSEUDOF = 0.5*(SLOPE)
        else
          PSEUDOF = 0.5*(1.-SLOPE)
        endif
        PSEUDOS = 0.5*SIGSLOP
        WRITE(CMON,702)PSEUDOF, PSEUDOS
702     FORMAT(19X,'  Post-Refinement Flack =', 2F7.3)
c        CALL XPRVDU (NCVDU,1,0)
        IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)(:nctrim(cmon(1)))

      ELSE IF(IDJW.EQ.-1) THEN

        WRITE(CMON,*)'Line fitting failed'
        CALL XPRVDU (NCVDU,1,0)
        IF (ISSPRT.EQ.0) WRITE(NCWU,'(a)')CMON(1)(:nctrim(cmon(1)))
        WRITE (CMON,*) ' Slope and Intercept cannot be computed'
        CALL XPRVDU (NCVDU,1,0)
        IF (ISSPRT.EQ.0) WRITE(NCWU,'(/a)')CMON(1)(:nctrim(cmon(1)))

      ELSE

        WRITE (CMON,*) ' Correlation Coefficient cannot be computed'
        CALL XPRVDU (NCVDU,1,0)
        IF (ISSPRT.EQ.0) WRITE(NCWU,'(/a)')CMON(1)(:nctrim(cmon(1)))

      ENDIF      
      call outcol(1)
      if((iplot.eq.1).or.(iplot.eq.2)) then
       if (cood .le. 0.5) then 
              write(cmon,'(a,f5.2,a,i4,a,a)')
     1'{I The Coefficient of determination (r^2) of',cood,
     2' means that only',nint(cood*100.),
     3'% of the'
            call xprvdu (ncvdu,1,0)
            if (issprt.eq.0) write (ncwu,'(A)') cmon(1)(3:)
            write(cmon,'(A,A)')
     1'{I observed differences are related to the calculated',
     2 ' differences'
          call xprvdu (ncvdu,1,0)
          if (issprt.eq.0)write(ncwu,'(A)')cmon(1)(3:nctrim(cmon(1)))
       endif
      endif
C 
      if(iplot.eq.3) then 
c----- check for large noise:sigmal
          alpha = grad(1)
          beta = rtd*atan(slope)
          gamma = (alpha-beta)
          if(gamma.lt.   0.0) gamma = gamma+180.
          if(gamma.gt. 180.0) gamma = gamma-180.
          if(gamma.gt.  90.0) gamma = gamma-180.
          if((gamma.gt.80.).and.(gamma.lt.-80.)) then
            write(cmon,'(/a,f7.2 )')
     1'{I The Principal Component points in the noise direction, ',
     2 grad(1)
            call xprvdu (ncvdu,2,0)
            if (issprt.eq.0) write (ncwu,'(/A)') cmon(2)(3:)
           endif
      endif
C 
      djw1=min(xmax,ymax)
      phi = atan2(ymax,xmax)
c        a line calculated from the coefficients.

         theta = atan2(slope,1.)
         if(theta .gt. phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
         else if(theta .le. -phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
         else
            djw2 = xmax
            djw3 = xmax*tan(theta)
         endif
      IF ((IPLOT.eq.1).or.(IPLOT.EQ.2)) THEN
         WRITE (CMON,'(A/ (2(A,2(1X,F12.2))) )') 
     1 '^^PL ADDSERIES ''Best Line'' TYPE LINE',
     2 '^^PL DATA ', -djw2,-djw3+ycut,' DATA ',djw2,djw3+ycut
         CALL XPRVDU (NCVDU,2,0)
c
C       Also add a series for unit slope (y=x) 
       djwx = 0.8*djw1
         WRITE (CMON,'(A/(2(A,2(1X,F12.3))) )') 
     1 '^^PL ADDSERIES ''Unit Slope'' TYPE LINE',
     2 '^^PL DATA ', -djwx,-djwx,' DATA ',djwx,djwx
       CALL XPRVDU (NCVDU,2,0)
c
c       plot principal axes

       theta = grad(2)*dtr
       if(theta .gt. phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
       else if(theta .le. -phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
       else
            djw2 = xmax
            djw3 = xmax*tan(theta)
       endif

       WRITE (CMON,'(A/ (2(A,2(1X,F12.2))) )') 
     1 '^^PL ADDSERIES ''Minor'' TYPE LINE',
     2 '^^PL DATA ', -djw2,-djw3,' DATA ',djw2,djw3
       CALL XPRVDU (NCVDU,2,0)

       theta = grad(1)*dtr
       if(theta .gt. phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
       else if(theta .le. -phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
       else
            djw2 = xmax
            djw3 = xmax*tan(theta)
       endif
       WRITE (CMON,'(A/ (2(A,2(1X,F12.2))) )') 
     1 '^^PL ADDSERIES ''Major'' TYPE LINE',
     2 '^^PL DATA ', -djw2,-djw3,' DATA ',djw2,djw3
       CALL XPRVDU (NCVDU,2,0)
c
C -- FINISH THE GRAPH DEFINITION
       WRITE (CMON,'(A,/,A)') 
     1      '^^PL SHOW',
     2      '^^CR'
       CALL XPRVDU (NCVDU,2,0)
      endif
C 
C 
C 
      IF (NFRIED.GT.0) THEN
C  SECOND PASS (THROUGH SELECTED STORED REFLECTIONS)
C
       DMAX = MAX(DOMAX,DCMAX)
C 
       IF (N6ACC.GT.MAX11/md6acc) THEN
            WRITE (CMON,'(A,I8)') 
     1     '{E Too many reflections for memory: ',N6ACC
            CALL XPRVDU (NCVDU,1,0)
            N6ACC=MAX11/md6acc
       END IF
       write(cmon,'(//)')
       call xprvdu (ncvdu,2,0)
       WRITE (CMON,'(/A,6x,I7,A)') 
     1 ' Computations continued with ',N6ACC,' reflections.'
       CALL XPRVDU (NCVDU,2,0)
       IF (ISSPRT.EQ.0) WRITE(NCWU,'(/a)')CMON(2)(:nctrim(cmon(2)))
c
      
      if(iplot.eq.3) then
         xmax = 0.
         ymax = 0.
         m6acc = l6acc
         do 880 i=1,n6acc
C        Unpack HKL
          D=FLOAT(NINT(STR11(m6acc+1)/256.))
          MH=STR11(m6acc+1)-D*256.
          ML=FLOAT(NINT(D/256.))
          MK=D-ML*256.
c
          xaxis = str11(m6acc+3)
c          yaxis = (slope*str11(m6acc+3)+ycut) - str11(m6acc+2)
          yaxis = ((1.-2.*pseudof)*str11(m6acc+3)) - str11(m6acc+2)
          xmax=max(xmax,abs(xaxis))
          ymax=max(ymax,abs(yaxis))
          write (hkllab,'(2(i4,a),i4)') mh,',',
     1     mk,',',ml
          call xcrems (hkllab, hkllab,ihkllen)
          if((xaxis.gt.9999990.).or.(yaxis.gt.9999990.)) then
c           number too big for plot
             if(issprt.eq.0) write(ncwu,'(a,a,2(1x,f14.4))') 
     1           'Overflow ', hkllab(1:ihkllen), xaxis, yaxis
          else   
               write (cmon,'(3a,2(1x,f12.4))') 
     1         '^^PL LABEL ''', hkllab(1:ihkllen), 
     2         ''' DATA ',xaxis,yaxis
               call xprvdu (ncvdu,1,0)
          endif
c         
          m6acc = m6acc + md6acc
880      continue
c
         djw1=min(xmax,ymax)
         phi = atan2(ymax,xmax)
c        a line calculated from the coefficients.
c        Do not try this if the structure probably needs inverting
         if(slope .lt. 1.) then
          theta = atan2(slope,1.)
          if(theta .gt. phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
          else if(theta .le. -phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
          else
            djw2 = xmax
            djw3 = xmax*tan(theta)
          endif
          WRITE (CMON,'(A/ (2(A,2(1X,F12.2))) )') 
     1 '^^PL ADDSERIES ''Best Line'' TYPE LINE',
     2 '^^PL DATA ', -djw2,-djw3+ycut,' DATA ',djw2,djw3+ycut
          CALL XPRVDU (NCVDU,2,0)

C        Dummy very short line to keep colours in synch
          djwx = .01*djw1

          WRITE (CMON,'(A/(2(A,2(1X,F12.3))) )') 
     1 '^^PL ADDSERIES ''Unit Slope'' TYPE LINE',
     2 '^^PL DATA ', -djwx,-djwx,' DATA ',djwx,djwx
          CALL XPRVDU (NCVDU,2,0)

c         Minor Axis
          theta = grad(2)*dtr
          if(theta .gt. phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
          else if(theta .le. -phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
          else
            djw2 = xmax
            djw3 = xmax*tan(theta)
          endif

c  cannot do this if the structure is inverted because the 
c  ellipsoid will be at tan-1(2.), not zero
          WRITE (CMON,'(A/ (2(A,2(1X,F12.2))) )') 
     1 '^^PL ADDSERIES ''Minor'' TYPE LINE',
     2 '^^PL DATA ', -djw2,-djw3,' DATA ',djw2,djw3
          CALL XPRVDU (NCVDU,2,0)

c         Major Axis
          theta = grad(1)*dtr
          if(theta .gt. phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
          else if(theta .le. -phi) then
            djw2 = ymax/tan(theta)
            djw3 = ymax
          else
            djw2 = xmax
            djw3 = xmax*tan(theta)
          endif
c as above
          WRITE (CMON,'(A/ (2(A,2(1X,F12.2))) )') 
c     1 '^^PL ADDSERIES ''Major'' TYPE LINE',
c     2 '^^PL DATA ', -djw2,-djw3,' DATA ',djw2,djw3
          CALL XPRVDU (NCVDU,2,0)
         endif

c -- finish the graph definition
         write (cmon,'(a,/,a)') 
     1  '^^PL SHOW',
     2  '^^CR'
         call xprvdu (ncvdu,2,0)
      endif
c
       if(iplot.eq.4) then
c----- SET UP FLACK Do/2Ao SCATERPLOT AND LOOK FOR OUTLIERS
C       Flack Am-Dm scatter
         WRITE (CMON,'(A,/,A,/,A,/A,/A)') 
     1 '^^PL PLOTDATA _FOFC SCATTER ATTACH _VFOFC KEY',
     2 '^^PL XAXIS TITLE 2Am&Dm NSERIES=1 LENGTH=2000',
     3 '^^PL YAXIS TITLE 2Ao&Do',
     4 '^^PL SERIES 1 SERIESNAME ''2Ao'' TYPE SCATTER'
         CALL XPRVDU (NCVDU,4,0)
c
         m6acc = l6acc
         do 890 i=1,n6acc
C        Unpack HKL
          D=FLOAT(NINT(STR11(m6acc+1)/256.))
          MH=STR11(m6acc+1)-D*256.
          ML=FLOAT(NINT(D/256.))
          MK=D-ML*256.
c
          if((2.*str11(m6acc+5).le.dmax).and.   
     1    (2.*str11(m6acc+5).le.dmax)) then
           xaxis = 2.*str11(m6acc+6)
           yaxis = 2.*str11(m6acc+5)
           write (hkllab,'(2(i4,a),i4)') mh,',',
     1     mk,',',ml
           call xcrems (hkllab, hkllab,ihkllen)
           if((xaxis.gt.9999990.).or.(yaxis.gt.9999990.)) then
c           number too big for plot
             if(issprt.eq.0) write(ncwu,'(a,a,2(1x,f14.4))') 
     1           'Overflow ', hkllab(1:ihkllen), xaxis, yaxis
           else   
               write (cmon,'(3a,2(1x,f12.4))') 
     1         '^^PL LABEL ''', hkllab(1:ihkllen), 
     2         ''' DATA ',xaxis,yaxis
               call xprvdu (ncvdu,1,0)
           endif
          endif
          m6acc = m6acc + md6acc
890      continue
c
c we have to go round again for the dO dm bit
C
         WRITE (CMON,'(A)') 
     4 '^^PL ADDSERIES  Do TYPE SCATTER'
         CALL XPRVDU (NCVDU,1,0)
        m6acc = l6acc
        do 891 i=1,n6acc
C        Unpack HKL
         D=FLOAT(NINT(STR11(m6acc+1)/256.))
         MH=STR11(m6acc+1)-D*256.
         ML=FLOAT(NINT(D/256.))
         MK=D-ML*256.
               xaxis = str11(m6acc+3)
               yaxis = str11(m6acc+2)
               write (hkllab,'(2(i4,a),i4)') mh,',',
     1            mk,',',ml
               call xcrems (hkllab, hkllab,ihkllen)
             if((xaxis.gt.9999990.).or.(yaxis.gt.9999990.)) then
c              number too big for plot
               if(issprt.eq.0) write(ncwu,'(a,a,2(1x,f14.4))') 
     1           'Overflow ', hkllab(1:ihkllen), xaxis, yaxis
             else   
               write (cmon,'(3a,2(1x,f12.4))') 
     1         '^^PL LABEL ''', hkllab(1:ihkllen), 
     2         ''' DATA ',xaxis,yaxis
               call xprvdu (ncvdu,1,0)
             endif
         m6acc = m6acc + md6acc
891     continue
c -- finish the graph definition
        write (cmon,'(a,/,a)') 
     1  '^^PL SHOW',
     2  '^^CR'
        call xprvdu (ncvdu,2,0)
       endif
C
C----- COMPUTE NORMAL PROBABILITY PLOT
         write(cmon,'(/a)')' Normal Probability Plot'
         call xprvdu(ncvdu,2,0)
         if(issprt.eq.0) write(ncwu,'(/a)')cmon(2)(:nctrim(cmon(2)))
c
            IF (IPLOT.EQ.5) THEN
C       Normal probability plot
             WRITE (CMON,'(A,/,A,/,A)') 
     1 '^^PL PLOTDATA _NORMPP SCATTER ATTACH _VNORMPP',
     2 '^^PL XAXIS TITLE ''Expected (Z-score)'' NSERIES=1 LENGTH=2000',
     3 '^^PL YAXIS TITLE Residual SERIES 1 TYPE SCATTER'
             CALL XPRVDU (NCVDU,3,0)
            ENDIF
C Sort the sqrt(W)*(Fo2-Fc2) into ascending order.
         CALL XSHELQ (STR11,md6acc,1,N6ACC,N6ACC*md6acc,TEMP)
         noutl = 0
         m6acc = l6acc
         DO 900 I=1,N6ACC
C
           if(iplot.ne.3) then
            dest = slope * str11(m6acc+3) + ycut
            rest = str11(m6acc+2)-dest 
            ston = abs(rest)/str11(m6acc+4)
            if (ston .gt. 6.) then
             if(issprt.eq.0) then
               if(noutl .eq. 0) then
                write(ncwu,'(A/4x,a,7x,a,8x,a,7x,a,2x,a,4x,a,3x,a )')
     1         ' Outliers with residual > 6 sigma',
     2         'Indices', 'Dm', 'Do', 'Dest', '/Do-Dest/', 'sigma',
     3         'Delta/sigma' 
               endif
               write(ncwu,'(3i4, 6f10.3)') 
     1        mh, mk, ml, str11(m6acc+3), str11(m6acc+2), dest, 
     1        rest, str11(m6acc+4), ston
              endif
             noutl = noutl+1
            endif
           endif
C
           PC=(I-0.5)/FLOAT(N6ACC)
           A=SQRT(-2.*LOG(.5-ABS(PC-.5)))
           B=0.27061*A+2.30753
           C=A*(A*.04481+.99229)+1
           Z=A-B/C
C        Unpack HKL
           D=FLOAT(NINT(STR11(m6acc+1)/256.))
           MH=STR11(m6acc+1)-D*256.
           ML=FLOAT(NINT(D/256.))
           MK=D-ML*256.
           IF (I.LE.N6ACC/2) Z=-Z
           IF ( I .EQ. CEILING(N6ACC*0.1) )  z10 = z
           IF ( I .EQ. CEILING(N6ACC*0.9) )  z90 = z
           SS=SS+1.
           SX=SX+Z
           SY=SY+STR11(m6acc)
           SXX=SXX+Z*Z
           SYY=SYY+STR11(m6acc)*STR11(m6acc)
           SXY=SXY+STR11(m6acc)*Z
C 

C Generate Friedel opposite for current HKL:
           STORE(M6+1) = -MK
           STORE(M6+2) = -ML
C Work out canonicalized HKL for the Friedel Opposite
           CALL KSYSAB(1)
C Done.	
           IF (IPLOT.EQ.5) THEN
              WRITE (HKLLAB,'(5(I4,A),I4)') MH,',',MK,',',ML,' vs ',
     1		      NINT(STORE(M6)),',',
     1            NINT(STORE(M6+1)),',',NINT(STORE(M6+2))
               CALL XCREMS (HKLLAB, HKLLAB,IHKLLEN)
               WRITE (CMON,'(3A,2F11.3)') 
     1 '^^PL LABEL ''', HKLLAB(1:IHKLLEN),''' DATA ',Z,STR11(m6acc)
               CALL XPRVDU (NCVDU,1,0)
           END IF
           m6acc = m6acc + md6acc
900      CONTINUE
         if(iplot.ne.3) then
          write(cmon,'(18x,i6,a)') noutl,' outliers at 6 sigma'
          call xprvdu(ncvdu,1,0)
          if(issprt.eq.0)write(ncwu,'(/a/)')cmon(1)(:nctrim(cmon(1)))
         endif
C
         WRITE (CMON,'(23x,A,F10.3)') 'Z at 10th centile: ', Z10
         CALL XPRVDU (NCVDU,1,0)
         if(issprt.eq.0)write(ncwu,'(/a)')cmon(1)(:nctrim(cmon(1)))
         WRITE (CMON,'(23x,A,F10.3)') 'Z at 90th centile: ', Z90
         CALL XPRVDU (NCVDU,1,0)
         if(issprt.eq.0)write(ncwu,'(a/)')cmon(1)(:nctrim(cmon(1)))
C -- FINISH THE GRAPH DEFINITION
         IF (IPLOT.EQ.5) THEN
            WRITE (CMON,'(A,/,A)') 
     1      '^^PL SHOW',
     2      '^^CR'
            CALL XPRVDU (NCVDU,2,0)
         END IF
C      find slope and intercept of NPP
C      determinant
         WRITE (CMON,'(a,9x,2f12.3)') ' Gradient for zero intercept = ',
     1    SXY/SXX
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)(:)
         DETER=SS*SXX-SX*SX
         IF (DETER.NE.0.) THEN
            ycut=(SXX*SY-SX*SXY)/DETER
            SLOPE=(SS*SXY-SX*SY)/DETER
            YSLOPE=SLOPE
            DENOM=(SS*SXX-SX*SX)*(SS*SYY-SY*SY)
            IF (DENOM.GT.0.) THEN
               DENOM=SQRT(DENOM)
               CORREL=(SS*SXY-SX*SY)/DENOM
               WRITE (CMON,950) SLOPE,ycut,CORREL
950            FORMAT (' Slope, intercept and Cc (R) of NPP Plot ='
     1         ,F7.3,F7.3,F7.3)
               CALL XPRVDU (NCVDU,1,0)
               IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)(:)
            ELSE
               WRITE (CMON,1000)
1000           FORMAT (' Correlation coefficient cannot be computed')
               CALL XPRVDU (NCVDU,1,0)
               IF (ISSPRT.EQ.0) WRITE (NCWU,'(/a)') CMON(1)(:)
               WRITE (CMON,1050) SLOPE,ycut
1050           FORMAT (' Slope and intercept of NPP',' Plot =',F7.3,
     1         F10.2,F10.5)
               CALL XPRVDU (NCVDU,1,0)
               IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)(:)
            END IF
         ELSE
            WRITE (CMON,1100)
1100        FORMAT ('Slope and Intercept cannot be computed')
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(/a)') CMON(1)(:)
         END IF
C 
         IF ((SLOPE.GT.1.1).OR.(SLOPE.LT.0.9).OR.(ycut.LT.-.05).OR.
     1    (ycut.GT..05)) THEN
            WRITE (CMON,'(a,a)') ' The slope should be unity and the',
     1      ' intercept zero'
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(/a)') CMON(1)(:)
         END IF
C 
C 
C---- compute goodies
         SUM=SUM/SUMW
C  yslope is the gradient of the normal probability plot
         IF (NFRIED.NE.0) THEN
            DO 1150 J=1,NSTP_401
               DATC(J)=DATC(J)/YSLOPE**2
1150        CONTINUE
         END IF
C DETERMINE LARGEST and smallest LOG-PROBABILITY FOR SCALING
         DATCM=DATC(1)
         DATCL=DATC(1)
         DO 1200 J=2,NSTP_401
            IF (DATC(J).GT.DATCM) DATCM=DATC(J)
            IF (DATC(J).LT.DATCL) DATCL=DATC(J)
1200     CONTINUE
C CALCULATE G, SIGMA(G), FLEQ AND SIGMA(FLEQ) WITH BAYESIAN STATISTICS
         XG0=0.0
         XG1=0.0
         XG2=0.0
C equation 23 and 24
         DO 1250 J=1,NSTP_401
            YK=(J-NSPT_201)*STEP
            XG1=XG1+YK*EXP(DATC(J)-DATCM)
            XG0=XG0+EXP(DATC(J)-DATCM)
1250     CONTINUE
C  'G' parameter
         XG=XG1/XG0
C  su 'G' parameter
         DO 1300 J=1,NSTP_401
            YK=(J-NSPT_201)*STEP
            XG2=XG2+(YK-XG)**2*EXP(DATC(J)-DATCM)
1300     CONTINUE
         XGS=SQRT(XG2/XG0)
C  Tons-Hooft Parameters
         TONY=(1.0-XG)/2.0
         TONSY=SQRT(XG2/XG0)/2.0
         WRITE (CMON,'(/)')
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
c
         WRITE (CMON,'(/1x,a,f10.2,5x,a)') 
     1   'Friedif = ',FRIEDIF,' Acta A63, (2007), 257-265'
         CALL XPRVDU (NCVDU,2,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(/a)') CMON(2)(:)
C 
         WRITE (CMON,'(1x,a,/,1x,a)') 
     1   'Flack & Shmueli (2007) recommend a value >200',
     2   'for general structures and >80 for enantiopure crystals'
         CALL XPRVDU (NCVDU,2,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(a,/a)') CMON(1)(:),CMON(2)(:)
C 
         IF (ISSPRT.EQ.0) THEN
                  WRITE(NCWU,'(//A/)')'Reflection Distributions' 
            WRITE (NCWU,'(a/a/4x,a//)') 'I means Fsquared',
     1     'deltaI = I(+) - I(-)','Do = Io(+) - Io(-)'
            WRITE (NCWU,1400)
1400        FORMAT (10X,'Number +ve',3X,'mean(deltaI)',3X,'rms(deltaI)',
     1       3X,'Number -ve',3X,'mean(deltaI)',3X,'rms(deltaI)')
            WRITE (NCWU,1450)
1450        FORMAT ('For Io')
            WRITE (NCWU,1500) NPFO,SPFO/FLOAT(NPFO),SQRT(SPFOSQ/
     1       FLOAT(NPFO)),NNFO,SNFO/FLOAT(NNFO),SQRT(SNFOSQ/FLOAT(NNFO))
1500        FORMAT (10X,I6,3X,F12.4,3X,F12.4,7X,I6,3X,F12.4,2X,F12.4)
C 
            WRITE (NCWU,1550)
1550        FORMAT ('For Ic')
            WRITE (NCWU,1500) NPFC,SPFC/FLOAT(NPFC),SQRT(SPFCSQ/
     1       FLOAT(NPFC)),NNFC,SNFC/FLOAT(NNFC),SQRT(SNFCSQ/FLOAT(NNFC))

            WRITE(NCWU,'(//A)') 
     1      'Quadrant averages: N, Mean(Do), Mean(Dm)'
            WRITE(NCWU,'(/5x,i5,2f9.2,a4,5x,i5,2f9.2 )') 
     1      nmp,ymp/nmp,xmp/nmp, '|', npp,ypp/npp,xpp/npp
            write(ncwu,'(4x,a,a,a)')
     1      '---------------------------', '|',
     2      '----------------------------'
            WRITE(NCWU,'(5x,i5,2f9.2,a4,5x,i5,2f9.2 )')
     1       nmm,ymm/nmm,xmm/nmm, '|', npm,ypm/npm,xpm/npm

            WRITE (NCWU,1600)
1600        FORMAT (//'No of reflections for which delta(Io)',
     1      ' has same sign as delta(Ic)')
            WRITE (NCWU,1650)
1650        FORMAT ('Same sign',3X,'Opposite sign')
            WRITE (NCWU,1700) NPLS,NMIN
1700        FORMAT (I8,6X,I8)
            WRITE (NCWU,'(//A)') ' Distribution of Delta(I)/n<I>'
            WRITE (NCWU,'(a,15I6)') 'Delta Io',IFOPLT
            WRITE (NCWU,'(a,15I6)') 'Delta Ic',IFCPLT
            WRITE (NCWU,'(a,15I6)') '    n   ',
     1      (KDJW,KDJW=-NPLT,NPLT,1)
         END IF
C 
C 
         WRITE (CMON,'(/)')
         CALL XPRVDU (NCVDU,1,0)
         call outcol(3)
         WRITE (CMON,'(6x,a,2f10.4)')  
     1   ' Flack Parameter & su',STORE(L30GE+6),STORE(L30GE+7)
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(/A,a)') CMON(1)(:50),'@'
         if(iplot.eq.2) then
           WRITE(CMON,'(A,2F10.4)') 
     1     '        Quotient Flack & su', pseudof,pseudos
         else
           WRITE(CMON,'(A,2F10.4)') 
     1     '      Difference Flack & su', pseudof,pseudos
         endif
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A,a)') CMON(1)(:50),'!'
         WRITE (CMON,'(6x,a,2f10.4)')  
     1   ' Hooft Parameter & su',TONY,TONSY
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A,a)') CMON(1)(:50),'$'
         call outcol(1)


c-testing
c      write(123,'(i3, f8.0, 4f6.2, a,3(2f7.3,4x) )') 
c     1 iplot, criter, filter, ':::',
c     1 store(l30ge+6),store(l30ge+7), pseudof,pseudos, TONY,TONSY

         if (issprt .eq.0) then
1310        format(/3(/a,a))
            write(ncwu,1310)
     1   '@  ','Flack,1983, Acta Cryst A39, 876-881',
     2   '!  ','Thompson & Watkin, 2011, J Appl Cryst, 44, 1077-1022',
     3   '$  ','Hooft et al, 2008, J Appl Cryst, 41, 96-103'
         endif
         WRITE (CMON,'(/)')
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
         IF (STORE(L30GE+7).GE. 0.3) THEN
            WRITE (CMON,'(a,a/a,a/)') 
     1  '{E The absolute configuration has not been reliably',
     1  ' determined',
     2  '{E Flack & Bernardinelli., J. Appl. Cryst. (2000).',
     2  ' 33,1143-1148'
            CALL XPRVDU (NCVDU,3,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(/A)') CMON(1)(3:)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(A/)') CMON(3)(3:)
         END IF
C 
         XPLLL=DATC(NSPP_241)-DATCM
         XMNLL=DATC(NSPM_161)-DATCM
C 
         WRITE (CMON,'(14x,a)') 'Probabilities'
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
         WRITE (CMON,'(/)')
         CALL XPRVDU (NCVDU,1,0)
C 
         IF (RCN.NE.0) THEN
            RCO=RCT/RCN
         ELSE
            RCO=0.0
         END IF
c
C-WHAT IS RCO? Correlation coeficient for NPP?
C         IF (ISSPRT.EQ.0)
C     1   WRITE(NCWU,'(A,F12.3)') 'Tons Rc = ', rco
c
C values can be massive - can scaling be improved?
c      write(ncwu,'(10f12.2)') datc
c      write(ncwu,'(//4f12.4)') xplll,xmnll, datcm, datcl
c save some goodies to avoid divide by zero later
         xplll3 = xplll
         xmnll3 = xmnll
         XPLLL=EXP(XPLLL)
         XMNLL=EXP(XMNLL)
c      write(ncwu,'(3e12.4)') xplll,xmnll, xplll+xmnll
c      write(ncwu,*) xplll,xmnll, xplll+xmnll
c
C CALCULATE P2(0)
         IF (ABS(ABS(TONY-0.5)-0.5).LT.MAX(0.1,3*TONSY)) THEN
            if ((xplll+xmnll) .le. zero) then
              if (xplll3 .le. xmnll3) then
                  xpll2 = 0.0
              else
                  xpll2 = 1.0
              endif
            else  
              XPLL2=XPLLL/(XPLLL+XMNLL)
            endif
         ELSE
            XPLL2=-1.0
         END IF
c
         write(cmon,'(a)') ' Hooft probability analysis'
         call xprvdu (ncvdu,1,0)
         if (issprt.eq.0) write (ncwu,'(A)') cmon(1)
C P2(True)
         WRITE (CMON,'(a,a)') 
     1   ' For an enantiopure material,',' there are 2 choices, P2'
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1)
C
         IF (XPLL2.GT.0.001) THEN
            WRITE (FORM,1750) XPLL2,XPLL2
1750        FORMAT (X,F9.4,3X,'i.e. ',E12.6)
         ELSE IF (XPLL2.LT.0.0) THEN
            WRITE (FORM,1800)
1800        FORMAT (6X,'Does not compute')
         ELSE
            WRITE (FORM,1750) XPLL2,XPLL2
         END IF
         WRITE (LINE,1850) FORM
1850     FORMAT (' P2(correct) ',A)
         WRITE (CMON,1900) LINE
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,1900) LINE
1900     FORMAT (A)
C CALCULATE P3(0),P3(TW),P3(1)
         WRITE (CMON,'(/a,a)') 
     1   ' If 50:50 twinning is possible,',' there are 3 choices, P3'
         CALL XPRVDU (NCVDU,2,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(a)') CMON(1),CMON(2)
         XTWLL=DATC(NSPT_201)-DATCM
         XTWLL=EXP(XTWLL)
         XSMLL=XPLLL+XTWLL+XMNLL
C         write(ncwu,'(4e16.4)') xtwll,xplll, xmnll, xsmll
         IF (XSMLL.GT.ZEROSQ) THEN
            XPLLL=XPLLL/XSMLL
            XMNLL=XMNLL/XSMLL
            XTWLL=XTWLL/XSMLL
C P3(True)
            IF (XPLLL.GT.0.001) THEN
               WRITE (FORM,1750) XPLLL,XPLLL
            ELSE IF (XPLLL.LT.0.0) THEN
               WRITE (FORM,1800)
            ELSE
               WRITE (FORM,1750) XPLLL,XPLLL
            END IF
            WRITE (LINE,1950) FORM
1950        FORMAT (' P3(correct) ',A)
            WRITE (CMON,1900) LINE
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,1900) LINE
C P3(Twin)
            IF (XTWLL.GT.0.001) THEN
               WRITE (FORM,1750) XTWLL,XTWLL
            ELSE IF (XTWLL.LT.0.0) THEN
               WRITE (FORM,1800)
            ELSE
               WRITE (FORM,1750) XTWLL,XTWLL
            END IF
            WRITE (LINE,2000) FORM
2000        FORMAT (' P3(rac-twin)',A)
            WRITE (CMON,1900) LINE
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,1900) LINE
C P3(False)
            IF (XMNLL.GT.0.001) THEN
               WRITE (FORM,1750) XMNLL,XMNLL
            ELSE IF (XMNLL.LT.0.0) THEN
               WRITE (FORM,1800)
            ELSE
               WRITE (FORM,1750) XMNLL,XMNLL
            END IF
            WRITE (LINE,2050) FORM
2050        FORMAT (' P3(inverse) ',A)
            WRITE (CMON,1900) LINE
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,1900) LINE
            WRITE (LINE,2100) XG
2100        FORMAT (' G           ',F9.4)
            IF (ISSPRT.EQ.0) WRITE (NCWU,1900) LINE
            YUNK=SQRT(XG2/XG0)
            IF (YUNK.GT.0.0001) THEN
               WRITE (FORM,2150) YUNK
2150           FORMAT (F9.4)
            ELSE
               WRITE (FORM,1750) YUNK,YUNK
            END IF
            WRITE (LINE,2200) FORM
2200        FORMAT (' G S.U.      ',A)
            IF (ISSPRT.EQ.0) WRITE (NCWU,1900) LINE
            WRITE (LINE,2250) TONY
2250        FORMAT ('FLEQ         ',F9.4)
            IF (ISSPRT.EQ.0) WRITE (NCWU,1900) LINE
            IF (TONSY.GT.0.001) THEN
               WRITE (FORM,1750) TONSY,TONSY
            ELSE
               WRITE (FORM,1750) TONSY,TONSY
            END IF
            WRITE (LINE,2300) FORM
2300        FORMAT (' FLEQ S.U.  ',A)
            IF (ISSPRT.EQ.0) WRITE (NCWU,1900) LINE
            WRITE (CMON,'(/)')
            CALL XPRVDU (NCVDU,1,0)
            CALL XPRVDU (NCVDU,1,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
         ELSE
            WRITE (CMON,'(a//)')
     1    ' Data do not resolve the P3 hypothesis'
            CALL XPRVDU (NCVDU,2,0)
            IF (ISSPRT.EQ.0) WRITE (NCWU,'(A//)') CMON(1)(:)
         END IF
         if (issprt .eq. 0) then
            write(ncwu,'(/A,A/)')' Excluded reflections',
     1      ' - A reflection may fail more than one test'
            do i=1,nfailn
             write(ncwu,'(1X,a32,2X,i5)') CFAILN(I),ifailn(i)
            enddo
         endif
c
      ELSE
         WRITE (CMON,'(/)')
         CALL XPRVDU (NCVDU,1,0)
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
         WRITE (CMON,'(10(a,i7))') ' No of Reflections processed =',
     1    NREFIN,'         No of Friedel Pairs =',NFRIED
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(/A)') CMON(1)(:)
         WRITE (CMON,'(a)') ' No Friedel Pairs found'
         CALL XPRVDU (NCVDU,1,0)
         IF (ISSPRT.EQ.0) WRITE (NCWU,'(A)') CMON(1)(:)
         GO TO 2350
      END IF
C 
      RETURN
C 
2350  CONTINUE
C -- ERRORS DETECTED
      CALL XERHND (IERWRN)
      RETURN
      END
CDEC09
CODE FOR XTONCENT
      FUNCTION KTONCENT (I1,J1,K1,NCENTRIC)
C     KTONCENT = -1 IF NON-CENTRIC
C              =  0 IF CENTRIC
C
      DIMENSION H(3), HG(3)
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XLST02.INC'
      INCLUDE 'QSTORE.INC'
C
      KTONCENT = -1
      H(1) = I1
      H(2) = J1
      H(3) = K1
C--PASS THROUGH THE DIFFERENT SYMMETRY POSITIONS
      DO 1950 I=L2I,M2I,MD2I
C--CALCULATE THE TRANFORMED INDICES
      HG(1)=H(1)*STORE(I)+H(2)*STORE(I+3)+H(3)*STORE(I+6)
      HG(2)=H(1)*STORE(I+1)+H(2)*STORE(I+4)+H(3)*STORE(I+7)
      HG(3)=H(1)*STORE(I+2)+H(2)*STORE(I+5)+H(3)*STORE(I+8)
C--CHECK IF THE INDICES ARE THE SAME
      DO 1250 K=1,3
      IF(NINT(H(K)-HG(K)))1350,1250,1350
1250  CONTINUE
C--THE INDICES ARE THE SAME  
      GOTO 1900
C--THE REFLECTIONS ARE DIFFERENT
1350  CONTINUE
C--CHECK NEGATED
      DO 1450 K=1,3
      IF(NINT(H(K)+HG(K)))1550,1450,1550
1450  CONTINUE
C--THE NEGATED INDICES ARE THE SAME - CENTRIC REFLECTION
      NCENTRIC = NCENTRIC+1
      KTONCENT = 0
      GOTO 2000
1550  CONTINUE
1900  CONTINUE
1950  CONTINUE
2000  CONTINUE
      RETURN
      END
c
CODE FOR BENFRD
      SUBROUTINE BENFRD(ityp06,keywrd,scale)
C--APPLY BENFORD'S LAW TO THE PHASES
C
C--
      INCLUDE 'ISTORE.INC'
C
      INCLUDE 'STORE.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XCOMPD.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XLST28.INC'
      INCLUDE 'XLST30.INC'
      INCLUDE 'XERVAL.INC'
      INCLUDE 'XOPVAL.INC'
      INCLUDE 'XIOBUF.INC'
c
      dimension mm(9)
      dimension am(9)
C
      INCLUDE 'QSTORE.INC'
C
      IERROR = 1
C
      call xrsl
      call xcsae
      call xzerof(mm, 9)
      call xzerof(am, 9)
C    CONVERT RADIANS TO THOUSANDTHS OF A REVOLUTION
      RTOH = 1000./TWOPI
      IF (KEXIST(1) .GE. 1) CALL XFAL01
C--SET UP LIST 6 FOR READING ONLY
      IN = 0
cdjwsep07 check the type of reflections
            IULN6 = KTYP06(ITYP06)
            CALL XFAL06(IULN6,0)
      IF ( IERFLG .LT. 0 ) GO TO 9900
C
      NTERM = 0
C--FETCH THE NEXT REFLECTION
1050  CONTINUE
C  ONLY USE THE  REFLECTIONS USED IN REFINEMENT
      IF (KFNR(IN)) 1250, 1100, 1100
C      IF (KLDRNR(IN)) 1250, 1100, 1100
C
1100  continue
      if (keywrd .eq. 1 ) then
c      fo
        a = store(m6+3)
      else if (keywrd .eq. 2 ) then
c      sigma
        a = 100. * store(m6+12)*store(m6+12)
      else if (keywrd .eq. 3 ) then
c      fc
        a = store(m6+5)
      else if (keywrd .eq. 4 ) then
c       phase
        a = STORE(M6+6) 
        if (a .le. 0.) a = a+twopi
        a = a * rtoH
      else if (keywrd .eq. 5 ) then
c      wt
        a = 100. * store(m6+4)
      else
        write(cmon,'(A,i4)') 'Unknown keyword', keywrd
        goto  9900
      endif
      a = scale*abs(a )
c      write(ncpu,'(f10.4)') a
c      write(*,*)m,a
      if(a .gt.0) then
       nterm = nterm + 1
       f = log10(a)
       j = int(f)
       b = a/10.0**j
       n =int(b)
      WRITE(NCPU,'(i6,2f10.4,i10,f10.4,i6)') NTERM,a,f,j,b,n
       if(n .le. 0) goto 9800
       mm(n) = mm(n) + 1
      endif
      GOTO 1050
C
C--TERMINATE THE LIST
1250  CONTINUE
      n = 0
      do i=1,9
        n = n + mm(i)
      enddo

      write(cmon,'(a,9I6,3x,A)')'Value   ', (i,i=1,9), 'items'
      CALL XPRVDU(NCVDU,1,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
      do i=1,9
            am(i) = (100.*float(mm(i))/float(n))
      enddo
      write(CMON,'(a, 9f6.1,2i6)')'Observed  ',  am, n, nterm
      CALL XPRVDU(NCVDU,1,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)

      do i=1,9
            am(i) = 100.0*log10((float(i+1))/float(i))
      enddo
      write(CMON,'(a, 9f6.1)')'Calculated',  am
      CALL XPRVDU(NCVDU,1,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
C
      RETURN
C
9800  continue
      write(cmon,'(a,f6.2)') 
     c 'Items less than unity: Raise the scale factor from', scale
      CALL XPRVDU(NCVDU,1,0)
      IF (ISSPRT .EQ. 0) WRITE(NCWU, '(A)') CMON(1 )(:)
      RETURN
9900  CONTINUE
C -- ERRORS
      CALL XOPMSG ( IOPPCH , IOPLSP , 6 )
      RETURN
      END
C
CODE FOR CCOEF
      SUBROUTINE CCOEF(MODE, X, Y, N, A, SLOPE, RINTER, CORREL)
C compute correlation coefficient for x-y data.
C MODE:      0 FOR INITIALISATION
C            1 FOR ACCUMULATION
C            2 FOR RESULTS
C MODE:      3 FOR SUCCESS
C            4 FOR NO CORRELATION COEFFICIENT
C            5 FOR FAILURE
C X,Y        DATA POINTS
C N          NUMBER OF ITEMS
C SLOPE      SLOPE
C RINTER      INTERCEPT
C CORREL     CORRELATION COEFFICIENT
C IUPDATE    0 DO NOT UPDATE LIST 30
C
      DIMENSION A(6)
c
      INCLUDE 'ICOM30.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'XLST30.INC'
      INCLUDE 'XSSVAL.INC'
c
      IF ( MODE .EQ. 0) THEN
C INITIALISE
        a(1) = 0.
        a(2) = 0.
        a(3) = 0.
        a(4) = 0.
        a(5) = 0.
        a(6) = 0.
      ELSE IF (MODE .EQ. 1) THEN
c      totals for plot
           a(1) =  a(1)  + 1.
           a(2) =  a(2)  + X
           a(3) =  a(3)  + Y
           a(4) = a(4) + X*X
           a(5) = a(5) + Y*Y
           a(6) = a(6) + X*Y
      ELSE
       slope = 0.
       inter = 0.
       correl = 0.
       n = nint(a(1))
c      determinant
       deter = a(1)*a(4)-a(2)*a(2)
        if (deter .ne. 0.) then
         mode = 3
         slope = (a(1)*a(6)-a(2)*a(3))/deter
         rinter = (a(4)*a(3)-a(2)*a(6))/deter
         denom = (a(1)*a(4)-a(2)*a(2))*(a(1)*a(5)-a(3)*a(3))
         if (denom .gt. 0.) then
            denom=sqrt(denom)
            correl = (a(1)*a(6) - a(2)*a(3))/denom
            write(cmon,470) slope, rinter, correl
470         format(' Slope, intercept and Cc of plot = ',
     1      3g10.3)
c            call xprvdu(ncvdu, 1,0)
            if (issprt.eq.0) write (ncwu,'(/a)') cmon(1)(:)
         else
            mode = 4
            write(cmon,471) 
471         format ('Correlation coefficient cannot be computed')
            call xprvdu(ncvdu, 1,0)
            if (issprt.eq.0) write (ncwu,'(/a)') cmon(1)(:)
            write(cmon,472) slope, rinter 
472         format(' Slope and intercept of plot =',
     1      3g10.3)
c            call xprvdu(ncvdu, 1,0)
            if (issprt.eq.0) write (ncwu,'(/a)') cmon(1)(:)
         endif
        else
            mode = 5
            write(cmon,473) 
473         format ('Slope and Intercept cannot be computed')
            call xprvdu(ncvdu, 1,0)
            if (issprt.eq.0) write (ncwu,'(/a)') cmon(1)(:)
        endif
      ENDIF
      RETURN
      END
CODE FOR SYMCODE
      SUBROUTINE SYMCODE(M,J,N2P,L2C)
C RETURN X-RAY STYLE SYMMETRY CODES
cdjwmay09
c      M      RETURN VALUE
c      J1     S
c      J2     L
c      J3     TX
c      J4     TY
c      J5     TZ
c      N2P    No OF OPERATORS
c      L2C    CENTRIC SWITCH
C
      INCLUDE 'XUNITS.INC'
      include 'ISTORE.INC'
      DIMENSION J(5)
C
       M = 0
       IF (ISTORE(L2C) .LE. ZERO) THEN
            JA = 1
       ELSE
            JA = 2
       ENDIF
       M = 1+
     1 (ABS(J(1))-1) * N2P * JA +
     2 (J(2)-1) * JA +
     3 (-SIGN(1,J(1))+1)/2
       M=1000*M+100*(5+J(3))+10*(5+J(4))
     1 +(5+J(5))
      WRITE(NCWU,'(8I10)') M,J,N2P,L2C
      RETURN
      END
CODE FOR XCIFQC
      SUBROUTINE XCIFQC
CDJWMAR99[      CIF OUTPUT DIRECTED TO NCFPU1, PERMITTING TEXT OUTPUT TO
C               BE SENT TO THE PUNCH UNIT AS A TABLE
C
      PARAMETER (NCOL=2,NROW=49)
      PARAMETER (IDATA=15,IREF=23)
      CHARACTER*35 CPAGE(NROW,NCOL)
      CHARACTER*76 CREFMK
      PARAMETER (IDIFMX=11)
      PARAMETER (IREDMX=7)
      DIMENSION IREFCD(3,IDIFMX)
      DIMENSION IREDCD(IREDMX)
CAVDL more solution packages in cif-goodies
      PARAMETER (ISOLMX=10)
      DIMENSION ISOLCD(ISOLMX)
      PARAMETER (IABSMX=16)
      DIMENSION IABSCD(IABSMX)

C
CDJWMAR99 MANY CHANGES TO BRING UP TO DATE WITH NEW CIFDIC
      PARAMETER (NTERM=4)
      PARAMETER (NNAMES=30)
      DIMENSION A(12), JDEV(4), KDEV(4)
      PARAMETER (NLST=4)
      DIMENSION LSTNUM(NLST), JLOAD(NLST)
      DIMENSION IVEC(16), ESD(6)
      CHARACTER CCELL(3)*1,CANG(3)*5,CSIZE(3)*3,CINDEX(3)*2
      CHARACTER CBUF*80,CTEMP*80,CLINE*80, CHLINE*380
      character *80 ctext(4)
C
      CHARACTER*4 CTYPE
      CHARACTER*15 CINSTR,CDIR,CPARAM,CVALUE,CDEF
      CHARACTER*26 UPPER,LOWER
      CHARACTER*3 CSSUBS(11)
      CHARACTER*17 CWT
      CHARACTER*22 CFM, CFMC ! 'F<sub>obs</sub>&sup2;'
      CHARACTER*35 CMOD
      CHARACTER*6 CSOLVE
cdjwapr09
      INTEGER  IFARG      ! F OR F^2^ FOR WEIGHTING SCHEME
C
      INCLUDE 'TSSCHR.INC'
      INCLUDE 'ICOM30.INC'
      INCLUDE 'ICOM31.INC'
      INCLUDE 'ISTORE.INC'
      INCLUDE 'STORE.INC'
      INCLUDE 'XCOMPD.INC'
      INCLUDE 'XUNITS.INC'
      INCLUDE 'UFILE.INC'
      INCLUDE 'XTAPES.INC'
      INCLUDE 'XCHARS.INC'
      INCLUDE 'XCONST.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XSSCHR.INC'
      INCLUDE 'XLISTI.INC'
      INCLUDE 'XLST01.INC'
      INCLUDE 'XLST02.INC'
      INCLUDE 'XLST03.INC'
      INCLUDE 'XLST04.INC'
      INCLUDE 'XLST05.INC'
      INCLUDE 'XLST06.INC'
      INCLUDE 'XLST13.INC'
      INCLUDE 'XLST23.INC'
      INCLUDE 'XLST25.INC'
      INCLUDE 'XLST28.INC'
      INCLUDE 'XLST29.INC'
      INCLUDE 'XLST30.INC'
      INCLUDE 'XLST31.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'XFLAGS.INC'
C
C
      INCLUDE 'QLST30.INC'
      INCLUDE 'QLST31.INC'
      INCLUDE 'QSTORE.INC'

      V(CA,CB,CC,AL,BE,GA)=CA*CB*CC * SQRT(1-COS(AL)**2-COS(BE)**2-
     1   COS(GA)**2 + 2 * COS(AL) * COS(BE) * COS(GA))
C
C
      DATA UPPER/'ABCDEFGHIJKLMNOPQRSTUVWXYZ'/
      DATA LOWER/'abcdefghijklmnopqrstuvwxyz'/
C                  1 2 3 4 
      DATA LSTNUM/1,2,5,31/
      DATA CCELL/'a','b','c'/
      DATA CANG/'alpha','beta','gamma'/
      DATA CSIZE/'min','mid','max'/
      DATA CINDEX/'h_','k_','l_'/
#if defined (_HOL_)
      DATA ICARB/4HC   /
      DATA KHYD/4HH   /
      DATA KDET/4HD   /
#else
      DATA ICARB/'C   '/
      DATA KHYD/'H   '/
      DATA KDET/'D   '/
#endif
CDJWMAR99      DATA JDEV /'H','K','L','I'/
      DATA CSSUBS /' 21',' 31',' 32',' 41',' 42',' 43',' 61',
     1            ' 62',' 63',' 64',' 65'/
 
CRICFEB03: Output one of 0=CIF, 1=PLAIN, 2=HTML
      CALL XCSAE
      I = KRDDPV ( IPUNCH , 1 )
      IF (I.LT.0) THEN
         IF (ISSPRT .EQ. 0) WRITE(NCWU, 51)
         WRITE ( CMON ,51)
         CALL XPRVDU(NCVDU, 1,0)
51       FORMAT(' Error in #CIFOUT directives. ')
         RETURN
      END IF
c
c set some dummy esds just in case
c
      do i = 1,6
      esd(i) = 0.001
      enddo

CDJWMAY99 - OPEN CIF OUTPUT ON FRN1
      IF ( IPUNCH .EQ. 0 ) THEN
         CALL XMOVEI (KEYFIL(1,23),KDEV,4)
         CALL XRDOPN (6,KDEV,CSSCIF,LSSCIF)
      END IF
      CALL XRSL
      CALL XCSAE
c
      CALL XDATER (CBUF(1:8))

      IF ( IPUNCH .EQ. 0 ) THEN
        WRITE (NCFPU1,'(''data_global '')')
        WRITE (NCFPU1,'(''_audit_creation_date  '',6X, 
     1  ''"'',3(A2,A))')
     2  CBUF(7:8),'-',CBUF(4:5),'-',CBUF(1:2),'"'
        WRITE (NCFPU1,
     1   '(''_audit_creation_method CRYSTALS_ver_'',F5.2)')
     1    0.01*FLOAT(ISSVER)

C----- OUTPUT A TITLE, FIRST 44 CHARACTERS ONLY
        WRITE (CLINE,'(20A4)') (KTITL(I),I=1,20)
        K=KHKIBM(CLINE)
        CALL XCREMS (CLINE,CLINE,NCHAR)
        CALL XCTRIM (CLINE,NCHAR)
        K=MIN(44,NCHAR-1)
        WRITE (NCFPU1,'(/,''_oxford_structure_analysis_title  '''''',
     1   A,'''''''')') CLINE(1:K)
        WRITE (NCFPU1,'(''_chemical_name_systematic '',T35,''?'')')
        WRITE (NCFPU1,'(''_chemical_melting_point '',T35,''?'',/)')
      END IF
 
C                      1 2 3  4 
C FYI:    DATA LSTNUM /1,2,5,31 /
c
      DO MLST=1,NLST
         JLOAD(MLST)=0                   !INDICATE LIST NOT LOADED
         LSTYPE=LSTNUM(MLST)
         IF (KEXIST(LSTYPE)) 400,300,500
300      CONTINUE
           WRITE (CMON,350) LSTYPE
           CALL XPRVDU (NCVDU,1,0)
350        FORMAT (1X,'List ',I2,' contains errors')
           CYCLE
400      CONTINUE
           WRITE (CMON,450) LSTYPE
450        FORMAT (1X,'List',I2,' does not exist')
           CALL XPRVDU (NCVDU,1,0)
           CYCLE
500      CONTINUE
 
         IF (LSTYPE.EQ.1) THEN
            CALL XFAL01
         ELSE IF (LSTYPE.EQ.2) THEN
            CALL XFAL02
         ELSE IF (LSTYPE.EQ.5) THEN
            CALL XLDR05 (LSTYPE)
         ELSE IF (LSTYPE.EQ.31) THEN
      INCLUDE 'IDIM31.INC'
            CALL XLDLST (31,ICOM31,IDIM31,0)
         END IF
 
         IF (IERFLG.GE.0) JLOAD(MLST)=1
      END DO
c
C
C 
C----- LIST 1 AND 31
C
      IF (JLOAD(1).GE.1) THEN
C --  CONVERT ANGLES TO DEGREES.

         CIFA = STORE(L1P1)
         CIFB = STORE(L1P1+1)
         CIFC = STORE(L1P1+2)
         CIFAL = STORE(L1P1+3)
         CIFBE = STORE(L1P1+4)
         CIFGA = STORE(L1P1+5)

         STORE(L1P1+3)=RTD*STORE(L1P1+3)
         STORE(L1P1+4)=RTD*STORE(L1P1+4)
         STORE(L1P1+5)=RTD*STORE(L1P1+5)
         CALL XZEROF (ESD,6)
         IF (JLOAD(4).GE.1) THEN
C----- SCALE DOWN THE ELEMENTS OF THE V/CV MATRIX
            SCALE=STORE(L31K)
            M31=L31
            ESD(1)=SQRT(STORE(M31)*SCALE)
            ESD(2)=SQRT(STORE(M31+6)*SCALE)
            ESD(3)=SQRT(STORE(M31+11)*SCALE)
            ESD(4)=SQRT(STORE(M31+15)*SCALE)*RTD
            ESD(5)=SQRT(STORE(M31+18)*SCALE)*RTD
            ESD(6)=SQRT(STORE(M31+20)*SCALE)*RTD
         END IF

         IF ( IPUNCH .EQ. 0 ) THEN
          DO I=0,2
C----- VALUE AND ESD
            CALL XFILL (IB,IVEC,16)
            CALL SNUM (STORE(L1P1+I),ESD(I+1),-2,0,12,IVEC)
            WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CBUF,N)
            WRITE (NCFPU1,600) CCELL(I+1)(1:1),CBUF(1:N)
600         FORMAT ('_cell_length_',A,T35,A)
          END DO
          DO I=0,2
            CALL XFILL (IB,IVEC,16)
cdjwjul05
            CALL SNUM (STORE(L1P1+3+I),ESD(I+4),-2,0,12,IVEC)
            WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
            CALL XCRAS (CBUF,N)
            J=INDEX(CBUF(1:N),'.')
            IF (J.EQ.0) J=MAX(1,N)
            TEMP=STORE(L1P1+3+I)-INT(STORE(L1P1+3+I))
            IF (TEMP.LE.ZERO) N=MAX(1,J-1)
            WRITE (NCFPU1,650) CANG(I+1)(1:5),CBUF(1:N)
650         FORMAT ('_cell_angle_',A,T35,A)
          END DO
         END IF

         VOL = V(CIFA,CIFB,CIFC,CIFAL,CIFBE,CIFGA)

         CU=SQRT((VOL-V(CIFA+ESD(1),CIFB,CIFC,CIFAL,CIFBE,CIFGA))**2
     1        + (VOL-V(CIFA,CIFB+ESD(2),CIFC,CIFAL,CIFBE,CIFGA))**2
     2        + (VOL-V(CIFA,CIFB,CIFC+ESD(3),CIFAL,CIFBE,CIFGA))**2
     3        + (VOL-V(CIFA,CIFB,CIFC,CIFAL+ESD(4)*DTR,CIFBE,CIFGA))**2
     4        + (VOL-V(CIFA,CIFB,CIFC,CIFAL,CIFBE+ESD(5)*DTR,CIFGA))**2
     5        + (VOL-V(CIFA,CIFB,CIFC,CIFAL,CIFBE,CIFGA+ESD(6)*DTR))**2)

         CALL XFILL (IB,IVEC,16)
         CALL SNUM (VOL,CU,-2,0,12,IVEC)
         WRITE (CBUF,'(16A1)') (IVEC(J),J=1,16)
         CALL XCRAS (CBUF,N)
         IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (NCFPU1,750) CBUF(1:N)
750        FORMAT ('_cell_volume ',T35,A)
           CALL XPCIF (' ')
         END IF
      END IF
C 
C----- LIST 2
C

      Z2 = 1
      IFLACK = 0
      IF (JLOAD(2).GE.1) THEN
         ICENTR=NINT(STORE(L2C))+1
         Z2 = STORE(L2C+3)
C----- CRYSTAL CLASS - FROM LIST 2
         J=L2CC+MD2CC-1
         WRITE (CTEMP,800) (ISTORE(I),I=L2CC,J)
800      FORMAT (4(A4))
         CBUF=' '
cdjwnov2011 - make all text lowercase - requested by ALT
         CALL XCCLWC (CTEMP(1:),CBUF(1:))
c         CBUF(1:1)=CTEMP(1:1)
         CALL XCTRIM (CBUF,J)
         J = J - 1
         IF ( IPUNCH .EQ. 0 ) THEN
           WRITE (CLINE,850) CBUF(1:J)
           CALL XPCIF (CLINE)
850        FORMAT ('_symmetry_cell_setting',T35,'''',A,'''')
         END IF
C 
C ----- DISPLAY SPACE GROUP SYMBOL
         J=L2SG+MD2SG-1
         WRITE (CTEMP,900) (ISTORE(I),I=L2SG,J)
900      FORMAT (4(A4,1X))
         CBUF=' '
         CALL XCCLWC (CTEMP(2:),CBUF(2:))
         CBUF(1:1)=CTEMP(1:1)
         CALL XCTRIM (CBUF,J)
         WRITE (CLINE,950) CBUF(1:J)
950      FORMAT ('_symmetry_space_group_name_H-M',T35,'''',A,'''')
951      FORMAT ('_symmetry_space_group_name_Hall',T35,'?')
         IF  ( IPUNCH .EQ. 0 ) THEN
           CALL XPCIF (CLINE)
           WRITE (CLINE,951)
           CALL XPCIF (CLINE)
         END IF
 
         IF ( IPUNCH .EQ. 0 ) THEN
C DISPLAY EACH SYMMETRY OPERATOR
            CALL XCIF2(NCFPU1)
         END IF
C
         IF ( IPUNCH .EQ. 0 ) THEN
           IF ( NINT ( STORE(L2C) ) .LE. 0 ) THEN
             IFLACK = 0
           ELSE
             IFLACK = 1
           END IF
         END IF
      END IF
C 
C
      GO TO 2650
C----- ERROR EXIT
2600  CONTINUE
C 
2650  CONTINUE
C----- CLOSE THE 'CIF' OUTPUT FILE
      IF ( IPUNCH .EQ. 0 ) THEN
        CALL XRDOPN (7,KDEV,CSSCIF,LSSCIF)
      END IF
      RETURN
      END
c
CODE FOR LINFIT
	function LINFIT(mode,x,y,wt,a,sa,b,sb,t,tsq,r,rsq,mitem,
     1  root, xcoord, ycoord, grad)
c least squares best line, based on Wolfram
c  http://mathworld.wolfram.com/LeastSquaresFitting.html
c  y = a + bx
c
c verified against Watts & Halliwell, Essential Environmental
c Science, Routledge, 1996.
c
      save ss,sx,sxx,sy,syy,sxy,nitem
      dimension  root(2), xcoord(2), ycoord(2), grad(2)
      INCLUDE 'XUNITS.INC'
      INCLUDE 'XIOBUF.INC'
      INCLUDE 'XSSVAL.INC'
      INCLUDE 'XCONST.INC'
c
      root(1) = 0.
      root(2) = 0.
      grad(1) = 0.
      grad(2) = 0.
c
      if(mode.eq.1) then
	ss = 0.
	sx = 0.
	sxx = 0.
	sy = 0.
	syy = 0.
	sxy = 0.
        nitem=0
        xmax = 0.
        ymax = 0.

      else if (mode.eq.2) then	
        nitem=nitem+1
	ss = ss+wt
	sx = sx + x*wt
	sxx = sxx + x*x*wt
	sy = sy + y*wt
	syy = syy + y*y*wt
	sxy = sxy + x*y*wt
        xmax = max(xmax, x*wt)
        ymax = max(ymax, y*wt)


      else
        mitem = nitem
        LINFIT = +1
c
c        WRITE (*,'(a,9x,2f12.3)') 
c     2 ' Gradient for zero intercept =',SXY/SXX
c        WRITE (11,'(a,9x,2f12.3)') 
c     2 ' Gradient for zero intercept =',SXY/SXX
c
	denom = ss*sxx - sx*sx
        if(abs(denom) .gt. zero) then
            a = (sy*sxx - sx*sxy)/denom
            b = (ss*sxy - sx*sy)/denom

c based on Wolfram world but including weights (derived by DJW so 
c beware)
            sqs = ((syy*sxx)-(sxy*sxy))/ ((mitem-2)*sxx)
            sa = (sx*sx)/(mitem*mitem*sxx) +(1./float(mitem))
            sa = sa * sqs
            if (sa .ge. 0.0) then
                  sa = sqrt(sa)
            else
c                  write(ncwu,*) 'Sa negative', sa
                  sa = -999.
            endif
            sb = (((syy*sxx)-(sxy*sxy))/((mitem-2)*sxx*sxx))
            if (sb .ge. 0.0) then
                  sb = sqrt(sb)
            else
c                  write(ncwu,*) 'Sb negative', sb
                  sb = -999.
            endif
c            write(ncwu,'(2(a,4f10.3))') ' Gradient and esd', b, sb
c      1      ' Intercept and su', a, sa
c
        else
           if (issprt .eq. 0) 
     1      write(ncwu,*)'Denominator 1 in linfit = ', denom
            LINFIT = -1
        endif

c r   = r in Watts & Halliwell, page 111
c rsq = r-sq in Excel,  & W&H, page 112
c t   = t in Watts & Halliwell page 113
c tsq = F-test in Excel

        denom=(ss*sxx-sx*sx)*(ss*syy-sy*sy)
        if(denom .gt. 0.0) then
                  r    =  (ss*sxy-sx*sy)/sqrt(denom)
                  rsq  = r * r
                  if ((ss .ge. 2.).and.(1. .ge. rsq)) then
                        t   =  r*sqrt(ss-2.)/sqrt(1.-rsq)
                        tsq =  rsq*(ss-2.)/(1.-rsq)
                  else
                        t = -999.
                        tsq = -999.
                  endif
         else
           if (issprt .eq. 0) 
     1       write(ncwu,*)'Denominator 2 in linfit = ', denom
                  LINFIT = -2
         endif
500     format (A,t40,2f11.3,4x,i7)
501     format (A,t40,2f11.7,4x,i7)
        ax = max(xmax,ymax)
        if (issprt .eq. 0) THEN
          if (ax .ge. .001) then
          write(NCWU,500) 
     1 'Weighted averages of x and y', sx/ss, sy/ss, mitem
           write(NCWU,500) 'Weighted RMS',
     1  sqrt(sxx/mitem), sqrt(syy/mitem)
           write(NCWU,500) 'Weighted Maxima  ', xmax, ymax
          else
           write(NCWU,501) 
     1 'Weighted averages of x and y', sx/mitem, sy/mitem, mitem
c           write(NCWU,501) 'Weighted RMS',
c     1  sqrt(sxx/mitem), sqrt(syy/mitem)
           write(NCWU,501) 'Weighted Maxima  ', xmax, ymax
          endif
        endif
c
c      this call assumes that the original coordinates were 
c      centred on 0,0
c
        call EIGEN2(sxx,sxy,syy,XCOORD,YCOORD,ROOT,GRAD)

          write(cmon(1)(:),602)
600       format(a,t40,f11.0,3f11.3)
601       format(a,t40,f11.8,3f11.3)
602       format('Principal Componenet Analysis')
          if (root(1) .ge. 0.001) then
            write(cmon(2)(:),600)'Major root,Components,angle',
     1      root(1), xcoord(1), ycoord(1), grad(1)
            write(cmon(3)(:),600)'Minor root,Components,angle',
     1      root(2), xcoord(2), ycoord(2), grad(2)
          else
            write(cmon(2)(:),601)'Major root,Components,angle',
     1      root(1), xcoord(1), ycoord(1), grad(1)
            write(cmon(3)(:),601)'Minor root,Components,angle',
     1      root(2), xcoord(2), ycoord(2), grad(2)
          endif      
        call xprvdu(ncvdu,3,0)
        if (issprt .eq. 0) THEN
          write(ncwu,'(/a/a/a)')cmon(1)(:),cmon(2)(:),cmon(3)(:)
        endif
      endif
      return
      end
c
CODE FOR EIGEN2
      SUBROUTINE EIGEN2(A,B,D,X,Y,ROOT,GRAD)
c get eigen info for a symmetric 2x2 matrix
C      a = a11
c      b = a12 = a21
c      d = a22
c
      dimension x(2), y(2), root(2), grad(2)
c
c check for diagonal matrix
      if (abs(b) .le. .000001) then
        if(a.gt.d) then
          root(1) = a
          x(1) = 1.
          y(1) = 0.
          root(2) = d
          x(2) = 0.
          y(2) = -1.
          grad(1) = 0
          grad(2) = 1000000
        else
          root(1) = d
          x(1) = 0.
          y(1) = 1.
          root(2) = a
          x(2) = -1.
          y(2) = 0.
          grad(1) = 1000000
          grad(2) = 0
        endif
      goto 100
      endif

      term =((a-d)*(a-d)+4.*b*b)
      term = sqrt(term)

      root(1) = ((a+d)+term)/2.
      root(2) = ((a+d)-term)/2.

      if(abs(b).ge.abs(root(1)-d)) then
        grad(1) = (root(1)-a)/b
      else
        grad(1) = b/(root(1)-d)
      endif

      if(abs(b).ge.abs(root(2)-d)) then
        grad(2) = (root(2)-a)/b
      else
        grad(2) = b/(root(2)-d)
      endif

      if(abs(b) .gt. abs(root(1)-d)) then
       side = sqrt(b*b+(root(1)-a)*(root(1)-a))
       x(1) = b / side
       y(1) = (root(1)-a) / side
      else
       side = sqrt(b*b+(root(1)-d)*(root(1)-d))
       x(1) = (root(1)-d) / side
       y(1) = b / side
      endif

      if(abs(b) .gt. abs(root(2)-d)) then
       side = sqrt(b*b+(root(2)-a)*(root(2)-a))
       x(2) = b / side
       y(2) = (root(2)-a) / side
      else
       side = sqrt(b*b+(root(2)-d)*(root(2)-d))
       x(2) = (root(2)-d) / side
       y(2) = b / side
      endif

      grad(1) = 180. *atan2((root(1)-a),b)/3.14159
      grad(2) = 180. *atan2((root(2)-a),b)/3.14159
c
      if(grad(1).gt.135.) grad(1)=grad(1)-180.
      if(grad(1).lt. -45.) grad(1)=grad(1)+180.
c
      if(grad(2).gt. 45.) grad(2)=grad(2)-180.
      if(grad(2).lt.-135.) grad(2)=grad(2)+180.

100   continue
      return
      end
