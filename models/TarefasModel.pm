package TarefasModel;

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
        tarefa => shift,
        idUsuario => shift,

    };
    bless $self, $class;
    return $self;

}

sub create {
    my ($self) = @_;
    my $query = "INSERT INTO tarefas VALUES(NULL, ?, ?)";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($self->{tarefa}, $self->{idUsuario});
    # $database->disconnect();
    my $rowsAffecteds = $stateHandler->rows;    
    return $rowsAffecteds;
  
}

sub getAll {
    my ($self, $id_passed) = @_;
    my $query = "SELECT id, tarefa, idUsuario FROM tarefas WHERE idUsuario=?";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($id_passed);
    # $database->disconnect();
    return $stateHandler;
    
}

sub getById {
    my ($self, $id_passed) = @_;
    my $query = "SELECT id, tarefa, idUsuario FROM tarefas WHERE id=?";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($id_passed);
    # $database->disconnect();
    return $stateHandler;
}

sub updateById {
    my ($self, $id_passed) = @_;
    my $query = "UPDATE tarefas SET tarefa=? WHERE id=?";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($self->{tarefa}, $id_passed);
    $database->disconnect();
    my $rowsAffecteds = $stateHandler->rows;    
    return $rowsAffecteds;
    # return $self->{tarefa};
    
}

sub deleteById {
    my ($self, $id_passed) = @_;
    my $query = "DELETE FROM tarefas WHERE id=?";
    my $stateHandler = $database->prepare($query);
    $stateHandler->execute($id_passed);
    $database->disconnect();
    my $rowsAffecteds = $stateHandler->rows;    
    return $rowsAffecteds;
   
}


1;