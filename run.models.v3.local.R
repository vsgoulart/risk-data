rm(list=ls());
source("R/functions/predict.api.v3.R");
source("R/load.final.model.R");

load(file="output/test_aux/test.v2");

load("testData");

pred <- predict.web.glm(server.data,  DEBUG=FALSE);
print(pred);