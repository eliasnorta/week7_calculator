pipeline {
    agent any
    tools {
        maven 'Maven3'
    }
    environment {
        IMAGE_NAME = "eliasnorta/calculator-app"
        DOCKER_IMAGE_TAG = 'latest'
        DOCKER_CLI = '/usr/local/bin/docker'
        PATH = "/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        DOCKERHUB_CREDENTIALS_ID = 'Docker_Hub'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                        credentialsId: 'dockerId',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh """
                        echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                        docker push $IMAGE_NAME:latest
                    """
                }
            }
        }
    }
}
