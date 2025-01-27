pipeline {
    agent {label 'maven'}
        stages {
            stage('vcs') {
                steps{
                    git branch: 'main',
                    url: 'https://github.com/spring-projects/spring-petclinic.git'
                     }
                        }
            stage('build'){
                steps {
                    sh 'mvn package'
                }
             }
            stage('artifacts'){
                steps {
                    junit testResults:"**/surefire-reports/*.xml"
                }  
                }
             stage('archiveArtifacts'){
                steps {
                    archiveArtifacts artifacts:"**/target/*.jar"
                }
            }
}
}