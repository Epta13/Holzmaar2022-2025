
#function 1: standardize data
standardize.data <- function(X){
 if (is.vector(X)==TRUE){
   X <- as.data.frame(X)
   S <- var(X, na.rm = TRUE)
   X.center <- t( t(X) - colMeans(X, na.rm = TRUE) )
   scale <- as.numeric((S)^(-1/2))
   result <- as.data.frame(X.center * scale)
   colnames(result) <- colnames(X)
 }else{
  S <- var(X, na.rm = TRUE)
   X.center <- t( t(X) - colMeans(X, na.rm = TRUE) )
  scale <- diag(diag(S)^(-1/2))
 
   result <- as.data.frame(X.center %*% scale)
  colnames(result) <- colnames(X)
 }
 return(result)
 
 }

#function 2: qq plot for N(0,1) distribution
n01_qqplot <- function(vect){
  vect1 <- na.omit(vect)
  x <- seq(from = min(vect1)-1 , to = max(vect1)+1 ,length=100   )
  
  qqnorm(vect1)
  lines(x,x)
  
}

#function 3: empirical density estimation and comparison with
#the density of a N(0,1) random variable
densityplot_n01 <- function(vect){
  vect1 <- na.omit(vect)
  x <- seq(from = min(vect1, na.rm =TRUE)-1 , to = max(vect1, na.rm =TRUE)+1 ,length=100   )
  
  density <- density(vect1)
  ylim <- c(0, max(density$y * 1.1 , 0.5) )
  
  plot(density(vect1),ylim=ylim)
  lines(x=x,y=dnorm(x),lty=2)
  
}

#function 4: calculation of the generalized distance for each observation
gen.distance <- function(X){
  
  X1 <- X
  X1 <- na.omit(X1)
  
  S <- var(X1, na.rm = TRUE)
  n <- nrow(X1)
  p <- ncol(X1)
  Gen.dist <- rep(0,times=n)
  
  Sinv <- solve(S)
  X.center <- t( t(X1) - colMeans(X1, na.rm = TRUE) )
  
  for(i in 1:n){
    X_i <- matrix(X.center[i,],nrow=p,ncol=1)
    Gen.dist[i] <- t(X_i) %*% Sinv %*% X_i
  }
  
  return(Gen.dist)
  
}

#function 5: qq plot vs a chi square distribution with p degrees of freedom
chi2_qqplot <-  function(vect,p){
 
  #vect is typically a vector containing generalized distances
  n <- length(vect)
  
  sVect <- sort(vect)
  #high <- max(sVect)
  #maxvals <- 0.95*high
  #z1 <- (which(sVect > maxvals, arr.ind=TRUE))
  
  qunif <- 1/(2*n) + 1/n * c(0:(n-1))
  qchi2p <- qchisq(qunif,df=p)
  
  plot(x=qchi2p,y=sVect , 
       xlab="chi2(p) quantiles", 
       ylab="sample quantiles",
       main="Chi square (p) q-q plot")
  #if(nrow(z1)!=0) points(qchi2p[z1],sVect[z1], col="red")
  #if(nrow(z1)!=0) text  (qchi2p(z1),sVect[z1], labels=as.character(z1[1]), adj=c(0,0))
  lines(x=qchi2p,y=qchi2p)
  
}

