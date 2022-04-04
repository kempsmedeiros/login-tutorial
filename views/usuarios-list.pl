#!/usr/bin/perl

use CGI;

my $cgi = CGI->new;

print $cgi->header();


print <<HTML 
    <!DOCTYPE html>
    <html lang="en" ng-app="appList">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>List</title>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap\@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/ngstorage\@0.3.11/ngStorage.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular-route.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular-cookies.js"></script>

        <script>
           angular.module('appList', ['ngCookies'])
                .controller('appListCtrl', ['\$cookies', '\$scope', function (\$cookies, \$scope) {
                    \$scope.verificarLogin = function () {
                        let usuarioLogado = \$cookies.get('usuario');
                        if (!usuarioLogado) {
                            window.location.href = "../index.pl";
                        }
                    };
                    \$scope.logout = function (){
                      \$cookies.remove('usuario', { path: '/cgi-bin/login-tutorial' });
                       window.location.href = "../index.pl";
                    };
                    \$scope.verificarLogin();

                    \$scope.title = "My List";
                }]);
        </script>
    </head>

    <body ng-controller="appListCtrl">
        <div class="container">
            <h1>{{title}}</h1>
            <a class="btn btn-danger" ng-click="logout()">SAIR</a>
        </div>
    </body>

    </html>
HTML
