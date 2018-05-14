module Components
  class Footer
    include Inesita::Component

    def render
      footer do
        div.container.flex.mobile_column do
          legal_mentions
          source_and_obligations
        end
      end
    end

    private

    def new_tab_link(params, &block)
      params = { target: "_blank", onclick: -> (event) {} }.merge(params)
      a(params, &block)
    end

    def legal_mentions
      div.flex_1.flex do
        p style: "white-space: pre;" do
          "Copyright © 2018 Guillaume Hivert. Theme heavily inspired by "
        end
        new_tab_link href: "https://tabler.github.io/tabler" do
          "Tabler"
        end
        p { "." }
      end
    end

    def source_and_obligations
      div.mobile_top_padding.flex style: "align-items: center;" do
        new_tab_link href: "https://www.coindesk.com/price",
                     style: "padding-right: 12px;" do
          "Powered by CoinDesk"
        end
        new_tab_link href: "https://github.com/ghivert/RubyCoin",
                     class: "btn btn_outline_primary btn_sm" do
          "Source code"
        end
      end
    end
  end
end
