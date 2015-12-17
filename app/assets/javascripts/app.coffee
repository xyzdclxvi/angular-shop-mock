shopthing = angular.module('shopthing', [
  'templates',
  'ngRoute',
  'controllers',
])

shopthing.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'ProductsController'
      )
])

controllers = angular.module('controllers',[])
