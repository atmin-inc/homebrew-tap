class Atmin < Formula
  desc "Evidence-based code review with bounded model spending"
  homepage "https://github.com/atmin-inc/review"
  url "https://registry.npmjs.org/@atmin.ai/review/-/review-0.1.0-alpha.2.tgz"
  version "0.1.0-alpha.2"
  sha256 "e75a94349bae82edd43017285d871a27b47799dfc1f727b76f48a59da3cc22e1"
  license "Apache-2.0"

  depends_on "gh"
  depends_on "git"
  depends_on "node@24"

  def install
    system formula_opt_bin("node@24")/"npm", "install", *std_npm_args
    %w[atmin-review atmin-review-github].each do |command|
      (bin/command).write_env_script libexec/"bin"/command,
                                    PATH: "#{formula_opt_bin("node@24")}:$PATH"
    end
    bin.install_symlink "atmin-review" => "atmin"
    (share/"atmin").install libexec/"lib/node_modules/@atmin.ai/review/profiles"
  end

  def caveats
    <<~EOS
      This alpha provides code review via `atmin review`.
      Run `gh auth login` and set OPENROUTER_API_KEY before reviewing a PR.
      Example profiles: #{share}/atmin/profiles
      Copy a profile and pass it with --profile; paid profiles allow model spending.
    EOS
  end

  test do
    assert_match "atmin-review review", shell_output("#{bin}/atmin --help")
    assert_match "atmin-review review", shell_output("#{bin}/atmin-review --help")
    assert_match "Starts paused", shell_output("#{bin}/atmin-review-github --help")
    profile = share/"atmin/profiles/smoke-openrouter-free.json"
    assert_path_exists share/"atmin/profiles/baseline-deepseek.json"
    output = shell_output("#{bin}/atmin review https://example.com/owner/repo/pull/1 --profile #{profile} 2>&1", 1)
    assert_match "Use an HTTPS github.com pull request URL", output
  end
end
