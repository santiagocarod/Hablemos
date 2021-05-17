FROM cirrusci/flutter

# Run flutter doctor
RUN flutter doctor -v

# Copy the app files to the container
COPY . /usr/local/bin/app

# Set the working directory to the app files within the container
WORKDIR /usr/local/bin/app

# Get App Dependencies
RUN flutter pub get

# Build the app for the web
RUN flutter build web

# Document the exposed port
EXPOSE 4040

# Set the server startup script as executable
RUN ["chmod", "+x", "/usr/local/bin/app/server/server.sh"]

# Start the web server
ENTRYPOINT [ "/usr/local/bin/app/server/server.sh" ]