package configs

import (
	"context"
	"github.com/aws/aws-sdk-go-v2/service/costexplorer"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"os"
	"strings"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

type AWSConfig struct {
	AccessKey string
	SecretKey string
	Region    string
}

func GetAWSConfig() AWSConfig {
	return AWSConfig{
		AccessKey: os.Getenv("AWS_ACCESS_KEY"),
		SecretKey: os.Getenv("AWS_SECRET_KEY"),
		Region:    os.Getenv("AWS_REGION"),
	}
}

func GetS3Client() *s3.Client {
	cfg, err := config.LoadDefaultConfig(context.TODO(),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(GetAWSConfig().AccessKey, GetAWSConfig().SecretKey, "")),
		config.WithRegion(GetAWSConfig().Region),
	)
	if err != nil {
		return nil
	}

	return s3.NewFromConfig(cfg)
}

func GetCostExplorerClient(iamKey []string) *costexplorer.Client {
	cfg, err := config.LoadDefaultConfig(context.TODO(),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(strings.ReplaceAll(iamKey[0], "\n", ""), strings.ReplaceAll(iamKey[1], "\n", ""), "")),
		config.WithRegion(GetAWSConfig().Region),
	)
	if err != nil {
		return nil
	}
	return costexplorer.NewFromConfig(cfg)
}

func GetDynamoDBClient() *dynamodb.Client {
	cfg, err := config.LoadDefaultConfig(context.TODO(),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(GetAWSConfig().AccessKey, GetAWSConfig().SecretKey, "")),
		config.WithRegion(GetAWSConfig().Region),
	)
	if err != nil {
		return nil
	}
	return dynamodb.NewFromConfig(cfg)
}
