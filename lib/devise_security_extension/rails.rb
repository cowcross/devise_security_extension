module DeviseSecurityExtension
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_controller) do
      include DeviseSecurityExtension::Controllers::Helpers
    end
    
    if defined?(ActiveSupport::Reloader)
      ActiveSupport::Reloader
    else
      ActionDispatch::Reloader
    end.to_prepare do
      DeviseSecurityExtension::Patches.apply
    end
 
    # rails_reloader_klass.to_prepare do
    #   DeviseSecurityExtension::Patches.apply
    # end
  end
end
