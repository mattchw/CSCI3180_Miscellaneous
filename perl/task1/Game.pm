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

package Game;
use MannerDeckStudent; 
use Player;

sub new {
	#Instantiate a variable deck with a Deck object and an array to record players.
    my $class = shift @_;
    my $deck = MannerDeckStudent->new();
    my @players = ();
    my @cards = ();
	my $object = bless {"deck"=>\$deck,"players"=>\@players, "cards"=>\@cards}, $class;
	return $object;
}

sub set_players {
    #"players name" is a reference to a one-dimensional array recording the name of the players. The players variable will be instantiated by the players name.
    my $self = shift @_;
	my $players_name = shift @_;
    my $playerNum = scalar(@$players_name);
    my $x = 52 % ($playerNum);
    if($x!=0){
        print "Error: cards' number 52 can not be divided by players number ",$playerNum,"!\n";
        return 0;
    }
    else{
        print "There ",scalar(@$players_name)," players in the game:\n";
        for my $i (@$players_name){
            print $i." ";
            my $playerObj = Player->new($i);
            #print "print playerObj: ",$playerObj->{"name"},"\n";
            push @{$self->{"players"}}, $playerObj;
            #print "print instance players array: ",@{$self->{"players"}},"\n";
        }
        
        print "\n\n";
    }
    return 1;
}

sub getReturn {
    #Calculate how many will be returned to the player from the current cards stack.
    my $self = shift @_;
    my $cards = shift @_;
    my $counter = 0;
    my $found = 0;
    #print "in get return \n";
    for my $i (reverse 0..$#{$self->{"cards"}}) {
        #print "hi ",@{$self->{"cards"}}[$i],"\n";
        $counter++;
        if ($cards eq @{$self->{"cards"}}[$i]){
            #print "found card\n";
            $found = 1;
            last;
        }
    }
    if($found == 1){
        #print $counter," cards will be returned\n";
        return $counter;
    }
    return 0;
}

sub showCards {
	#Show the cards on the cards stack.
    my $self = shift @_;
    my $limit = scalar @{$self->{"cards"}};
    my $counter = 1;
    for my $i (@{$self->{"cards"}}){
        print $i;
        if($counter<$limit){
            print " ";
            $counter++;
        }
    }
    print "\n";
}

sub start_game {
    #Start a new game. First, deck will be shuffled and each participant will get a deck of cards evenly. 
    #And then players will deal cards and get cards return by turn. In each player’s turn, he/she firstly deal a card and then get some or no return according to the rule. 
    #Finally, the winner will be shown. You are required to output very important information in this function and more details can be found in the output specifications.
    
    my $self = shift @_;
    my $playerNum = scalar(@{$self->{"players"}});
    my $winner = "";
    my $end=0;
    my $round = 0;
    print "Game begin!!!\n\n";
    ${$self->{"deck"}}->shuffle(); #shuffle the deck
    my @shuffledDeck = ${$self->{"deck"}}->AveDealCards($playerNum); #divide the deck evenly
    
    #distribute cards
    for my $i (0..($playerNum-1)){
        @{@{$self->{"players"}}[$i]->{"cards"}}=@{$shuffledDeck[$i]};
    }
    
    while($end==0){
        $round++;
        for my $i (@{$self->{"players"}}){
            if($i->numCards()!=0){
                print "Player ", $i->{"name"}," has ",$i->numCards()," cards before deal.\n";
                print "=====Before player's deal=======\n";
                $self->showCards();
                print "================================\n";

                my $dealCards = $i->dealCards();
                print $i->{"name"}," ==> card ",$dealCards,"\n";

                my $returnCards=0;
                my $isJack=0;
                #check card stack
                if ($dealCards eq "J"){
                    if (scalar(@{$self->{"cards"}})!=0){
                        #take all
                        $isJack=1;
                    }
                }
                else{
                    $returnCards=$self->getReturn($dealCards);
                }
                push @{$self->{"cards"}},$dealCards;
                if($returnCards!=0){
                    for my $j(0..($returnCards)){
                        my $card = pop @{$self->{"cards"}};
                        push @{$i->{"cards"}}, $card;
                    }
                }
                elsif ($isJack==1){
                    for my $j(0..(scalar(@{$self->{"cards"}})-1)){
                        my $card = pop @{$self->{"cards"}};
                        push @{$i->{"cards"}}, $card;
                    }
                }

                print "=====After player's deal=======\n";
                $self->showCards();
                print "================================\n";
                print "Player ", $i->{"name"}," has ",$i->numCards()," cards after deal.\n";
                if ($i->numCards()==0){
                    print "Player ", $i->{"name"}," has no cards, out!\n";
                    #print "\n";
                    $playerNum--;
                    if($playerNum==1){
                        $end=1;
                        last;
                    }
                }
                print "\n";
            }
        }
    }
    for my $i (@{$self->{"players"}}){
        if($i->numCards()!=0){
            print "\nWinner is ",$i->{"name"}," in game ",$round,"\n";
            last;
        }
    }
    #print "\n";
}

return 1;
