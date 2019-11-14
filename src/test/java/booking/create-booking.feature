Feature: Create a new booking

  Background:
    * url bookingURL

  Scenario:  Create new booking
    Given path 'booking'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
    """
    {
        "firstname" : "Jim",
        "lastname" : "Brown",
        "totalprice" : 111,
        "depositpaid" : true,
        "bookingdates" : {
            "checkin" : "2018-01-01",
            "checkout" : "2019-01-01"
        },
        "additionalneeds" : "Breakfast"
    }
    """
    When method post
    Then match response.booking ==
    """
    {
      "firstname": "#string",
      "lastname": "#string",
      "totalprice": '#number',
      "depositpaid": '#boolean',
      "bookingdates": {
          "checkin": "#string",
          "checkout": "#string"
      },
      "additionalneeds": "#string"
    }
    """
    * def bookingId = response.bookingid