# Application Description
This application comprises of a GUI and a server.
The aim of this application is to draw various plots to perform
exploratory analysis using diamonds dataset from ggplot2 package. 
 
This dataset containing the prices and other attributes of almost 
54,000 *diamonds*. The server uses 5000 rows from the diamonds 
datset using a sample_n method from dplyr package. 

You can choose any "one" of the variables to plot on X and Y axis. 
These appear in drop-down list on the GUI. You can, optionally, 
choose the factor variable for grouping

Y-axis  : carat, cut,color, clarity, price (default - price)
X-axis  : carat, cut,color, clarity, price (default - carat)
groupby : cut, color, clarity, None (default - None)
 

Once the application starts, a plot of price vs carat appears.
You can use a brush to select a subset of rows from the data-frame. 
The selected row count is displayed at bottom of the screen and
the selected rows are displayed in a different tab "selected rows".

You can change the X, Y and group-by columns and plot different
plots. You can select different rows from the plot using the
the brush feature. 

# Important Note:
The X, Y and groupby columns cannot be the same.
If columns are the same, an error will be displayed prompting you 
to re-select the columns. The existing plot will be erased.

Happy Plotting !!
