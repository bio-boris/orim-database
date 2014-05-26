#!/usr/bin/env perl
# Last edited May 26, 2014
# Created on May 26, 2014
# Summary : Gunzip files
# 
use strict;
use FindBin qw($Bin);
use lib "$Bin/";
use orim_config qw(orim_config);
$/ = "\n";

my %config = orim_config();
my $dir = $config{'phytozome'};
my @organisms = split /\n/,  `ls $dir`;

foreach my $organism(@organisms){
	my $pwd =("$dir/$organism/annotation");
	print "About to gunzip * in pwd : $pwd";
	chdir($pwd);
	system("gunzip *");


}

