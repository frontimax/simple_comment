class Segment < ApplicationRecord
  
  validates :title, :presence => true, :uniqueness => true
  validates :content, :presence => true
  
  belongs_to :user
  belongs_to :parent, :polymorphic => true
  has_many :comments, :foreign_key => 'parent_id', :class_name => 'Comment', :dependent => :destroy

  scope :active_segments, -> do
    where(active: true)
  end

  scope :inactive_segments, -> do
    where(active: false)
  end
  
  def preview(size=250)
    self.content.truncate(size, :ommision => "...")
  end

  private
  
end
