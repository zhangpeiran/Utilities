#!/usr/bin/perl
$weightnum=72;
open(FILE, "EIGENVAL");
$_=<FILE>;
$fermilevel=4.5485;
@tmp=split;
$nspin=$tmp[3];
for($i=0;$i<4;$i++) {
$_=<FILE>;
}
$_=<FILE>;
@tmp=split;
$nkpts=$tmp[1]-$weightnum;
$nbnds=$tmp[2];
for($i=0;$i<$weightnum;$i++)
{
$_=<FILE>;
$_=<FILE>;
@judge=split;
for($j=0;$j<$nbnds;$j++) {
$_=<FILE>;
@tmp=split;
if($nspin==1) {
$te[$j]=$tmp[1];
}
else {
$te[$j*2]=$tmp[1];
$te[$j*2+1]=$tmp[2];
}
}
}
for($i=0;$i<$nkpts;$i++) {
$_=<FILE>;
$_=<FILE>;
@judge=split;
for($j=0;$j<$nbnds;$j++) {
$_=<FILE>;
@tmp=split;
if($nspin==1) {
$te[$j]=$tmp[1];
}
else {
$te[$j*2]=$tmp[1];
$te[$j*2+1]=$tmp[2];
}
}
push @ebnds, [ @te ];
}
close(FILE);
open(FILE, "OUTCAR");
while($_=<FILE>) {
if(/k-points in units of 2pi\/SCALE/) {
$_=<FILE>;
@kold=split;
$kpt[0]=0;
for($i=1;$i<$weightnum;$i++)
{
$_=<FILE>;
}
for($i=1;$i<$nkpts;$i++) {
$_=<FILE>;
@knew=split;
if ($i%100==0) {
$kpt[$i]=$kpt[$i-1];
}
else {
$kpt[$i]=$kpt[$i-1]+sqrt(($knew[0]-$kold[0])**2+($knew[1]-$kold[1])**2+($knew[2]-$kold[2])**2);
}
@kold=@knew;
}
}

}

for($i=0;$i<$nbnds;$i++) {
for($j=0;$j<$nkpts;$j++) {
if($nspin==1) {
printf("%12.9f %12.9f\n",$kpt[$j],$ebnds[$j][$i]-$fermilevel);
}
else {
printf("%12.9f %12.9f %12.9f\n",$kpt[$j],$ebnds[$j][$i*2]-$fermilevel,$ebnds[$j][$i*2+1]-$fermilevel);
}
}
printf("\n");
}

