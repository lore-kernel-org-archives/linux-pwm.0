From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] pwm: Add Amlogic Meson SoC PWM Controller
Date: Fri, 17 Jun 2016 16:29:40 +0200
Message-ID: <1466173784-15625-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add support for the PWM controller found in Amlogic Meson SoCs.
This controller provides a dual PWM output with 4 selectable clock source
and a two level divider to achieve a better PWM range.

Currently Meson8b and GXBB SoCs are supported.

Neil Armstrong (4):
  pwm: Add support for Meson PWM Controller
  dt-bindings: pwm: Add bindings for Meson PWM Controller
  ARM64: dts: meson-gxbb: Add Meson GXBB PWM Controller nodes
  ARM: dts: meson8b: Add Meson8b PWM Controller nodes

 .../devicetree/bindings/pwm/pwm-meson.txt          |  21 +
 arch/arm/boot/dts/meson8b.dtsi                     |  21 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  28 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-meson.c                            | 492 +++++++++++++++++++++
 6 files changed, 572 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
 create mode 100644 drivers/pwm/pwm-meson.c

-- 
2.7.0
