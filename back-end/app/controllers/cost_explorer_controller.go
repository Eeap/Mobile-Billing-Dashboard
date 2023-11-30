package controllers

import (
	"github.com/gofiber/fiber/v2"
	"main/app/models"
	"main/app/services"
)

// @Router /v1/aws-resource [get]
func GetResourcesCost(c *fiber.Ctx) error {
	costIn := &models.CostExplorer{}
	if err := c.QueryParser(costIn); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": true,
			"msg":   err,
		})
	}
	resData, _ := services.GetCostUsageByResource(costIn)
	//resData := []models.CostResource{
	//	{
	//		Key:       "Amazon Simple Storage Service",
	//		Amount:    "0.8",
	//		TimeEnd:   "2023-10-29",
	//		TimeStart: "2023-10-30",
	//	},
	//	{
	//		Key:       "Amazon Simple Storage Service",
	//		Amount:    "1.0",
	//		TimeEnd:   "2023-10-30",
	//		TimeStart: "2023-10-31",
	//	},
	//	{
	//		Key:       "Amazon Simple Storage Service",
	//		Amount:    "1.8",
	//		TimeEnd:   "2023-10-31",
	//		TimeStart: "2023-11-01",
	//	},
	//	{
	//		Key:       "Amazon Simple Storage Service",
	//		Amount:    "2.8",
	//		TimeEnd:   "2023-11-01",
	//		TimeStart: "2023-11-02",
	//	},
	//	{
	//		Key:       "Amazon Relational Database Service",
	//		Amount:    "8.0",
	//		TimeEnd:   "2023-10-29",
	//		TimeStart: "2023-10-30",
	//	},
	//	{
	//		Key:       "Amazon Relational Database Service",
	//		Amount:    "12.592",
	//		TimeEnd:   "2023-10-30",
	//		TimeStart: "2023-10-31",
	//	},
	//	{
	//		Key:       "Amazon Relational Database Service",
	//		Amount:    "5.602",
	//		TimeEnd:   "2023-10-31",
	//		TimeStart: "2023-11-01",
	//	},
	//	{
	//		Key:       "Amazon Relational Database Service",
	//		Amount:    "10.235",
	//		TimeEnd:   "2023-11-01",
	//		TimeStart: "2023-11-02",
	//	},
	//	{
	//		Key:       "Amazon Virtual Private Cloud",
	//		Amount:    "3.0",
	//		TimeEnd:   "2023-10-29",
	//		TimeStart: "2023-10-30",
	//	},
	//	{
	//		Key:       "Amazon Virtual Private Cloud",
	//		Amount:    "2.592",
	//		TimeEnd:   "2023-10-30",
	//		TimeStart: "2023-10-31",
	//	},
	//	{
	//		Key:       "Amazon Virtual Private Cloud",
	//		Amount:    "5.602",
	//		TimeEnd:   "2023-10-31",
	//		TimeStart: "2023-11-01",
	//	},
	//	{
	//		Key:       "Amazon Virtual Private Cloud",
	//		Amount:    "4.235",
	//		TimeEnd:   "2023-11-01",
	//		TimeStart: "2023-11-02",
	//	},
	//}
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"totalResults": len(resData),
		"resources":    resData,
	})
}
