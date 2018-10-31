args <- commandArgs(TRUE);


if(!file.exists("bcw_logisticRegression.rda")) {
  #install.packages("caret")
  library(caret)
  raw=read.csv("breast-cancer-wisconsin.csv",na.strings=c("?","NA"))
  
  raw$g[is.na(raw$g)] <- 1
  raw$label=sapply(raw$label,as.factor)
  
  index=sample(nrow(raw),nrow(raw)*0.75)
  train=raw[index,]
  test=raw[-index,]
  
  
  model=glm(formula=label~.,family=binomial, data=train)
  pred=predict(model, type="response",test[-11])
  pred
  pred=ifelse(pred>0.5,4,2)
  #finalPred
  pred
  #x=table(test$label,pred)
  #tx
  #cf = table(pred,test$label)
  #tx=confusionMatrix(cf)
  #accuracy<-sum(diag(cf))/sum(cf)
  save(tx, file = "bcw_logisticRegressioncc.rda")
  save(model, file = "bcw_logisticRegression.rda")
  
}else{
  
  load("bcw_logisticRegression.rda")
  load("bcw_logisticRegressioncc.rda")
  
}

if (length(args)==10){
  #args=c(1059552,1,1,1,1,2,1,3,1,1,2)
  
  raw=read.csv("breast-cancer-wisconsin.csv")
  x = as.data.frame(t(as.numeric(as.vector(args))))
  names(x)=names(raw[,(1:10)])
  
  ans=predict(model,type="response",x)
  #pred=predict(model,type="response",x)
  ans
  ans=ifelse(ans>0.5,4,2)
  ans
  if(ans==2){
    print("Predicted as Benign")
    #print(paste("Benign ",ans," <br />","Probablity Benign==>",prob[1,1]," <br /> Probablity Malignant==>",prob[1,2],"<br />"))
  }else{
    print("Predicted as Malignant")
    #print(paste("Malignant ",ans,"<br />","Probablity Benign==>",prob[1,1]," <br /> Probablity Malignant==>",prob[1,2],"<br />"))
  }
}else{
  print("Insufficient Input")
}
