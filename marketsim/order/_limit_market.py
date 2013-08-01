from marketsim import combine, meta, types, _, registry, bind, Side

from _limit import LimitFactory
from _cancel import Cancel
from _base import Base


class LimitMarket(Base):
    """ This a combination of a limit order and a cancel order sent immediately
    It works as a market order in sense that it is not put into the order queue 
    but can be matched (as a limit order) 
    only if there are orders with suitable price in the queue
    """
    
    def __init__(self, side, price, volume):
        """ Initializes order with 'price' and 'volume'
        'limitOrderFactory' tells how to create limit orders
        """
        Base.__init__(self, side, volume)
        # we create a limit order
        self._order = LimitFactory(side)(price, volume)
        # translate its events to our listeners
        self._order.on_matched += self.on_matched.fire
        #self._order.on_cancelled += self.on_cancelled.fire
        self._order.on_cancelled += _(self)._onCancelled
        
    def _onCancelled(self, order):
        self.on_cancelled.fire(self)
        
    def processIn(self, orderBook):
        orderBook.process(self._order)
        orderBook.process(Cancel(self._order))
        
    @property 
    def volume(self):
        return self._order.volume 
    
    @property
    def PnL(self):
        return self._order.PnL
    
    @staticmethod
    def Buy(price, volume): return LimitMarket(Limit.Buy, price, volume)
    
    @staticmethod
    def Sell(price, volume): return LimitMarket(Limit.Sell, price, volume)

class Factory(types.IOrderGenerator, combine.SidePriceVolume):
    
    def __call__(self):
        params = combine.SidePriceVolume.__call__(self)
        return LimitMarket(*params) if params is not None else None

    
@registry.expose(alias=['LimitMarket'])
@meta.sig(args=(Side,), rv=meta.function((types.Price,), types.IOrder))
def LimitMarketFactory(side):
    return bind.Construct(LimitMarket, side)

LimitMarketFactory.__doc__ = LimitMarket.__doc__

