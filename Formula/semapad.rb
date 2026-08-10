class Semapad < Formula
  include Language::Python::Virtualenv

  desc "Codex Micro pad + web dashboard for parallel Claude Desktop sessions"
  homepage "https://github.com/JeongJaeSoon/semapad"
  url "https://github.com/JeongJaeSoon/semapad/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "20671a9c133d1ca9e9ba03f4323cb03447f997def0f95a58fa3b3be9d9199f9b"
  license "MIT"

  depends_on :macos
  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      To get working / waiting / error colours and start on login:
        semapad install-hooks
        semapad autostart install
      Dashboard: semapad ui  (http://127.0.0.1:8642)
    EOS
  end

  test do
    assert_match "usage: semapad", shell_output("#{bin}/semapad --help")
  end
end
