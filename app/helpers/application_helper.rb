module ApplicationHelper
  # Method helpers
  def patch_method
    <<-HTML.html_safe
      <input type="hidden" name="_method" value="patch">
    HTML
  end
  
  # AUTH helpers
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

  # Music Model helpers
  def list_of_model_objects(collection, url_method)
    items = collection.order(:name).map { |item| <<-HTML }.join
      <li>#{link_to item.name, self.send(url_method, item)}</li>
    HTML
    
    <<-HTML.html_safe
      <ul>
        #{items}
      </ul>
    HTML
  end
  
  def resource_name(resource, name)
    <<-HTML.html_safe
      <input type="text" name="#{resource}[name]"
        id="#{resource}_name" value="#{name}">
      <label for="#{resource}_name">Name</label>
    HTML
  end
  
  def navigation_footer(links)
    <<-HTML.html_safe
      <h3>Navigate!</h3>
      <ul>
        #{ links.map { |link| "<li>#{link}</li>" }.join }
      </ul>
    HTML
  end
  
end
