package controllers

import (
	"github.com/gofiber/fiber/v2"
	"main/app/models"
	"main/app/services"
)

// UserSignIn method to auth user and return access and refresh tokens.
// @Router /v1/login/new [post]
func UserSignIn(c *fiber.Ctx) error {
	return c.Status(fiber.StatusOK).JSON(fiber.Map{})
}

// UserSignOut method to de-authorize user and delete refresh token from Redis.
// @Router /v1/logout [post]
func UserSignOut(c *fiber.Ctx) error {
	// Return status 204 no content.
	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{
		"error": false,
		"msg":   "logout success",
	})
}

// @Router /v1/user-key [post]
func UserKeySet(c *fiber.Ctx) error {
	keyIn := &models.UserKey{}
	if err := c.BodyParser(keyIn); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error":   true,
			"message": err,
		})
	}
	msg, err := services.S3UploadKey(keyIn)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error":   true,
			"message": err,
		})
	}
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"error":   false,
		"message": msg,
	})
}
