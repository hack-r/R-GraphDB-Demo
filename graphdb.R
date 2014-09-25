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
corpus        <- c(googlefinance, googlenews.lv, googlenews.pr, googlenews.ts,
                   yahoonews, yahoonews.lv, yahoonews.pr, yahoofinance)

# Create a TDM from Scraped Data ------------------------------------------
# Clean/prepare data with tm_map
doc.corpus <- tm_map(corpus, stripWhitespace)
doc.corpus <- tm_map(doc.corpus, removePunctuation)
doc.corpus <- tm_map(doc.corpus, stemDocument)
doc.corpus <- tm_map(doc.corpus, content_transformer(removeWords), 
                     c("a", "b", "c", "d", "e", "f","g","h","i","j","k","l","m",
                       "n","o","p","q","r","s","t","u","v","w","x","y","z",))
doc.corpus <- tm_map(doc.corpus, content_transformer(removeWords), 
                     stopwords("english"))
#Create the TDM
doc.tdm   <- TermDocumentMatrix(doc.corpus)
notsparse <- 

# Initialize a Neo4J Graph Database ---------------------------------------
hack_r = startGraph("http://localhost:7474/db/data/") 


# Utilize Transactional Endpoint ------------------------------------------
appendCypher()

query = "
MERGE (liker:User {name:{liker_id}})
MERGE (author:User {name:{author_id}})
CREATE (liker)<-[:LIKER]-(:liked_objectID {number:{liked_objectID}})-[:AUTHOR]->(author)"

t = newTransaction(hack_r)

for (i in 1:nrow(Z)) {
  liker_id = Z[i, ]$liker
  author_id = Z[i, ]$author
  liked_objectID = Z[i, ]$liked_objectID
  
  appendCypher(t, 
               query, 
               liker_id = liker_id, 
               author_id = author_id, 
               liked_objectID = liked_objectID)
}

commit(t)

cypher(hack_r, "MATCH (l:User)<-[:LIKER]-(i:liked_objectID)-[:AUTHOR]->(a:User)
               RETURN l.name, i.number, a.name")
# It works!

summary(hack_r)

