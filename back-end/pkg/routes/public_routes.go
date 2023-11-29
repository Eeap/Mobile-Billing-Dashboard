package routes

import (
	"github.com/gofiber/fiber/v2"
	"main/app/controllers"
)

// PublicRoutes func for describe group of public routes.
func PublicRoutes(a *fiber.App) {
	// Create routes group.
	route := a.Group("/api/v1")
	// Routes for POST method:
	route.Post("/login", controllers.UserSignIn)
	route.Get("/aws-resource", controllers.GetResourcesCost)
	route.Get("/alert-messages", controllers.GetAlertMessages)
	route.Post("/user-key", controllers.UserKeySet)
	route.Post("/sign-up", controllers.UserSignUp)
	route.Post("/alert-setting", controllers.AlertSetting)
}
