require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do 
    product = Product.new(:title => "My Book Title",
      :description => "yyy",
      :image_url => "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join(';')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join(';')

    product.price = 1
    assert product.valid?, "1 should be a valid price"
  end

  test "image_url" do 
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.jpg 
      http://a.b.c/x/y/z/fred.gif }
    bad = %w{fred.doc fred.gif/more fred.gif.more}

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do 
    product = Product.new(:title => products(:ruby).title,
      :description => "yyy",
      :price => 1,
      :image_url => "fred.gif"
    )

    assert !product.save, "product should not be able to be saved"
    assert_equal "already exists",
      product.errors[:title].join(';')
  end

  test "product title should be at least 10 characters" do 
    product = Product.new(:title => "Not 10",
      :description => "yyy",
      :price => 1,
      :image_url => "fred.gif"
    )

    assert product.invalid?, "\"Not 10\" should not be a valid title"

    product.title = "This title has more than 10 characters"

    assert product.valid?, "#{product.title} should be a valid title"
  end

  def new_product(image_url)
    Product.new(:title => "My Book Title",
      :description => "yyy",
      :price => 1,
      :image_url => image_url
    )
  end
end
