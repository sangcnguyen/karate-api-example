import hudson.tasks.test.AbstractTestResultAction

pipeline {
    agent {
        docker {
            image 'maven:3.6.2-jdk-8'
            args '-v /root/.m2:/root/.m2'
        }
    }

    parameters {
        booleanParam(name: 'archiveArtifacts', defaultValue: false, description: 'true: store report files in jenkins, false: skip it')
        string(name: 'tagRun', defaultValue: '@smoke-test', description: 'Select one or more tags to run the test')
        string(name: 'envChoice', defaultValue: 'staging', description: 'Choose environment you want to execute test')
    }

    stages {
        stage('Build project') {
            steps {
                sh "mvn install"
            }
        }
        stage('Run tests') {
            steps{
                echo "Start running API test automation"
                sh "mvn test -Dtest=APITestRunner -Dkarate.env=${params.envChoice} -Dkarate.options=\"--tags ${params.tagRun}\""
                handleArchiveArtifacts()
                junit "**/surefire-reports/*.xml"
                notifyBuild()
            }
        }
    }
}


@NonCPS
def notifyBuild() {
    AbstractTestResultAction testResultAction = currentBuild.rawBuild.getAction(AbstractTestResultAction.class)
    def failedTCs = testResultAction.getFailedTests()
    def total = testResultAction.getTotalCount()
    def failed = testResultAction.getFailCount()
    def skipped = testResultAction.getSkipCount()
    def failedTCsString = ""
    failedTCs.each {
        failedTCsString += "\n${it.getDisplayName()}"
    }
    List<String> temp = params.tagRun.split(',')
    def subject = "Done ${temp} on ${params.envChoice} enviroment"
    def summary = ""
    summary += "${subject}\n"

    summary += "Test Status:\n\t"
    summary += "Passed: " + (total - failed - skipped)
    summary += ", Failed: " + failed
    summary += ", Skipped: " + skipped
    if(failed>0){
        summary += "\n ${failed} failed tests:\n\t"
        summary += "${failedTCsString}"
    }
    summary += "\n"
    summary += "View console log ${env.RUN_DISPLAY_URL}"
    def color = failed > 0 ? 'danger' : 'good'
    slackSend(message: summary, color: color)
}

@NonCPS
def handleArchiveArtifacts(){
    if (params.archiveArtifacts){
        archiveArtifacts(artifacts: '**/surefire-reports/*.*', fingerprint: true)
    }
}