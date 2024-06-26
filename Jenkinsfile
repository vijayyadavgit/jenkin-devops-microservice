// SCRIPTED

// DECLARATIVE
pipeline {
	agent any
	// agent { docker { image 'maven:3.6.3' } }
	// agent { docker { image 'node:13.8' } }

	environment {
		dockerHome = tool 'myDocker'
		mavenHome = tool 'myMaven'
		PATH = "$dockerHome/bin:$mavenHome/bin:$PATH"
	}
	
	stages {
		stage('Checkout') {
			steps {
				sh 'mvn --version'
				sh 'docker --version'
				echo "Build"
				echo "$PATH"
				echo "BUILD_NUMBER - $env.BUILD_NUMBER"
				echo "BUILD_ID - $env.BUILD_ID"
				echo "JOB_NAME - $env.JOB_NAME"
				echo "BUILD_TAG - $env.BUILD_TAG"
				echo "BUILD_URL - $env.BUILD_URL"
			}
		}
		
		stage('Compile') {
			steps {
				sh "mvn clean compile"
			}
		}
		
		stage('Test') {
			steps {
				echo "mvn test"
			}
		}
		
		stage('Integration Test') {
			steps {
				echo "mvn failsafe:integration-test failsafe:verify"
			}
		}

		stage('Package') {
			steps {
				echo "mvn package -DskipTests"
			}
		}

		stage('Build Docker Image') {
			steps {
				script {
					dockerImage = docker.build("vijayyadav820/currency-exchange-devops:${env.BUILD_TAG}")
				}
			}	
				
		}

		stage('Push Docker Image') {
			steps {
				script {
					docker.withRegistry("", "dockerhub") {
						dockerImage.push();
						dockerImage.push('latest');
					}
				}
			}	
		}
			
	} 
	
	post {
		always {
			echo 'I awesome. I run always'
		}
		success {
			echo 'I run when you are successful'
		}
		failure {
			echo 'I run when you fail'
		}
	}
	
}
