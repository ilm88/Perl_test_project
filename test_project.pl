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
    repos_name($line)
   
};
sub uri_gen {
    if ( $#_ == 0){
    my $name=shift;
    my $uri = "https://api.github.com/users/$name/repos";
    }
    else { 
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
    my $response = api_github($uri);
    my $content;
    my @repos;
    $content=$response-> content;
    @repos=$content=~m/"node\_id":"\w*=","name":"(.*?)"/img;
};
sub get_repos_commits {
    my $uri = shift;
    my $response = api_github($uri);
    my $content;
    my $repos;
    my @commit;
    $content=$response-> content;
    @commit=$content=~m/"node\_id":"\w*=","name":"(.*?)"/img;
    #use Data::Dumper;
    #say Dumper \@repos;
    #print @repos;
};
sub parse_response {
1
};
sub repos_name { 
my $in=shift;  
my $uri = uri_gen ($in);
my @repos = get_repos_name ($uri);  
say Dumper \@repos; 
};
#sub print_response {
#    my $response = shift;
#    if ($response-> is_success){
#        print $response-> content;
#        }
#    else{
#       print $response-> error_as_HTML;
#       }
#};
