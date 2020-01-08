library(rvest)
library(stringr)

#지니
html <- read_html('https://www.genie.co.kr/chart/musicHistory?year=2018&category=0&pg=1')
#year=yyyy4글자 / pg=1,2

#곡정보 url 
a1 <- html_nodes(html, xpath='//*[@id="body-content"]/div[4]/div[1]/table/tbody/tr/td[4]/a')%>%
  html_attr('onclick')
a1 <- str_extract(a1, '[0-9]+')
a1
# https://www.genie.co.kr/detail/songInfo?xgnm=, a1
read_html('https://www.genie.co.kr/detail/songInfo?xgnm=87663449')
html1 <- read_html(paste0('https://www.genie.co.kr/detail/songInfo?xgnm=',a1[50]))
#곡 명
html_nodes(html1, xpath='//*[@id="body-content"]/div[2]/div[2]/h2')%>%
  html_text()%>%
  str_trim()
#아티스트
html_nodes(html1, xpath='//*[@id="body-content"]/div[2]/div[2]/ul/li[1]/span[2]/a')%>%
  html_text()
#가사
html_nodes(html1, xpath='//*[@id="pLyrics"]/p')%>%
  html_text()%>%
  str_replace_all('[[:space:]]+',' ')
#장르
html_nodes(html1, xpath='//*[@id="body-content"]/div[2]/div[2]/ul/li[3]/span[2]')%>%
  html_text()

# 반복문을 통한 data 수집
df <- NULL
for (i in 1999:1999){
  html <- read_html(paste0('https://www.genie.co.kr/chart/musicHistory?year=',i,'&category=0&pg=1'))
  surl <- html_nodes(html, xpath='//*[@id="body-content"]/div[4]/div[1]/table/tbody/tr/td[4]/a')%>%
    html_attr('onclick')
  surl <- unlist(str_extract_all(surl, '[0-9]+'))
  for (j in surl){
    songinfo <- read_html(paste0('https://www.genie.co.kr/detail/songInfo?xgnm=',j))
    df <- rbind(df, data.frame(곡명=(html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/h2/text()')%>%
                                     html_text()%>%
                                     str_trim()),
                                 아티스트=(html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/ul/li[1]/span[2]/a')%>%
                                         html_text()),
                                 가사=(html_nodes(songinfo, xpath='//*[@id="pLyrics"]/p')%>%
                                       html_text()%>%
                                       str_replace_all('[[:space:]]+',' ')),
                                 장르=(html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/ul/li[3]/span[2]')%>%
                                       html_text()),
                                 연도=i)
    )
  }
}

View(df)
#19금 가사(로그인 필요)로 인한 오류 발생
#19금 가사 예외 처리
html23 <- read_html('https://www.genie.co.kr/detail/songInfo?xgnm=16266099')

html_nodes(html23, xpath='//*[@id="body-content"]/div[4]/div[1]')%>%
  html_text%>%
  str_replace_all('[[:space:]]+',' ')

html24 <- read_html('https://www.genie.co.kr/detail/songInfo?xgnm=16265420')
html_nodes(html24, xpath='//*[@id="body-content"]/div[4]/div[1]')%>%
  html_text%>%
  str_replace_all('[[:space:]]+',' ')


#1970년부터 2018년 1page만
df <- NULL
for (i in 1970:2018){
  html <- read_html(paste0('https://www.genie.co.kr/chart/musicHistory?year=',i,'&category=0&pg=1'))
  surl <- html_nodes(html, xpath='//*[@id="body-content"]/div[4]/div[1]/table/tbody/tr/td[4]/a')%>%
    html_attr('onclick')
  surl <- unlist(str_extract_all(surl, '[0-9]+'))
  for (j in surl){
    songinfo <- read_html(paste0('https://www.genie.co.kr/detail/songInfo?xgnm=',j))
    song <- html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/h2')%>%
      html_text()%>%
      str_trim()
    artist <- html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/ul/li[1]/span[2]/a')%>%
      html_text()
    lylics <- html_nodes(songinfo, xpath='//*[@id="body-content"]/div[4]/div[1]')%>%
      html_text()%>%
      str_replace_all('[[:space:]]+',' ')
    genre <- html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/ul/li[3]/span[2]')%>%
      html_text()
    
    df <- rbind(df, data.frame(곡명=song,
                                 아티스트=artist,
                                 가사=lylics,
                                 장르=genre,
                                 연도=i)
    )
  }
}
View(df)

#1984년도 부터 2page
for (i in 1984:2018){
  html <- read_html(paste0('https://www.genie.co.kr/chart/musicHistory?year=',i,'&category=0&pg=2'))
  surl <- html_nodes(html, xpath='//*[@id="body-content"]/div[4]/div[1]/table/tbody/tr/td[4]/a')%>%
    html_attr('onclick')
  surl <- unlist(str_extract_all(surl, '[0-9]+'))
  for (j in surl){
    songinfo <- read_html(paste0('https://www.genie.co.kr/detail/songInfo?xgnm=',j))
    song <- html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/h2')%>%
      html_text()%>%
      str_trim()
    artist <- html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/ul/li[1]/span[2]/a')%>%
      html_text()
    lylics <- html_nodes(songinfo, xpath='//*[@id="body-content"]/div[4]/div[1]')%>%
      html_text()%>%
      str_replace_all('[[:space:]]+',' ')
    genre <- html_nodes(songinfo, xpath='//*[@id="body-content"]/div[2]/div[2]/ul/li[3]/span[2]')%>%
      html_text()
    
    df <- rbind(df, data.frame(곡명=song,
                                 아티스트=artist,
                                 가사=lylics,
                                 장르=genre,
                                 연도=i)
    )
  }
}

View(df)
str(df)
df$곡명 <- as.vector(df$곡명)
df$아티스트 <- as.vector(df$아티스트)
df$가사 <- as.vector(df$가사)
df$장르 <- as.vector(df$장르)
write(df[df$연도<=1979,'가사'], 'c:/data/1970년대가사.txt')
write(df[df$연도>=1980 & df$연도<=1989,'가사'], 'c:/data/1980년대가사.txt')
write(df[df$연도>=1990 & df$연도<=1999,'가사'], 'c:/data/1990년대가사.txt')
write(df[df$연도>=2000 & df$연도<=2009,'가사'], 'c:/data/2000년대가사.txt')
write(df[df$연도>=2010 & df$연도<=2019,'가사'], 'c:/data/2010년대가사.txt')
write.csv(df[,-3], 'c:/data/시대별차트(지니).csv', row.names=FALSE, quote=F)
