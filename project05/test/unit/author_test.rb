require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  
  setup do
    @valid_photo = File.new("test/fixtures/onion.jpg")
    @invalid_photo = File.new("test/fixtures/lena.bmp")
  end

  teardown do
    @valid_photo.close
    @invalid_photo.close
  end

  test "name_should_not_include_pat" do
    author = Author.new name: "Pat"
    author.photo = @valid_photo
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
    author.photo = @valid_photo
    assert author.valid?
  end

  test "photo_should_be_present" do
    author = Author.new name: "Trevor"
    author.photo = @valid_photo

    assert author.valid?
  end

  test "photo_should_be_jpeg_or_png" do
    author = Author.new name: "Trevor"
    author.photo = @invalid_photo

    assert author.invalid?

    author.photo = @valid_photo

    assert author.valid?
  end

end
