class NavBar
  include Inesita::Component

  def render
    nav.navbar do
      icon icon_name: :home, label: "Home", url: :home
      icon icon_name: :credit_card, label: "Wallet", url: :wallet
    end
  end

  private

  def icon(opts)
    a href: router.url_for(opts[:url]),
      class: router.current_url?(opts[:url]) ? "active" : "" do
      i.feather.send("icon_#{opts[:icon_name].to_s}")
      text opts[:label]
    end
  end
end
