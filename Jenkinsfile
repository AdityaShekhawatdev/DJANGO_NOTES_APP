pipeline{
    agent any

    environment{
        DOCKERHUB_CREDENTIALS = credentials("jenkins")
    }

    stages{
        stage('Checkout'){
            steps {
                checkout scm
            }
        }

        stage('Docker Hub Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Build Backend Image'){
            steps{
                sh 'docker build -t shekhawataditya/django_app:latest .'
            }
        }

        stage('Push Backend Image'){
            steps{
                sh 'docker push shekhawataditya/django_app:latest'
            }
        }

        stage('Build frontend Image'){
            steps{
                sh 'docker build -t shekhawataditya/notes_frontend:latest ./mynotes'
            }
        }

        stage('Push Frontend Image'){
            steps{
                sh 'docker push shekhawataditya/notes_frontend:latest'
            }
        }

        stage('Build Nginx Image'){
            steps{
                sh 'docker build -t shekhawataditya/notes_nginx:latest ./nginx'
            }
        }

        stage('Push Nginx Image'){
            steps{
                sh 'docker push shekhawataditya/notes_nginx:latest'
            }
        }

        
    }
}