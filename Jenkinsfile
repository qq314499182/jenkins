pipeline {
    agent any

    stages {
        stage('pull code') {
            steps {
               checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'ab4b5c84-9c42-45d8-9de2-a660e604e782', url: 'https://github.com/qq314499182/jenkins.git']]])
            }
        }
        stage('check code') {
            steps {
              script {
                scannerHome = tool 'sonar-scanner'
              }
              withSonarQubeEnv('sonarqube') {
                sh "${scannerHome}/bin/sonar-scanner"
              }
            }
        }
        stage('build project') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
    post {
      always {
        emailext body: '${FILE,path="/home/email.html"}', subject: ' \'构建通知：${PROJECT_NAME} - Build # ${BUILD_NUMBER} - ${BUILD_STATUS}!\',', to: '314499182@qq.com'
      }
    }
}
