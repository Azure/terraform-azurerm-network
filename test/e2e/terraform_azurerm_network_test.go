package e2e

import (
	"regexp"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestStartup(t *testing.T) {
	t.Run("for_each", func(t *testing.T) {
		testStartup(t, true)
	})
	t.Run("count", func(t *testing.T) {
		testStartup(t, false)
	})
}

func testStartup(t *testing.T, useForEach bool) {
	vars := map[string]interface{}{
		"use_for_each": useForEach,
	}
	test_helper.RunE2ETest(t, "../../", "examples/startup", terraform.Options{
		Upgrade: true,
		Vars:    vars,
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		vnetId, ok := output["test_vnet_id"].(string)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Network/virtualNetworks/.+"), vnetId)
	})
}
