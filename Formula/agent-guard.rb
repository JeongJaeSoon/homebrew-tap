class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.6.6/agent-guard-3.6.6.tar.gz"
  sha256 "aff5aa32819d8fea31c2d19faa067a23ba9e310eeef43d6c021ff10eef825c26"
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
    assert_match "agent-guard 3.6.6", shell_output("#{bin}/agent-guard version")
    system bin/"agent-guard", "check"
    system bin/"agent-guard", "smoke-test"
  end
end
