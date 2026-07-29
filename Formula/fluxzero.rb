class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.1/flux-macos-arm64"
      sha256 "6d12763808575c23b3ce510cf1c2406904ffabdfde5b48c6ff17d0219a562b68"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.1/flux-macos-amd64"
      sha256 "068de7eea9e4b5723165da5f2d7637b48b05122d723ef0312c3d27745b6481d7"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.11.1/flux-linux-amd64"
      sha256 "ada2e1b8c666d6531d1cc36349b8b8080a906c5be26626369adf35e9864bc99e"
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
