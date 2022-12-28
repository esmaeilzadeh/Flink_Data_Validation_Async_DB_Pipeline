#!/bin/bash
rm target/scala-2.12/job-assembly-1.0.jar
sbt 'set test in assembly := {}' clean assembly
rm docker/usrlib/job-assembly.jar
cp target/scala-2.12/job-assembly-1.0.jar docker/usrlib/job-assembly.jar
