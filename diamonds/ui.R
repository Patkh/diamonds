#
# ui.R
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
library(shinyhelper)
library(magrittr)

# Define UI for application that draws a plot
shinyUI(fluidPage(
    # Application title
    titlePanel("      Exploring Diamonds Dataset      ")  %>%
        helper(
            icon = "question",
            size = "m",
            type = "inline",
            title = "application help",
            content = "</p>
            This application is designed to help draw plots to perform
            exploratory analysis using diamonds dataset from ggplot2 package </p>
            <p> Diamonds dataset containing the prices and other attributes of almost
            54,000 diamonds. The server uses 5000 rows from the diamonds
            datset, sampled using a random sampling mechanism </p>
            <p> Once the application starts, a plot of price vs carat appears.
            You can use a <b> brush </b> to select a subset of rows from the data-frame.
            The selected row count is displayed at bottom of the screen and
            the selected rows are displayed in a different tab <i> selected rows</i></p>
            <p>You can change the X, Y and group-by columns and draw different plots </p>
            <p> Happy Plotting !! </p>"
        ),
    # Sidebar
    sidebarLayout(
        sidebarPanel(
            selectInput(
                "inputYcol",
                "Y Axis",
                choices = c("carat", "cut", "color", "clarity", "price"),
                selected = "price",
                multiple = FALSE
            )  %>% helper(
                type = "inline",
                title = "Help",
                content = c(
                    "<p> The dropdown list contains variables from <b> diamonds </b> dataset.</p>
                                       <p> Choose a variable to plot on X and Y axis.
                                       You can, optionally, choose the factor variable for grouping. This is
                                       <i> None</i> by default. </p>

                                       <p> The X, Y and groupby columns cannot be the same.
                                       If columns are the same, an error will be displayed prompting you
                                       to re-select the columns. The existing plot will be erased.
                                       </p>
                                       <p> Happy Plotting !! </p>"
                ),
                size = "m"
            ),
            selectInput(
                "inputXcol",
                "X Axis",
                choices = c("carat", "cut", "color", "clarity", "price"),
                selected = "carat",
                multiple = FALSE
            ),
            selectInput(
                "groupby",
                "Group By",
                choices = c("cut", "color", "clarity", "None"),
                selected = "None",
                multiple = FALSE
            )
        ),
        # Show plot
        mainPanel(
            textOutput("msg"),
            tabsetPanel(
                type = "tabs",
                tabPanel("Plot",
                         br(),
                         plotOutput("dplot",
                                    brush = brushOpts(
                                        id = "brush1", fill =
                                            "red"
                                    ))),
                tabPanel("Selected Rows", br(),
                         tableOutput("subtable"))
            ),
            textOutput("bcols")
            
        )
    )
))
