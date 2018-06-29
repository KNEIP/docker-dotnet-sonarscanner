# .Net Core Sonar Scanner on Docker Container

Sonar Scanner MsBuild Dockerfile for .Net Core Projects

[![Docker Pulls](https://img.shields.io/docker/pulls/francoiskarman/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/francoiskarman/dotnetcore-sonarscanner/)
[![Docker Automated build](https://img.shields.io/docker/automated/francoiskarman/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/francoiskarman/dotnetcore-sonarscanner/)
[![Docker Build Status](https://img.shields.io/docker/build/francoiskarman/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/francoiskarman/dotnetcore-sonarscanner/)

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

docker exec --name dotnetcore-scanner dotnet sonarscanner begin /k:<project-key>
docker exec --name dotnetcore-scanner dotnet build
docker exec --name dotnetcore-scanner dotnet sonarscanner end

docker stop --name dotnetcore-scanner
docker rm --name dotnetcore-scanner
```
