package amazon

import (
	"context"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"io"
	"log"
	"main/pkg/configs"
	"os"
	"strings"
)

func S3UploadObject(file *os.File) (string, error) {
	svc := configs.GetS3Client()
	_, err := svc.PutObject(context.TODO(), &s3.PutObjectInput{
		Bucket: aws.String(os.Getenv("BUCKETNAME")),
		Key:    aws.String(file.Name()),
		Body:   file,
	})
	if err != nil {
		log.Println(err)
		return "", err
	}
	return "success", nil
}

func S3GetObject(objectName string) ([]string, error) {
	svc := configs.GetS3Client()
	resp, err := svc.GetObject(context.TODO(), &s3.GetObjectInput{
		Bucket: aws.String(os.Getenv("BUCKETNAME")),
		Key:    aws.String(objectName),
	})
	if err != nil {
		log.Println(err)
		return nil, err
	}
	buf := new(strings.Builder)
	_, err = io.Copy(buf, resp.Body)
	if err != nil {
		log.Println(err)
		return nil, err
	}
	defer resp.Body.Close()
	return strings.Split(buf.String(), ","), err
}
