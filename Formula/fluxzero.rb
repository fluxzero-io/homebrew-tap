class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.1/flux-macos-arm64"
      sha256 "cfae99920e7e6aef07457fbb59cb273a8bc20c770af085f58b109411d067580c"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.1/flux-macos-amd64"
      sha256 "8b61850532edd4911b40d9f1039160003f441bedb219d1b1ff32d2a6dad06f02"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.17.1/flux-linux-amd64"
      sha256 "2d7e20c22d32dd723f24473f0d81d7b0d87a826824f983c704ac880efa5197d3"
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
