# Sonarqube for Local Development

Running the Quality Server Sonarqube locally using Docker. Collecting both Unit and Integration tests in different phases of development.

* For Dev Engineers: Many tools that helps with code quality.
* For QA Engineers: All reports from developers, ability to better triage bugs.
* For Managers: Managers can get high-level reports about quality of services.

All descriptions of the new Sonarqube at the following:

* http://www.sonarqube.org/tag/release/
* Current version here: http://www.sonarqube.org/sonarqube-6-0-in-screenshots/
* http://www.sonarqube.org/sonarqube-5-5-in-screenshots/
* http://www.sonarqube.org/github-pull-request-analysis-helps-fix-the-leak/
* https://github.com/integrations/sonarqube

# Requirements

* Docker Engine 1.12.x or newer
* Docker Compose 1.8.x or newer
* Gradle 2.14.1 or newer

# Docker Setup

In regards to the docker sonarqube server, please refer to https://hub.docker.com/r/library/sonarqube for details.

> Current supported version: Sonarqube 6.0

* We use Docker-Compose to execute everything needed, described at `sonarqube-compose.yml`. 
* The current version configured is Sonarqube 6.0.
 * Here's the version: https://hub.docker.com/r/library/sonarqube/tags/

Sonarqube uses Sonarqube Plugins to enhance its experience. The local code already contains a couple of them, but if needed, you may add more to `sonarqube-plugins.Dockerfile`. Here are the important resources to know:

* Plugin Library: http://docs.sonarqube.org/display/PLUG/Plugin+Library
* Downloads:  http://sonarsource.bintray.com/Distribution/
* Compatibility Matrix: http://docs.sonarqube.org/display/PLUG/Plugin+Version+Matrix

> When selecting plugins, please make sure they are compatible to the current version used looking at the `Compatibility Matrix`.

## Setting up

1. Build the Plugins in a docker volume: this downloads the plugins only once and make them available for the running sonarqube server through a shared docker volume.
 * Uses a `docker-compose build` instruction.

2. Start the sonarqube server.
 * Uses the usual `docker-compose up` instruction.

### Setting up Plugins

```
$ docker-compose -f sonarqube-compose.yml build 
sonarqube uses an image, skipping
Building install_plugins
Step 1 : FROM alpine:3.4
 ---> 4e38e38c8ce0
Step 2 : MAINTAINER Guido Zockoll
 ---> Running in e5e45465208a
 ---> 8341a978c31e
Removing intermediate container e5e45465208a
Step 3 : RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community wget ca-certificates
 ---> Running in 874d096f5f7a
fetch http://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.4/community/x86_64/APKINDEX.tar.gz
(1/2) Installing ca-certificates (20160104-r4)
(2/2) Installing wget (1.18-r0)
Executing busybox-1.24.2-r9.trigger
Executing ca-certificates-20160104-r4.trigger
OK: 6 MiB in 13 packages
 ---> 1e97b7fe7954
Removing intermediate container 874d096f5f7a
Step 4 : WORKDIR /opt/download
 ---> Running in 00296062a5a8
 ---> 08c846cf9fcc
Removing intermediate container 00296062a5a8
Step 5 : RUN wget http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-motion-chart-plugin/1.7/sonar-motion-chart-plugin-1.7.jar
 ---> Running in f6f5a4bcb919
--2016-08-26 04:35:13--  http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-motion-chart-plugin/1.7/sonar-motion-chart-plugin-1.7.jar
Resolving downloads.sonarsource.com... 75.101.133.159
Connecting to downloads.sonarsource.com|75.101.133.159|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 14188 (14K) [application/java-archive]
Saving to: 'sonar-motion-chart-plugin-1.7.jar'

     0K .......... ...                                        100%  316M=0s

2016-08-26 04:35:14 (316 MB/s) - 'sonar-motion-chart-plugin-1.7.jar' saved [14188/14188]

 ---> d64e3f2f5c08
Removing intermediate container f6f5a4bcb919
Step 6 : RUN wget http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-timeline-plugin/1.5/sonar-timeline-plugin-1.5.jar
 ---> Running in a8046f088c81
--2016-08-26 04:35:14--  http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-timeline-plugin/1.5/sonar-timeline-plugin-1.5.jar
Resolving downloads.sonarsource.com... 75.101.133.159
Connecting to downloads.sonarsource.com|75.101.133.159|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 7364 (7.2K) [application/java-archive]
Saving to: 'sonar-timeline-plugin-1.5.jar'

     0K .......                                               100% 3.45M=0.002s

2016-08-26 04:35:14 (3.45 MB/s) - 'sonar-timeline-plugin-1.5.jar' saved [7364/7364]

 ---> 5d0869cc003e
Removing intermediate container a8046f088c81
Step 7 : RUN wget https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-4.1.jar
 ---> Running in 70e3d0451037
--2016-08-26 04:35:15--  https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-4.1.jar
Resolving sonarsource.bintray.com... 75.126.118.188, 108.168.243.150
Connecting to sonarsource.bintray.com|75.126.118.188|:443... connected.
HTTP request sent, awaiting response... 302 
Location: https://akamai.bintray.com/f6/f6270df4d43518d586e5f734d53970d68f524252833f286bfaeec841350114b1?__gda__=exp=1472186835~hmac=bbbb07df71b97a9f13616dfecfac768532fcc34307335212c76b7b7e218b13be&response-content-disposition=attachment%3Bfilename%3D%22sonar-java-plugin-4.1.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX197e71GFDbvos08Bf4w5akXQ77rkZd_Mid8pOtn1bVgTlgV54HuBWAgpG24cJn9wsU_vmwvvi-1xlm5Ouzz2yleXiRfjDWCDSJcphQAWpii8FQEvyWEp6uprX9W0ZkDScQIe5HZZrEBZA [following]
--2016-08-26 04:35:15--  https://akamai.bintray.com/f6/f6270df4d43518d586e5f734d53970d68f524252833f286bfaeec841350114b1?__gda__=exp=1472186835~hmac=bbbb07df71b97a9f13616dfecfac768532fcc34307335212c76b7b7e218b13be&response-content-disposition=attachment%3Bfilename%3D%22sonar-java-plugin-4.1.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX197e71GFDbvos08Bf4w5akXQ77rkZd_Mid8pOtn1bVgTlgV54HuBWAgpG24cJn9wsU_vmwvvi-1xlm5Ouzz2yleXiRfjDWCDSJcphQAWpii8FQEvyWEp6uprX9W0ZkDScQIe5HZZrEBZA
Resolving akamai.bintray.com... 104.95.221.65
Connecting to akamai.bintray.com|104.95.221.65|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 6070066 (5.8M) [application/java-archive]
Saving to: 'sonar-java-plugin-4.1.jar'

     0K .......... .......... .......... .......... ..........  0% 2.12M 3s
    50K .......... .......... .......... .......... ..........  1% 2.22M 3s
   100K .......... .......... .......... .......... ..........  2% 10.9M 2s
...
...
  5700K .......... .......... .......... .......... .......... 97% 33.6M 0s
  5750K .......... .......... .......... .......... .......... 97% 25.8M 0s
  5800K .......... .......... .......... .......... .......... 98% 9.64M 0s
  5850K .......... .......... .......... .......... .......... 99% 18.7M 0s
  5900K .......... .......... .......                         100% 11.5M=0.7s

2016-08-26 04:35:16 (8.88 MB/s) - 'sonar-java-plugin-4.1.jar' saved [6070066/6070066]

 ---> 55d268779104
Removing intermediate container 70e3d0451037
Step 8 : RUN wget http://sonarsource.bintray.com/Distribution/sonar-xml-plugin/sonar-xml-plugin-1.4.1.jar
 ---> Running in ebeb165ffc32
--2016-08-26 04:35:17--  http://sonarsource.bintray.com/Distribution/sonar-xml-plugin/sonar-xml-plugin-1.4.1.jar
Resolving sonarsource.bintray.com... 75.126.118.188, 108.168.243.150
Connecting to sonarsource.bintray.com|75.126.118.188|:80... connected.
HTTP request sent, awaiting response... 302 
Location: http://akamai.bintray.com/21/2159c2f4fc07bbc6f589c73aefe5ff675e2b494cc559f55d5b3aaf71f37dacc5?__gda__=exp=1472186837~hmac=b8ade0c1cb2b218bb8da449c1edc1bad446792fdd92c793721515396047e4046&response-content-disposition=attachment%3Bfilename%3D%22sonar-xml-plugin-1.4.1.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX18fCrWrs5Ty0H3hg5z8Ed46p2SFOoZenuwcH1BSiTgr7mya-5WJLo7JhEd4qpGVDTKdUro2TFGRK2-NtSTm6lQbXhuB8VYS8JTn3YWKv-NaB0K7n2Vdpubj700e11z39QmWp7w7oSCyTQ [following]
--2016-08-26 04:35:17--  http://akamai.bintray.com/21/2159c2f4fc07bbc6f589c73aefe5ff675e2b494cc559f55d5b3aaf71f37dacc5?__gda__=exp=1472186837~hmac=b8ade0c1cb2b218bb8da449c1edc1bad446792fdd92c793721515396047e4046&response-content-disposition=attachment%3Bfilename%3D%22sonar-xml-plugin-1.4.1.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX18fCrWrs5Ty0H3hg5z8Ed46p2SFOoZenuwcH1BSiTgr7mya-5WJLo7JhEd4qpGVDTKdUro2TFGRK2-NtSTm6lQbXhuB8VYS8JTn3YWKv-NaB0K7n2Vdpubj700e11z39QmWp7w7oSCyTQ
Resolving akamai.bintray.com... 104.95.221.65
Connecting to akamai.bintray.com|104.95.221.65|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 5030691 (4.8M) [application/java-archive]
Saving to: 'sonar-xml-plugin-1.4.1.jar'

     0K .......... .......... .......... .......... ..........  1% 1.32M 4s
    50K .......... .......... .......... .......... ..........  2%  662K 5s
...
...
  4850K .......... .......... .......... .......... .......... 99% 1.92M 0s
  4900K .......... ..                                         100% 1.98M=3.0s

2016-08-26 04:35:20 (1.61 MB/s) - 'sonar-xml-plugin-1.4.1.jar' saved [5030691/5030691]

 ---> 6a2c734ebe15
Removing intermediate container ebeb165ffc32
Step 9 : RUN wget https://sonarsource.bintray.com/Distribution/sonar-groovy-plugin/sonar-groovy-plugin-1.4.jar
 ---> Running in 51be51596bf0
--2016-08-26 04:35:21--  https://sonarsource.bintray.com/Distribution/sonar-groovy-plugin/sonar-groovy-plugin-1.4.jar
Resolving sonarsource.bintray.com... 75.126.118.188, 108.168.243.150
Connecting to sonarsource.bintray.com|75.126.118.188|:443... connected.
HTTP request sent, awaiting response... 302 
Location: https://akamai.bintray.com/3c/3cfbed765b7d30b22f37b466ff1c8ee9b720eec035bba38aaa0d6a2086b56701?__gda__=exp=1472186841~hmac=0f83bd47541539194866ee7a03feba36f0a8fe53df83962d188dde84617fb792&response-content-disposition=attachment%3Bfilename%3D%22sonar-groovy-plugin-1.4.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX1_vJe_Dj1LFJG5K3XEUwMx5pJynH_UE7B5W_zok4I9j_NMfBfCZLxohWvjE7NFwHzR2lUd161MPBTN8mFaiuBtPyvxv13vPhcZgSunbh7SR1xBccVJxh1DESA9TDBmHDJGZ5PmS4bfczg [following]
--2016-08-26 04:35:21--  https://akamai.bintray.com/3c/3cfbed765b7d30b22f37b466ff1c8ee9b720eec035bba38aaa0d6a2086b56701?__gda__=exp=1472186841~hmac=0f83bd47541539194866ee7a03feba36f0a8fe53df83962d188dde84617fb792&response-content-disposition=attachment%3Bfilename%3D%22sonar-groovy-plugin-1.4.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX1_vJe_Dj1LFJG5K3XEUwMx5pJynH_UE7B5W_zok4I9j_NMfBfCZLxohWvjE7NFwHzR2lUd161MPBTN8mFaiuBtPyvxv13vPhcZgSunbh7SR1xBccVJxh1DESA9TDBmHDJGZ5PmS4bfczg
Resolving akamai.bintray.com... 104.95.221.65
Connecting to akamai.bintray.com|104.95.221.65|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 13962448 (13M) [application/java-archive]
Saving to: 'sonar-groovy-plugin-1.4.jar'

     0K .......... .......... .......... .......... ..........  0% 2.37M 6s
    50K .......... .......... .......... .......... ..........  0% 2.75M 5s
   100K .......... .......... .......... .......... ..........  1% 3.69M 5s
   150K .......... .......... .......... .......... ..........  1% 8.75M 4s
   200K .......... .......... .......... .......... ..........  1% 28.1M 3s
...
...
 13500K .......... .......... .......... .......... .......... 99% 33.4M 0s
 13550K .......... .......... .......... .......... .......... 99% 44.7M 0s
 13600K .......... .......... .......... .....                100% 26.5M=2.1s

2016-08-26 04:35:24 (6.26 MB/s) - 'sonar-groovy-plugin-1.4.jar' saved [13962448/13962448]

 ---> 4901b7d79745
Removing intermediate container 51be51596bf0
Step 10 : RUN wget https://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-1.2.jar
 ---> Running in 83c5459ba025
--2016-08-26 04:35:24--  https://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-1.2.jar
Resolving sonarsource.bintray.com... 75.126.118.188, 108.168.243.150
Connecting to sonarsource.bintray.com|75.126.118.188|:443... connected.
HTTP request sent, awaiting response... 302 
Location: https://akamai.bintray.com/c3/c3ffae97a038f84905967a4221766dd7d8e3c66cd68bd62f5dd9f7108169e6bf?__gda__=exp=1472186845~hmac=ee9fa93de72728505087e057ee1494ec09b52ffadea014d4d29bf05d730cbd7c&response-content-disposition=attachment%3Bfilename%3D%22sonar-scm-git-plugin-1.2.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX1_1HUH0Bl0qV2U2GMxmFwgljAj9shBOEmm7dR_E-m66Q3i0-D32-qfoSSH8U8f-ODVenhPi-pg9P6HZ2YAjlkgn-ut0ssm0qOwu-Mmp4IlWVXMX3smfQaGyEyC9rV3xt_RBAGTF_qfw6A [following]
--2016-08-26 04:35:25--  https://akamai.bintray.com/c3/c3ffae97a038f84905967a4221766dd7d8e3c66cd68bd62f5dd9f7108169e6bf?__gda__=exp=1472186845~hmac=ee9fa93de72728505087e057ee1494ec09b52ffadea014d4d29bf05d730cbd7c&response-content-disposition=attachment%3Bfilename%3D%22sonar-scm-git-plugin-1.2.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX1_1HUH0Bl0qV2U2GMxmFwgljAj9shBOEmm7dR_E-m66Q3i0-D32-qfoSSH8U8f-ODVenhPi-pg9P6HZ2YAjlkgn-ut0ssm0qOwu-Mmp4IlWVXMX3smfQaGyEyC9rV3xt_RBAGTF_qfw6A
Resolving akamai.bintray.com... 104.95.221.65
Connecting to akamai.bintray.com|104.95.221.65|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3233126 (3.1M) [application/java-archive]
Saving to: 'sonar-scm-git-plugin-1.2.jar'

     0K .......... .......... .......... .......... ..........  1% 1.98M 2s
    50K .......... .......... .......... .......... ..........  3% 2.07M 1s
   100K .......... .......... .......... .......... ..........  4% 6.68M 1s
...
...
  3000K .......... .......... .......... .......... .......... 96% 34.1M 0s
  3050K .......... .......... .......... .......... .......... 98%  299M 0s
  3100K .......... .......... .......... .......... .......... 99% 51.5M 0s
  3150K .......                                               100%  453M=1.7s

2016-08-26 04:35:27 (1.78 MB/s) - 'sonar-scm-git-plugin-1.2.jar' saved [3233126/3233126]

 ---> e8eada476da4
Removing intermediate container 83c5459ba025
Step 11 : RUN wget http://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-2.15.jar
 ---> Running in 68cabaa6f271
--2016-08-26 04:35:27--  http://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-2.15.jar
Resolving sonarsource.bintray.com... 75.126.118.188, 108.168.243.150
Connecting to sonarsource.bintray.com|75.126.118.188|:80... connected.
HTTP request sent, awaiting response... 302 
Location: http://akamai.bintray.com/04/04b4b5d5c789d613a9ceccc548b6f865e5197990143ce94d554b0844f26d7610?__gda__=exp=1472186847~hmac=eeed94bbccfafac1084a2a87db70611a5c496a229a96bde368c7d4ea9f684f0f&response-content-disposition=attachment%3Bfilename%3D%22sonar-javascript-plugin-2.15.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX1-B5B9yoGYGx0EmspMFBE7QBbnGINA9y_XwDL8Yr_xklR-EBCM8LDG_NCOPUWuLrTiLWOTtd5qKbU5Lj9MfcqHT5bUY8n2I8dYjdereUFlFu-Ts-tR6qZ_SQUqaGnvbqZh38d3pP9lv9A [following]
--2016-08-26 04:35:27--  http://akamai.bintray.com/04/04b4b5d5c789d613a9ceccc548b6f865e5197990143ce94d554b0844f26d7610?__gda__=exp=1472186847~hmac=eeed94bbccfafac1084a2a87db70611a5c496a229a96bde368c7d4ea9f684f0f&response-content-disposition=attachment%3Bfilename%3D%22sonar-javascript-plugin-2.15.jar%22&response-content-type=application%2Fjava-archive&requestInfo=U2FsdGVkX1-B5B9yoGYGx0EmspMFBE7QBbnGINA9y_XwDL8Yr_xklR-EBCM8LDG_NCOPUWuLrTiLWOTtd5qKbU5Lj9MfcqHT5bUY8n2I8dYjdereUFlFu-Ts-tR6qZ_SQUqaGnvbqZh38d3pP9lv9A
Resolving akamai.bintray.com... 104.95.221.65
Connecting to akamai.bintray.com|104.95.221.65|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 2618162 (2.5M) [application/java-archive]
Saving to: 'sonar-javascript-plugin-2.15.jar'

     0K .......... .......... .......... .......... ..........  1% 1.96M 1s
    50K .......... .......... .......... .......... ..........  3% 2.35M 1s
   100K .......... .......... .......... .......... ..........  5% 5.76M 1s
...
...
  2450K .......... .......... .......... .......... .......... 97% 25.7M 0s
  2500K .......... .......... .......... .......... .......... 99% 60.7M 0s
  2550K ......                                                100%  435M=0.8s

2016-08-26 04:35:28 (3.12 MB/s) - 'sonar-javascript-plugin-2.15.jar' saved [2618162/2618162]

 ---> 7a0319139e2e
Removing intermediate container 68cabaa6f271
Step 12 : VOLUME /opt/sonarqube/lib/bundled-plugins
 ---> Running in 22382826b3e4
 ---> dbd8818f7b63
Removing intermediate container 22382826b3e4
Step 13 : CMD cp -R /opt/download/* /opt/sonarqube/lib/bundled-plugins
 ---> Running in 0e3f6752c8d2
 ---> a9d6bd0c2b24
Removing intermediate container 0e3f6752c8d2
Successfully built a9d6bd0c2b24
db uses an image, skipping
```

### Setting up Server

The server can be run with the following command using docker-compose. It will do the following:

* Initialize a Postgres Server
* Initialize a Sonarqube server at port `9000`.
 * Load the plugins built in the previous step from a Docker Volume. (`maker_install_plugins_1` docker service)
 * Will connect Sonarqube to Postgres and initialize its database. (`db_1` docker service)
 * Will load other services and initializes the server itself (`sonarqube_1` docker service)

```
$ docker-compose -f sonarqube-compose.yml up
Creating volume "maker_postgresql2_data" with default driver
Creating volume "maker_sonarqube2_extensions" with default driver
Creating volume "maker_sonarqube2_data" with default driver
Creating volume "maker_postgresql2" with default driver
Creating volume "maker_sonarqube2_conf" with default driver
Creating volume "maker_sonarqube2_bundled-plugins" with default driver
Creating maker_db_1
Creating maker_install_plugins_1
Creating maker_sonarqube_1
Attaching to maker_db_1, maker_install_plugins_1, maker_sonarqube_1
db_1               | The files belonging to this database system will be owned by user "postgres".
db_1               | This user must also own the server process.
db_1               | 
db_1               | The database cluster will be initialized with locale "en_US.utf8".
db_1               | The default database encoding has accordingly been set to "UTF8".
db_1               | The default text search configuration will be set to "english".
db_1               | 
db_1               | Data page checksums are disabled.
db_1               | 
db_1               | fixing permissions on existing directory /var/lib/postgresql/data ... ok
db_1               | creating subdirectories ... ok
db_1               | selecting default max_connections ... 100
db_1               | selecting default shared_buffers ... 128MB
db_1               | selecting dynamic shared memory implementation ... posix
maker_install_plugins_1 exited with code 0
db_1               | creating configuration files ... ok
sonarqube_1        | 2016.08.26 04:40:33 INFO  app[o.s.a.AppFileSystem] Cleaning or creating temp directory /opt/sonarqube/temp
sonarqube_1        | 2016.08.26 04:40:33 INFO  app[o.s.p.m.JavaProcessLauncher] Launch process[es]: /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Djava.awt.headless=true -Xmx1G -Xms256m -Xss256k -Djna.nosys=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -Djava.io.tmpdir=/opt/sonarqube/temp -javaagent:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/management-agent.jar -cp ./lib/common/*:./lib/search/* org.sonar.search.SearchServer /opt/sonarqube/temp/sq-process3699817720408540938properties
db_1               | creating template1 database in /var/lib/postgresql/data/base/1 ... ok
db_1               | initializing pg_authid ... ok
db_1               | initializing dependencies ... ok
db_1               | creating system views ... ok
db_1               | loading system objects' descriptions ... ok
sonarqube_1        | 2016.08.26 04:40:34 INFO   es[o.s.p.ProcessEntryPoint]  Starting es
db_1               | creating collations ... ok
db_1               | creating conversions ... ok
sonarqube_1        | 2016.08.26 04:40:34 INFO   es[o.s.s.EsSettings]  Elasticsearch listening on /127.0.0.1:9001
db_1               | creating dictionaries ... ok
db_1               | setting privileges on built-in objects ... ok
db_1               | creating information schema ... ok
db_1               | loading PL/pgSQL server-side language ... ok
sonarqube_1        | 2016.08.26 04:40:34 INFO   es[o.elasticsearch.node]  [sonar-1472186433560] version[2.3.3], pid[17], build[218bdf1/2016-05-17T15:40:04Z]
sonarqube_1        | 2016.08.26 04:40:34 INFO   es[o.elasticsearch.node]  [sonar-1472186433560] initializing ...
sonarqube_1        | 2016.08.26 04:40:34 INFO   es[o.e.plugins]  [sonar-1472186433560] modules [], plugins [], sites []
sonarqube_1        | 2016.08.26 04:40:34 INFO   es[o.elasticsearch.env]  [sonar-1472186433560] using [1] data paths, mounts [[/opt/sonarqube/data (/dev/sda1)]], net usable_space [53.2gb], net total_space [97.3gb], spins? [possibly], types [ext4]
sonarqube_1        | 2016.08.26 04:40:34 INFO   es[o.elasticsearch.env]  [sonar-1472186433560] heap size [1007.3mb], compressed ordinary object pointers [true]
db_1               | vacuuming database template1 ... ok
db_1               | copying template1 to template0 ... ok
db_1               | copying template1 to postgres ... ok
db_1               | syncing data to disk ... ok
db_1               | 
db_1               | WARNING: enabling "trust" authentication for local connections
db_1               | You can change this by editing pg_hba.conf or using the option -A, or
db_1               | --auth-local and --auth-host, the next time you run initdb.
db_1               | 
db_1               | Success. You can now start the database server using:
db_1               | 
db_1               |     pg_ctl -D /var/lib/postgresql/data -l logfile start
db_1               | 
db_1               | waiting for server to start....LOG:  database system was shut down at 2016-08-26 04:40:34 UTC
db_1               | LOG:  MultiXact member wraparound protections are now enabled
db_1               | LOG:  database system is ready to accept connections
db_1               | LOG:  autovacuum launcher started
db_1               |  done
db_1               | server started
db_1               | CREATE DATABASE
db_1               | 
db_1               | CREATE ROLE
...
...
...
 org.sonar.server.ws.WebServiceFilter@101372e [pattern=org.sonar.api.web.ServletFilter$UrlPattern@17ba777]
sonarqube_1        | 2016.08.26 04:41:05 INFO  web[o.s.s.p.MasterServletFilter] Initializing servlet filter org.sonar.server.authentication.InitFilter@15d806a7 [pattern=org.sonar.api.web.ServletFilter$UrlPattern@1d68fb75]
sonarqube_1        | 2016.08.26 04:41:05 INFO  web[o.s.s.p.MasterServletFilter] Initializing servlet filter org.sonar.server.authentication.OAuth2CallbackFilter@3dfcd1e5 [pattern=org.sonar.api.web.ServletFilter$UrlPattern@68c415c3]
sonarqube_1        | 2016.08.26 04:41:05 INFO  web[o.s.s.p.MasterServletFilter] Initializing servlet filter org.sonar.server.authentication.ws.LoginAction@da800e3 [pattern=org.sonar.api.web.ServletFilter$UrlPattern@458a7698]
sonarqube_1        | 2016.08.26 04:41:05 INFO  web[o.s.s.p.MasterServletFilter] Initializing servlet filter org.sonar.server.authentication.ws.ValidateAction@4aee6e04 [pattern=org.sonar.api.web.ServletFilter$UrlPattern@78cd0a2]
sonarqube_1        | 2016.08.26 04:41:05 INFO  web[o.a.c.h.Http11NioProtocol] Starting ProtocolHandler ["http-nio-0.0.0.0-9000"]
sonarqube_1        | 2016.08.26 04:41:05 INFO  web[o.s.s.a.TomcatAccessLog] Web server is started
sonarqube_1        | 2016.08.26 04:41:05 INFO  web[o.s.s.a.EmbeddedTomcat] HTTP connector enabled on port 9000
sonarqube_1        | 2016.08.26 04:41:06 INFO  app[o.s.p.m.Monitor] Process[web] is up
sonarqube_1        | 2016.08.26 04:41:06 INFO  app[o.s.p.m.JavaProcessLauncher] Launch process[ce]: /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Xmx512m -Xms128m -XX:+HeapDumpOnOutOfMemoryError -Djava.io.tmpdir=/opt/sonarqube/temp -javaagent:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/management-agent.jar -cp ./lib/common/*:./lib/server/*:./lib/ce/*:/opt/sonarqube/lib/jdbc/postgresql/postgresql-9.3-1102-jdbc41.jar org.sonar.ce.app.CeServer /opt/sonarqube/temp/sq-process1804912028867029977properties
sonarqube_1        | 2016.08.26 04:41:06 INFO  ce[o.s.p.ProcessEntryPoint] Starting ce
sonarqube_1        | 2016.08.26 04:41:06 INFO  ce[o.s.ce.app.CeServer] Compute Engine starting up...
sonarqube_1        | 2016.08.26 04:41:06 INFO  ce[o.s.s.p.ServerImpl] SonarQube Server / 6.0 / 93442889cd219e78b028c7dcf51a30de74c987fe
sonarqube_1        | 2016.08.26 04:41:06 INFO  ce[o.sonar.db.Database] Create JDBC data source for jdbc:postgresql://db:5432/sonar?user=sonar&password=sonar
sonarqube_1        | 2016.08.26 04:41:07 INFO  ce[o.s.s.p.DefaultServerFileSystem] SonarQube home: /opt/sonarqube
sonarqube_1        | 2016.08.26 04:41:07 INFO  ce[o.e.plugins] [sonar-1472186433560] modules [], plugins [], sites []
sonarqube_1        | 2016.08.26 04:41:08 INFO  ce[o.s.c.c.CePluginRepository] Load plugins
sonarqube_1        | 2016.08.26 04:41:09 INFO  ce[o.s.s.c.q.PurgeCeActivities] Delete the Compute Engine tasks created before Sun Feb 28 04:41:09 UTC 2016
sonarqube_1        | 2016.08.26 04:41:09 INFO  ce[o.s.ce.app.CeServer] Compute Engine is up
sonarqube_1        | 2016.08.26 04:41:09 INFO  app[o.s.p.m.Monitor] Process[ce] is up
```

## Connecting to Sonarqube Server

After the server is up and running, you can connect the server from `http://localhost:9000`. 

* From Gradle: Use the environment variable SONARQUBE_SERVER_URL=http://localhost:9000
 * Note that you can map the port number to a different one using Docker's magic.
* From Browser: After you execute the command above during tests, you can go to the browser and see the results. 

# Publishing Quality Reports

Here's what this setup is already capable of:

* Execute unit tests and submit to the server.
* Execute unit and integration tests together, merge the results and submit to the server.

Running code without reports show up empty.

## Publishing Unit Tests

* Execute the unit tests with sonarqube. 
* After it finishes, open the same URL in the browser and see the initial report.

The server will then display more quality reports like the Code Coverage numbers.

```
$ SONARQUBE_SERVER_URL=http://localhost:9000 gradle clean test sonarqube
```
or check, which executes the test.

```
$ SONARQUBE_SERVER_URL=http://localhost:9000 gradle check sonarqube
:clean
:compileJava
:processResources
:classes
:compileTestJava
:processTestResources
:testClasses
:test

cash.super.platform.ConfigMatrixDownloadIntegrationTests > testGetAndLoadMatrix STARTED

cash.super.platform.ConfigMatrixDownloadIntegrationTests > testGetAndLoadMatrix PASSED

cash.super.platform.MatrixFileAndS3BucketControllerTest > getMatrixFilesListWithCustomLabelAndS3Bucket STARTED

cash.super.platform.MatrixFileAndS3BucketControllerTest > getMatrixFilesListWithCustomLabelAndS3Bucket PASSED

cash.super.platform.MatrixFileAndS3BucketControllerTest > getMatrixFilesListWithCustomLabelAndS3BucketButWithoutOutputTypes STARTED

cash.super.platform.MatrixFileAndS3BucketControllerTest > getMatrixFilesListWithCustomLabelAndS3BucketButWithoutOutputTypes PASSED

cash.super.platform.MatrixFilesResponseCartesianProductControllerTest > cartesianProductSetContainsAllFilesTest STARTED

cash.super.platform.MatrixFilesResponseCartesianProductControllerTest > cartesianProductSetContainsAllFilesTest PASSED

cash.super.platform.ConfigMatrixWithOutputFileTypesDownloadAndProcessingIntegrationTests > verifyThatMatrixFilesAreDownloaded STARTED

cash.super.platform.ConfigMatrixWithOutputFileTypesDownloadAndProcessingIntegrationTests > verifyThatMatrixFilesAreDownloaded PASSED

cash.super.platform.ConfigMatrixDownloadAndProcessingIntegrationTests > verifyThatMatrixFilesAreDownloaded STARTED

cash.super.platform.ConfigMatrixDownloadAndProcessingIntegrationTests > verifyThatMatrixFilesAreDownloaded PASSED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListWithLabelWithReplaceTokenDefaultS3Bucket STARTED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListWithLabelWithReplaceTokenDefaultS3Bucket PASSED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListDefaults STARTED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListDefaults PASSED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListWithCustomLabelAsMaster STARTED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListWithCustomLabelAsMaster PASSED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListWithLabelDefaultS3Bucket STARTED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListWithLabelDefaultS3Bucket PASSED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListWithLabelForwardSlashesDefaultS3Bucket STARTED

cash.super.platform.MatrixFileAndLabelsControllerTest > getMatrixFilesListWithLabelForwardSlashesDefaultS3Bucket PASSED

cash.super.platform.ConfigMatrixWithWrongSigVersionDownloadAndProcessingIntegrationTests > verifyThatMatrixFilesAreDownloaded STARTED

cash.super.platform.ConfigMatrixWithWrongSigVersionDownloadAndProcessingIntegrationTests > verifyThatMatrixFilesAreDownloaded PASSED

2016-08-25 21:54:05.380  INFO 84562 --- [      Thread-25] o.s.w.c.s.GenericWebApplicationContext   : Closing 
2016-08-25 21:54:05.458  WARN 84562 --- [      Thread-25] c.i.p.j.c.listener.ConfigClientListener  : ContextClosedEvent: no entry for ac=org.springframework.web.context.support.GenericWebApplicationContext@300e05d9: startup date [Thu Aug 25 21:53:59 PDT 2016]; parent: org.springframework.context.annotation.AnnotationConfigApplicationContext@7645efa
2016-08-25 21:54:05.459  INFO 84562 --- [      Thread-25] o.s.c.support.DefaultLifecycleProcessor  : Stopping beans in phase 2147483647
:sonarqube

BUILD SUCCESSFUL

Total time: 39.356 secs
== Build Time Summary ==
                                                                             0% :processTestResources (0:00.151)
                                                                          ▇  1% :processResources (0:00.211)
                                                                          ▇  1% :clean (0:00.352)
                                                                       ▇▇▇▇  3% :compileTestJava (0:00.914)
                                                     ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 13% :compileJava (0:04.242)
        ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 39% :sonarqube (0:12.803)
▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 43% :test (0:14.348)

== BUILD SUCCESSFUL ==
```

The test cases and code coverage list is on the section shown in the screen.

> Note that there are 34 test cases implemented in the unit tests.

## Publishing Integration Tests

Integration tests runs with unit and the merged reports are sent to Sonarqube. You just need to use the commands to properly:

1. Execute Integration tests
2. Merge Integation and Unit test reports
3. Push to sonarqube as usual.
4. Go to the browser and refresh the Sonarqube page with reports.

The reports will be updated as follows:

```
$ SONARQUBE_SERVER_URL=http://localhost:9000 gradle -x test check integrationTest jacocoMergedReports sonarqube
:compileJava UP-TO-DATE
:processResources UP-TO-DATE
:classes UP-TO-DATE
:compileTestJava UP-TO-DATE
:processTestResources UP-TO-DATE
:testClasses UP-TO-DATE
:compileIntegrationTestJava
:processIntegrationTestResources UP-TO-DATE
:integrationTestClasses
:integrationTest

cash.super.platform.GithubWebhookControllerFullIntegrationTest STANDARD_OUT
    22:23:00.128 [Test worker] DEBUG org.springframework.test.context.junit4.SpringJUnit4ClassRunner - SpringJUnit4ClassRunner constructor called with [class cash.super.platform.GithubWebhookControllerFullIntegrationTest]
    22:23:00.139 [Test worker] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating CacheAwareContextLoaderDelegate from class [org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate]
    22:23:00.154 [Test worker] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating BootstrapContext using constructor [public org.springframework.test.context.support.DefaultBootstrapContext(java.lang.Class,org.springframework.test.context.CacheAwareContextLoaderDelegate)]
    22:23:00.185 [Test worker] DEBUG org.springframework.test.context.BootstrapUtils - Instantiating TestContextBootstrapper for test class [cash.super.platform.GithubWebhookControllerFullIntegrationTest] from class [org.springframework.boot.test.context.SpringBootTestContextBootstrapper]
    22:23:00.206 [Test worker] INFO org.springframework.boot.test.context.SpringBootTestContextBootstrapper - Neither @ContextConfiguration nor @ContextHierarchy found for test class [cash.super.platform.GithubWebhookControllerFullIntegrationTest], using SpringBootContextLoader
...
...
...
    2016-08-25 22:56:36.681  INFO 90402 --- [    Test worker] thubWebhookControllerFullIntegrationTest : HTTP GET https://s3-us-west-1.amazonaws.com/supercash-caas-super--maker-config/maker-prf,qydc,onboard_preprod.metadata: 200
    2016-08-25 22:56:36.719  INFO 90402 --- [    Test worker] thubWebhookControllerFullIntegrationTest : HTTP GET https://s3-us-west-1.amazonaws.com/supercash-caas-super--maker-config/maker-prf,qydc,onboard_preprod.json: 200
    2016-08-25 22:56:36.756  INFO 90402 --- [    Test worker] thubWebhookControllerFullIntegrationTest : HTTP GET https://s3-us-west-1.amazonaws.com/supercash-caas-super--maker-config/maker-prf,qydc,onboard_preprod.yml: 200
    2016-08-25 22:56:36.795  INFO 90402 --- [    Test worker] thubWebhookControllerFullIntegrationTest : HTTP GET https://s3-us-west-1.amazonaws.com/supercash-caas-super--maker-config/maker-prf,qydc,onboard_preprod.metadata.sig: 200

cash.super.platform.GithubWebhookControllerFullIntegrationTest > fullWebhookE2ETest PASSED
...
...
2016-08-25 22:56:47.661  INFO 90483 --- [      Thread-25] c.i.p.j.c.listener.ConfigClientListener  : findRefresher: ContextClosedEvent -- no refresher found for ac=org.springframework.web.context.support.GenericWebApplicationContext@76eead54: startup date [Thu Aug 25 22:56:42 PDT 2016]; parent: org.springframework.context.annotation.AnnotationConfigApplicationContext@4a0dce1
2016-08-25 22:56:47.661  WARN 90483 --- [      Thread-25] c.i.p.j.c.listener.ConfigClientListener  : ContextClosedEvent: no entry for ac=org.springframework.web.context.support.GenericWebApplicationContext@76eead54: startup date [Thu Aug 25 22:56:42 PDT 2016]; parent: org.springframework.context.annotation.AnnotationConfigApplicationContext@4a0dce1
2016-08-25 22:56:47.665  INFO 90483 --- [      Thread-25] o.s.c.support.DefaultLifecycleProcessor  : Stopping beans in phase 2147483647
:jacocoMerge
:jacocoMergedReports SKIPPED
:sonarqube
Invalid character encountered in file /home/mdesales/dev/github/supercash/platform/maker/src/main/resources/certs/server.jks at line 1 for encoding UTF-8. Please fix file content or configure the encoding to be used using property 'sonar.sourceEncoding'.
2016-08-26 00:48:00.716  INFO 95564 --- [      Thread-10] c.i.p.jsk.config.client.RefresherImpl    : closed() called for this=❲RefresherImpl@fde68951 #1 2016-08-26T00:47:32.585 ac=org.springframework.boot.context.embedded.AnnotationConfigEmbeddedWebApplicationContext@3837f939: startup date [Fri Aug 26 00:47:27 PDT 2016]; parent: org.springframework.context.annotation.AnnotationConfigApplicationContext@716f0223 loc=org.springframework.cloud.config.client.ConfigServicePropertySourceLocator@6f161a34❳ elapsedMs=7 lifetimeSecs=28
2016-08-26 00:48:00.718  INFO 95564 --- [      Thread-10] o.s.c.support.DefaultLifecycleProcessor  : Stopping beans in phase 2147483647
2016-08-26 00:48:00.730  INFO 95564 --- [      Thread-10] c.i.p.jsk.config.client.RefresherImpl    : preDestroy: this=❲RefresherImpl@fde68951 #1 2016-08-26T00:47:32.585 ac=org.springframework.boot.context.embedded.AnnotationConfigEmbeddedWebApplicationContext@3837f939: startup date [Fri Aug 26 00:47:27 PDT 2016]; parent: org.springframework.context.annotation.AnnotationConfigApplicationContext@716f0223 loc=org.springframework.cloud.config.client.ConfigServicePropertySourceLocator@6f161a34❳
:jacocoMerge
:jacocoMergedReports SKIPPED
:sonarqube
Invalid character encountered in file /home/mdesales/dev/github/supercash/platform/maker/src/main/resources/certs/server.jks at line 1 for encoding UTF-8. Please fix file content or configure the encoding to be used using property 'sonar.sourceEncoding'.
Invalid character encountered in file /home/mdesales/dev/github/supercash/platform/maker/src/main/docker/lib/jce_policy-8.zip at line 2 for encoding UTF-8. Please fix file content or configure the encoding to be used using property 'sonar.sourceEncoding'.
Class not found: org.apache.http.annotation.NotThreadSafe
Class not found: org.apache.http.annotation.Immutable
Class not found: org.apache.http.annotation.NotThreadSafe
Class not found: org.apache.http.annotation.ThreadSafe
Missing blame information for the following files:
  * /home/mdesales/dev/github/supercash/platform/maker/src/main/docker/lib/jce_policy-8.zip
  * /home/mdesales/dev/github/supercash/platform/maker/src/main/resources/certs/server.jks
This may lead to missing/broken features in SonarQube

BUILD SUCCESSFUL

Total time: 1 mins 16.123 secs
== Build Time Summary ==
                                                                                   0% :processTestResources (0:00.063)
                                                                                   0% :jacocoMerge (0:00.077)
                                                                                   0% :compileTestJava (0:00.317)
                                                                                ▇  1% :pmdIntegrationTest (0:00.579)
                                                                               ▇▇  1% :compileIntegrationTestJava (0:01.013)
                                                                              ▇▇▇  2% :checkstyleTest (0:01.682)
                                                                            ▇▇▇▇▇  4% :checkJavadoc (0:02.534)
                                                               ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 13% :sonarqube (0:09.213)
                                                   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 21% :test (0:15.199)
▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 57% :integrationTest (0:40.220)

== BUILD SUCCESSFUL ==

This build could be faster, please consider using the Gradle Daemon: https://docs.gradle.org/2.14.1/userguide/gradle_daemon.html
```

> Note that there are now 35 test cases implemented, and all are listed with the additional integrationTest.

## Logs on the Server

You can double-check the logs in the Sonarqube docker logs and see the creation of reports being received by the server.

```
sonarqube_1        | 2016.08.26 05:30:25 INFO  app[o.s.p.m.Monitor] Process[ce] is up
sonarqube_1        | 2016.08.26 05:32:17 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Execute task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFVZyUZjXA3GQ67FPK
sonarqube_1        | 2016.08.26 05:32:20 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Executed task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFVZyUZjXA3GQ67FPK | time=2965ms
sonarqube_1        | 2016.08.26 05:33:38 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Execute task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFVte4ZjXA3GQ67FPL
sonarqube_1        | 2016.08.26 05:33:40 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Executed task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFVte4ZjXA3GQ67FPL | time=1269ms
sonarqube_1        | 2016.08.26 05:48:15 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Execute task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFZDNIZjXA3GQ67FPM
sonarqube_1        | 2016.08.26 05:48:16 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Executed task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFZDNIZjXA3GQ67FPM | time=1219ms
sonarqube_1        | 2016.08.26 05:51:20 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Execute task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFZwxVZjXA3GQ67FPN
sonarqube_1        | 2016.08.26 05:51:21 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Executed task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFZwxVZjXA3GQ67FPN | time=1373ms
sonarqube_1        | 2016.08.26 05:56:58 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Execute task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFbDOdZjXA3GQ67FPO
sonarqube_1        | 2016.08.26 05:56:59 INFO  ce[o.s.s.c.t.CeWorkerCallableImpl] Executed task | project=com.supercash.platform:super--maker | type=REPORT | id=AVbFbDOdZjXA3GQ67FPO | time=1293ms
```

## Sending Reports to remote Sonarqube

You can just use the credentials to the same Sonarqube server. Granted you have all the credentials, you can just do the following:

```
SONARQUBE_JDBC_URL="jdbc:mysql://sonarqube.tools.d1matrix.com:3306/sonarqube?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance" \
SONARQUBE_DB_USER=sonarqube \
SONARQUBE_SERVER_URL=https://sonarqube.tools.d1matrix.com/ \
SONARQUBE_USER=admin \
SONARQUBE_PASSWORD=**** gradle sonarqube
```

# Troubleshooting

Many different probles around Docker or Sonarqube can make you slower. But here are a couple of tips to get you up and running.

## Troubleshooting: Current version is too old

> org.sonar.api.utils.MessageException: Current version is too old. Please upgrade to Long Term Support version firstly

This is described at http://stackoverflow.com/questions/34947417/messageexception-current-version-is-too-old-please-upgrade-to-long-term-suppor/34964463#34964463. If you ever get the error about incompability version, please make sure to:

1. Upgrade all plugins
2. Pull a different version of Sonarqube
3. Remove the docker volumes
4. Build all over again.

Here's the error you might see:

```
$ docker-compose -f sonarqube-compose.yml up
Starting maker_db_1
Starting maker_sonarqube_1
Recreating maker_install_plugins_1
Attaching to maker_db_1, maker_sonarqube_1, maker_install_plugins_1
db_1               | LOG:  database system was shut down at 2016-08-26 04:28:18 UTC
db_1               | LOG:  MultiXact member wraparound protections are now enabled
db_1               | LOG:  database system is ready to accept connections
db_1               | LOG:  autovacuum launcher started
maker_install_plugins_1 exited with code 0
sonarqube_1        | 2016.08.26 04:35:39 INFO  app[o.s.a.AppFileSystem] Cleaning or creating temp directory /opt/sonarqube/temp
sonarqube_1        | 2016.08.26 04:35:39 INFO  app[o.s.p.m.JavaProcessLauncher] Launch process[es]: /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Djava.awt.headless=true -Xmx1G -Xms256m -Xss256k -Djna.nosys=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -Djava.io.tmpdir=/opt/sonarqube/temp -javaagent:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/management-agent.jar -cp ./lib/common/*:./lib/search/* org.sonar.search.SearchServer /opt/sonarqube/temp/sq-process4405923391552124844properties
sonarqube_1        | 2016.08.26 04:35:39 INFO   es[o.s.p.ProcessEntryPoint]  Starting es
sonarqube_1        | 2016.08.26 04:35:39 INFO   es[o.s.s.EsSettings]  Elasticsearch listening on /127.0.0.1:9001
sonarqube_1        | 2016.08.26 04:35:39 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] version[2.3.3], pid[17], build[218bdf1/2016-05-17T15:40:04Z]
sonarqube_1        | 2016.08.26 04:35:39 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] initializing ...
sonarqube_1        | 2016.08.26 04:35:39 INFO   es[o.e.plugins]  [sonar-1472186138961] modules [], plugins [], sites []
sonarqube_1        | 2016.08.26 04:35:39 INFO   es[o.elasticsearch.env]  [sonar-1472186138961] using [1] data paths, mounts [[/opt/sonarqube/data (/dev/sda1)]], net usable_space [53.2gb], net total_space [97.3gb], spins? [possibly], types [ext4]
sonarqube_1        | 2016.08.26 04:35:39 INFO   es[o.elasticsearch.env]  [sonar-1472186138961] heap size [1007.3mb], compressed ordinary object pointers [true]
sonarqube_1        | 2016.08.26 04:35:40 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] initialized
sonarqube_1        | 2016.08.26 04:35:40 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] starting ...
sonarqube_1        | 2016.08.26 04:35:41 INFO   es[o.e.transport]  [sonar-1472186138961] publish_address {127.0.0.1:9001}, bound_addresses {127.0.0.1:9001}
sonarqube_1        | 2016.08.26 04:35:41 INFO   es[o.e.discovery]  [sonar-1472186138961] sonarqube/5V5ntLArTyGP_waAXLw7pw
sonarqube_1        | 2016.08.26 04:35:44 INFO   es[o.e.cluster.service]  [sonar-1472186138961] new_master {sonar-1472186138961}{5V5ntLArTyGP_waAXLw7pw}{127.0.0.1}{127.0.0.1:9001}{rack_id=sonar-1472186138961}, reason: zen-disco-join(elected_as_master, [0] joins received)
sonarqube_1        | 2016.08.26 04:35:44 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] started
sonarqube_1        | 2016.08.26 04:35:44 INFO   es[o.e.gateway]  [sonar-1472186138961] recovered [0] indices into cluster_state
sonarqube_1        | 2016.08.26 04:35:44 INFO  app[o.s.p.m.Monitor] Process[es] is up
sonarqube_1        | 2016.08.26 04:35:44 INFO  app[o.s.p.m.JavaProcessLauncher] Launch process[web]: /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Djruby.management.enabled=false -Djruby.compile.invokedynamic=false -Xmx512m -Xms128m -XX:+HeapDumpOnOutOfMemoryError -Djava.security.egd=file:/dev/./urandom -Djava.io.tmpdir=/opt/sonarqube/temp -javaagent:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/management-agent.jar -cp ./lib/common/*:./lib/server/*:/opt/sonarqube/lib/jdbc/postgresql/postgresql-9.3-1102-jdbc41.jar org.sonar.server.app.WebServer /opt/sonarqube/temp/sq-process8083055985445990683properties
sonarqube_1        | 2016.08.26 04:35:44 INFO  web[o.s.p.ProcessEntryPoint] Starting web
sonarqube_1        | 2016.08.26 04:35:44 INFO  web[o.s.s.a.TomcatContexts] Webapp directory: /opt/sonarqube/web
sonarqube_1        | 2016.08.26 04:35:45 INFO  web[o.a.c.h.Http11NioProtocol] Initializing ProtocolHandler ["http-nio-0.0.0.0-9000"]
sonarqube_1        | 2016.08.26 04:35:45 INFO  web[o.a.t.u.n.NioSelectorPool] Using a shared selector for servlet write/read
sonarqube_1        | 2016.08.26 04:35:45 INFO  web[o.s.s.p.ServerImpl] SonarQube Server / 6.0 / 93442889cd219e78b028c7dcf51a30de74c987fe
sonarqube_1        | 2016.08.26 04:35:46 INFO  web[o.sonar.db.Database] Create JDBC data source for jdbc:postgresql://db:5432/sonar?user=sonar&password=sonar
sonarqube_1        | 2016.08.26 04:35:46 ERROR web[o.a.c.c.C.[.[.[/]] Exception sending context initialized event to listener instance of class org.sonar.server.platform.PlatformServletContextListener
sonarqube_1        | org.sonar.api.utils.MessageException: Current version is too old. Please upgrade to Long Term Support version firstly.
sonarqube_1        | 2016.08.26 04:35:46 ERROR web[o.a.c.c.StandardContext] One or more listeners failed to start. Full details will be found in the appropriate container log file
sonarqube_1        | 2016.08.26 04:35:46 ERROR web[o.a.c.c.StandardContext] Context [] startup failed due to previous errors
sonarqube_1        | 2016.08.26 04:35:46 WARN  web[o.a.c.l.WebappClassLoaderBase] The web application [ROOT] appears to have started a thread named [Timer-0] but has failed to stop it. This is very likely to create a memory leak. Stack trace of thread:
sonarqube_1        |  java.lang.Object.wait(Native Method)
sonarqube_1        |  java.util.TimerThread.mainLoop(Timer.java:552)
sonarqube_1        |  java.util.TimerThread.run(Timer.java:505)
sonarqube_1        | 2016.08.26 04:35:46 INFO  web[o.a.c.h.Http11NioProtocol] Starting ProtocolHandler ["http-nio-0.0.0.0-9000"]
sonarqube_1        | 2016.08.26 04:35:46 INFO  web[o.s.s.a.TomcatAccessLog] Web server is started
sonarqube_1        | 2016.08.26 04:35:46 INFO  web[o.s.s.a.EmbeddedTomcat] HTTP connector enabled on port 9000
sonarqube_1        | 2016.08.26 04:35:46 WARN  web[o.s.p.ProcessEntryPoint] Fail to start web
sonarqube_1        | java.lang.IllegalStateException: Webapp did not start
sonarqube_1        | 	at org.sonar.server.app.EmbeddedTomcat.isUp(EmbeddedTomcat.java:84) ~[sonar-server-6.0.jar:na]
sonarqube_1        | 	at org.sonar.server.app.WebServer.isUp(WebServer.java:47) [sonar-server-6.0.jar:na]
sonarqube_1        | 	at org.sonar.process.ProcessEntryPoint.launch(ProcessEntryPoint.java:105) ~[sonar-process-6.0.jar:na]
sonarqube_1        | 	at org.sonar.server.app.WebServer.main(WebServer.java:68) [sonar-server-6.0.jar:na]
sonarqube_1        | 2016.08.26 04:35:46 INFO  web[o.a.c.h.Http11NioProtocol] Pausing ProtocolHandler ["http-nio-0.0.0.0-9000"]
sonarqube_1        | 2016.08.26 04:35:47 INFO  web[o.a.c.h.Http11NioProtocol] Stopping ProtocolHandler ["http-nio-0.0.0.0-9000"]
sonarqube_1        | 2016.08.26 04:35:48 INFO  web[o.a.c.h.Http11NioProtocol] Destroying ProtocolHandler ["http-nio-0.0.0.0-9000"]
sonarqube_1        | 2016.08.26 04:35:48 INFO  web[o.s.s.a.TomcatAccessLog] Web server is stopped
sonarqube_1        | 2016.08.26 04:35:48 INFO  app[o.s.p.m.Monitor] Process[es] is stopping
sonarqube_1        | 2016.08.26 04:35:48 INFO   es[o.s.p.StopWatcher]  Stopping process
sonarqube_1        | 2016.08.26 04:35:48 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] stopping ...
sonarqube_1        | 2016.08.26 04:35:48 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] stopped
sonarqube_1        | 2016.08.26 04:35:48 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] closing ...
sonarqube_1        | 2016.08.26 04:35:48 INFO   es[o.elasticsearch.node]  [sonar-1472186138961] closed
sonarqube_1        | 2016.08.26 04:35:48 INFO  app[o.s.p.m.Monitor] Process[es] is stopped
maker_sonarqube_1 exited with code 0
 ^CGracefully stopping... (press Ctrl+C again to force)
Stopping maker_db_1 ... done
```

## Troubleshooting: Missing blame information for the following files

> Sonarqube: Missing blame information for the following files

This error occurs because you haven't added them to revision control yet. That is, the files listed have not been indexed by git. Use `git add`, `git commit`, etc.

http://stackoverflow.com/questions/37432290/sonarqube-missing-blame-information-for-the-following-files

```java
Invalid character encountered in file /home/mdesales/dev/github/supercash/platform/maker/src/main/docker/lib/jce_policy-8.zip at line 2 for encoding UTF-8. Please fix file content or configure the encoding to be used using property 'sonar.sourceEncoding'.
Class not found: org.apache.http.annotation.NotThreadSafe
Class not found: org.apache.http.annotation.Immutable
Class not found: org.apache.http.annotation.NotThreadSafe
Class not found: org.apache.http.annotation.ThreadSafe
Missing blame information for the following files:
  * /home/mdesales/dev/github/supercash/platform/maker/src/integrationTest/java/cash.super.platform/GithubWebhookControllerFullIntegrationTest.java
  * /home/mdesales/dev/github/supercash/platform/maker/src/main/docker/lib/jce_policy-8.zip
  * /home/mdesales/dev/github/supercash/platform/maker/src/integrationTest/java/cash.super.platform/GithubWebhookControllerAbstractTest.java
  * /home/mdesales/dev/github/supercash/platform/maker/src/main/resources/certs/server.jks
This may lead to missing/broken features in SonarQube

BUILD SUCCESSFUL
```

## Troubleshooting: Docker Volumes Cleanup

If you need to clean up the docker volumes, use the following:

1. List the volumes

```
$ docker volume ls
DRIVER              VOLUME NAME
local               04d8f9377dfe5247c912a99cd4ad6003d0dbae418dad67338d2c75158ccd4c59
local               05fdc59bd6a4e40b7317a2a7d1cbc3283e38553c3a9ee34f7c792bc0d748fa27
local               0659ed50ef59241b0ef2a9c48715dd09c712f5a11b7e5060ae988d74716f2559
local               marcello
local               maker_postgresql6
local               maker_postgresql6_data
local               maker_sonarqube6_bundled-plugins
local               maker_sonarqube6_conf
local               maker_sonarqube6_data
local               maker_sonarqube6_extensions
```

2. Stop/Remove the docker services running and using the volumes

```
$ docker-compose -f sonarqube-compose.yml rm
Going to remove maker_sonarqube_1, maker_install_plugins_1, maker_db_1
Are you sure? [yN] y
```

3. Completely remove the volumes

```
$ docker volume rm maker_postgresql maker_postgresql_data maker_sonarqube_bundled-plugins maker_sonarqube_conf maker_sonarqube_data maker_sonarqube_extensions
maker_postgresql6
maker_postgresql6_data
maker_sonarqube6_bundled-plugins
maker_sonarqube6_conf
maker_sonarqube6_data
maker_sonarqube6_extensions
```
