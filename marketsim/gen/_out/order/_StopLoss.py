# generated with class generator.python.order_factory$Factory
from marketsim import registry
from marketsim.gen._out._iobservable._iobservableiorder import IObservableIOrder
from marketsim.gen._out._ifunction._ifunctionfloat import IFunctionfloat
from marketsim.gen._out._iorder import IOrder
from marketsim.gen._out._observable._observableiorder import ObservableIOrder
@registry.expose(["Order", "StopLoss"])
class StopLoss_IObservableIOrderFloat(ObservableIOrder,IObservableIOrder):
    """ **Factory creating StopLoss orders**
    
    
      StopLoss order is initialised by an underlying order and a maximal acceptable loss factor.
      It keeps track of position and balance change induced by trades of the underlying order and
      if losses from keeping the position exceed certain limit (given by maximum loss factor),
      the meta order clears its position.
    
    Parameters are:
    
    **proto**
    	 underlying orders to create 
    
    **maxloss**
    	 maximal acceptable loss factor 
    """ 
    def __init__(self, proto = None, maxloss = None):
        from marketsim.gen._out._iorder import IOrder
        from marketsim.gen._out.order._limit import Limit_SideFloatFloat as _order_Limit_SideFloatFloat
        from marketsim.gen._out._constant import constant_Float as _constant_Float
        from marketsim.gen._out._observable._observableiorder import ObservableIOrder
        from marketsim import deref_opt
        ObservableIOrder.__init__(self)
        self.proto = proto if proto is not None else deref_opt(_order_Limit_SideFloatFloat())
        self.maxloss = maxloss if maxloss is not None else deref_opt(_constant_Float(0.1))
    
    @property
    def label(self):
        return repr(self)
    
    _properties = {
        'proto' : IObservableIOrder,
        'maxloss' : IFunctionfloat
    }
    
    
    def on_proto_set(self, value):
        from marketsim import event
        event.subscribe_field(self, 'proto', value)
    
    
    
    
    def __repr__(self):
        return "StopLoss(%(proto)s, %(maxloss)s)" % dict([ (name, getattr(self, name)) for name in self._properties.iterkeys() ])
    
    def bind_ex(self, ctx):
        if self.__dict__.get('_bound_ex', False): return
        self.__dict__['_bound_ex'] = True
        if self.__dict__.get('_processing_ex', False):
            raise Exception('cycle detected')
        self.__dict__['_processing_ex'] = True
        self.__dict__['_ctx_ex'] = ctx.updatedFrom(self)
        if hasattr(self, '_internals'):
            for t in self._internals:
                v = getattr(self, t)
                if type(v) in [list, set]:
                    for w in v: w.bind_ex(self.__dict__['_ctx_ex'])
                else:
                    v.bind_ex(self.__dict__['_ctx_ex'])
        self.proto.bind_ex(self._ctx_ex)
        self.maxloss.bind_ex(self._ctx_ex)
        self.bind_impl(self.__dict__['_ctx_ex'])
        if hasattr(self, '_subscriptions'):
            for s in self._subscriptions: s.bind_ex(self.__dict__['_ctx_ex'])
        self.__dict__['_processing_ex'] = False
    
    def reset_ex(self, generation):
        if self.__dict__.get('_reset_generation_ex', -1) == generation: return
        self.__dict__['_reset_generation_ex'] = generation
        if self.__dict__.get('_processing_ex', False):
            raise Exception('cycle detected')
        self.__dict__['_processing_ex'] = True
        if hasattr(self, '_internals'):
            for t in self._internals:
                v = getattr(self, t)
                if type(v) in [list, set]:
                    for w in v: w.reset_ex(generation)
                else:
                    v.reset_ex(generation)
        self.proto.reset_ex(generation)
        self.maxloss.reset_ex(generation)
        self.reset()
        if hasattr(self, '_subscriptions'):
            for s in self._subscriptions: s.reset_ex(generation)
        self.__dict__['_processing_ex'] = False
    
    def typecheck(self):
        from marketsim import rtti
        from marketsim.gen._out._iorder import IOrder
        from marketsim.gen._out._iobservable._iobservableiorder import IObservableIOrder
        from marketsim.gen._out._ifunction._ifunctionfloat import IFunctionfloat
        rtti.typecheck(IObservableIOrder, self.proto)
        rtti.typecheck(IFunctionfloat, self.maxloss)
    
    def registerIn(self, registry):
        if self.__dict__.get('_id', False): return
        self.__dict__['_id'] = True
        if self.__dict__.get('_processing_ex', False):
            raise Exception('cycle detected')
        self.__dict__['_processing_ex'] = True
        registry.insert(self)
        self.proto.registerIn(registry)
        self.maxloss.registerIn(registry)
        if hasattr(self, '_subscriptions'):
            for s in self._subscriptions: s.registerIn(registry)
        if hasattr(self, '_internals'):
            for t in self._internals:
                v = getattr(self, t)
                if type(v) in [list, set]:
                    for w in v: w.registerIn(registry)
                else:
                    v.registerIn(registry)
        self.__dict__['_processing_ex'] = False
    
    def __call__(self, *args, **kwargs):
        from marketsim.gen._intrinsic.order.meta.stoploss import Order_Impl
        proto = self.proto()
        if proto is None: return None
        
        maxloss = self.maxloss()
        if maxloss is None: return None
        
        return Order_Impl(proto, maxloss)
    
    def bind_impl(self, ctx):
        pass
    
    def reset(self):
        pass
    
def StopLoss(proto = None,maxloss = None): 
    from marketsim.gen._out._iorder import IOrder
    from marketsim.gen._out._iobservable._iobservableiorder import IObservableIOrder
    from marketsim.gen._out._ifunction._ifunctionfloat import IFunctionfloat
    from marketsim import rtti
    if proto is None or rtti.can_be_casted(proto, IObservableIOrder):
        if maxloss is None or rtti.can_be_casted(maxloss, IFunctionfloat):
            return StopLoss_IObservableIOrderFloat(proto,maxloss)
    raise Exception('Cannot find suitable overload for StopLoss('+str(proto) +':'+ str(type(proto))+','+str(maxloss) +':'+ str(type(maxloss))+')')
