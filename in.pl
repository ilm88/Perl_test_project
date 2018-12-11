#!/usr/bin/perl

use v5.15;
use strict;
use warnings;
use utf8;
use diagnostics;

use LWP;
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;
use HTTP::Headers;
use JSON;
use HTML::TreeBuilder;
use HTML::FormatText;
use Data::Dumper qw(Dumper);

my $response;
print "Введите имя пользователя для получения статистики о его активности на GitHub.
Или введите exit для выхода \n";
while(my $line = <STDIN>) {   
  chomp($line); # отсекаем символ \n
  last if($line eq "exit");
  use_api_github ($line);  
  print_response ($response);

};
sub use_api_github {
my $name = shift;  
my $lwp = LWP::UserAgent-> new;
my $uri = "https://api.github.com/users/$name/repos";
my $request = HTTP::Request->new(GET => "$uri");
$response = $lwp->request($request);

1
};
sub print_response {
my $response = shift;
if ($response-> is_success){
    print $response-> content;
    }
else{
    print $response-> error_as_HTML;
    }
1
};
sub parse_response {

1
};
sub print_parse_response {

1
};
