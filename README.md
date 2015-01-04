RFitZip
=======

R functions for easy use of the FitBit API for data collected by the FitBit Zip

(in development)

The FitBit API allows developer access to data without signing up for premium membership. It will allow you to get data according to your own specific requests. This project provides/will provide the tools to access FitBit data in R. It does not provide authentications for general use. To get your own OAuth codes, please visit:

https://dev.fitbit.com/apps/new

You will need to assure that the httr, httpuv, and jsonlite packages are installed, then source the R code.

Now you can use the functions:

openConnection(app, my_key, my_secret) (all arguments should be in quotes)
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


getSteps(start_date, end_date) (dates to be given as "yyyy-mm-dd" in quotes)

    > steps<-getSteps("2014-12-31", "2015-01-02")
    > steps
    $`activities-steps`
        dateTime value
    1 2014-12-31  6129
    2 2015-01-01  5108
    3 2015-01-02  9244

*The backbone of the oauth code was found at http://sidderb.wordpress.com/2013/09/09/accessing-fitbit-data-in-r/ before being updated and turned into a function.
