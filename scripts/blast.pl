#!/usr/bin/env perl
use strict;
my $array_id = shift @ARGV;

unless(length $array_id > 0 && $array_id >0){
	die "Need array id\n";
}

my $base_dir = '/home/sadkhin2/orim';
my $fasta_dir = "/home/sadkhin2/scratch/fasta";
my $organism_list = "$fasta_dir/organism_fasta_list";
my $blast_dir = "/home/sadkhin2/scratch/blasts";
mkdir($blast_dir);

chomp(my $organism_name = `head -n $array_id $organism_list| tail -n1`);

open F, $organism_list or die $!;
while(my $line= <F>){
	chomp $line;
	mkdir("$blast_dir/$organism_name");
	blast($line);
}


sub blast{
	my $organism2_name = $_[0];
	my $input_file = "$fasta_dir/$organism_name.renamed";
	my $data_base = "$fasta_dir/$organism2_name.renamed";
	my $output_file = "$blast_dir/$organism_name/$organism_name-$organism2_name.blast";
	my $temp = "$output_file.temp";

	if(-s $output_file){
		print "Skipping $output_file , already exists\n";
		return;
	}
	else{
		my $call = "blastall -p blastp -i $input_file -d $data_base -e 1e-5 -m8 -a12 -o $temp -b20 -v20 ";

		print "\n##################################################################\n";
		print "\nAbout to blast $organism_name against $organism2_name\n\n";
		print $call,"\n";

		system($call);

		if(-s $temp){
			print "Moving $temp to $output_file\n";
			system("mv $temp $output_file");
		}
		else{
			print "Something went wrong , $temp does not exist\n";
		}
	}



	;



}
