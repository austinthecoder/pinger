class ApplicationController < ActionController::Base

  protect_from_forgery

  TODO: test
  def account
    @account ||= THE_ACCOUNT.extend(DecoratedAccount).tap do |account|
      account.controller = self
    end
  end

  # delegate :locations, :to => :account
  # delegate :paginated_locations, :to => :account
  # delegate :email_callbacks, :to => :account
  # delegate :alerts, :to => :account

end
