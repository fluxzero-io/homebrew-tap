class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.1/flux-macos-arm64"
      sha256 "3c1df3f8ffaf605ba4e47bf3d61e0eb75dca8a00f99dbbbf15beba8c75ea21b9"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.1/flux-macos-amd64"
      sha256 "84903c1b8d0419f93f356f6cdc6b0420ed79174a5ce597847dabe44e8ec690de"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.20.1/flux-linux-amd64"
      sha256 "5b634630b31cdc22c0d1d831e2d909c68af4f98f771a58a1f2dae3f1504102a7"
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
