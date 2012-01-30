class Product < ActiveRecord::Base
  validates :title, :description, :image_url, :presence => true
  validates :title, :length => { :minimum => 10, 
    :message => "must be at least 10 characters long" }
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => { 
    :message => "already exists" }
  validates :image_url, :format => {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPG, or PNG image.'
  }
end
