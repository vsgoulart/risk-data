rm(list=ls());
source("R/functions/predict.api.v3.R");
source("R/load.final.model.R");

load(file="output/test_aux/test.v2");

library(jsonlite);

stdin <- file("stdin");
open(stdin);
json <- readLines(stdin,n=1);
data = fromJSON(txt=json);

server.data <- data.frame(c(a_ativfisica), c(a_bebexcessivo), c(as.numeric(a_cint)), c(a_escolar), c(a_gidade), c(a_has2), c(as.numeric(a_imc1)), c(a_imc2), 
                          c(as.numeric(a_rcq)), c(a_sfcvdhard), c(diea133), c(hfda11), c(rcta8a));
colnames(server.data) <- c("a_ativfisica", "a_bebexcessivo", "a_cint", "a_escolar", "a_gidade", "a_has2", "a_imc1", "a_imc2", "a_rcq", "a_sfcvdhard", 
                           "diea133", "hfda11", "rcta8");

#save(server.data, file="testData");

pred <- predict.web.glm(server.data,  DEBUG=FALSE);

if(pred == 0)
{
  print("a-dm-true");
}
else if(pred == 1)
{
  print("a-dm-false");
}
else
{
  print("error");
}