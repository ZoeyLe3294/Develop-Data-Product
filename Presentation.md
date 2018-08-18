Developing Data Products
========================================================
author: Zoey Le
date: August 14, 2018
autosize: true
transition: concave
font-family: 'Arial'

Final Project - Coursera

Simulation Coin Flipping
========================================================

This project will use Shiny application and Plotly package to simulate Flipping Coin event

- Part 1: Flipping 1 coin for t tossing times, then examine the probability of a Heads 
- Part 2: Flipping n coins repeatedly t times, then examine and compare the Expectation and Variance from the simulator data with theoretical formular


Part 1
========================================================

Using `rbinom` to generate Heads or Tails of flipping 1 coin for t times and probability of Head is prob.
<br>Note: data are generated from 1 to t for the ploting purpose

- For example: t= 40, prob= 0.5


```r
    prob=0.5
    t=40
    data=data.frame(iter=0,probH=0)
    for(i in c(1:t)){
      sim=rbinom(i,1,prob)
      data[i,]=c(i,sum(sim)/i)}
    names(data)=c("flips","probHead")
    t(format(data[1:5,],digits=3))
```

```
         1       2       3       4       5      
flips    "1"     "2"     "3"     "4"     "5"    
probHead "0.000" "0.000" "0.667" "0.250" "0.200"
```

Part 2
========================================================

Similarly, using `rbinom` to simulate flipping n for t times and probability of heads is prob
<br>For this part, the sample mean and variance, also theory expectation and variance will be generated

For example: t=15, prob=0.5, n=1:100
<br>Note that 100 coins are generated for the purpose of ploting


```
  coins  mean sample var expectation theory var
1     1 0.667      0.238         0.5          0
2     2 0.867      0.267         1.0          0
3     3 1.600      0.829         1.5          1
4     4 2.133      0.838         2.0          1
5     5 3.067      0.781         2.5          1
```

Shiny Application Output
===================================

Outputs produced by Shiny include:

- Part 1: Plot of probability of Heads vs number of flipping times
- Part 2: Plot of number of Heads from flipping 1 to 100 coins repeatedly t times
       <br> and <br> Table of Expectation and Variance for a specific number of coins
       
The application can be found at: **https://zoeyle3294.shinyapps.io/Develop_Data_Products_final/**

**server.R** and **ui.R** can be found at: **https://github.com/ZoeyLe3294/Develop-Data-Product**










