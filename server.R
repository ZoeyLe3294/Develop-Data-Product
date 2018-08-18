
library(shiny)
library(plotly)
shinyServer(function(input, output) {
  
  ############# INPUT ################## 
  ##########  TAB 1 ###############
  result=reactive({
    prob=input$prob1
    t=input$toss
    dat=data.frame()
    data=data.frame(iter=NULL,probH=NULL)
    for(i in c(1:t)){
      sim=rbinom(i,1,prob)
      dat=rbind(dat,c(i,sum(sim)/i))
      data=rbind(data,dat)
    }
    data=cbind(data,rep(1:input$toss,1:input$toss))
    names(data)=c("flips","probHead","frame")
    return(data)
  })
  
  ##########  TAB 2 ############### 
  result1= eventReactive(input$refresh, {
    prob=input$probM
    t=input$trial
    theo.ex=c()
    theo.var=c()
    sam.ex=c()
    sam.var=c()
    numcoin=c(1:100)
    
    for(i in c(1:100)){
      sim=rbinom(t,i,prob)
      sam.ex[i]=mean(sim)
      sam.var[i]=var(sim)
      theo.ex[i]=i*prob
      theo.var[i]=i*prob*(1-prob)
    }
    
    data=data.frame(numcoin,sam.ex,sam.var,theo.ex,theo.var)
    return(data)
  })
  
  
  
  
  ############# OUTPUT ################## 
  ##########  TITLE ###############  
  output$title=renderText({
    if (input$tabs == "1 coin"){
      text="Probability of Heads when flipping 1 coin"
    }else{
      text="Evaluate flipping coins"
    }
    return(text)
  })
  ##########  PLOT ############### 
  output$plot=renderPlotly({
    if(input$tabs == "1 coin"){
      plot_ly(data=result(),
              x=~flips,y=~probHead,frame = ~frame, type="scatter", mode="lines")%>%
        add_lines(y=input$prob1)%>%
        animation_opts(frame=150, transition = 0, easing = "linear")%>%
        layout(showlegend=F,
               yaxis=list(title = "Probability of Heads",range=c(0,1)),
               xaxis= list(title="Number of Flips", range = c(0,input$toss)))
    }else{
      plot_ly(data = result1(),
              x=~numcoin, y=~theo.ex, name = "theoretical trace", mode="lines",type = "scatter")%>%
        add_trace(y=~sam.ex,name="sample trace")%>%
        add_markers(x=input$numCoin,y=result1()$sam.ex[input$numCoin],name="sample point", size=2)%>%
        add_markers(x=input$numCoin,y=result1()$theo.ex[input$numCoin],name="theorical point",size=1)%>%
        layout(yaxis=list(title="number of Heads",range=c(0,55)),
               xaxis=list(title="number of coins",range=c(0,110)))
    }
    
  })
  ##########  CALCULATION ############### 
  output$table=renderTable({
    if(input$tabs=="Multiple coins"){
      data=data.frame(cbind(c("Sample means","Sample variance","Theoretical expectation","Theoretical variance"),
                            format(t(result1()[input$numCoin,-1]),digits=4)))
      names(data)=c("",paste("Number of coins: ",result1()[input$numCoin,1]))
      return(data)}
  })
  
})
