# Changelog

## [0.1.2](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/compare/v0.1.1...v0.1.2) (2025-01-09)


### Styles

* move the descriptions up in the variables ([7d57082](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/7d570829e6120c2917f9cc91f9ffb6eb493a13af))


### Continuous Integration

* add config to enable Renovate ([3172d34](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/3172d34b6c3a16af5a7387ce9e363ca6884cacf4))

## [0.1.1](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/compare/v0.1.0...v0.1.1) (2024-11-27)


### Features

* add default SG rules to allow health checks on private LB ([b33920f](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/b33920f7ef0df4880c6205d57c4aa7ad55d6fc00))
* add outputs with the LB info to configure the ingress controller ([05e13f1](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/05e13f1591ee096c52751551e9540df95ecd97fb))
* implement a way to provide a private and public LB ([11e6ef5](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/11e6ef5076885d7df411e6fcd0a1627d80ec7eb4))
* validate that both LBs do not use the same backend node pool ([12ca39c](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/12ca39c164db81305a23118df242965a92e0b433))


### Bug Fixes

* fix not found error when LBs are not enabled ([9649c12](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/9649c12161d5a5d95e7ab195e7e37fa3d21b75b5))
* remove '/' from tags (they are overwritten by Exoscale) ([56dbe11](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/56dbe1170f30e9b970ef4c4c6ea6dfd86e3b19d2))


### Documentation

* add small note on comment in locals.tf ([29a168b](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/29a168be6f10464790e23e5a1239686272a9d5de))
* warn users that disabling LB requires manual steps ([dc01e27](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/dc01e2712e3f9ed31f5db301802d501297d4538f))


### Miscellaneous Chores

* merge pull request [#5](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/issues/5) from schrodingers-stack/feat/create-load-balancers ([cac5db0](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/cac5db0191db6092f6b77ae4dd45a0766ccc4450))
* remove commented and unnecessary rules ([83871cc](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/83871ccbe96a3cef267dec79bc876af1b1d5df8b))


### Code Refactoring

* rename files to more understandable file structure ([ac887c1](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/ac887c1f5cc6fe2b80daa7b73ad92a501de2ab88))
* reorganize attributes in SG rules in the same order ([6e9ef6c](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/6e9ef6c3d32b7dc6e2195f133190a51543fddd0b))

## 0.1.0 (2024-11-21)


### Features

* initial commit (migrate the changes from the old monorepo) ([63afe49](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/63afe491d0fef0831effd9bf2569a3734c4d6e9c))
* remove reference to old name ([89e0c20](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/89e0c20774561134ee9b1cf29010c75a4a3c3a61))


### Miscellaneous Chores

* add/edit .gitignore ([e07e091](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/e07e09123c48aae8aa35ff97f9df06b87d002892))
* add/edit .gitignore ([1ce0ee5](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/1ce0ee56383607db687948166ff53d3e998dc510))
* add/edit CODEOWNERS ([d717a7a](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/d717a7acffc889fc3a92f4ff228810109e6e3891))
* add/edit CODEOWNERS ([b20f741](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/b20f7411a6db35c7861c57a9aa420037743e88a0))
* add/edit CODEOWNERS ([355dffa](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/355dffaa0767d9acef13b04470611981c12eb132))
* add/edit CODEOWNERS ([f15f10a](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/f15f10a3f1c76023ddf40c8836e84f851e14c311))
* add/edit LICENSE.txt ([28fbfae](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/28fbfaebdddc56b4a43eddb27a64c641bf5bb860))
* add/edit release-please-config.json ([13088e2](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/13088e2a31e21352de8e1194faa3b8d0798dd090))
* add/edit release-please-config.json ([f7e8547](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/f7e8547817fa0cc2f4b64475648557fd9508036a))
* add/edit release-please-config.json ([52b87de](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/52b87debd9b237a2addd21f0ce02223df8eff679))
* add/edit release-please-config.json ([241d5c8](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/241d5c8455c144173f2d5772dc4682ac6ece55f3))
* add/edit release-please-config.json ([03d9d01](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/03d9d01f2b06003823d025b236f322554389a671))
* add/edit release-please-config.json ([e0d23f4](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/e0d23f4533c77b4b7a99e07ba60849d44375595a))
* add/edit release-please-manifest.json ([ffb9a6e](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/ffb9a6efd0662d324f5a07d3b71f5b43a1ce327f))
* delete old CODEOWNERS file ([fe7b166](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/fe7b166727b6ea32fa44d520340220c6c84da4e6))
* migrate tags to the new project name ([639b24c](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/639b24c68073d50f40c66144a1d17b9c0e5883d6))
* remove typo in .gitignore ([107fd21](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/107fd2154c1e3019c5f6691670be44387be1b6ae))
* trigger release v0.1.0 ([daac47a](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/daac47a55d967dce739a67dd4e8bac2a13646b22))


### Continuous Integration

* add/edit commits-checks.yaml ([8511be9](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/8511be958d97bd1c79fd50db90bb218ca8dbdaf1))
* add/edit commits-checks.yaml ([4d97d26](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/4d97d2631684a90689459eb093fa4c4c2a6ab999))
* add/edit pr-issues-project.yaml ([20d7713](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/20d7713f79c77239d7dde07cb9909661ff7b521c))
* add/edit pr-issues-project.yml ([03e9e26](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/03e9e2614caa814b321763614f8f3c0fc11ad35f))
* add/edit release-please.yaml ([1775086](https://github.com/schrodingers-stack/terraform-exoscale-sks-cluster/commit/177508661ab7fdec32fdb90638d09bf213d55aa5))
