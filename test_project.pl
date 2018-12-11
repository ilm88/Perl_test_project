#!/usr/bin/perl

use v5.15;
use strict;
use warnings;
use utf8;
use diagnostics;

use LWP::UserAgent;
use HTTP::Request;
use Data::Dumper qw(Dumper);

print "Введите имя пользователя для получения статистики о его активности на GitHub.
Или введите exit для выхода \n";
while(my $line = <STDIN>) {   
    chomp($line); # отсекаем символ \n
    last if($line eq "exit");
    parse_response_commits ($line)
   
};
sub uri_gen {
    if ( $#_ == 0){
        my $name=shift;
        my $uri = "https://api.github.com/users/$name/repos";
    }
    elsif ( $#_ == 1) { 
        my ($name, $repos)=@_;
        my $uri = "https://api.github.com/repos/$name/$repos/commits";
    };   
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
       print $response-> error_as_HTML;
       };  
};
sub get_repos_name {
    my $uri = shift;
    my $content;
    my @repos;
    my $response = api_github($uri);
    $content=$response-> content;
    @repos=$content=~m/"node\_id":"\w*=","name":"(.*?)"/img;
};
sub get_repos_commits {
    my $uri = shift;
    my $content;
    my @commits;
    my $response = api_github($uri);
    $content=$response-> content;
    @commits=$content=~m/"commit":(\S*?)"\},"committer"/img;
    
};
sub parse_response_commits {
    my $line=shift;  
    my $uri = uri_gen ($line);
    my @repos = get_repos_name ($uri); 
    my @response;
    foreach my $repos (@repos){
        my $uri = uri_gen ($line, $repos);
        #say $uri; #test
        @response = get_repos_commits ($uri);
        #say Dumper \@response;
        my $sumrep=$#response+1;
        say "Репозиторий ", $repos, " коммитов ", $sumrep;
    };   
};
sub repos_name { 
    my $line=shift;  
    my $uri = uri_gen ($line);
    my @repos = get_repos_name ($uri);  
    say Dumper \@repos; 
};

