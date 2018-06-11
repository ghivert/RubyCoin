require './home/variation_cell'

module Components
  class Wallet
    include Inesita::Component

    def activate_eth
      store.send_eth
    end

    def activate_rbc
      store.send_rbc
    end

    def update_value_content(event)
      store.update_value_content(`event.native.target.value`.to_f)
    end

    def update_recipient_content(event)
      store.update_recipient_content(`event.native.target.value`)
    end

    def render
      div.wallet do
        div.card do
          div.card_header__variations.wallet_header do
            component Components::Home::VariationCell.new("#{store.rubycoin_balance.to_s(10)} RBC", "On your account")
            div style: "border-right: 1px solid rgba(0, 40, 100, 0.12);"
            component Components::Home::VariationCell.new("#{store.ethereum_balance.to_s(10)} ETH", "On your account")
          end
        end
        div.card.send_coins do
          div.card_header do
            "Send coins"
          end
          div.send_coins do
            div.send_coins__coins_selector.flex_1 do
              span.clickable.btn class: store.sending_eth? ? "active" : "", onclick: method(:activate_eth) do
                text "Ether"
              end
              span.clickable.btn class: store.sending_rbc? ? "active" : "", onclick: method(:activate_rbc) do
                text "Rubycoin"
              end
            end
            div style: "border-right: 1px solid rgba(0, 40, 100, 0.12);"
            div.sender.flex_1 do
              div.sender_inside do
                div.padding_6 do
                  span do
                    "Send some #{store.sending_eth? ? "Ether" : "Rubycoin"}!"
                  end
                end
                div.padding_6 do
                  label do
                    text "Amount"
                    input.send_amount_field type: 'number', placeholder: '123.456', onkeyup: method(:update_value_content), value: store.sending[:value_content]
                  end
                end
                div.padding_6 do
                  label do
                    text "To"
                    input.send_address_field type: 'text', placeholder: '0xcbcb6bd2a1e6085584e323edafb5cf9bb8d77e44', onkeyup: method(:update_recipient_content), value: store.sending[:to]
                  end
                end
                div.padding_6 do
                  div class: "btn btn_outline_primary btn_sm", onclick: method(:send_transaction) do
                    "Send!"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
