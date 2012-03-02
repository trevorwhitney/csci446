require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase
  setup do
    @author = authors(:robert)
    @valid_photo = File.new("test/fixtures/onion.jpg")
    @invalid_photo = File.new("test/fixtures/lena.bmp")

    @author.photo = @valid_photo
  end

  teardown do
    @valid_photo.close
    @invalid_photo.close
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create author" do
    assert_difference('Author.count') do
      post(:create, {author: @author.attributes}, {author_previous: articles_path})
    end

    assert_redirected_to articles_path
  end

  test "should show author" do
    get :show, id: @author
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @author
    assert_response :success
  end

  test "should update author" do
    put(:update, {id: @author, author: @author.attributes}, {author_previous: articles_path})
    assert_redirected_to articles_path
  end

  test "should destroy author" do
    assert_difference('Author.count', -1) do
      delete :destroy, id: @author
    end

    assert_redirected_to authors_path
  end
end
