#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Currency list and euro exchange rate from European Central Bank
currencies <- c("EUR", "USD", "JPY", "BGN", "CZK", "DKK", "GBP", "HUF", "PLN",
 "RON", "SEK", "CHF", "ISK", "NOK", "HRK", "RUB", "TRY", "AUD",
 "BRL", "CAD", "CNY", "HKD", "IDR", "ILS", "INR", "KRW", "MXN",
 "MYR", "NZD", "PHP", "SGD", "THB", "ZAR")
euro_today <- c(1, 1.2203, 132.95, 1.9558, 25.519, 7.4364, 
 0.86400, 350.60, 4.5153, 4.9278, 10.1813, 
 1.0991, 149.30, 10.1775, 7.5095, 89.8263, 
 10.2114, 1.5736, 6.4567, 1.4778, 7.8563, 9.4726,
 17589.83, 3.9849, 89.1630, 1379.90, 24.2825, 
 5.0594, 1.6986, 58.410, 1.6261, 38.305, 17.1639)
names(euro_today) <- currencies
df <- as.data.frame(outer(1 / euro_today, euro_today))


shinyServer(function(input, output) {
    # read in currency names
    cur1 <- reactive({paste(input$cur1_in)})
    cur2 <- reactive({paste(input$cur2_in)})
    #Plot exchange rates for euro 
    output$curPlot <- renderPlot({
        g <- ggplot(df, aes(x=colnames(df), y = df[,c(cur1())]))
        g <-g + labs(caption = "Euro Foreign Exchange Reference Rates as of 20 May 2021 by European Central Bank") +
             xlab(" ") + ylab(" ") + theme_bw()
        g <- g + theme(axis.text.x = element_text(angle = 90))
        g + geom_bar(stat="identity")
    }, height = 300, width = 500 
    )
    # Calculate conversion rate for selected currencies and corresponding sum
    output$out <- renderText({
        value_in <- as.numeric(input$value_in)
        convrate <- df[c(cur1()), c(cur2())]
        value_out <- round(convrate*value_in, 2)
        paste(value_in, cur1(), 
              "equals to", value_out, cur2(),
              "with the conversion rate of", round(convrate, 2))
     })
    

    
})
