def ImmediateOrCancel(proto = None): 
    from marketsim import IOrderGenerator
    from marketsim import float
    from marketsim import IFunction
    from marketsim import rtti
    if proto is None or rtti.can_be_casted(proto, IFunction[IOrderGenerator,IFunction[float]]):
        return ImmediateOrCancel_IOrderGenerator(proto)
    raise Exception("Cannot find suitable overload")