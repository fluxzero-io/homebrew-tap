class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.4/flux-macos-arm64"
      sha256 "ef4aea76b5fbac10f7fd67d2d454a2bc2d51ad22db9f4c5753ca1e6b1829befe"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.4/flux-macos-amd64"
      sha256 "2e8f895e046fe823f43dd840d778287001c37a2c8e31279879ca40624bbbe14c"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.4/flux-linux-amd64"
      sha256 "19aedd4b80db46e6493e10e653fd8c63b38d1586d68ab8149f140a9947586331"
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
