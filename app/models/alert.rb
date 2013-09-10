class Alert < ActiveRecord::Base

  belongs_to :location
  belongs_to :email_callback

  validates :times, :presence => true, :numericality => {
    :greater_than => 0,
    :if => -> { times.present? }
  }
  validates :code_is_not, :presence => true
  validates :email_callback_id, :presence => true

  class << self
    def all_for_location(location)
      where { |q| q.location_id.eq location.id }
    end
  end

  def deliver!
    Mailer.notification(self).deliver
  end

end