class Article < Segment
  
  scope :active_segments, -> do
    includes(:comments)
    .where(active: true)
  end

  scope :inactive_segments, -> do
    includes(:comments)
      .where(active: false)
  end
  
  def number_of_comments
    self.comments.active_segments.size
  end
  
end
