class Markdone < Formula
  desc "Personal todo lists kept as Markdown files"
  homepage "https://github.com/sharpmist/markdone"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/sharpmist/markdone/releases/download/v0.4.0/t-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "72ec64972b9a961c022fbdc3c3d1b3b24d6d3c5835c8e6a2af2190f19a961354"
    end
    on_intel do
      url "https://github.com/sharpmist/markdone/releases/download/v0.4.0/t-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "77f8d2fe7cbfa4e93a536138c34d014412911968911f141c981269f0da5c0330"
    end
  end

  on_linux do
    # From the next release on, add an on_arm block for t-<version>-aarch64-unknown-linux-musl.tar.gz.
    on_intel do
      url "https://github.com/sharpmist/markdone/releases/download/v0.4.0/t-0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9d4a2611f90c8b2b4f08673ec35a5c38481910e3f7ae613d5f8926c07e416e0f"
    end
  end

  def install
    bin.install "t"
    pkgshare.install "shell/t.zsh"
  end

  def caveats
    <<~EOS
      Tab completion for t needs zsh and fzf. To turn it on, add to ~/.zshrc,
      after fzf's key bindings (source <(fzf --zsh)):
        source #{opt_pkgshare}/t.zsh
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/t version")
    (testpath/"Todo.md").write "## Today\n\n## Later\n\n## Done\n"
    ENV["TODO_FILE"] = testpath/"Todo.md"
    ENV["XDG_CONFIG_HOME"] = testpath/".config"
    system bin/"t", "add", "Try markdone"
    assert_match "Try markdone", shell_output("#{bin}/t list")
  end
end
