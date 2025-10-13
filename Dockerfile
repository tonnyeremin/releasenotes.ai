# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ReleaseNotes.ai.service/*.csproj ./ReleaseNotes.ai.service/
RUN dotnet restore ./ReleaseNotes.ai.service/ReleaseNotes.ai.service.csproj
COPY ReleaseNotes.ai.service/. ./ReleaseNotes.ai.service/
WORKDIR /src/ReleaseNotes.ai.service
RUN dotnet publish -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080 8081
ENV ASPNETCORE_URLS="http://+:8080;http://+:8081"
ENTRYPOINT ["dotnet", "ReleaseNotes.ai.service.dll"]

