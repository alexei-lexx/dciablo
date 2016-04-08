class MoneyTransfer < Dciablo::Context
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
