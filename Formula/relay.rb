class Relay < Formula
  desc "Multi-agent orchestrator for Claude Code sessions with dashboard and CLI"
  homepage "https://github.com/JeongJaeSoon/relay"
  license "MIT"

  depends_on "git"
  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/JeongJaeSoon/relay/releases/download/v0.1.4/relay-0.1.4-darwin-arm64.tar.gz"
    sha256 "6befe074f738f0a97fcd9761360be8b6b2941840c59bf4b9b49276a23c7d35b5"
  else
    url "https://github.com/JeongJaeSoon/relay/releases/download/v0.1.4/relay-0.1.4-darwin-x64.tar.gz"
    sha256 "b9039a38547c9e6c4f2c3deeb3597a9fdb577a0484c639ee24d5591e122b7062"
  end

  def install
    bin.install "relay"
  end

  service do
    run [opt_bin/"relay", "serve"]
    keep_alive successful_exit: false
    working_dir Dir.home
    log_path var/"log/relay/stdout.log"
    error_log_path var/"log/relay/stderr.log"
    environment_variables PATH:          "#{std_service_path_env}:#{Dir.home}/.local/bin",
                          RELAY_SERVICE: "1",
                          RELAY_BIN:     opt_bin/"relay"
  end

  def caveats
    <<~EOS
      relay needs the Claude Code CLI (>= 2.1.251) logged in with your subscription:
        claude --version && claude   # then /login if needed
      First-time setup, then start the always-on service:
        relay setup --service
        brew services start relay
        relay open                    # http://127.0.0.1:8790
      Check the service context (PATH, Keychain vs token fallback):
        relay doctor --service
    EOS
  end

  test do
    assert_match "relay", shell_output("#{bin}/relay --version")
  end
end
