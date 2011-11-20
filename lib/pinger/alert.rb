require 'alert/record'

class Alert

  class << self
    def build(attrs)
      Record.new attrs
    end

    delegate :joins, :scoped, :unscoped, :table_name,
      :to => Record
  end

end

require 'alert/presenter'