@echo off
echo Downloading required JAR files for PhanNgocAnh project (Jakarta EE 9+)...
echo.

cd web\WEB-INF\lib

echo Downloading Jakarta Servlet API...
curl -L -o jakarta.servlet-api-5.0.0.jar "https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/5.0.0/jakarta.servlet-api-5.0.0.jar"

echo Downloading Jakarta JSTL API...
curl -L -o jakarta.servlet.jsp.jstl-api-2.0.0.jar "https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/2.0.0/jakarta.servlet.jsp.jstl-api-2.0.0.jar"

echo Downloading Jakarta JSTL Implementation...
curl -L -o jakarta.servlet.jsp.jstl-2.0.0.jar "https://repo1.maven.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/2.0.0/jakarta.servlet.jsp.jstl-2.0.0.jar"

echo Downloading SQL Server JDBC Driver...
curl -L -o mssql-jdbc-9.4.1.jre8.jar "https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/9.4.1.jre8/mssql-jdbc-9.4.1.jre8.jar"

echo Downloading JSON Processing...
curl -L -o jakarta.json-2.0.1.jar "https://repo1.maven.org/maven2/org/glassfish/jakarta.json/2.0.1/jakarta.json-2.0.1.jar"

echo.
echo Download completed!
echo.
echo IMPORTANT: Please REMOVE any old javax.*.jar files from the lib directory before building.
echo.
echo Files downloaded:
dir *.jar
echo.
echo Please make sure these files are in your classpath when building the project.
pause 