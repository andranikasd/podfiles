Contributing to podfiles

Development
1. Clone repo and make bin/podfiles executable.
2. Run lint: make lint
3. Run tests: make test

Commit messages
Use Conventional Commits:
  feat: add X
  fix: correct Y
  docs: update README
  chore: tooling, deps
  ci: workflows
Use "!" or BREAKING CHANGE for majors.

Pull requests
1. Title must follow Conventional Commits (enforced by PR Title Gate).
2. Tests and ShellCheck must pass.
3. Keep changes focused; include docs.

Git flow
• main/master is protected.
• feature branches: feat/xxx, fix/xxx, chore/xxx
• squash merge with a Conventional title preferred.

Release
• Start simple: manual GitHub Releases or tags.
• Optionally add semantic-release later.
