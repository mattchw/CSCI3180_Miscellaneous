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

package Player;
sub new {
    my $class = shift @_;
    my $name = shift @_;
	my @cards = ();
	my $object = bless {"name"=>$name, "cards"=>\@cards}, $class;
	return $object;
}

sub getCards {
    #Put the taken cards to the bottom of his/her deck.
    my $self = shift @_;
    my $add = shift @_;
    print $add,"\n";
	push @{$self->{"cards"}}, $add;  
}

sub dealCards {
    #Take a card from the top of his/her deck and deal it to the game.
    my $self = shift @_;
    my $dealCard = shift @{$self->{"cards"}};
    #print $dealCard;
    return $dealCard;
}

sub numCards {
    #Return the number of player’s cards.
    my $self = shift @_;
    my $num = scalar(@{$self->{"cards"}});
    return $num;
}

return 1;