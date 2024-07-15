pipeline {
    agent {
        docker {
            image 'python:3.12-alpine'
            label 'docker'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        PYTHON_ENV = 'venv'
    }
    stages {
        stage("Checkout") {
            steps {
                checkout scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/tomprogramuje/jenkins_test']])
            }
        }
        stage('Environment setup') {
            steps {
                sh '''
                python3 -m venv ${PYTHON_ENV}
                . ${PYTHON_ENV}/bin/activate
                python3 -m pip install --upgrade pip
                python3 -m pip install -r requirements.txt
                '''
            }
        }
        stage('Static Analysis') {
            steps {
                sh '''
                . ${PYTHON_ENV}/bin/activate
                ruff check .
                mypy .
                '''
            }
        }
        stage('Unit Tests') {
            steps {
                sh '''
                . ${PYTHON_ENV}/bin/activate
                pytest
                '''
            }
        }
        stage('Deploy and Schedule') {
            steps {
                sh '''
                . ${PYTHON_ENV}/bin/activate
                python3 -m main
                '''
            }
        }
    }
    post {
        always {
            sh 'rm -rf ${PYTHON_ENV}'
        }
    }
}
