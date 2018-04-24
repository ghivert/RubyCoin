# require Inesita
require 'inesita'
require 'inesita-router'

# require main parts of application
require 'router'
require 'store'

# require all components
require_tree './components'

class Application
  include Inesita::Component

  inject Router
  inject Store

  def render
    div.container do
      component NavBar
      div.app do
        component router
      end
    end
  end
end

# when document is ready render application to <body>
Inesita::Browser.ready? do
  Application.mount_to(Inesita::Browser.body)
end
