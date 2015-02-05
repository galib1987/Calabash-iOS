Feature: Welcome Screen, Share Flight Details and Add to Calendar

  ############################################################
  #                      Welcome Screen                      #
  ############################################################

  Scenario: iPhone - Welcome Screen
    #Given I am on the Account Screen
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "NETJETS"
    And I wait for "Skip" to appear
    And I should see "flight_around_image"
    And I should see "WELCOME TO NETJETS"
    And I should see "line_image"
    And I should see "Let us show you around."
    When I swipe left
    Then I should see "Skip"
    And I should see "flights_list_image"
    And I should see "FLIGHTS"
    And I should see "line_image"
    And I should see "See all your upcoming flights in one place."
    When I swipe left
    Then I should see "Skip"
    And I should see "contact_owner_service_image"
    And I should see "YOUR OWNER SERVICES TEAM"
    And I should see "line_image"
    And I should see "Your team is now just a tap away-24 hours a day, seven days a week."
    When I swipe left
    Then I should see "Skip"
    And I should see "quick_booking_image"
    And I should see "QUICK BOOKING"
    And I should see "line_image"
    And I should see "You can submit a flight request in just a few taps. Then our Owner Services team will call you to iron out the details."
    When I swipe left
    Then I should see "Skip"
    And I should see "notification_image"
    And I should see "NOTIFICATIONS"
    And I should see "line_image"
    And I should see "Allow us to notify you of important flight updates, without answering a phone call."
    And I should see "NO THANKS"
    And I should see "ALLOW"


  ############################################################
  #                    Share Flight Details                  #
  ############################################################

  Scenario: iPhone - Share Flight Details
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "NETJETS"
    And I wait for "Skip" to appear
    When I press "Skip"
    Then I should see "FLIGHT DETAILS"
    And I should see "share_icon"
    When I press "share_icon"
    Then I should see "Share"
    And I should see "Email"
    And I should see "SMS"
    And I should see "Add to Calendar"
    And I should see "More..."
    And I should see "Cancel"
    When I press "Email"
    Then I should see "Cancel"
    And I should see "SEND EMAIL"
    And I should see "To*"
    And I should see "NOTE"



  ############################################################
  #                       ADD TO CALENDAR                    #
  ############################################################

  Scenario: iPhone - Add To Calendar
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "NETJETS"
    And I wait for "Skip" to appear
    When I press "Skip"
    Then I should see "FLIGHT DETAILS"
    And I should see "share_icon"
    When I press "share_icon"
    Then I should see "Add to Calendar"
    When I press "Add to calendar"
    Then I should see "Cancel"
    And I should see "EVENT"
    And I should see "Add"
    And I should see "NEW EVENT"
    And I should see "line_image"
    And I should see "Flight to city_name, state_name"
    And I should see "Signature Aviation"
    And I should see "All days"
    And I should see "on_off_button"
    And I should see "Starts"
    And I should see "starting_date"
    And I should see "start_time"
    And I should see "Ends"
    And I should see "end_time"
    And I should see "Repeat"
    And I should see "Never"
    And I should see "arrow_icon"
    And I should see "Ends"
    And I should see "None"
    And I should see "arrow_icon"
    And I should see "Calendar"
    And I should see "email_id"
    And I should see "arrow_icon"
    And I should see "Invites"
    And I should see "None"
    And I should see "arrow_icon"
    And I should see "Alert"
    And I should see "None"
    And I should see "arrow_icon"
    And I should see "Show As"
    And I should see "Busy"
    And I should see "arrow_icon"
    And I should see "URL"
    And I should see "line_image"
    And I should see "Reservation #: reservation_number"
    And I should see "Tail #: tail_number"
    And I should see "from_airport,from_city_name"
    And I should see "flight_icon"
    And I should see "arrival_airport, arrival_city_name"
    And I should see "Arrival FBO: Lorem Ipsum Aviation"


  ############################################################
  #                       ADD TO CALENDAR                    #
  ############################################################

  Scenario: iPhone - Add To Calendar
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "NETJETS"
    And I wait for "Skip" to appear
    When I press "Skip"
    Then I should see "FLIGHT DETAILS"
    And I should see "share_icon"
    When I press "share_icon"
    Then I should see "Add to Calendar"
    When I press "Add to calendar"
    Then I should see "Add"
    When I press "Add"
    Then I enter "remainder_message" into the textfield