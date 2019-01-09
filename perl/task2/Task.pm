#
# CSCI3180 Principles of Programming Languages
#
# --- Declaration ---
#
# I declare that the assignment here submitted is original except for source
# material explicitly acknowledged. I also acknowledge that I am aware of
# University policy and regulations on honesty in academic work, and of the
# disciplinary guidelines and procedures applicable to breaches of such policy
# and regulations, as contained in the website
# http://www.cuhk.edu.hk/policy/academichonesty/
#
# Assignment 3
# Name : Wong Cho Hin
# Student ID : 1155070355
# Email Addr : wongch6@cse.cuhk.edu.hk
#

use strict;
use warnings;

package Task;
our $pidCount=0;
sub new {
    #Instantiate an object of Task with its name, time, and return the object. The pid is counted from zero and plus one for each new task (The first task has pid 0).
    my $class = shift @_;
    my $name = shift @_;
    my $time = shift @_;
    my $pid = $pidCount;
	my $object = bless {"name"=>\$name, "time"=>\$time, "pid"=>\$pid}, $class;
    $pidCount++;
	return $object;
}

sub name{
    my $self = shift @_;
    return ${$self->{"name"}};
}

sub pid{
    my $self = shift @_;
    return ${$self->{"pid"}};
}

sub time{
    my $self = shift @_;
    return ${$self->{"time"}};
}

return 1;