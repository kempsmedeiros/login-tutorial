#!/usr/bin/perl

use CGI;

my $cgi = CGI->new;

print $cgi->header();


print <<HTML 
<!DOCTYPE html>
    <html lang="en" ng-app="appLogin">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap\@4.6.1/dist/css/bootstrap.min.css"
            integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/ngstorage\@0.3.11/ngStorage.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular-route.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular-cookies.js"></script>
        <style>
            .row {
                height: 100vh;
            }

            .card-header {
                width: 100%;
                margin 0 auto;
            }

            h3 {
                width: 100%;
            }
        </style>
        <script>
            angular.module('appLogin', ['ngCookies'])
                .controller('appLoginCtrl', ['\$cookies', '\$scope', function (\$cookies, \$scope) {
                    \$scope.usuarios = [{
                            nome: "Kemps",
                            email: "kempsmm\@gmail.com",
                            senha: "1234"
                        },
                        {
                            nome: "Calleri",
                            email: "calleri\@gmail.com",
                            senha: "456"
                        },
                        {
                            nome: "Rigoni",
                            email: "rigoni\@gmail.com",
                            senha: "789"
                        }
                    ];
                    \$scope.form = {
                        email: '',
                        password: ''
                    };\
                    \$scope.login = function (passwordPassed) {
                        let password = passwordPassed;
                        let passwordVerify = \$scope.usuarios.filter(function (usuario) {
                            return usuario.senha == password;
                        });
                        if (passwordVerify.length > 0 && passwordVerify[0].email == \$scope.form.email) {
                            \$cookies.put('usuario', 'logado');
                            window.location.href = "views/list.pl";
                        }
                    };
                }]);
        </script>
    </head>

    <body ng-controller="appLoginCtrl">
        <!--color green: #63FF75-->
        <script src="https://cdn.jsdelivr.net/npm/jquery\@3.5.1/dist/jquery.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap\@4.6.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous">
        </script>
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="card" style="width: 18rem;">
                    <div class="card-header">
                        <h3>
                            Login
                        </h3>
                    </div>
                    <div class="card-body">
                        <form>
                            <div class="form-group">
                                <label for="email">Email address</label>
                                <input type="email" class="form-control" id="email" ng-model="form.email">

                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" ng-model="form.password">
                            </div>
                            <div class="form-group form-check">
                            </div>
                        </form>
                        <a class="btn btn-primary" ng-click="login(form.password)">Entrar</a>
                    </div>
                </div>
            </div>
        </div>

    </body>

    </html>
HTML