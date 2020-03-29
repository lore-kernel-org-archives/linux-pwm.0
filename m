From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Sun, 29 Mar 2020 11:45:50 +0100
Message-ID: <20200329104549.GX25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35574 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgC2KqB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 06:46:01 -0400
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>

Hi,

This series adds support for the fan PWM output on the Clearfog GT8K
platform, and can potentially be extended to the Macchiatobin.

The cooling maps are experimental - it seems to work well for me
without the fan speed varying too much, but what I've noticed with
fewer entries in the map is instability in the fan speed - it
continually toggles between two fan speeds as the temperature
rises and falls due to the different fan speed.  Hence, this is more
for discussion at this point (and in any case, -final is likely to be
released today.)

 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     | 125 ++++++++++++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi      |   6 +
 drivers/gpio/gpio-mvebu.c                          | 220 ++++++++++++++-------
 3 files changed, 275 insertions(+), 76 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
