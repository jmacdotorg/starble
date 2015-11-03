package Starble;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple

    Session
    Session::Store::DBIC
    Session::State::Cookie

    Authentication

/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in starble.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Starble',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header

    'View::JSON' => {
        'expose_stash' => [ qw/ result guid / ],
    },

    'Model::StarbleDB' => {
        schema_class => 'Starble::Schema',
    },

    'Plugin::Authentication' => {
        default_realm => "default",
        default => {
            credential => {
                class => 'Password',
                password_field => 'password',
                password_type => 'clear'
            },
            store => {
                class => 'Minimal',
                users => {
                    starble => {
                        password => "starble",
                    },
                },
            },
        },
    },

    'Plugin::Session' => {
        'expires' => 31536000, # Year
        'dbic_class' => 'StarbleDB::Session',
    },


);

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

Starble - Catalyst based application

=head1 SYNOPSIS

    script/starble_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Starble::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Jason McIntosh

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
