require('caret');
validate.input <- function(test) 
{
  if (all(subset.sem.a_dm %in% names(test))) {
    return (TRUE);
  } else {
    print("Dataset precisa possuir todas colunas do subset selecionado");
    print("Colunas necessarias: ");
    print(subset.sem.a_dm);
    print("Colunas do dataset passado: ");
    print(names(test));
    return (FALSE);
  }
}

validate.dataset.complete <- function (test.comp) 
{ 
  index.class <- which(colnames(test.comp) == "a_dm");
  test.comp.aux <- test.comp;
  # aceita NA na variavel alvo
  if (length(index.class) > 0) {
    test.comp.aux <- test.comp[,-index.class];
  }
  if (all(complete.cases(test.comp.aux))) {
    return(TRUE);
  } else {
    print("Dataset passado como parametro possui dados faltantes");
    return (FALSE);
  }
}

print.conf <- function(pred, truth)
{
  truth <- factor(truth, levels = c("1", "0"));
  xtab <- table(pred = pred, truth = truth);
  conf <- confusionMatrix(xtab, positive = "0");  
  print(conf);
}

scale.test <- function(testing, scale.preProc, train.numeric.names) 
{
  train.numeric.idx <- c();
  for (name in train.numeric.names) {
    num.idx <- which(colnames(testing)==name);
    if (length(num.idx) > 0)
      train.numeric.idx <- c(train.numeric.idx, num.idx);
  }
  
  testing.scaled <- testing;
  if (length(train.numeric.idx) > 0)
  {
    testing.scaled[,train.numeric.idx] <- predict(scale.preProc, testing[,train.numeric.idx]);
  }
  return (testing.scaled);
}

predict.web.glm <- function(test, DEBUG = FALSE)  
{
  if (!validate.input(test)) { 
    return ("ERRO: Dados de entrada não passaram na validação. Verificar erro no console."); 
  }
  model <- model.glm;
  test <- scale.test(test, scale.preProc, train.numeric.names);
  
  best.cutoff <- 0.1;
  
  pred.resp <-  predict(model, newdata = test, type='response');
  pred.class <- ifelse(pred.resp > best.cutoff , 0, 1);
  pred.class <- factor(pred.class, levels = c("1", "0"));
  if (DEBUG) 
  {
    if("a_dm" %in% colnames(test)) {
      print.conf(pred = pred.class, truth = test$a_dm);
      if (nrow(test) > 1) {
        require(pROC);
        result.roc <- roc(test$a_dm, pred.resp);
        plot(result.roc);
        print(auc(result.roc));
      }
    } else {
      print("test dataframe needs to have 'a_dm' column to debug.");
    }
  }
  return(pred.class);
}