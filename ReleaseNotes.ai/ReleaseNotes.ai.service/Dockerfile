FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["ReleaseNotes.ai.service/ReleaseNotes.ai.service.csproj", "ReleaseNotes.ai.service/"]
RUN dotnet restore "ReleaseNotes.ai.service/ReleaseNotes.ai.service.csproj"
COPY . .
WORKDIR "/src/ReleaseNotes.ai.service"
RUN dotnet build "ReleaseNotes.ai.service.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "ReleaseNotes.ai.service.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS=http://0.0.0.0:8080
ENTRYPOINT ["dotnet", "ReleaseNotes.ai.service.dll"]
