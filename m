From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v2 0/6] Add PWM_NOFLAGS property flag
Date: Sun,  5 Apr 2020 22:22:40 +0300
Message-ID: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Alexis Ballier <aballier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Soeren Moch <smoch-S0/GAf8tV78@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tobias Schramm <t.schramm-x9ov/VOV9nNAfugRpC6u6w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Katsuhiro Suzuki <katsuhiro-WKCMddiH/C4xsqv6Oivclw@public.gmane.org>, Hugh Cole-Baker <sigmaris-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ludovic Desroches <ludovic.desroches@microchip.>
List-Id: linux-pwm@vger.kernel.org


This patchset introduces the PWM_NOFLAGS flag instead of '0' raw value
in the optional cell "flags" of "pwms" property, if it is required to be
used but don't need to set any flag.

Also, replace '1' raw value of "flags" cell with the existing macro
PWM_POLARITY_INVERTED where it has not been done before.

Changes in v2:
- remove the driver part of patchset as dangerous and senseless.
- Use PWM_NOFLAGS instead of PWM_POLARITY_NORMAL to avoid possible
  conflict with enum pwm_polarity in <linux/pwm.h>. Also, this name
  reflects the sense of this value more precisely.
- add the example of PWM_NOFLAGS usage;

Oleksandr Suvorov (6):
  dt-bindings: pwm: add PWM_NOFLAGS definition
  dt-bindings: pwm: document the PWM no-flag
  arm64: dts: pwm: replace flag 1 with PWM_POLARITY_INVERTED
  arm64: dts: pwm: replace flag 0 with PWM_NOFLAGS
  arm: dts: pwm: replace flag 1 with PWM_POLARITY_INVERTED
  arm: dts: pwm: replace flag 0 with PWM_NOFLAGS

 Documentation/devicetree/bindings/pwm/pwm.txt         | 11 ++++++++++-
 arch/arm/boot/dts/am335x-cm-t335.dts                  |  2 +-
 arch/arm/boot/dts/am335x-evm.dts                      |  2 +-
 arch/arm/boot/dts/am3517-evm.dts                      |  2 +-
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi         |  2 +-
 arch/arm/boot/dts/at91-kizbox2-common.dtsi            |  6 +++---
 arch/arm/boot/dts/at91-kizbox3_common.dtsi            |  8 ++++----
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi         |  6 +++---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts           |  2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts           |  2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                   |  2 +-
 arch/arm/boot/dts/at91sam9x5dm.dtsi                   |  2 +-
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts     |  4 ++--
 arch/arm/boot/dts/da850-evm.dts                       |  2 +-
 arch/arm/boot/dts/da850-lego-ev3.dts                  |  4 ++--
 arch/arm/boot/dts/exynos4412-midas.dtsi               |  2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts             |  2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi         |  2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts             |  2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts            |  2 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts            |  2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi    |  2 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts            |  2 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi       |  4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts             |  2 +-
 arch/arm/boot/dts/imx53-tx53-x13x.dts                 |  5 +++--
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts             |  2 +-
 arch/arm/boot/dts/imx6q-display5.dtsi                 |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts          |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts          |  2 +-
 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi               |  4 ++--
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi        |  4 +++-
 arch/arm/boot/dts/imx7-colibri.dtsi                   |  4 +++-
 arch/arm/boot/dts/imx7d-nitrogen7.dts                 |  3 ++-
 arch/arm/boot/dts/imx7d-pico.dtsi                     |  3 ++-
 arch/arm/boot/dts/imx7d-sdb.dts                       |  3 ++-
 arch/arm/boot/dts/imx7ulp-evk.dts                     |  3 ++-
 arch/arm/boot/dts/iwg20d-q7-common.dtsi               |  2 +-
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi      |  2 +-
 arch/arm/boot/dts/meson8b-ec100.dts                   |  4 ++--
 arch/arm/boot/dts/meson8b-mxq.dts                     |  4 ++--
 arch/arm/boot/dts/meson8b-odroidc1.dts                |  4 ++--
 arch/arm/boot/dts/motorola-mapphone-common.dtsi       |  3 ++-
 arch/arm/boot/dts/omap3-gta04.dtsi                    |  2 +-
 arch/arm/boot/dts/omap3-n900.dts                      |  2 +-
 arch/arm/boot/dts/rk3229-evb.dts                      |  4 ++--
 arch/arm/boot/dts/rk3229-xms6.dts                     |  4 ++--
 arch/arm/boot/dts/rk3288-veyron-edp.dtsi              |  2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi                  |  2 +-
 arch/arm/boot/dts/rv1108-evb.dts                      |  2 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts                |  2 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi                  |  2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts                |  2 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts                   |  2 +-
 arch/arm/boot/dts/vf-colibri.dtsi                     |  4 +++-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts  |  2 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts        |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi            |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi     |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts     |  5 +++--
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts       |  2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts    |  5 +++--
 .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi      |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts  |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts  |  7 ++++---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi   |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi             |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts  |  3 ++-
 .../arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi      |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi  |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi     |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts  |  3 ++-
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts    |  3 ++-
 .../boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   |  2 +-
 .../boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts  |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts |  5 +++--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts    |  3 ++-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi    |  4 +++-
 .../arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts |  2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts      |  7 ++++---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi |  3 ++-
 arch/arm64/boot/dts/rockchip/px30-evb.dts             |  2 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi                |  1 +
 arch/arm64/boot/dts/rockchip/rk3308-evb.dts           |  2 +-
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts        |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3308.dtsi              |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts           |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts       |  4 ++--
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi  |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi          |  6 +++---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi  |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts     |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts     |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts  |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi       |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts     |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi    |  4 ++--
 .../boot/dts/rockchip/rk3399-sapphire-excavator.dts   |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi     |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi              |  1 +
 include/dt-bindings/pwm/pwm.h                         |  1 +
 107 files changed, 183 insertions(+), 135 deletions(-)

-- 
2.24.1
