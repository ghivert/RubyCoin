module Components
  class Footer
    include Inesita::Component

    def render
      footer do
        div.container.flex.mobile_column do
          div.flex_1.flex do
            p style: "white-space: pre;" do
              "Copyright © 2018 Guillaume Hivert. Theme heavily inspired by "
            end
            a href: "https://tabler.github.io/tabler",
              target: "_blank",
              onclick: -> (event) {} do
              "Tabler"
            end
            p { "." }
          end
          div.mobile_top_padding.flex style: "align-items: center;" do
            a href: "https://www.coindesk.com/price",
              target: "_blank",
              style: "padding-right: 12px;",
              onclick: -> (event) {} do
              "Powered by CoinDesk"
            end
            a.btn.btn_outline_primary.btn_sm href: "https://github.com/ghivert/RubyCoin",
              target: "_blank",
              onclick: -> (event) {} do
              "Source code"
            end
          end
        end
      end
    end
  end
end
