class EmailCallback < ActiveRecord::Base

  validates :to, :presence => true
  validates :label, :presence => true

end
