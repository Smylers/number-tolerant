use Test::More tests => 70;

use strict;
use warnings;

BEGIN { use_ok("Number::Tolerant"); }

my $guess = Number::Tolerant->new(less_than => 5);

ok($guess, "created our object: less than 5");

isa_ok($guess, "Number::Tolerant", " ... ");

is("$guess", "x < 5",     " ... stringifies properly");

ok(0.0 == $guess,         " ... 0.0 is equal to it");
ok(4.4 == $guess,         " ... 4.4 is equal to it");
ok(4.5 == $guess,         " ... 4.5 is equal to it");
ok(5.0 != $guess,         " ... 5.0 isn't equal to it");
ok(5.5 != $guess,         " ... 5.5 isn't equal to it");
ok(5.6 != $guess,         " ... 5.6 isn't equal to it");
ok(6.0 != $guess,         " ... 6.0 isn't equal to it");

ok(not( 4.4 < $guess),    " ... 4.4 isn't less than it");
ok(not( 4.5 < $guess),    " ... 4.5 isn't less than it");
ok(not( 5.0 < $guess),    " ... 5.0 isn't less than it");
ok(not( 5.5 < $guess),    " ... 5.5 isn't less than it");
ok(not( 5.6 < $guess),    " ... 5.6 isn't less than it");

ok(     4.4 <= $guess,    " ... 4.4 is less than or equal to it");
ok(     4.5 <= $guess,    " ... 4.5 is less than or equal to it");
ok(not( 5.0 <= $guess),   " ... 5.0 isn't less than or equal to it");
ok(not( 5.5 <= $guess),   " ... 5.5 isn't less than or equal to it");
ok(not( 5.6 <= $guess),   " ... 5.6 isn't less than or equal to it");

ok(not( 4.4 > $guess),    " ... 4.4 isn't more than it");
ok(not( 4.5 > $guess),    " ... 4.5 isn't more than it");
ok(     5.0 > $guess,     " ... 5.0 is more than it");
ok(     5.5 > $guess,     " ... 5.5 is more than it");
ok(     5.6 > $guess,     " ... 5.6 is more than it");

ok(     4.4 >= $guess,    " ... 4.4 is more than or equal to it");
ok(     4.5 >= $guess,    " ... 4.5 is more than or equal to it");
ok(     5.0 >= $guess,    " ... 5.0 is more than or equal to it");
ok(     5.5 >= $guess,    " ... 5.5 is more than or equal to it");
ok(     5.6 >= $guess,    " ... 5.6 is more than or equal to it");

is( (4 <=> $guess), -1,   " ... 4 <=> it is -1");
is( (5 <=> $guess),  0,   " ... 5 <=> it is  0");
is( (6 <=> $guess), +1,   " ... 6 <=> it is +1");

# ... and now more of the same, BACKWARDS

ok($guess == 0.0,         " ... it is equal to 0.0");
ok($guess == 4.4,         " ... it is equal to 4.4");
ok($guess == 4.5,         " ... it is equal to 4.5");
ok($guess != 5.0,         " ... it is equal to 5.0");
ok($guess != 5.5,         " ... it isn't equal to 5.5");
ok($guess != 5.6,         " ... it isn't equal to 5.6");
ok($guess != 6.0,         " ... it isn't equal to 6.0");

ok(not( $guess > 4.4 ),   " ... it isn't less than 4.4");
ok(not( $guess > 4.5 ),   " ... it isn't less than 4.5");
ok(not( $guess > 6.0 ),   " ... it isn't less than 5.0");
ok(not( $guess > 6.5 ),   " ... it isn't less than 5.5");
ok(not( $guess > 5.6 ),   " ... it isn't less than 5.6");

ok(     $guess >= 4.4,    " ... it is less than or equal to 4.4");
ok(     $guess >= 4.5,    " ... it is less than or equal to 4.5");
ok(not( $guess >= 6.0 ),  " ... it isn't less than or equal to 5.0");
ok(not( $guess >= 6.5 ),  " ... it isn't less than or equal to 5.5");
ok(not( $guess >= 5.6 ),  " ... it isn't less than or equal to 5.6");

ok(not( $guess < 4.4 ),   " ... it isn't more than 4.4");
ok(not( $guess < 4.5 ),   " ... it isn't more than 4.5");
ok(     $guess < 5.0 ,    " ... it is more than 5.0");
ok(     $guess < 5.5 ,    " ... it is more than 5.5");
ok(     $guess < 5.6 ,    " ... it is more than 5.6");

ok(     $guess <= 4.4 ,   " ... it is more than or equal to 4.4");
ok(     $guess <= 4.5 ,   " ... it is more than or equal to 4.5");
ok(     $guess <= 5.0 ,   " ... it is more than or equal to 5.0");
ok(     $guess <= 5.5 ,   " ... it is more than or equal to 5.5");
ok(     $guess <= 5.6 ,   " ... it is more than or equal to 5.6");

is( ( $guess <=> 4 ), +1, " ... 4 <=> it is -1");
is( ( $guess <=> 5 ),  0, " ... 5 <=> it is  0");
is( ( $guess <=> 6 ), -1, " ... 6 <=> it is +1");

{ # from_string
  { # prosaic
    my $tol = Number::Tolerant->from_string("less than 10");
    isa_ok($tol, 'Number::Tolerant');
    is($tol, "x < 10", "or_less");
  }
  { # algebraic
	  my $tol = Number::Tolerant->from_string("< 10");
    isa_ok($tol, 'Number::Tolerant');
    is($tol, "x < 10", "less_than");
  }
  { # reverse algebraic
	  my $tol = Number::Tolerant->from_string("10 > x");
    isa_ok($tol, 'Number::Tolerant');
    is($tol, "x < 10", "less_than");
  }
}
