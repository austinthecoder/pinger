module Poser
  class Presenter

    include Comparable

    def initialize(presentee, view)
      @presentee = presentee
      @view = view
    end

    def render_form_errors(attribute)
      if (errors = @presentee.errors[attribute]).present?
        render 'shared/form_errors', errors: errors.map(&:capitalize)
      end
    end

  private

    class << self
      def presents(name)
        define_method(name) { @presentee }
      end
    end

    # TODO: test
    def method_missing(*args, &block)
      @view.send *args, &block
    end

  end
end