class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.11/flux-macos-arm64"
      sha256 "d2f10987c9763623ada944422b7c9173496c41c549f25a7fcd6a05a9643bd776"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.11/flux-macos-amd64"
      sha256 "4c45853543cb0037a9c82316812c25c2ffc673ac5cbc77e2fc59128ca667ee4b"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.11/flux-linux-amd64"
      sha256 "7afb0d7253636618f5b718971bd7c2818bb3430851733ec23163050c4d99dfc7"
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
