pipeline {
    agent any

    stages {
        stage('pull code') {
            steps {
               checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'ab4b5c84-9c42-45d8-9de2-a660e604e782', url: 'https://github.com/qq314499182/jenkins.git']]])
            }
        }
        stage('build project') {
            steps {
                sh 'mvn clean package'
            }
        }

    }
}
