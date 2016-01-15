module MessagesHelper
  def recipients_options
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}' data-img-src='#{avatar_url_for user}'>#{user.name}</option>"
    end
    s.html_safe
  end
end
