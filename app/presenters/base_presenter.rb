class BasePresenter

  def initialize(object, template)
    @object = object
    @tpl = template
  end

private

  class << self
    def presents(name)
      define_method(name) { @object }
    end
  end

  def method_missing(*args, &block)
    @tpl.send *args, &block
  end

end