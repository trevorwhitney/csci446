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
    assert_equal "has already been taken", article.errors[:title].join(';')
  end

  test "article should increment edits when saved" do
    article = articles(:one)
    edits = article.edits + 1
    assert article.save
    assert_equal article.edits, edits
  end
end
