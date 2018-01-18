#!/usr/bin/perl
open(FILE,"WT.out");
while($_=<FILE>) {
if(/Chiralities/)
{
for($i=0;$i<3768;$i++)
{
$_=<FILE>;
@line=split;
if($line[3] == 1 || $line[3] == -1 )
{
                printf("%12.9f %12.9f %12.9f %12.9f \n",$line[0],$line[1],$line[2],$line[3])

}
}
}
}
