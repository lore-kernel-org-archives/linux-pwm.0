From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH v2 0/4] pwm: Add Amlogic Meson SoC PWM Controller
Date: Sat, 20 Aug 2016 20:34:39 +0200
Message-ID: <1471718083-11516-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37587 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbcHTSeu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Aug 2016 14:34:50 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so85340558wmg.0
        for <linux-pwm@vger.kernel.org>; Sat, 20 Aug 2016 11:34:50 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Add support for the PWM controller found in Amlogic Meson SoCs.
This controller provides a dual PWM output with 4 selectable clock source
and a two level divider to achieve a better PWM range.

Currently Meson8b and GXBB SoCs are supported.

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
 drivers/pwm/pwm-meson.c                            | 491 +++++++++++++++++++++
 6 files changed, 571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
 create mode 100644 drivers/pwm/pwm-meson.c

-- 
1.9.1
