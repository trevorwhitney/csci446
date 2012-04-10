require 'integer_to_word'

class User < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
	acts_as_authentic do |c|
    c.merge_validates_length_of_login_field_options( 
      :length => { :minimum => 6},
      :message => "is too short (minimum is 6 characters)." )
    c.merge_validates_length_of_password_field_options(
      :length => { :minimum => 6 },
      :message => "is too short (minimum is 6 characters)." )
    c.merge_validates_confirmation_of_password_field_options(
      :message => "doesn't match confirmation."
      )
  end

  validates_presence_of :first_name, :last_name, :email, 
    :message => "can't be blank."


  has_many :assignments
  has_many :roles, :through => :assignments
  has_many :games

  has_attached_file :photo, styles: { small: "300x300#" },
    url: "users/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/users/:id/:style/:basename.:extension"

  before_create :set_default_role

  def self.all_users(page)
    User.paginate :per_page => 10, :page => page,
      :order => "last_name ASC"
  end

  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end

  def role(id)
    self.roles << Role.find(id)
  end

  def role_ids
    roles.map do |role|
      role.id
    end
  end

  def is_admin?
    role_symbols.include? :administrator
  end

  def full_name
    [first_name, last_name].compact.join(' ');
  end

  def last_login(current_time)
    now = current_time.strftime("%s").to_i
    if last_login_at.nil?
      return "Never"
    else
      last_login = last_login_at.strftime("%s").to_i
    end

    minute = 1.minute.to_i
    hour = 1.hour.to_i
    day = 1.day.to_i
    week = 1.week.to_i
    month = 1.month.to_i
    year = 1.year.to_i

    time_since_last_login = now - last_login

    if time_since_last_login < minute
      last_login_str = "Less than a minute ago"
    elsif time_since_last_login < hour
      minutes_ago = time_since_last_login/minute
      last_login_str = time_ago_string(minutes_ago, "minute")
    elsif time_since_last_login < day
      yesterday = current_time.yesterday.strftime("%s").to_i
      if time_since_last_login >= yesterday
        last_login_str = "Yesterday"
      else
        hours_ago = time_since_last_login/hour
        last_login_str = time_ago_string(hours_ago, "hour")
      end
    elsif time_since_last_login < week
      days_ago = time_since_last_login/day
      if days_ago <= 1
        last_login_str = "Yesterday"
      else
        last_login_str = time_ago_string(days_ago, "day")
      end
    elsif time_since_last_login < month
      weeks_ago = time_since_last_login/week
      last_login_str = time_ago_string(weeks_ago, "week")
    elsif time_since_last_login < year
      months_ago = time_since_last_login/month
      last_login_str = time_ago_string(months_ago, "month")
    else
      last_login_str = "Over a year ago"
    end

  end

  def percent_of_games_rated
    rated = Game.where("user_id = #{self.id} AND rating_id != 0").count * 1.0
    total = self.games.size * 1.0

    if total == 0
      0
    else
      ((rated/total) * 100).to_i
    end
  end


  private

  def time_ago_string(time_ago, singular_unit)
    string = pluralize(time_ago, singular_unit) + " ago"
    string.gsub(/\d+/) { |num| num.to_i.to_word }.humanize
  end

  def set_default_role
    self.roles << Role.find_by_name("Member") if self.roles.blank?
  end
  
end
