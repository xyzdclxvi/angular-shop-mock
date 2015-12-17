controllers = angular.module('controllers',[])
controllers.controller("ProductsController", [ '$scope', '$routeParams', '$location', 'SharedData', 
  ($scope,$routeParams,$location, SharedData)->
    $scope.search = (keywords)-> $location.path("/").search('keywords',keywords)
    $scope.toggleFull = (product)-> product.fullVisible = !product.fullVisible
    $scope.addToCart = (product)->
      console.log("adding #{product.quantity} x #{product.name} to cart... current cart:")
      console.log($scope.shoppingList)
      $scope.shoppingList.push(product: product, quantity: product.quantity)
      console.log("after: ")
      console.log($scope.shoppingList)
      cartSum()
    $scope.clearCart = ()->
      $scope.shoppingList = []
      SharedData.ClearCart()
      cartSum()
      console.log("cart cleared")
    $scope.showCart = ()-> console.log($scope.shoppingList)
    
    cartSum = ()->
      $scope.cartSum = [0].concat($scope.shoppingList).reduce( (sum,record)-> sum + record.product.price * record.quantity )
    
    $scope.keywords = $routeParams.keywords
    #Product = $resource('/products/:productId', { productId: "@id", format: 'json' })
    #$scope.products = Product.query()
    $scope.products = SharedData.ProductsList
    $scope.shoppingList = SharedData.ShoppingList
    cartSum()
])