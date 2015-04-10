class MoneyTransaction < Dciablo::Context

  def initialize(user_a, user_b)
    set_actor :source, user_a
    set_actor :target, user_b
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

  def transfer(amount)
    source.subtract(amount)
    target.add(amount)
  end
end
