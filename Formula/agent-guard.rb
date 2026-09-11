class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.4.1/agent-guard-3.4.1.tar.gz"
  sha256 "eef847d6a7cb59c9445262ae3aad5ad485b46831c270b6c849b605c4560d5795"
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
    assert_match "agent-guard 3.4.1", shell_output("#{bin}/agent-guard version")
    system "#{bin}/agent-guard", "check"
    system "#{bin}/agent-guard", "smoke-test"
  end
end
