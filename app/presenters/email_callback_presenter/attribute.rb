class EmailCallbackPresenter
  class Attribute < Poser::Presenter::Attribute

    delegate :email_callback, to: :presenter

  end
end