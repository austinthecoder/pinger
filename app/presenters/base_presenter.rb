class BasePresenter

  def initialize(object, template)
    @object = object
    @tpl = template
  end

  attr_reader :tpl

private

  class << self
    def presents(name)
      define_method(name) { @object }
    end
  end

end