# Use a lightweight base image
FROM debian:11-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget apt-transport-https && \
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-runtime-9.0 && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy everything
COPY . .

# Expose the port Profinity uses
EXPOSE 18080

# Run the app
CMD ["dotnet", "Profinity.dll"]
