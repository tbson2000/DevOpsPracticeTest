pipeline {
    agent any
    environment{
        DOCKER_IMAGE = "103245736/nginx"
    }
    stages {
        stage("Build") {
            options {
                timeout(time: 10, unit:'MINUTES')
            }
            environment {
                    DOCKERHUB_CREDENTIALS = credentials('docker-hub')
                    DOCKER_TAG="${GIT_BRANCH.tokenize('/').pop()}-${GIT_COMMIT.substring(0,7)}"
                }
            steps{
                sh '''
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                    docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest
                    docker image ls | grep ${DOCKER_IMAGE}'''
                withCredentials([usernamePassword(
                    credentialsId:'docker-hub',
                    usernameVariable:'DOCKER_USERNAME',
                    passwordVariable:'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin'
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    }

                // clean to save disk
                sh "docker image rm ${DOCKER_IMAGE}:${DOCKER_TAG}"
                sh "docker image rm ${DOCKER_IMAGE}:latest"
            }
        }

        stage("Deploy Main"){
            options{
                timeout(time:10, unit:'MINUTES')
            }
            when { expression {env.GIT_BRANCH == 'origin/master'}}
            steps{
                withCredentials([usernamePassword(
                    credentialsId:'docker-hub',
                    usernameVariable:'DOCKER_USERNAME',
                    passwordVariable:'DOCKER_PASSWORD')]) {
                        ansiblePlaybook(
                            credentialsId: 'private_key',
                            playbook: 'playbook.yml',
                            inventory: 'hosts',
                            become: 'yes',
                            extraVars:[
                                DOCKER_USERNAME: "${DOCKER_USERNAME}",
                                DOCKER_PASSWORD: "${DOCKER_PASSWORD}"
                            ]
                        )
                    }
            }
        }

        stage("Deploy Dev"){
            options{
                timeout(time:10, unit:'MINUTES')
            }
            when { expression {env.GIT_BRANCH == 'origin/dev'}}
            steps{
                withCredentials([usernamePassword(
                    credentialsId:'docker-hub',
                    usernameVariable:'DOCKER_USERNAME',
                    passwordVariable:'DOCKER_PASSWORD')]) {
                        ansiblePlaybook(
                            credentialsId: 'private_key',
                            playbook: 'dev/playbook.yml',
                            inventory: 'hosts',
                            become: 'yes',
                            extraVars:[
                                DOCKER_USERNAME: "${DOCKER_USERNAME}",
                                DOCKER_PASSWORD: "${DOCKER_PASSWORD}"
                            ]
                        )
                    }
            }
        }

        
    }
}