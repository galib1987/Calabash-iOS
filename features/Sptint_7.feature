Feature: Booking a flight



  Scenario: user is able to book a flight by selecting an account.

    Given: User is Logged in With a valid UserId And Password
    When:  User Try to book a flight by selecting an Account associated with user
    Then:  User should be able to book a flight


  Scenario: user is able to reset the form after filling it up.

    Given:  User is Logged in With a valid UserId And Password
    And  :  User has selected an account associated with user
    And :   User fill out the form for booking a flight with necessary information
    When:   User try to reset the from by clicking Reset button
    Then :  User should be able to reset the form


  Scenario: user is able Copy information from past flights by selecting an account.

    Given:  User is Logged in With a valid UserId And Password
    And  :  User has selected an account associated with user
    When :  User Try to copy past flight from booking screen
    Then :  User should be able to copy from past flight and ake a new reservation.



  #### Manual steps ##################################################



    Given I am on the Welcome Screen
    Given I enter "user_email_id" into the "EMAIL" text field
    And   I enter "user_password" into the "PASSWORD" text field
    When  I press "LOGIN"
    When  I press "menu_button"
    When  I press "BOOK"
    When  I press "Copy From Past Flight"
    Then  I should see "Your PAST FLIGHTS"
    Then  I should see "list of past flights"

  #    When I press "Cancel"
  #    Then I should see "back_arrow_icon"
  #    Then I should see "BOOK A FLIGHT"
    When I press "AIRCRAFT"
    Then I should see "Done"
    Then I should see "next_icon"
    Then I should see "previous_icon"
    Then I should see "list_of_flights_name - number_of_hours_left hrs left"
    Then I should see "Request a Different Aircraft"
    Then I press "check_box"


    When I press "From"
    Then I should see "Cancel"
    Then I should see "DEPARTING FROM"
    Then I should see "search_icon"
    Then I should see "Recent Airports"
    Then I should see "see_recent_Airport_list"
    Then I enter "Depart_city_name" into the "search_field" field
    Then I should see "close_icon"
    Then I should see "list_of_airports"
    When I press "Cancel"
    Then I should see "Back_arrow_icon"
    Then I should see "BOOK A FLIGHT"


    When I should see "To"
    Then I should see "Cancel"
    Then I should see "ARRIVING TO"
    Then I should see "search_icon"
    Then I should see "Recent Airports"
    Then I should see "see_recent_Airport_list"
    Then I enter "arrive_city_name" into the "search_field" field
    Then I should see "close_icon"
    Then I should see "list_of_airports"
    When I press "Cancel"
    Then I should see "Back_arrow_icon"
    Then I should see "BOOK A FLIGHT"

    When I should see "DATE"
    Then I should see "Done"
    Then I should see "calendar"
    Then I should see "not_available_icon"
    Then I should see "Not Available"
    Then I should see "Help_icon"
    Then I should see "peak_period_icon"
    Then I should see "Peak Period"
    Then I should see "help_icon"
    When I press "Done"
    Then I should see "back_arrow_icon"
    Then I should see "BOOK A FLIGHT"

    When I should see "DEPART AT"
    Then I should see "forward_icon"
    Then I should see "backward_icon"
    Then I should see "Clear"
    Then I should see "Done"
    Then I should see "list_of_available_depart_time_with_zone"
    When I press "Done"
    Then I should see "ARRIVE BY"

    When I press "ARRIVE BY"
    Then I should see "forward_icon"
    Then I should see "backward_icon"
    Then I should see "Clear"
    Then I should see "Done"
    Then I should see "list_of_arrival_time"
    When I should see "Done"
    Then I should see "number_of_passenger Passengers"
    Then I should see "Plus_icon"
    Then I should see "Minus_icon"
    When I should see "Plus_icon"
    Then I should see "Number_of_passengers+1 Passengers"
    When I should see "minus_icon"
    Then I should see "number_of_passengers-1 Passengers"
    Then I should see "RESERVATION NOTES"
    Then I enter "Some text into reservation text field" into the "RESERVATION NOTES" field


    When I press "RESET FORM"
    Then I should see "close-icon"
    Then I should see "Are you sure you want to reset this form?"
    Then I should see "NO, GO BACK"
    Then I should see "YES, RESET"
    When I press "NO, GO BACK"
    Then I should see "RESET FORM"
    Then I should see "NEXT"

    When I press "NEXT"
    Then I should see "REVIEW & SUBMIT"
    Then I should see "Big Skies LLC: Cessna Citation X"
    Then I should see "Reservation Hours Used: number_of_hours hours"
    Then I should see "Projected Hours Left: number_of_hours_left hours"
    Then I should see "FLIGHT REQUEST #1"
    Then I should see "FROM"
    Then I should see "departure_city or Airport"
    Then I should see "TO"
    Then I should see "arrival_city or Airport"
    Then I should see "DEPART"
    Then I should see "depart_date_and_time"
    Then I should see "ARRIVE"
    Then I should see "arrive_date_and_time"
    Then I should see "NO. OF PASSENGERS"
    Then I should see "number_of_passengers"
    Then I should see "AIRCRAFT"
    Then I should see "*Change Requested"
    Then I should see "RESERVATION NOTES"
    Then I should see "reservation_text"
    Then I should see "EDIT FLIGHT DETAILS"
    Then I should see "FLIGHT REQUEST #2"
    Then I should see "FROM"
    Then I should see "departure_city or Airport"
    Then I should see "TO"
    Then I should see "arrival_city or Airport"
    Then I should see "DEPART"
    Then I should see "depart_date_and_time"
    Then I should see "ARRIVE"
    Then I should see "arrive_date_and_time"
    Then I should see "NO. OF PASSENGERS"
    Then I should see "number_of_passengers"
    Then I should see "AIRCRAFT"
    Then I should see "RESERVATION NOTES"
    Then I should see "reservation_text"
    Then I should see "EDIT FLIGHT DETAILS"
    Then I should see "Add an Onward Flight"
    Then I should see "plus_icon"
