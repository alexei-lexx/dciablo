require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe MoneyTransfer do
  context 'when two accounts are given' do
    let(:john) { OpenStruct.new(balance: 10) }
    let(:david) { OpenStruct.new(balance: 20) }
    let(:context) { MoneyTransfer.new(john, david) }

    describe '#source' do
      let(:source_role) { context.source }

      it 'has balance = 10' do
        expect(source_role.balance).to eq 10
      end

      it 'responds to :transfer_out' do
        expect(source_role.respond_to?(:transfer_out)).to be true
      end
    end

    describe '#target' do
      let(:target_role) { context.target }

      it 'has balance = 20' do
        expect(target_role.balance).to eq 20
      end

      it 'responds to :add' do
        expect(target_role.respond_to?(:transfer_in)).to be true
      end
    end

    describe '#transfer' do
      it 'transfers $5 from source to target' do
        context.transfer(5)
        expect(john.balance).to eq 5
        expect(david.balance).to eq 25
      end

      it 'doesnt change accounts definition' do
        context.transfer(5)
        expect(john.respond_to?(:transfer_out)).to be false
        expect(david.respond_to?(:transfer_in)).to be false
      end
    end
  end
end
