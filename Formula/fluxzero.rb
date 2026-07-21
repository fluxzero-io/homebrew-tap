class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.5.0"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.5.0/flux-macos-arm64"
      sha256 "dc72d7cfec37b36bb5db8b109a24ff09c10d33eea028012c8bea0f8d0d31a800"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.5.0/flux-macos-amd64"
      sha256 "3b48e8a6a345584ca299ba5e4d04843f42b52aacbbe1917d71d0a81c5a418590"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.5.0/flux-linux-amd64"
      sha256 "8737faaf9d4e2c31d551533de55090aef634cca39c05cde27e303702cde1a171"
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
