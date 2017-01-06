# girlmerry-cli
A command-line interface to the www.girlmerry.com online fashion clothing wholesale store.

# Synopsis
The girlmerry-cli is a non-blocking and multi-threaded product page aggregator. Its primary purpose
is to render near realtime and easy to understand results to the console. Alternatively, you may export your result
lists to common file formats such as JSON, XML and CSV.

## Usage

Grab 120 results from a single product page.

    girlmerry-cli "jumpsuits.html?product_list_limit=120"

Retrieve results from a combination of product pages.

    girlmerry-cli "sexy-lingerie" "jumpsuits.html" "swimsuits"

Native www.girlmerry.com query strings can be used.

    girlmerry-cli "jumpsuits.html?product_list_limit=360&p=1"

Here's a query that retrieves nearly every single product on www.girlmerry.com.

    girlmerry-cli "clubwear-dresses" "swimwear" "jumpsuits.html?product_list_limit=360&p=1" "jumpsuits.html?product_list_limit=360&p=2" "jumpsuits.html?product_list_limit=360&p=3" "jumpsuits.html?product_list_limit=360&p=4" "top-10"


# License
MIT

# Copyright
2017 Dan Stephenson (ispyhumanfly)

