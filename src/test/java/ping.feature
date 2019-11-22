@ignore
Feature: A simple health check endpoint to confirm whether the API is up and running

  Background:
    * url bookingURL

  Scenario: Ping to api
    Given path 'ping'
    When method get
    Then status 201