module Components
  class NavBar
    include Inesita::Component

    def render
      nav.navbar do
        div.container.navbar__content do
          icon icon_name: :home, label: "Home", url: :home
          # icon icon_name: :credit_card, label: "Wallet", url: :wallet
        end
      end
    end

    private

    def icon(opts)
      a href: router.url_for(opts[:url]),
        class: class_names(active: router.current_url?(opts[:url])) do
        i.feather.send("icon_#{opts[:icon_name].to_s}")
        text opts[:label]
      end
    end
  end
end
