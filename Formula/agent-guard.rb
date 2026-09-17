class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.4.4/agent-guard-3.4.4.tar.gz"
  sha256 "e638249e15c947cbad97430898240cb32dee9004f3fbfaeaf6579675c0063c5d"
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
    assert_match "agent-guard 3.4.4", shell_output("#{bin}/agent-guard version")
    system bin/"agent-guard", "check"
    system bin/"agent-guard", "smoke-test"
  end
end
