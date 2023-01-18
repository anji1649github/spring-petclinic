pipeline {
        agent  { label 'docker' }
        parameters {
        choice(name: 'branch', choices: ['main', 'develop','feature'], description: 'branch name')
     }
         triggers {
          pollSCM('* * * * *')
          }
          stages {
            stage ('scm') {
              steps{
                git url: 'https://github.com/anji1649github/spring-petclinic.git',
                 branch: "${params:branch}"
              }
            }
           // stage('checkout') {
           //   steps {
                 //  mail subject: "build started",
                 //   body   : "build started",
                 //  to     : 'anji1649@gmail.com'
              //    checkout scmGit(branches: [[name: '*/develop']], extensions: [], 
               //   userRemoteConfigs: [[credentialsId: 'docker_image', url: 'https://github.com/anji1649github/spring-petclinic.git']])
               
          //  stage('Package build & Sonar'){
          //  steps{
           //     withSonarQubeEnv('SONAR') {
           //     sh "mvn package sonar:sonar"
           //   }
           // }
        //}
        // stage("Quality Gate") {
        //     steps {
        //       timeout(time: 30, unit: 'MINUTES') {
        //         waitForQualityGate abortPipeline: true
        //       }
        //     }
        // }
           stage ('Artifactory configuration'){
                steps {
                   rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "JFROG_1649",
                    releaseRepo: 'anji-libs-release-local',
                    snapshotRepo: 'anji-libs-release-local'
                   )
                }
                }
            stage ('docker image build and push') {
               steps {
                      mail subject: "DockerBuild",
                      body   : "Docker build started",
                      to     : 'anji1649@gmail.com'
                      sh "docker image build -t anji1473.jfrog.io/anji/spc:${env.BUILD_NUMBER} ."
                      sh "docker image tag spc:${env.BUILD_NUMBER} anji1473.jfrog.io/anji/spc:${env.BUILD_NUMBER} "
                      sh "docker image push anji1473.jfrog.io/anji/spc:${env.BUILD_NUMBER}"
                }
                }
            stage ('Deleting image') {
              steps {
                     sh "docker image rmi -f anji1473.jfrog.io/anji/spc:${env.BUILD_NUMBER} "
                    }   
               }
        }
}

                    
                      