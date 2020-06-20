#!/bin/sh

# default symbol
symbol='AAPL'

# loop while string is not empty
while [ -n $symbol ]; do

    # get user input
    echo "Input stock symbol (eg. AAPL, GOOG, MSFT):"
    read symbol
    if [ -z $symbol ]; then
        exit 0
    fi

    # get stock quote
    quote=$(wget https://financialmodelingprep.com/api/v3/quote/$symbol\?apikey=$1 -q -O -)

    # print out table of stock quote
    echo "${quote}" | awk -F: 'BEGIN{
      printf ("\n%s\t%s\t%s\n","Symbol", "Company Name", "Price ($ USD)")
    }
    /symbol/ { gsub(/\"|,|\s/,""); printf ("%s\t", $2) }
    /name/ { gsub(/\"|,|\s/,""); printf ("%s\t", $2) }
    /priceAvg50/ { gsub(/\"|,|\s/,""); printf ("%s\n\n", $2) }'

done

exit 0
