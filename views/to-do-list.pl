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
        <title>To Do List</title>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap\@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/ngstorage\@0.3.11/ngStorage.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular-route.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular-cookies.js"></script>
        <style>
        .col-10 {
            margin: auto;
        }

        </style>
        <script>
           angular.module('appList', ['ngCookies'])
                .controller('appListCtrl', ['\$cookies', '\$scope', '\$http', function (\$cookies, \$scope, \$http) {
                    \$scope.verificarLogin = function () {
                        let usuarioLogado = \$cookies.get('usuario');
                        if (!usuarioLogado) {
                            window.location.href = "../index.pl";
                        } else {
                            \$scope.idUsuarioAtivo = usuarioLogado;
                        }
                    };
                    \$scope.logout = function (){
                      \$cookies.remove('usuario', { path: '/cgi-bin/login-tutorial' });
                       window.location.href = "../index.pl";
                    };
                    \$scope.verificarLogin();

                    \$scope.carregarTasks = function () {
                        \$http.get('../routes/TarefasRoute.cgi?function=getAll&idUsuario=' + \$scope.idUsuarioAtivo)
                            .then(function(res) {
                            //\$scope.usuarios = res.data;
                            \$scope.tarefas = res.data;
                            });
                    };

                    \$scope.carregarTasks();

                    \$scope.title = "My Daily Tasks";
                    \$scope.tarefas = [];
                    \$scope.newTask = "";

                    \$scope.adicionarTask = function () {
                        \$http.get('../routes/TarefasRoute.cgi?function=create&tarefa=' + \$scope.newTask + '&idUsuario=' + \$scope.idUsuarioAtivo)
                        .then(function(res) {
                            console.log(res);
                            \$scope.newTask = "";
                            \$scope.carregarTasks();
                        });
                    };

                    \$scope.deletarTask = function (idTask) {
                        console.log("deletando" + idTask);
                        \$http({
                            method: 'GET',
                            url: '../routes/TarefasRoute.cgi?function=deleteById&deleteId=' + idTask,
                            headers: {
                            'Content-type': 'application/json;charset=utf-8'
                            }
                        })
                        .then(function(response) {
                        console.log(response.data);
                        \$scope.carregarTasks();
                        });
                    };

                    

                }]);
        </script>
    </head>

    <body ng-controller="appListCtrl">
        <div class="container">
            <header class="col-10">
                <h1 class="mt-5">{{title}}</h1>
                <form class="mt-5">

                    
                    <input type="text" id="newTask" placeholder="Cadastre uma nova tarefa..." class="form-control mb-3"
                        ng-model="newTask" />
                    <a class="btn btn-success mb-5" ng-click="adicionarTask()">
                        Adicionar
                    </a>
                </form>
            </header>
            <main class="col-10 mb-3">
                <table class='table'>
                    <tr>
                        <td>Tarefa</td>
                        <!-- <td>Prioridade</td>-->
                        <td>Editar</td>
                        <td>Deletar</td>
                    </tr>
                    <tr ng-repeat="tarefa in tarefas">
                        <td>{{tarefa.tarefa}}</td>
                        <td><a class="btn btn-primary">Edit</a></td>
                        <td><a class="btn btn-danger" ng-click='deletarTask(tarefa.id)'>Delete</a></td>

                        <!--<td><a class='btn btn-primary' href='Views/edit-aluno.pl?editedId={{aluno.id}}'>Edit</a></td>
                        <td><a class='btn btn-danger' ng-click='deletar(aluno.id)'>Delete</a></td>-->
                    </tr>
                </table>
                <a class="btn btn-danger" ng-click="logout()">SAIR</a>
            </main>
        </div>
    </body>

    </html>
HTML
