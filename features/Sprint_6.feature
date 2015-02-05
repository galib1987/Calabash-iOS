Feature: Login, Navigation, Flight List, Flight Details


 ###########################################

  #Login

 ###########################################

  @Done
  Scenario: iPhone - UI Elements
    Given  I am on the Login Screen
    #Then   I should see "NETJETS"
    And    I should see "Reset Password"
    And    I should see "Learn more about NetJets"
    And    I should see "Contact Sales"
    And    I should see "For Owner Service General Inquiry: 1.888.8888"

  @Done
  Scenario: iPhone - Unsuccessful Login
    Given I am on the Login Screen
    And   I enter "kbrowdcdcedn@email.com" into the  "USERNAME" field name
    And   I enter "abc1dcece23ABC" into the  "PASSWORD" field fname
    And   I touch "LOG IN"
    And   I should not see "YOUR NEXT FLIGHT"
    #Then  I should see "Incorrect log in credentials for this account."

  @Done
  Scenario: iPhone - Successful Login
    Given I am on the Login Screen
    And   I enter "kbrown@email.com" into the  "USERNAME" field name
    And   I enter "abc123ABC" into the  "PASSWORD" field fname
    And   I touch "LOG IN"
    And   I should see "YOUR NEXT FLIGHT"


 ###########################################

  #Reset Password

 ###########################################


  @Done
  Scenario: iPhone - Reset Password - automated test
    Given I am on the Login Screen
    When  I press "Reset Password"
    Then  I should see "Reset Password"
    And   I should see "Enter your login email to receive instructions on resetting your password. If you need asssistance please call your Owner Service team."
    Then  I enter "kbrown@email.com" into "EMAIL" input field
    Then  I press "Submit"
    Then  I should see "an email has been sent to: <email> Please follow link in that email to complete your password reset"
    Then  I should return to Login Screen


 ###########################################

  #Contact sales

 ###########################################


  @Done
  @Not_ready_to_Execute

  Scenario: iPhone - Contact Sales
    Given I am on the Login Screen
    When  I press "Contact Sales"
    #Then  I should see "NETJETS"
    And   I should see "UNITED STATES"
    And   I should see "877-356-5823"
    And   I should see "EUROPE"
    And   I should see "+44 (0)-843-634-9006"
    And   I should see "CHINA"
    And   I should see "877-356-5823"
    And   I should see "Learn more about NetJets"
    And   I should see "For Owner Services general inquiry: 1.888.756.3423"




 ###########################################

  #Navigation

 ###########################################


  @Done
  Scenario: iPhone -  Navigation
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    And    I should see "ACCOUNT"
    And    I should see "FLIGHTS"
    And    I should see "MESSAGES"
    And    I should see "BOOK"
    And    I should see "SETTINGS"




 ###########################################

  #Home

 ###########################################


  @Done
  Scenario: iPhone - Home Screen Next Flight test *w/Tail #
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    #Then   I wait for 2 seconds
    Then   I touch "HOME"
    #Then   I should see "NETJETS"
    Then   I should see "YOUR NEXT FLIGHT"
    Then   I should see "N168QS"
    Then   I should see "Ground Transportation"
    Then   I should see "Pick Up at 11:00AM"
    Then   I should see "Departure FBO"
    Then   I should see "Signature Aviation"
    Then   I should see "DEPART"
    Then   I should see "03:06PM"
    Then   I should see "EDDM"
    Then   I should see "MUNICH"
    Then   I should see "2h 54m"
    Then   I should see "ARRIVE"
    Then   I should see "10:00AM"
    Then   I should see "FACT"
    Then   I should see "CAPE TOWN"
    Then   I should see "VIEW FLIGHT DETAILS"



  @Done
  @Check
  Scenario: iPhone - Home Screen On The Day Of The Flight (not in-flight), with Ground Transportation
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    #Then   I wait for 2 seconds
    Then   I touch "HOME"
    #Then   I should see "NETJETS"
    Then   I should see "YOUR NEXT FLIGHT"
    Then   I should see "Cessna Citation Encore+"
    Then   I should see "Tail#"
    Then   I should see "N168QS"
    Then   I should see "Departure FBO"
    Then   I should see "Signature Aviation"
    Then   I should see "Ground Transportation"
    Then   I should see "Pick Up at 11:00AM"
    Then   I should see "DEPART"
    Then   I should see "08:00AM"
    Then   I should see "KCMH"
    Then   I should see "COLUMBUS"
    Then   I should see "2h 54m"
    Then   I should see "ARRIVE"
    Then   I should see "08:48AM"
    Then   I should see "KLAS"
    Then   I should see "LAS VEGAS"
    Then   I should see "VIEW FLIGHT DETAILS"

  @Done
  Scenario: iPhone - Home Screen Day Of - IN FLIGHT
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    #Then   I wait for 2 seconds
    Then   I touch "HOME"
    #Then   I should see "NETJETS"
    Then   I should see "YOUR NEXT FLIGHT"
    Then   I should see "Cessna Citation Encore+"
    Then   I should see "Tail#"
    Then   I should see "N168QS"
    Then   I should see "Departure FBO"
    Then   I should see "Signature Aviation"
    Then   I should see "DEPART"
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I should see "08:00AM"
    Then   I should see "KCMH"
    Then   I should see "COLUMBUS"
    Then   I should see "2h 54m"
    Then   I should see "ARRIVE"
    Then   I should see "08:48AM"
    Then   I should see "KLAS"
    Then   I should see "LAS VEGAS"
    Then   I should see "Time Until Arrival"
    Then   I should see "2hrs 7mins"
    Then   I should see "VIEW FLIGHT DETAILS"



  @Done
  Scenario: iPhone - Home Screen, No Flight Booked
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    #Then   I wait for 2 seconds
    Then   I touch "HOME"
    #Then  I should see "NETJETS"
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I should see "NO FLIGHTS BOOKED"
    Then   I should see Paris is always a good idea text
    Then   I should see "-Audrey Hepburn"
    Then   I should see "BOOK A NEW FLIGHT"




  ##################################################################################


   # Flight List


  ##################################################################################



  @Done
  Scenario: iPhone - Flight List - YOUR FLIGHTS
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I touch "FLIGHTS"
    And    I should see "YOUR FLIGHTS"
    And    I touch "YOUR FLIGHTS"
    Then   I should see "JAN"
    And    I should see "/1"
    Then   I should see "Wednesday"
    Then   I should see "CAPE TOWN"
    Then   I should see "MUNICH"
    Then   I should see "12:00PM - 2:45AM"



  @Done
  Scenario: iPhone - Flight List - ACCOUNT FLIGHTS
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    #And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I touch "FLIGHTS"
    And    I should see "YOUR FLIGHTS"
    And    I touch "ACCOUNT FLIGHTS"
    Then   I should see "JAN"
    And    I should see "/1"
    Then   I should see "Wednesday"
    Then   I should see "CAPE TOWN"
    Then   I should see "MUNICH"
    Then   I should see "12:00PM - 2:45AM"



  ##################################################################################


   # Flight Details


  ##################################################################################





  @Done
  Scenario:  iPhone -  Flight Details - Forecasted Weather

    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    Then   I touch "HOME"
    Then   I scroll down
    #Then   I scroll down
    Then   I touch "VIEW FLIGHT DETAILS"
    Then   I scroll down
    Then   I should see "Forecasted Weather"
    Then   I should see "Sat Jan 31, 2015"
    And    I should see "MUNICH"
    And    I should see "10:00AM"
    And    I should see "39°"
    Then   I should see "Sat Jan 31, 2015"
    And    I should see "CAPE TOWN"
    And    I should see "03:06PM"
    And    I should see "85°"

 #####################  LAB #####################################################



  Scenario: iPhone -  Flight Details

    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    When   I press "FLIGHTS"
    And    I should see "YOUR FLIGHTS"
    And    I touch "ACCOUNT FLIGHTS"
    And    I wait for 4 seconds
#    And    I touch "the_first_flight_from_the_list"
#    Then   I touch "VIEW FLIGHT DETAILS"
#    Then   I should see "FLIGHT DETAILS"
#    #Then   I should see "back_arrow_icon"
#    #Then   I should see "share_icon"
#    Then   I should see "Departing time"
#    Then   I should see "depart_date"
#    Then   I should see "depart_city"
#    Then   I should see "Airport_code"
#    Then   I should see "Departure FBO"
#    And    I should see "Tail #"
#    Then   I should see "Est. Travel: duration_of_travel_time"
#    Then   I should see "Arriving time"
#    Then   I should see "Arrival_date"
#    Then   I should see "Arrival_city"
#    Then   I should see "Airport_code"
#    Then   I should see "Arrival FBO"

  Scenario: iPhone - Flight Details - Catering
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    Then   I touch "HOME"
    Then   I scroll down
    #Then   I scroll down
    Then   I touch "VIEW FLIGHT DETAILS"
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I touch "Catering"
    Then   I wait


  Scenario: iPhone - Flight Details - Passenger Manifest
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    Then   I touch "HOME"
    Then   I scroll down
    Then   I touch "VIEW FLIGHT DETAILS"
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I touch "Passenger Manifest"
    Then   I wait and wait

  Scenario: iPhone - Flight Details - Your Crew
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    Then   I touch "HOME"
    Then   I scroll down
    Then   I touch "VIEW FLIGHT DETAILS"
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I touch "Your Crew"
    Then   I wait and wait


  Scenario: iPhone - Flight Details - Ground Transportation
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    Then   I touch "HOME"
    Then   I scroll down
    Then   I touch "VIEW FLIGHT DETAILS"
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I touch "Ground Transportation"
    Then   I wait and wait

  Scenario: iPhone - Flight Details - Ground Transportation
    Given  I am on the Login Screen
    And    I enter "kbrown@email.com" into the  "USERNAME" field name
    And    I enter "abc123ABC" into the  "PASSWORD" field fname
    And    I touch "LOG IN"
    #And    I touch "Ok"
    And    I touch "Kim - Brown - User ID: 1064684"
    When   I press Menu_Button
    Then   I should see "HOME"
    Then   I touch "HOME"
    Then   I scroll down
    Then   I touch "VIEW FLIGHT DETAILS"
    Then   I scroll down
    Then   I scroll down
    Then   I scroll down
    Then   I touch "Ground Transportation"
    Then   I wait and wait
