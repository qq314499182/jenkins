pipeline {
    agent any

    stages {
        stage('拉取代码') {
            steps {
               checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'ab4b5c84-9c42-45d8-9de2-a660e604e782', url: 'https://github.com/qq314499182/jenkins.git']]])
            }
        }
        stage('代码审查') {
            steps {
              script {
                scannerHome = tool 'sonar-scanner'
              }
              withSonarQubeEnv('sonarqube') {
                sh "${scannerHome}/bin/sonar-scanner"
              }
            }
        }
        stage('编译，构建镜像') {
            steps {
                //maven编译1
                sh 'mvn clean package -Dmaven.test.skip=true'
                //构建镜像
                sh 'docker build -t jenkins:1.0.0 .'
                //给镜像打标签
                sh "docker tag jenkins:1.0.0 123.56.18.37:25100/iids/jenkins:1.0.0"
                //登陆harbor,并推送镜像
                withCredentials([usernamePassword(credentialsId: '4954eac9-977e-4733-a602-1c24703c37cd', passwordVariable: 'password', usernameVariable: 'username')]) {
                    //登录
                    sh "docker login -u ${username} -p ${password} 123.56.18.37:25100"
                    //上传镜像
                    sh "docker push 123.56.18.37:25100/iids/jenkins:1.0.0"
                }
                //删除虚悬镜像none
                sh 'docker rmi $(docker images -q -f dangling=true)'
                //删除本地镜像
                sh "docker rmi -f jenkins:1.0.0"
                sh "docker rmi -f 123.56.18.37:25100/iids/jenkins:1.0.0"
            }
        }
    }
    post {
      always {
        emailext body: '${FILE,path="/home/email.html"}', subject: ' \'构建通知：${PROJECT_NAME} - Build # ${BUILD_NUMBER} - ${BUILD_STATUS}!\',', to: '314499182@qq.com'
      }
    }
}
