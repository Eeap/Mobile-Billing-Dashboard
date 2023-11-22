package amazon

import (
	"context"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"log"
	"main/app/models"
	"main/pkg/configs"
	"os"
)

func PutItem(user *models.SignIn) error {
	svc := configs.GetDynamoDBClient()
	_, err := svc.PutItem(context.TODO(), &dynamodb.PutItemInput{
		TableName: aws.String(os.Getenv("AWS_TABLE_NAME")),
		Item: map[string]types.AttributeValue{
			"email":    &types.AttributeValueMemberS{Value: user.Email},    // 이메일
			"password": &types.AttributeValueMemberS{Value: user.Password}, // 비밀번호
		},
	})
	if err != nil {
		log.Println(err)
		return err
	}
	return nil
}
func GetItem(user *models.SignIn) (map[string]types.AttributeValue, error) {
	svc := configs.GetDynamoDBClient()
	resp, err := svc.GetItem(context.TODO(), &dynamodb.GetItemInput{
		TableName: aws.String(os.Getenv("AWS_TABLE_NAME")),
		Key: map[string]types.AttributeValue{
			"email": &types.AttributeValueMemberS{Value: user.Email}, // 이메일
		},
	})
	value := resp.Item["email"]
	if value == nil {
		return nil, err
	}
	if err != nil {
		log.Println(err)
		return nil, err
	}
	return resp.Item, nil
}
