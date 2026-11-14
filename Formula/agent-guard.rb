class AgentGuard < Formula
  desc "Deterministic secret guardrails for AI coding agents"
  homepage "https://github.com/JeongJaeSoon/agent-guard"
  url "https://github.com/JeongJaeSoon/agent-guard/releases/download/v3.9.0/agent-guard-3.9.0.tar.gz"
  sha256 "eaadcc7e586ec35cd29ebd7fd4535c94130398df9bb97b1fea6c9032a303d1c3"
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

  def caveats
    on_macos do
      on_intel do
        <<~EOS
          Intel Mac (x86_64) support ended after Agent Guard v3.8.2.
          Later releases ship no Intel native helper and are not tested on Intel;
          redaction uses the shell/jq fallback.
        EOS
      end
    end
  end

  test do
    assert_match "agent-guard 3.9.0", shell_output("#{bin}/agent-guard version")
    system bin/"agent-guard", "check"
    system bin/"agent-guard", "smoke-test"
  end
end
