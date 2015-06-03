require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module RoleA
  def method_a
  end
end

class RoleInModuleContext < Dciablo::Context
  def initialize(actor_a, actor_b)
    set_actor(:role_a, actor_a)
  end

  module RoleB
    def method_b
    end
  end

  role :role_a, as: RoleA
  role :role_b, as: RoleB
end

describe RoleInModuleContext do
  let(:actor_a) { Object.new }
  let(:actor_b) { Object.new }
  let(:context) { RoleInModuleContext.new(actor_a, actor_b) }

  describe '#role_a' do
    context 'when includes an external module' do
      it 'responds to its methods' do
        expect(context.role_a.respond_to?(:method_a)).to be true
      end
    end
  end
end
