Exercise 1 : Import the CLAIMED library to JupyterLab
Task 1 - Import the component library

Exercise 2 : Explore the CLAIMED component library
  - claimed > component-library > transform > spark-csv-to-parquet.ipynb # run all cells
Task 2 - Explore component library transformations
  - claimed > component-library > transform > spark-parquet-to-csv.ipynb # run all cells
    # but Please note that this notebook will fail in the penultimate cell with AnalysisException:
    # 'Path does not exist: file:/resources/claimed/data/data.csv;' - this is because we haven't created any data yet.


Exercise 3 : Create the Pipeline
3A : Getting Started
  - claimed > component-library > input > input-hmp.ipynb # run all cells
  # “data.csv” in the “data” -- created

3B : Train the Machine Learning Model
  - claimed > component-library > train > spark-train-lr.ipynb # run all cells
    # model.xml in the “data” folder  -- crated

Exercise 4 : Deploy the Model
  - in IBM Cloud there are such layers:
    - top: IBM Cloud > BM Cloud Pak for Data > Deployment Space > Watson Machine Learning Service
  _ to use the service needed:
    - an API_KEY -- to access to all IBM Cloud
    - DEPLOYMENT_SPACE_GUID is needed -- to publish the model to the Watson Machine Learning service

# in browser,  the IBM Cloud Registration Page in your web browser.
4A: Create and Obtain API keys and DEPLOYMENT_SPACE_GUID
4B: Deploy The Trained Model
  # enter obtained API keys and DEPLOYMENT_SPACE_GUID in
  - claimed > component-library > deploy > deploy/deploy_wml_pmml # run all
  - in new file copy and paste a code chunk  from the 'IBM Cloud Pak for Data' - Deployments>Python
    - Replace the line starting with with the following line
    payload_scoring = {"input_data": [{"fields": ["x", "y", "z", ], "values": [[1,2,3]]}]}
  - Execute the code. You should see the result of the prediction

Task 6 - Deploy the model to Watson Machine Learning
- claimed > component-library > deploy > deploy/deploy_wml_pmml # run all


task 8
Hyperparameters are training parameters that can be controlled by us during the training process.
Examples include learning rate, number of iterations, steps per iteration etc.
Specifically in the notebook used in 3B, we have 3 hyper parameters and their default values -
namely maxIter=10, regParam=0.3 and elasticNetParam=0.8. Now, for this exercise, do the following:
    - Iterate over the hyperparameters maxIter in [10, 100, 1000],
      regParam in [0.01, 0.5, 2.0] and elasticNetParam in [0.0, 0.5, 1.0].
    - Print the accuracy for each combination of hyperparameters in a human readable format.
    - Report the combination of hyperparameters that yielded the highest accuracy

# what imported
from pyspark import SparkContext, SparkConf, SQLContext
import os
from pyspark.ml.classification import LogisticRegression
from pyspark.ml import Pipeline
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark2pmml import PMMLBuilder
from pyspark.ml.feature import StringIndexer
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.feature import MinMaxScaler
import logging
import shutil
import site
import sys
import wget
import re

conf = SparkConf().setMaster(master)
#if sys.version[0:3] == '3.6' or sys.version[0:3] == '3.7':
conf.set("spark.jars", 'jpmml-sparkml-executable-1.5.12.jar')

sc = SparkContext.getOrCreate(conf)
sqlContext = SQLContext(sc)
spark = sqlContext.sparkSession

# in train folder
for maxiter in  [10, 100, 1000]:

       for  regParam in [0.01, 0.5, 2.0] :

              for elasticNetParam in [0.0, 0.5, 1.0]:

                    lr = LogisticRegression(maxIter=maxiter, regParam=regParam, elasticNetParam=elasticNetParam)
                    pipeline = Pipeline(stages=[indexer, vectorAssembler, normalizer, lr])
                    model = pipeline.fit(df_train)
                    prediction = model.transform(df_train)

                    binEval = MulticlassClassificationEvaluator(). \
                        setMetricName("accuracy"). \
                        setPredictionCol("prediction"). \
                        setLabelCol("label")

                    accuracy_result = binEval.evaluate(prediction)

                    print(f"The accuracy result for Logistics Regression with maxiter = {maxiter},
                            regParam = {regParam}, elasticNetParam = {elasticNetParam} is  ----  {accuracy_result}")


Task 10 - RandomForest classification
In this task, you will build an end to end pipeline that reads in data in parquet format,
converts it to CSV and loads it into a dataframe, trains a model and perform hyperparameter tuning.
For this submission, you may use code and snippets from all the resources mentioned above
including the component library. Create a notebook that does the following:
 - Read in the parquet file you created as part of Task 3.
 - Convert the parquet file to CSV format.
 - Load the CSV file into a dataframe
 - Create a 80-20 training and test split with seed=1.
 - Train a Random Forest model with different hyperparameters listed below and report the best performing hyperparameter combinations.

Hyper parameters:
  - number of trees : {10, 20}
  - maximum depth : {5, 7}
  - use random seed = 1 wherever needed
Use the accuracy metric when evaluating the model with different hyperparameters