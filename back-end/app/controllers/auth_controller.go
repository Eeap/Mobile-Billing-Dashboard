package controllers

import (
	"github.com/gofiber/fiber/v2"
	"main/app/models"
	"main/app/services"
)

// UserSignIn method to auth user and return access and refresh tokens.
// @Router /v1/login [post]
func UserSignIn(c *fiber.Ctx) error {
	signIn := &models.SignIn{}
	if err := c.BodyParser(signIn); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error":   true,
			"message": err,
		})
	}
	msg, err := services.GetItem(signIn)
	if msg == "password" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error":   true,
			"message": err.Error(),
		})
	}
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error":   true,
			"message": err.Error(),
		})
	}
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"error":    false,
		"messages": "user login success",
	})
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

// @Router /v1/sign-up [post]
func UserSignUp(c *fiber.Ctx) error {
	signIn := &models.SignIn{}
	if err := c.BodyParser(signIn); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error":   true,
			"message": err,
		})
	}
	msg, err := services.PutItem(signIn)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error":   true,
			"message": err,
		})
	}
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"error":    false,
		"messages": msg,
	})
}
