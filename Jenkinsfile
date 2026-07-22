pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials("jenkins")
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Hub Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Build Images') {
            parallel {
                stage('Backend') {
                    steps {
                        sh 'docker build -t shekhawataditya/django_app:latest .'
                    }
                }
                stage('Frontend') {
                    steps {
                        sh 'docker build -t shekhawataditya/notes_frontend:latest ./mynotes'
                    }
                }
                stage('Nginx') {
                    steps {
                        sh 'docker build -t shekhawataditya/notes_nginx:latest ./nginx'
                    }
                }
            }
        }

        stage('Push Images') {
            parallel {
                stage('Push Backend') {
                    steps {
                        sh 'docker push shekhawataditya/django_app:latest'
                    }
                }
                stage('Push Frontend') {
                    steps {
                        sh 'docker push shekhawataditya/notes_frontend:latest'
                    }
                }
                stage('Push Nginx') {
                    steps {
                        sh 'docker push shekhawataditya/notes_nginx:latest'
                    }
                }
            }
        }
    }
}