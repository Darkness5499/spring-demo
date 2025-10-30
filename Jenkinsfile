pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-debug.yaml'   // Jenkins sẽ dùng file Pod này
    }
  }

  environment {
    IMAGE = "harbor.local/spring-demo/spring-demo:latest"
  }

  stages {
    stage('Checkout Code') {
      steps {
        container('kaniko') {
          // Checkout code từ Git repo
          checkout scm
        }
      }
    }

    stage('Build and Push Image') {
      steps {
        container('kaniko') {
          sh '''
            echo "🚀 Starting Kaniko build..."
            /kaniko/executor \
              --dockerfile=/workspace/Dockerfile \
              --context=/workspace/ \
              --destination=$IMAGE \
              --skip-tls-verify \
              --verbosity=debug
          '''
        }
      }
    }

    stage('Debug Pod (optional)') {
      steps {
        container('sleep') {
          sh 'echo "✅ Build done. Pod is kept alive for debug (3600s)."'
        }
      }
    }
  }
}
