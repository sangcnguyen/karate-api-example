Feature: Get all booking list

  Background:
    * url bookingURL

  Scenario: Get all booking list
    Given path 'booking'
    When method get
    Then status 200
    And match each response == { bookingid: '#number'}