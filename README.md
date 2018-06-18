# SinatraPortfolioProject

The Sinatra Portfolio Project app provides a database and web interface for Authors to:
1.  Authors have to signup on this app inorder to add their books.
2.  Once signed up they can logon and start adding their books on this site.
3.  Authors can only edit or delete their own books
4.  Authors can add category to the book from the existing category or they can add new category while adding their book
5.  On home page of this site authors can view books of other author.
6.  All authors have capability to add or delete or edit a cateory regardless of who added the category. But a category which is      already assigned to a book can neither be edited or deleted.
 
 This app was built with Sinatra, extended with Rake tasks for working with an SQL database using ActiveRecord ORM


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra_portfolio_project'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra_portfolio_project

## Usage

After checking out the repo, run bundle install to install Ruby gem dependencies.

You can start one of Rack's supported servers using the shotgun command shotgun and navigate to localhost:9393 in your browser.



## Models
The Author Registration app includes four model classes: Author, BookCategory, Book, and Category

Author:
  has_many :books
  has_many :categories, through: :books
  
Has attributes:
* Name
* Email
* Password (Secured with [Bcrypt](https://github.com/codahale/bcrypt-ruby) hashing algorithm)
* Moms Maiden Name

BookCategory (join table):
  belongs_to :book
  belongs_to :category
  
Has attributes:
* book_id
* category_id

Category
  has_many :book_categories
  has_many :books, through: :book_categories
  has_many :authors, through: :books
Has attributes:
* name

Book
  belongs_to :author
  has_many :book_categories
  has_many :categories, through: :book_categories
Has attributes:
* name
* author_id


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'ayesha-x-ansari'/sinatra_portfolio_project. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the SinatraPortfolioProject project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'ayesha-x-ansari'/sinatra_portfolio_project/blob/master/CODE_OF_CONDUCT.md).

## License
The app is available as open source under the terms of the MIT License.
