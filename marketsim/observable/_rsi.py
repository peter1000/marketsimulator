from marketsim import (event, bind, meta, types, 
                       defs, _, ops, registry, orderbook, mathutils)

from _orderbook import MidPrice
from _ewma import EWMA
from _computed import OnEveryDt

from marketsim.gen._out.observable._DownMovements import DownMovements
from marketsim.gen._out.observable._UpMovements import UpMovements

import fold

from marketsim.gen._out.observable._Max import Max

import _wrap 
from marketsim.types import *

class RSI(ops.Function[float]):
    
    def getDefinitions(self):
        return { 
            'rs' : (EWMA(UpMovements(MidPrice(self.orderBook), self.timeframe), self.alpha) /
                    EWMA(DownMovements(MidPrice(self.orderBook), self.timeframe), self.alpha))
        }
        
    def getImpl(self):
        return ops.constant(100.) - (ops.constant(100.) / (ops.constant(1.) + _.rs))

    def __repr__(self):
        return self.label
    
    @property    
    def label(self):
        return 'RSI_{%g}(%s)' % (self.timeframe, self.orderBook.label)
    
_wrap.function(RSI, ["Asset's", "Relative strength index"],
    """ Relative strength index
    """,               
    [
        ('orderBook', 'orderbook.OfTrader()',   'IOrderBook'),
        ('timeframe', 1.,                       'non_negative'),
        ('alpha',     0.15,                     'positive')
    ], globals())


