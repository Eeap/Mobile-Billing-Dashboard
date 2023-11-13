package services

import (
	"github.com/aws/aws-sdk-go-v2/service/costexplorer/types"
	"main/app/models"
	"main/platform/amazon"
)

func GetCostUsageByResource(costIn *models.CostExplorer) ([]models.CostResource, error) {
	// 구조체의 리스트를 반환하는 로직 필요
	iamKey, err2 := amazon.S3GetObject(costIn.Email)
	if err2 != nil {
		return nil, err2
	}
	costData := amazon.GetCostUsage(costIn.Region, costIn.Day, iamKey)
	costResources, err := makeCostResource(costData)
	if err != nil {
		return []models.CostResource{}, err
	}
	// email 토대로 캐쉬에 데이터를 저장하는 로직 필요
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
