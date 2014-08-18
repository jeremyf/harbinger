# Harbinger

[![Version](https://badge.fury.io/rb/harbinger.png)](http://badge.fury.io/rb/harbinger)
[![Build Status](https://travis-ci.org/ndlib/harbinger.png?branch=master)](https://travis-ci.org/ndlib/harbinger)
[![Code Climate](https://codeclimate.com/github/ndlib/harbinger.png)](https://codeclimate.com/github/ndlib/harbinger)
[![Coverage Status](https://img.shields.io/coveralls/ndlib/harbinger.svg)](https://coveralls.io/r/ndlib/harbinger)
[![API Docs](http://img.shields.io/badge/API-docs-blue.svg)](http://rubydoc.info/github/ndlib/harbinger/master/frames/)
[![APACHE 2 License](http://img.shields.io/badge/APACHE2-license-blue.svg)](./LICENSE)

A Rails engine for arbitrary message creation and delivery.

## Installation

Add this line to your application's Gemfile:

    gem 'blorg'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blorg

## Usage

```ruby
class PagesController
  def show
    @page = Page.find(params[:id])
  rescue ActiveRecord::RecordNotFound => exception
    Harbinger.call(
      channels: [:database, :logger],
      reporters: [exception, current_user, request]
    )
  end
end
```

When we attempt to find the given page but an exception is raised then the above code will:

* Build a message based on the three reporters:
  * The raised exception
  * The current user
  * The request
* Deliver that message to the two channels:
  * Database
  * Logger

For further details I recommend delving into the [end to end exception handling spec](./spec/features/end_to_end_exception_handling_spec.rb)

### Extending Contexts and Channels

Harbinger is built to allow for easy creation of new Contexts and Channels.