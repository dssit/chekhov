Chekhov.controller "TemplateEditCtrl", @TemplateEditCtrl = ($scope, $routeParams, Templates, $location) ->
  $scope.loaded = false
  $scope.template = {}
  $scope.template.entries_attributes = []
  $scope.newContent = null
  $scope.position = 1
  $scope.error = null

  console.debug 'TemplateEditCtrl', 'Initializing...'
  
  $scope.addToEntries = () ->
    if $scope.newContent
      $scope.template.entries_attributes.push {content: $scope.newContent, position: $scope.position}
      $scope.position++
    $scope.newContent = ""

  $scope.removeFromEntries = (entry) ->
    entry._destroy = true
  
  $scope.save = () ->
    if $scope.template.entries_attributes.length and $scope.template.name
      Templates.update $scope.template,
        (data) ->
          # Success
          $location.path("/")
      , (data) ->
          # Error
          $scope.error = "Could not save changes"

  $scope.clearError = ->
    $scope.error = null
  
  Templates.get {id: $routeParams.id},
    (data) ->
      # Success
      $scope.template = data
      $scope.template.entries_attributes = $scope.template.entries
      delete $scope.template.entries
      $scope.position = _.max(_.pluck($scope.template.entries_attributes, "position")) + 1
      $scope.loaded = true
  , (data) ->
      # Error
      $scope.error = "Error retrieving information from server"
