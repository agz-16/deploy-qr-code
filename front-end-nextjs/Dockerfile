# Frontend Dockerfile
#uses Node.js 24 alpine as the base image
FROM node:24-alpine

#creates and cds into the app directory
WORKDIR /app

# copies package files
# npm install only re-runs when dependencies change, not on every code change
COPY package*.json .

#installs all the depencies
RUN npm install

#copies rest of the files
COPY . .

# compiles Next.js into production files during build and bake it into the image
RUN npm run build

# When the container starts, launch the Next.js server
CMD ["npm", "start"]