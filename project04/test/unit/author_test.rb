require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test "name_should_not_include_pat" do
    author = Author.new name: "Pat"
    assert author.invalid?

    author.name = "Patrick"
    assert author.invalid?

    author.name = "John Patrick"
    assert author.invalid?

    author.name = "Valid Author"
    assert author.valid?
  end

  test "name_should_not_be_blank" do
    author = Author.new
    assert author.invalid?

    author.name = "Author Name"
    assert author.valid?
  end
end
