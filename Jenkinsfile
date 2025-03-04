pipeline {
    agent any

  

    environment {
        SONAR_URL = 'http://34.30.219.230:9000'
        SONAR_TOKEN = credentials('sonar-token')  // Add this in Jenkins credentials
        IMAGE_NAME = "saitejamvn"
        IMAGE_TAG = "amedasonar"
        DOCKER_HUB_USER = credentials('docker-token')
        DOCKER_REPO = "saiteja562/jenkinsmvndocker"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/ameda71/mvnsonardoc.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage("build & SonarQube analysis") {
            agent any
            steps {
              withSonarQubeEnv('sonar') {
                sh ''' 
                  
                  mvn clean verify sonar:sonar \
                      -Dsonar.projectKey=test1 \
                      -Dsonar.projectName='test1' \
                      -Dsonar.host.url=http://34.30.219.230:9000 \
                      -Dsonar.token=squ_45724ab5b770fc81122b9f8c70a516bc479c54f1
                  
                  '''
              }
            }
          }
          stage("Quality Gate") {
            steps {
              timeout(time: 10, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 8086:8081 --name slicecontainer ${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    sh '''
                    echo "${DOCKER_HUB_USER_PSW}" | docker login -u "${DOCKER_HUB_USER_USR}" --password-stdin
                    docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_REPO}:${IMAGE_TAG}
                    docker push ${DOCKER_REPO}:${IMAGE_TAG}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Application successfully deployed in a Docker container!"
        }
        failure {
            echo "Build failed!"
        }
    }
}
