## Getting data from the FitBit App

## Open connection point - all args in quotes
openConnection <- function(app, my_key, my_secret) {
  require(httr)
  require(httpuv)
  require(rjson)

  token_url = "https://api.fitbit.com/oauth/request_token"
  access_url = "https://api.fitbit.com/oauth/access_token"
  auth_url = "https://www.fitbit.com/oauth/authorize"
  key = my_key
  secret = my_secret

  fbr = oauth_app(app,key,secret)
  fitbit = oauth_endpoint(token_url,auth_url,access_url)
  token = oauth1.0_token(fitbit,fbr)
  sig <-config(token = token)
  sig
}

## Get user data
getUser <- function() {
  user_url<-"https://api.fitbit.com/1/user/-/profile.json"
  user=GET(user_url, sig)
  user<-iconv(user[6])
  user<-fromJSON(user)
  profile<-c(user$user$displayName, user$user$dateOfBirth, user$user$height, user$user$weight)
  names(profile)<-c("name", "birthdate", "height", "weight")
  profile
}

## get steps from a date range - dates formatted 'yyyy-mm-dd'
getSteps <- function(start_date, end_date) {
  steps_url=paste("https://api.fitbit.com/1/user/-/activities/steps/date/", start_date, "/", end_date, ".json", sep="")
  steps<-GET(steps_url, sig)
  steps<-iconv(steps[6])
  steps<-fromJSON(steps)
  steps<-steps$activities
  steps<-do.call(rbind, lapply(steps, data.frame, stringsAsFactors=FALSE))
  steps$dateTime<-as.Date(steps$dateTime)
  steps$value<-as.numeric(steps$value)
  steps
}

## get calories for the day - dates formatted 'yyyy-mm-dd'
getCalories <- function(start_date, end_date) {
  calories_url<-paste("https://api.fitbit.com/1/user/-/activities/calories/date/", start_date, "/", end_date, ".json", sep="")
  calories<-GET(calories_url, sig)
  calories<-iconv(calories[6])
  calories<-fromJSON(calories)
  calories<-calories$`activities-calories`
  calories<-do.call(rbind, lapply(calories, data.frame, stringsAsFactors=FALSE))
  calories$dateTime<-as.Date(steps$dateTime)
  calories$value<-as.numeric(calories$value)
  calories
}

## get foods for a given date in format 'yyyy-mm-dd'
getCaloriesIn <-function(start_date, end_date) {
  calsIn_url<-paste("https://api.fitbit.com/1/user/-/foods/log/caloriesIn/date/", start_date,"/",end_date,".json", sep="")
  calsIn<-GET(calsIn_url,sig)
  calsIn<-iconv(calsIn[6])
  calsIn<-fromJSON(calsIn)
  calsIn<-calsIn$`foods-log-caloriesIn`
  calsIn<-do.call(rbind, lapply(calsIn, data.frame, stringsAsFactors=FALSE))
  calsIn$dateTime<-as.Date(calsIn$dateTime)
  calsIn$value<-as.numeric(calsIn$value)
  calsIn
}


