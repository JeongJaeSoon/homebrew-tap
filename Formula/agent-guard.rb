class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.4.0/agent-guard-3.4.0.tar.gz"
  sha256 "d1c6b578b6d89e576562f5c3c1e8dd6385f0cb606f0ca5a2cbf33fb57d0969a0"
  license "MIT"

  depends_on "git"
  depends_on "gitleaks"
  depends_on "jq"

  def install
    libexec.install Dir["*"]
    (libexec/".agent-guard-homebrew").write "homebrew\n"
    (bin/"agent-guard").write <<~SH
      #!/bin/sh
      exec "#{libexec}/bin/agent-guard" "$@"
    SH
  end

  test do
    assert_match "agent-guard 3.4.0", shell_output("#{bin}/agent-guard version")
    system "#{bin}/agent-guard", "check"
    system "#{bin}/agent-guard", "smoke-test"
  end
end
