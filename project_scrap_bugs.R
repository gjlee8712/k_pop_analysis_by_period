library(rvest)
library(stringr)

#벅스 연도별 html
html <- read_html('https://music.bugs.co.kr/years')
#각 연도별 link 정보
yurl <- html_nodes(html, xpath='//*[@id="container"]/section/div/ul/li/figure/figcaption/a[1]')%>%
  html_attr('href')
#연도별 text
year <- html_nodes(html, xpath='//*[@id="container"]/section/div/ul/li/figure/figcaption/a[1]')%>%
  html_text()

#1개 연도별 곡리스트
album <- read_html(yurl[1])
#곡명 정보
html_nodes(album, xpath='//*[@id="ESALBUM30871"]/table/tbody/tr/th/p/a')%>%
  html_text()
#아티스트 정보 
html_nodes(album, xpath='//*[@id="ESALBUM30871"]/table/tbody/tr/td[4]/p/a/text()')%>%
  html_text()
#1곡에 아티스트가 2명이상일경우 데이터가 늘어남
#1개 연도의 top 100 테이블 정보
tab <- html_nodes(album, 'table')
tab[[2]]
tab <- html_table(tab[[2]])
song <- tab[,4]
song
artist <- tab[,5]
artist
#1곡의 아티스트가 2명이상이 경우 데이터가 중복
#곡의 가사 링크
surl <- html_nodes(album, xpath='//*[@id="ESALBUM30871"]/table/tbody/tr/td[3]/a')%>%
  html_attr('href')
#1곡 정보 
songinfo <- read_html(surl[87])
#곡 명
html_nodes(songinfo, xpath='//*[@id="container"]/header/div/h1')%>%
  html_text()%>%
  str_trim()
#아티스트
html_nodes(songinfo, xpath='//*[@id="container"]/section[1]/div/div[1]/table/tbody/tr[1]/td')%>%
  html_text()%>%
  str_trim()%>%
  str_replace_all('[[:space:]]+',' ')
#곡 가사
html_nodes(songinfo, xpath='//*[@id="container"]/section[2]/div/div/xmp')%>%
  html_text()%>%
  str_replace_all('[[:space:]]+',' ')

#xpath 경로 확인
yurl[2]
album <- read_html(yurl[2])
surl <- html_nodes(album, xpath='//*[@id="ESALBUM30871"]/table/tbody/tr/td[3]/a')%>%
  html_attr('href')
surl
# //*[@id="ESALBUM25698"]/table/tbody/tr[1]/td[3]/a
# //*[@id="ESALBUM25698"]/table/tbody/tr[2]/td[3]/a

str_extract(yurl[2],'[0-9]+')
html_nodes(album, xpath=paste0('//*[@id="ESALBUM',str_extract(yurl[2],'[0-9]+'),'"]/table/tbody/tr/td[3]/a'))%>%
  html_attr('href')


html_nodes(songinfo, xpath='//*[@id="container"]/section[2]/div/div/xmp')%>%
  html_text()%>%
  str_replace_all('[[:space:]]+',' ')

#19금 가사 오류 해결
html_nodes(songinfo, xpath='//*[@id="container"]/section[2]/div/div')%>%
  html_text()

# 재생불가한 노래 가사 경로 오류 해결 
song
artist
lylics
html_nodes(songinfo, xpath='//*[@id="container"]/section[2]/div/div')%>%
  html_text()
html_nodes(songinfo, xpath='//*[@id="container"]/section/div/div')%>%
  html_text()
html_nodes(songinfo, '.lyricsContainer')%>%
  html_text()




# 최종 반복문
html <- read_html('https://music.bugs.co.kr/years')
yurl <- html_nodes(html, xpath='//*[@id="container"]/section/div/ul/li/figure/figcaption/a[1]')%>%
  html_attr('href')
year <- html_nodes(html, xpath='//*[@id="container"]/section/div/ul/li/figure/figcaption/a[1]')%>%
  html_text()
df <- NULL
for (i in 1:length(yurl)){
  album <- read_html(yurl[i])
  surl <- html_nodes(album, xpath=paste0('//*[@id="ESALBUM',str_extract(yurl[i],'[0-9]+'),'"]/table/tbody/tr/td[3]/a'))%>%
    html_attr('href')
  for (j in 1:length(surl)){
    songinfo <- read_html(surl[j])
    song <- html_nodes(songinfo, xpath='//*[@id="container"]/header/div/h1')%>%
      html_text()%>%
      str_trim()
    artist <- html_nodes(songinfo, xpath='//*[@id="container"]/section[1]/div/div[1]/table/tbody/tr[1]/td')%>%
      html_text()%>%
      str_trim()%>%
      str_replace_all('[[:space:]]+',' ')
    lylics <- html_nodes(songinfo, '.lyricsContainer')%>%
      html_text()%>%
      str_replace_all('[[:space:]]+',' ')
    df <- rbind(df, data.frame(s=song,
                               a=artist,
                               l=lylics,
                               y=year[i]))
  }
}

View(df)

str(df)
df$s <- as.vector(df$s)
df$a <- as.vector(df$a)
df$l <- as.vector(df$l)
df$y <- as.vector(df$y)
df$y
write(df[substr(df$y, 1, 4)<=1949,'l'],'c:/data/1940년대가사(벅스).txt')
write(df[substr(df$y, 1, 4)>=1950 & substr(df$y, 1, 4)<=1959,'l'],'c:/data/1950년대가사(벅스).txt')
write(df[substr(df$y, 1, 4)>=1960 & substr(df$y, 1, 4)<=1969,'l'],'c:/data/1960년대가사(벅스).txt')
write(df[substr(df$y, 1, 4)>=1970 & substr(df$y, 1, 4)<=1979,'l'],'c:/data/1970년대가사(벅스).txt')
write(df[substr(df$y, 1, 4)>=1980 & substr(df$y, 1, 4)<=1989,'l'],'c:/data/1980년대가사(벅스).txt')
write(df[substr(df$y, 1, 4)>=1990 & substr(df$y, 1, 4)<=1999,'l'],'c:/data/1990년대가사(벅스).txt')
write(df[substr(df$y, 1, 4)>=2000 & substr(df$y, 1, 4)<=2009,'l'],'c:/data/2000년대가사(벅스).txt')
write(df[substr(df$y, 1, 4)>=2010 & substr(df$y, 1, 4)<=2019,'l'],'c:/data/2010년대가사(벅스).txt')
write.csv(df[,-3], 'c:/data/시대별차트(벅스).csv', row.names=FALSE, quote=F)