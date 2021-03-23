FROM node:15-alpine

# Create app directory
# Equivalent de : cd /usr/src/app
WORKDIR /usr/src/app

# Install dependencies #package* car il prend tout entr package et .json
COPY package*.json ./ 
RUN npm install

# Copy app source into the container
COPY . .

#ici on expose le port et on fait executer node app.js
EXPOSE 3000
CMD [ "node", "app.js" ]
