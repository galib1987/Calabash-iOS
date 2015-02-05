Feature: Accounts

  ############################################################
  #                       Account menu                       #
  ############################################################

  Scenario: iPhone - Account Menu
    #Given I am on the Account Screen
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "ACCOUNT"
    When I press "ACCOUNT"
    Then I should see "ACCOUNT"
    And I should see "user_icon"
    And I should see "Your Profile"
    And I should see "Lorem Ipsum"
    And I should see "flight_icon"
    And I should see "Your Past Flights"
    And I should see "Lorem Ipsum"
    And I should see "Big Skies LLC"
    And I should see "Principal"
    And I should see "Ajayal Banga"
    And I should see "VIEW DETAILS"
    And I should see "Bettina Smith"
    And I should see "Principal"
    And I should see "Bettina Smith"
    And I should see "VIEW DETAILS"
    And I should see "Big Skies LLC"
    And I should see "Principal"
    And I should see "Ajayal Banga"
    And I should see "VIEW DETAILS"


  ############################################################
  #                   iPhone - Your Profile                  #
  ############################################################

  Scenario: iPhone - Your Profile
    #Given I am on the Account Screen
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "ACCOUNT"
    When I press "ACCOUNT"
    Then I should see "Your Profile"
    When I press "Your Profile"
    Then I should see "back_arrow_icon"
    And I should see "YOUR PROFILE"
    And I should see "Ms. Bettina Smith"
    And I should see "NetJets Login"
    And I should see "Bettina.Smith@bigskies.com"
    And I should see "CHANGE PASSWORD"
    And I should see "NEED TO MAKE A CHANGE?"
    And I should see text starting with "Full profile details"
    And I should see text ending with "at any time for assistance."


  ############################################################
  #                iPhone - Your Details                  #
  ############################################################

  Scenario: iPhone - Your Details
    #Given I am on the Account Screen
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "ACCOUNT"
    When I press "ACCOUNT"
    Then I should see "Big Skies LLC"
    And I should see "VIEW DETAILS"
    When I press "VIEW DETAILS"
    Then I should see "back_arrow_icon"
    And I should see "ACCOUNT DETAILS"
    And I should see "Big Skies LLC"
    And I should see "Principal"
    And I should see "Ajayal Banga"
    And I should see "CONTRACTS"
    And I should see "NetJets Lease"
    And I should see "Cessna Citation Encore +"
    And I should see "89.4/100"
    And I should see "Hours flown"
    And I should see "WOULD YOU LIKE TO RENEW A CONTRACT?"
    And I should see "For assistance please contact you NetJets sales representatives:"
    And I should see "Sales Vice President"
    And I should see "Firstname Lastname"
    And I should see "888.888.8888"
    And I should see "Account Executive"
    And I should see "Firstname Lastname"
    And I should see "888.888.8888"
    And I should see "Full contract details, account history and billing can be accessed through the NetJets Owners Portal."


  ############################################################
  #                   iPhone - Your Past Flights                  #
  ############################################################

  Scenario: iPhone - Past Flights
    #Given I am on the Account Screen
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "ACCOUNT"
    When I press "ACCOUNT"
    Then I should see "Your Past Flights"
    When I press "Your Past Flights"
    Then I should see "back_arrow_icon"
    And I should see "YOUR PAST FLIGHTS"
    And I should see "Rebook a previous flight."
    And I should see "We provide a list of past flights so you can review and copy  details from a completed itinerary."
    And I should see "the_list_of_past_flights_associated_with_the_user"
    When I press "any_flight_from_the_list_of_past_flights_associated_with_the_user"
    Then I should see "back_arrow_icon"
    And I should see "PAST FLIGHT"
    And I should see "REBOOK THIS FLIGHT"
    And I should see "Big Skies LLC"
    And I should see "Reservation Hours Used"
    And I should see "6 Hours"
    And I should see "Projected Hours Left"
    And I should see "150 Hours"
    And I should see "DEPART"
    And I should see "depart_time"
    And I should see "airport_name_name"
    And I should see "departure_city_name"
    And I should see "flight_icon"
    And I should see "duration_of_traval_time"
    And I should see "type_of_service_Non_Stop_or_Stop"
    And I should see "ARRIVE"
    And I should see "arrival_time"
    And I should see "arrival_airport_name"
    And I should see "arrival_city_name"
    And I should see "Passengers"
    And I should see "number_of_passengers People"
    And I should see "Aircraft"
    And I should see "Bombardier"
    And I should see "* Upgraded"
    And I should see "Special Instructions"
    And I should see "Lorem ipsum dolor ito. Lorem ipsum dolor ito. Lorem ipsum dolor ito. Ito lorem ipsum dolor ito lorem ipsum dolor."



  ############################################################
  #                     iPhone - Settings                    #
  ############################################################

  Scenario: iPhone - Settings
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "SETTINGS"
    When I press "SETTINGS"
    Then I should see "back_arrow_icon"
    And I should see "SETTINGS"
    And I should see "Push Notifications"
    And I should see "on"
    And I should see "arrow_icon"
    And I should see "Display Units"
    And I should see "arrow_icon"
    And I should see "Privacy and Terms"
    And I should see "arrow_icon"
    And I should see "About this App"
    And I should see "arrow_icon"
    And I should see "Love this App?"
    And I should see "Would you like to  comment on a recent flight?"
    And I should see "Is there a feature that you would like to see in the next release of this app?"
    And I should see "SEND US YOUR FEEDBACK"
    And I should see "LOG OUT"


  ############################################################
  #          iPhone - Settings - Push Notifications          #
  ############################################################

  Scenario: iPhone - Settings - Push Notifications
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "SETTINGS"
    When I press "SETTINGS"
    Then I should see "Push Notifications"
    When I press "Push Notifications"
    Then I should see "back_arrow_icon"
    And I should see "PUSH NOTIFICATIONS"
    And I should see text starting with "Toggle to the right to enable"
    And I should see text ending with "change it on this page."
    And I should see "Flight Notifications"
    And I should see "on_off_button"



  ############################################################
  #              iPhone - Settings - Display Units           #
  ############################################################

  Scenario: iPhone - Settings - Display Units
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "SETTINGS"
    When I press "SETTINGS"
    Then I should see "Display Units"
    When I press "Display Units"
    Then I should see "back_arrow_icon"
    And I should see "DISPLAY UNITS"
    And I should see "Date"
    And I should see "US"
    And I should see "arrow_icon"
    And I should see "Time"
    And I should see "Standard"
    And I should see "arrow_icon"
    And I should see "Temperature"
    And I should see "temperature_iconF"
    And I should see "arrow_icon"
    And I should see "Distance"
    And I should see "Miles"
    And I should see "arrow_icon"



  ############################################################
  #           iPhone - Settings - Display Units Date         #
  ############################################################

  Scenario: iPhone - Settings - Display Units - Date
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "SETTINGS"
    When I press "SETTINGS"
    Then I should see "Display Units"
    When I press "Display Units"
    Then I should see "Date"
    When I press "Date"
    Then I should see "back_arrow_icon"
    And I should see "DATE"
    And I should see "Choose the date format you prefer."
    And I should see "US: day month date, year"
    And I should see "tick_icon"
    And I should see "EU: day month date year"



  ############################################################
  #             iPhone - Settings - About this App           #
  ############################################################

  Scenario: iPhone - Settings - About this App
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "SETTINGS"
    When I press "SETTINGS"
    Then I should see "About this App"
    When I press "About this App"
    Then I should see "back_arrow_icon"
    And I should see "ABOUT THIS APP"
    And I should see "PRIVACY & TERMS"
    And I should see "line_image"
    And I should see text starting with "Lorem ipsum dolor"
    And I should see text ending with "elementum mollis."
    And I should see "LEGAL"
    And I should see "line_image"
    And I should see text starting with "Ut posuere"
    And I should see text ending with "arcu nec ex."



  ############################################################
  #                 iPhone - Settings - Feedback             #
  ############################################################

  Scenario: iPhone - Settings - Feedback
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "SETTINGS"
    When I press "SETTINGS"
    Then I should see "SEND US YOUR FEEDBACK"
    When I press "SEND US YOUR FEEDBACK"
    Then I should see "Cancel"
    And I should see "FEEDBACK"
    And I should see text starting with "Your feedback is always"
    And I should see text ending with "call your Owner Services team at any time."
    And I should see "SUBJECT"
    And I should see "Select a topic"
    When I press "Select a topic"
    Then I should see "Done"
    And I should see "arrow_icon"
    And I should see "arrow_icon"
    And I should see "Feedback about this app"
    And I should see "Feedback about a flight"
    When I press "Feedback about this app"
    Then I enter "feedback_content" into the "feedback" text field
    When I press "Send"
    Then I should see "FEEDBACK SEND"
    And I should see "Thank You!"
    And I should see "line_image"
    And I should see "Your feedback has been sent."
    And I should see text starting with "Lorem ipsum dolor"
    And I should see text ending with "iaculis quis."
    And I should see "GO BACK TO SETTINGS"


  ############################################################
  #        iPhone - Settings - Feedback without subject      #
  ############################################################

  Scenario: iPhone - Settings - Feedback without subject
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "SETTINGS"
    When I press "SETTINGS"
    Then I should see "SEND US YOUR FEEDBACK"
    When I press "SEND US YOUR FEEDBACK"
    Then I should see "Cancel"
    And I should see "FEEDBACK"
    And I should see text starting with "Your feedback is always"
    And I should see text ending with "call your Owner Services team at any time."
    And I should see "SUBJECT"
    And I should see "Select a topic"
    And I enter "feedback_content" into the "feedback" text field
    When I press "Send"
    Then I should see "Your feedback message has no subject. What would you like to do?"
    And I should see "GO BACK"
    And I should see "SEND ANYWAY"


  ############################################################
  #                       iPhone - Logout                    #
  ############################################################

  Scenario: iPhone - Logout
    Given I enter "user_email_id" into the "EMAIL" text field
    And I enter "user_password" into the "PASSWORD" text field
    When I press "LOGIN"
    Then I should see "menu_button"
    When I press "menu_button"
    Then I should see "SETTINGS"
    When I press "SETTINGS"
    Then I should see "LOG OUT"
    When I press "LOG OUT"
    Then I should see "Are you sure you want to log out?"
    And I should see "GO BACK"
    And I should see "YES"