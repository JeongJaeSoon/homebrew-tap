class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.6.3/agent-guard-3.6.3.tar.gz"
  sha256 "cd794369d41d8abfdf07a4f6beb211e3d45ce9498c7e1063ecd7717c9969ee8a"
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
    assert_match "agent-guard 3.6.3", shell_output("#{bin}/agent-guard version")
    system bin/"agent-guard", "check"
    system bin/"agent-guard", "smoke-test"
  end
end
