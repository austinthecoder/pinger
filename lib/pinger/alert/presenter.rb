class Alert
  class Presenter < Poser::Presenter

    presents :alert

    def location
      @location ||= LocationAttribute.new(self)
    end

    def code_is_not
      @code_is_not ||= CodeIsNotAttribute.new(self)
    end

    def times
      @times ||= TimesAttribute.new(self)
    end

    def email_callback
      @email_callback ||= EmailCallbackAttribute.new(self)
    end

    def location_options_for_select
      locations.map { |l| [l.title, l.id] }
    end

    def email_callback_options_for_select
      EmailCallback.order { label.asc }.map { |ec| [ec.label, ec.id] }
    end

    # TODO: test
    attr_accessor :form_builder

    # TODO: test
    def form
      form_for alert do |f|
        self.form_builder = f
        yield
        self.form_builder = nil
      end
    end

  end
end

require 'alert/presenter/code_is_not_attribute'
require 'alert/presenter/email_callback_attribute'
require 'alert/presenter/location_attribute'
require 'alert/presenter/times_attribute'