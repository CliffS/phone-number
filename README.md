# NAME

Phone::Number - Module to hold a phone number from a UK-centric
point of view.

# VERSION

Version 1.1.0

# SYNOPSYS

    use Phone::Number;
    

    my $num = new Phone::Number('02002221666');
    print $num->formatted;    # 020 0222 1666
    print $num->packed;       # 02002221666
    print $num->number;       # +442002221666
    print $num->plain;        # 442002221666
    print $num->uk ? "yes" : "no"; # yes

# EXPORT

Nothing is exported

# ROUTINES

## new

Creates a new, immutable object using any unambiguous phone
number format.

    my $num = new Phone::Number('02002221666');
    my $num = new Phone::Number('2002221666');
    my $num = new Phone::Number('442002221666');
    my $num = new Phone::Number('+442002221666');
    my $new = new Phone::Number($num);

## formatted

Returns the number formatted with leading 0 and spaces.

This can be used for displaying the number in "standard" format.

The raw object stringifies to the formatted version.

## packed

Returns the number with a leading 0 but no spaces.

This can be useful for databases but see ["plain"](#plain) below.

## number

Returns the number in international format starting with +.

## plain

Returns the number in international format without the +.

This is usually the best way to store the number onto a database.

## uk

Returns a boolean: true if it is a valid UK number

# AUTHOR

Cliff Stanford, `<cpan@may.be>`

# BUGS

Please report any bugs or feature requests to
`bug-phone-number at rt.cpan.org`, or through
the web interface at
[http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Phone-Number](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Phone-Number).
I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Phone::Number

# LICENSE AND COPYRIGHT

Copyright 2014 Cliff Stanford.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
