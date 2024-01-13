node {

    stage('Pull code from git repository') { // for display purposes
        
        git branch: 'main', url: 'https://github.com/vvd0502/COSC2767-RMIT-Store'

    }
    stage('Send files over SSH') {
        
        
        sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''sed -i "s/\'db_admin\'@\'localhost\'/\'db_admin\'@\'172.31.40.138\'/g" webapp/sql-scripts/sql-script.sql && mv webapp/test-db webapp/test-webapp . && ansible-playbook booksAndScripts/buildAndPushTest.yml && ansible-playbook booksAndScripts/pullAndRunTest.yml''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: 'webapp', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/*')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
        
       
    }
    stage('Test') {
        echo "Testing"
    }
}
