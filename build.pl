#!/usr/bin/perl
###################################
#Author :Jiang Li
#Email  :riverlee2008@gmail.com
#MSN    :riverlee2008@live.cn
#Address:Harbin Medical University
#TEl    :+86-13936514493
###################################
use strict;
use warnings;
use Getopt::Long;
my($version,$doversion,$dodate);
GetOptions ("version=s" => \$version,
	    "doversion=s" =>\$doversion,
	    "dodate=s" =>\$dodate);
	
	
my $doversionlong=$dodate." (sub_version ".$doversion.")";
my $parentdir=`pwd`;

#1)#################################
#first step:cp moban to DO.db
`test -d "DO.db" && rm -rf DO.db`;
`mkdir DO.db`;
`cp -rf moban/* DO.db/`;

#2)##################################
#second step: modify the DESCRIPTION file
=desc
Package: DO.db
Title: A set of annotation maps describing the entire Disease Ontology
Description: A set of annotation maps describing the entire Disease Ontology assembled using data from DO
Version: ?
Author: Jiang Li
Maintainer: Jiang Li <riverlee2008@gmail.com>
Depends: R (>= 2.7.0), methods, AnnotationDbi (>= 1.9.7)
Imports: methods, AnnotationDbi
License: Artistic-2.0
biocViews: AnnotationData, FunctionalAnnotation
Packaged: ? UTC; Jiang Li
=cut

my $descfile= "DO.db/DESCRIPTION";
my $tmp=`cat $descfile`;
my $time= localtime();
#print $tmp,"\n";
$tmp=~s/Version: \?/Version: $version/g;
$tmp=~s/Packaged: \?/Packaged: $time/g;
open(O,">$descfile") or die $!;
print O $tmp;
close O;

#3)###################################
#Third step:replace "With a date stamp from the source of: ?" with the right version for disease ontology
#e.g. With a date stamp from the source of: 20100429 (version 926)
chdir "DO.db/man" or die $!;
my $commandstr= qq{sed -i 's/source of: ?/source of: $doversionlong/g' `grep -rl 'source of: ?' *`};
`$commandstr`;


#4)###################################
#Fourth step: modify the create_DO.db.pl file
chdir "../../" or die $!;
chdir "DO.db/inst/scripts" or die $!;
my $filename = "create_DO.db.pl";
`sed -i 's/dodate/$dodate/g' $filename`;
`sed -i 's/doversion/$doversion/g' $filename`;


#5)###################################
#Fifth step: cp the HumanDO.obo file to the  DO.db/inst/scripts directory
` cp ../../../HumanDO.obo ./`;
system("bash batch_run.sh");


#6)###################################
#sixth step: move the DO.sqlite file to the inst/extdata
`mv DO.sqlite ../extdata/`;












    
	       



