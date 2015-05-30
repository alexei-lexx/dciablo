# Dciablo

[![Build Status](https://travis-ci.org/alexei-lexx/dciablo.svg?branch=master)](https://travis-ci.org/alexei-lexx/dciablo)

DCI (Data, context and interaction) is a pattern used to program a
collaboration of objects.
It separates the data from use case (which is called a context) and Roles that objects play (interaction).
An excellent explanation you can find in the article
http://www.sitepoint.com/dci-the-evolution-of-the-object-oriented-paradigm/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dciablo', github: 'alexei-lexx/dciablo'
```

And then execute:

    $ bundle

## Usage

Let's look at the classic example: Money Transfer. Suppose we have two
users with account balances and we want to make a transfer from user A to
user B.

In terms of DCI we have
* context - our money transfer operation,
* two roles (source and target), which are played by both users,
* an interaction - an algorithm to transfer money between balances.

The context is a class derived from Dciablo::Context.
The roles are defined by class macros `role`, which is followed by a block with
definitions of extra methods.


```ruby
class MoneyTransfer < Dciablo::Context
  def initialize(user_a, user_b)
    set_actor :source, user_a
    set_actor :target, user_b
  end
  
  role :source do
    def transfer_out(amount)
      self.balance -= amount
      context.target.transfer_in(amount)
    end
  end

  role :target do
    def transfer_in(amount)
      self.balance += amount
    end
  end

  def transfer(amount)
    source.transfer_out(amount)
  end
end
```


As you can see our context constructor takes 2 arguments: two users, who play
the roles. The private method `set_actor` is used to assign a role to each user.

One significant thing here. The role `source` accesses the role `target`
through `context`.

```ruby
context.target.transfer_in(amount)
```

Here is the example of usage.

```ruby
john = OpenStruct.new(balance: 10)
david = OpenStruct.new(balance: 20)

context = MoneyTransfer.new(john, david)
context.transfer(5)

p john.balance    # 5
p david.balance   # 25
```

## Contributing

1. Fork it ( https://github.com/alexei-lexx/dciablo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
