rm(list=ls());
source("R/functions/predict.api.v3.R");
source("R/load.final.model.R");

# subconjunto de variaveis bf.glm = glm-fs
#load("output/feature_selection_v2/bf.glm");
#subset.sem.a_dm <- bf
#save(subset.sem.a_dm, file = "output/models.v5/subset.sem.a_dm");

#load(file='output/models.v5/model.glm');
# modelo 1 foi construido com o subconjunto "glm-fs"
#final.model <- model.glm[[1]];
#save(final.model, file = 'output/models.v5/final.model');


load(file="output/test_aux/test.v2");
pred <- predict.web.glm(test,  DEBUG=TRUE);
