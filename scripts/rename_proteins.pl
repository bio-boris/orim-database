#!/usr/bin/env perl
use strict;

print "Changing dir\n";
chdir("/home/sadkhin2/orim/data/phytozome10/fasta");
my @list_of_fasta = `ls | grep fa\$`;



foreach my $fp(@list_of_fasta){
	my $counter = 0;
	chomp $fp;
	my ($organism,$number,@rest) = split /\_/, $fp;
	open F, $fp or die $!;
	my $temp_output = "$fp.renamed.tmp";
	open O, ">$temp_output" or die $! . $temp_output;
	while(my $line = <F>){
		if(substr($line,0,1) eq ">"){
			$line = substr($line,1);
			$line = ">$organism" . "_" . "$number" . "_" . $counter++ . " " . "$line";
		}
		print O $line;
	}
	close O;
	close F;
	if(-s "$temp_output"){
	print "Completing printing $organism to $fp.renamed.tmp\n";
		system("mv $temp_output $fp.renamed");
	}
	else{
		die "Error renaming $fp\n";
	}


}
