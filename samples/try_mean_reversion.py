import sys
sys.path.append(r'..')

from marketsim import (signal, strategy, trader, orderbook, order,
                       scheduler, observable, veusz, mathutils)

from common import run

const = mathutils.constant

def MeanReversion(graph, world, books):

    book_A = books['Asset A']
    proxy_A = books['Proxy A']

    price_graph = graph("Price")
     
    assetPrice = observable.Price(book_A)
    
    avg = observable.avg
    
    V = 1
    
    lp_A = trader.SASM(book_A, 
                       strategy.LiquidityProvider(
                            volumeDistr=const(V*20), 
                            orderFactoryT=order.WithExpiryFactory(
                                expirationDistr=const(10))),
                       label="liquidity")
    
    linear_signal = signal.RandomWalk(initialValue=200, 
                                      deltaDistr=const(-1), 
                                      label="200-t")
    
    signal_trader = trader.SASM(book_A, 
                                strategy.Signal(linear_signal, 
                                                volumeDistr = const(V*3)), 
                                "signal")
    
    alpha = 0.015
    
    mean_reversion = trader.SASM(book_A, 
                                 strategy.MeanReversion(
                                    average=mathutils.ewma(alpha),
                                    volumeDistr = const(V)),
                                 label="meanreversion")
    
    mean_reversion_ex=trader.SASM(book_A, 
                                 strategy.MeanReversionEx(proxy_A,
                                    average=mathutils.ewma(alpha),
                                    volumeDistr = const(V)),
                                 label="meanreversion_ex")
    
    price_graph += [assetPrice,
                    avg(assetPrice, alpha),
                    linear_signal,
                    observable.VolumeTraded(signal_trader), 
                    observable.VolumeTraded(mean_reversion),
                    observable.VolumeTraded(mean_reversion_ex)]
    
    eff_graph = graph("efficiency")
    eff_graph += [observable.Efficiency(mean_reversion),
                  observable.Efficiency(mean_reversion_ex),
                  observable.Efficiency(signal_trader)]
    
    return [lp_A, signal_trader, mean_reversion, mean_reversion_ex], [price_graph, eff_graph]

if __name__ == '__main__':
    run("mean_reversion", MeanReversion)