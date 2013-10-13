#!/usr/bin/perl
# programmer: Yunfei Wang
# usage:
# input:
# output:

open(FILE,$ARGV[0]) or die("Fail to open FILE.\n");
while ($line=<FILE>)
{
	chomp ($line);
	@line = split("\t",$line);
}
close FILE;

