#!/usr/bin/env perl

use 5.018_000;
use strict;
use warnings;

no if $] >= 5.018, warnings => "experimental::smartmatch";
no if $] >= 5.018, warnings => "experimental::lexical_subs";

use Mojo::Asset::Memory;
use Mojo::UserAgent;
use Mojo::IOLoop;
use Mojo::Util qw/ camelize decamelize quote dumper /;

use Mojo::JSON qw/ decode_json encode_json /;
use Mojo::CSV;
use Try::Tiny;

my $client = Mojo::UserAgent->new;

my $results = 0;

for my $page (@ARGV) {

    my $cache = Mojo::Asset::Memory->new;
    $cache->max_memory_size(2000000);

    $client->get(
        "https://www.girlmerry.com/$page" => sub {

            my ( $client, $server ) = @_;

            try {

                for my $item (
                    $server->res->dom->find("li.item.product.product-item")
                    ->each )
                {
                    $results++;

                    # Result
                    say "\nRESULT: $results\n";

                    # Name

                    my $name = $item->at("a.product-item-link")->text;
                    $name =~ s/^\s+|\s+$//g;
                    say decamelize "\tNAME: $name";

                    # Image

                    my $image =
                      $item->at("img.product-image-photo")->{'data-src'};
                    say "\tIMAGE: $image";

                    # Price

                    my $price = $item->at("span.price")->text;
                    $price =~ s/^\s+|\s+$//g;
                    say decamelize "\tPRICE: $price";

                    #my @colors;

                   #for my $color (
                   #    $server->res->dom->at("div.swatch-option.image")->each )
                   #{
                   #    push @colors, $color->{'option-label'};
                   #}

                    #say "\tCOLORS: " . join ",", sort @colors
                    #  unless scalar @colors == 0;

                    # Sizes

                    for (
                        split /\n/,
                        $item->at(
                            "div.product.details.product-item-details > script")
                        ->text
                      )
                    {

                        if (m/.*jsonSwatchConfig/g) {

                            s/^\s+|\s+$//g;

                            my ($jsonSwatchConfig) =
                              ( $_ =~ m/jsonSwatchConfig: (.*),/g );
                            $jsonSwatchConfig = decode_json $jsonSwatchConfig;

                            my @sizes;

                            for my $id ( keys %{$jsonSwatchConfig} ) {
                                for my $code (
                                    keys %{ $jsonSwatchConfig->{$id} } )
                                {
                                    for my $key (
                                        keys
                                        %{ $jsonSwatchConfig->{$id}->{$code} } )
                                    {

                                        next if $key ne 'label';

                                        push @sizes,
                                          $jsonSwatchConfig->{$id}->{$code}
                                          ->{$key}
                                          if $jsonSwatchConfig->{$id}->{$code}
                                          ->{$key} =~
                                          m/^[S|M|L|XL|XXL|3XL|OS]$/g;
                                    }
                                }
                            }

                            @sizes = reverse sort(@sizes);
                            my $sizes = join( ",", @sizes );
                            say "\tSIZES: $sizes" unless scalar @sizes == 0;
                        }
                    }
                }
             }
        }
    );
}

Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
