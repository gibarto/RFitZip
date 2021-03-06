RFitZip
=======

R functions for easy use of the FitBit API for data collected by the FitBit Zip

(in development)

The FitBit API allows developer access to data without signing up for premium membership. It will allow you to get data according to your own specific requests. This project provides/will provide the tools to access FitBit data in R. It does not provide authentications for general use. To get your own OAuth codes, please visit:

https://dev.fitbit.com/apps/new

You will need to assure that the httr, httpuv, and rjson packages are installed, then source the R code.

Now you can use the functions:

openConnection(`app, my_key, my_secret`) (all arguments should be in quotes)

Opens a connection to the FitBit data. You should map the result to sig*:

    > sig <- openConnection("your app name", "your key", "your secret")
    >

getUser()

Returns an atomic vector with the user's display name, date of birth, height and weight:

    > getUser()
    > user
           name    birthdate       height       weight 
          "Geoff" "1972-06-15"      "165.1"       "86.1" 
    > user["name"]
      name 
    "Geoff" 
    > 


getSteps(`start_date, end_date`) (dates to be given as "yyyy-mm-dd" in quotes)

Returns a data frame with dateTime as a date object and value equal to steps
 
    > steps<-getSteps("2015-01-01", "2015-01-05")
    > steps
        dateTime value
    1 2015-01-01  5108
    2 2015-01-02  9244
    3 2015-01-03  3681
    4 2015-01-04  6365
    5 2015-01-05  6371
    > 

getCalories(`start_date, end_date`) (dates to be given as "yyyy-mm-dd" in quotes)

Returns a data frame with dateTime as a date object and value equal to calories burned

    > calories<-getCalories("2015-01-01", "2015-01-05")
    > calories
         dateTime value
    1  2015-01-01  2087
    2  2015-01-02  2407
    3  2015-01-03  2013
    4  2015-01-04  2153
    5  2015-01-05  2182
    > 

getCaloriesIn(`start_date, end_date`) (dates to be given as "yyyy-mm-dd" in quotes)

Returns a data frame with dateTime as a date object and value equal to calories consumed

    > calsIn<-getCaloriesIn("2015-01-01", "2015-01-05")
    > calsIn
        dateTime value
    1 2015-01-01  1645
    2 2015-01-02  2703
    3 2015-01-03  1920
    4 2015-01-04  2780
    5 2015-01-05  1898
    > 

getSurplusCals(`start-date, end-date`) (dates to be given as "yyyy-mm-dd" in quotes)

Returns an atomic vector with the total and average number of calories consumed minus those burned. A negative number indicates more calories burned than eaten.

    > surplus<-getSurplusCals("2015-01-01", "2015-01-05")
    > surplus
      total average 
      104.0    20.8 
    > 

More functions to come!

*The backbone of the oauth code was found at http://sidderb.wordpress.com/2013/09/09/accessing-fitbit-data-in-r/ before being updated and turned into a function. Make sure to map to sig, because the other functions need the oauth generated to access the API.
