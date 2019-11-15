Feature: Returns a specific booking based upon the booking id provided

  Background:
    * url bookingURL

  Scenario: Get all booking list
    Given path 'booking', '1'
    And header Accept = 'application/json'
    And method get
    Then status 200
    Then match response ==
    """
    {
      "firstname": "#string",
      "lastname": "#string",
      "totalprice": '#number',
      "depositpaid": '#boolean',
      "bookingdates": {
          "checkin": "#string",
          "checkout": "#string"
      }
    }
    """