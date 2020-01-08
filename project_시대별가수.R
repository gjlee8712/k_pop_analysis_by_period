library(stringr)

#지니 (3524곡)
df <- read.csv('c:/data/시대별차트(지니).csv', header=T, stringsAsFactors=F, quote="\"'")
df$연도 <- str_replace_all(df$연도,'[0-9]$','0')
df <- unique(df)
df <- df[,c('아티스트','연도')]
total <- table(df$연도) #연도별 곡수
t <- table(df)
t
g_1970_a <- head(sort(t[,1], decreasing=T), 10)
g_1980_a <- head(sort(t[,2], decreasing=T), 10)
g_1990_a <- head(sort(t[,3], decreasing=T), 10)
g_2000_a <- head(sort(t[,4], decreasing=T), 10)
g_2010_a <- head(sort(t[,5], decreasing=T), 10)

names(g_1970_a)
gya <- data.frame(g_1970=paste0(names(g_1970_a),' ',g_1970_a,'곡'),
                  g_1980=paste0(names(g_1980_a),' ',g_1980_a,'곡'),
                  g_1990=paste0(names(g_1990_a),' ',g_1990_a,'곡'),
                  g_2000=paste0(names(g_2000_a),' ',g_2000_a,'곡'),
                  g_2010=paste0(names(g_2010_a),' ',g_2010_a,'곡'),
                  stringsAsFactors=F)
gya


#연도별 아티스트 수
df <- unique(df)
table(df)
a_total<- colSums(table(df))
a_total

gya <- rbind(gya, paste0(a_total,'명 ',total,'곡'))
gya

dimnames(gya)
colnames(gya) <- paste0(substr(colnames(gya),3,6),'년도')
gya <- cbind(순위=paste0(rownames(gya),'위'), gya)
gya$순위 <- as.vector(gya$순위)
gya$순위[11] <- 'Total' 
gya

#벅스 (5144곡 , 1970년도 이후 4584곡)
df <- read.csv('c:/data/시대별차트(벅스).csv', header=T, stringsAsFactors=F, quote="\"'")
df
df$y <- paste0(substr(df$y,1,3),'0')
df$a <- str_replace(df$a,' CONNECT 아티스트','')
df <- unique(df)
df <- df[,-1]
total <- table(df$y) #연도별 곡수
t <- table(df)
b_1940_a <- head(sort(t[,1], decreasing=T), 10)
b_1950_a <- head(sort(t[,2], decreasing=T), 10)
b_1960_a <- head(sort(t[,3], decreasing=T), 10)
b_1970_a <- head(sort(t[,4], decreasing=T), 10)
b_1980_a <- head(sort(t[,5], decreasing=T), 10)
b_1990_a <- head(sort(t[,6], decreasing=T), 10)
b_2000_a <- head(sort(t[,7], decreasing=T), 10)
b_2010_a <- head(sort(t[,8], decreasing=T), 10)

bya <- data.frame(b_1940=paste0(names(b_1940_a),' ',b_1940_a,'곡'),
                  b_1950=paste0(names(b_1950_a),' ',b_1950_a,'곡'),
                  b_1960=paste0(names(b_1960_a),' ',b_1960_a,'곡'),
                  b_1970=paste0(names(b_1970_a),' ',b_1970_a,'곡'),
                  b_1980=paste0(names(b_1980_a),' ',b_1980_a,'곡'),
                  b_1990=paste0(names(b_1990_a),' ',b_1990_a,'곡'),
                  b_2000=paste0(names(b_2000_a),' ',b_2000_a,'곡'),
                  b_2010=paste0(names(b_2010_a),' ',b_2010_a,'곡'),
                  stringsAsFactors=F)
bya


#연도별 아티스트 수
df <- unique(df)
table(df)
a_total<- colSums(table(df))

bya <- rbind(bya, paste0(a_total,'명 ',total,'곡'))
bya
dimnames(bya)
colnames(bya) <- paste0(substr(colnames(bya),3,6),'년도')
bya <- cbind(순위=paste0(rownames(bya),'위'), bya)
bya$순위 <- as.vector(bya$순위)
bya$순위[11] <- 'Total' 
bya
bya[,-2:-4]

View(gya)
View(bya[,-2:-4])
View(rbind(gya, colnames(bya)[-2:-4],bya[,-2:-4]))

# 지니 벅스 비교
a1970 <- cbind(gya[,2],gya[,1],bya[,5])
colnames(a1970) <- c('지니','순위','벅스')
View(a1970)

a1980 <- cbind(gya[,3],gya[,1],bya[,6])
colnames(a1980) <- c('지니','순위','벅스')
View(a1980)

a1990 <- cbind(gya[,4],gya[,1],bya[,7])
colnames(a1990) <- c('지니','순위','벅스')
View(a1990)

a2000 <- cbind(gya[,5],gya[,1],bya[,8])
colnames(a2000) <- c('지니','순위','벅스')
View(a2000)

a2010 <- cbind(gya[,6],gya[,1],bya[,9])
colnames(a2010) <- c('지니','순위','벅스')
View(a2010)
