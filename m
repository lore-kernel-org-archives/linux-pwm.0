From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv8 0/2] Add Allwinner SoCs PWM support
Date: Sun, 19 Oct 2014 20:28:23 +0200
Message-ID: <1413743305-1979-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53365 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751583AbaJSS2f (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Oct 2014 14:28:35 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, jonsmirl@gmail.com, Simon <longsleep@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi,

This patch series adds support for the PWM controller found on the Allwinner
SoCs.

The first patch adds the driver itself.
The second patch adds the DT binding documentation

Changes in v8:
 - renamed the driver sun4i as the PWM IP is different in the next sunxi SoCs
 - Took into account comments from Thierry

Alexandre Belloni (2):
  pwm: Add Allwinner SoC support
  pwm: sunxi: document OF bindings

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  20 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun4i.c                            | 371 +++++++++++++++++++++
 4 files changed, 401 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
 create mode 100644 drivers/pwm/pwm-sun4i.c

-- 
1.9.1

