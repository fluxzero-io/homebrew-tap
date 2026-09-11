class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.6/flux-macos-arm64"
      sha256 "6381a26dc77daf35349dfc95754465b7a787a8bdd14db65115d5bb4685d5e009"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.6/flux-macos-amd64"
      sha256 "55c183692109cb8fa1e418dc7b4a1a047b526a39cfdbaa21005de68c105f56d9"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.18.6/flux-linux-amd64"
      sha256 "775d014b45c388cab5e371e5cc745d590541a7b527fb1c60bfd4b3898692c92f"
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
