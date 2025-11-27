########################## Final Report for Statistics in climate sciences ################################
#                                                                                                         #
#                                                                                                         #
#       Author:         Christoph Butz                                                                    #
#       Date:           21. May 2013                                                                      #
#                                                                                                         #
#       Last modified:  04. Nov 2015                                                                      #
#                                                                                                         #
#       File:           user_functions.r                                                                  #
#                                                                                                         #
###########################################################################################################

# Libraries

libraries <- function(){
  # installs and activates Necessary libraries
  ###########################################################################################################
  # mvsf -> mulitvariate shapiro-wilks test
  # Try open existing library
  lib1 <- library("mvsf", logical.return=TRUE)
  # if not installed, install and load package
  if(lib1==FALSE) install.packages("mvsf"); library("mvsf")
  # package for Mean absolute deviation (MAD) Filters and ceil function
  lib4 <- library("pracma", logical.return=TRUE)
  if(lib4==FALSE) install.packages("pracma"); library("pracma")
  # package for Mean absolute deviation (MAD) Filters and ceil function
  lib2 <- library("ipred", logical.return=TRUE)
  if(lib2==FALSE) install.packages("ipred"); library("ipred")
  # package for pretty log axes
  lib3 <- library("magicaxis", logical.return=TRUE)
  if(lib3==FALSE) install.packages("magicaxis"); library("magicaxis")  
  
  # cleanup
  rm(list=c("lib1","lib4","lib2","lib3"))  
}

# function 1: Calculate percentage of values above and below confidence interval
###########################################################################################################
confidence <- function(X){
  
  # This function calculates how much values are outside the confidence region at 95% or 99.8%
  #
  # Variables:
  ############
  #
  # x:  a list or vector of values
  
  
  print("h0-1:  Less than 5  % of values are outside the 95  % confidence region")
  print("h0-2:  Less than 0.2% of values are outside the 99.8% confidence region")
  
  # For debugging
  #vect <- std_MAM_means_cloud
  #vect1 <- as.data.frame(vect[,1])
  #X <- na.omit(vect1)
    
  # Remove NA's and change to vector format  
  X1 <- as.vector(na.omit(X))
  # Depending on the mode of the data choose data count method
  if (mode(X1)== "list"){
    n <- nrow(X1)
  } else {
    n <- length(X1)
  }  
  # variables defining the confidence threshold
  i <- length(X1[(X1< -1.96),1])
  j <- length(X1[(X1> +1.96),1])
  k <- length(X1[(X1< -3.10),1])
  l <- length(X1[(X1> +3.10),1])  
  # calculate percentage of values outside the threshold level
  c95  <- ((i+j)/n)*100
  c99  <- ((k+l)/n)*100
  conf <- c(c95,c99)  
  # Print the appropriate results
  res1 <- if (conf[1]>5){print(paste("at 95%:",
                                     round(conf[1],digits=2),
                                     "% of values (",(i+j),"/",n,") outside confidence region (max<5%)", 
                                     "=> h0-1 can be rejected, data may not have a normal distribution", 
                                     sep=" " ))
                 } else {print(paste("at 95%:",
                                     round(conf[1],digits=2),
                                     "% of values (",(i+j),"/",n,") outside confidence region (max<5%)", 
                                     "=> h0-1 cannot be rejected, data may have a normal distribution", 
                                     sep=" " ))
                         }
  
  res2 <- if (conf[2]>0.2){print(paste("at 99.8%:",
                                      round(conf[2],digits=2),
                                      "% of values (",(k+l),"/",n,") outside confidence region (max<0.2%)",
                                      "=> h0-2 can be rejected, data may not have a normal distribution",
                                      sep=" " ))
                   } else {print(paste("at 99.8%:",
                                      round(conf[2],digits=2),
                                      "% of values (",(k+l),"/",n,") outside confidence region (max<0.2%)", 
                                      "=> h0-2 cannot be rejected, data may have a normal distribution",
                                      sep=" " ))
                           }
}
###########################################################################################################

# function 2: compute Exercise 5 on a multivariate Dataset. 
###########################################################################################################
Data_description <- function(vect){
  #vect <- as.vector(stdres[,1], mode="numeric")
  # Visualise data ( Check for gaussianity, extreme values and outliers )
    # check if data is a vector  
    if(is.vector(vect)==TRUE)  {
      # plot as a vector
      plot.ts(vect)
      k <- 1
      # convert vector to data.frame
      vect <- as.data.frame((vect))
    }else{
      # multiple columns in a data set
      if (ncol(vect)>10){
        # handle plotting of several (more than ten) vectors. Plot only ten at a time.
        t <- floor(ncol(vect)/10)
        j <- seq(from=1, to=t*11, by=10)
        l <- seq(from=10, to=t*11+10,by=10)
        k <- cbind(j,l)
        for (i in 1:t) {
          plot.ts(vect[,c(k[i,1]:k[i,2])], plot.type = "multiple", 
                                           xy.labels = TRUE, 
                                                  nc = 1, 
                                                main = "Timeseries")
        }
      }else{
        plot.ts(vect, plot.type = "multiple", 
                      xy.labels = TRUE, 
                             nc = 1, 
                           main = "Timeseries")
      }
    k <- ncol(vect)
    }   
  
  # process each column
  for (i in 1:k){
  
    # Debug
    #i <- 1
    #vect <- std_MAM_means_cloud # For debugging
  
    # Create data.frame of row vector 
    vect1 <- as.data.frame(vect[,i])
    
    rownames(vect1) <- rownames(vect)
    # Remove Na's 
    vect1 <- na.omit(vect1)
    names <- rownames(vect1)
    
    print(paste("###########################  ", "Dataset", i,"  ##########################", sep=" "))  
    print("#")
    print(paste("Timeseries range used:",names[1], "to",names[length(names)], sep=" "))  
    print("#")
    print(paste("Plot Variances for Dataset",i, seq=""))
    # Plot Variances for Dataset
    #
    # 95% of values in plots should be between -2 < +2; 99.8% of values should be between -3.1 < +3.1
    plot(x=rownames(vect1), y=vect1[,1],ylim=c(-4,4)) 
      title(main=paste("variance of column", i, sep=" "))
      abline(h=+1.96, col="red")
      abline(h=-1.96, col="red")
      abline(h=+3.10, col="green")
      abline(h=-3.10, col="green")
      confidence(vect1) # From File: "/Scripts/user_functions.r"
      z1 <- as.data.frame(which(vect1 > +1.96, arr.ind=TRUE))
      z2 <- as.data.frame(which(vect1 < -1.96, arr.ind=TRUE))
      z3 <- as.data.frame(which(vect1 > +3.10, arr.ind=TRUE))
      z4 <- as.data.frame(which(vect1 < -3.10, arr.ind=TRUE))
      if(nrow(z1)!=0) points(rownames(z1),vect1[z1[,1],1], col="red")
      if(nrow(z1)!=0) text  (rownames(z1),vect1[z1[,1],1], labels=as.character(z1[,1]), adj=c(0,0))
      if(nrow(z2)!=0) points(rownames(z2),vect1[z2[,1],1], col="red")
      if(nrow(z2)!=0) text  (rownames(z2),vect1[z2[,1],1], labels=as.character(z2[,1]), adj=c(0,0))
      if(nrow(z3)!=0) points(rownames(z3),vect1[z3[,1],1], col="green")
      if(nrow(z3)!=0) text  (rownames(z3),vect1[z3[,1],1], labels=as.character(z3[,1]), adj=c(0,0))
      if(nrow(z4)!=0) points(rownames(z4),vect1[z4[,1],1], col="green")
      if(nrow(z4)!=0) text  (rownames(z4),vect1[z4[,1],1], labels=as.character(z4[,1]), adj=c(0,0))
    
    # Plot sample distribution vs empirical gaussian distribution
    
    # Density plots   
    densityplot_n01(vect[,i]) 
      
   
    # QQ - Plots 
      n01_qqplot(vect[,i])
     
    # Kolmogorov Smirnov Test
    # Tests if the samples came from a specified distribution. In this case a normal distribution
    
    res1 <- ks.test(vect1, "pnorm")
    print(res1)  
    if (res1$p.value > 0.05){
      print(paste("p-value:",
                  round(res1$p.value, digits=4), 
                  "is bigger than 0.05. => h0 = 'data has normal distribution' cannot be rejected.",
                  sep=" " ))
    } else {print(paste("p-value:",
                        round(res1$p.value, digits=4), 
                        "is lower than 0.05. => h0 = 'data has normal distribution' can be rejected.",
                        sep=" " ))
    
    }
    
    # Shapiro Wilks Test
    # Tests if the samples came from a normal distribution. 
    # If the p-value is less than alpha=0.05 (95% confidence) then h0 = "data has normal distribution" 
    # can be rejected. 
    res2 <- shapiro.test(as.numeric(vect1[,1]))
    print(res2)
    if (res2$p.value > 0.05){
      print(paste("p-value:",
                  round(res2$p.value, digits=4), 
                  "is bigger than 0.05. => h0 = 'data has normal distribution' cannot be rejected.",
                  sep=" " ))
    } else {print(paste("p-value:",
                        round(res2$p.value, digits=4), 
                        "is lower than 0.05. => h0 = 'data has normal distribution' can be rejected.",
                        sep=" " ))
    }
    print("#")
    print("#")
    }  
    
    # Chi-squared qqplot
    # First compute generalized distance
    gen_Dist <- gen.distance(vect)
    # chi-squared qqplot, with the generalised distance and P=ncol(vect) degrees of freedom 
    chi2_qqplot(gen_Dist, p=ncol(vect))
    
    # Multi-normality Shapiro Wilks Test
    res3 <- mshapiro.test(t(na.omit(as.matrix(vect))))
    print("Multi normality Shapiro-Wilks Test")
    print(res3)
    if (res3$p.value > 0.05){
      print(paste("p-value:",
                  round(res3$p.value, digits=4), 
                  "is bigger than 0.05. => h0 = 'data has normal distribution' cannot be rejected.",
                  sep=" " ))
    } else {print(paste("p-value:",round(res3$p.value, digits=4), 
                        "is lower than 0.05. => h0 = 'data has normal distribution' can be rejected.",
                        sep=" " ))
    }
}
###########################################################################################################

# function 3: Plot principal components
###########################################################################################################
plot_PCA <- function(PCA, vars){
  
  # PCA  <- Principal components rotated Dataset
  # vars <- Number of variables used in the PCA
  
  old.par <- par(no.readonly = TRUE)
  count   <- length(names(PCA$sdev))
  # plot a screeplot
  screeplot(PCA,npcs=count)
    box(which = "plot", lty = "solid")
    pairs(PCA$scores[,1:if(count>4){4}else{count}])
    title(outer=TRUE, main="PCA - Scores", line=-1)
  
  # plot several plots next to each other
  layout(matrix(seq(from=1, to=vars, by=1), ncol=1, nrow=vars))
  #layout.show(vars)
  for(i in seq(from=1, to=vars, by=1)) {
    
    barplot(PCA$loadings[,i], names.arg = names(PCA$scale),
                                   main = paste("Loadings of principal component",i, seq=" "), 
                                   xlab = paste("PC",i, seq=" "),
                                  ylab = "loadings value"
                                   )
      box(which = "plot", lty = "solid")
      abline(h=0, col="darkred")
  }
  par(old.par)
  biplot(PCA,choices=c(1,2),col=c("red","blue"),cex=c(0.5,1))
  par(old.par)
  biplot(PCA,choices=c(2,3),col=c("red","blue"),cex=c(0.5,1))
  par(old.par)
  
}
###########################################################################################################

# function 4: Perform a principal component analysis, summarize and plot the results
###########################################################################################################
PCA_analysis <- function(X){
  #Graphic device defaults
  std.par       <- par(no.readonly = TRUE)
  #Principal component analysis and result
  PCA_result    <- princomp(na.omit(X), cor=TRUE, scores=TRUE)
  PCA_summary   <- summary(PCA_result)
  print(PCA_summary)
  PCA_loadings  <- loadings(PCA_result)
  print(PCA_loadings)
  #Plots for PCA
  plot_PCA(PCA_result, 3)
  par(std.par)
  return(PCA_result)
}
###########################################################################################################

###########################################################################################################

# function 5: Plot several timeseries
###########################################################################################################
tseries.plot <- function(X){
  
  # plot several time series
  
  Data <- as.data.frame(X)
  n    <- ncol(Data)
  
  if (n<=5){
    plot.ts(Data,
            plot.type="multiple", 
            xy.labels=TRUE, 
            nc=1, 
            main="Timeseries")
  }else{
    t <- floor(ncol(Data)/5)
    j <- seq(from=1, to=t*6, by=5)
    l <- seq(from=6, to=t*6+5,by=5)
    k <- cbind(j,l)
    for (i in 1:t) {
      plot.ts(Data[,c(k[i,1]:k[i,2])], plot.type="multiple", 
              xy.labels=TRUE, 
              nc=1, 
              main="Timeseries")
    }      
  } 
}

# function 6: closest values
###########################################################################################################

closest_values <- function(vector, value, Zero=FALSE){
  
  # This function finds and returns the closest values in a vector and returns the index subscripts
  # vector = vector to search in
  # value  = vector of search values
  # Zero   = if TRUE index is zero based    
  
  # zero or one based
  if (Zero==TRUE) l <- (1) else l <- (0)  
  # Prepare data
  vector  <-  as.vector(vector, mode="numeric")
  Result  <-  as.vector(length(value), mode= "integer")
    
  for(i in 1:(length(value))){    
    # find minimum. positive of (vector value - search value)
    near  <- which.min(abs(vector-value[i]))
    Result[i] <- near
  }
  Result <- (Result-l)
  return(Result)
}


# function 7: Switch model mode
###########################################################################################################

modeltype <- function(y,x=NA,type, FWD=FALSE){
  
  # support function for plotreg. switches between the different regression model types
  
  # Variables:
  ############
  
  #    y: Independent variable
  #    x: Dependent variable 
  # type: model type to switch to
  #  FWD: Set 'TRUE' for forward calculation/transformation of the data. Set 'FALSE' to inverse the transformation.  
  
  
  if (type=="Exponential_log"){type <- "Exponential"}
  if(FWD==FALSE){  
    if(typeof(x)!="double"){    
      if(is.na(x)==TRUE){#No x parameter
        switch(type,
               Standard    = c(y),
               Exponential = exp(y),
               Quadratic   = c(y)^2,
               Reciprocal  = 1/(y),
               Logarithmic = exp(y),
               Power       = exp(y)        
        )
      }else{return("Error")}
    }else{# with x parameter
    
    switch(type,
           Standard    = cbind(  c(y),   c(x)),
           Exponential = cbind(exp(y),   c(x)),
           Quadratic   = cbind(   (y)^2, c(x)),
           Reciprocal  = cbind( 1/(y),   c(x)),
           Logarithmic = cbind(  c(y), exp(x)),
           Power       = cbind(exp(y), exp(x))               
           )
    }
  }else{# FWD==TRUE!!!
    if(typeof(x)!="double"){    
      if(is.na(x)==TRUE){
        switch(type,
               Standard    = c(y),
               Exponential = log(y),
               Quadratic   = sqrt(y),
               Reciprocal  = 1/(y),
               Logarithmic = log(y),
               Power       = log(y)        
        )
      }else{return("Error")}
    }else{      
      switch(type,
             Standard    = cbind(   c(y),  c(x)),
             Exponential = cbind( log(y),  c(x)),
             Quadratic   = cbind(sqrt(y),  c(x)),
             Reciprocal  = cbind(  1/(y),  c(x)),
             Logarithmic = cbind(  c(y), log(x)),
             Power       = cbind(log(y), log(x))               
      )
    }
    
    
  }
}

# function 8: plot model
###########################################################################################################
plotreg <- function(Xvect,Yvect,type,xlim,ylim,xlab,ylab,plot=F){
  
  # Function to perform and plot a simple linear regression nicely.
  
  # Variables:
  ############
  #
  # Xvect: Dependent variable
  # Yvect: Independent variable
  # type : Type of regression (see 'type' further down)
  # xlim : vector with min and max for the x-axis
  # ylim : vector with min and max for the y-axis
  # xlab : string annotation for x-axis
  # ylab : string annotation for y-axis
  # plot : plot=TRUE plots the regmodel, plot=FALSE just returns the regmodel stats
  
  
  Data <- cbind(Xvect,Yvect)
  
  mode     <- modeltype(Data[,2],Data[,1],type, FALSE)
  modeData <- modeltype(Data[,2],Data[,1],type, TRUE)
  
  
  if(type=="Standard")       {log <-   ""; yaxt= "s"} 
  if(type=="Exponential")    {log <-  "y"; yaxt= "n"}
  if(type=="Exponential_log"){log <-   ""; yaxt= "s";Data[,2] <- log(Data[,2]);type <- "Exponential"}
  if(type=="Quadratic")      {log <-   ""; yaxt= "s"} 
  if(type=="Reciprocal")     {log <-   ""; yaxt= "s"} 
  if(type=="Logarithmic")    {log <-  "y"; yaxt= "n"}
  if(type=="Power")          {log <- "xy"; yaxt= "n"}
  
  # Regression models
  ###################  
  # 1. Standard linear regression  y = b0 + b1x, y = b0 + b1x  
  if(type=="Standard")       {regmodel <- lm((Data[,2])~Data[,1])}  
  # 2. Exponential model: Dependent variable = log(y),    log(y) = b0 + b1x,  y = 10^(b0 + b1x) 
  if(type=="Exponential")    {regmodel <- lm(log(Data[,2])~Data[,1])}  
  # 3. Quadratic model:   Dependent variable = sqrt(y),  sqrt(y) = b0 + b1x,  y = ( b0 + b1x )^2  
  if(type=="Quadratic")      {regmodel <- lm(sqrt(Data_in[,2])~Data_in[,1])}  
  # 4. Reciprocal model:  Dependent variable = 1/y,      1/y = b0 + b1x,      y = 1 / ( b0 + b1x )  
  if(type=="Reciprocal")     {regmodel <- lm((1/(Data[,2]))~Data[,1])} 
  # 5. Logarithmic model: Independent variable = log(x),   y = b0 + b1log(x), y = b0 + b1log(x)  
  if(type=="Logarithmic")    {regmodel <- lm(Data[,2]~log(Data[,1]))}   
  # 6. Power model Dependent variable = log(y), Independent variable = log(x), log(y)= b0 + b1, log(x) y = 10^(b0 + b1log(x))  
  if(type=="Power")          {regmodel <- lm(Data[,2]~log(Data[,1]))} 
  
  sum <- summary(regmodel)
  sum  
  plot(regmodel, ask=F)
  
  if(plot==TRUE){
  
    par(family="serif")
    plot(Data[,1],Data[,2],
         xlim = xlim,
         ylim = ylim,
         ylab = ylab,
         xlab = xlab,     
          log = log,
         yaxt = yaxt,
         xaxs = "i",
         yaxs = "i"
    )
    # Sequence of 1000 values for X-Axis
    Slope_vect <- seq(from=xlim[1], to=xlim[2], length=1000)
    # Regression line using the 1000 X-values from Slope_vect
    regline     <- regmodel$coefficients[1]+regmodel$coefficients[2]*(Slope_vect)
    reglinemode <- modeltype(regline,NA,type,FALSE)
    # Pearson correlation of Data set
    R <- cor((modeData[,1]),modeData[,2])
    # R <- cor.test(Data[,1],Data[,2],na.action="na.omit",method="pearson")[["estimate"]] c(0,1,2,3,4,5,6,7,8,9,10)max(Data[,2])
    
    # Plot Lines, intercept and annotation 
    if(type!="Exponential_log"){
      lines (x=Slope_vect,y=reglinemode, col="red")
    }else{
      lines (x=Slope_vect,y=regline, col="red")
    }
    
    #points(0,regmodel$coefficients[1], col="red")
    #text  (0,regmodel$coefficients[1], labels="I (calc)", adj=c(0,0.9),col="red")
    mtext(paste("n =    ",nrow(Data)),                       side=1,adj=0.91,line=-10)
    mtext(paste("r = ",round(R, digits=2)),                  side=1,adj=0.91,line= -9)
    mtext(paste("R^2 = ",round(sum$adj.r.squared, digits=2)),side=1,adj=0.91,line= -8)
    p <- pf(sum$fstatistic[1], sum$fstatistic[2], sum$fstatistic[3],lower.tail = FALSE)
    if(p<0.0001){p <- format(p,scientific=TRUE, digits=4)}
    mtext(paste("p-value = ",p),                             side=1,adj=0.90,line= -7)
    
    # Confidence Region
    ###########################################################################################################
    #We can build confidence intervals for two different things:
    # - The regression function: i.e. in which interval is the 
    #   average temperature of all the rivers having a given slope ?
    # - A new observation: i.e. in which interval is the temperature 
    #   of a new river with a given slope ?
    #
    #
    #Let us first build the confidence interval for the regression function:
    #i.e. for the average temperature of all the rivers having a given slope.
    #see: proposition 7.4.1
    
    # 95% confidence
    alpha <- 0.05
    # 1 predictor
    r <- 1
    # number of data pints
    n <- nrow(Data)
    # Confidence quantiles
    T_alpha <- qt(1-alpha/2,df=n-r-1)
    # classical linear regression matrix (1,pred1,pred2,...) first col consists of 1's
    Z <- cbind(rep(1,times=n),Data[,2])
    # Variance
    s2 <- sum(regmodel$residuals^2)/(n-r-1)
    # (Z'Z) inverted => proposition 7.4.1 (Piot's stat course)
    ZprimeZ.inv <- solve(t(Z)%*%Z)
    # Upper and lower confidence intervalls of regression fct => 7.4.1
    Mean_upper <- Mean_lower <- rep(0,times=1000)
    for(i in 1:1000){
      z0 <- matrix(c(1,Slope_vect[i]),ncol=1)
      Mean_upper[i] <- regline[i] + T_alpha * sqrt(s2 * t(z0)%*%ZprimeZ.inv%*%z0 )
      Mean_lower[i] <- regline[i] - T_alpha * sqrt(s2 * t(z0)%*%ZprimeZ.inv%*%z0 )
    }
    if(type!="Exponential_log"){
      Mean_upper_mode <- modeltype(Mean_upper,NA,type)
      Mean_lower_mode <- modeltype(Mean_lower,NA,type)
      #
      lines(x=Slope_vect,y=(Mean_lower_mode),lty=2)
      lines(x=Slope_vect,y=(Mean_upper_mode),lty=2)
    }else{
      lines(x=Slope_vect,y=(Mean_lower),lty=2)
      lines(x=Slope_vect,y=(Mean_upper),lty=2)  
    }
    
    # Forecasting new observations (more uncertain)
    # see: proposition 7.4.2 (Prof Piot's statistics course script)
    
    newobs_upper <- newobs_lower <- rep(0,times=1000)
    for(i in 1:1000){
      z0 <- matrix(c(1,Slope_vect[i]),ncol=1)
      newobs_upper[i] <- regline[i] + T_alpha * sqrt(s2 * (1 + t(z0)%*%ZprimeZ.inv%*%z0) )
      newobs_lower[i] <- regline[i] - T_alpha * sqrt(s2 * (1 + t(z0)%*%ZprimeZ.inv%*%z0) )
    }
    
    if(type!="Exponential_log"){
      newobs_upper_mode <- modeltype(newobs_upper,NA,type)
      newobs_lower_mode <- modeltype(newobs_lower,NA,type)
      
      lines(x=Slope_vect,y=(newobs_upper_mode),lty=3,col="green")
      lines(x=Slope_vect,y=(newobs_lower_mode),lty=3,col="green")
    }else{
      lines(x=Slope_vect,y=(newobs_upper),lty=3,col="green")
      lines(x=Slope_vect,y=(newobs_lower),lty=3,col="green")
    }
    #
    # Root Mean Square Error of Prediction (10-fold, k-fold, Bootstrap)
    ####################################################################
    # simplify colnames
    colnames(modeData) <- c("V1","V2")
    # prepare data containers
    tenfold <- c()
      kfold <- c()
    bootstr <- c()  
    
    # iterate the x-validation 100 times and use the average
    for(i in 1:100){  
      tenfold_temp <- errorest(V1~V2,data=as.data.frame(modeData),model=lm,estimator='cv')
      kfold_temp   <- errorest(V1~V2,data=as.data.frame(modeData),model=lm,estimator='cv',est.para=control.errorest(k=nrow(Data)))
      bootstr_temp <- errorest(V1~V2,data=as.data.frame(modeData),model=lm,estimator='boot')
      tenfold[i]   <- tenfold_temp$error 
      kfold[i]     <-   kfold_temp$error
      bootstr[i]   <- bootstr_temp$error
      cat('iterate RMSEP: ',i,' / 100 \n')
    }
    # mean of the results
    tenfold <- mean(tenfold)
      kfold <- mean(  kfold)
    bootstr <- mean(bootstr)
    # in case the model is of exponential type, reverse to normal scale
    if(type!="Exponential_log"){
      tenfold <- modeltype(tenfold,NA,type,FWD=FALSE)
      kfold   <- modeltype(kfold,  NA,type)
      bootstr <- modeltype(bootstr,NA,type)
    }
    
    # print info
    cat('10-fold error: ',tenfold,' ug/g \n')
    cat('leave-one-out: ',  kfold,' ug/g \n') 
    cat('bootstrapping: ',bootstr,' ug/g \n')
    
    # Calculate Amplitude of Data set
    amplitude = max(Data[,2])-min(Data[,2])
    # Calculate Error in Percent (10-fold, k-fold, Bootstrap)
    error_10fold  = tenfold/amplitude*100  
     error_kfold  =   kfold/amplitude*100
    error_bootstr = bootstr/amplitude*100
  
    # print info
    cat('10-fold error: ', error_10fold,' % \n')
    cat('leave-one-out: ',  error_kfold,' % \n') 
    cat('bootstrapping: ',error_bootstr,' % \n')
    
    # Write to Image
    mtext("RMSEP:", side=1, adj=0.82, line=-5)
    mtext(paste("10_fold = ",  round((tenfold), digits=2)," (",round(error_10fold,  digits=2)," %)",sep=""),side=1,adj=0.9, line=-4)
    mtext(paste("k_fold = ",   round((kfold),   digits=2)," (",round(error_kfold,   digits=2)," %)",sep=""),side=1,adj=0.9, line=-3)
    mtext(paste("Bootstrap = ",round((bootstr), digits=2)," (",round(error_bootstr, digits=2)," %)",sep=""),side=1,adj=0.9, line=-2)
    
    # use magicaxis for pretty labels in case of special 'types'
    if(type=="Exponential"){magaxis(side=2, logpretty=TRUE)}
    if(type=="Logarithmic"){magaxis(side=2, logpretty=TRUE)}
    if(type=="Power")      {magaxis(side=1,2, logpretty=TRUE)}
  }
  return(regmodel)
}


# function 9: calculate pigment concentration from data
##########################################################

convert_2_concentration <- function(model,RABD_data,Out.Dir,Out.Name){
  
  # Function to convert RABD values to concentration values using a (pre-produced) linear regression model.
  
  # Variables:
  ############
  #     model: regression model output used by the calibration
  # RABD_data: Dataset to be converted: first column=Depth [mm], second column=RABD values
  #   Out.Dir: output directory
  #   Out.Name: output filename with extension
  
  
  # Set values RABD < 1.0 = NA
  RABD_data[which(RABD_data[,2]<1),2] <- NA
  
  # vector of new observations
  scaledpoints <- model$coefficients[1]+model$coefficients[2]*RABD_data[,2]
  # replace NA's with 0. (Zero pigment concentration)
  scaledpoints[which(is.finite(scaledpoints)==FALSE)] <- 0
  # output Dataset
  output <- cbind(RABD_data[,1],scaledpoints)
  colnames(output) <- colnames(RABD_data)
  # write file
  write.table(output,file=Add_Date(Out.Name,Out.Dir,"csv"),sep=",", row.names = FALSE)
  
  return(output)
}

