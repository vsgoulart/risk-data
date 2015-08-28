# exemplos de dados entrada, carregar dataset.mod antes
rm(list=ls());
source('R/load.libraries.R');
source("R/load.generalization.models.R");
source('R/load.perform.tests.functions.R');
source("R/functions/predict.api.v2.R");

load(file="output/test_aux/test.v2"); # mesmo conjunto de testes utilizado na generalizacao

library(jsonlite);

read.data.from.server <- function(){
  f <- file("stdin");
  open(f);
  length(line <- readLines(f,n=1));
  data = fromJSON(txt=line);
  
  server.data <- data.frame(c(data$rcta8), c(data$hfda07), c(data$hfda11), c(data$hmpa08), c(as.numeric(data$afia7)), c(data$claa2), c(data$diea133), c(as.numeric(data$a_imc1)), 
                            c(data$a_imc2), c(as.numeric(data$a_cint)), c(as.numeric(data$a_rcq)), c(data$a_sitconj), c(data$a_escolar), c(data$a_gidade), c(data$a_thas2), 
                            c(data$a_has2), c(data$a_medanthipert), c(as.numeric(data$a_rendapercapita)), c(data$a_fumante), c(as.numeric(data$a_volalc)), c(data$a_bebexcessivo), 
                            c(data$a_binge), c(data$a_ativfisica), c(data$a_consdiaverduras), c(data$a_consdiafrutas), c(data$a_sintsono), c(data$a_hipertrig), 
                            c(data$a_medoutahip), c(data$a_medredlip), c(data$a_sfmiprem), c(data$a_sfstkprem), c(data$a_sfrevprem), c(data$a_sfhfprem), 
                            c(data$a_chdlight), c(data$a_chdhard), c(data$a_sfcvdhard), c(data$a_prvdcc), c(as.numeric(data$a_cons_est_nacl)), c(data$a_dm));
  
  colnames(server.data) <- c("rcta8", "hfda07", "hfda11", "hmpa08", "afia7", "claa2", "diea133", "a_imc1", "a_imc2", "a_cint", "a_rcq", "a_sitconj", 
                             "a_escolar", "a_gidade", "a_thas2", "a_has2", "a_medanthipert", "a_rendapercapita", "a_fumante", "a_volalc", "a_bebexcessivo", 
                             "a_binge", "a_ativfisica", "a_consdiaverduras", "a_consdiafrutas", "a_sintsono", "a_hipertrig", "a_medoutahip", "a_medredlip", 
                             "a_sfmiprem", "a_sfstkprem", "a_sfrevprem", "a_sfhfprem", "a_chdlight", "a_chdhard","a_sfcvdhard", "a_prvdcc", "a_cons_est_nacl", 
                             "a_dm");
  
  save(server.data, file="testData");
  
  return(server.data);
}

user.data <- data.frame();

user.data <- read.data.from.server();

#user.data <- server.data;
#load("testData");

pred <- predict.web.nb(user.data, model.id = "normal", subset.idx = 8, DEBUG=TRUE);
pred <- predict.web.nbalt(user.data, model.id = "normal", subset.idx = 8, DEBUG=TRUE);
pred <- predict.web.c5alt(user.data, model.id = "normal", subset.idx = 8, DEBUG=TRUE);
pred <- predict.web.c5rulesalt(user.data, model.id = "normal", subset.idx = 8, DEBUG=TRUE);
pred <- predict.web.glm(user.data, model.id = "normal", subset.idx = 8, DEBUG=TRUE);
pred <- predict.web.nnet(user.data, model.id = "normal", subset.idx = 8, DEBUG=TRUE);
pred <- predict.web.knn(user.data, model.id = "normal", subset.idx = 8, DEBUG=TRUE);
pred <- predict.web.rf(user.data, model.id = "normal", subset.idx = 8, DEBUG=TRUE);

pred <- predict.web.nb(user.data, model.id = "normal", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.nbalt(user.data, model.id = "normal", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.c5alt(user.data, model.id = "normal", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.c5rulesalt(user.data, model.id = "normal", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.glm(user.data, model.id = "normal", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.nnet(user.data, model.id = "normal", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.knn(user.data, model.id = "normal", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.rf(user.data, model.id = "normal", subset.idx = 5, DEBUG=TRUE);

pred <- predict.web.nb(user.data, model.id = "bin", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.nbalt(user.data, model.id = "bin", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.c5alt(user.data, model.id = "bin", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.c5rulesalt(user.data, model.id = "bin", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.glm(user.data, model.id = "bin", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.nnet(user.data, model.id = "bin", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.knn(user.data, model.id = "bin", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.rf(user.data, model.id = "bin", subset.idx = 5, DEBUG=TRUE);

pred <- predict.web.nb(user.data, model.id = "disc", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.nbalt(user.data, model.id = "disc", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.c5alt(user.data, model.id = "disc", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.c5rulesalt(user.data, model.id = "disc", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.glm(user.data, model.id = "disc", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.nnet(user.data, model.id = "disc", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.knn(user.data, model.id = "disc", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.rf(user.data, model.id = "disc", subset.idx = 5, DEBUG=TRUE);

pred <- predict.web.nb(user.data, model.id = "bin-imp", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.nbalt(user.data, model.id = "bin-imp", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.c5alt(user.data, model.id = "bin-imp", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.c5rulesalt(user.data, model.id = "bin-imp", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.glm(user.data, model.id = "bin-imp", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.nnet(user.data, model.id = "bin-imp", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.knn(user.data, model.id = "bin-imp", subset.idx = 5, DEBUG=TRUE);
pred <- predict.web.rf(user.data, model.id = "bin-imp", subset.idx = 5, DEBUG=TRUE);