class FormPresenter
  # TODO: test
  class Input

    include Comparable

    def initialize(form_presenter)
      @form_presenter = form_presenter
    end

    attr_reader :form_presenter

    def <=>(other)
      form_presenter <=> other.form_presenter
    end

  private

    delegate :render, :text_field, :select, :location, :to => :form_presenter

  end
end