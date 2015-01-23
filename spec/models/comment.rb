class Comment
  include CequelCQL2::Model

  key :id, :uuid
  column :body, :text

  private

  def generate_key
    SimpleUUID::UUID.new
  end
end
