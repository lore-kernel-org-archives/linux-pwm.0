From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] pwm: Add support for Amlogic Meson G12A
Date: Tue, 23 Apr 2019 15:36:43 +0200
Message-ID: <20190423133646.5705-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This adds support for the PWM modules on the Amlogic Meson G12A SoC
family, including bindings changes and DT nodes.

Changes since v1:
- Add two different AO compatible to distinguish the different clock sources

Neil Armstrong (3):
  dt-bindings: pwm: Update bindings for the Meson G12A Family
  pwm: meson: Add clock source configuration for Meson G12A
  arm64: dts: meson-g12a: Add PWM nodes

 .../devicetree/bindings/pwm/pwm-meson.txt     |   3 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 179 ++++++++++++++++++
 drivers/pwm/pwm-meson.c                       |  30 +++
 3 files changed, 212 insertions(+)

-- 
2.21.0
