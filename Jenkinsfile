pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-debug.yaml'
    }
  }

  environment {
    IMAGE = "harbor.local/spring-demo/spring-demo:latest"
  }

  stages {
    stage('Checkout Code') {
      steps {
        echo "step 11111111111111"
        container('kaniko') {
          checkout scm
        }
      }
    }

    stage('Build and Push Image') {
      steps {
        container('kaniko') {
          sh '''
            echo "🚀 Starting Kaniko build..."
            echo "Current workspace: $WORKSPACE"
            ls -al $WORKSPACE
            /kaniko/executor \
              --dockerfile=$WORKSPACE/Dockerfile \
              --context=$WORKSPACE \
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
