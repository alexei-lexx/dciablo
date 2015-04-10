class MoneyTransaction < Dciablo::Context

  def initialize(source_account, target_account, amount)
    set_actor :source, source_account
    set_actor :target, target_account
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
