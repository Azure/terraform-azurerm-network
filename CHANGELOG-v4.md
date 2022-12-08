# Changelog

## [4.2.0](https://github.com/Azure/terraform-azurerm-network/tree/4.2.0) (2022-12-08)

**Merged pull requests:**

- Add new variable `use_for_each` so we can use `for_each` to create multiple resource instances. [\#84](https://github.com/Azure/terraform-azurerm-network/pull/84) ([lonegunmanb](https://github.com/lonegunmanb))
- Bump tflint plugin version, add new checking rule [\#83](https://github.com/Azure/terraform-azurerm-network/pull/83) ([lonegunmanb](https://github.com/lonegunmanb))
- Upgrade `terraform-module-test-helper` lib so we can get rid of override file to execute version upgrade test [\#82](https://github.com/Azure/terraform-azurerm-network/pull/82) ([lonegunmanb](https://github.com/lonegunmanb))

## [4.1.0](https://github.com/Azure/terraform-azurerm-network/tree/4.1.0) (2022-11-24)

**Merged pull requests:**

- Add support for `delegation` block for `azurerm_subnet resource` [\#81](https://github.com/Azure/terraform-azurerm-network/pull/81) ([lonegunmanb](https://github.com/lonegunmanb))
- reorder variables, outputs and arguments [\#80](https://github.com/Azure/terraform-azurerm-network/pull/80) ([lonegunmanb](https://github.com/lonegunmanb))
- Replace location with local variable [\#78](https://github.com/Azure/terraform-azurerm-network/pull/78) ([jiaweitao001](https://github.com/jiaweitao001))
- Fix CI pipeline by adding missing override file, version upgrade test and correct changelog filename [\#76](https://github.com/Azure/terraform-azurerm-network/pull/76) ([lonegunmanb](https://github.com/lonegunmanb))
- Rewrite output to get rid of legacy index syntax [\#75](https://github.com/Azure/terraform-azurerm-network/pull/75) ([lonegunmanb](https://github.com/lonegunmanb))

## [4.0.1](https://github.com/Azure/terraform-azurerm-network/tree/4.0.1) (2022-11-23)

**Merged pull requests:**

- Removing dependency in example [\#77](https://github.com/Azure/terraform-azurerm-network/pull/77) ([jiaweitao001](https://github.com/jiaweitao001))
- Adding Microsoft SECURITY.MD [\#69](https://github.com/Azure/terraform-azurerm-network/pull/69) ([microsoft-github-policy-service[bot]](https://github.com/apps/microsoft-github-policy-service))

## [4.0.0](https://github.com/Azure/terraform-azurerm-network/tree/4.0.0) (2022-11-22)

**Merged pull requests:**

- Add CI pipeline [\#73](https://github.com/Azure/terraform-azurerm-network/pull/73) ([jiaweitao001](https://github.com/jiaweitao001))
- Add new variable `address_spaces` [\#61](https://github.com/Azure/terraform-azurerm-network/pull/61) ([yupwei68](https://github.com/yupwei68))
- ADD variable to configure service endpoints [\#60](https://github.com/Azure/terraform-azurerm-network/pull/60) ([goatwu1993](https://github.com/goatwu1993))
- adds missing words and fixes consistency [\#55](https://github.com/Azure/terraform-azurerm-network/pull/55) ([ksatirli](https://github.com/ksatirli))
- Add variable `subnet_enforce_private_link_endpoint_network_policies` [\#51](https://github.com/Azure/terraform-azurerm-network/pull/51) ([yupwei68](https://github.com/yupwei68))
- Docker fix [\#49](https://github.com/Azure/terraform-azurerm-network/pull/49) ([yupwei68](https://github.com/yupwei68))
- Integration of Terramodtest 0.8.0 [\#48](https://github.com/Azure/terraform-azurerm-network/pull/48) ([yupwei68](https://github.com/yupwei68))
- Create pull\_request\_template.md [\#47](https://github.com/Azure/terraform-azurerm-network/pull/47) ([yupwei68](https://github.com/yupwei68))
- Terraform 0.13 upgrade [\#45](https://github.com/Azure/terraform-azurerm-network/pull/45) ([yupwei68](https://github.com/yupwei68))
- Add period to vnet\_name description. [\#40](https://github.com/Azure/terraform-azurerm-network/pull/40) ([cedarkuo](https://github.com/cedarkuo))
- Replace use of deprecated attribute address\_prefix [\#39](https://github.com/Azure/terraform-azurerm-network/pull/39) ([alhails](https://github.com/alhails))
- Integration of terramodtest 0.5.0 [\#37](https://github.com/Azure/terraform-azurerm-network/pull/37) ([yupwei68](https://github.com/yupwei68))
- Remove 'azurerm\_resource\_group' & upgrade azurerm 2.0 [\#35](https://github.com/Azure/terraform-azurerm-network/pull/35) ([yupwei68](https://github.com/yupwei68))
- terraform version upgrade to v0.12 [\#33](https://github.com/Azure/terraform-azurerm-network/pull/33) ([yupwei68](https://github.com/yupwei68))
- Updated README example to supress network security ID warning [\#32](https://github.com/Azure/terraform-azurerm-network/pull/32) ([danielfears](https://github.com/danielfears))
- fix \#30 [\#31](https://github.com/Azure/terraform-azurerm-network/pull/31) ([AlexBevan](https://github.com/AlexBevan))
- Add Terratest and Revert to 2.0.0 [\#26](https://github.com/Azure/terraform-azurerm-network/pull/26) ([foreverXZC](https://github.com/foreverXZC))
- Migrating Network to use vnet module 1.0.0 and updating test. [\#21](https://github.com/Azure/terraform-azurerm-network/pull/21) ([rguthriemsft](https://github.com/rguthriemsft))
- Update the travis.yaml to build image with pre-defined environment variables. [\#20](https://github.com/Azure/terraform-azurerm-network/pull/20) ([metacpp](https://github.com/metacpp))
- Use terramodtest package to run test kitchen tasks. [\#18](https://github.com/Azure/terraform-azurerm-network/pull/18) ([metacpp](https://github.com/metacpp))
- Correction on fixtures [\#17](https://github.com/Azure/terraform-azurerm-network/pull/17) ([dcaro](https://github.com/dcaro))
- removed NSG from module and updaded README [\#16](https://github.com/Azure/terraform-azurerm-network/pull/16) ([dcaro](https://github.com/dcaro))
- Add badge service in README [\#13](https://github.com/Azure/terraform-azurerm-network/pull/13) ([metacpp](https://github.com/metacpp))
- Improve the workflow for network module. [\#12](https://github.com/Azure/terraform-azurerm-network/pull/12) ([metacpp](https://github.com/metacpp))
- Enable Rake workflow for network module [\#11](https://github.com/Azure/terraform-azurerm-network/pull/11) ([metacpp](https://github.com/metacpp))
- Kitchen test [\#9](https://github.com/Azure/terraform-azurerm-network/pull/9) ([rguthriemsft](https://github.com/rguthriemsft))
- Add Travis CI using docker [\#7](https://github.com/Azure/terraform-azurerm-network/pull/7) ([dtzar](https://github.com/dtzar))
- remove undefined dns\_servers output [\#6](https://github.com/Azure/terraform-azurerm-network/pull/6) ([ricoli](https://github.com/ricoli))
- Added vnet name as parameter [\#2](https://github.com/Azure/terraform-azurerm-network/pull/2) ([jmapro](https://github.com/jmapro))
- Changes for Terraform Module Registry formatting [\#1](https://github.com/Azure/terraform-azurerm-network/pull/1) ([cgriggs01](https://github.com/cgriggs01))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
