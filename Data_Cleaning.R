#necessary libraries and download the dataset
library(ggplot2)
library(dplyr)
library(stargazer)
fileroot_rawdata = c("/Users/ekaterinafedorova/Documents/Econ 191/Data/Disabled DiD")
fileroot_finaldata = c("/Users/ekaterinafedorova/Documents/Econ 191/Data/Cleaned")
hashtags = c("disabledtiktok", "disabilitytiktok", "disability","disabled", "queertiktok", "lgbtqtiktok", "doctorsoftiktok","kidsoftiktok", "musiciansoftiktok", "musictiktok", "tiktokmusic", "tiktokmusicians", "gaytiktok", "lgbttiktok")
filenames = paste0(hashtags, "_videos.csv")

#import all csvs
for(r in 1:length(hashtags)){
  assign(hashtags[r], read.csv(file.path(fileroot_rawdata, filenames[r])))
  assign(hashtags[r], get(hashtags[r]) %>% mutate(timestamp = 0, era = NA))
  assign(paste0(hashtags[r], "_cleaned"), get(hashtags[r])[1,])
}

#Add timestamps (days) and pre/post
for(h in 1:length(hashtags)){
  for (t in 1:37){
    temp = (get(hashtags[h]) %>% filter(video_time > (1601452400 + 2*86400 * (t-1)) & video_time < (1601452400 + 2*86400 * (t)) ))
    temp$timestamp = t
    if (t <32){
      temp$era = 0
    }
    else{
      if(t > 32){
        temp$era = 1
      }
    }
    assign(paste0(hashtags[h], "_cleaned"), rbind(get(paste0(hashtags[h], "_cleaned")), temp))
  }
  assign(paste0(hashtags[h], "_cleaned"),get(paste0(hashtags[h], "_cleaned")) %>% filter(timestamp>0))
}

#Add treatment dummy, 3 is the last disability related tag index, be sure to change if necessary.
for(h in 1:length(hashtags)){
  if(h > 4){
    temp = get(paste0(hashtags[h], "_cleaned"))
    temp$awarenessday = 0
    assign(paste0(hashtags[h], "_cleaned"), temp)
  }
  else{
    temp = get(paste0(hashtags[h], "_cleaned"))
    temp$awarenessday = 1
    assign(paste0(hashtags[h], "_cleaned"), temp)
  }
}

#combining all of disability videos & music videos and queer tiktoks
disabilityvideos_all = rbind(disability_cleaned, disabilitytiktok_cleaned)
disabilityvideos_all = rbind(disabilityvideos_all, disabled_cleaned)
disabilityvideos_all = rbind(disabilityvideos_all, disabledtiktok_cleaned)
disabilityvideos_all = unique(disabilityvideos_all)

musicvideos_all = rbind(musiciansoftiktok_cleaned, musictiktok_cleaned)
musicvideos_all = rbind(musicvideos_all, tiktokmusic_cleaned)
musicvideos_all = rbind(musicvideos_all, tiktokmusicians_cleaned)
musicvideos_all = unique(musicvideos_all)

lgbtqvideos_all = rbind(gaytiktok_cleaned, queertiktok_cleaned)
lgbtqvideos_all = rbind(lgbtqvideos_all, lgbttiktok_cleaned)
lgbtqvideos_all = rbind(lgbtqvideos_all, lgbtqtiktok_cleaned)
lgbtqvideos_all = unique(lgbtqvideos_all)

disxmusic = rbind(disabilityvideos_all, musicvideos_all)
disxlgbtq = rbind(disabilityvideos_all, lgbtqvideos_all)

disxmusic$interaction = disxmusic$era*disxmusic$awarenessday
disxlgbtq$interaction = disxlgbtq$era*disxlgbtq$awarenessday

disabilityvideos_all = filter(disabilityvideos_all, n_plays<50000000)
lgbtqvideos_all = filter(lgbtqvideos_all, n_plays<50000000)

#Checking for outliers
disxlgbtq = filter(disxlgbtq, n_plays<50000000)
disxmusic = filter(disxmusic, n_plays<50000000)
test = droplevels(disxlgbtq)

#Saving data
write.csv(disxlgbtq, file.path(fileroot_finaldata, "disxlgbtq"))

write.csv(disabilityvideos_all, file.path(fileroot_finaldata, "disabilityvideos_all"))
write.csv(lgbtqvideos_all, file.path(fileroot_finaldata, "lgbtqvideos_all"))
