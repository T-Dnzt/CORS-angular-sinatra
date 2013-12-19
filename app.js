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

	//a scope function to load the data..in this case all the users in the database.
	$scope.loadData = function () {
		$http.get('http://localhost:4567/users').success(function(data) {
		 $scope.items = data;
		});
	};

});
