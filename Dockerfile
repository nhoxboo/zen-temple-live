FROM node:20-alpine
WORKDIR /app
COPY live/package*.json ./live/
RUN cd live && npm install --omit=dev
COPY . .
WORKDIR /app/live
EXPOSE 3300
ENV PORT=3300
ENV HOST=0.0.0.0
CMD ["node", "server.mjs"]
