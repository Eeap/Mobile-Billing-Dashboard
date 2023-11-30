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
	"strconv"
)

func PutItem(user *models.SignIn) error {
	svc := configs.GetDynamoDBClient()
	_, err := svc.PutItem(context.TODO(), &dynamodb.PutItemInput{
		TableName: aws.String(os.Getenv("AWS_TABLE_NAME")),
		Item: map[string]types.AttributeValue{
			"email":      &types.AttributeValueMemberS{Value: user.Email},      // 이메일
			"password":   &types.AttributeValueMemberS{Value: user.Password},   // 비밀번호
			"timeEnd":    &types.AttributeValueMemberS{Value: ""},              // 날짜
			"targetCost": &types.AttributeValueMemberN{Value: strconv.Itoa(0)}, // 목표비용
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

func UpdateItem(alertSettings *models.AlertSetting) error {
	svc := configs.GetDynamoDBClient()
	_, err := svc.UpdateItem(context.TODO(), &dynamodb.UpdateItemInput{
		TableName: aws.String(os.Getenv("AWS_TABLE_NAME")),
		Key: map[string]types.AttributeValue{
			"email": &types.AttributeValueMemberS{Value: alertSettings.Email}, // 이메일
		},
		ExpressionAttributeValues: map[string]types.AttributeValue{
			":t": &types.AttributeValueMemberS{Value: alertSettings.TimeEnd},                  // 날짜
			":c": &types.AttributeValueMemberN{Value: strconv.Itoa(alertSettings.TargetCost)}, // 목표비용
		},
		UpdateExpression: aws.String("set timeEnd = :t, targetCost = :c"),
	})
	if err != nil {
		log.Println(err)
		return err
	}
	return nil
}
