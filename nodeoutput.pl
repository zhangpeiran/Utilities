#!/usr/bin/perl
open(FILE,"WT.out");
for($i=0;$i<25004270;$i++)
{
$_=<FILE>;
@line=split;
if($line[4] eq F && $line[5] eq F )
{
                printf("%12.9f %12.9f %12.9f %s %s \n",$line[1],$line[2],$line[3],$line[4],$line[5])
}
}


