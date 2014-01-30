From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
Date: Thu, 30 Jan 2014 20:49:27 +0100
Message-ID: <201401302049.27521.arnd@arndb.de>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62967 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbaA3Ttd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jan 2014 14:49:33 -0500
In-Reply-To: <1391061145-2078-1-git-send-email-21cnbao@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Barry Song <21cnbao@gmail.com>, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, Rongjun Ying <Rongjun.ying@csr.com>, Huayi Li <Huayi.Li@csr.com>, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

On Thursday 30 January 2014, Barry Song wrote:
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7acab93..0a252f8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -166,6 +166,15 @@ config PWM_SAMSUNG
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-samsung.
>  
> +config PWM_SIRF
> +	tristate "SiRF PWM support"
> +	depends on ARCH_SIRF
> +	help

please make this "depends on ARCH_SIRF || COMPILE_TEST" if you can, so we
can build it on other platforms for test purposes. If you do this, you
have to list the full set of dependencies, so probably another
"depends on HAVE_CLK".

> +
> +#define to_sirf_chip(chip)	container_of(chip, struct sirf_pwm, chip)
> +
> +static unsigned int sirf_pwm_ns_to_cycles(struct pwm_chip *chip, unsigned int time_ns)
> +{
> +	u64 dividend;
> +	unsigned int cycle;
> +	/*
> +	 * on SiRFSoC, OSC input is const, we use it as the source to generate
> +	 * PWM wave
> +	 */
> +#define SRC_OSC_RATE 26000000ULL
> +	dividend = SRC_OSC_RATE * time_ns + NSEC_PER_SEC / 2;
> +	do_div(dividend, NSEC_PER_SEC);
> +
> +	cycle = dividend & 0xFFFFFFFFUL;
> +
> +	return cycle > 1 ? cycle : 1;
> +}
> +

Is SRC_OSC_RATE the rate of spwm->clk? If so, it would be nice to just call
clk_get_rate() here, in case you ever have a chip with a different rate.

This is a very nice driver otherwise!

	Arnd
