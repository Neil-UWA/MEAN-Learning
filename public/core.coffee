scotchTodo = angular.module 'Todo', []

scotchTodo.controller('mainController', ($scope, $http) ->
  $scope.formData = {}

  $http.get('/api/todos').success(
    (data) ->
      $scope.todos = data
      console.log data
  ).error(
    (data) -> console.log 'error happens' + data
  )

  $scope.createTodo = () ->
    $http.post('/api/todos', $scope.formData).success((data) ->
      $scope.formData = {}
      $scope.todos = data
      console.log(data)
    ).error((data) ->
      console.log('erorr' + data)
    )

  $scope.deleteTodo = (id) ->
    $http.delete('/api/todos/'+id).success((data) ->
      $scope.todos = data
      console.log(data)
    ).error((data)-> console.log('error' + data))
)
