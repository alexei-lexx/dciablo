require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Dciablo::Context do
  let(:object) { Object.new }

  before do
    stub_const 'MyContext', Class.new(Dciablo::Context)
  end

  describe '.role' do
    before do
      class MyContext
        def initialize(object)
          set_actor :santa, object
        end

        role :santa do
          def give_gift; end
        end
      end
    end

    let(:context) { MyContext.new(object) }

    it 'creates the same-name getter' do
      expect(context).to respond_to :santa
    end

    it 'creates the same-name setter' do
      expect(context).to respond_to :santa=
    end

    context 'when a new method is defined in the role' do
      it 'adds this method to the resulted object' do
        expect(context.santa).to respond_to :give_gift
      end

      it 'leaves the original object clean' do
        expect(object).not_to respond_to :give_gift
      end
    end
  end
end
