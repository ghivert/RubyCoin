module Components
  class Wallet
    include Inesita::Component

    def render
      div.wallet do
        div.card.card_wallet__balance do
          text store.balance_of_rubycoin.to_s(10)
        end
        div.card.card_wallet__transactions do
          text store.balance_of_rubycoin.to_s(2)
        end
      end
    end
  end
end
