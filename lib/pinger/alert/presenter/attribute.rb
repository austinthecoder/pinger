class Alert
  class Presenter
    class Attribute < Poser::Presenter::Attribute

      delegate :alert, to: :presenter

    end
  end
end