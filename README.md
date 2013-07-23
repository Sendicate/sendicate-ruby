# Sendicate

This gem is a wrapper for the [Sendicate API](https://github.com/Sendicate/sendicate-docs/tree/master/api).

Find out more about Sendicate at [https://www.sendicate.net/](https://www.sendicate.net/).


## Installation

    gem install sendicate


## Requirements

You will need a Sendicate account and [API token](https://www.sendicate.net/account/edit).  The token can be found by logging into your Sendicate account and going to Manage, then Account, then scrolling down to API Access.


## Usage

Configure your API token. You can either set the environment variable SENDICATE_API_TOKEN to your api token or hardcode it.

    export SENDICATE_API_TOKEN='YOUR_API_TOKEN'
    # or
    Sendicate.api_token = 'YOUR_API_TOKEN'


### Lists

Create a new list:

    list = Sendicate::List.new(title: 'Life-changing newsletter list')
    list.save
    
View all lists:
    
    lists = Sendicate::List.all

Update a list:

    list.title = 'new list'
    list.save

Destroy a list:

    list.destroy

Add a subcriber to a list:

    import = Sendicate::Import.new(
      list_id: LIST_ID, 
      data: {
        email: 'user@example.com', 
        name: 'New User'
      }
    )
    
    if import.save
      puts 'success'
    else
      puts import.error_messages
    end


### Subscribers

Change a subscriber's email address:

    subscriber = Sendicate::Subscriber.find('user@example.com')
    subscriber.email = 'differentuser@example.com'
    subscriber.save

Unsubscribe a subscriber:

    Sendicate::Subscriber.unsubscribe('user@example.com')

Check if a subscriber belongs to a list:

    subscriber.list_ids.include?(LIST_ID)

## Contributing to sendicate-ruby
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.


## Copyright

Copyright (c) 2013 Evan Whalen. See LICENSE.txt for
further details.

