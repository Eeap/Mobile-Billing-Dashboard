package routes

import (
	"github.com/gofiber/fiber/v2"
	"main/app/controllers"
	"main/pkg/middleware"
)

// PrivateRoutes func for describe group of private routes.
func PrivateRoutes(a *fiber.App) {
	// Create routes group.
	route := a.Group("/api/v1")

	// Routes for POST method:
	route.Post("/logout", middleware.JWTProtected(), controllers.UserSignOut)
}
