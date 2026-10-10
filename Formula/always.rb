class Always < Formula
  desc "Always-on speech-to-text daemon — hands-free voice dictation"
  homepage "https://github.com/LivioGama/always"
  url "https://github.com/LivioGama/always/releases/download/v0.0.1/always-0.0.1-macos-arm64"
  sha256 "PLACEHOLDER_ARM64"
  license "AGPL-3.0-only"

  depends_on "mas" => :optional # For the GUI app (installed via cask)

  def install
    bin.install "always" => "always"
  end

  plist_options startup: true

  def plist
    <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/always</string>
          <string>run</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>StandardErrorPath</key>
        <string>#{HOMEBREW_PREFIX}/var/log/always.log</string>
        <key>StandardOutPath</key>
        <string>#{HOMEBREW_PREFIX}/var/log/always.log</string>
      </dict>
      </plist>
    PLIST
  end

  test do
    system "#{bin}/always", "--help"
  end
end
