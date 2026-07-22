class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  version "1.8.1"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.1/flux-macos-arm64"
      sha256 "46c70530f815da842d431d294e92b53327312350d96bcf2f5091f2d929d79d5d"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.1/flux-macos-amd64"
      sha256 "6d666dba4a41d9f3423c3291a135f05881704ae7bd362228b946192ecd7bd126"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.8.1/flux-linux-amd64"
      sha256 "49b730aa7547969424f8f86d9e537a121e89fa4a04ce9b3f85a538bc3f13c4d0"
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
