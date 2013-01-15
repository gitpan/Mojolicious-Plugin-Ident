package Mojolicious::Plugin::Ident::Response;

use strict;
use warnings;
use Mojo::Base -base;

# ABSTRACT: Ident response object
our $VERSION = '0.22'; # VERSION


has 'os';
has 'username';

# private attributes (undocumented may go away)
has 'remote_address';

my $server_user_uid;
my $server_user_name;

sub _server_user_uid  { $server_user_uid  }
sub _server_user_name { $server_user_name }

sub _setup
{
  if($^O eq 'MSWin32')
  {
    $server_user_name = $ENV{USERNAME};
  }
  else
  {
    $server_user_uid  = $<;
    $server_user_name = scalar getpwuid($<);
  }
  die "could not determine username"
    unless defined $server_user_name
    &&     $server_user_name;
}


sub same_user
{
  my($self) = @_;
  return unless $self->remote_address eq '127.0.0.1';
  return 1 if $self->username eq $server_user_name;
  return 1 if defined $server_user_uid && $self->username =~ /^\d+$/ && $self->username == $server_user_uid;
  return;
}

1;


__END__
=pod

=head1 NAME

Mojolicious::Plugin::Ident::Response - Ident response object

=head1 VERSION

version 0.22

=head1 DESCRIPTION

This class represents the responses as they come back
from the remote ident server.

NOTE: This class is only used for blocking requests.
If you provide a callback, then you are probably 
more interested in L<AnyEvent::Ident::Response>, which
is similar, but does not have a C<same_user> method.

=head1 ATTRIBUTES

=head2 $ident-E<gt>username

The username of the remote connection as provided by
the remote ident server.

=head2 $ident-E<gt>os

The operating system of the remote connection as provided
by the remote ident server.

=head1 METHODS

=head2 $ident-E<gt>same_user

Returns true if the remote user is the same as the one which started the 
Mojolicious application.  The user is considered the same if the remote 
connection came over the loopback address (127.0.0.1) and the username 
matches either the server's username or real uid.

=head1 SEE ALSO

L<Mojolicious::Plugin::Ident>

=head1 AUTHOR

Graham Ollis <plicease@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

