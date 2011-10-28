class BasePresenter

  def initialize(object, template)
    @object = object
    @tpl = template
  end

  def render_form_errors(attribute)
    if (errors = @object.errors[attribute]).present?
      render 'shared/form_errors', errors: errors.map(&:capitalize)
    end
  end

private

  class << self
    def presents(name)
      define_method(name) { @object }
    end
  end

  # TODO: test
  def method_missing(*args, &block)
    @tpl.send *args, &block
  end

end