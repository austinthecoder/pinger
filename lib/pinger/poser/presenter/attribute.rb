module Poser
  class Presenter
    class Attribute < Struct.new(:presenter)

      include Comparable

      delegate :form_builder, :render,
        to: :presenter

      delegate :text_field, :select,
        to: :form_builder

      def <=>(other)
        presenter <=> other.presenter
      end

    end
  end
end