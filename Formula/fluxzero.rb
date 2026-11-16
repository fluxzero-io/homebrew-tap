class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.23/flux-macos-arm64"
      sha256 "74a1bdc8bf2f89d8ffa6a5514c80ff31b71cdc3eeefb9581c90a98f2e5637a9e"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.23/flux-macos-amd64"
      sha256 "f22636c5e6510271ba11aedb146a7e0be706508407a178354de901ecce0d5177"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.23/flux-linux-amd64"
      sha256 "51ae13cb03ab3c6a190e1aed5bb0ae797a1d1e9b3f85b9090165e83c781f82f2"
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
