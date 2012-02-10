require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  fixtures :articles

  test "article fields must not be empty" do
    article = Article.new
    assert article.invalid?
    assert article.errors[:title].any?
    assert article.errors[:body].any?
    assert article.errors[:author_id].any?
  end

  test "article not valid without a unique title" do
    article = Article.new(:title => articles(:one).title,
      :body => articles(:one).body,
      :author_id => articles(:one).author_id
    )
    assert !article.save, "#{article.title} should not be a unique title"
  end
end
