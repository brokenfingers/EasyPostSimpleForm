Feature: creating shipping label

Background: I am on the homepage
  Given I am on the homepage

Scenario: Failed to create shipping label
  Given I press "Create Shipment"
  Then I should be on the homepage

@stub_easypost_request
Scenario: Successfully created shipping label
  Give I fill the following:
  | from_address_company      | Hello         |
  | from_address_street1      | 222 Market St |
  |	from_address_city         | San Francisco |
  | from_address_zip          | 99999         |
  | from_address_phone_number | 999-999-9999  |
  | to_address_name           | Arnold John   |
  | to_address_company        | Bye           |
  | to_address_street1        | 111 Market St |
  | to_address_city           | San Francisco |
  | to_address_phone_number   | 888-888-8888  |
  | to_address_zip            | 99999         |
  | shipment_length           | 10            |
  | shipment_width            | 10            |
  | shipment_height           | 10            |
  | shipment_weight           | 10            |
  And I press "Create Shipment"
  Then I should be on the Shipping Label page