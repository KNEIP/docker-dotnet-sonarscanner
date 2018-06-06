# .Net Core Sonar Scanner on Docker Container

Sonar Scanner MsBuild Dockerfile for .Net Core Projects

[![Docker Pulls](https://img.shields.io/docker/pulls/francoiskarman/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/francoiskarman/dotnetcore-sonarscanner/)
[![Docker Automated build](https://img.shields.io/docker/automated/francoiskarman/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/francoiskarman/dotnetcore-sonarscanner/)
[![Docker Build Status](https://img.shields.io/docker/build/francoiskarman/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/francoiskarman/dotnetcore-sonarscanner/)

## This Image Using

|                | Name          | Version       |
| -------------- |:-------------:| -------------:|
| OS             | Debian        |   Stretch (9) |
| Java           | OpenJDK       |  8 Update 171 |
| .NET Framework | Mono          |    5.12.0.226 |
| .NET SDK       | .NET Core SDK | 2.1 (2.1.300) |
| Sonar Scanner  | CLI           |    3.2.0.1227 |
| Sonar Scanner  | MS Build      |    4.3.0.1333 |

Please check [Releases Page](https://github.com/burakince/docker-dotnet-sonarscanner/releases) for details.

## Latest Versions

[Latest Debian](https://www.debian.org/releases/stable/)
[Latest OpenJDK](https://hub.docker.com/r/library/openjdk/tags/)
[Latest Mono](https://www.mono-project.com/download/stable/#download-lin-debian)
[Latest .Net SDK](https://www.microsoft.com/net/download/all)
[Latest Sonar Scanner](https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner+for+MSBuild)

## Using Example

First of all you need a sonarqube server. If you haven't one, run this code;

```
docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube
```

And then you need .Net Core project. If you haven't one, run this codes;

```
mkdir ConsoleApplication1
cd ConsoleApplication1

dotnet new console
dotnet new sln
dotnet sln ConsoleApplication1.sln add ConsoleApplication1.csproj
```

Take login token from sonarqube server, change working directory to project directory and run this code;

```
docker start --name dotnetcore-scanner -v $(pwd):/project francoiskarman/dotnetcore-sonarscanner

docker exec --name dotnetcore-scanner dotnet /opt/sonar-scanner-msbuild/SonarScanner.MSBuild.dll begin /k:<project-key>
docker exec --name dotnetcore-scanner dotnet build
docker exec --name dotnetcore-scanner dotnet /opt/sonar-scanner-msbuild/SonarScanner.MSBuild.dll end

docker stop --name dotnetcore-scanner
docker rm --name dotnetcore-scanner
```

Note: If you have sonarqube as docker container, you must inspect sonarqube's bridge network IP address and use it in HOST variable.

```
docker network inspect bridge
```
