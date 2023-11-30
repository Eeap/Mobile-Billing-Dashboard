package cache

import (
	"github.com/create-go-app/fiber-go-template/pkg/utils"

	"github.com/redis/go-redis/v9"
)

// RedisConnection func for connect to Redis server.
func RedisConnection() (*redis.Client, error) {
	// Build Redis connection URL.
	redisConnURL, err := utils.ConnectionURLBuilder("redis")
	if err != nil {
		return nil, err
	}

	// Set Redis options.
	options := &redis.Options{
		Addr: redisConnURL,
	}

	return redis.NewClient(options), nil
}
