package controllers

import (
	"github.com/gofiber/fiber/v2"
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

// @Router /v1/user/key [post]
func UserKeySave(c *fiber.Ctx) error {
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"error": false,
		"msg":   "userKeySave success",
	})
}

// @Router /v1/user/key/get [get]
func UserKeyGet(c *fiber.Ctx) error {
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"error": false,
	})
}
