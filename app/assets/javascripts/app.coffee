shopthing = angular.module('shopthing', [
  'templates',
  'ngRoute',
  'ngResource',
  'ngStorage',
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

shopthing.factory('SharedData', [ '$resource', '$window', '$localStorage',
  ($resource,$window,$localStorage)->
    Product = $resource('/products/:productId', { productId: "@id", format: 'json' })
    products = Product.query()
    storager = $localStorage.$default(shoppingList: [])
    clearCart = ()-> delete $localStorage.$reset(shoppingList: [])
    { ProductsList: products, ShoppingList: storager.shoppingList, ClearCart: clearCart }
])

controllers = angular.module('controllers',[])
