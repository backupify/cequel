class CommentCounts < CequelCQL2::Model::Counter

  key :blog_id, :int
  columns :uuid

  self.default_batch_size = 2

end
