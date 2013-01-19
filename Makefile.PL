
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Mojolicious plugin to interact with a remote ident service",
  "AUTHOR" => "Graham Ollis <plicease\@cpan.org>",
  "BUILD_REQUIRES" => {
    "AnyEvent::Ident" => 0,
    "Mojolicious::Lite" => 0,
    "Test::Mojo" => 0,
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Mojolicious-Plugin-Ident",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Mojolicious::Plugin::Ident",
  "PREREQ_PM" => {
    "AnyEvent" => 0,
    "AnyEvent::Ident" => "0.02",
    "AnyEvent::Ident::Client" => 0,
    "AnyEvent::Ident::Response" => 0,
    "EV" => 0,
    "Mojo::Base" => 0,
    "Mojo::Exception" => 0,
    "base" => 0
  },
  "VERSION" => "0.26",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



