class EmailCallback < ActiveRecord::Base

  validates :to,
    presence: true,
    length: {maximum: 255}
  validates :label,
    presence: true,
    uniqueness: true,
    length: {maximum: 255}

  def to_presenter(view)
    EmailCallbackPresenter.new self, view
  end

end
