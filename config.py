# Importing the pathlib module for handling filesystem paths in an object-oriented way
import pathlib

# Importing the os module for interacting with the operating system
import os

# Importing the main package of the project
import demo_project_1 as mlops_project

# Resolve the root directory of the project by getting the absolute path of the main package
# __file__ gives the path of the current file, resolve() converts it to an absolute path,
# and parent gives the directory containing the file
ROOT_DIR = pathlib.Path(mlops_project.__file__).resolve().parent

# Define the directory where raw data files are stored by joining the root directory path
# with the relative path 'data/raw'
DATA_DIR = os.path.join(ROOT_DIR, 'data', 'raw')

# Define the name of the data file
file_name = 'iris.csv'

# Define the full path to the data file by joining the data directory path with the file name
file_path = os.path.join(DATA_DIR, file_name)

# Define the name of the model file
MODEL_NAME = 'iris_model.joblib'

# Define the directory where the model will be saved by joining the root directory path
# with the relative path 'model'
SAVE_MODEL_DIR = os.path.join(ROOT_DIR, 'model')
