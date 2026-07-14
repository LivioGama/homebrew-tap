class AgentConfig < Formula
  EXCLUDED_DOT_ENTRIES = [".", "..", ".git"].freeze

  desc "Canonical AI agent configuration and deeplink tooling"
  homepage "https://github.com/LivioGama/agent-config"
  url "https://github.com/LivioGama/agent-config/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "0f6966c30c88b3ed9b15815b1e1141288bced3f3498db9b2290ce270b667454e"
  license "MIT"

  depends_on "rulesync"

  def install
    libexec.install Dir["*"]
    libexec.install Dir[".*"].reject { |path| EXCLUDED_DOT_ENTRIES.include? File.basename(path) }

    chmod 0755, libexec/"build.sh"
    chmod 0755, libexec/"sync-skills.sh"
    chmod 0755, libexec/"handle-deeplink.sh"
    chmod 0755, libexec/"install.sh"
    chmod 0755, libexec/"AgentConfigHandler/build.sh"
    chmod 0755, libexec/"AgentConfigHandler/install-linux.sh"

    (bin/"agent-config").write <<~BASH
      #!/bin/bash
      set -euo pipefail

      command="${1:-help}"
      case "$command" in
        build)
          shift || true
          cd "#{libexec}"
          exec ./build.sh "$@"
          ;;
        sync-skills)
          shift || true
          cd "#{libexec}"
          exec ./sync-skills.sh "$@"
          ;;
        handle)
          shift || true
          exec "#{libexec}/handle-deeplink.sh" "$@"
          ;;
        install-handler)
          shift || true
          case "$(uname -s)" in
            Darwin)
              cd "#{libexec}/AgentConfigHandler"
              exec ./build.sh "$@"
              ;;
            Linux)
              cd "#{libexec}/AgentConfigHandler"
              exec ./install-linux.sh "$@"
              ;;
            *)
              echo "Unsupported platform: $(uname -s)" >&2
              exit 1
              ;;
          esac
          ;;
        path)
          echo "#{libexec}"
          ;;
        help|--help|-h)
          cat <<'USAGE'
      Usage: agent-config <command>

      Commands:
        build             Regenerate .agent-config/AGENTS.md and per-tool config files
        sync-skills       Sync canonical skills to local agent tool directories
        handle <url>      Handle an agent-config:// deeplink
        install-handler   Build/install the local deeplink handler
        path              Print the installed source path
      USAGE
          ;;
        *)
          echo "Unknown command: $command" >&2
          echo "Run 'agent-config --help' for usage." >&2
          exit 1
          ;;
      esac
    BASH
  end

  test do
    assert_match "Usage: agent-config", shell_output("#{bin}/agent-config --help")
    assert_path_exists libexec/".agent-config/AGENTS.md"
    refute_path_exists libexec/".agent-config/rules"
    assert_path_exists libexec/"rules/global-content-workflow.md"
  end
end
