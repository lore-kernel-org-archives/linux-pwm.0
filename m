From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v4 0/8] rockchip: kevin: Enable edp display
Date: Tue, 17 Oct 2017 18:16:16 +0800
Message-ID: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:36295 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbdJQKQp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Oct 2017 06:16:45 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, heiko@sntech.de, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, tfiga@chromium.org, broonie@kernel.org, seanpaul@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Andrzej Hajda <a.hajda@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-samsung-soc@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>, Inki Dae <inki.dae@samsung.com>, linux-rockchip@lists.infradead.org, Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will.deacon@arm.com>


Make edp display works on chromebook kevin(at least for boot animation).

Also solve some issues i meet during the bringup.

Changes in v4:
Fix compile warning.

Changes in v3:
Assign orphan pwms to dummy pwmchip instead of adding device link in the
customer driver.

Changes in v2:
Use device link to correct the suspend/resume and shutdown ordering,
instead of converting rockchip spi's suspend/resume PM callbacks to
late suspend/resume PM callbacks.

Jeffy Chen (7):
  arm64: dts: rockchip: Enable edp disaplay on kevin
  drm/rockchip: analogix_dp: Fix error handling path
  drm/rockchip: dw-mipi-dsi: Fix error handling path
  drm/rockchip: dw_hdmi: Fix error handling path
  drm/rockchip: inno_hdmi: Fix error handling path
  pwm: Add dummy pwmchip for orphan pwms
  drm/rockchip: Add device links for master and components

Tomasz Figa (1):
  drm/bridge/analogix: Do not use device's drvdata

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  | 29 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 16 +++++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 50 ++++++-------
 drivers/gpu/drm/exynos/exynos_dp.c                 | 26 ++++---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 57 +++++++++------
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 17 +++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  4 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               | 20 ++++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 24 ++++++-
 drivers/pwm/core.c                                 | 81 ++++++++++++++++++++--
 include/drm/bridge/analogix_dp.h                   | 19 ++---
 11 files changed, 254 insertions(+), 89 deletions(-)

-- 
2.11.0
