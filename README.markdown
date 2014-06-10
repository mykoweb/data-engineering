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

## Issues

1. There was an issue querying for Items with special characters using the Rails `find_by` and `find_or_create_by` methods with SQLite. As a quick fix, we are using `Item.where` in conjunction with the SQL `LIKE` command. This is only a temporary fix as this is a Rails anti-pattern and it potentially exposes the app to SQL Injection attacks. DO NOT USE THIS CODE IN ANY PRODUCTION ENVIRONMENT.

## TODOs

1. Fix the issue above.
2. Add more validations for the tab-delimited file. Currently, we are only performing simple validations such as checking for empty fields or checking for non-integers in the 'Purchase Count' field. We also need to decide what we should do if a validation fails on a line other than the first line of the tab-delimited file. In this case, should we ignore all previously validated lines? Or should we allow the validated lines but stop reading the file as soon as we hit an invalid field and ignore all subsequent lines? Decisions, decisions...
3. Add handling for Authentication and Authorization.
4. Make it aesthetically pleasing.
