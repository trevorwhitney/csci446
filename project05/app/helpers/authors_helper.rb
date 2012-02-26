module AuthorsHelper

  def list_authors_link
    link_to image_tag('user.png', :id => 'users') + 'list all authors', authors_path,
      :title => 'Return to all authors list'
  end

  def back_to_articles_link
    link_to image_tag('arrow_left.png', :id => 'back') + 'back to articles', articles_path,
      :title => 'Return to all articles list'
  end

  def back_link
    link_to image_tag('arrow_left.png', :id => 'back') + 'back', session[:author_previous],
      :title => 'Return to previous page'
  end

  def new_author_link
    link_to image_tag('add.png') + 'New Author', new_author_path,
      title: 'Create new author'
  end

  def edit_link
    link_to image_tag('user_edit.png', :id => 'edit_user') + 'edit', edit_author_path(@author),
    title: 'Edit this author'
  end

end
