node {
  //git变量
  def git_auth = 'ab4b5c84-9c42-45d8-9de2-a660e604e782'
  def git_url = 'https://github.com/qq314499182/jenkins.git'
  //harbor变量
  def harbor_project = 'iids'
  def harbor_image = 'jenkins'
  def harbor_version = '1.0.0'
  def harbor_url = '123.56.18.37:25100'
  def harbor_password = '4954eac9-977e-4733-a602-1c24703c37cd'

  stage('拉取代码') {
    checkout(
      [
        $class: 'GitSCM',
        branches: [[name: '*/main']],
        doGenerateSubmoduleConfigurations: false,
        extensions: [],
        submoduleCfg: [],
        userRemoteConfigs: [
          [
            credentialsId: "${git_auth}",
            url: "${git_url}"
          ]
        ]
      ]
    )
  }
  stage('代码审查') {
    script {
      scannerHome = tool 'sonar-scanner'
    }
    withSonarQubeEnv('sonarqube') {
      sh "${scannerHome}/bin/sonar-scanner"
    }
  }
  stage('编译，构建镜像') {
    //maven编译1
    sh 'mvn clean package -Dmaven.test.skip=true'
    //构建镜像
    sh "docker build -t ${harbor_image}:${harbor_version} ."
    //给镜像打标签
    sh "docker tag ${harbor_image}:${harbor_version} ${harbor_url}/iids/${harbor_image}:${harbor_version}"
    //登陆harbor,并推送镜像
    withCredentials([usernamePassword(credentialsId: "${harbor_password}", passwordVariable: 'password', usernameVariable: 'username')]) {
      //登录
      sh "docker login -u ${username} -p ${password} ${harbor_url}"
      //上传镜像
      sh "docker push ${harbor_url}/${harbor_project}/${harbor_image}:${harbor_version}"
    }
    //删除本地镜像
    sh "docker rmi -f ${harbor_image}:${harbor_version}"
    sh "docker rmi -f ${harbor_url}/${harbor_project}/${harbor_image}:${harbor_version}"
  }
  stage('部署服务') {
    sshPublisher(publishers: [sshPublisherDesc(configName: 'test-1', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: "/opt/jenkins_shell/deployment.sh $harbor_url $harbor_project $harbor_image $harbor_version", execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
  }
}