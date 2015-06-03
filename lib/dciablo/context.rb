class Dciablo::Context
  class << self
    attr_accessor :roles

    def role(name, options = {}, &block)
      attr_accessor name
      self.roles ||= {}
      roles[name.to_sym] = {
        options: options,
        block: block
      }
    end
  end

  private

  def set_actor(role, actor)
    made_up_actor = Dciablo::Role.new(actor, self)
    proc = self.class.roles[role.to_sym][:block]
    made_up_actor.instance_eval &proc
    send "#{role}=".to_sym, made_up_actor
  end
end
