from marketsim.gen._out._iobservable._iobservablefloat import IObservablefloat
from marketsim.gen._out._iobservable._iobservablebool import IObservablebool
from marketsim import meta
#(.IObservable[.Float],.IObservable[.Float]) => .IObservable[.Boolean]
class IFunctionIObservableboolIObservablefloatIObservablefloat(object):
    _types = [meta.function((IObservablefloat,IObservablefloat,),IObservablebool)]
    
    pass



