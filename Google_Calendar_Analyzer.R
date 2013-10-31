### http://stat.ethz.ch/R-manual/R-devel/library/graphics/html/hist.POSIXt.html
####################################################
# % R --vanilla --slave --args data < Analysis_of_Google_Calendar.R
# or
# % R
# > source("histgram.R")
####################################################

### read argumetns
args <- commandArgs(trailingOnly = T)
if(length(args) != 1) { # 引数の数をチェックする。引数が2つでない場合は...
    write("Error: commandline arguments for <infile> <outfile> are required", stderr())
    # エラーメッセージを表示して...
    q() # 終了する。
}

### get argument
name <- args[1]
### create file path
file <- name
file <- paste("data", name, sep="/")

### histgram
mydata <- read.table(file, header=F) # データを読み込む  header 列名があるかいなか sep 区切り文字
### 0以上でフィルタをかける
mydata <- subset(mydata, V1 >= 0)
x <- sort(mydata[,1])
size <- length(x)
interval <- 10

pdffile <- paste("pdf", name, sep="/")
pdffile <- paste(pdffile, "pdf", sep=".")
pdf(pdffile, width=8, height=6)
hist(x, breaks = seq(0,x[size]+9,interval), xaxt="n", xlab="Days", freq=TRUE)

axis(1, at=seq(0,x[size]+9,interval), las=2)
dev.off()
