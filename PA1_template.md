# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data

We will import this as a CSV file and leave it as is for this analysis. 


```r
activitydata<-read.csv("activity.csv")
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

## What is mean total number of steps taken per day?

Here is a histogram for the total number of steps taken each day:


```r
totaldailysteps<-tapply(activitydata$steps,activitydata$date,sum,na.rm=TRUE)
hist(totaldailysteps, xlab = "Total Daily Steps", main = "Histogram of Total Daily Steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-2-1.png) 

Here is the median of the total number of steps taken each day:


```r
allmedians<-tapply(activitydata$steps,activitydata$date,median,na.rm=TRUE)
summary(allmedians)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##       0       0       0       0       0       0       8
```

Here is the mean of the total number of steps take each day:

```r
allmeans<-tapply(activitydata$steps,activitydata$date,mean,na.rm=TRUE)
summary(allmeans)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##  0.1424 30.7000 37.3800 37.3800 46.1600 73.5900       8
```
## What is the average daily activity pattern?

Fist, we will extract the average number of steps per interval. Then we will plot the daily activity pattern.


```r
intervalmean<-tapply(activitydata$steps,activitydata$interval,mean,na.rm=TRUE)
plot(x=dimnames(intervalmean)[[1]],y=intervalmean,type="l", main = "Daily Activity Pattern", xlab = "Intervals - 5 Minutes", ylab = "Interval Means")
```

![](PA1_template_files/figure-html/unnamed-chunk-5-1.png) 

## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?
