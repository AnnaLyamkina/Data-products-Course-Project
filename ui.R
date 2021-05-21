#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Currency list from European Central Bank
currencies <- c("EUR", "USD", "JPY", "BGN", "CZK", "DKK", "GBP", "HUF", "PLN",
 "RON", "SEK", "CHF", "ISK", "NOK", "HRK", "RUB", "TRY", "AUD",
 "BRL", "CAD", "CNY", "HKD", "IDR", "ILS", "INR", "KRW", "MXN",
 "MYR", "NZD", "PHP", "SGD", "THB", "ZAR")



# Application for currency conversion
shinyUI(fluidPage(

    # Application title
    titlePanel("Currency conversion calculator"),

    # Set layout for input
    sidebarLayout(
        sidebarPanel(
            selectInput('cur1_in', 'Select currency for conversion from', currencies, selectize=FALSE),
            selectInput('cur2_in', 'Select currency for conversion to', currencies, selectize=FALSE),
            textInput('value_in', 'Sum', value = "1")
        ),
     #Output and plot of exchange rates
           mainPanel(
            textOutput('out'),
            plotOutput(outputId = "curPlot", width = "100%")
            
        )
    )
))
