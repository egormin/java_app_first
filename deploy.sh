#!/usr/bin/bash

local_path="/GITs/web/first/out/artifacts/first_war_exploded/"
remote_path="/opt/tomcat8/webapps"
tmp_path="/tmp/temp_depl/"
app_name="first.war"

if [ ! -d "$tmp_path" ]; then
    mkdir $tmp_path
    echo == Directory $tmp_path created
else
    echo == Directory $tmp_path exists... skipped
fi

rm -rf $tmp_path/*
echo == Directory $tmp_path cleaned
cp $local_path*.war $tmp_path
echo == Copying artefact
filename=`ls $tmp_path/`
echo == $filename found
mv $tmp_path$filename $tmp_path$app_name
echo == Artefact renamed. Now is `ls $tmp_path/`
rm -rf $remote_path$app_name
echo == Removed old artifact from $remote_path
cp $tmp_path$app_name $remote_path
/opt/tomcat8/bin/shutdown.sh
sleep 3
/opt/tomcat8/bin/startup.sh
echo == Tomcat restarted