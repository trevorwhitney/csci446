class Product < ActiveRecord::Base
  #scope
  default_scope :order => 'title'

  #associations
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  #validation
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

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
