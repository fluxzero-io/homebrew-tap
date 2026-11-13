class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.17/flux-macos-arm64"
      sha256 "bc9bad44e6050d9e20da3a31fcfec897f169c0bbbc512f175df62e6d42057596"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.17/flux-macos-amd64"
      sha256 "71d3213cbd4d75089225d5bf3e001838cca295b76fefdda6e01e0143230afe99"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.17/flux-linux-amd64"
      sha256 "daa0b2ff02fc326ab94b996dc7abdbd5bfdd244ae74167ec5cc09b40dfb041fd"
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
