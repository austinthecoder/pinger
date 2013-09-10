class EmailCallbacksController < ApplicationController

  respond_to :html

  helper_method :email_callback

  def create
    if email_callback.add
      flash.notice = "Email callback was added."
      redirect_to email_callbacks_url
    else
      render :new
    end
  end

  def update
    if email_callback.modify params[:email_callback]
      flash.notice = "Email callback was saved"
      redirect_to email_callbacks_url
    else
      render :edit
    end
  end

  def destroy
    email_callback.destroy
    respond_with email_callback
  end

##################################################

  # TODO: test
  def email_callback
    @email_callback ||= if params[:id]
      account.fetch_email_callback params[:id]
    else
      account.new_email_callback params[:email_callback]
    end
  end

  def email_callbacks
    @email_callbacks ||= account.email_callbacks
  end

end
