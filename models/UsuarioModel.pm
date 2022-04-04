package UsuarioModel;

use strict;
use warnings;

use lib "../modules";

use ConnectionDb;

my $connection = ConnectionDb->new();
my $database = $connection->connectDb();

sub new {
   my $class = shift;
   my $self = {
        #member variables
        # id => shift,
        nome => shift,
        email => shift,
        senha => shift,

    };
    bless $self, $class;
    return $self;

}

sub create {
    my ($self) = @_;
    my $query = "INSERT INTO usuarios VALUES(NULL, ?, ?, ?)";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($self->{nome}, $self->{email}, $self->{senha});
    # $database->disconnect();
    my $rowsAffecteds = $stateHandler->rows;    
    return $rowsAffecteds;
  
}

sub getAll {
    my ($self) = @_;
    my $query = "SELECT id, nome, email, senha FROM usuarios";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute();
    # $database->disconnect();
    return $stateHandler;
    
}

sub getById {
    my ($self, $id_passed) = @_;
    my $query = "SELECT id, nome, email, senha FROM usuarios WHERE id=?";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($id_passed);
    # $database->disconnect();
    return $stateHandler;
}

sub updateById {
    my ($self, $id_passed) = @_;
    my $query = "UPDATE usuarios SET nome=?, email=?, senha=? WHERE id=?";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($self->{nome}, $self->{matricula}, $self->{telefone}, $self->{id});
    $database->disconnect();
    my $rowsAffecteds = $stateHandler->rows;    
    return $rowsAffecteds;
    
}

sub deleteById {
    my ($self, $id_passed) = @_;
    my $query = "DELETE FROM usuarios WHERE id=?";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($id_passed);
    $database->disconnect();
    my $rowsAffecteds = $stateHandler->rows;    
    return $rowsAffecteds;
   
}


1;