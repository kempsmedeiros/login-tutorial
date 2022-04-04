package ConnectionDb;

use strict;
use warnings;
use DBI;


my $db = '';
my $user = '';
my $password = '';


sub new {
   my $class = shift;
   my $self = {
        #member variables
        db => $db,
        user => $user,
        password => $password,

    };
    bless $self, $class;
    return $self;
}


sub connectDb {
    my ($self) = @_;
    my $database = DBI->connect ($self->{db},
                        $self->{user},
                        $self->{password}) 
                        or die "Can't connect to database: $DBI::errstr\n";
    return $database; 
}


1;