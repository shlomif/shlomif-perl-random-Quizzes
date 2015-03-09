package Site::Member;

use strict;
our $VERSION = '0.01';

sub new { bless { ip_address => '' }, shift }

sub ip_address { 
    my ($self, $ip_address) = @_;
    $self->{ip_address} = $ip_address if $ip_address;
    return $self->{ip_address};
}

# ...

sub city {
    my ($self) = @_;
    eval "use Geo::IP";
    if ($@) {
        warn "You must have Geo::IP installed for this feature";
        return;
    }
    my $geo = Geo::IP->open(
                "/usr/local/share/GeoIP/GeoIPCity.dat", 
                Geo::IP->GEOIP_STANDARD
            ) || die "Could not create a Geo::IP object with City data";
    my $record = $geo->record_by_addr($self->ip_address());
    return $record->city();
}

