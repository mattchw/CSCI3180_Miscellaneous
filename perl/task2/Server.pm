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
 
package Server;
use Gpu;
use Task;
our $task;
our $gpu;

sub new {
    #Initialize the gpus array with gpu num GPU Object. The array index represents the GPU index.
    my $class = shift @_;
    my $gpu_num = shift @_;
    my @gpus = ();
    for my $i (0..($gpu_num-1)){
        my $gpuObj = Gpu->new();
        ${$gpuObj->{"id"}}=$i;
        push @gpus, $gpuObj;
    }
    my @waitq = ();
    my $object = bless {"gpus"=>\@gpus, "waitq"=>\@waitq}, $class;
    return $object;
}
sub task_info {
    #Output the task information.
	return "task(user: ".$task->name().", pid: ".$task->pid().", time: ".$task->time().")";
}
sub task_attr {
    #Return the task attributes.
	return $task->name(), $task->pid(), $task->time();
}
sub gpu_info {
    #Return the GPU information.
	return "gpu(id: ".$gpu->id().")";
}
sub submit_task {
    #Assign the submitted task to a idel GPU in ascending order. If there is no empty GPU, it will be added in the waiting queue.
    my $self = shift @_;
    my $name = shift @_;
    my $time = shift @_;
    my $found = 0;
    local $task=Task->new($name,$time);
    print task_info();
    print " => ";
    for my $i (@{$self->{"gpus"}}){
        local $gpu = $i;
        if(${$i->{"state"}}==0){
            print gpu_info();
            ${$i->{"state"}}=1;
            ${$i->{"task"}}=$task;
            $found=1;
            last;
        }
    }
    if($found==0){
        print "waiting queue";
        push @{$self->{"waitq"}},$task;
    }
    print "\n";
}
sub deal_waitq {
    #Check the waiting queue and submit the task if any GPU is idle.
    my $self = shift @_;
    if(scalar(@{$self->{"waitq"}})!=0){
        for my $i (@{$self->{"gpus"}}){ 
            if(${$i->{"state"}}==0){
                my $waitTask = undef;
                for my $j (@{$self->{"waitq"}}){
                    $waitTask = shift @{$self->{"waitq"}};
                    if($waitTask){
                        last;
                    }
                }
                if($waitTask){
                    local $task=$waitTask;
                    local $gpu = $i;
                    print task_info();
                    print " => ";
                    print gpu_info();
                    ${$i->{"state"}}=1;
                    ${$i->{"task"}}=$task;
                    print "\n";
                    last;
                }
            }
        }
        
    }

}
sub kill_task {
    #Kill the task with given pid and name. If there is no corresponding task, output the failure message.
    my $self = shift @_;
    my $name = shift @_;
    my $pid = shift @_;
    my $found=0;
    for my $i (@{$self->{"gpus"}}){
        local $task=${$i->{"task"}};
        if ($task&&($task->name() eq $name)&&($task->pid()==$pid)){
            $found=1;
            print "user ".$name." kill ".task_info()."\n";
            $i->release();
            $self->deal_waitq();
        }
    }
    if($found==0){
        for my $i (@{$self->{"waitq"}}){
            if (($i->name() eq $name)&&($i->pid()==$pid)){
                $found=1;
                local $task=$i;
                print "user ".$name." kill ".task_info()."\n";
                $i=undef;
            }
        }
    }
    if($found==0){
        print "user ".$name." kill task(pid: ".$pid.") fail\n";
    }
}
sub execute_one_time {
    #Excute all the GPU one unit time. The task is finished once reaching the set
    my $self = shift @_;
    print "execute_one_time..\n";
    for my $i (@{$self->{"gpus"}}){
        $i->execute_one_time();
        $self->deal_waitq();
    }
}
sub show {
    #Print the current GPU message.
    my $self = shift @_;
    print "==============Server Message================\n";
    print "gpu-id  state  user  pid  tot_time  cur_time\n";
    for my $i (@{$self->{"gpus"}}){
        local $task=${$i->{"task"}};
        print "  ",${$i->{"id"}},"   ";
        print "  ";
        if(${$i->{"state"}}==1){
            print "busy";
        }
        elsif (${$i->{"state"}}==0){
            print "idle";
        }
        if ($task){
            my ($user, $pid, $time) = task_attr();
            print "   ".$user."    ".$pid."      ".$time."         ".${$i->{"time"}};
        }
        print "\n";
    }
    for my $i (@{$self->{"waitq"}}){
        local $task=$i;
        if($i){
            my ($user, $pid, $time) = task_attr();
            print "        wait";
            print "   ".$user."    ".$pid."      ".$time;
            print "\n";
        }
    }
    print "============================================\n\n";
}


return 1;