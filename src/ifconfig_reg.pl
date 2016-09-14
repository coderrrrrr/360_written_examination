#!/usr/bin/perl

#ifconfig_reg子程序解析ifconfig命令的标准输出返回一个hash。key是网卡名称，value是对应的ip。
sub ifconfig_reg{
	$command = `ifconfig`;
	@com_out=split(/\n/,$command);

	#循环遍历每一行，判断是否有mac地址，如果有再判断一下行是否有ip地址
	foreach $i (0..$#com_out){
		if ($com_out[$i] =~ m/HWaddr(.+?)\s/){
	 		$HWaddr=$1;
			if ($com_out[$i+1] =~ m/inet addr+?:(.+?)B/){
				 $result{$HWaddr}=$1;
			}else{
				 $result{$HWaddr}='';
			}
		}
	}
	return %result;
}
#test
print ifconfig_reg();
