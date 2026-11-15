class Sangsoe < Formula
  desc "Orchestration for Claude Code sessions on Orca"
  homepage "https://github.com/JeongJaeSoon/sangsoe"
  url "https://github.com/JeongJaeSoon/sangsoe/releases/download/v0.1.7/sangsoe-0.1.7.tar.gz"
  sha256 "8038be5910cc908bf1ebb0d14becb06e6b23474a9e89aafa389d04ee260cc757"

  depends_on "node"

  conflicts_with "sangsoe-rc", because: "both install the sangsoe command"

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
      refuses and prints the condition that failed. The review is recorded
      by someone other than the session that wrote the pull request; under
      Claude Code, a record made from a checkout on the pull request's
      branch is refused.
      Each upgrade installs a new folder, so after `brew upgrade` run
      `sangsoe install`, have the new build's review recorded with
      `sangsoe review record`, run `sangsoe plugin approve` again, then
      `sangsoe doctor`.
      Before `brew uninstall sangsoe`, run `sangsoe uninstall`.
    EOS
  end

  test do
    assert_match "sangsoe #{version}", shell_output("#{bin}/sangsoe --version")
    system bin/"sangsoe", "doctor", "--offline"
  end
end
