class AgentConfig < Formula
  EXCLUDED_DOT_ENTRIES = [".", "..", ".git"].freeze

  desc "Canonical AI agent configuration and deeplink tooling"
  homepage "https://github.com/LivioGama/agent-config"
  url "https://github.com/LivioGama/agent-config/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "efb1ed4d575662d32fe3a81ec1643983e872d7b24134fcf3a7b82f13d6da90d7"
  license "MIT"

  depends_on "rulesync"

  def install
    libexec.install Dir["*"]
    libexec.install Dir[".*"].reject { |path| EXCLUDED_DOT_ENTRIES.include? File.basename(path) }

    chmod 0755, libexec/"build.sh"
    chmod 0755, libexec/"sync-skills.sh"
    chmod 0755, libexec/"sync-infrastructure.sh"
    chmod 0755, libexec/"sync-mcp-servers.sh"
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
        sync-infrastructure)
          shift || true
          cd "#{libexec}"
          exec ./sync-infrastructure.sh "$@"
          ;;
        sync-mcp)
          shift || true
          cd "#{libexec}"
          exec ./sync-mcp-servers.sh "$@"
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
        sync-infrastructure  Install shell scripts, hooks, MCP configs
        sync-mcp          Centralize MCP servers across all AI agent CLIs
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

    # Standalone commands so rules can reference them by name without
    # needing to know about the `agent-config` subcommand interface.
    (bin/"build-agent-config").write <<~BASH
      #!/bin/bash
      set -euo pipefail
      cd "#{libexec}"
      exec ./build.sh "$@"
    BASH

    (bin/"sync-agent-skills").write <<~BASH
      #!/bin/bash
      set -euo pipefail
      cd "#{libexec}"
      exec ./sync-skills.sh "$@"
    BASH

    (bin/"sync-agent-infrastructure").write <<~BASH
      #!/bin/bash
      set -euo pipefail
      cd "#{libexec}"
      exec ./sync-infrastructure.sh "$@"
    BASH

    (bin/"sync-mcp-servers").write <<~BASH
      #!/bin/bash
      set -euo pipefail
      cd "#{libexec}"
      exec ./sync-mcp-servers.sh "$@"
    BASH
  end

  test do
    assert_match "Usage: agent-config", shell_output("#{bin}/agent-config --help")
    assert_path_exists libexec/".agent-config/AGENTS.md"
    refute_path_exists libexec/".agent-config/rules"
    assert_path_exists libexec/"rules/global-content-workflow.md"
    assert_match "Regenerated", shell_output("#{bin}/build-agent-config 2>&1", 0).lines.first&.strip || ""
  end
end
