class SangsoeRc < Formula
  desc "Orchestration for Claude Code sessions on Orca"
  homepage "https://github.com/JeongJaeSoon/sangsoe"
  url "https://github.com/JeongJaeSoon/sangsoe/releases/download/v0.1.4-rc.4/sangsoe-0.1.4-rc.4.tar.gz"
  sha256 "36931ec0c64ccebcb15c7f3a8fe228e341739aa1e22acf2e4e8ab7b0fe1801c8"

  depends_on "node"

  conflicts_with "sangsoe", because: "both install the sangsoe command"

  def install
    # Dir["*"] skips dot folders; .claude-plugin holds the marketplace file `sangsoe install` registers.
    libexec.install Dir["*"], ".claude-plugin"
    (bin/"sangsoe").write <<~SH
      #!/bin/sh
      SANGSOE_ROOT="#{opt_libexec}" exec "#{Formula["node"].opt_bin}/node" "#{opt_libexec}/dist/cli/main.js" "$@"
    SH
  end

  def caveats
    <<~EOS
      Register sangsoe with Claude Code and Orca, then check it:
        sangsoe install
        sangsoe doctor
      The Orca plugin stays pending until `sangsoe plugin approve` enables
      it. Approve enables only a build whose pull request has an
      independent review with no Act-on findings, recorded in this
      machine's sangsoe store by `sangsoe review record`; otherwise it
      refuses and prints the condition that failed.
      Each upgrade installs a new folder, so after `brew upgrade` run
      `sangsoe install`, record the new build's review with
      `sangsoe review record`, run `sangsoe plugin approve` again, then
      `sangsoe doctor`.
      Before `brew uninstall sangsoe-rc`, run `sangsoe uninstall`.
    EOS
  end

  test do
    assert_match "sangsoe #{version}", shell_output("#{bin}/sangsoe --version")
    system bin/"sangsoe", "doctor", "--offline"
  end
end
