#!/bin/bash


python -m mlflow server --host 0.0.0.0 --backend-store-uri sqlite:///mlflow.db --default-artifact-root /tmp/mlruns

#EOF