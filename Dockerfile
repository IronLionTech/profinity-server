FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY . .
EXPOSE 18080
ENTRYPOINT ["dotnet", "Profinity.dll"]
