Return-path: <broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
Message-Id: <160683107675.35139.13466076210885462180.b4-ty@kernel.org>
Date: Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA Tegra20/30 SoCs
To: Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Peter Chen <Peter.Chen@nxp.com>, Jonathan Hunter <jonathanh@nvidia.com>, u.kleine-koenig@pengutronix.de, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Adrian Hunter <adrian.hunter@intel.com>, Peter Geis <pgwipeout@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Dmitry Osipenko <digetx@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

On Thu, 5 Nov 2020 02:43:57 +0300, Dmitry Osipenko wrote:
> Introduce core voltage scaling for NVIDIA Tegra20/30 SoCs, which reduces
> power consumption and heating of the Tegra chips. Tegra SoC has multiple
> hardware units which belong to a core power domain of the SoC and share
> the core voltage. The voltage must be selected in accordance to a minimum
> requirement of every core hardware unit.
> 
> The minimum core voltage requirement depends on:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] regulator: Allow skipping disabled regulators in regulator_check_consumers()
      (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
