# Solution to Software Engineer Challenge

## Setup

Follow these commands for setting up on your local environment (assuming you already have a working Ruby environment installed):

    $ git clone https://github.com/mykoweb/data-engineering.git
    $ cd data-engineering
    $ bundle install
    $ rake db:migrate
    $ rails server

You can now open a browser and point to http://localhost:3000

If you want to run tests, you'll need to run

    $ rake db:test:prepare
    $ rspec

## Assumptions

Some assumptions were made when solving this challenge:

1. Purchaser and Merchant names must be unique.
2. For a given Merchant, 2 items with the same description but with different prices are considered 2 different items.
3. Columns in the tab-delimited file will always be in the correct order and will have data in the correct format.
4. There will always be a header line with the correct headings in the tab-delimited file.

