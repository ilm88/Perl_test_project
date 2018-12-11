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
use JSON::PP qw();
use HTML::TreeBuilder;
use HTML::FormatText;
use Data::Dumper qw(Dumper);




print "Введите имя пользователя для получения статистики о его активности на GitHub.
Или введите exit для выхода \n";
while(my $line = <STDIN>) {   
    chomp($line); # отсекаем символ \n
    last if($line eq "exit");
    my $uri = "https://api.github.com/users/$line/repos";
    use_api_github ($uri);  
    #print "Введите название репозитория для получения статистики коммитов.
    #Или введите exit для выхода \n";
    #while(my $line = <STDIN>){
        #chomp($line); # отсекаем символ \n
        #last if($line eq "exit");

        #use_api_github ($line);
    #};
};


sub use_api_github { #Данная подпрограмма вызывается с аргументом содержащим имя пользователя по 
# которому делается запрос 
    use Data::Dumper;
    my $uri = shift;  
    my $lwp = LWP::UserAgent-> new;
    my $request = HTTP::Request->new(GET => "$uri");
    my $response = $lwp->request($request);
    #if
    my @repos=return_repos_name ($response);
    say Dumper \@repos;
    #elsif
    #my @commit=return_repos_commit ($response);
    #say Dumper \@repos;
    #print_response ($response);
};
sub return_repos_name {
    my $response = shift;
    my $content;
    my @repos;
    $content=$response-> content;
    @repos=$content=~m/"node\_id":"\w*=","name":"(.*?)"/img;
    #use Data::Dumper;
    #say Dumper \@repos;
    #print @repos;
};
sub return_repos_commit {
    my $response = shift;
    my $content;
    my $repos;
    my @commit;
    $content=$response-> content;
    @commit=$content=~m/"node\_id":"\w*=","name":"(.*?)"/img;
    #use Data::Dumper;
    #say Dumper \@repos;
    #print @repos;
};
sub print_response {
    my $response = shift;
    if ($response-> is_success){
        print $response-> content;
        }
    else{
       print $response-> error_as_HTML;
       }
};

sub parse_response {

1
};
sub print_parse_response {

1
};

