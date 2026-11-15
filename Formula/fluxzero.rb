class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.20/flux-macos-arm64"
      sha256 "ef566658d2fa65fae556db2add1df3bad1fd08ddc727027a09f711b4d2dc4323"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.20/flux-macos-amd64"
      sha256 "2d8e9d494b03f3dce25eec4918f4051865fb24b5e07b9e63dc18b34c988d16b1"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.20/flux-linux-amd64"
      sha256 "bef535dea043e5c65707fe18d36fe64492e8a1e173280ae9bbce5d950640cbb1"
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
