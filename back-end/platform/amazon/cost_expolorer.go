package amazon

import (
	"context"
	"log"
	"main/pkg/configs"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/costexplorer"
	"github.com/aws/aws-sdk-go-v2/service/costexplorer/types"
)

func GetCostUsage(region string, day int, iamKey []string) []types.ResultByTime {
	svc := configs.GetCostExplorerClient(iamKey)
	resp, err := svc.GetCostAndUsage(context.TODO(), &costexplorer.GetCostAndUsageInput{
		Filter:      getFilter(region),
		Granularity: "DAILY",
		TimePeriod:  getPeriod(day),
		Metrics:     []string{"BlendedCost"},
		GroupBy: []types.GroupDefinition{
			{
				Type: "DIMENSION",
				Key:  aws.String("SERVICE"),
			},
		},
	})
	if err != nil {
		log.Println(err)
		return nil
	}
	return resp.ResultsByTime
}

func getPeriod(day int) *types.DateInterval {
	now := time.Now()
	then := now.AddDate(0, 0, -day)
	dateRange := &types.DateInterval{
		End:   aws.String(now.Format("2006-01-02")),
		Start: aws.String(then.Format("2006-01-02")),
	}
	return dateRange
}

func getFilter(region string) *types.Expression {
	expression := &types.Expression{
		Dimensions: &types.DimensionValues{
			Key:    "REGION",
			Values: []string{region},
		},
	}
	return expression
}
