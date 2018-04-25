class Router
  include Inesita::Router

  def routes
    route '/', to: Components::Home, as: :home
    route '/wallet', to: Components::Wallet, as: :wallet
  end
end
