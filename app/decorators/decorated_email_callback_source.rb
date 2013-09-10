module DecoratedEmailCallbackSource

  attr_accessor :account
  attr_accessor :controller

  def new(attrs = {})
    decorate_email_callback(super()).tap do |email_callback|
      email_callback.attributes = attrs
    end
  end

  def find_by_id(id)
    if email_callback = super
      decorate_email_callback email_callback
    end
  end

  def each
    super do |email_callback|
      yield decorate_email_callback(email_callback)
    end
  end

private

  def decorate_email_callback(email_callback)
    email_callback.extend(DecoratedEmailCallback).tap do |email_callback|
      email_callback.controller = controller
      email_callback.account = account
    end
  end

end