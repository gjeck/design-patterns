class Stock
    attr_reader :name, :market

    def initialize(name, market)
        @name = name 
        @market = market
    end

    def key
        "#{market}:#{name}"
    end
end

class Portfolio
    attr_reader :store
    
    def initialize(store={})
        @store = store
    end

    def buy(stock, count)
        @store[stock.key] = @store.fetch(stock.key, 0) + count
    end

    def sell(stock, count)
        @store[stock.key] = @store.fetch(stock.key, 0) - count
    end

end

class SellStock
    attr_reader :stock, :count

    def initialize(stock, count, portfolio)
        @stock = stock
        @count = count
        @portfolio = portfolio
    end

    def execute
        @portfolio.sell(@stock, @count)
    end

    def unexecute
        @portfolio.buy(@stock, @count)
    end
end

class BuyStock
    attr_reader :stock, :count

    def initialize(stock, count, portfolio)
        @stock = stock
        @count = count
        @portfolio = portfolio
    end

    def execute
        @portfolio.buy(@stock, @count)
    end

    def unexecute
        @portfolio.sell(@stock, @count)
    end
end

class Broker
    attr_reader :orders

    def initialize(orders=[])
        @orders = orders
    end

    def take_order(*order)
        order.each {|o| @orders << o}
    end

    def place_orders()
        @orders.each {|o| o.execute}
    end

    def undo_orders()
        @orders.reverse.each {|o| o.unexecute}
    end
end
