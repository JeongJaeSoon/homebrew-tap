class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.6.1/agent-guard-3.6.1.tar.gz"
  sha256 "00f6ee4fd18a515384d82ba465fc445b21b1c55a749a931aedea8bf4877551b2"
  license "MIT"

  depends_on "git"
  depends_on "gitleaks"
  depends_on "jq"
  depends_on "perl"

  def install
    libexec.install Dir["*"]
    (libexec/".agent-guard-homebrew").write "homebrew\n"
    (bin/"agent-guard").write <<~SH
      #!/bin/sh
      exec "#{libexec}/bin/agent-guard" "$@"
    SH
  end

  test do
    assert_match "agent-guard 3.6.1", shell_output("#{bin}/agent-guard version")
    system bin/"agent-guard", "check"
    system bin/"agent-guard", "smoke-test"
  end
end
