require 'rails/observers/railtie'

module CequelCQL2

  module Model

    class Railtie < Rails::Railtie

      config.cequel = CequelCQL2::Model

      initializer "cequel.configure_rails" do
        config_path = Rails.root.join('config/cequel.yml').to_s

        if File.exist?(config_path)
          yaml = YAML::load(ERB.new(IO.read(config_path)).result)[Rails.env]
          CequelCQL2::Model.configure(yaml.symbolize_keys) if yaml
        end

        CequelCQL2::Model.logger = Rails.logger
      end

      initializer "cequel.instantiate_observers" do
        config.after_initialize do
          ::CequelCQL2::Model.instantiate_observers

          ActionDispatch::Callbacks.to_prepare do
            ::CequelCQL2::Model.instantiate_observers
          end
        end
      end
    end

  end

end
