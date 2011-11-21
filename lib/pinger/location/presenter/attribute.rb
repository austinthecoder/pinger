class Location
  class Presenter
    class Attribute < Poser::Presenter::Attribute

      delegate :location, to: :presenter

    end
  end
end