#!/usr/bin/env perl
use strict;

my $dir = `pwd`;
print "Dir = $dir\n";
my @ls = split /\n/, `ls`;
mkdir('tar');

foreach my $ls(@ls){
	my @files = split /\n/ , `ls $ls`;
	my @blast;
	my @unfinished;
	next if $ls eq 'tar';

	print "Checking $ls";

	foreach my $file(@files){
			
		if($file =~/blast$/){
			push @blast, $file;
		}
		else{
			
			push @unfinished, $file;
		}
	}
	if(scalar @unfinished > 0){
		print "$ls not complete!\n";
		print join "\n", @unfinished;
	
	}
	else{
		print "\t OK!\n";
		my $tar = "tar -czvf tar/$ls.tgz.tmp $ls > tar/$ls.log";
		if(-s "tar/$ls.tgz"){
			print "Skipping $ls , tar already exists\n";
		}
		else{
			print "About to tar $tar \n";
			system("$tar; mv tar/$ls.tgz.tmp tar/$ls.tgz");
			print "Tarred $ls and moved from tar/$ls.tgz.tmp to tar/$ls.tgz\n";
		}
	}
	
}
