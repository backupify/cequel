class Category

  include CequelCQL2::Model
  include CequelCQL2::Model::Dynamic

  key :id, :int
  column :name, :text

end
