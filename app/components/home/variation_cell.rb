module Components
  class Home
    class VariationCell
      include Inesita::Component

      def initialize(price, sub_price)
        @price = price
        @sub_price = sub_price
      end

      def render
        div.card_header__variations__elem.flex_1 do
          span.price { @price }
          br
          span.sub_price { @sub_price }
        end
      end
    end
  end
end
