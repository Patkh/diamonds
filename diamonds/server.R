#
# Server.R
#
# This application provides a GUI and a server to draw a plot using
# diamonds dataset. This is a dataset containing the prices
# and other attributes of almost 54,000 diamonds. You can
# choose the variables to plot on X and Y axis. In addition
# you can choose the factor variable to group the columns into.
#
# You can use a brush to select a data-frame and the selected
# row count is displayed at bottom of the screen. The selected
# rows are displayed in a different tab.
#
# Hemant
# version 1.0

library(shiny)
library(ggplot2)
library(dplyr)

data(diamonds)

# Take a subset of rows from the diamonds dataset
set.seed(1250)
d <- sample_n(diamonds, 5000, replace = FALSE)

# Define server logic
shinyServer(function(input, output) {
  observe_helpers()
  
  x1 <- reactive(input$inputXcol)
  y1 <- reactive(input$inputYcol)
  grpby <- reactive(input$groupby)
  inpb <- reactive(input$brush1)
  
  validateColumns <- function(gby, xcol, ycol) {
    if (gby == ycol || gby == xcol || xcol == ycol) {
      output$dplot <- renderPlot(NULL)
      output$subtable <- renderTable(NULL)
      output$msg <- renderText("X, Y and Group By columns cannot be equal.
                Re-submit!!")
      return(0)
    }
    return(1)
  }
  
  observe({
    #message("Processing brush...")
    inpb()
    xcol = isolate(input$inputXcol)
    ycol = isolate(input$inputYcol)
    gby  = isolate(input$groupby)
    ret <- validateColumns(gby, xcol, ycol)
    if (ret == 0)
      return(NULL)
    if (!(is.null(inpb()))) {
      if (gby == "None")
        df <- brushedPoints(d, input$brush1,
                            xvar = xcol,
                            yvar = ycol)
      else
        df <- brushedPoints(
          d,
          input$brush1,
          xvar = xcol,
          yvar = ycol,
          panelvar1 = gby
        )
      
      brushed_data <- df
      output$subtable <- renderTable(brushed_data)
      output$msg <-
        renderText(paste0("Plot of ", ycol, " ~ ", xcol))
      if (nrow(brushed_data) > 0) {
        output$bcols <- renderText(paste0(nrow(brushed_data),
                                          " rows selected"))
      }  else
        output$bcols <-
        renderText("Note: You can use a brush to select rows")
      return(NULL)
    } else {
      output$bcols <-
        renderText("Note: You can use a brush to select rows")
      output$subtable <- renderTable(NULL)
      return(NULL)
    }
  })
  
  observe({
    xcol = input$inputXcol
    ycol = input$inputYcol
    gby  = input$groupby
    
    output$dplot <- renderPlot({
      output$msg <- renderText(NULL)
      output$bcols <- renderText(NULL)
      output$subtable <- renderTable(NULL)
      xcol = input$inputXcol
      ycol = input$inputYcol
      gby  = input$groupby
      ret <- validateColumns(gby, xcol, ycol)
      if (ret == 0)
        return(NULL)
      output$msg <-
        renderText(paste0("Plot of ", ycol, " ~ ", xcol))
      output$bcols <-
        renderText("Note: You can use a brush to select rows")
      g <- ggplot(data = d, aes(
        x = .data[[xcol]],
        y = .data[[ycol]],
        color = clarity
      )) +
        theme_bw() + xlab(xcol) +
        ggtitle(paste0("Diamond Price Distribution by ", xcol)) +
        geom_point()
      
      if (!(gby == "None"))
        g <- g + facet_grid( ~ .data[[gby]])
      g
    })
  })
})