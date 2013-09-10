module DecoratedEmailCallback

  attr_accessor :controller
  attr_accessor :account

  def edit_path
    controller.edit_email_callback_path self
  end

  def delete_path
    controller.delete_email_callback_path self
  end

  def add
    account.add_email_callback self
  end

  def modify(attrs)
    account.modify_email_callback self, attrs
  end

end