class Alert < ActiveRecord::Base

  belongs_to :location
  belongs_to :email_callback

  validates :times,
    presence: true,
    numericality: {
      greater_than: 0,
      if: lambda { times.present? }
    }
  validates :code_is_not, presence: true
  validates :email_callback_id, presence: true

  def conditions_met?
    pings = location.pings.order { performed_at.desc }.limit times
    pings.size == times && pings.all? { |p| p.response_status_code != code_is_not }
  end

  def deliver!
    Mailer.notification(self).deliver
  end

  def to_presenter(view)
    Presenter.new self, view
  end

end

require 'alert/mailer'
require 'alert/presenter'