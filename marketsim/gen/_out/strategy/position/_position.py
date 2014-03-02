from marketsim import registry
from marketsim.gen._out._observable._observablefloat import Observablefloat
from marketsim.gen._out.strategy.position._rsi_linear import RSI_linear
from marketsim import context
@registry.expose(["Volume function", "Position"])
class Position_strategypositionRSI_linear(Observablefloat):
    """ 
    """ 
    def __init__(self, x = None):
        from marketsim import deref_opt
        from marketsim.gen._out._observable._observablefloat import Observablefloat
        from marketsim import _
        from marketsim import rtti
        from marketsim.gen._out.strategy.position._rsi_linear import RSI_linear_FloatIObservableFloatFloatISingleAssetTrader as _strategy_position_RSI_linear_FloatIObservableFloatFloatISingleAssetTrader
        from marketsim import event
        Observablefloat.__init__(self)
        self.x = x if x is not None else deref_opt(_strategy_position_RSI_linear_FloatIObservableFloatFloatISingleAssetTrader())
        rtti.check_fields(self)
        self.impl = self.getImpl()
        event.subscribe(self.impl, _(self).fire, self)
    
    @property
    def label(self):
        return repr(self)
    
    _properties = {
        'x' : RSI_linear
    }
    def __repr__(self):
        return "Position(%(x)s)" % self.__dict__
    
    def bind(self, ctx):
        self._ctx = ctx.clone()
    
    _internals = ['impl']
    def __call__(self, *args, **kwargs):
        return self.impl()
    
    def reset(self):
        self.impl = self.getImpl()
        ctx = getattr(self, '_ctx', None)
        if ctx: context.bind(self.impl, ctx)
    
    def getImpl(self):
        from marketsim import deref_opt
        from marketsim.gen._out.strategy.position._trader import Trader_strategypositionRSI_linear as _strategy_position_Trader_strategypositionRSI_linear
        from marketsim.gen._out.strategy.position._desiredposition import DesiredPosition_strategypositionRSI_linear as _strategy_position_DesiredPosition_strategypositionRSI_linear
        from marketsim.gen._out.trader._position import Position_IAccount as _trader_Position_IAccount
        from marketsim.gen._out.ops._sub import Sub_IObservableFloatIObservableFloat as _ops_Sub_IObservableFloatIObservableFloat
        from marketsim.gen._out.trader._pendingvolume import PendingVolume_IAccount as _trader_PendingVolume_IAccount
        return deref_opt(_ops_Sub_IObservableFloatIObservableFloat(deref_opt(_ops_Sub_IObservableFloatIObservableFloat(deref_opt(_strategy_position_DesiredPosition_strategypositionRSI_linear(self.x)),deref_opt(_trader_Position_IAccount(deref_opt(_strategy_position_Trader_strategypositionRSI_linear(self.x)))))),deref_opt(_trader_PendingVolume_IAccount(deref_opt(_strategy_position_Trader_strategypositionRSI_linear(self.x))))))
    
    def __getattr__(self, name):
        if name[0:2] != '__' and self.impl:
            return getattr(self.impl, name)
        else:
            raise AttributeError
    
from marketsim import registry
from marketsim.gen._out._observable._observablefloat import Observablefloat
from marketsim.gen._out.strategy.position._bollinger_linear import Bollinger_linear
from marketsim import context
@registry.expose(["Volume function", "Position"])
class Position_strategypositionBollinger_linear(Observablefloat):
    """ 
    """ 
    def __init__(self, x = None):
        from marketsim import deref_opt
        from marketsim.gen._out._observable._observablefloat import Observablefloat
        from marketsim import _
        from marketsim import rtti
        from marketsim.gen._out.strategy.position._bollinger_linear import Bollinger_linear_FloatIObservableFloatISingleAssetTrader as _strategy_position_Bollinger_linear_FloatIObservableFloatISingleAssetTrader
        from marketsim import event
        Observablefloat.__init__(self)
        self.x = x if x is not None else deref_opt(_strategy_position_Bollinger_linear_FloatIObservableFloatISingleAssetTrader())
        rtti.check_fields(self)
        self.impl = self.getImpl()
        event.subscribe(self.impl, _(self).fire, self)
    
    @property
    def label(self):
        return repr(self)
    
    _properties = {
        'x' : Bollinger_linear
    }
    def __repr__(self):
        return "Position(%(x)s)" % self.__dict__
    
    def bind(self, ctx):
        self._ctx = ctx.clone()
    
    _internals = ['impl']
    def __call__(self, *args, **kwargs):
        return self.impl()
    
    def reset(self):
        self.impl = self.getImpl()
        ctx = getattr(self, '_ctx', None)
        if ctx: context.bind(self.impl, ctx)
    
    def getImpl(self):
        from marketsim import deref_opt
        from marketsim.gen._out.strategy.position._trader import Trader_strategypositionBollinger_linear as _strategy_position_Trader_strategypositionBollinger_linear
        from marketsim.gen._out.strategy.position._desiredposition import DesiredPosition_strategypositionBollinger_linear as _strategy_position_DesiredPosition_strategypositionBollinger_linear
        from marketsim.gen._out.trader._position import Position_IAccount as _trader_Position_IAccount
        from marketsim.gen._out.ops._sub import Sub_IObservableFloatIObservableFloat as _ops_Sub_IObservableFloatIObservableFloat
        from marketsim.gen._out.trader._pendingvolume import PendingVolume_IAccount as _trader_PendingVolume_IAccount
        return deref_opt(_ops_Sub_IObservableFloatIObservableFloat(deref_opt(_ops_Sub_IObservableFloatIObservableFloat(deref_opt(_strategy_position_DesiredPosition_strategypositionBollinger_linear(self.x)),deref_opt(_trader_Position_IAccount(deref_opt(_strategy_position_Trader_strategypositionBollinger_linear(self.x)))))),deref_opt(_trader_PendingVolume_IAccount(deref_opt(_strategy_position_Trader_strategypositionBollinger_linear(self.x))))))
    
    def __getattr__(self, name):
        if name[0:2] != '__' and self.impl:
            return getattr(self.impl, name)
        else:
            raise AttributeError
    
def Position(x = None): 
    from marketsim.gen._out.strategy.position._rsi_linear import RSI_linear
    from marketsim.gen._out.strategy.position._bollinger_linear import Bollinger_linear
    from marketsim import rtti
    if x is None or rtti.can_be_casted(x, RSI_linear):
        return Position_strategypositionRSI_linear(x)
    if x is None or rtti.can_be_casted(x, Bollinger_linear):
        return Position_strategypositionBollinger_linear(x)
    raise Exception('Cannot find suitable overload for Position('+str(x) +':'+ str(type(x))+')')