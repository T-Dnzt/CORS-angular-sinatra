var app = angular.module('myApp', []);

app.config(function($httpProvider) {
    //Enable cross domain calls
	$httpProvider.defaults.useXDomain = true;

    //Remove the header containing XMLHttpRequest used to identify ajax call 
    //that would prevent CORS from working
    delete $httpProvider.defaults.headers.common['X-Requested-With'];
});

app.controller('MainCtrl', function($scope, $http) {

	$scope.get = function() {
		$http.get("http://localhost:4567/movie").success(function(result) {
		    console.log("Success", result);
		    $scope.resultGet = result;
		}).error(function() {
		    console.log("error");
		});
	};

	$scope.post = function(value) {
		$http.post("http://localhost:4567/movie", { 'movie': value }).success(function(result) {
		    console.log(result);
		    $scope.resultPost = result;
		}).error(function() {
		    console.log("error");
		});
	};

	$scope.put = function(value) {
		$http.put("http://localhost:4567/movie", { 'movie': value }).success(function(result) {
		    console.log(result);
		    $scope.resultPut = result;
		}).error(function() {
		    console.log("error");
		});
	};

	$scope.delete = function(value) {
		$http.delete("http://localhost:4567/movie", { 'movie': value }).success(function(result) {
		    console.log(result);
		    $scope.resultDelete = result;
		}).error(function() {
		    console.log("error");
		});
	};

});