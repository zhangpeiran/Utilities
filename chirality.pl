#!/usr/bin/perl
#
#

$WT="WT.out";
$command = readpipe("wc -l ./Nodes.dat");
@buffer = split(/\s/,$command);
$linenumber = $buffer[0];
&read_chirality ($WT);
open(FILE,"Nodes.dat");
$_=<FILE>;
printf($_);
$_=<FILE>;
printf($_);
for($i=0;$i<$linenumber;$i++)
{
#printf("The chirality is : %d \n",$chirality[$i]);
$_=<FILE>;
if($chirality[$i]==1 || $chirality[$i]==-1) {
printf($_);
}
}
close(FILE);
sub read_chirality {
my @command,@line;
my $linenumber,$i;
$command = readpipe("wc -l $_[0]");
@buffer = split(/\s/,$command);
$linenumber = $buffer[0];
open(FILE,"$_[0]");
while($_=<FILE>){
if(/Chiralities/) {
$_=<FILE>;
for($i=0;$i<$linenumber;$i++) {
$_=<FILE>;
@line=split;
if($line[3] == -1 || $line[3] == 1 || $line[3] == 0) {
push @chirality,$line[3];
}
}
}
}
close(FILE);

}





