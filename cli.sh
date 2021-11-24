#!/bin/zsh

###########################################################################################
###########################################################################################
#### This script automates the setting of the appropriate JDK when running Upwave      ####
#### tests from the command line for those who use sdkman to manage sdks on their      ####
#### local machine.                                                                    ####
###########################################################################################
#### USAGE:                                                                            ####
#### 1. Save this script to somewhere on your path. I put mine in ~/bin/ though you    ####
####    may need to add that to your path                                              ####
###########################################################################################
#### 2. Set the values of JDK8 and JDK11 to the correct sdkman  versions.              ####
####    For example:                                                                   ####
####      $ sdk ls java                                                                ####
####      .....                                                                        ####
####      Corretto      |     | 17.0.1.12.1  | amzn    |            | 17.0.1.12.1-amzn ####
####                    |     | 17.0.0.35.2  | amzn    |            | 17.0.0.35.2-amzn ####
####                    |     | 16.0.2.7.1   | amzn    |            | 16.0.2.7.1-amzn  ####
####                    |     | 11.0.13.8.1  | amzn    |            | 11.0.13.8.1-amzn ####
####                    | >>> | 11.0.12.7.2  | amzn    | installed  | 11.0.12.7.2-amzn ####
####                    |     | 8.312.07.1   | amzn    |            | 8.312.07.1-amzn  ####
####                    |     | 8.302.08.1   | amzn    | installed  | 8.302.08.1-amzn  ####
####                    |     | 8.292.10.1   | amzn    | local only | 8.292.10.1-amzn  ####
####     .....                                                                         ####
####    So I set JDK8 to 8.302.08.1-amzn and JDK11 to 11.0.12.7.2-amzn as below.       ####
#### 3. Run the cli.sh script from your projects without the ./                        ####
####    If you normally run:                                                           ####
####      $./cli.sh test                                                               ####
####    You should run:                                                                ####
####      $cli.sh test                                                                 ####
####    This will set the jdk appropriately before running tests                       ####
#### 4. If this script doesn't contain the project where you want to run cli.sh, add   ####
####    it. To add my-project add the line my_project="${JDK8}" or my_project=${JDK11} ####
###########################################################################################
###########################################################################################
JDK8="8.302.08.1-amzn"
JDK11="11.0.12.7.2-amzn"
survata_jobs="${JDK8}"
athena_agent="${JDK11}"
survata_surveywall_api="${JDK8}"
partner_pipeline="${JDK11}"
digital_element="${JDK8}"
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"


proj=`basename $PWD | sed s/\-/_/`
JDK="${(P)proj}"

[[ -z $JDK ]] && echo "WARNING: Unknown project $proj. Consider updating your project/jdk settings" || sdk use java $JDK

echo "Running cli.sh $@ with Java version..."
java -version

./cli.sh $@
