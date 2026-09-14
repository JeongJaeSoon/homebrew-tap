class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.4.2/agent-guard-3.4.2.tar.gz"
  sha256 "3c6ea0f8a3270ce93504e75601f14e20e85eeb5aa9a4fbd443a798bbea90986d"
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
    assert_match "agent-guard 3.4.2", shell_output("#{bin}/agent-guard version")
    system "#{bin}/agent-guard", "check"
    system "#{bin}/agent-guard", "smoke-test"
  end
end
