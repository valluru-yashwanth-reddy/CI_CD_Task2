# Use official Node image as the build environment
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy entire source code
COPY . .

# Build the React app for production
RUN npm run build

# Use a lightweight web server to serve built app
FROM nginx:alpine

# Copy built app from build stage to nginx html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
