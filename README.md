# .Net Core Sonar Scanner on Docker Container

Sonar Scanner MsBuild Dockerfile for .Net Core Projects

[![Docker Pulls](https://img.shields.io/docker/pulls/kneip/dotnet-sonar.svg)](https://hub.docker.com/r/kneip/dotnet-sonar/)
![.github/workflows/docker.yml](https://github.com/KNEIP/dotnet-sonar/workflows/.github/workflows/docker.yml/badge.svg)

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
docker start --name dotnet-sonar -v $(pwd):/project kneip/dotnet-sonar

docker exec --name dotnet-sonar dotnet sonarscanner begin /k:<project-key>
docker exec --name dotnet-sonar dotnet build
docker exec --name dotnet-sonar dotnet sonarscanner end

docker stop --name dotnet-sonar
docker rm --name dotnet-sonar
```
