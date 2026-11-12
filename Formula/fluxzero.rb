class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.14/flux-macos-arm64"
      sha256 "f706e1d4f1d4c387cf5f3884e7898f8e74c2d9e064efb118d3246adb5d97ad2f"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.14/flux-macos-amd64"
      sha256 "307d4387ccfa0229f377d9933ded30cb765bec8e58628d57dadb9f262a5e9f03"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.14/flux-linux-amd64"
      sha256 "771f217d37e53ce4d22b8b07fdcfd1abf1e38d2c5d25a71436a2b3760cd91d9f"
    end
  end

  def install
    binary = if OS.mac?
      Hardware::CPU.arm? ? "flux-macos-arm64" : "flux-macos-amd64"
    else
      "flux-linux-amd64"
    end

    bin.install binary => "fz"
    bin.install_symlink "fz" => "fluxzero"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fz version")
    assert_equal "fz", File.basename(File.readlink(bin/"fluxzero"))
  end
end
