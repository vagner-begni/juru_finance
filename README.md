# JURU_FINANCE: Payment Management System
### (personal project for learning Ruby on Rails enviroment)

Application for managing the financial transactions required to maintain a service for a group of payers. The idea arose from the author's experience on the street where he lives: residents of a street contribute monthly to the operation of a guardhouse. The system aims to record contributions from residents, as well as payments made to service providers.

### Main Features ([x] defines implemented features):
- [x] User register (resident, employee, financial management and administrator)
- [ ] Access management by Administrator
- [ ] House and its residents register 
- [ ] Financial transactions register
- [ ] Financion transactions visualization

### Development Stack
* Ruby 3.1.3 | Rails 7.0.4
* PostgreSQL
* Dependencies
    * Rspec (acceptance and unit tests)
    * Capybara (acceptance tests)
    * Rubocop (linter)
    * Simplecov (code coverage)
    * Devise (authentication)

### Usage
No Linux terminal, type:
* git clone ***xxx***
* cd juru_finance
* bundle install
* rails db:migrate
* rails db:seed
* rails server

In browser, type the URL (localhost):
* localhost:3000/
### Tests and linter
In Linux terminal, access the app path, and type:
* rspec (for tests)
* rubocop (for linter)
