From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RESEND PATCH v2 0/5] rockchip: kevin: Enable edp display
Date: Mon, 16 Oct 2017 18:06:35 +0800
Message-ID: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, heiko@sntech.de, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, tfiga@chromium.org, broonie@kernel.org, seanpaul@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Andrzej Hajda <a.hajda@samsung.com>, linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Thompson <daniel.thompson@linaro.org>, David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-samsung-soc@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>, Inki Dae <inki.dae@samsung.com>, linux-rockchip@lists.infradead.org, Kyungmin Park <kyungmi>
List-Id: linux-pwm@vger.kernel.org


Make edp display works on chromebook kevin(at least for boot animation).

Also solve some issues i meet during the bringup.

Changes in v2:
Use device link to correct the suspend/resume and shutdown ordering,
instead of converting rockchip spi's suspend/resume PM callbacks to
late suspend/resume PM callbacks.

Jeffy Chen (4):
  arm64: dts: rockchip: Enable edp disaplay on kevin
  backlight: pwm_bl: Add device link for pwm_bl and pwm
  drm/rockchip: Fix error handling path in rockchip_dp_bind()
  drm/rockchip: Add device links for master and components

Tomasz Figa (1):
  drm/bridge/analogix: Do not use device's drvdata

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  | 29 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 16 ++++++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 50 ++++++++-----------
 drivers/gpu/drm/exynos/exynos_dp.c                 | 26 +++++-----
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 57 ++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 24 +++++++--
 drivers/video/backlight/pwm_bl.c                   |  2 +
 include/drm/bridge/analogix_dp.h                   | 19 +++++---
 8 files changed, 151 insertions(+), 72 deletions(-)

-- 
2.11.0
