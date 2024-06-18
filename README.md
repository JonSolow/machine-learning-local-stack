# machine-learning-local-stack
Local stack for starting ML model and data development

## Purpose
The Machine Learning Local Stack (MLLS) is designed for Data Scientists and Machine Learning Engineers to develop and prototype data and models, in a manner that parallels practices in a professional setting.  

In particular, this manner of development includes
  - Orchestration of ELT (extract, load, transform) operations with Dagster & dbt
  - Training and inference of models using Sagemaker in local Docker containers
  - Analytics Dashboarding with Metabase
  - Local database implementation with duckdb
  - Separated Python environments using Pipenv

### When should I use this?


Data Scientists and Machine Learning Engineers who are currently employed may find this tool useful to prototype models and then easily break down the requirements for their related Data Engineering and Software Development teams to implement.  Rather than a jupyter notebook which may conflate requirements of data processing, model training, inference, and analysis, this process separates each of these steps to be implemented elsewhere as desired.

Students may also find this tool useful as an education tool and to familiarize oneself with the process and technical tools to develop data and a machine learning model.

### How does the MLLS work?
The MLLS is built using Visual Studio Code's dev container feature.  This feature makes use of Docker containers to standardize the environment that is running everything you do in that VS Code context.  This layer aims to provide a standardization in the experience that doesn't depend on your particular OS and hardware.

The particular dev container used by MLLS is called "Docker in Docker" and allows us to run Docker containers within the Docker container that is actually running our dev container (a la the movie Inception).  This feature is utilized to run local Sagemaker containers for training and inference, as well as a Metabase container for analytics and visualizations.


## Getting Started

### 0. Prerequisites
- Install [Visual Studio Code](https://code.visualstudio.com/)
- Install [Visual Studo Code Extension - Dev containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- Install [Docker](https://www.docker.com/)


### 1. Development Container
- Confirm Docker is installed by executing command `docker -v`
- Open VSCode to a New Window and open this repository's directory
- You may see a notification that the Folder containers a Dev Container configuration file. If so, click on "Reopen in Container"
  - If you do not see this notification, press `F1` key and begin typing the following until you can see the option "Dev Containers: Rebuild and reopen in Container".
- This action will reopen the VSCode within a Docker container suitable to develop and locally run the application.

### 2. Data Orchestration - Dagster & dbt
New to dagster-dbt? - Check out the [tutorial](https://docs.dagster.io/integrations/dbt/using-dbt-with-dagster)

- A dagster-dbt project has already been scaffolded in this repo - [dagster-dbt](./dagster-dbt/)
    - [Dagster Project](./dagster-dbt/dagster_project/) containing code for dagster orchestration which is scaffolded to automatically import dbt project code
    - [dbt project](./dagster-dbt/dbt_project/) containing a scaffolded dbt project with some example SQL models (note model has distinct meaning in Data Engineering context).
- The Python environment used for dagster-dbt is defined using by [Pipfile](./dagster-dbt/Pipfile) and can be updated via pipenv
- To begin local dagster development, execute `./start_dagster.sh`, which will start dagster webserver in development mode within the dev container and forward a port locally to http://localhost:3000/ where you can execute and view logs of dagster processes.
- All data will be stored in a duckdb file which is not checked into source code and will be ignored by git - [dev.duckdb](./dagster-dbt/dbt_project/dev.duckdb)


#### 3. Analytics / Visualizations - Metabase
Metabase is an analytics tool that you can run locally.  To start up your local Metabase, run `./start_metabase.sh`

First time running
- Navigate through the on screen setup process.  The data is used to register you as a user for your local metabase instance (stored in [metabase-data](./data/metabase-data/))
- When you get to "Add your data", select "DuckDb"
  - Display name: dev.duckdb
  - Database file: /database/dev.duckdb
  - Enable: Establish a read-only connection
  - Choose "Connect Database"
  - The data created by dagster-dbt is now accessible in your metabase instance.


### 4. ML Model Training and Inference - Sagemaker
The development container uses a [Sagemaker specific pipenv Python environment](./sagemaker/Pipfile) which contains the sagemaker and sagemaker-local python packages.  This environment allows us to use a python script to run specified local Docker containers combined with the relevant model python [code](./sagemaker/sagemaker_example/code/) and [data](./sagemaker/sagemaker_example/data/).

The [sagemaker_example](./sagemaker/sagemaker_example/) is based on - https://github.com/aws-samples/amazon-sagemaker-local-mode/tree/3ff2ac5f687db27c17c7046e4d4a7d6f5f3323ea/tensorflow_script_mode_local_training_and_serving

