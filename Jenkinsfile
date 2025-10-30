pipeline {
    agent {
        kubernetes {
            yamlFile 'kaniko-agent.yaml'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push Image') {
            steps {
                container('kaniko') {
                    sh '''
                    /kaniko/executor \
                      --dockerfile=/workspace/Dockerfile \
                      --context=/workspace/ \
                      --destination=harbor.local/spring-demo/spring-demo:${GIT_COMMIT} \
                      --docker-config=/kaniko/.docker \
                      --verbosity=debug
                    '''
                }
            }
        }
    }
}
