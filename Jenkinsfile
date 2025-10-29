pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: jenkins-kaniko
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    command:
    - cat
    tty: true
"""
        }
    }

    environment {
        REGISTRY = "harbor.local"                  // Harbor URL
        IMAGE_NAME = "first-project/spring-demo"             // Tên image
        IMAGE_TAG = "latest"                        // Tag image
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Spring Boot Jar') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                container('kaniko') {
                    sh """
                    /kaniko/executor \
                      --dockerfile=/workspace/Dockerfile \
                      --context=/workspace \
                      --destination=${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} \
                      --insecure \
                      --skip-tls-verify
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
