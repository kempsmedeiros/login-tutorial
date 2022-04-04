package UsuarioRule;

use strict;
use warnings;
use JSON;
use Encode qw(decode encode);
use lib "../models";
use UsuarioModel;

my $json = JSON->new->allow_nonref;


sub new {
   my $class = shift;
   my $self = {
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
    my $usuarioModel = UsuarioModel->new($self->{nome}, $self->{email}, $self->{senha});
    my $rowsAffecteds = $usuarioModel->create();
    return $rowsAffecteds;
   
    
}

sub getAll {
    my ($self) = @_;
    my $usuarioModel = UsuarioModel->new();
    my $stateHandler = $usuarioModel->getAll();
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
    };
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
    my $alunoModel = UsuarioModel->new();
    my $rowsAffecteds = $alunoModel->deleteById($id_passed);
    return $rowsAffecteds;
}


1;