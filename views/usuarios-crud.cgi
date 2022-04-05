#!/usr/bin/perl

use CGI;

my $cgi = CGI->new;

print $cgi->header();


print <<HTML 
    <!DOCTYPE html>
    <html lang="en" ng-app="appNewUser">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>List</title>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap\@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .row {
                height: 100vh;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/ngstorage\@0.3.11/ngStorage.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular-route.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular-cookies.js"></script>
        
        <script>
           angular.module('appNewUser', ['ngCookies'])
                .controller('appNewUserCtrl', ['\$cookies', '\$scope', '\$http', function (\$cookies, \$scope, \$http) {
                    \$scope.title = "Cadastrar Usuário";
                    \$scope.formUsuario = {
                        nome: "",
                        email: "",
                        senha: ""
                    }
                    \$scope.cadastrarUsuario = function () {                    
                        \$http.get('../routes/UsuarioRoute.cgi?function=create&nome=' + \$scope.formUsuario.nome + '&email=' + \$scope.formUsuario.email + '&senha=' + \$scope.formUsuario.senha)
                        .then(function(res) {
                            console.log(res);
                        window.location.href = "../index.cgi";
                        });
                    
                    };
                }]);
        </script>
    </head>

    <body ng-controller="appNewUserCtrl">
        <div class="container justify-content-center align-items-center">
            <div class="row justify-content-center align-items-center">
                <form>
                <h1>{{title}}</h1>
                    <div class="mb-3">
                        <label for="nome" class="form-label">Nome</label>
                        <input type="nome" class="form-control" id="nome" ng-model="formUsuario.nome">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" ng-model="formUsuario.email">
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" ng-model="formUsuario.senha">
                    </div>
                    <a class="btn btn-primary" ng-click="cadastrarUsuario()">Cadastrar</a>
                    <a class="btn btn-danger" href="../index.cgi">Cancelar</a>
                </form>
            </div>
        </div>
    </body>

    </html>
HTML
