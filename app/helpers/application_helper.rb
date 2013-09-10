module ApplicationHelper

  def main_menu
    [
      ["Add resource", new_resource_path],
      ["Email callbacks", email_callbacks_path],
      ["Alerts", alerts_path]
    ]
  end

  def email_callbacks_menu
    [['Add email callback', new_email_callback_path]]
  end

end
