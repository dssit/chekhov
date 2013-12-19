Chekhov.controller "TemplatesActiveIndexCtrl", @TemplatesActiveIndexCtrl = ($scope, $modal, $location, Checklists, User) ->
  $scope.loaded = false
  $scope.error = null
  $scope.checklists = Checklists.query {},
    (data) ->
      # Success
      $scope.loaded = true
      $scope.user = User
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"

  console.debug 'TemplatesActiveIndexCtrl', 'Initializing...'

  $('ul.nav li').removeClass 'active'
  $('ul.nav li#checklists_active').addClass 'active'
  
  $scope.openChecklist = (checklist_id) ->
    $location.path("/checklists/#{checklist_id}")
    
  $scope.deleteChecklist = (checklist) ->
    modalInstance = $modal.open
      templateUrl: "/assets/partials/checklist_delete.html"
      controller: ChecklistDeleteCtrl

    modalInstance.result.then () ->
      Checklists.delete {id: checklist.id},
        (data) ->
          # Success
          index = $scope.checklists.indexOf(checklist)
          $scope.checklists.splice(index,1)
      , (data) ->
          # Error
          $scope.error = "Error deleting checklist '#{checklist.name}'"

  $scope.clearError = ->
    $scope.error = null
