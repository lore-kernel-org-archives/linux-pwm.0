From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH 7/7] arm: dts: pwm: replace polarity constant with
 macro
Date: Fri, 20 Mar 2020 11:02:43 +0100
Message-ID: <20200320100243.GA16931@pi3>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-8-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-8-oleksandr.suvorov@toradex.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Chen-Yu Tsai <wens@csie.org>, David Lechner <david@lechnology.com>, Fabio Estevam <festevam@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Kevin Hilman <khilman>
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 02:32:31PM +0200, Oleksandr Suvorov wrote:
> There is the PWM_POLARITY_NORMAL defined and describled in
> <dt-bindings/pwm/pwm.h> and used by pwm drivers.
> 
> This patch converts all '0' constant in pwms parameters into
> PWM_POLARITY_NORMAL.
> 
> Replace with sed regexp:
> 's/(pwms = <&[a-zA-Z_0-9]+ [0-9]+ [0-9]+) 0>/\1 PWM_POLARITY_NORMAL>/'
> 
> Then:
> - included pwm.h in some dts/dtsi to fix building errors about undefined
>   symbols.
> - fixed the patman warnings about the code format;
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
> 
>  arch/arm/boot/dts/am335x-cm-t335.dts               | 2 +-
>  arch/arm/boot/dts/am335x-evm.dts                   | 2 +-
>  arch/arm/boot/dts/am3517-evm.dts                   | 2 +-
>  arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi      | 2 +-
>  arch/arm/boot/dts/at91-kizbox2-common.dtsi         | 6 +++---
>  arch/arm/boot/dts/at91-kizbox3_common.dtsi         | 8 ++++----
>  arch/arm/boot/dts/at91-kizboxmini-common.dtsi      | 6 +++---
>  arch/arm/boot/dts/at91-nattis-2-natte-2.dts        | 2 +-
>  arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        | 2 +-
>  arch/arm/boot/dts/at91sam9n12ek.dts                | 2 +-
>  arch/arm/boot/dts/at91sam9x5dm.dtsi                | 2 +-
>  arch/arm/boot/dts/berlin2cd-google-chromecast.dts  | 4 ++--
>  arch/arm/boot/dts/da850-evm.dts                    | 2 +-
>  arch/arm/boot/dts/da850-lego-ev3.dts               | 4 ++--
>  arch/arm/boot/dts/exynos4412-midas.dtsi            | 2 +-
>  arch/arm/boot/dts/exynos4412-odroidu3.dts          | 2 +-
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi      | 2 +-
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          | 2 +-
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         | 2 +-
>  arch/arm/boot/dts/exynos5422-odroidhc1.dts         | 2 +-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
>  arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 2 +-
>  arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    | 4 ++--
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          | 2 +-
>  arch/arm/boot/dts/imx53-tx53-x13x.dts              | 5 +++--
>  arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          | 2 +-
>  arch/arm/boot/dts/imx6q-display5.dtsi              | 2 +-
>  arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       | 2 +-
>  arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       | 2 +-
>  arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi            | 4 ++--
>  arch/arm/boot/dts/imx7-colibri.dtsi                | 4 +++-
>  arch/arm/boot/dts/imx7d-nitrogen7.dts              | 3 ++-
>  arch/arm/boot/dts/imx7d-pico.dtsi                  | 3 ++-
>  arch/arm/boot/dts/imx7d-sdb.dts                    | 3 ++-
>  arch/arm/boot/dts/imx7ulp-evk.dts                  | 3 ++-
>  arch/arm/boot/dts/iwg20d-q7-common.dtsi            | 2 +-
>  arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   | 2 +-
>  arch/arm/boot/dts/meson8b-ec100.dts                | 4 ++--
>  arch/arm/boot/dts/meson8b-mxq.dts                  | 4 ++--
>  arch/arm/boot/dts/meson8b-odroidc1.dts             | 4 ++--
>  arch/arm/boot/dts/motorola-mapphone-common.dtsi    | 3 ++-
>  arch/arm/boot/dts/omap3-gta04.dtsi                 | 2 +-
>  arch/arm/boot/dts/omap3-n900.dts                   | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-edp.dtsi           | 2 +-
>  arch/arm/boot/dts/rk3288-veyron.dtsi               | 2 +-
>  arch/arm/boot/dts/rv1108-evb.dts                   | 2 +-
>  arch/arm/boot/dts/s3c6410-mini6410.dts             | 2 +-
>  arch/arm/boot/dts/s5pv210-aries.dtsi               | 2 +-
>  arch/arm/boot/dts/s5pv210-smdkv210.dts             | 2 +-

For Exynos/S3C/S5P:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
