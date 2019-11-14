Feature: Creates a new auth token to use for access to the PUT and DELETE /booking

  Background:
    * url bookingURL

  Scenario: Create token
    Given path 'auth'
    And request {"username" : "admin","password":"password123"}
    When method post
    Then status 200
    * def basicToken = response.token