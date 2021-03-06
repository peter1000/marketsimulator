# generated with class generator.python.intrinsic_function$Import
from marketsim import registry
from marketsim.gen._out._itimeserie import ITimeSerie
from marketsim.gen._out._iorderbook import IOrderBook
from marketsim.gen._intrinsic.orderbook.remote import Remote_Impl
from marketsim import listOf
from marketsim.gen._out._itwowaylink import ITwoWayLink
@registry.expose(["Asset", "Remote"])
class Remote_IOrderBookITwoWayLinkListITimeSerie(IOrderBook,Remote_Impl):
    """ **Represent an *orderbook* from point of view of a remote trader connected**
    
     to the market by means of a *link* that introduces some latency in information propagation
    
    Parameters are:
    
    **orderbook**
    
    **link**
    
    **timeseries**
    """ 
    def __init__(self, orderbook = None, link = None, timeseries = None):
        from marketsim.gen._out.orderbook._local import Local_StringFloatIntListITimeSerie as _orderbook_Local_StringFloatIntListITimeSerie
        from marketsim import deref_opt
        from marketsim.gen._out.orderbook._twowaylink import TwoWayLink_ILinkILink as _orderbook_TwoWayLink_ILinkILink
        self.orderbook = orderbook if orderbook is not None else deref_opt(_orderbook_Local_StringFloatIntListITimeSerie())
        self.link = link if link is not None else deref_opt(_orderbook_TwoWayLink_ILinkILink())
        self.timeseries = timeseries if timeseries is not None else []
        Remote_Impl.__init__(self)
    
    @property
    def label(self):
        return repr(self)
    
    _properties = {
        'orderbook' : IOrderBook,
        'link' : ITwoWayLink,
        'timeseries' : listOf(ITimeSerie)
    }
    
    
    
    
    
    
    def __repr__(self):
        return "%(orderbook)s.name^remote" % dict([ (name, getattr(self, name)) for name in self._properties.iterkeys() ])
    
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
        self.orderbook.bind_ex(self._ctx_ex)
        self.link.bind_ex(self._ctx_ex)
        for x in self.timeseries: x.bind_ex(self._ctx_ex)
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
        self.orderbook.reset_ex(generation)
        self.link.reset_ex(generation)
        for x in self.timeseries: x.reset_ex(generation)
        self.reset()
        if hasattr(self, '_subscriptions'):
            for s in self._subscriptions: s.reset_ex(generation)
        self.__dict__['_processing_ex'] = False
    
    def typecheck(self):
        from marketsim.gen._out._itwowaylink import ITwoWayLink
        from marketsim import listOf
        from marketsim.gen._out._itimeserie import ITimeSerie
        from marketsim import rtti
        from marketsim.gen._out._iorderbook import IOrderBook
        rtti.typecheck(IOrderBook, self.orderbook)
        rtti.typecheck(ITwoWayLink, self.link)
        rtti.typecheck(listOf(ITimeSerie), self.timeseries)
    
    def registerIn(self, registry):
        if self.__dict__.get('_id', False): return
        self.__dict__['_id'] = True
        if self.__dict__.get('_processing_ex', False):
            raise Exception('cycle detected')
        self.__dict__['_processing_ex'] = True
        registry.insert(self)
        self.orderbook.registerIn(registry)
        self.link.registerIn(registry)
        for x in self.timeseries: x.registerIn(registry)
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
    
    def bind_impl(self, ctx):
        Remote_Impl.bind_impl(self, ctx)
    
    def reset(self):
        Remote_Impl.reset(self)
    
def Remote(orderbook = None,link = None,timeseries = None): 
    from marketsim import rtti
    from marketsim.gen._out._itimeserie import ITimeSerie
    from marketsim.gen._out._iorderbook import IOrderBook
    from marketsim.gen._out._itwowaylink import ITwoWayLink
    from marketsim import listOf
    if orderbook is None or rtti.can_be_casted(orderbook, IOrderBook):
        if link is None or rtti.can_be_casted(link, ITwoWayLink):
            if timeseries is None or rtti.can_be_casted(timeseries, listOf(ITimeSerie)):
                return Remote_IOrderBookITwoWayLinkListITimeSerie(orderbook,link,timeseries)
    raise Exception('Cannot find suitable overload for Remote('+str(orderbook) +':'+ str(type(orderbook))+','+str(link) +':'+ str(type(link))+','+str(timeseries) +':'+ str(type(timeseries))+')')
