class Router
  include Inesita::Router

  def routes
    route '/', to: Home
    route '/wallet', to: Wallet
  end
end
