FROM mcr.microsoft.com/dotnet/runtime:9.0

WORKDIR /app

COPY . .

EXPOSE 18080

CMD ["dotnet", "Profinity.dll"]
