class ZapSh < Formula
  desc "Bash CLI for putting files in the trash"
  homepage "https://github.com/AjaiKN/zap.sh"
  url "https://github.com/AjaiKN/zap.sh/archive/refs/tags/v0.0.14.tar.gz"
  sha256 "89fcf40d50897fae85f435ca576625d4f1681d0dcb84c05f63a291e4fbc6bed9"
  license "GPL-3.0-or-later"

  def install
    bin.install Dir["bin/*"]
    man.install Dir["man/*"]
    zsh_completion.install "completions/zsh/_zap"
  end

  test do
    # brew test --verbose --keep-tmp zap.sh
    shell_output "touch #{testpath}/a_file.txt"
    assert_path_exists testpath/"a_file.txt"
    puts shell_output "#{bin}/zap --dry-run -v -s freedesktop #{testpath}/a_file.txt 2>&1"
    assert_path_exists testpath/"a_file.txt"
    puts shell_output "#{bin}/zap -v -s freedesktop #{testpath}/a_file.txt 2>&1"
    refute_path_exists testpath/"a_file.txt"
  end
end
