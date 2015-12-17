controllers = angular.module('controllers')
controllers.controller("ProductsController", [ '$scope', '$routeParams', '$location', 'SharedData', 
  ($scope,$routeParams,$location, SharedData)->
    $scope.search = (keywords)-> $location.path("/").search('keywords',keywords)
    $scope.toggleFull = (product)-> product.fullVisible = !product.fullVisible
    $scope.addToCart = (product)->
      console.log("adding #{product.quantity} x #{product.name} to cart...\nbefore cart:")
      console.log($scope.shoppingList)
      index = $scope.shoppingList.findIndex((element, index, array)-> element.product.id == product.id)
      console.log("index: #{index}")
      if index == -1
        $scope.shoppingList.push(product: product, quantity: product.quantity)
      else
        $scope.shoppingList[index].quantity += product.quantity
      console.log("current cart: ")
      console.log($scope.shoppingList)
      cartCalculate()
    $scope.clearCart = ()->
      SharedData.ClearCart()
      $scope.shoppingList = SharedData.ShoppingList
      console.log("cart cleared")
      cartCalculate()
    $scope.showCart = ()-> $location.path("/cart")
    $scope.logCart = ()->
      console.log("SharedData.ShoppingList; $scope.shoppingList")
      console.log(SharedData.ShoppingList)
      console.log($scope.shoppingList)
    
    cartCalculate = ()->
      $scope.cartSum = [0].concat($scope.shoppingList).reduce( (sum,record)-> sum + record.product.price * record.quantity )
      $scope.cartCount = [0].concat($scope.shoppingList).reduce( (sum,record)-> sum + record.quantity )
    
    $scope.keywords = $routeParams.keywords
    #Product = $resource('/products/:productId', { productId: "@id", format: 'json' })
    #$scope.products = Product.query()
    $scope.products = SharedData.ProductsList
    $scope.shoppingList = SharedData.ShoppingList
    cartCalculate()
])