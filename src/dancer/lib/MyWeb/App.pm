package MyWeb::App;
use Dancer2;
our $Time;
our $File;
sub getTimeFile{
	my $command=`ls -l /home/jazhao/test/`;
	my @tmp=split(/\n/,$command);
	my @array=split(/ /,$tmp[1]);
	$Time=$array[8];
	$File=$array[9];
}


our $VERSION = '0.1';
get '/' => sub {
    getTimeFile();
    template 
	'index' => { Time => $Time,File => $File },
};

true;
