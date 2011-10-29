class AlertPresenter
  class Attribute < Poser::Presenter::Attribute

    delegate :alert, to: :presenter

  end
end