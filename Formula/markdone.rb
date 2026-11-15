class Markdone < Formula
  desc "Personal todo lists kept as Markdown files"
  homepage "https://github.com/sharpmist/markdone"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/sharpmist/markdone/releases/download/v0.4.1/t-0.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "984f0671f380942bccfe03e0270afb18e4f899c0aa51a2f73333577931ab53b5"
    end
    on_intel do
      url "https://github.com/sharpmist/markdone/releases/download/v0.4.1/t-0.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "408e3e82425f8dd700f70f9b3ca881189ffabb7a50a72cf52b097d45df9cc1e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/sharpmist/markdone/releases/download/v0.4.1/t-0.4.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0650c663613ac9fb7479b457bb64897ea0b2d6fc4dd12c6cd23a1bcfe3b67803"
    end
    on_intel do
      url "https://github.com/sharpmist/markdone/releases/download/v0.4.1/t-0.4.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0cd21f317c41043753941f533d59059bfe26229f816ecdf0039366eaec9d3e1c"
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
