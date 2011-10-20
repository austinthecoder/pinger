class BasePresenter

  def initialize(object, template)
    @object = object
    @tpl = template
  end

private

  # TODO: make public and test
  def render_form_errors(attribute)
    errors = @object.errors[attribute].map &:capitalize
    if errors.present?
      render 'shared/form_errors', :errors => errors
    end
  end

  class << self
    def presents(name)
      define_method(name) { @object }
    end
  end

  def method_missing(*args, &block)
    @tpl.send *args, &block
  end

end