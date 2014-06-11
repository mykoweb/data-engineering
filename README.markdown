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
5. Special characters are allowed in the tab-delimited file only for Item objects (see Issues described below).

## Issues

1. There was an issue querying for Items with special characters using the Rails `find_by` and `find_or_create_by` methods with SQLite. As a solution, we are using `Item.where` in conjunction with the SQL `LIKE` command. This seems to be an SQLite bug. We tested in PostgreSQL and this issue does not appear there. This issue was found when reading in the same tab-delimited file twice.

## TODOs

1. Add more validations for the tab-delimited file. Currently, we are only performing simple validations such as checking for empty fields or checking for non-integers in the 'Purchase Count' field. We also need to decide what we should do if a validation fails on a line other than the first line of the tab-delimited file. In this case, should we ignore all previously validated lines? Or should we allow the validated lines but stop reading the file as soon as we hit an invalid field and ignore all subsequent lines? Decisions, decisions...
2. Add handling for Authentication and Authorization.
3. Make it aesthetically pleasing.
4. Modify code to handle special characters in other columns (other than those columns pertaining to Items) in the tab-delimited file.
