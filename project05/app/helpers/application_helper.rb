module ApplicationHelper
  def random_message
    messages = [
      "... with a name .com hipsters love!",
      "... what\'s \"Articl\" in Spanish anyway?",
      "... my cousin works for Bit.ly",
      "... not just for the country of Spain",
      "... my favorite radio staion is Last.fm",
      "... all your \"Articl\" are belong to us"
    ]
    messages[rand(messages.size)]
  end

  def article_title(article)
    link_to(truncate(article.title, length: 25), article, title: 'View article')
  end

  def buttons(article)
    buttons = ""
    buttons += link_to image_tag('magnifier.png'), article, :title => 'View article'
    buttons += "\n"
    buttons += link_to image_tag('page_edit.png'), edit_article_path(article), 
      :title => 'Edit article'
    buttons += "\n"
    buttons += link_to image_tag('bin.png'), article, confirm: 'Are you sure?', method: :delete, 
      :title => 'Delete article'
  end

end
