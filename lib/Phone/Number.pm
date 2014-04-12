package Phone::Number;

use strict;
use warnings;
use 5.10.0;

=head1 NAME

Phone::Number - Module to halde a phone number from a UK-centric
point of view.

=cut

our $VERSION = '0.01';

use Carp;

use overload q("") => 'number';

# Passed a string or a Number object.  If the latter, simply returns it.
sub new
{
    my $class = shift;
    my $number = shift or croak "No number passed to new $class";
    return $number if ref $number && $number->isa($class);
    $number =~ s/^\s*(.*?)\s*$/$1/;	# trim leading/trailing spaces
    $number =~ s/\D//g;			# throw away non-digits
    $number =~ s/^44/0/;		# change leading 44 into 0
    $number =~ s/^(?=[1-9])/00/;	# it still starts with a 1-9, add 00
    my $self = {};
    $self->{raw} = $number;
    $self->{valid} = $number =~ /^0[123578]\d{8,9}$/;
    my $formatted;
    given ($number)
    {
	when (/^02/)
	{
	    ($formatted = $number) =~ s/^(\d{3})(\d{4})(\d*)/$1 $2 $3/;
	}
	when (/^03/)
	{
	    ($formatted = $number) =~ s/^(\d{4})(\d{3})(\d*)/$1 $2 $3/;
	}
	when (/^01\d?1/ || /^08[47]/) {
	    ($formatted = $number) =~ s/^(\d{4})(\d{3})(\d*)/$1 $2 $3/;
	}
	when (/^0[85]0/) {
	    ($formatted = $number) =~ s/^(\d{4})(\d{3})(\d*)/$1 $2 $3/;
	}
	when (/^0(?!0)/) {
	    ($formatted = $number) =~ s/^(\d{5})(\d*)/$1 $2/;
	}
	default {
	    $formatted = $number;
	}
    }
    $self->{formatted} = $formatted;
    $number =~ s/^00/+/;
    $number =~ s/^0/+44/;
    $self->{number} = $number;
    bless $self, $class;
}

sub formatted	    # the number formatted with leading 0 and spaces
{
    my $self = shift;
    return $self->{formatted};
}

sub packed	    # the number with leading 0, no spaces
{
    my $self = shift;
    (my $packed = $self->formatted) =~ s/\s+//g;
    return $packed;
}

sub number	    # the number in international format starting with +
{
    my $self = shift;
    return $self->{number};
}

sub plain	    # the number in international format without the +
{
    my $self = shift;
    (my $plain = $self->{number}) =~ s/^\+//;
    return $plain;
}

sub uk		    # boolean: is it a valid UK number
{
    my $self = shift;
    return $self->{valid};
}

1;
