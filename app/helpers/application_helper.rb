module ApplicationHelper
  def authenticity_token
    <<-HTML.html_safe
      <input type="hidden" name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML
  end
  
  def flash_errors
    errors = flash[:errors].inject('') do |accum, error|
      accum + "<li>#{error}</li>"
    end
    
    <<-HTML.html_safe
      <h3>Errors</h3>
      <ul>
        #{errors}
      </ul>
    HTML
  end
  
  def signed_in_panel
    <<-HTML.html_safe
      <p>You are signed in as #{h(current_user.email)}.</p>
      #{ button_to "Sign out", sign_in_url(current_sign_in), method: :delete }
    HTML
  end
end
