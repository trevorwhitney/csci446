module ArticlesHelper

  def back_to_articles_link
    link_to image_tag('arrow_left.png', id: 'back') + 'list all articles', 
      articles_path, :title => 'Return to all articles list'
  end

  def edit_link
    link_to image_tag('page_edit.png', :id => 'edit') + 'edit', edit_article_path(@article),
      :title => 'Edit this article'
  end

  def delete_link
    link_to image_tag('bin.png', :id => 'delete') + 'delete', @article,
      :title => 'Delete this article', :method => :delete, :confirm => 'Are you sure?'
  end

  def mailto_link
    mail_to nil, image_tag('email.png', :id => 'email') + 'email',
      :title => 'Email this article to a friend', :subject => @article.title,
      :body => article_url(@article)
  end

  def back_link
    link_to image_tag('arrow_left.png', :id => 'back') + 'back', session[:article_previous],
      :title => 'Return to previous page'
  end

end
