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
  user<-fromJSON(user, flatten=TRUE)
  profile<-c(user$user$displayName, user$user$dateOfBirth, user$user$height, user$user$weight)
  names(profile)<-c("name", "birthdate", "height", "weight")
  profile
}

## get steps from a date range - dates formatted 'yyyy-mm-dd'
getSteps <- function(start_date, end_date) {
  steps_url=paste("https://api.fitbit.com/1/user/-/activities/steps/date/", start_date, "/", end_date, ".json", sep="")
  steps=GET(steps_url, sig)
  steps<-iconv(steps[6])
  steps<-fromJSON(steps)
  steps<-steps$activities
  steps<-do.call(rbind, lapply(steps, data.frame, stringsAsFactors=FALSE))
  steps$dateTime<-as.Date(steps$dateTime)
  steps$value<-as.numeric(steps$value)
  steps
}


