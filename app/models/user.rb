class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  CRUD_ATTR = [
    :name, :email, :active, :country, :country_code, :currency, :currency_code, :created_at, :updated_at,
    :admin_role
  ]
  
  before_save :check_admin
  
  has_many :articles, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :received_comments, :through => :articles, :source => 'comments'
  
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates :country, :presence => true
  validates :country_code, :presence => true
  validates :currency, :presence => true
  validates :currency_code, :presence => true
  
  validates_format_of :email,:with => Devise::email_regexp
  
  
  def check_admin
    if self.name == 'admin'
      self.admin_role = true
      self.active     = true
    end
  end
  
  def show_attributes
    CRUD_ATTR
  end
  
  def self.edit_attributes
    CRUD_ATTR - [:created_at, :updated_at]
  end

  def get_value(attr)
    result =  case attr
                when :active, :admin_role
                  self.active ? "Yes" : "No"
                when :created_at, :updated_at
                  self.send(attr).to_time.strftime("%d.%m.%Y %H:%M")
                else
                  self.send(attr)
              end
  end

  def get_label(attr)
    User.get_label(attr)
  end

  def self.get_label(attr)
    attr.to_s.split('_').map{|a| a.capitalize()}.join(' ')
  end
  
  
  private
  
end
