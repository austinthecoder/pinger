module DecoratedLocationSource

  attr_accessor :account
  attr_accessor :controller

  def new(attrs = {})
    decorate_location(super()).tap do |location|
      location.attributes = attrs
    end
  end

  def find_by_id(id)
    if location = super
      decorate_location location
    end
  end

  def each
    super do |location|
      yield decorate_location(location)
    end
  end

private

  def decorate_location(location)
    location.extend(DecoratedLocation).tap do |location|
      location.controller = controller
      location.account = account
    end
  end

end