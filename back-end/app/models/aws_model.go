package models

// CostExplorer struct to describe aws costexplorer data.
type CostExplorer struct {
	Email  string `json:"email" validate:"required,email,lte=255"`
	Region string `json:"region" validate:"required,lte=255"`
	Day    int    `json:"day" validate:"required"`
}

// CostResource struct to describe aws response of costexplorer.
type CostResource struct {
	Key       string `json:"key" validate:"required,email,lte=255"`
	Amount    string `json:"amount" validate:"required"`
	TimeEnd   string `json:"timeEnd" validate:"required"`
	TimeStart string `json:"timeStart" validate:"required,lte=255"`
}
