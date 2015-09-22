rm(list=ls());
source("R/functions/predict.api.v3.R");
source("R/load.final.model.R");

load(file="output/test_aux/test.v2");

library(jsonlite);

stdin <- file("stdin");
open(stdin);
json <- readLines(stdin,n=1);
data = fromJSON(txt=json);

server.data <- data.frame(c(data$a_hipertrig), c(data$a_ativfisica), c(data$a_bebexcessivo), c(data$a_has2), c(data$a_gidade), c(data$a_escolar),
						  c(as.numeric(data$a_rcq)), c(as.numeric(data$a_imc1)), c(data$diea133), c(data$hfda11), 0);
colnames(server.data) <- c("a_hipertrig", "a_ativfisica", "a_bebexcessivo", "a_has2", "a_gidade", "a_escolar", "a_rcq", "a_imc1", "diea133", "hfda11", "a_dm");

#save(server.data, file="testData");

pred <- predict.web.glm(server.data,  DEBUG=TRUE);