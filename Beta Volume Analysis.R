getwd()
setwd("Public Company Analysis")

library(httr)
library(XML)

##Get NZX List

con<-GET("https://en.wikipedia.org/wiki/List_of_companies_listed_on_the_New_Zealand_Exchange")
htmlCode<-content(con,as="text")

parsedHtml<-htmlParse(htmlCode, asText=TRUE)

listingTable<-xpathSApply(parsedHtml,"//tbody")

xmlValues<-(xmlSApply(listingTable[[1]],xmlValue))

names(xmlValues)<-1:length(xmlValues)

##Alternate Source
con<-GET("https://www.nzx.com/markets/NZSX")
htmlCode<-content(con,as="text")

parsedHtml<-htmlParse(htmlCode, asText=TRUE)

listingTable<-xpathSApply(parsedHtml,"//tbody/tr/td/a/strong",xmlValue)
listingTable
xmlValues<-(xmlSApply(listingTable[[1]],xmlValue))

names(xmlValues)<-1:length(xmlValues)






tickers2<-gsub("^[^,]+NZX:\\s+|\\n.*$","",xmlValues[2:length(xmlValues)])
gsub(" ","",tickers2)
tickers4<-paste(tickers2,".NZ",sep="")
tickers5<-c("%5ENZ50",tickers4)
names(tickers5)<-1:length(tickers5)
tickers5


install.packages("TTR")

library(TTR)
library(quantmod)
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

#Make a new environment for quantmod to store data in 
stockData <- new.env() 

#Specify period of time we are interested in
startDate = as.Date("2014-01-10") 
endDate = as.Date("2019-01-10")

#Define the tickers we are interested in
listingTable<-paste(listingTable,".NZ",sep="")


#Download the stock history (for all tickers)
listingTable<-listingTable[-match("CO2.NZ",listingTable)]
listingTable<-listingTable[-match("MVT.NZ",listingTable)]
listingTable<-listingTable[-match("PCTHA.NZ",listingTable)]
listingTable<-listingTable[-match("MLNWC.NZ",listingTable)]
listingTable<-listingTable[-match("FIN.NZ",listingTable)]
listingTable<-listingTable[-match("FCT.NZ",listingTable)]
listingTable<-listingTable[-match("CBL.NZ",listingTable)]
listingTable<-listingTable[-match("KFLWE.NZ",listingTable)]
listingTable<-listingTable[-match("DOW.NZ",listingTable)]
listingTable<-listingTable[-match("BRMWE.NZ",listingTable)]
listingTable<-listingTable[-match("NTLOB.NZ",listingTable)]



sdata <- getSymbols(listingTable, env = stockData, src = "yahoo", from = startDate, to = endDate)

stockinf <- stockData$sdata
head(stockinf)

sdata
head(stockData$ABA.NZ)










##Get Price Data

library("BatchGetSymbols")

test<-BatchGetSymbols(
    tickers=tickers3,
    first.date = Sys.Date()-365*5,
    last.date=Sys.Date(),
    freq.data='daily',
    cache.folder=file.path(tempdir(),'BGS_Cache'),
    do.complete.data=TRUE,
    bench.ticker="%5ENZ50")
test3<-BatchGetSymbols(
    tickers=tickers5[-c(20)],
    first.date = Sys.Date()-365*5,
    last.date=Sys.Date(),
    freq.data='daily',
    cache.folder=file.path(tempdir(),'BGS_Cache'),
    do.complete.data=TRUE
    #bench.ticker="%5ENZ50")
)
str(test)
test2<-BatchGetSymbols(
    tickers="%5ENZ50",
    )
str(test2)

for(i in length(tickers))
    download.file(paste("https://query1.finance.yahoo.com/v7/finance/download/",tickers[1],".NZ?period1=1389265200&amp;period2=1547031600&amp;interval=1d&amp;events=history&amp",sep=""),destfile=paste("Price Data CSVs\\",tickers[1],".NZ.csv",sep=""),mode="wb")
    Sys.sleep(.5)
?download.file

urlList<-paste("https://nz.finance.yahoo.com/quote/",tickers,".NZ/history?period1=1389265200&period2=1547031600&interval=1d&filter=history&frequency=1d",sep="")
tooMuch<-list(mode="response",length=length(urlList))
urlList[1]
getContent<-GET(urlList[1])
parsedHtml2<-htmlParse(getContent)
parsedHtml2

##Get Headings

priceHeadTable<-xpathSApply(parsedHtml2,"//thead/tr")
priceHeadValues<-xmlSApply(priceHeadTable[[1]],function(x)xmlSApply(x,xmlValue))


## GEt body

#Everything's in a <span> except missing data
priceTable<-xpathSApply(parsedHtml2,"//tbody/tr[@class='BdT Bdc($c-fuji-grey-c) Ta(end) Fz(s) Whs(nw)']/td",xmlValue)


priceTable



split(priceTable,rep(1:7,length(priceTable)/7))

priceData<-gsub("","",priceTable[1:length(priceTable)])




?split

#result<-tryCatch({
    tooMuch<-GET(urlList[1])
    tooMuchCode<-content(tooMuch[1],as="text")
    tooMuchParsed<-htmlParse(tooMuchCode,asText=TRUE)
#}, warning = function(warning_condition){
#    print(warning_condition)
#    return(NA)
#}, error = function(error_condition){
#    print(error_condition)
#    return(NA)
#}, finally = {
#    print("Finished Processing")
#    tooMuchParsed
#})
#result

    
}


