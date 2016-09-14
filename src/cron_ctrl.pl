#!/usr/bin/perl
#通过修改/etc/crontab文件，在需要被暂停的服务前加#将该服务注释掉，如需重启则去掉注释

use strict;
use Tie::File;

#确保输入参数为两个
if(!$ARGV[0] or !$ARGV[1]){
	print "请按要求输入参数\n";
}
else{
#$jobName为目标工作，$action为期望动作。
my $jobName=$ARGV[0];
my $action=$ARGV[1];

tie my @crontabProfile, 'Tie::File', '/etc/crontab' or die "can't open $!\n";
#启动
if($action eq "--start"){
	foreach (@crontabProfile){
		if($_ =~ m/$jobName/){
			s/^#//;
		}	
 }
 }
#暂停
elsif($action eq "--stop"){
	foreach (@crontabProfile){
		if($_ =~ m/$jobName/){
			s/^#*(.*$)/#$1/;
		}
}
}
#显示当前状态
elsif($action eq "--list"){
	foreach (@crontabProfile){
		if($_ =~ m/$jobName/){
			if($_ =~ m/^#/){
				print "该服务现在的状态为暂停";
			}
			else{
				print "该服务现在的状态为已激活";
			}
		}
	}
}

untie @crontabProfile;
exit 0;
}
