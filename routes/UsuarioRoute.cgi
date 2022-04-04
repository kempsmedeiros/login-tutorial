#!/usr/bin/perl

use strict;
use warnings;
use Encode qw(decode encode);
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI ':standard';
use lib "../rules";
use JSON;
use UsuarioRule;

my $cgi = CGI->new();
my $json = JSON->new->allow_nonref;


my $function = param('function');
my $id = param('id');
my $nome = param('nome');
my $email = param('email');
my $senha = param('senha');
my $deletedId = param('deleteId');
my $editedId = param('editedId');

sub createUsuarioWithData {
    my $newUsuario = UsuarioRule->new($nome, $email, $senha);
    return $newUsuario
}


my $returnSuccess = {
    statuscode => 200,
    message => "OK - Usuario criado com sucesso"
};

my $returnFailed = {
    statuscode => 400,
    message => "Bad Request"
};

my $returnUpdateSuccess = {
    statuscode => 200,
    message => "OK - Usuario atualizado com sucesso"
};

my $returnDeleteSuccess = {
    statuscode => 200,
    message => "OK - Usuario deletado com sucesso"
};


sub convertToJson {
    my ($return) = @_;
    my $returnJsonText = encode_json $return;
    my $jsonFinal = $json->encode($returnJsonText);
    return $jsonFinal;
}

my $returnSuccessJson = convertToJson($returnSuccess);
my $returnFailedJson = convertToJson($returnFailed);
my $returnUpdateSucessJson = convertToJson($returnUpdateSuccess);
my $returnDeleteSucessJson = convertToJson($returnDeleteSuccess);

sub printHeader {
    my ($rowsAffecteds, $message) = @_;
    if ($rowsAffecteds > 0) {
    print $cgi->header(
        -type   => 'application/json',
        -status => 200,
    );
    print $message;
    
    } else {
        print $cgi->header(
        -type   => 'application/json',
        -status => 400,
    );
    print $returnFailedJson;
    }
};


if( $function eq "create" ) {
    my $newUsuario = createUsuarioWithData();
    my $rowsAffecteds = $newUsuario->create();
    printHeader($rowsAffecteds, $returnSuccessJson);
      
};

# if( $function eq "updateById" ) {
#     my $newAluno = createAlunoWithData();
#     my $rowsAffecteds = $newAluno->updateById($id);
#     printHeader($rowsAffecteds, $returnUpdateSucessJson);
    
# };

# if ( $function eq "deleteById") {
#     my $newAluno = UsuarioRule->new();
#     my $rowsAffecteds = $newAluno->deleteById($deletedId);
#     printHeader($rowsAffecteds, $returnDeleteSucessJson);
    
# };

if ( $function eq "getAll") {
    my $newUsuario = UsuarioRule->new();
    my $result = $newUsuario->getAll();
    my $cgi = CGI->new;
    print $cgi->header(
        -type   => 'application/json',
        -status => 200,
    );
    print $result;
    
};

# if ( $function eq "getById") {
#     my $newAluno = createAlunoWithData();
#     my $result = $newAluno->getById($editedId);
#     my $cgi = CGI->new;
#     print $cgi->header(
#         -type   => 'application/json',
#         -status => 200,
#     );
#     print $result;

# };
