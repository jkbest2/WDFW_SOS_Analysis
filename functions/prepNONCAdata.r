prepNONCAdata<-function(data_date,NONCAfilename,ESU_DPS_list){
  SubDir <- paste("results ", data_date,sep="")
  if (!file.exists(SubDir)){
    dir.create(file.path(SubDir))
  }
  dat<-data.frame(read.csv(paste("data/",NONCAfilename,sep="")))
  dat<-dat[dat$POPFIT%in%c("same","multiple"),]
  dat<-dat%>%dplyr::select(
    ESU_DPS = ESU_DPS,
    MAJORPOPGROUP = MAJOR_POPULATION_GROUP,
    COMMONPOPNAME2 = COMMON_POPULATION_NAME,
    COMMONNAME = SPECIES ,
    RUN = RUN_TIMING,
    WATERBODY = STREAM_NAME,
    SPAWNINGYEAR = BROOD_YEAR,
    final_abundance = NUMBER_OF_SPAWNERS
  )
  ESU_DPS_list<-data.frame(read.csv(paste("data/",ESU_DPS_list,sep="")))
  dat<-merge(dat,ESU_DPS_list[,colnames(ESU_DPS_list)%in%c("ESU_DPS","ESU_DPS_COMMONNAME")],by="ESU_DPS")
  #DataSource
  dat$datasource <-NONCAfilename
  dat<-dat %>% mutate_if(is.factor, as.character)
  return(dat)
}