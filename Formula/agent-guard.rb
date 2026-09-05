class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.1.1/agent-guard-3.1.1.tar.gz"
  sha256 "b8ca9ca791e6fbe72c469a2ac9ed444f38cc52d05ef056d901809c41bbe00855"
  license "MIT"

  def install
    libexec.install Dir["*"]
    (bin/"agent-guard").write <<~SH
      #!/bin/sh
      exec "#{libexec}/bin/agent-guard" "$@"
    SH
  end

  test do
    assert_match "agent-guard 3.1.1", shell_output("#{bin}/agent-guard version")
  end
end
