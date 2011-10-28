class FormPresenter

  class << self
    def field(name, opts = {})
      opts.reverse_merge! :class => "#{self}::#{name.to_s.camelize}Input".constantize
      define_method name do
        fields[name] ||= opts[:class].new(self)
      end
    end
  end

  def initialize(object_presenter, form_builder)
    @object_presenter = object_presenter
    @form_builder = form_builder
  end

  delegate :label, :text_field, :select,
    :to => :form_builder

  delegate :render, :button_tag,
    :to => :object_presenter

  def fields
    @fields ||= {}
  end

private

  attr_reader :object_presenter, :form_builder

end