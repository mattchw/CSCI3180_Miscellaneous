use strict;
use warnings;

package Task;
sub new {
    #Instantiate an object of Task with its name, time, and return the object. The pid is counted from zero and plus one for each new task (The first task has pid 0).
    my $class = shift @_;
    my $name = shift @_;
    my $time = shift @_;
    my $pid = 0;
	my $object = bless {"name"=>$name, "time"=>$time, "pid"=>$pid}, $class;
	return $object;
}

sub name{
    my $self = shift @_;
    return $self->{"name"};
}

sub pid{
    my $self = shift @_;
    return $self->{"name"};
}

sub time{
    my $self = shift @_;
    return $self->{"time"};
}

return 1;