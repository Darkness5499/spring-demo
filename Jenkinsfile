pipeline {
    agent {
        kubernetes {
            label 'kaniko-pod'
            defaultContainer 'kaniko'
            yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: jenkins-kaniko
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    tty: true
"""
        }
    }

    environment {
        HARBOR_URL  = "harbor.local"
        PROJECT     = "first-project"
        IMAGE_NAME  = "spring-demo"
        TAG         = "latest"
        DOCKERFILE  = "Dockerfile"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/your-user/spring-demo.git', branch: 'main'
            }
        }

        stage('Build Spring Boot Jar') {
            steps {
                container('kaniko') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                container('kaniko') {
                    sh """
                    /kaniko/executor \
                      --dockerfile=${DOCKERFILE} \
                      --context=dir://. \
                      --destination=${HARBOR_URL}/${PROJECT}/${IMAGE_NAME}:${TAG} \
                      --skip-tls-verify
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }
    }
}
