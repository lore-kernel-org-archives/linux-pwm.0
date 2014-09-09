From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] pwm: lpc32xx - Add a driver for the motor PWM
Date: Tue, 09 Sep 2014 17:47:53 +0200
Message-ID: <2942175.JkZcLDKfiR@wuerfel>
References: <1410277361-26848-1-git-send-email-alban.bedel@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:53200 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbaIIPsC (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Sep 2014 11:48:02 -0400
In-Reply-To: <1410277361-26848-1-git-send-email-alban.bedel@avionic-design.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Roland Stigge <stigge@antcom.de>

On Tuesday 09 September 2014 17:42:41 Alban Bedel wrote:
> +config PWM_LPC32XX_MOTOR
> +	tristate "LPC32xx Motor PWM support"
> +	depends on ARCH_LPC32XX
> +	help
> +	  Generic PWM framework driver for LPC32xx motor PWM. The LPC32xx SOC
> +	  has one motor PWM controllers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-lpc32xx-motor.
> +

Can you change the dependency to ARCH_LPC32XX || COMPILE_TEST and
add explicit dependencies for the subsystems the driver depends
on (pwm and clk, I guess)? That would give us better build-time
coverage with allmodconfig.

> +	/* Write to limit register -> period */
> +	__raw_writel(period, lpc32xx->base + MCLIM_REG_OFFSET(pwm));
> +
> +	/* Write to match register -> duty */
> +	__raw_writel(period - duty, lpc32xx->base + MCMAT_REG_OFFSET(pwm));

Please don't use __raw_{writel,readl} in driver, and change that to use
readl_relaxed()/writel_relaxed().

	Arnd
