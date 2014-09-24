## File: graphdb.R
## Description: A demonstration of how to create and use graph DB's in R with Big Data
## Copyright: (c) 2014, Jason D. Miller, MS, MS
## http://hack-r.com 
## http://hack-r.github.io
## http://github.com/hack-r


# Source Libraries/Functions ----------------------------------------------
source("graphdb_functions.R")


# Scrape Example Data from the Web ----------------------------------------

# LifeVantage is the maker of Nrf2-activating (antioxidant)
#  products such as Protandim and TrueScience; for more
#  information see http://lifevantagefacts.com 

googlefinance <- WebCorpus(GoogleFinanceSource("NASDAQ:LFVN"))
googlenews.lv <- WebCorpus(GoogleNewsSource("LifeVantage"))
googlenews.pr <- WebCorpus(GoogleNewsSource("Protandim"))
googlenews.ts <- WebCorpus(GoogleNewsSource("TrueScience"))
yahoofinance  <- WebCorpus(YahooFinanceSource("LFVN"))
yahoonews.lv  <- WebCorpus(YahooNewsSource("LifeVantage"))
yahoonews.pr  <- WebCorpus(YahooNewsSource("Protandim"))
yahoonews     <- WebCorpus(YahooNewsSource("TrueScience"))
