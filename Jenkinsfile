pipeline {
    agent {
        kubernetes {
            label 'kaniko-agent'
            yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: default
  restartPolicy: Never
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:v1.11.0
    args:
      - "--dockerfile=/workspace/Dockerfile"
      - "--context=/workspace/"
      - "--destination=harbor.local/spring-demo/spring-demo:latest"
      - "--docker-config=/kaniko/.docker"
      - "--verbosity=debug"
      - "--skip-tls-verify"
      - "--insecure"
    volumeMounts:
      - name: workspace
        mountPath: /workspace
      - name: kaniko-secret
        mountPath: /kaniko/.docker

  # giữ pod lại để debug khi cần
  - name: sleep
    image: busybox
    command: ["sleep", "3600"]

  volumes:
    - name: workspace
      emptyDir: {}
    - name: kaniko-secret
      secret:
        secretName: harbor-cred
"""
        }
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Kaniko') {
            steps {
                container('kaniko') {
                    sh 'echo "🚀 Starting Kaniko build..."'
                }
            }
        }
    }

    post {
        always {
            echo "✅ Pipeline finished. Check pod logs for Kaniko if needed."
        }
    }
}
