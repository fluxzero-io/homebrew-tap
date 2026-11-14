class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.19/flux-macos-arm64"
      sha256 "fb3faff1acb860a0efb517e49ec0ebfa3363d3ea75aee5ae593128f582311e29"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.19/flux-macos-amd64"
      sha256 "ecb959521c2580461e9c5e11fbb48789e445a36cfeedf9591eff22d56c8dc679"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.19/flux-linux-amd64"
      sha256 "330d9b41e643c1e41b8b7307224eeaf86c281550cc354de50bf1ebe95f1b9866"
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
