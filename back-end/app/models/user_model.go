package models

// User struct to describe User object.
type User struct {
	Name         string `json:"name"`
	Email        string `json:"email" validate:"required,email,lte=255"`
	Password     string `json:"password" validate:"required,lte=255"`
	RefreshToken string `json:"refreshToken"`
}

type UserKey struct {
	Email     string `json:"email"`
	AccessKey string `json:"accessKey"`
	SecretKey string `json:"secretKey"`
}
