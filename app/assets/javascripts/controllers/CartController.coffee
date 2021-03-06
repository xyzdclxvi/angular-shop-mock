controllers = angular.module('controllers')
controllers.controller("CartController", [ '$scope', '$location', 'SharedData', 
  ($scope,$location, SharedData)->
    $scope.sendOrder = ()->
      #does nothing - its only a mock
      $scope.clearCart()
      $scope.orderSent = true
      #$location.path("/")
    $scope.clearCart = ()->
      SharedData.ClearCart()
      $scope.shoppingList = SharedData.ShoppingList
      console.log("cart cleared")
      cartCalculate()
      $scope.$apply()
    $scope.goBack = ()-> $location.path("/")
    $scope.logCart = ()->
      console.log("SharedData.ShoppingList; $scope.shoppingList")
      console.log(SharedData.ShoppingList)
      console.log($scope.shoppingList)
    $scope.logOrder = ()->
      console.log($scope.orderForm)
      
    $scope.toggleOrder = ()->
      $scope.orderVisible = !$scope.orderVisible
      console.log("toggled to: #{$scope.orderVisible}")
      
    $scope.saveRecord = (record)->
      console.log("saving")
      console.log(record)
      console.log($scope.shoppingList.indexOf(record))
      if record.product.quantity == undefined || record.product.quantity == null
        $scope.shoppingList.splice($scope.shoppingList.indexOf(record),1)
      else
        record.quantity = record.product.quantity
      cartCalculate()
    $scope.revertRecord = (record)->
      record.product.quantity = record.quantity
      cartCalculate()
    
    cartCalculate = ()->
      $scope.cartSum = [0].concat($scope.shoppingList).reduce( (sum,record)-> sum + record.product.price * record.quantity )
      $scope.cartCount = [0].concat($scope.shoppingList).reduce( (sum,record)-> sum + record.quantity )
      $scope.orderVisible = false if $scope.cartCount == 0
      
    $scope.$on('formLocator', (event)->
      $scope.orderForm = event.targetScope.orderForm;
    )  
    
    $scope.shoppingList = SharedData.ShoppingList
    $scope.orderVisible = false
    $scope.orderSent = false
    
    cartCalculate()
])