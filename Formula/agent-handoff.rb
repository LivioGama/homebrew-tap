class AgentHandoff < Formula
  desc "Extract conversation transcripts from local AI coding agent logs"
  homepage "https://github.com/LivioGama/agent-handoff"
  url "https://github.com/LivioGama/agent-handoff.git",
    branch: "main",
    revision: "276811c"
  version "0.1.0"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/agent-handoff", "--help"
  end
end
