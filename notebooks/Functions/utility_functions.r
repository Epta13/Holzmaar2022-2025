# Script holds small utility functions for everyday use


#######################################################################################################
#                      Function to add a date and a version number to a file name                     #
#######################################################################################################
Add_Date <- function(Name,Out.Dir,ext,Add=''){
  
  # Parameters
  ############
  # Name:   Filename (string)
  # OutDir: Output directory
  # ext:    File extension without "." e.g. "csv"
  # Add:    optional addendum between Name and Date.
  ############
  # Example: Add_Date("Test","C:\\","csv", Add='new')
  
  file.path(Out.Dir,fsep="/")
  # version number
  X <- 1
  if(Add!=''){Add <- paste('_',Add, sep="")}
  # original path+file name
  eName  <- paste(Name,Add,"_",Sys.Date(),"_V",X,".",ext,sep="")
  Result <- file.path(Out.Dir,eName,fsep="/")
  # check if file version exists and create higher version number if yes
  while(file.exists(Result)==TRUE){
    X <- X+1
    eName  <- paste(Name,Add,"_",Sys.Date(),"_V",X,".",ext,sep="")
    Result <- file.path(Out.Dir,eName,fsep="/")
  }
  return(Result)
}

#######################################################################################################
#                       Function to find the closest match for a value in a vector                    #
#######################################################################################################

closest_values <- function(vector, value, Zero){
  
  # This function returns the closest values in a monotonic vector and returns the index subscripts
  # vector = vector to search in
  # value  = vector of search values
  # Zero   = if TRUE index is zero based    
  if (Zero==TRUE) l <- (1) else l <- (0)  
  
  vector  <-  as.vector(vector, mode="numeric")
  Result  <-  as.vector(length(value), mode= "integer")
  
  
  for(i in 1:(length(value))){    
    near  <- which.min(abs(vector-value[i]))
    Result[i] <- near
  }
  Result <- (Result-l)
  return(Result)
}


#######################################################################################################
#                               Function to split a Path into its elements                            #
#######################################################################################################

Pathbreakdown <- function(string,Rem=F){
  
  # Parameters
  # String: A File path
  # Rem:    Remove the filename?
  
  # Remove File name
  if(Rem==TRUE){string <- paste(dirname(string),"/",sep="")}
  
  if (length(grep("\\",string,fixed=TRUE))==1){
    X   <- gregexpr("\\",string,fixed=TRUE)
    Arr <- strsplit(string,"\\",fixed=TRUE)
    Arr <- as.character(Arr[[1]][])
  }else{    
    if (length(grep(("\"") , string,fixed=TRUE))==1){
      X   <- gregexpr("\"",string,fixed=TRUE)
      Arr <- strsplit(string,"\"",fixed=TRUE)
      Arr <- as.character(Arr[[1]][])
    }else{  
      if(length(grep("/",string,fixed=TRUE))==1){
        X   <- gregexpr("/",string,fixed=TRUE)
        Arr <- strsplit(string,"/",fixed=TRUE)
        Arr <- as.character(Arr[[1]][])
      }
    }
  }  
  return(Arr)
}

#######################################################################################################
#                               Function to search for files - returns full paths                     #
#######################################################################################################

File.search <- function(File, Path, recur=TRUE) {
  
  # Returns full path(s) to (a) file(s) 
  # 
  # File: filename to be searched, empty string searches all
  # Path: initial path to search from
  # recur: Recursively search subdirectories? default = TRUE
  
  
  Files <- dir(path=Path, recursive=recur, full.names=T)
  Files <- normalizePath(Files)
  Locations <- c()
  for (i in 1:(length(File))){
    Location  <- grep(File[i], Files)
    Locations <- c(Locations,Location)
  }
  
  result <- Files[Locations]
  return(result)
}







