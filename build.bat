@echo off
echo Building Chemistry Learning Project...
cd /d f:\TEST\CMateData
mvn clean install -DskipTests
echo Build completed successfully!
pause