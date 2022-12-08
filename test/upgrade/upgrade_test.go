package upgrade

import (
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExampleUpgrade_startup(t *testing.T) {
	t.Run("for_each", func(t *testing.T) {
		upgradeTest(t, true)
	})
	t.Run("count", func(t *testing.T) {
		upgradeTest(t, false)
	})
}

func upgradeTest(t *testing.T, useForEach bool) {
	currentRoot, err := test_helper.GetCurrentModuleRootPath()
	if err != nil {
		t.FailNow()
	}
	currentMajorVersion, err := test_helper.GetCurrentMajorVersionFromEnv()
	if err != nil {
		t.FailNow()
	}
	vars := map[string]interface{}{
		"use_for_each": useForEach,
	}
	test_helper.ModuleUpgradeTest(t, "Azure", "terraform-azurerm-network", "examples/startup", currentRoot, terraform.Options{
		Upgrade: true,
		Vars:    vars,
	}, currentMajorVersion)
}
