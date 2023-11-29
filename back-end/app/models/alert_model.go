package models

type AlertMessage struct {
	Time    string `json:"time" validate:"required"`
	Message string `json:"message" validate:"required"`
	Creator string `json:"creator" validate:"required"`
}

type AlertSetting struct {
	Email      string `json:"email" validate:"required"`
	TimeEnd    string `json:"timeEnd" validate:"required"`
	TargetCost int    `json:"targetCost" validate:"required"`
}
