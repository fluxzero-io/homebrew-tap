class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.13.1/flux-macos-arm64"
      sha256 "b3c32c8c87c2e7786457975f2c3ed1c671d496abc0d3c1fd20f16263202d9669"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.13.1/flux-macos-amd64"
      sha256 "b5ab6d7c2bfb997f86d5158c081f24ca46a038e0dcdcb5d5c1cad5b52bf70344"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.13.1/flux-linux-amd64"
      sha256 "cefe8f2e8a50a9c1827fa63d2ec822bcb2938a7a773e43e831426bf4d0b434b7"
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
