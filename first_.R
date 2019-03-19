install.packages("tuber")
install.packages("httpuv")
install.packages("dplyr")
install.packages("stringr")
install.packages("tibble")
install.packages("KoNLP")
install.packages("tm")
install.packages("wordcloud2")
install.packages("RColorBrewer") 
install.packages("wordcloud")


library(tuber)
library(httpuv)
library(dplyr)
library(stringr)
library(tibble)
library(tm)
library(KoNLP)
library(wordcloud2)
useNIADic()
library(RColorBrewer)
library(wordcloud)



app_id <-"152593731585-3fu2n5m15ib2m2hpajjf7i78qvudsb9v.apps.googleusercontent.com"
app_secret<-"mEh6y9aUxeg3bHPNVRCgoIr2"
yt_oauth(app_id,app_secret,token = "")

#특정 채널에 대한 정보를 저장 
chanel_information<-yt_search(term="", type="video", channel_id = "UC-g0gSStENkYPXFRsKrlvyA")




video_cmt_bind= rbind()
#한 채널에 있는 동영상의 댓글 정보 중, 댓글 원본, 동영상 아이디,그리고 댓글 단 사용자 아이디를 데이터프레임으로 추출. 
for (i in 1:50){
  #한 채널에 있는 모든 영상(i개)의 댓글 크롤링하여 새로운 변수에 저장
  video_comments<-get_all_comments(chanel_information$video_id[i])
  ) 
  
  #아래와 같은 정보를 추출하여 데이터프레임으로 만들고, 각각 적용
  video_cmt_bind[[i]]= data.frame(video_comments$authorDisplayName, video_comments$textOriginal, video_comments$videoId)
  #리스트 형태를 rbind를 통해 matrix로 만듦
  video_to_matrix<-rbind(video_cmt_bind)
  #데이터프레임으로 만듦
  video_to_dataframe<-data.frame(do.call(rbind,video_to_matrix))
  #각각의 열 이름 변경
  names(video_to_dataframe) <- c("AuthorName", "Comments", "VideoId")
  #csv파일로 저장
  write.csv(video_to_dataframe, file = "team_coco.csv")
}