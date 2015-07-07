require 'test/unit'
require_relative 'gui_command'
require_relative 'stock_command'

class GuiTest < Test::Unit::TestCase
    def setup
        @some_button_action = ''
        @button = GuiRuby::Button.new do
            @some_button_action = 'button_action!'
        end

        @some_checkbox_action = ''
        @checkbox = GuiRuby::Checkbox.new do
            @some_checkbox_action = 'checkbox_action!'
        end

        @some_slider_action = ''
        @slider = GuiRuby::Slider.new do
            @some_slider_action = 'slider_action!'
        end
    end

    def test_button
        @button.pressed
        assert_equal('button_action!', @some_button_action)
    end

    def test_checkbox
        assert_equal(@checkbox.checked, false)
        @checkbox.pressed
        assert_equal(@checkbox.checked, true)
        assert_equal('checkbox_action!', @some_checkbox_action)
    end

    def test_slider
        assert_equal(@slider.value, 0)
        @slider.set_value(0.5)
        assert_equal(@slider.value, 0.5)
        assert_equal('slider_action!', @some_slider_action)
    end
end

class StockTest < Test::Unit::TestCase
    def setup
        @tesla_stock = Stock.new('TSLA', :nasdaq)
        @google_stock = Stock.new('GOOG', :nasdaq)

        @portfolio = Portfolio.new
        @buy_tesla_order = BuyStock.new(@tesla_stock, 100, @portfolio)
        @sell_tesla_order = SellStock.new(@tesla_stock, 50, @portfolio)
        @buy_google_order = BuyStock.new(@google_stock, 200, @portfolio)
        @sell_google_order = SellStock.new(@google_stock, 100, @portfolio)

        @broker = Broker.new
    end

    def test_broker_orders
        @broker.take_order(
            @buy_tesla_order,
            @buy_google_order,
            @sell_tesla_order
        )
        @broker.place_orders
        expected = [
            @buy_tesla_order,
            @buy_google_order,
            @sell_tesla_order
        ]
        assert_equal(expected, @broker.orders)
    end

    def test_buy_and_sell
        @broker.take_order(
            @buy_tesla_order,
            @buy_google_order,
            @sell_tesla_order
        )
        @broker.place_orders
        assert_equal(50, @portfolio.store[@tesla_stock.key])
        assert_equal(200, @portfolio.store[@google_stock.key])
    end

    def test_undo
        @broker.take_order(
            @buy_tesla_order,
            @buy_google_order,
        )
        @broker.place_orders
        @broker.undo_orders
        assert_equal(0, @portfolio.store[@tesla_stock.key])
        assert_equal(0, @portfolio.store[@google_stock.key])
    end
end
