From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
Date: Mon, 27 Mar 2017 15:02:37 +0200
Message-ID: <20170327150237.69d8523f@bbrezillon>
References: <1490189375-20384-1-git-send-email-claudiu.beznea@microchip.com>
        <1490189375-20384-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35727 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbdC0NC7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2017 09:02:59 -0400
In-Reply-To: <1490189375-20384-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com, cristian.birsan@microchip.com, andrei.pistirica@microchip.com, tudor.ambarus@microchip.com, eugen.hristev@microchip.com

Hi Claudiu,

On Wed, 22 Mar 2017 15:29:34 +0200
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

>  static const struct platform_device_id atmel_pwm_devtypes[] = {
>  	{
>  		.name = "at91sam9rl-pwm",
> -		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v1,
> +		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v1,
>  	}, {
>  		.name = "sama5d3-pwm",
> -		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v2,
> +		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v2,
>  	}, {
>  		/* sentinel */
>  	},

Unrelated to this series, but can you prepare a patch to get rid of
this platform id table (AT91 platforms have completely switched to DT
for quite some time now).

You can also get rid of the "if (pdev->dev.of_node)" condition in
atmel_pwm_probe() since it's guaranteed to be true, otherwise the
->probe() method wouldn't be called.

Thanks,

Boris
