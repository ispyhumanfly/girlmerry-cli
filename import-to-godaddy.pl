#!/usr/bin/env perl

use 5.018_000;
use strict;
use warnings;

no if $] >= 5.018, warnings => "experimental::smartmatch";
no if $] >= 5.018, warnings => "experimental::lexical_subs";

use Mojo::CSV;
use Try::Tiny;

my $columns = [
    [
        'Product Name', 'SKU',             'Price',  'Sale Price',
        'Description',  'Track Inventory', 'Qty',    'Backorder',
        'Weight',       'Featured',        'Hidden', 'Category',
        'Image URL',    'SEO',             'Options'
    ]
];

my @row;

while (<STDIN>) {

    # Product Name
    $row[0] = ($_ =~ m/NAME: (.*)/g) if m/NAME/g;

    # SKU
    $row[1] = ($_ =~ m/RESUlT: (.*)/g) if m/RESULT/g;

    # Price
    $row[2] = ($_ =~ m/PRICE: (.*)/g) if m/PRICE/g;

    push @{ $columns }, \@row;# if $_ eq '' and undef @row;
}

Mojo::CSV->new->spurt( $columns => 'godaddy-online-store.csv' );
