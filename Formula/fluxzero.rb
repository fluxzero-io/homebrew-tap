class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.1/flux-macos-arm64"
      sha256 "8f3fa49c9559df88d4c4d6dcd24c830290177b099eeb7d5a25e1849c234c1b99"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.1/flux-macos-amd64"
      sha256 "7692127ac6e9f218bfc5c542fa73908d0c80841822ca98f41069a2505c2a193e"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.1/flux-linux-amd64"
      sha256 "d4fa66a3132ae27a6ad4e0f2c63d452e631c80bc11e74f89ce060ae5722152f8"
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
