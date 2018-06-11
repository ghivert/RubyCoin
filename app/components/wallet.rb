require './home/variation_cell'

ENTER_KEY = 13

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
      send_transaction if `event.native.keyCode` == ENTER_KEY
    end

    def update_recipient_content(event)
      store.update_recipient_content(`event.native.target.value`)
      send_transaction if `event.native.keyCode` == ENTER_KEY
    end

    def send_rubycoin_transaction(to, value)
      store.contract[:instance].transfer(to, value) do |err, result|
        # Maybe do something one day
      end
    end

    def send_ether_transaction(to, value)
      Web3::Eth.send_transaction({
        from: store.account,
        to: to,
        value: Web3.to_wei(value)
      }) do |error, result|
        # Maybe do something one day
      end
    end

    def send_transaction
      to = store.sending[:to]
      value = store.sending[:value_content]
      if to != "" && value != 0
        if store.sending_rbc?
          send_rubycoin_transaction(to, value)
        elsif store.sending_eth?
          send_ether_transaction(to, value)
        end
      end
    end

    def render
      div.wallet do
        div.card do
          div.card_header__variations.wallet_header do
            component Components::Home::VariationCell.new(
              "#{store.rubycoin_balance.to_s(10)} RBC",
              "On your account"
            )
            div style: "border-right: 1px solid rgba(0, 40, 100, 0.12);"
            component Components::Home::VariationCell.new(
              "#{store.ethereum_balance.to_s(10)} ETH",
              "On your account"
            )
          end
        end
        div.card.send_coins do
          div.card_header do
            "Send coins"
          end
          div.send_coins do
            send_coin_choice
            div style: "border-right: 1px solid rgba(0, 40, 100, 0.12);"
            sender_form
          end
        end
      end
    end

    def send_coin_choice
      div.send_coins__coins_selector.flex_1 do
        span.clickable.btn class: store.sending_eth? ? "active" : "",
          onclick: method(:activate_eth) do
          text "Ether"
        end
        span.clickable.btn class: store.sending_rbc? ? "active" : "",
          onclick: method(:activate_rbc) do
          text "Rubycoin"
        end
      end
    end

    def sender_form
      div.sender.flex_1 do
        div.sender_inside do
          form_header
          input_field label: "Amount",
            type: "number",
            placeholder: "123.456",
            method: :update_value_content,
            value: store.sending[:value_content]
          input_field label: "To",
            type: "text",
            placeholder: "0xcbcb6bd2a1e6085584e323edafb5cf9bb8d77e44",
            method: :update_recipient_content,
            value: store.sending[:to]
          form_submit
        end
      end
    end

    def form_header
      div.padding_6 do
        span do
          "Send some #{store.sending_eth? ? "Ether" : "Rubycoin"}!"
        end
      end
    end

    def input_field(options)
      div.padding_6 do
        label do
          text options[:label]
          input.send_amount_field type: options[:type],
            placeholder: options[:placeholder],
            onkeyup: method(options[:method]),
            value: options[:value]
        end
      end
    end

    def form_submit
      div.padding_6 do
        div class: "btn btn_outline_primary btn_sm",
          onclick: method(:send_transaction) do
          "Send!"
        end
      end
    end
  end
end
