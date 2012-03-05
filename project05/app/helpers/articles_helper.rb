module ArticlesHelper

  def list_articles_link
    link_to image_tag('arrow_left.png', id: 'back') + 'list all articles', 
      articles_path, :title => 'Return to all articles list'
  end

  def new_article_link
    link_to image_tag('add.png') + 'New Article', new_article_path, 
      :title => "Create a new article"
  end

  def edit_article_link
    link_to image_tag('page_edit.png', :id => 'edit') + 'edit', edit_article_path(@article),
      :title => 'Edit this article'
  end

  def delete_article_link
    link_to image_tag('bin.png', :id => 'delete') + 'delete', @article,
      :title => 'Delete this article', :method => :delete, :confirm => 'Are you sure?'
  end

  def article_mailto_link
    mail_to nil, image_tag('email.png', :id => 'email') + 'email',
      :title => 'Email this article to a friend', :subject => @article.title,
      :body => article_url(@article)
  end

  def article_back_link
    link_to image_tag('arrow_left.png', :id => 'back') + 'back', session[:article_previous],
      :title => 'Return to previous page'
  end

  def article_byline
    author_link = link_to(@article.author.name, @article.author, :title => 'View author')
    "by #{author_link}. #{pluralize(@article.edits, 'edit')} since #{I18n.l @article.created_at.to_date}.".html_safe
  end

  def list_authors_link
    link_to image_tag('user.png', :id => 'users') + 'list all authors', authors_path,
      :title => 'Return to all authors list'
  end

  def author_name(article)
    link_to(truncate(article.author.name, :length => 20), article.author, title: 'View author')
  end

  def author_selection_collection(authors)
    collection_select(:article, :author_id, authors, 
      :id, :name, {:prompt => 'Please select an author...'})
  end

  def create_author_link
    link_to image_tag('add.png') + "Create a new author", 
      new_author_path, title: 'Create an author'
  end

end
