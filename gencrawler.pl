#!/usr/bin/env perl

use 5.018_000;
use strict;
use warnings;

no if $] >= 5.018, warnings => "experimental::smartmatch";
no if $] >= 5.018, warnings => "experimental::lexical_subs";

use Mojo::Asset::Memory;
use Mojo::UserAgent;
use Mojo::IOLoop;
use Mojo::Util qw/ camelize decamelize quote dumper url_escape url_unescape/;

use Mojo::JSON qw/ decode_json encode_json /;
use Try::Tiny;

use Email::Valid::Loose;

my $ua = Mojo::UserAgent->new;

#$ua->proxy->http('socks://127.0.0.1:9050');

$ENV{MOJO_MAX_MESSAGE_SIZE} = '0';

my %CACHE;

for my $query (@ARGV) {

    $ua->max_redirects(5)->get(
        "https://duckduckgo.com/html/?q=$query" => sub {

            my ($ua, $tx) = @_;

            # Level 1

            my %level_1_data;

            my @links = $tx->res->dom->find("a")->map(attr => 'href')->each;

            for (@links) {

                next unless $_;
                $level_1_data{normalize_links($_)} = '';
            }

            for (keys %level_1_data) {

                next if $_ eq '1';

                for ($ua->max_redirects(5)->get($_)->res->dom->find("a")->map(attr => "href")->each)
                {

                    next if not $_;

                    if (m/mailto/g) {
                        s/mailto://g;

                        my $email = decamelize $_;

                        if (not exists $CACHE{$email}) {
                            $CACHE{$email} = '';
                            say decamelize $_
                              if Email::Valid::Loose->address($_);
                        }
                    }
                }

                $ua->get(
                    "$_" => sub {

                        my ($ua, $tx) = @_;

                        # Level 2

                        my %level_2_data;

                        my @links = $tx->res->dom->find("a")->map(attr => 'href')->each;

                        for (@links) {

                            next unless $_;
                            $level_2_data{normalize_links($_)} = '';
                        }

                        for (keys %level_2_data) {

                            next if $_ eq '1';

                            for ($ua->max_redirects(5)->get($_)->res->dom->find("a")
                                ->map(attr => "href")->each)
                            {

                                next if not $_;

                                if (m/mailto/g) {
                                    s/mailto://g;

                                    my $email = decamelize $_;

                                    if (not exists $CACHE{$email}) {
                                        $CACHE{$email} = '';
                                        say decamelize $_
                                          if Email::Valid::Loose->address($_);
                                    }
                                }
                            }

                            $ua->get(
                                "$_" => sub {

                                    my ($ua, $tx) = @_;

                                    # Level 3

                                    my %level_3_data;

                                    my @links = $tx->res->dom->find("a")->map(attr => 'href')->each;

                                    for (@links) {

                                        next unless $_;
                                        $level_3_data{normalize_links($_)} = '';
                                    }

                                    for (keys %level_3_data) {

                                        next if $_ eq '1';

                                        for ($ua->max_redirects(5)->get($_)->res->dom->find("a")
                                            ->map(attr => "href")->each)
                                        {

                                            next if not $_;

                                            if (m/mailto/g) {
                                                s/mailto://g;

                                                my $email = decamelize $_;

                                                if (not exists $CACHE{$email}) {
                                                    $CACHE{$email} = '';
                                                    say decamelize $_
                                                      if Email::Valid::Loose->address($_);
                                                }
                                            }
                                        }

                                        $ua->get(
                                            "$_" => sub {

                                                my ($ua, $tx) = @_;

                                                # Level 4

                                                my %level_4_data;

                                                my @links =
                                                  $tx->res->dom->find("a")->map(attr => 'href')
                                                  ->each;

                                                for (@links) {

                                                    next unless $_;
                                                    $level_4_data{normalize_links($_)} = '';
                                                }

                                                for (keys %level_4_data) {

                                                    next if $_ eq '1';

                                                    for ($ua->max_redirects(5)->get($_)
                                                        ->res->dom->find("a")->map(attr => "href")
                                                        ->each)
                                                    {

                                                        next if not $_;

                                                        if (m/mailto/g) {
                                                            s/mailto://g;

                                                            my $email = decamelize $_;

                                                            if (not exists $CACHE{$email}) {
                                                                $CACHE{$email} = '';
                                                                say decamelize $_
                                                                  if Email::Valid::Loose->address(
                                                                    $_);
                                                            }
                                                        }
                                                    }

                                                    $ua->get(
                                                        "$_" => sub {

                                                            my ($ua, $tx) = @_;

                                                            # Level 5

                                                            my %level_5_data;

                                                            my @links =
                                                              $tx->res->dom->find("a")
                                                              ->map(attr => 'href')->each;

                                                            for (@links) {

                                                                next unless $_;
                                                                $level_5_data{normalize_links($_)}
                                                                  = '';
                                                            }

                                                            for (keys %level_5_data) {

                                                                next
                                                                  if $_ eq '1';

                                                                for (
                                                                    $ua->max_redirects(5)->get($_)
                                                                    ->res->dom->find("a")
                                                                    ->map(attr => "href")->each)
                                                                {

                                                                    next
                                                                      if not $_;

                                                                    if (m/mailto/g) {
                                                                        s/mailto://g;

                                                                        my $email = decamelize $_;

                                                                        if (not
                                                                            exists $CACHE{$email})
                                                                        {
                                                                            $CACHE{$email} = '';
                                                                            say decamelize $_
                                                                              if
                                                                              Email::Valid::Loose
                                                                              ->address($_);
                                                                        }
                                                                    }
                                                                }

                                                                $ua->get(
                                                                    "$_" => sub {

                                                                        my ($ua, $tx) = @_;

                                                                        # Level 6

                                                                        my %level_6_data;

                                                                        my @links =
                                                                          $tx->res->dom->find("a")
                                                                          ->map(attr => 'href')
                                                                          ->each;

                                                                        for (@links) {

                                                                            next
                                                                              unless $_;
                                                                            $level_6_data{
                                                                                normalize_links($_)
                                                                            } = '';
                                                                        }

                                                                        for (keys %level_6_data) {

                                                                            next
                                                                              if $_ eq '1';

                                                                            for (
                                                                                $ua->max_redirects(
                                                                                    5)->get($_)
                                                                                ->res->dom->find(
                                                                                    "a")
                                                                                ->map (
                                                                                    attr => "href")
                                                                                ->each
                                                                              )
                                                                            {

                                                                                next
                                                                                  if not $_;

                                                                                if (m/mailto/g) {
                                                                                    s/mailto://g;

                                                                                    my $email =
                                                                                      decamelize $_;

                                                                                    if (not
                                                                                        exists
                                                                                        $CACHE{
                                                                                            $email})
                                                                                    {
                                                                                        $CACHE{
                                                                                            $email}
                                                                                          = '';
                                                                                        say decamelize
                                                                                          $_
                                                                                          if
                                                                                          Email::Valid::Loose
                                                                                          ->address(
                                                                                            $_);
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                );
                                                            }
                                                        }
                                                    );
                                                }
                                            }
                                        );
                                    }
                                }
                            );
                        }
                    }
                );
            }
        }
    );

    sub normalize_links {

        my $link = shift;

        try {
            $link = url_unescape $link;
            my ($clean) = $link =~ m/.*(http.*)/g;
            return $clean unless not $clean;
        }
    }

    sub normalize_emails {

        my $email = shift;
        $email =~ s/mailto://g;
        return $email if Email::Valid::Loose->address($email) || return 0;
    }
}

Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
