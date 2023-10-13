package routes

import (
	"bytes"
	"encoding/json"
	"net/http/httptest"
	"os"
	"testing"

	"github.com/gofiber/fiber/v2"
	"github.com/stretchr/testify/assert"
)

func TestPublicRoutes(t *testing.T) {
	//if err := godotenv.Load("../../.env"); err != nil {
	//	panic(err)
	//}
	// Define a structure for specifying input and output data of a single test case.
	tests := []struct {
		description   string
		route         string // input route
		method        string // input method
		tokenString   string // input token
		body          map[string]interface{}
		expectedError bool
		expectedCode  int
	}{
		{
			description: "login test",
			route:       "/api/v1/login/new",
			method:      "POST",
			tokenString: "",
			body: map[string]interface{}{
				"email":    os.Getenv("TEST_EMAIL"),
				"password": os.Getenv("TEST_PASSWORD"),
			},
			expectedError: false,
			expectedCode:  200,
		},
	}
	// Define Fiber app.
	app := fiber.New()

	// Define routes.
	PublicRoutes(app)

	// Iterate through test single test cases
	for _, test := range tests {
		// Create a new http request with the route from the test case.
		b, err := json.Marshal(test.body)
		req := httptest.NewRequest(test.method, test.route, bytes.NewReader(b))
		req.Header.Set("Content-Type", "application/json")

		// Perform the request plain with the app.
		resp, err := app.Test(req, -1) // the -1 disables request latency
		// Verify, that no error occurred, that is not expected
		assert.Equalf(t, test.expectedError, err != nil, test.description)
		// As expected errors lead to broken responses,
		// the next test case needs to be processed.
		if test.expectedError {
			continue
		}

		// Verify, if the status code is as expected.
		assert.Equalf(t, test.expectedCode, resp.StatusCode, test.description)
	}
}
