# generated with class generator.python.order_factory$Factory
from marketsim import registry
from marketsim.gen._out._iobservable._iobservableiorder import IObservableIOrder
from marketsim.gen._out._ifunction._ifunctionfloat import IFunctionfloat
from marketsim.gen._out._iorder import IOrder
from marketsim.gen._out._observable._observableiorder import ObservableIOrder
@registry.expose(["Order", "LimitSigned"])
class LimitSigned_FloatFloat(ObservableIOrder,IObservableIOrder):
    """ **Factory creating limit orders**
    
    
      Limit orders ask to buy or sell some asset at price better than some limit price.
      If a limit order is not competely fulfilled
      it remains in an order book waiting to be matched with another order.
    
    Parameters are:
    
    **signedVolume**
    	signed volume
    
    **price**
    	 function defining price of orders to create 
    """ 
    def __init__(self, signedVolume = None, price = None):
        from marketsim import rtti
        from marketsim.gen._out._iorder import IOrder
        from marketsim.gen._out._constant import constant_Float as _constant_Float
        from marketsim.gen._out._observable._observableiorder import ObservableIOrder
        from marketsim import deref_opt
        ObservableIOrder.__init__(self)
        self.signedVolume = signedVolume if signedVolume is not None else deref_opt(_constant_Float(1.0))
        self.price = price if price is not None else deref_opt(_constant_Float(100.0))
        rtti.check_fields(self)
    
    @property
    def label(self):
        return repr(self)
    
    _properties = {
        'signedVolume' : IFunctionfloat,
        'price' : IFunctionfloat
    }
    
    
    
    
    
    
    def __repr__(self):
        return "LimitSigned(%(signedVolume)s, %(price)s)" % dict([ (name, getattr(self, name)) for name in self._properties.iterkeys() ])
    
    def bind_ex(self, ctx):
        if hasattr(self, '_bound_ex'): return
        self._bound_ex = True
        if hasattr(self, '_processing_ex'):
            raise Exception('cycle detected')
        self._processing_ex = True
        self._ctx_ex = ctx.updatedFrom(self)
        if hasattr(self, '_internals'):
            for t in self._internals:
                v = getattr(self, t)
                if type(v) in [list, set]:
                    for w in v: w.bind_ex(self._ctx_ex)
                else:
                    v.bind_ex(self._ctx_ex)
        if hasattr(self, 'bind_impl'): self.bind_impl(self._ctx_ex)
        self.signedVolume.bind_ex(self._ctx_ex)
        self.price.bind_ex(self._ctx_ex)
        if hasattr(self, '_subscriptions'):
            for s in self._subscriptions: s.bind_ex(self._ctx_ex)
        delattr(self, '_processing_ex')
    
    def __call__(self, *args, **kwargs):
        from marketsim.gen._out._side import Side
        from marketsim.gen._intrinsic.order.limit import Order_Impl
        signedVolume = self.signedVolume()
        if signedVolume is None: return None
        side = Side.Buy if signedVolume > 0 else Side.Sell
        volume = abs(signedVolume)
        if abs(volume) < 1: return None
        volume = int(volume)
        price = self.price()
        if price is None: return None
        
        return Order_Impl(side, price, volume)
    
def LimitSigned(signedVolume = None,price = None): 
    from marketsim.gen._out._ifunction._ifunctionfloat import IFunctionfloat
    from marketsim import rtti
    if signedVolume is None or rtti.can_be_casted(signedVolume, IFunctionfloat):
        if price is None or rtti.can_be_casted(price, IFunctionfloat):
            return LimitSigned_FloatFloat(signedVolume,price)
    raise Exception('Cannot find suitable overload for LimitSigned('+str(signedVolume) +':'+ str(type(signedVolume))+','+str(price) +':'+ str(type(price))+')')
