import sys
sys.path.append(r'../..')

from marketsim._pub import strategy
from common import expose

@expose("Market Data", __name__)
def MarketData(ctx):
    return [
        ctx.makeTrader_A(strategy.price.MarketData().TwoSides, "marketdata2"),

        ctx.makeTrader_A(strategy.side.Noise().Strategy(), "noise")
    ]