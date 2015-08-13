# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data

We will import this as a CSV file and leave it as is for this analysis. Let's also make sure everything in each column is in the right format. 


```r
activitydata<-read.csv("activity.csv")
activitydata$steps<-as.numeric(activitydata$steps)
head(activitydata)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```

```r
summary(activitydata)
```

```
##      steps                date          interval     
##  Min.   :  0.00   2012-10-01:  288   Min.   :   0.0  
##  1st Qu.:  0.00   2012-10-02:  288   1st Qu.: 588.8  
##  Median :  0.00   2012-10-03:  288   Median :1177.5  
##  Mean   : 37.38   2012-10-04:  288   Mean   :1177.5  
##  3rd Qu.: 12.00   2012-10-05:  288   3rd Qu.:1766.2  
##  Max.   :806.00   2012-10-06:  288   Max.   :2355.0  
##  NA's   :2304     (Other)   :15840
```

```r
str(activitydata)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : Factor w/ 61 levels "2012-10-01","2012-10-02",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```

## What is mean total number of steps taken per day?

Here is a histogram of the total number of steps taken each day:


```r
totaldailysteps<-tapply(activitydata$steps,activitydata$date,sum,na.rm=TRUE)
hist(totaldailysteps, xlab = "Total Daily Steps", main = "Histogram of Total Daily Steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-2-1.png) 

Here is the median of the total number of steps taken each day:

```r
median(totaldailysteps)
```

```
## [1] 10395
```

Here is the mean of the total number of steps taken each day:

```r
mean(totaldailysteps)
```

```
## [1] 9354.23
```
## What is the average daily activity pattern?

First, we will extract the average number of steps per interval. Then we will plot the daily activity pattern.


```r
intervalmean<-tapply(activitydata$steps,activitydata$interval,mean,na.rm=TRUE)
plot(x=dimnames(intervalmean)[[1]],y=intervalmean,type="l", main = "Average Daily Activity Pattern", xlab = "Intervals - 5 Minutes", ylab = "Interval Means")
```

![](PA1_template_files/figure-html/unnamed-chunk-5-1.png) 

The following 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps:


```r
cat("Interval",names(which.max(intervalmean)),"\n","Average",max(intervalmean))
```

```
## Interval 835 
##  Average 206.1698
```

## Imputing missing values

There seems to be a notable number of missing values. Let's take a look:

```r
sum(is.na(activitydata$steps))
```

```
## [1] 2304
```
Let's try to fill the missing values with the means for those intervals. First, we will create a copy of the data set so we can fill it. Next, we will create a loop to replace the NAs. 


```r
activitydata2<-activitydata

for(i in 1:nrow(activitydata2))
    {
        if(is.na(activitydata2$steps[i]))
        {
            k<-activitydata2$interval[i]
            k<-as.character(k)
            activitydata2$steps[i]=intervalmean[intervalmean=k]
        }
    }
```

Let's see how filling in the missing values affected the data.


```r
totaldailysteps2<-tapply(activitydata2$steps,activitydata2$date,sum)
hist(totaldailysteps2, xlab = "Total Daily Steps", main = "Histogram of Total Daily Steps with NAs Replaced")
```

![](PA1_template_files/figure-html/unnamed-chunk-9-1.png) 

The data have gravitated more towards the center. What happened to the daily mean and median?

Median:

```r
median(totaldailysteps2)
```

```
## [1] 10766.19
```

Mean:

```r
mean(totaldailysteps2)
```

```
## [1] 10766.19
```

These values differ from the first data set. The distribution has shifted slightly to the right. The spread of the distribution has been compressed a little bit tighter around the mean. 

How many zeros are there?

```r
sum(activitydata2$steps==0,na.rm=TRUE)
```

```
## [1] 11166
```

```r
sum(activitydata$steps==0,na.rm=TRUE)
```

```
## [1] 11014
```

There are more zeros in the filled data set because some of the interval means were zero for some days. The loop filled in those intervals with zeros.

## Are there differences in activity patterns between weekdays and weekends?

First let's create a third data frame to store our changes and remove the factor levels from dates.


```r
activitydata3<-activitydata
activitydata3$date<-as.POSIXlt(activitydata3$date)
```

Next we will see if the weekday name of the dates column is either a "Saturday" or "Sunday". The %in% function returns either a TRUE or a FALSE for each date and we will use that to create a new column so we know what part of the week we are in. The labels for this new column will be "Weekend" and "Weekday".


```r
activitydata3$weekpart<-factor((weekdays(activitydata3$date) %in% c('Saturday','Sunday')),levels=c(TRUE,FALSE),labels=c('Weekend','Weekday'))
summary(activitydata3)
```

```
##      steps             date                        interval     
##  Min.   :  0.00   Min.   :2012-10-01 00:00:00   Min.   :   0.0  
##  1st Qu.:  0.00   1st Qu.:2012-10-16 00:00:00   1st Qu.: 588.8  
##  Median :  0.00   Median :2012-10-31 00:00:00   Median :1177.5  
##  Mean   : 37.38   Mean   :2012-10-31 00:25:34   Mean   :1177.5  
##  3rd Qu.: 12.00   3rd Qu.:2012-11-15 00:00:00   3rd Qu.:1766.2  
##  Max.   :806.00   Max.   :2012-11-30 00:00:00   Max.   :2355.0  
##  NA's   :2304                                                   
##     weekpart    
##  Weekend: 4608  
##  Weekday:12960  
##                 
##                 
##                 
##                 
## 
```

Now let's get the interval means for the Weekends and Weekdays. First we will subset the data into two different data frames. We will then get the means for the time intervals in the "intervalmeanweekday" and "intervalmeanweekend" data frames. We will then combine the interval means into their own matrix. That matrix will then be converted into a time series object in R so it can be plotted using the xyplot function.

```r
activitydataweekday<-subset(activitydata3,weekpart=="Weekday")
activitydataweekend<-subset(activitydata3,weekpart=="Weekend")

intervalmeanweekday<-tapply(activitydataweekday$steps,activitydataweekday$interval,mean,na.rm=TRUE)
intervalmeanweekend<-tapply(activitydataweekend$steps,activitydataweekend$interval,mean,na.rm=TRUE)

weekpartintervalmeans<-cbind(intervalmeanweekend,intervalmeanweekday)

colnames(weekpartintervalmeans)[1]<-c("Weekend")
colnames(weekpartintervalmeans)[2]<-c("Weekday")

weekpartintervalmeans<-as.ts(weekpartintervalmeans)

library(lattice)

xyplot(weekpartintervalmeans,xlab="Intervals - 5 Minutes",ylab="Steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-15-1.png) 

We can see that there is more activity on the Weekends later in the day.
