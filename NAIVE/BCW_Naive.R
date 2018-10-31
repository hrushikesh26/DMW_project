library("e1071")
args <- commandArgs(TRUE);

if(!file.exists("bcw_naive.rda")) {

library(caret)
raw=read.csv("breast-cancer-wisconsin.csv",na.strings=c("?","NA"))

raw$g[is.na(raw$g)] <- 1
raw$label=sapply(raw$label,as.factor)

index=sample(nrow(raw),nrow(raw)*0.75)
train=raw[index,]
test=raw[-index,]

model=naiveBayes(label~.,train)
pred=predict(model,test)
tx=table(test$label,pred)
#cf = confusionMatrix(tx)
save(tx, file = "bcw_naiveacc.rda")
save(model, file = "bcw_naive.rda")

}else{

load("bcw_naive.rda")
load("bcw_naiveacc.rda")

}

if (length(args)==10){

  raw=read.csv("breast-cancer-wisconsin.csv")
  x = as.data.frame(t(as.numeric(as.vector(args))))
  names(x)=names(raw[,(1:10)])

  ans=predict(model,x)
  prob=predict(model,x,type="raw")
  
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
