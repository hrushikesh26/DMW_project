#setwd("/media/hrishikesh/Study Material/BE/DMW mini")

library("e1071")
args <- commandArgs(TRUE);
# args=read.csv("ip.csv",na.strings=c("?","NA"))
if(!file.exists("bcw_naive.rda")) {
  
  library(caret)
  raw=read.csv("breast-cancer-wisconsin.csv",na.strings=c("?","NA"))
  
  raw$g[is.na(raw$g)] <- 1
  raw$label=sapply(raw$label,as.factor)
  
  index=sample(nrow(raw),nrow(raw)*0.75)
  train=raw[index,]
  test=raw[-index,]
  
  train_data=train[-11]
  train_label=train$label
  model=svm(train_data,train_label)
  # model=naiveBayes(label~.,train)
  
  testData=test[-11]
  testLabel=test$label
  
  pred=predict(model,testData)
  tx=table(testLabel,pred)
  
  svm_tune <- tune(svm, train.x=train_data, train.y=train_label, kernel="radial", ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))
  # 
  # print(svm_tune)
  svm_model_after_tune <- svm(train_label~., data=train_data, kernel="radial", cost=1, gamma=0.5)
  summary(svm_model_after_tune)
  pred <- predict(svm_model_after_tune,testData)
  system.time(predict(svm_model_after_tune,testData)) 
  table(pred,testLabel)
  
  #cf = confusionMatrix(tx)
  save(tx, file = "bcw_naiveacc.rda")
  save(model, file = "bcw_naive.rda")
  
  
}else{
  
  load("bcw_naive.rda")
  load("bcw_naiveacc.rda")
  
}
# --------------------------------------------------------------


if (length(args)==10){
  args
  raw=read.csv("breast-cancer-wisconsin.csv")
  x = as.data.frame(t(as.numeric(as.vector(args))))
  names(x)=names(raw[,(1:10)])
  names(x)
  ans=predict(model,x)
  prob=predict(model,x,type="raw")
  nrow(ans)
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

