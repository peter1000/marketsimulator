@category = "Side"

package side {
    @label = "Sell"
    @python.intrinsic("side._Sell_Impl")
    def Sell() : () => Side
        
    
    @label = "Buy"
    @python.intrinsic("side._Buy_Impl")
    def Buy() : () => Side
        
    
    @label = "NoneSide"
    @python.intrinsic("side._Buy_Impl")
    def Nothing() : () => Side
        
}

package mathops {@category = "Log/Pow"
    
    package  {
        /** Exponent of x
         *
         */
        @category = "Log/Pow"
        @label = "e^{%(x)s}"
        @python.mathops("exp")
        def Exp(x : IFunction[Float] = constant(1.0)) : () => Float
            
        
        /** Natural logarithm of x (to base e)
         *
         */
        @category = "Log/Pow"
        @label = "log(%(x)s)"
        @python.mathops("log")
        def Log(x : IFunction[Float] = constant(1.0)) : () => Float
            
        
        /** Square root of x
         *
         */
        @category = "Log/Pow"
        @label = "\\sqrt{%(x)s}"
        @python.mathops("sqrt")
        def Sqrt(x : IFunction[Float] = constant(1.0)) : () => Float
            
        
        /** Return *x* raised to the power *y*.
         *
         * Exceptional cases follow Annex F of the C99 standard as far as possible.
         * In particular, ``pow(1.0, x)`` and ``pow(x, 0.0)`` always return 1.0,
         * even when *x* is a zero or a NaN.
         * If both *x* and *y* are finite, *x* is negative, and *y* is not an integer then
         * ``pow(x, y)`` is undefined, and raises ``ValueError``.
         */
        @category = "Log/Pow"
        @label = "%(base)s^{%(power)s}"
        @python.mathops("pow")
        def Pow(base : IFunction[Float] = constant(1.0),
                power : IFunction[Float] = constant(1.0)) : () => Float
            
    }
    @category = "Trigonometric"
    
    package  {
        /** Arc tangent of x, in radians.
         *
         */
        @label = "atan(%(x)s)"
        @python.mathops("atan")
        def Atan(x : IFunction[Float] = constant(0.0)) : () => Float
            
    }
}

package mathutils {
    package rnd {
        /** Gamma distribution
         *
         *  Conditions on the parameters are |alpha| > 0 and |beta| > 0.
         *
         *  The probability distribution function is: ::
         *
         *               x ** (alpha - 1) * math.exp(-x / beta)
         *     pdf(x) =  --------------------------------------
         *                  math.gamma(alpha) * beta ** alpha
         */
        @python.random()
        def gammavariate(Alpha : Float = 1.0,
                         Beta : Float = 1.0) : () => Float
            
        
        /** Normal distribution
         */
        @python.random()
        def normalvariate(/** |mu| is the mean                  */ Mu : Float = 0.0,
                          /** |sigma| is the standard deviation */ Sigma : Float = 1.0) : () => Float
            
        
        /** Pareto distribution
         */
        @python.random()
        def paretovariate(/** |alpha| is the shape parameter*/ Alpha : Float = 1.0) : () => Float
            
        
        /** Triangular distribution
         *
         * Return a random floating point number *N* such that *low* <= *N* <= *high* and
         *       with the specified *mode* between those bounds.
         *       The *low* and *high* bounds default to zero and one.
         *       The *mode* argument defaults to the midpoint between the bounds,
         *       giving a symmetric distribution.
         */
        @python.random()
        def triangular(Low : Float = 0.0,
                       High : Float = 1.0,
                       Mode : Float = 0.5) : () => Float
            
        
        /** Von Mises distribution
         */
        @python.random()
        def vonmisesvariate(/** |mu| is the mean angle, expressed in radians between 0 and 2|pi|*/ Mu : Float = 0.0,
                            /** |kappa| is the concentration parameter, which must be greater than or equal to zero.
                              *      If |kappa| is equal to zero, this distribution reduces
                              *      to a uniform random angle over the range 0 to 2|pi|        */ Kappa : Float = 0.0) : () => Float
            
        
        /** Uniform distribution
         *
         * Return a random floating point number *N* such that
         * *a* <= *N* <= *b* for *a* <= *b* and *b* <= *N* <= *a* for *b* < *a*.
         * The end-point value *b* may or may not be included in the range depending on
         * floating-point rounding in the equation *a* + (*b*-*a*) * *random()*.
         */
        @python.random()
        def uniform(Low : Float = -10.0,
                    High : Float = 10.0) : () => Float
            
        
        /** Weibull distribution
         */
        @python.random()
        def weibullvariate(/** |alpha| is the scale parameter */ Alpha : Float = 1.0,
                           /** |beta| is the shape parameter  */ Beta : Float = 1.0) : () => Float
            
        
        /** Exponential distribution
         *
         *  Returned values range from 0 to positive infinity
         */
        @python.random()
        def expovariate(/** |lambda| is 1.0 divided by the desired mean. It should be greater zero.*/ Lambda : Float = 1.0) : () => Float
            
        
        /** Log normal distribution
         *
         * If you take the natural logarithm of this distribution,
         *  you'll get a normal distribution with mean |mu| and standard deviation |sigma|.
         *  |mu| can have any value, and |sigma| must be greater than zero.
         */
        @python.random()
        def lognormvariate(Mu : Float = 0.0,
                           Sigma : Float = 1.0) : () => Float
            
        
        /** Beta distribution
         *
         * Conditions on the parameters are |alpha| > 0 and |beta| > 0.
         * Returned values range between 0 and 1.
         */
        @python.random()
        def betavariate(Alpha : Float = 1.0,
                        Beta : Float = 1.0) : () => Float
            
    }
}
@category = "Order"

package order {
    @label = "Market(%(side)s, %(volume)s)"
    @python.order.factory("order.market.Market_Impl")
    def Market(side : () => Side = side.Sell(),
               volume : IFunction[Float] = constant(1.0)) : IObservable[Order]
        
}
@category = "Basic"

package observable {@category = "Price function"
    
    package pricefunc {
        @label = "Lp_{%(side)s}(%(book)s)"
        @python.observable()
        def LiquidityProvider(side : () => Side = side.Sell(),
                              initialValue : Float = 100.0,
                              priceDistr : () => Float = mathutils.rnd.lognormvariate(0.0,0.1),
                              book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.orderbook.SafeSidePrice(observable.orderbook.Queue(book,side),constant(initialValue))*priceDistr
    }
    @category = "Side function"
    
    package sidefunc {
        @label = "Pt_{%(factor)s*%(dependee)s}(%(book)s)"
        @python.observable()
        def PairTrading(dependee : IOrderBook = observable.orderbook.OfTrader(),
                        factor : IFunction[Float] = constant(1.0),
                        book : IOrderBook = observable.orderbook.OfTrader()) : () => Side
             = observable.sidefunc.FundamentalValue(observable.orderbook.MidPrice(dependee)*factor,book)
        
        @label = "SignalSide_{%(threshold)s}(%(signal)s)"
        @python.observable()
        def Signal(signal : IFunction[Float] = constant(),
                   threshold : Float = 0.7) : () => Side
             = if signal>const(threshold) then side.Buy() else if signal<const(0-threshold) then side.Sell() else side.Nothing()
        
        @label = "CrAvg_{%(alpha_1)s}^{%(alpha_2)s}(%(book)s)"
        @python.observable()
        def CrossingAverages(alpha_1 : Float = 0.015,
                             alpha_2 : Float = 0.15,
                             threshold : Float = 0.0,
                             book : IOrderBook = observable.orderbook.OfTrader()) : () => Side
             = observable.sidefunc.Signal(observable.EW.Avg(observable.orderbook.MidPrice(book),alpha_1)-observable.EW.Avg(observable.orderbook.MidPrice(book),alpha_2),threshold)
        
        @label = "Tf_{%(alpha)s}(%(book)s)"
        @python.observable()
        def TrendFollower(alpha : Float = 0.015,
                          threshold : Float = 0.0,
                          book : IOrderBook = observable.orderbook.OfTrader()) : () => Side
             = observable.sidefunc.Signal(Derivative(observable.EW.Avg(observable.orderbook.MidPrice(book),alpha)),threshold)
        
        @label = "Fv_{%(fv)s}(%(book)s)"
        @python.observable()
        def FundamentalValue(fv : IFunction[Float] = constant(200.0),
                             book : IOrderBook = observable.orderbook.OfTrader()) : () => Side
             = if observable.orderbook.BidPrice(book)>fv then side.Sell() else if observable.orderbook.AskPrice(book)<fv then side.Buy() else side.Nothing()
        
        @label = "Mr_{%(alpha)s}(%(book)s)"
        @python.observable()
        def MeanReversion(alpha : Float = 0.015,
                          book : IOrderBook = observable.orderbook.OfTrader()) : () => Side
             = observable.sidefunc.FundamentalValue(observable.EW.Avg(observable.orderbook.MidPrice(book),alpha),book)
        
        @label = "Noise_{%(side_distribution)s}"
        @python.observable()
        def Noise(side_distribution : IFunction[Float] = mathutils.rnd.uniform(0.0,1.0)) : () => Side
             = if side_distribution>const(0.5) then side.Sell() else side.Buy()
    }
    
    package Cumulative {
        @label = "Min_{\\epsilon}(%(source)s)"
        @python.intrinsic("observable.minmax_eps.MinEpsilon_Impl")
        def MinEpsilon(source : IFunction[Float] = constant(),
                       epsilon : IFunction[Float] = constant(0.01)) : IObservable[Float]
            
        
        @label = "Max_{\\epsilon}(%(source)s)"
        @python.intrinsic("observable.minmax_eps.MaxEpsilon_Impl")
        def MaxEpsilon(source : IFunction[Float] = constant(),
                       epsilon : IFunction[Float] = constant(0.01)) : IObservable[Float]
            
    }
    @category = "RSI"
    
    package rsi {
        @label = "RSIRaw_{%(timeframe)s}^{%(alpha)s}(%(source)s)"
        @python()
        def Raw(source : IObservable[Float] = observable.orderbook.MidPrice(),
                timeframe : Float = 10.0,
                alpha : Float = 0.015) : IFunction[Float]
             = observable.EW.Avg(observable.UpMovements(source,timeframe),alpha)/observable.EW.Avg(observable.DownMovements(source,timeframe),alpha)
    }
    @category = "MACD"
    
    package macd {
        @label = "MACD_{%(fast)s}^{%(slow)s}(%(x)s)"
        @python()
        def MACD(x : IObservable[Float] = observable.orderbook.MidPrice(),
                 slow : Float = 26.0,
                 fast : Float = 12.0) : IFunction[Float]
             = observable.EW.Avg(x,2.0/(fast+1))-observable.EW.Avg(x,2.0/(slow+1))
        
        @label = "Signal^{%(timeframe)s}_{%(step)s}(MACD_{%(fast)s}^{%(slow)s}(%(x)s))"
        @python()
        def Signal(x : IObservable[Float] = observable.orderbook.MidPrice(),
                   slow : Float = 26.0,
                   fast : Float = 12.0,
                   timeframe : Float = 9.0,
                   step : Float = 1.0) : IDifferentiable
             = observable.EW.Avg(observable.OnEveryDt(step,observable.macd.MACD(x,slow,fast)),2/(timeframe+1))
        
        @label = "Histogram^{%(timeframe)s}_{%(step)s}(MACD_{%(fast)s}^{%(slow)s}(%(x)s))"
        @python()
        def Histogram(x : IObservable[Float] = observable.orderbook.MidPrice(),
                      slow : Float = 26.0,
                      fast : Float = 12.0,
                      timeframe : Float = 9.0,
                      step : Float = 1.0) : IFunction[Float]
             = observable.macd.MACD(x,slow,fast)-observable.macd.Signal(x,slow,fast,timeframe,step)
    }
    @category = "Trader's"
    
    package trader {
        @label = "Balance_{%(trader)s}"
        @python.intrinsic("trader.props.Balance_Impl")
        def Balance(trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IObservable[Float]
            
        
        @label = "RoughPnL_{%(trader)s}"
        @python.observable()
        def RoughPnL(trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IObservable[Float]
             = observable.Observable(observable.trader.Balance(trader)+observable.orderbook.NaiveCumulativePrice(observable.orderbook.OfTrader(trader),observable.trader.Position(trader)))
        
        @label = "Amount_{%(trader)s}"
        @python.intrinsic("trader.props.Position_Impl")
        def Position(trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IObservable[Float]
            
        
        @label = "Efficiency_{%(trader)s}"
        @python.observable()
        def Efficiency(trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IObservable[Float]
             = observable.Observable(observable.trader.Balance(trader)+observable.orderbook.CumulativePrice(observable.orderbook.OfTrader(trader),observable.trader.Position(trader)))
        
        @label = "N/A"
        @python.intrinsic("trader.proxy._Single_Impl")
        def SingleProxy() : ISingleAssetTrader
            
        
        @label = "EfficiencyTrend_{%(trader)s}"
        @python()
        def EfficiencyTrend(trader : ISingleAssetTrader = observable.trader.SingleProxy(),
                            alpha : Float = 0.15) : () => Float
             = Derivative(observable.EW.Avg(observable.trader.Efficiency(trader),alpha))
        
        @label = "PendingVolume_{%(trader)s}"
        @python.intrinsic("trader.props.PendingVolume_Impl")
        def PendingVolume(trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IObservable[Float]
            
    }
    @category = "Volume function"
    
    package volumefunc {
        @label = "Dp_{%(trader)s}(%(desiredPosition)s)"
        @python.observable()
        def DesiredPosition(desiredPosition : IObservable[Float] = const(),
                            trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IObservable[Float]
             = desiredPosition-observable.trader.Position(trader)-observable.trader.PendingVolume(trader)
        
        @label = "Bl_{%(trader)s}(%(alpha)s)*%(k)s"
        @python.observable()
        def Bollinger_linear(alpha : Float = 0.15,
                             k : IObservable[Float] = const(0.5),
                             trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IObservable[Float]
             = observable.volumefunc.DesiredPosition(observable.OnEveryDt(1.0,observable.EW.RelStdDev(observable.orderbook.MidPrice(observable.orderbook.OfTrader(trader)),alpha))*k,trader)
        
        @label = "RSI_{%(trader)s}(%(alpha)s, %(timeframe)s)*%(k)s"
        @python.observable()
        def RSI_linear(alpha : Float = 1.0/14.0,
                       k : IObservable[Float] = const(-0.04),
                       timeframe : Float = 1.0,
                       trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IObservable[Float]
             = observable.volumefunc.DesiredPosition(observable.OnEveryDt(1.0,const(50.0)-observable.RSI(observable.orderbook.OfTrader(trader),timeframe,alpha))*k,trader)
    }
    @category = "Asset's"
    
    package orderbook {
        @label = "SafeSidePrice^{%(queue)s}"
        @python.observable()
        def SafeSidePrice(queue : IOrderQueue = observable.orderbook.Asks(),
                          defaultValue : IFunction[Float] = constant(100.0)) : IObservable[Float]
             = observable.Observable(IfDefined(observable.orderbook.BestPrice(queue),IfDefined(observable.orderbook.LastPrice(queue),defaultValue)))
        
        @label = "Price_{%(alpha)s}^{%(queue)s}"
        @python()
        def WeightedPrice(queue : IOrderQueue = observable.orderbook.Asks(),
                          alpha : Float = 0.015) : IFunction[Float]
             = observable.EW.Avg(observable.orderbook.LastTradePrice(queue)*observable.orderbook.LastTradeVolume(queue),alpha)/observable.EW.Avg(observable.orderbook.LastTradeVolume(queue),alpha)
        
        @label = "TickSize(%(book)s)"
        @python.intrinsic("orderbook.props._TickSize_Impl")
        def TickSize(book : IOrderBook = observable.orderbook.OfTrader()) : () => Float
            
        
        @label = "Ask_{%(book)s}"
        @python()
        def AskLastPrice(book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.orderbook.LastPrice(observable.orderbook.Asks(book))
        
        @label = "LastTradeBid^{%(book)s}"
        @python()
        def BidLastTradePrice(book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.orderbook.LastTradePrice(observable.orderbook.Bids(book))
        
        @label = "Ask_{%(alpha)s}^{%(book)s}"
        @python()
        def AskWeightedPrice(book : IOrderBook = observable.orderbook.OfTrader(),
                             alpha : Float = 0.015) : IFunction[Float]
             = observable.orderbook.WeightedPrice(observable.orderbook.Asks(book),alpha)
        
        @label = "MidPrice_{%(book)s}"
        @python()
        def MidPrice(book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.Observable((observable.orderbook.AskPrice(book)+observable.orderbook.BidPrice(book))/const(2.0))
        
        @label = "Asks(%(book)s)"
        @python.intrinsic("orderbook.queue._Asks_Impl")
        def Asks(book : IOrderBook = observable.orderbook.OfTrader()) : IOrderQueue
             = observable.orderbook.Queue(book,side.Sell())
        
        @label = "Bid_{%(alpha)s}^{%(book)s}"
        @python()
        def BidWeightedPrice(book : IOrderBook = observable.orderbook.OfTrader(),
                             alpha : Float = 0.015) : IFunction[Float]
             = observable.orderbook.WeightedPrice(observable.orderbook.Bids(book),alpha)
        
        @label = "Ask_{%(book)s}"
        @python()
        def AskPrice(book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.orderbook.BestPrice(observable.orderbook.Asks(book))
        
        @label = "LastTradeVolume(%(queue)s)"
        @python.intrinsic("orderbook.last_trade._LastTradeVolume_Impl")
        def LastTradeVolume(queue : IOrderQueue = observable.orderbook.Asks()) : IObservable[Float]
            
        
        @label = "Bid^{%(book)s}"
        @python()
        def BidPrice(book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.orderbook.BestPrice(observable.orderbook.Bids(book))
        
        @label = "Bids(%(book)s)"
        @python.intrinsic("orderbook.queue._Bids_Impl")
        def Bids(book : IOrderBook = observable.orderbook.OfTrader()) : IOrderQueue
             = observable.orderbook.Queue(book,side.Buy())
        
        @label = "Price(%(queue)s)"
        @python.intrinsic("orderbook.props._BestPrice_Impl")
        def BestPrice(queue : IOrderQueue = observable.orderbook.Asks()) : IObservable[Float]
            
        
        @label = "Queue(%(book)s)"
        @python.intrinsic("orderbook.queue._Queue_Impl")
        def Queue(book : IOrderBook = observable.orderbook.OfTrader(),
                  side : () => Side = side.Sell()) : IOrderQueue
            
        
        @label = "N/A"
        @python.intrinsic("orderbook.of_trader._OfTrader_Impl")
        def OfTrader(Trader : ISingleAssetTrader = observable.trader.SingleProxy()) : IOrderBook
            
        
        @label = "LastTradeAsk_{%(book)s}"
        @python()
        def AskLastTradePrice(book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.orderbook.LastTradePrice(observable.orderbook.Asks(book))
        
        @label = "Bid^{%(book)s}"
        @python()
        def BidLastPrice(book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.orderbook.LastPrice(observable.orderbook.Bids(book))
        
        @label = "CumulativePrice(%(book)s, %(depth)s)"
        @python.intrinsic("orderbook.cumulative_price.CumulativePrice_Impl")
        def CumulativePrice(book : IOrderBook = observable.orderbook.OfTrader(),
                            depth : IFunction[Float] = constant()) : IObservable[Float]
            
        
        @label = "VolumeLevels(%(queue)s)"
        @python.intrinsic("orderbook.volume_levels.VolumeLevels_Impl")
        def VolumeLevels(queue : IOrderQueue = observable.orderbook.Asks(),
                         volumeDelta : Float = 30.0,
                         volumeCount : Int = 10) : IFunction[VolumeLevels]
            
        
        @label = "LastPrice(%(queue)s)"
        @python.intrinsic("orderbook.last_price._LastPrice_Impl")
        def LastPrice(queue : IOrderQueue = observable.orderbook.Asks()) : IObservable[Float]
            
        
        @label = "NaiveCumulativePrice(%(book)s, %(depth)s)"
        @python()
        def NaiveCumulativePrice(book : IOrderBook = observable.orderbook.OfTrader(),
                                 depth : IFunction[Float] = constant()) : IObservable[Float]
             = observable.Observable(if depth<const(0.0) then depth*observable.orderbook.AskPrice(book) else if depth>const(0.0) then depth*observable.orderbook.BidPrice(book) else const(0.0))
        
        @label = "Spread_{%(book)s}"
        @python()
        def Spread(book : IOrderBook = observable.orderbook.OfTrader()) : IObservable[Float]
             = observable.Observable(observable.orderbook.AskPrice(book)-observable.orderbook.BidPrice(book))
        
        @label = "LastTradePrice(%(queue)s)"
        @python.intrinsic("orderbook.last_trade._LastTradePrice_Impl")
        def LastTradePrice(queue : IOrderQueue = observable.orderbook.Asks()) : IObservable[Float]
            
    }
    
    package Moving {
        @label = "Min_{n=%(timeframe)s}(%(source)s)"
        @python.intrinsic("observable.minmax.Min_Impl")
        def Min(source : IFunction[Float] = constant(),
                timeframe : Float = 100.0) : IObservable[Float]
            
        
        @label = "Max_{n=%(timeframe)s}(%(source)s)"
        @python.intrinsic("observable.minmax.Max_Impl")
        def Max(source : IFunction[Float] = constant(),
                timeframe : Float = 100.0) : IObservable[Float]
            
    }
    @category = "Statistics"
    
    package  {
        package EW {
            @label = "Avg_{\\alpha=%(alpha)s}(%(source)s)"
            @python.intrinsic("moments.ewma.EWMA_Impl")
            def Avg(source : IObservable[Float] = const(),
                    alpha : Float = 0.015) : IDifferentiable
                
            
            @label = "\\sigma^2_{\\alpha=%(alpha)s}_{%(source)s}"
            @python.intrinsic("moments.ewmv.EWMV_Impl")
            def Var(source : IObservable[Float] = const(),
                    alpha : Float = 0.015) : () => Float
                
            
            @label = "\\sqrt{\\sigma^2_{\\alpha=%(alpha)s}_{%(source)s}}"
            @python()
            def StdDev(source : IObservable[Float] = const(),
                       alpha : Float = 0.015) : () => Float
                 = mathops.Sqrt(observable.EW.Var(source,alpha))
            
            @label = "RSD_{\\alpha=%(alpha)s}_{%(source)s}"
            @python()
            def RelStdDev(source : IObservable[Float] = const(),
                          alpha : Float = 0.15) : IObservable[Float]
                 = (source-observable.EW.Avg(source,alpha))/observable.EW.StdDev(source,alpha)
        }
        
        package Cumulative {
            @label = "Avg_{cumul}(%(source)s)"
            @python.intrinsic("moments.cma.CMA_Impl")
            def Avg(source : IObservable[Float] = const()) : () => Float
                
            
            @label = "\\sigma^2_{cumul}(%(source)s)"
            @python.intrinsic("moments.cmv.Variance_Impl")
            def Var(source : IObservable[Float] = const()) : () => Float
                
            
            @label = "\\sqrt{\\sigma^2_{cumul}_{%(source)s}}"
            @python()
            def StdDev(source : IObservable[Float] = const()) : () => Float
                 = mathops.Sqrt(observable.Cumulative.Var(source))
            
            @label = "RSD_{cumul}_{%(source)s}"
            @python()
            def RelStdDev(source : IObservable[Float] = const()) : IObservable[Float]
                 = (source-observable.Cumulative.Avg(source))/observable.Cumulative.StdDev(source)
        }
        
        package Moving {
            @label = "Avg_{n=%(timeframe)s}(%(source)s)"
            @python.intrinsic("moments.ma.MA_Impl")
            def Avg(source : IObservable[Float] = const(),
                    timeframe : Float = 100.0) : () => Float
                
            
            @label = "\\sigma^2_{n=%(timeframe)s}(%(source)s)"
            @python.intrinsic("moments.mv.MV_Impl")
            def Var(source : IObservable[Float] = const(),
                    timeframe : Float = 100.0) : IFunction[Float]
                 = observable.Max(const(0),observable.Moving.Avg(source*source,timeframe)-observable.Sqr(observable.Moving.Avg(source,timeframe)))
            
            @label = "\\sqrt{\\sigma^2_{n=%(timeframe)s}_{%(source)s}}"
            @python()
            def StdDev(source : IObservable[Float] = const(),
                       timeframe : Float = 100.0) : () => Float
                 = mathops.Sqrt(observable.Moving.Var(source))
            
            @label = "RSD_{n=%(timeframe)s}_{%(source)s}"
            @python()
            def RelStdDev(source : IObservable[Float] = const(),
                          timeframe : Float = 100.0) : IObservable[Float]
                 = (source-observable.Moving.Avg(source,timeframe))/observable.Moving.StdDev(source,timeframe)
        }
    }
    
    @label = "[%(x)s]_dt=%(dt)s"
    @python.intrinsic("observable.on_every_dt._OnEveryDt_Impl")
    def OnEveryDt(dt : Float = 1.0,
                  x : IFunction[Float] = constant()) : IObservable[Float]
        
    
    @label = "min{%(x)s, %(y)s}"
    @python.observable()
    def Min(x : IFunction[Float] = constant(),
            y : IFunction[Float] = constant()) : IFunction[Float]
         = if x<y then x else y
    
    @label = "Downs_{%(timeframe)s}(%(source)s)"
    @python.observable()
    def DownMovements(source : IObservable[Float] = observable.orderbook.MidPrice(),
                      timeframe : Float = 10.0) : IObservable[Float]
         = observable.Observable(observable.Max(const(0.0),observable.Lagged(source,timeframe)-source))
    
    @label = "Lagged_{%(timeframe)s}(%(source)s)"
    @python.intrinsic("observable.lagged.Lagged_Impl")
    def Lagged(source : IObservable[Float] = const(),
               timeframe : Float = 10.0) : IObservable[Float]
        
    
    @label = "max{%(x)s, %(y)s}"
    @python.observable()
    def Max(x : IFunction[Float] = constant(),
            y : IFunction[Float] = constant()) : IFunction[Float]
         = if x>y then x else y
    
    @label = "Ups_{%(timeframe)s}(%(source)s)"
    @python.observable()
    def UpMovements(source : IObservable[Float] = observable.orderbook.MidPrice(),
                    timeframe : Float = 10.0) : IObservable[Float]
         = observable.Observable(observable.Max(const(0.0),source-observable.Lagged(source,timeframe)))
    
    @category = "Pow/Log"
    @label = "{%(x)s}^2"
    @python.observable()
    def Sqr(x : IFunction[Float] = constant()) : IFunction[Float]
         = x*x
    
    @label = "RSI_{%(timeframe)s}^{%(alpha)s}(%(book)s)"
    @python()
    def RSI(book : IOrderBook = observable.orderbook.OfTrader(),
            timeframe : Float = 10.0,
            alpha : Float = 0.015) : IObservable[Float]
         = const(100.0)-const(100.0)/(const(1.0)+observable.rsi.Raw(observable.orderbook.MidPrice(book),timeframe,alpha))
    
    @label = "%(ticker)s"
    @python.intrinsic("observable.quote.Quote_Impl")
    def Quote(ticker : String = "^GSPC",
              start : String = "2001-1-1",
              end : String = "2010-1-1") : IObservable[Float]
        
    
    @label = "CandleSticks(%(source)s)"
    @python.intrinsic("observable.candlestick.CandleSticks_Impl")
    def CandleSticks(source : IObservable[Float] = const(),
                     timeframe : Float = 10.0) : IObservable[CandleStick]
        
    
    @label = "[%(x)s]"
    @python.intrinsic("observable.on_every_dt._Observable_Impl")
    def Observable(x : IFunction[Float] = const()) : IObservable[Float]
        
}

package trash {
    package types {
        package  {
            type T
        }
        
        package  {
            type R : trash.types.T
        }
        
        package  {
            package  {
                type U : trash.types.T, trash.types.R
            }
        }
        
        type T1 = trash.types.T
    }
    
    package in1 {
        package in2 {
            def S1(y : String = "abc") : String
                 = y
            
            def F(x : IFunction[Float] = trash.in1.in2.IntFunc()) : IFunction[Float]
                 = x
            
            def A(x : IFunction[Float] = constant(),
                  y : IFunction[Float] = if 3>x+2 then x else x*2) : () => trash.types.T
                
            
            def IntFunc() : () => Int
                
            
            def C(x : IFunction[CandleStick]) : IFunction[CandleStick]
                 = x
        }
        
        def A(x : () => trash.types.T1 = trash.A()) : () => trash.types.U
            
    }
    
    def A(x : () => trash.types.T = trash.in1.in2.A()) : () => trash.types.R
        
}
@category = "Basic"

package  {
    @label = "C=%(x)s"
    @python()
    def constant(x : Float = 1.0) : IFunction[Float]
         = const(x)
    
    @label = "Null"
    @python.intrinsic("_constant._Null_Impl")
    def null() : () => Float
        
    
    @label = "C=%(x)s"
    @python.intrinsic.function("_constant._Constant_Impl")
    def const(x : Float = 1.0) : IObservable[Float]
        
    
    @label = "\\frac{d%(x)s}{dt}"
    @python.intrinsic("observable.derivative._Derivative_Impl")
    def Derivative(x : IDifferentiable = observable.EW.Avg()) : () => Float
        
    
    @label = "If def(%(x)s) else %(elsePart)s"
    @python.observable()
    def IfDefined(x : IFunction[Float] = constant(),
                  elsePart : IFunction[Float] = constant()) : IFunction[Float]
         = if x<>null() then x else elsePart
}

type CandleStick

type Side

type Boolean

type IOrderQueue

type Float

type Int : Float

type IOrderBook

type IObservable : IFunction[T]

type IFunction = () => T

type ISingleAssetTrader

type Order

type IDifferentiable : IFunction[T]

type VolumeLevels

type String
