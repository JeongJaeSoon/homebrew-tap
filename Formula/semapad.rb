class Semapad < Formula
  include Language::Python::Virtualenv

  desc "Codex Micro pad + web dashboard for parallel Claude Desktop sessions"
  homepage "https://github.com/JeongJaeSoon/semapad"
  url "https://github.com/JeongJaeSoon/semapad/archive/refs/tags/v0.1.23.tar.gz"
  sha256 "93fee0bee6e0dfcf395268c641e21f4a3f298ed72856512e7b7c5cf9a85d4991"
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
