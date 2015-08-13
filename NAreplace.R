for(i in 1:nrow(activitydata2))
    {
        if(is.na(activitydata2$steps[i]))
        {
            k<-activitydata2$interval[i]
            k<-as.character(k)
            activitydata2$steps[i]=intervalmean[intervalmean=k]
        }
    }