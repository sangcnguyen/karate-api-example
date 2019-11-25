@full-test
Feature: Update a booking

  Background:
    * url bookingURL
    * def auth = call read('classpath:auth.feature')
    * def createBooking = call read('classpath:booking/create-booking.feature')
    # import RandomUtil class
    * def RandomUtil = Java.type('com.github.sn.RandomUtil')
    * def firstName = RandomUtil.firstName()
    * def lastName = RandomUtil.lastName()
    * def bool = RandomUtil.bool()
    * def string = RandomUtil.string()
    * def number = RandomUtil.number()
    * def date = RandomUtil.date()

  @update-booking
  Scenario:  Update booking
    Given path 'booking' , createBooking.bookingId
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And cookie token = auth.basicToken
    And request
    """
    {
        "firstname" : "#(firstName)",
        "lastname" : "#(lastName)",
        "totalprice" : #(number),
        "depositpaid" : #(bool),
        "bookingdates" : {
            "checkin" : "#(date)",
            "checkout" : "#(date)"
        },
        "additionalneeds" : "#(string)"
    }
    """
    When method put
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
      "additionalneeds": "#string"
    }
    """
    And status 200