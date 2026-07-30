class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.12.0/flux-macos-arm64"
      sha256 "51452ca891a849c0963457c60ad398ca2c89173f813fd5ebc983415af88ae88a"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.12.0/flux-macos-amd64"
      sha256 "00a0960a6b9f07e013da934060915b676b9c0484ac9ab16822071540ed59f66c"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.12.0/flux-linux-amd64"
      sha256 "aa09b05ca293e750ff0ff7ed5d384cb3557b83b0ce5cae0c89ec71cf1a8974fc"
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
