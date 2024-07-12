pipeline {
    agent any
    environment {
        PYTHON_ENV = '.venv'
    }
    stages {
        stage("Checkout") {
            steps {
                // Checkout code from version control
                checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/tomprogramuje/jenkins_test.git']]])
            }
        }
        stage('Environment setup') {
            steps {
                sh '''
                python3 -m venv ${PYTHON_ENV}
                source ${PYTHON_ENV}/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }
        stage('Static Analysis') {
            steps {
                sh '''
                source ${PYTHON_ENV}/bin/activate
                ruff check .
                mypy .
                '''
            }
        }
        stage('Unit Tests') {
            steps {
                sh '''
                source ${PYTHON_ENV}/bin/activate
                pytest
                '''
            }
        }
        stage('Deploy and Schedule') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                source ${PYTHON_ENV}/bin/activate
                ./deploy_script.sh
                '''
                script {
                    // Schedule the script to run daily, if needed
                    // Example cron job setup (Linux-based)
                    sh '''
                    (crontab -l 2>/dev/null; echo "0 0 * * * /path/to/venv/bin/python /path/to/your_daily_script.py") | crontab -
                    '''
                }
            }
        }
    }
    post {
        always {
            sh 'rm -rf ${PYTHON_ENV}'
        }
    }
}
