Chekhov.controller "TemplatesActiveIndexCtrl", @TemplatesActiveIndexCtrl = ($scope, $routeParams, $location, Checklists) ->
  $scope.loaded = false
  $scope.checklists = Checklists.query ->
    $scope.loaded = true
  
  console.debug 'TemplatesActiveIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_active').addClass 'active'
  
  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")