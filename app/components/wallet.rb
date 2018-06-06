require './home/variation_cell'

module Components
  class Wallet
    include Inesita::Component

    def render
      div.wallet do
        div.card do
          div.card_header__variations.wallet_header do
            component Components::Home::VariationCell.new("#{store.rubycoin_balance.to_s(10)} RBC", "On your account")
            div style: "border-right: 1px solid rgba(0, 40, 100, 0.12);"
            component Components::Home::VariationCell.new("#{store.ethereum_balance.to_s(10)} ETH", "On your account")
          end
        end
        div.card.card_wallet__transactions do
          div do
            text store.ethereum_balance.to_s(17)
          end
        end
      end
    end
  end
end
