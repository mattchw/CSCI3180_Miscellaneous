use strict;
use warnings;

our $add;
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
    print $add,"\n";
	push @{$self->{"cards"}}, $add;  
}

sub dealCards {
    #Take a card from the top of his/her deck and deal it to the game.
    my $self = shift @_;
    my $dealCard = shift @{$self->{"cards"}};
    print $dealCard," is popped \n";
}

sub numCards {
    #Return the number of player’s cards.
    my $self = shift @_;
    my $num = scalar(@{$self->{"cards"}});
    return $num;
}

return 1;