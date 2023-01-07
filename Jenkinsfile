pipeline {
        agent  { label 'docker' }
        parameters {
           choice(name: 'branch', choices: ['main','develop','feature'], description: 'Branch to build docker image')
         }
         triggers {
          pollSCM('* * * * *')
         }
          stages {
            stage('checkout') {
              steps {
                   mail subject: "build started",
                    body   : "build started",
                    to     : 'anji1649@gmail.com'
                   git branch: "${params.branch}", url: 'https://github.com/anji1649github/spring-petclinic.git'
                }
                }
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
                  rtServer (
                    id: "jfrog_cicd",
                    url: 'https://anji1473.jfrog.io',
                    credentialsId: "jfrog_cicd_admin"
                )
                }
                }
            stage ('docker image build and push') {
               steps {
                      mail subject: "DockerBuild",
                      body   : "Docker build started",
                      to     : 'anji1649@gmail.com'
                      sh "docker image build -t spc:${env.BUILD_NUMBER} ."
                      sh "docker image push anji1473.jfrog.io/docker-local/spc:${env.BUILD_NUMBER}"
                }
                }   
               }
        }
                    
                      