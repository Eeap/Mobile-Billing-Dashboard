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

func TestPrivateRoutes(t *testing.T) {
	//if err := godotenv.Load("../../.env"); err != nil {
	//	panic(err)
	//}
	// Define a structure for specifying input and output data of multi test cases.
	tests := []struct {
		description   string
		route         string // input route
		method        string // input method
		accessToken   string // input token
		refreshToken  string // input token
		body          map[string]interface{}
		expectedError bool
		expectedCode  int
	}{
		{
			description:   "logout test",
			route:         "/api/v1/logout",
			method:        "POST",
			accessToken:   os.Getenv("TEST_ACCESS_TOKEN"),
			refreshToken:  os.Getenv("TEST_REFRESH_TOKEN"),
			body:          map[string]interface{}{},
			expectedError: false,
			expectedCode:  204,
		},
		{
			description:   "refresh test",
			route:         "/api/v1/login/refresh",
			method:        "POST",
			accessToken:   os.Getenv("TEST_ACCESS_TOKEN"),
			refreshToken:  os.Getenv("TEST_REFRESH_TOKEN"),
			body:          map[string]interface{}{},
			expectedError: false,
			expectedCode:  200,
		},
		{
			description:  "user key save test",
			route:        "/api/v1/user/key",
			method:       "POST",
			accessToken:  os.Getenv("TEST_ACCESS_TOKEN"),
			refreshToken: os.Getenv("TEST_REFRESH_TOKEN"),
			body: map[string]interface{}{
				"accessKey": "test",
				"secretKey": "test",
			},
			expectedError: false,
			expectedCode:  200,
		},
		{
			description:   "user key get test",
			route:         "/api/v1/user/key/get",
			method:        "GET",
			accessToken:   os.Getenv("TEST_ACCESS_TOKEN"),
			refreshToken:  os.Getenv("TEST_REFRESH_TOKEN"),
			body:          map[string]interface{}{},
			expectedError: false,
			expectedCode:  200,
		},
	}

	// Define a new Fiber app.
	app := fiber.New()

	// Define routes.
	PrivateRoutes(app)

	// Iterate through test single test cases
	for _, test := range tests {
		// Create a new http request with the route from the test case.
		b, err := json.Marshal(test.body)
		req := httptest.NewRequest(test.method, test.route, bytes.NewReader(b))
		req.Header.Set("Authorization", "Bearer "+test.accessToken)
		req.Header.Set("X-refresh-token", test.refreshToken)
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
