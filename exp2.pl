#!/usr/bin/perl -w

use v5.15;
use strict;
use warnings;
use utf8;
use IO::Socket;

use LWP::UserAgent;
use HTTP::Request;
use LWP::Simple;

my $url = "https://api.github.com/users/ilm88/repos";

my $content = get $url;
die "Couldn't get $url" unless defined $content;
# Далее что-нибудь делаем с $content, например:
print $content;
#if($content =~ m/jazz/i) {
#    print "They're talking about jazz today on Fresh Air!\n";
#  } else {
#    print "Fresh Air is apparently jazzless today.\n";
#  };