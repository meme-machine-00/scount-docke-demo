FROM node:22-alpine

ENV BLUEBIRD_WARNINGS=0 \
    NODE_ENV=production \
    NODE_NO_WARNINGS=1 \
    NPM_CONFIG_LOGLEVEL=warn \
    SUPPRESS_NO_CONFIG_WARNING=true

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package.json package-lock.json* ./

# Install production dependencies
RUN npm i --include=prod

# Copy the rest of the application code
COPY . .

# Ensure all files are owned by the node user
RUN chown -R node:node /app

# Switch to the non-root node user
USER node

EXPOSE 3000

CMD ["node", "app.js"]