From: "Imre Kaloz" <kaloz@openwrt.org>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Mon, 12 Jan 2015 12:05:50 +0100
Message-ID: <op.xscjr0cz2s3iss@ecaz>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:51212 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924AbbALLFw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 12 Jan 2015 06:05:52 -0500
In-Reply-To: <1420846493-31647-4-git-send-email-andrew@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linus.walleij@linaro.org, Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org

On Sat, 10 Jan 2015 00:34:49 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

<snip>

> diff --git a/drivers/gpio/gpio-mvebu-pwm.c  
> b/drivers/gpio/gpio-mvebu-pwm.c
> new file mode 100644
> index 000000000000..8a5af11aed67
> --- /dev/null
> +++ b/drivers/gpio/gpio-mvebu-pwm.c
> @@ -0,0 +1,202 @@
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/gpio.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include "gpio-mvebu.h"
> +#include "gpiolib.h"

You also need to include <asm/io.h> for readl_relaxed, and a short  
description/copyright on the top wouldn't hurt.


Imre
