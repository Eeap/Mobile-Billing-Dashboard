package services

import (
	"fmt"
	"github.com/aws/aws-sdk-go-v2/service/costexplorer/types"
	dynamoType "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"log"
	"main/app/models"
	"main/platform/amazon"
	"math"
	"strconv"
	"time"
)

func GetCostUsageByResource(costIn *models.CostExplorer) ([]models.CostResource, error) {
	// 구조체의 리스트를 반환하는 로직 필요
	iamKey, err := S3GetKey(costIn.Email)
	if err != nil {
		log.Println(err)
		return nil, err
	}
	costData := amazon.GetCostUsage(costIn.Region, costIn.Day, iamKey)
	costResources, err := makeCostResource(costData)
	if err != nil {
		return []models.CostResource{}, err
	}
	err = compareCostWithTarget(costResources, costIn.Email)
	if err != nil {
		log.Println(err)
		return nil, err
	}
	return costResources, nil
}

func makeCostResource(costData []types.ResultByTime) ([]models.CostResource, error) {
	costResources := []models.CostResource{}
	for _, oneDayVal := range costData {
		timeStart := oneDayVal.TimePeriod.Start
		timeEnd := oneDayVal.TimePeriod.End
		for _, resourceData := range oneDayVal.Groups {
			resourceName := resourceData.Keys[0]
			resourceAmount := resourceData.Metrics["BlendedCost"].Amount
			costResources = append(costResources, models.CostResource{
				Key:       resourceName,
				Amount:    *resourceAmount,
				TimeStart: *timeStart,
				TimeEnd:   *timeEnd,
			})
		}
	}
	return costResources, nil
}

func compareCostWithTarget(costData []models.CostResource, email string) error {
	// email 토대로 dynamoDB에 데이터를 불러오는 로직 필요
	item, err := amazon.GetItem(&models.SignIn{Email: email})
	if err != nil {
		log.Println(err)
		return err
	}
	value, err := strconv.ParseFloat(item["targetCost"].(*dynamoType.AttributeValueMemberN).Value, 64)
	if err != nil {
		log.Println(err)
		return err
	} else if value == 0 {
		return nil
	}
	timeNow := time.Now().Format("2006-01-02 15:04:05")
	timeEnd := item["timeEnd"].(*dynamoType.AttributeValueMemberS).Value
	if timeNow > timeEnd {
		return nil
	}
	total := 0.0
	for _, val := range costData {
		// 10원 미만 가격은 무시
		if val.Amount < "0.01" {
			continue
		}
		amount, err := strconv.ParseFloat(val.Amount, 64)
		if err != nil {
			return err
		}
		total += amount
	}
	// 목표비용과 비교하는 로직 필요
	percent := math.Round(total / value * 100)
	var text string
	if percent < 1 {
		text = fmt.Sprintf("리소스 총 사용 요금이 1%s 미만입니다.", "%")
	} else {
		text = fmt.Sprintf("리소스 총 사용 요금이 %.0f%s를 초과하였습니다.", math.Round(percent), "%")
	}
	err = SetAlertMessage(&models.AlertMessage{
		Time:    time.Now().Format("2006-01-02 15:04:05"),
		Message: text,
		Creator: email,
	}, email)
	if err != nil {
		log.Println(err)
		return err
	}
	return nil
}
