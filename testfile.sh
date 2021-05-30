def remote = [:]
remote.name = "deploy"
remote.host = "172.31.23.115"
remote.allowAnyHosts = true

node {
        withCredentials([sshUserPrivateKey(credentialsId: 'dev-slave', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'jenkins')]) {
				  remote.user = deploy
				  remote.identityFile = identity
         stage ("test pipeline") {
            writeFile file: 'test.sh' pwd: 'test'
            sshScript remote: remote, script: "test.sh"
            sshPut remote: remote, from: test.sh', into: '/home/jenkins/'
            sshCommand remote: remote, command: "chmod 777 test.sh;./tesh.sh"
           }
        }
        
