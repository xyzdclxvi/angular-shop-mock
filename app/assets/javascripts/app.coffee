shopthing = angular.module('shopthing', [
  'templates',
  'ngRoute',
  'ngResource',
  'ngStorage',
  'ui.bootstrap',
  'controllers',
])

shopthing.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'ProductsController'
      ).when('/cart',
        templateUrl: "cart.html"
        controller: 'CartController'
      )
])

shopthing.directive( 'ngConfirmClick', [() ->
  restrict: 'A'
  replace: false
  link: ($scope, $element, $attr) ->
    msg = $attr.ngConfirmClick || "Are you sure?"
    clickAction = $attr.confirmedClickAction;
    $element.bind('click',(event) ->
      if window.confirm(msg)
        $scope.$eval(clickAction)
)])

shopthing.factory('SharedData', [ '$resource', '$window', '$localStorage',
  ($resource,$window,$localStorage)->
    Product = $resource('/products/:productId', { productId: "@id", format: 'json' })
    products = Product.query()
    storager = $localStorage.$default(shoppingList: [])
    clearCart = ()-> 
      #console.log("storager before + after")
      #console.log(storager)
      storager.shoppingList.length = 0
      #console.log(storager)
      #this only makes a new array -> #delete $localStorage.$reset(shoppingList: [])
    { ProductsList: products, ShoppingList: storager.shoppingList, ClearCart: clearCart }
])

controllers = angular.module('controllers',[])
