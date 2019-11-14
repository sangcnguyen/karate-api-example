Feature: Update a booking

  Background:
    * url bookingURL
    * def auth = call read('classpath:booking/auth.feature')
    * def createBooking = call read('classpath:booking/create-booking.feature')

  Scenario:  Update booking
    Given path 'booking' +'/' + createBooking.bookingId
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And cookie token = auth.basicToken
    And request
    """
    {
        "firstname" : "Sang",
        "lastname" : "Nguyen",
        "totalprice" : 2000,
        "depositpaid" : false,
        "bookingdates" : {
            "checkin" : "2019-01-01",
            "checkout" : "2020-01-01"
        }
    }
    """
    When method put
    * print response
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
      },
      "additionalneeds": "#ignore"
    }
    """
    And status 200