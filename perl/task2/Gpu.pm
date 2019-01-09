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

package Gpu;
use Task;

sub new {
    #Instantiate an object of GPU and the initial state is set to idle.
    my $class = shift @_;
    my $time = 0; #- Current execution time of the task.
    my $state = 0; #- The state of GPU, it has two value, 1 and 0. 1 means busy and 0 means idle.
    my $task = undef; #- An object of Class Task, which means the task occupying it.
    my $id = 0; #- The ID of this GPU in the server.
	my $object = bless {"time"=>\$time, "state"=>\$state, "task"=>\$task, "id"=>\$id}, $class;
	return $object;
}
sub assign_task {
    #Assign a new task to this GPU. Its state will become busy and time is set to zero.
    my $self = shift @_;
    my $newTask = shift @_;
    ${$self->{"task"}}=$newTask;
}
sub release {
    #Release the task and re-initialize the variable.
    my $self = shift @_;
    ${$self->{"task"}}=undef;
    ${$self->{"time"}}=0;
    ${$self->{"state"}}=0;
    #print "released\n";
}
sub execute_one_time {
    #Execute the task one time. When the task is finished, it will be released.
    my $self = shift @_;
    if (${$self->{"task"}}){
        ${$self->{"time"}}++;
        if (${$self->{"task"}}->time()==${$self->{"time"}}){
            $self->release();
            print "task in gpu(id: ".${$self->{"id"}}.") finished\n";
        }
    }
}
sub id{
    my $self = shift @_;
    return ${$self->{"id"}};
}

return 1;
