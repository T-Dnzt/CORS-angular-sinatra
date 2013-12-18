var app = angular.module('MyApp', []);

app.config(function($httpProvider) {
    //Enable cross domain calls
	$httpProvider.defaults.useXDomain = true;

    //Remove the header containing XMLHttpRequest used to identify ajax call 
    //that would prevent CORS from working
    delete $httpProvider.defaults.headers.common['X-Requested-With'];
});

//add a controller to it
app.controller('MyCtrl', function($scope, $http) {

   //a scope function to load the data.
   $scope.loadData = function () {
      $http.get('http://localhost:4567/users').success(function(data) {
         $scope.items = data;
      });
   };
   
   
	$scope.get = function() {
		$http.get("http://localhost:4567/users").success(function(result) {
			console.log("Success", result);
            $scope.resultGet = result;
        }).error(function() {
			console.log("error");
		});
	};   

});
