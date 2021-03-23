const express = require('express');
const app = express();

const PORT  = process.env.PORT || 9090;

const winston = require('winston');
const logger = winston.createLogger({
    level: 'info',
    format: winston.format.json(),
    defaultMeta: { service: 'devops' },
    transports: [
      new winston.transports.File({ filename: 'error.log', level: 'error' }),
    ],
  });

app.get('/', function(request, response){

    logger.log({
        level: 'info',
        message: 'This will not be saved !'
      });
    
    logger.log({
       level: 'error',
       message: 'Hello distributed log files!'
      });
      

    return response.status(200).json({
        hello: 'world'
    });
});

app.listen(PORT, () => {
    console.log(`serveur listening on port ${PORT}`)
});
