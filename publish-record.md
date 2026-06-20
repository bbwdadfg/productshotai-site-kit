# Publish Record: ProductShot AI

- Site: <https://productshotai.app>
- Source repo: <https://github.com/bbwdadfg/productshotai-site-kit>
- Started: 2026-06-20T04:30:00Z
- Finished: 2026-06-20T06:45:17Z

## Summary

| Status | Count |
| --- | ---: |
| blocked_credentials | 4 |
| blocked_namespace | 1 |
| blocked_review | 1 |
| published | 3 |
| skipped_not_applicable | 3 |
| skipped_policy | 5 |
| submitted | 1 |
| verified | 13 |

## Published Links

| Platform | Package | Version | Public URL | Verification |
| --- | --- | --- | --- | --- |
| github | `bbwdadfg/productshotai-site-kit` | `v0.1.0` | <https://github.com/bbwdadfg/productshotai-site-kit> | public repo, homepage, and pushed tags verified |
| pkg_go_dev | `github.com/bbwdadfg/productshotai-site-kit` | `v0.1.0` | <https://pkg.go.dev/github.com/bbwdadfg/productshotai-site-kit> | Go proxy resolved v0.1.0; pkg.go.dev page still indexing |
| crates_io_docs_rs | `productshotai-site-kit` | `0.1.0` | <https://crates.io/crates/productshotai-site-kit> | crates.io API verified homepage and repository; docs.rs still 404/indexing |
| rubygems | `productshotai-site-kit` | `0.1.0` | <https://rubygems.org/gems/productshotai-site-kit> | RubyGems API verified version, homepage, and source_code_uri |
| npm | `productshotai-site-kit` | `0.1.0` | <https://www.npmjs.com/package/productshotai-site-kit> | npm registry JSON verified latest, homepage, and repository |
| pypi | `productshotai-site-kit` | `0.1.0` | <https://pypi.org/project/productshotai-site-kit/> | PyPI JSON API verified version, homepage, and repository |
| pub_dev | `productshotai_site_kit` | `0.1.1` | <https://pub.dev/packages/productshotai_site_kit> | pub.dev API verified latest 0.1.1 with homepage and repository |
| hex_hexdocs | `productshotai_site_kit` | `0.1.0` | <https://hex.pm/packages/productshotai_site_kit> | Hex API verified package links; HexDocs published and redirects to package docs host |
| clojars | `io.github.bbwdadfg/productshotai-site-kit` | `0.1.0` | <https://clojars.org/io.github.bbwdadfg/productshotai-site-kit> | Clojars repo POM verified homepage and SCM links |
| docker_hub | `baiwei111/productshotai-site-kit` | `0.1.0` | <https://hub.docker.com/r/baiwei111/productshotai-site-kit> | Docker Registry manifest verified schemaVersion 2, config digest, and layer count |
| maven_central_javadoc | `io.github.bbwdadfg:productshotai-site-kit` | `0.1.0` | <https://central.sonatype.com/artifact/io.github.bbwdadfg/productshotai-site-kit> | Central bundle uploaded, validated, and publish API returned HTTP 204; Central status API returned 500 and repo1/search indexing not visible yet |
| nuget | `ProductShotAI.SiteKit` | `0.1.0` | <https://www.nuget.org/packages/ProductShotAI.SiteKit/> | NuGet flat-container API verified version 0.1.0 |
| cocoapods | `ProductShotAISiteKit` | `0.1.0` | <https://cocoapods.org/pods/ProductShotAISiteKit> | GitHub Actions run 27862372191 published ProductShotAISiteKit 0.1.0; pod trunk info and CocoaPods page verified homepage and GitHub links |
| luarocks | `productshotai-site-kit` | `0.1.0-1` | <https://luarocks.org/modules/bbwdadfg/productshotai-site-kit> | LuaRocks module page verified version and homepage |
| chocolatey | `productshotai-site-kit` | `0.1.0` | <https://community.chocolatey.org/packages/productshotai-site-kit> | Chocolatey page shows Pending with ProductShot AI and homepage link |
| github_packages | `@bbwdadfg/productshotai-site-kit` | `0.1.0` | <https://github.com/users/bbwdadfg/packages/npm/package/productshotai-site-kit> | GitHub npm package verified via npm view against npm.pkg.github.com |
| gitlab_packages | `productshotai-site-kit` | `0.1.0` | <https://gitlab.com/baiwei.chu/productshotai-site-kit> | GitLab API verified generic package and public project |

## Blocked Or Manual Steps

| Platform | Status | Reason |
| --- | --- | --- |
| packagist | `blocked_credentials` | publish-package-backlinks/packagist-token exists but contains an empty password value |
| jsr | `blocked_namespace` | JSR package does not exist yet and must be created on jsr.io before CLI publish; token was exposed by CLI failure output |
| cpan_metacpan | `blocked_credentials` | PAUSE user/token rejected with 401 Unauthorized |
| hackage | `blocked_credentials` | missing publish-package-backlinks/hackage-token and cabal unavailable |
| terraform_registry | `skipped_not_applicable` | no infrastructure module value |
| helm_artifact_hub | `skipped_not_applicable` | no Kubernetes chart value |
| ansible_galaxy | `skipped_not_applicable` | no automation role value |
| open_vsx | `blocked_credentials` | missing publish-package-backlinks/openvsx-token |
| wordpress_plugin_directory | `blocked_review` | WordPress.org login/review/SVN approval required |
| aur | `skipped_policy` | no real installable Arch utility |
| conda_forge | `skipped_policy` | no scientific/Python conda value |
| cran | `skipped_policy` | no CRAN-suitable R package |
| flathub | `skipped_policy` | ordinary website helper is not a Flathub app |
| homebrew | `skipped_policy` | website helper only |

## Credential Cleanup

- Tokens were read from macOS Keychain into temporary command environments/config files only.
- Temporary npmrc, Maven settings, Docker workspace, GitLab upload archive, and generated package archives were deleted after use.
- JSR token was exposed by CLI failure output again and must be revoked before retry.
- CocoaPods token is stored as a GitHub Actions secret for this repository.

## Follow-Up Queue

- maven_central_javadoc: Retry Central status/repo1/search/javadoc verification after indexing; deployment publish API returned 204 (owner: agent_or_user)
- pkg_go_dev: Retry pkg.go.dev page after indexing; Go proxy already resolves v0.1.0 (owner: agent_or_user)
- chocolatey: Wait for moderation to leave Pending (owner: platform)
- hackage: Install cabal and add publish-package-backlinks/hackage-token (owner: user)
- open_vsx: Create/verify Open VSX publisher namespace bbwdadfg and add publish-package-backlinks/openvsx-token (owner: user)
- wordpress_plugin_directory: Submit /tmp/productshotai-site-kit-wordpress.zip in WordPress.org plugin review flow (owner: user)
- packagist: Re-store a non-empty Packagist token in publish-package-backlinks/packagist-token (owner: user)
- jsr: Create the JSR package page, revoke the exposed token, then store a fresh publish token (owner: user)
- cpan_metacpan: Generate a new PAUSE upload token from the logged-in PAUSE account and store it in publish-package-backlinks/cpan-token (owner: user)
