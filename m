From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 0/3] pwm: meson-axg: add pwm controller driver
Date: Mon, 4 Dec 2017 14:00:15 +0800
Message-ID: <20171204060018.8856-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, Yixun Lan <yixun.lan@amlogic.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This patch series try to add PWM controller driver for the 
Amlogic's Meson-AXG SoC. Update the Clock sources, pin DT.

Jian Hu (3):
  dt-bindings: pwm: update bindings for the Meson-AXG
  pwm: meson: add clock source configuratin for Meson-AXG
  ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC

 .../devicetree/bindings/pwm/pwm-meson.txt          |   2 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 120 +++++++++++++++++++++
 drivers/pwm/pwm-meson.c                            |  26 +++++
 3 files changed, 148 insertions(+)

-- 
2.15.0
