class EmailCallbacksController < ApplicationController
  respond_to :html

  helper_method :email_callback

  def create
    email_callback.save
    respond_with email_callback, location: email_callbacks_url
  end

  def update
    email_callback.attributes = params[:email_callback]
    email_callback.save
    respond_with email_callback, location: email_callbacks_url
  end

  def destroy
    email_callback.destroy
    respond_with email_callback
  end

  # TODO: test
  def email_callback
    @email_callback ||= begin
      if params[:id]
        EmailCallback.find params[:id]
      else
        EmailCallback.new params[:email_callback]
      end
    end
  end
end
