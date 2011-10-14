class BasePresenter

  def initialize(object, template)
    @object = object
    @tpl = template
  end

  attr_reader :tpl

  def model
    @object
  end

  def ==(other)
    [model, tpl] == [other.model, other.tpl]
  end

private

  class << self
    def presents(name)
      define_method(name) { @object }
    end
  end

end