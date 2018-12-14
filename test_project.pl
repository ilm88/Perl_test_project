#!/usr/bin/perl

use v5.15;
use strict;
use warnings;
use utf8;
use diagnostics;

use LWP::UserAgent;
use HTTP::Request;
use Data::Dumper qw(Dumper);

my $name;
my @repos;
my %response;
print "Введите имя пользователя для получения данных об активности на GitHub.
Или введите exit для выхода \n";
while(my $line = <STDIN>) {   
    
    chomp($line); # отсекаем символ \n
    last if($line eq "exit");
    $name=$line;
    say "Статистика пользователя. ", $name, ".";
    get_repos_name ();
    get_repos_commits ();
    print_respons ();
};

sub api_github { 
    my $uri = shift;  
    my $lwp = LWP::UserAgent-> new;
    my $request = HTTP::Request->new(GET => "$uri");
    my $response = $lwp->request($request);
    if ($response-> is_success){
        return $response;
        }
    else{
       print $response-> error_request_api_github;
       };  
};
sub get_repos_name {
    my $uri = "https://api.github.com/users/$name/repos";
    my $response = api_github($uri);
    my $content=$response-> content;
    @repos=$content=~m/"node\_id":"\w*=","name":"(.*?)"/img;
};
sub get_repos_commits {
    foreach my $repos (@repos){
        my $uri = "https://api.github.com/repos/$name/$repos/commits";
        my $response = api_github($uri);
        my $content=$response-> content;
        my @commits=$content=~m/"commit":\{"(\S*?)\},"committer"/img;  
        foreach my $commit (@commits){
            $commit=~m/"date":"(.*?)"/ig;
            #if проверка на "свежесть"
            $response{$name}{$repos}{$1}++;
        };  
    };
        
};
sub table {
};
sub print_respons {
    say Dumper \%response;
};