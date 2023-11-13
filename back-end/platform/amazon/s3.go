package amazon

import (
	"context"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"io"
	"os"
	"strings"
)

func S3UploadObject(file *os.File) (string, error) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		return "", err
	}
	svc := s3.NewFromConfig(cfg)
	_, err = svc.PutObject(context.TODO(), &s3.PutObjectInput{
		Bucket: aws.String(os.Getenv("BUCKETNAME")),
		Key:    aws.String(file.Name()),
		Body:   file,
	})
	if err != nil {
		return "", err
	}
	return "success", nil
}

func S3GetObject(objectName string) ([]string, error) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		return nil, err
	}
	svc := s3.NewFromConfig(cfg)
	resp, err := svc.GetObject(context.TODO(), &s3.GetObjectInput{
		Bucket: aws.String(os.Getenv("BUCKETNAME")),
		Key:    aws.String(objectName),
	})
	buf := new(strings.Builder)
	_, err = io.Copy(buf, resp.Body)
	defer resp.Body.Close()
	return strings.Split(buf.String(), ","), err
}
