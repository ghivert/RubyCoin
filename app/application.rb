# require Opal
require "opal"

# require Inesita
require "inesita"
require "inesita-router"

# require main parts of application
require "router"
require "store"

require "lib/bitcoin"
require "lib/big_number"
require "lib/web3"

# require all components
require_tree "./components"

class Application
  include Inesita::Component

  inject Router
  inject Store

  def render
    div class: "main" do
      component Components::NavBar
      div.app.container do
        component router
      end
      component Components::Footer
    end
  end
end

# when document is ready render application to <body>
Inesita::Browser.ready? do
  Application.mount_to(Inesita::Browser.body)
end
