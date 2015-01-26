class AssetObserver < CequelCQL2::Model::Observer
  def before_save(asset)
    asset.observed!(:before_save)
  end
end
