class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.1.0/pixel-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "a7029e82c865f73db93973aabec867e1ba482a1747510fefc9276013bc405aa2"
    end
    # Intel Macs (pre-2020): no prebuilt binary. Build from source via:
    #   cargo build --release -p pixel-cli
    # or run the ARM64 binary under Rosetta.
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.1.0/pixel-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "039c466fbd8c3aee4ea42630f601966f53d0ac67e527bd554c8e5ed6f0672157"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.1.0/pixel-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "45b12eddab408beda6b916b2ce2ddb9de57f7dc76f14bae3617a4ab3ee162e61"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
