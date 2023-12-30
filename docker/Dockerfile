FROM node:18

RUN apt-get update && apt-get install git

WORKDIR /usr/app

RUN git clone https://github.com/rhonalchirinos/devops_hapi.git

WORKDIR /usr/app/devops_hapi

RUN npm ci 

CMD ["node", "index.js"]