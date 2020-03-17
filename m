From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [RFC PATCH 0/7] Rework PWM_POLARITY_* flags
Date: Tue, 17 Mar 2020 14:32:24 +0200
Message-ID: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Sekhar Nori <nsekhar@ti.com>, dri-devel@lists.freedesktop.org, Soeren Moch <smoch@web.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Hugh Cole-Baker <sigmaris@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Katsuhiro Suzuki <katsuhiro@katsuster.net>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, NXP Linux Team <linux-imx@nxp.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-omap@vger.kernel.org, Alex Elder <elder@kernel.org>, Scott Branden <sbranden@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


PWM_POLARITY_* flags were defined in include/linux/pwm.h as a enum and
in include/dt-bindings/pwm/pwm.h as macros.

This patchset fixes duplication and introduces using PWM_POLARITY_NORMAL
flag instead of '0' constant in DT files.


Oleksandr Suvorov (7):
  pwm: rename the PWM_POLARITY_INVERSED enum
  dt-bindings: pwm: document the PWM polarity flag
  dt-bindings: pwm: add normal PWM polarity flag
  dt-bindings: pwm: add description of PWM polarity
  pwm: replace polarity enum with macros
  arm64: dts: pwm: replace polarity constant with macro
  arm: dts: pwm: replace polarity constant with macro

 Documentation/devicetree/bindings/pwm/pwm.txt |  1 +
 arch/arm/boot/dts/am335x-cm-t335.dts          |  2 +-
 arch/arm/boot/dts/am335x-evm.dts              |  2 +-
 arch/arm/boot/dts/am3517-evm.dts              |  2 +-
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi |  2 +-
 arch/arm/boot/dts/at91-kizbox2-common.dtsi    |  6 ++--
 arch/arm/boot/dts/at91-kizbox3_common.dtsi    |  8 ++---
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi |  6 ++--
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts   |  2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts   |  2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts           |  2 +-
 arch/arm/boot/dts/at91sam9x5dm.dtsi           |  2 +-
 .../boot/dts/berlin2cd-google-chromecast.dts  |  4 +--
 arch/arm/boot/dts/da850-evm.dts               |  2 +-
 arch/arm/boot/dts/da850-lego-ev3.dts          |  4 +--
 arch/arm/boot/dts/exynos4412-midas.dtsi       |  2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi |  2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts     |  2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |  2 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts    |  2 +-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi |  2 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts    |  2 +-
 .../boot/dts/exynos54xx-odroidxu-leds.dtsi    |  4 +--
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  2 +-
 arch/arm/boot/dts/imx53-tx53-x13x.dts         |  5 ++--
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts     |  2 +-
 arch/arm/boot/dts/imx6q-display5.dtsi         |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts  |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts  |  2 +-
 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi       |  4 +--
 arch/arm/boot/dts/imx7-colibri.dtsi           |  4 ++-
 arch/arm/boot/dts/imx7d-nitrogen7.dts         |  3 +-
 arch/arm/boot/dts/imx7d-pico.dtsi             |  3 +-
 arch/arm/boot/dts/imx7d-sdb.dts               |  3 +-
 arch/arm/boot/dts/imx7ulp-evk.dts             |  3 +-
 arch/arm/boot/dts/iwg20d-q7-common.dtsi       |  2 +-
 .../boot/dts/logicpd-torpedo-baseboard.dtsi   |  2 +-
 arch/arm/boot/dts/meson8b-ec100.dts           |  4 +--
 arch/arm/boot/dts/meson8b-mxq.dts             |  4 +--
 arch/arm/boot/dts/meson8b-odroidc1.dts        |  4 +--
 .../boot/dts/motorola-mapphone-common.dtsi    |  3 +-
 arch/arm/boot/dts/omap3-gta04.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-n900.dts              |  2 +-
 arch/arm/boot/dts/rk3288-veyron-edp.dtsi      |  2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi          |  2 +-
 arch/arm/boot/dts/rv1108-evb.dts              |  2 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts        |  2 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi          |  2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts        |  2 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts           |  2 +-
 arch/arm/boot/dts/vf-colibri.dtsi             |  4 ++-
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  2 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  2 +-
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  3 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  1 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  1 +
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  5 ++--
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  2 +-
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |  5 ++--
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   |  4 +--
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  4 +--
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts |  7 +++--
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  |  3 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  1 +
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts |  3 +-
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  3 +-
 .../boot/dts/amlogic/meson-gxbb-p20x.dtsi     |  3 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi |  3 +-
 .../boot/dts/amlogic/meson-gxbb-wetek.dtsi    |  3 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts |  3 +-
 .../meson-gxl-s905x-hwacom-amazetv.dts        |  3 +-
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    |  2 +-
 .../amlogic/meson-gxl-s905x-nexbox-a95x.dts   |  3 +-
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     |  3 +-
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     |  5 ++--
 .../boot/dts/amlogic/meson-gxm-rbox-pro.dts   |  3 +-
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  4 ++-
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    |  2 +-
 .../boot/dts/amlogic/meson-sm1-sei610.dts     |  7 +++--
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  3 +-
 arch/arm64/boot/dts/rockchip/px30-evb.dts     |  2 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi        |  1 +
 .../arm64/boot/dts/rockchip/rk3308-roc-cc.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts   |  4 +--
 .../boot/dts/rockchip/rk3399-firefly.dts      |  2 +-
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  2 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  4 +--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  6 ++--
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |  2 +-
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  2 +-
 .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  2 +-
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  2 +-
 .../rockchip/rk3399-sapphire-excavator.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  1 +
 drivers/pwm/core.c                            |  6 ++--
 drivers/pwm/pwm-atmel-hlcdc.c                 |  2 +-
 drivers/pwm/pwm-atmel-tcb.c                   | 24 +++++++--------
 drivers/pwm/pwm-atmel.c                       |  2 +-
 drivers/pwm/pwm-bcm-iproc.c                   |  2 +-
 drivers/pwm/pwm-bcm-kona.c                    |  4 +--
 drivers/pwm/pwm-bcm2835.c                     |  2 +-
 drivers/pwm/pwm-berlin.c                      |  2 +-
 drivers/pwm/pwm-ep93xx.c                      |  4 +--
 drivers/pwm/pwm-fsl-ftm.c                     |  2 +-
 drivers/pwm/pwm-hibvt.c                       |  4 +--
 drivers/pwm/pwm-imx-tpm.c                     |  2 +-
 drivers/pwm/pwm-imx27.c                       |  4 +--
 drivers/pwm/pwm-jz4740.c                      |  2 +-
 drivers/pwm/pwm-lpc18xx-sct.c                 |  2 +-
 drivers/pwm/pwm-meson.c                       |  6 ++--
 drivers/pwm/pwm-omap-dmtimer.c                |  6 ++--
 drivers/pwm/pwm-renesas-tpu.c                 | 10 +++----
 drivers/pwm/pwm-rockchip.c                    |  4 +--
 drivers/pwm/pwm-samsung.c                     |  2 +-
 drivers/pwm/pwm-sifive.c                      |  4 +--
 drivers/pwm/pwm-stm32.c                       |  2 +-
 drivers/pwm/pwm-sun4i.c                       |  2 +-
 drivers/pwm/pwm-tiecap.c                      |  4 +--
 drivers/pwm/pwm-tiehrpwm.c                    |  8 ++---
 drivers/pwm/pwm-vt8500.c                      |  4 +--
 drivers/pwm/pwm-zx.c                          |  4 +--
 drivers/pwm/sysfs.c                           |  6 ++--
 drivers/staging/greybus/pwm.c                 |  2 +-
 drivers/video/backlight/lp8788_bl.c           |  2 +-
 include/dt-bindings/pwm/pwm.h                 | 10 +++++++
 include/linux/mfd/lp8788.h                    |  2 +-
 include/linux/pwm.h                           | 29 +++++--------------
 include/trace/events/pwm.h                    |  2 +-
 130 files changed, 239 insertions(+), 205 deletions(-)

-- 
2.24.1
