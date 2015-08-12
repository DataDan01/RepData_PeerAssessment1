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

## What is mean total number of steps taken per day?

Here is a histogram for the total number of steps taken each day:


```r
totaldailysteps<-tapply(activitydata$steps,activitydata$date,sum,na.rm=T)
hist(totaldailysteps, xlab = "Total Daily Steps", main = "Frequency of Total Daily Steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-2-1.png) 

Here is the median of the total number of steps taken each day:


```r
median(totaldailysteps)
```

```
## [1] 10395
```

Here is the mean of the total number of steps take each day:

```r
mean(totaldailysteps)
```

```
## [1] 9354.23
```
## What is the average daily activity pattern?



## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?
