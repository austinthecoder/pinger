class LocationPresenter
  class Attribute < Poser::Presenter::Attribute

    delegate :location, to: :presenter

  end
end