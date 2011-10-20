class EmailCallbacksController < ApplicationController

  respond_to :html

  expose :email_callback

  def create
    current_user.save_email_callback email_callback
    respond_with email_callback, :location => email_callbacks_url
  end

end
