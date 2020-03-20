From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH 6/7] arm64: dts: pwm: replace polarity constant with
 macro
Date: Fri, 20 Mar 2020 11:03:29 +0100
Message-ID: <20200320100329.GB16931@pi3>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-7-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-7-oleksandr.suvorov@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>, Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Hugh Cole-Baker <sigmaris@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, Johan
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 02:32:30PM +0200, Oleksandr Suvorov wrote:
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
> - include pwm.h in some dts/dtsi to fix building errors about undefined
>   symbols.
> - fix the patman warnings about the code format;
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts      | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts       | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts             | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi                 | 1 +
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi          | 1 +
>  arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts          | 5 +++--
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts            | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts         | 5 +++--
>  arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi    | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts       | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts       | 7 ++++---
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi        | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi                  | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts       | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts     | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi           | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi       | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi          | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts       | 3 ++-
>  .../boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts    | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 +-
>  .../arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi      | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts      | 5 +++--
>  arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts         | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi         | 4 +++-
>  arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts     | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts           | 7 ++++---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi      | 3 ++-

For Exynos:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
