library(stringr)
library(reshape2)
library(ggplot2)

df <- read.csv('c:/data/시대별차트(지니).csv', header=T, quote="\"'")
df$대분류 <- str_extract(df$장르,'^.+?/ ')
df$소분류 <- str_extract(df$장르, ' /.+')

df$대분류 <- substr(df$대분류,1,nchar(df$대분류)-3)
df$소분류 <- substr(df$소분류,4,nchar(df$소분류))

View(df)
str(df)
df$곡명 <- as.vector(df$곡명)
df$아티스트 <- as.vector(df$아티스트)
df <- df[,c(2,3,5,6,7)]
df$연도 <- str_replace(df$연도, '.$', '0')
df$연도 <- as.integer(df$연도)
str(df)

df$소분류 <- str_replace(df$소분류, '전체', '미분류')
df[df$대분류 != '가요','소분류'] <- df[df$대분류 != '가요','대분류']
df$소분류 <- str_replace(df$소분류, '동요/태교', '기타')
df$소분류 <- str_replace(df$소분류, '그외장르', '기타')
df$소분류 <- str_replace(df$소분류, '인디', '기타')
df$소분류 <- str_replace(df$소분류, '재즈', '기타')
df$소분류 <- str_replace(df$소분류, '일렉트로니카', '기타')
df$소분류 <- str_replace(df$소분류, 'CCM', '기타')
df$소분류 <- str_replace(df$소분류, '국악', '기타')

View(df)

t <- tapply(df$곡명, list(df$연도,df$소분류),length, default=0)
t
str(t)
class(t)
prop <- t/rowSums(t)
g <- t(prop)*100
g


dg <-data.frame(장르=rownames(g), g)
rownames(dg) <-NULL

dg <- reshape2::melt(dg,id='장르')
dg
colnames(dg)[2:3] <-c('연도', '비율')
dg$연도 <- substr(dg$연도,2,5)

ggplot(dg, aes(x=연도, y=비율, fill=장르))+
  geom_bar(stat='identity')+
  geom_text(aes(y=비율, label=paste0(round(비율),'%')), 
            col='black', size=4, 
            position=position_stack(vjust=0.5))


