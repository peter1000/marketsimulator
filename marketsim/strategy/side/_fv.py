from marketsim import (Side, registry, meta, observable, orderbook, ops, _, types)

import _wrap

class FundamentalValue(ops.Observable[Side]):
    
    def getImpl(self):
        return  (observable.BidPrice(self.orderBook) > self.fundamentalValue)[
                    ops.constant(Side.Sell), 
                    (observable.AskPrice(self.orderBook) < self.fundamentalValue)[
                        ops.constant(Side.Buy), 
                        ops._None[Side]()
                    ]                
                ]
        
_wrap.function(FundamentalValue, ['Fundamental value side'], 
                 """ If *fundamentalValue* > bid price then sells, 
                     if *fundamentalValue* < ask price then buys
                 """, 
                 [
                    ('fundamentalValue','ops.constant(200.)',  'types.IFunction[float]'),
                    ('orderBook',       'orderbook.OfTrader()','types.IOrderBook'),
                 ], globals())    

