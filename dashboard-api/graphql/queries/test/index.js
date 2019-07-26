const redisClient = require('mobilize-dashboard-api-utils/redis');

exports.handler = async () => {
    const redisCount = await redisClient.getAsync('count');
    const count = (typeof redisCount === 'undefined') ? 0 : parseInt(redisCount, 10);
    const newCount = count + 1;
    await redisClient.setAsync('count', newCount);
    return newCount;
}