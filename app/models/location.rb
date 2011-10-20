class Location < ActiveRecord::Base
  
  extend Paginates
  include Pingable

  has_many :alerts

  validates :seconds,
    :presence => true,
    :numericality => {:if => lambda { seconds.present? }}
  validates :http_method, :format => /(get|post)/i
  validates :url,
    :presence => true,
    :format => {
      :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
      :if => lambda { url.present? }
    }
  validates :title, :presence => true

  def perform_request
    HTTParty.send http_method, url
  end

  def http_method=(value)
    self[:http_method] = value ? value.to_s.downcase : nil
  end

end


