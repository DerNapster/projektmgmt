angular
  .module('projektManagement', ['ngMaterial', 'ui.router', 'nodes'])
  .config(function($stateProvider, $urlRouterProvider, $mdThemingProvider, $mdIconProvider){
      $mdIconProvider
        .defaultFontSet( 'fontawesome' )
        .iconSet('action', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-action.svg', 24)
        .iconSet('alert', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-alert.svg', 24)
        .iconSet('av', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-av.svg', 24)
        .iconSet('communication', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-communication.svg', 24)
        .iconSet('content', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-content.svg', 24)
        .iconSet('device', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-device.svg', 24)
        .iconSet('editor', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-editor.svg', 24)
        .iconSet('file', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-file.svg', 24)
        .iconSet('hardware', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-hardware.svg', 24)
        .iconSet('icons', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-icons.svg', 24)
        .iconSet('image', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-image.svg', 24)
        .iconSet('maps', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-maps.svg', 24)
        .iconSet('navigation', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-navigation.svg', 24)
        .iconSet('notification', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-notification.svg', 24)
        .iconSet('social', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-social.svg', 24)
        .iconSet('toggle', '/assets/material-design-icons/sprites/svg-sprite/svg-sprite-toggle.svg', 24);

      $mdThemingProvider.theme('default')
        .primaryPalette('deep-orange')
        .accentPalette('grey');

      $stateProvider
        .state('home', {
          url: '/home',
          templateUrl: '/assets/nodes/_home.html',
          controller: '/assets/nodes/nodeController'
        });

      $urlRouterProvider.otherwise('home');

});
