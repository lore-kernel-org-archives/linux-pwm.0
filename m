From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/4] pwm: Add Amlogic Meson SoC PWM Controller
Date: Mon, 22 Aug 2016 17:36:29 +0200
Message-ID: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add support for the PWM controller found in Amlogic Meson SoCs.
This controller provides a dual PWM output with 4 selectable clock source
and a two level divider to achieve a better PWM range.

Currently Meson8b and GXBB SoCs are supported.

Changes since v2 at http://lkml.kernel.org/r/1471718083-11516-1-git-send-email-narmstrong@baylibre.com :
- Switch to apply() callback only, this fixes the setup sequence
- Implement get_state
- Make clock parent names as DT match data

Changes since v1 at http://lkml.kernel.org/r/1466173784-15625-1-git-send-email-narmstrong@baylibre.com :
- fix meson8b dtsi

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
 drivers/pwm/pwm-meson.c                            | 528 +++++++++++++++++++++
 6 files changed, 608 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
 create mode 100644 drivers/pwm/pwm-meson.c

-- 
1.9.1
