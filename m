From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Mon, 12 Jan 2015 14:12:48 +0100
Message-ID: <20150112131248.GD19533@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
 <op.xscjr0cz2s3iss@ecaz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50189 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbbALNOo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 12 Jan 2015 08:14:44 -0500
Content-Disposition: inline
In-Reply-To: <op.xscjr0cz2s3iss@ecaz>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Imre Kaloz <kaloz@openwrt.org>
Cc: linus.walleij@linaro.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org

On Mon, Jan 12, 2015 at 12:05:50PM +0100, Imre Kaloz wrote:
> On Sat, 10 Jan 2015 00:34:49 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> <snip>
> 
> >diff --git a/drivers/gpio/gpio-mvebu-pwm.c
> >b/drivers/gpio/gpio-mvebu-pwm.c
> >new file mode 100644
> >index 000000000000..8a5af11aed67
> >--- /dev/null
> >+++ b/drivers/gpio/gpio-mvebu-pwm.c
> >@@ -0,0 +1,202 @@
> >+#include <linux/err.h>
> >+#include <linux/module.h>
> >+#include <linux/gpio.h>
> >+#include <linux/pwm.h>
> >+#include <linux/clk.h>
> >+#include <linux/platform_device.h>
> >+#include "gpio-mvebu.h"
> >+#include "gpiolib.h"
> 
> You also need to include <asm/io.h> for readl_relaxed, and a short
> description/copyright on the top wouldn't hurt.

Will do.

Thanks
	Andrew
