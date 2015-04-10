# Dciablo

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
users with account balances and we want to make a transaction from user A to
user B.

In terms of DCI we have
* context - our money transfer operation,
* two roles (source and target), which are played by both users,
* an interaction - an algorithm to transfer money between balances.

The context is a class derived from Dciablo::Context.
The roles are defined by class macros `role`, which is followed by a block with
definitions of extra methods.


    class MoneyTransaction < Dciablo::Context
      def initialize(user_a, user_b, amount)
        set_actor :source, user_a
        set_actor :target, user_b
        @amount = amount
      end
      
      role :source do
        def subtract(amount)
          self.balance -= amount
        end
      end

      role :target do
        def add(amount)
          self.balance += amount
        end
      end

      def work
        source.subtract(@amount)
        target.add(@amount)
      end
    end

As you can see our context takes 3 arguments: two users and an amount. The private method `set_actor` is used to assign a role to each user.

Here is the example of usage.

    require 'ostruct'
    john = OpenStruct.new(balance: 10)
    david = OpenStruct.new(balance: 20)
    context = MoneyTransaction.new(john, david, 5)
    context.work

    p john.balance    # 5
    p david.balance   # 25

## Contributing

1. Fork it ( https://github.com/alexei-lexx/dciablo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
