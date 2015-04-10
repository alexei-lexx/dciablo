require 'delegate'

class Dciablo::Context
  class << self
    attr_accessor :roles

    def role(name, &block)
      attr_accessor name
      self.roles ||= {}
      roles[name.to_sym] = block
    end
  end

  def set_actor(role, actor)
    made_up_actor = SimpleDelegator.new(actor)
    proc = self.class.roles[role.to_sym]
    made_up_actor.instance_eval &proc
    send "#{role}=".to_sym, made_up_actor
  end
end
