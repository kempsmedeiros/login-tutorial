package TarefasRule;

use strict;
use warnings;
use JSON;
use Encode qw(decode encode);
use lib "../models";
use TarefasModel;

my $json = JSON->new->allow_nonref;


sub new {
   my $class = shift;
   my $self = {
        # id => shift,
        tarefa => shift,
        idUsuario => shift,

    };
    bless $self, $class;
    return $self;

}


sub create {
    my ($self) = @_;
    my $tarefaModel = TarefasModel->new($self->{tarefa}, $self->{idUsuario});
    my $rowsAffecteds = $tarefaModel->create();
    return $rowsAffecteds;
   
    
}

sub getAll {
    my ($self, $id_passed) = @_;
    my $tarefaModel = TarefasModel->new($self->{tarefa}, $self->{idUsuario});
    my $stateHandler = $tarefaModel->getAll($id_passed);
    my @listOfData;
    while (my @data = $stateHandler->fetchrow_array()) {
    my $id = $data[0];
    my $tarefa = $data[1];
    my $idUsuario = $data[2];
    my $row = {
        id => $id,
        tarefa => $tarefa,
        idUsuario => $idUsuario,
    };
    push @listOfData, $row;   
    }
    my $jsonList = $json->encode(\@listOfData);
    return $jsonList;
}   

sub getById {
    my ($self, $id_passed) = @_;
    my $usuarioModel = UsuarioModel->new($self->{id}, $self->{nome}, $self->{email}, $self->{senha});
    my $stateHandler = $usuarioModel->getById($id_passed);
    my @listOfData;
    while (my @data = $stateHandler->fetchrow_array()) {
    my $id = $data[0];
    my $nome = $data[1];
    my $email = $data[2];
    my $senha = $data[3];
    my $row = {
        id => $id,
        nome => $nome,
        email => $email,
        senha => $senha,
    };
    push @listOfData, $row;   
    }
    my $jsonList = $json->encode(\@listOfData);
    return $jsonList;
} 

sub updateById {
    my ($self, $id_passed) = @_;
    my $alunoModel = UsuarioModel->new($self->{id}, $self->{nome}, $self->{email}, $self->{senha});
    my $rowsAffecteds = $alunoModel->updateById();
    return $rowsAffecteds;
}

sub deleteById {
    my ($self, $id_passed) = @_;
    my $tarefaModel = TarefasModel->new();
    my $rowsAffecteds = $tarefaModel->deleteById($id_passed);
    return $rowsAffecteds;
}


1;