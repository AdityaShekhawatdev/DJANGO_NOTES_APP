pipeline{
    agent any
    
    environment{
        DOCKERHUB_CREDENTIALS = credentials("dockerhub-creds")
    }

    stages{
        stage('Checkout'){
            steps {
                checkout scm
            }
        }

        stage('Build Backend Image'){
            steps{
                sh 'docker build -t shekhawataditya/django_app:latest .'
            }
        }

        stage('Push Backend Image'){
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push shekhawataditya/django_app:latest'
            }
        }
    }
}