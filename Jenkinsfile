pipeline {

  agent { label "docker-compose" && "helm" }

  stages {
    stage('docker build') {
      steps {
        sh 'make build'
        sh 'make push'
      }
    }

    stage('deploy to stg') {
      when {
        not {
          branch 'master'
        }
      }
      environment {
          ENVIRONMENT = 'stg'
      }
      steps {
        timeout(time: 1, unit: 'HOURS') {
          input message: 'deploy to stg?', submitter: 'admin', submitterParameter: 'submitter'
        }
        sh 'echo "deploy to ${ENVIRONMENT}..."'
        sh 'make deploy'
      }
    }

    stage('deploy to prod') {
      when {
        branch 'master'
      }
      environment {
          ENVIRONMENT = 'prod'
          STARTER_BUNDLE_SECRET = 'prod-secret'
      }
      steps {
        timeout(time: 1, unit: 'HOURS') {
          input message: 'deploy to prod?', submitter: 'admin', submitterParameter: 'submitter'
        }
        sh 'echo "deploy to ${ENVIRONMENT}..."'
        sh 'make deploy'
      }
    }
  }
}
