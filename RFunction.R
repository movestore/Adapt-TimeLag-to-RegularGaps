library('move')

rFunction <- function(data,last_loctime=NULL)
{
  Sys.setenv(tz="UTC")
  
  if (is.null(last_loctime))
  {
    logger.info("You have not provided a timestmap of the daily last location collection before regular gap. Please go back and provide this, now the original data set is returned.")
    result <- data
  } else if (is.null(data@data$timelag)) 
  {
    logger.info("The variable 'timelag' is missing in your data set. Please make sure to run the Time Lag Between Locations App before in your Workflow. An adapted timelag2 cannot be provided, the original data set is returned.")
    result <- data
  } else
  {
    median_resol <- median(data@data$timelag,na.rm=TRUE)
    timelag2 <- data@data$timelag
    data.split <- move::split(data)
    
    last <- as.POSIXlt(last_loctime,format="%Y-%m-%dT%H:%M:%OSZ")
    timelag2 <- lapply(data.split, function(datai)
    {
      starttime <- as.POSIXct(paste0(as.character(as.Date(min(timestamps(datai)))-1)," ",last$hour,":",last$min,":",last$sec))
      td <- difftime(timestamps(datai),starttime,units="days")
      ix <- which(duplicated(ceiling(td),fromLast=FALSE)==FALSE)[-1] #dont use first day, as it is before the data (see starttime)
      
      datai@data$timelag2 <- datai@data$timelag
      datai@data$timelag2[ix] <- median_resol
      datai@data$timelag2
    })
  data@data$timelag2 <- unlist(timelag2)
  result <- data
  }  
        
  return(result)
}

  
  
  
  
  
  
  
  
  
  
