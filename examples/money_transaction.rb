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
