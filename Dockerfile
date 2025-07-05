FROM debian:11-slim

RUN apt-get update && \
    apt-get install -y wget apt-transport-https && \
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-runtime-9.0

WORKDIR /app
COPY . .

CMD ["dotnet", "Profinity.dll"]
