class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.0/flux-macos-arm64"
      sha256 "c602a2b291881c5422921f2b873975bcee44be90d21ad7be4670b6fd0d57a332"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.0/flux-macos-amd64"
      sha256 "93636247e3f280c1140f8f36b9f97e5709003dd7b3b98798cdfbc525d8111032"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.0/flux-linux-amd64"
      sha256 "71ace597ea359c3c894ccfd3596a044253c3daf5370337c336c26537baf0dcbf"
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
