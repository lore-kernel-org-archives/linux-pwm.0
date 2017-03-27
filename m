From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v3 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
Date: Mon, 27 Mar 2017 15:15:30 +0200
Message-ID: <20170327131530.ifexyrgrp5egtbtr@piout.net>
References: <1490189375-20384-1-git-send-email-claudiu.beznea@microchip.com>
 <1490189375-20384-2-git-send-email-claudiu.beznea@microchip.com>
 <20170327150237.69d8523f@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35929 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdC0NP7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2017 09:15:59 -0400
Content-Disposition: inline
In-Reply-To: <20170327150237.69d8523f@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>, thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com, cristian.birsan@microchip.com, andrei.pistirica@microchip.com, tudor.ambarus@microchip.com, eugen.hristev@microchip.com

On 27/03/2017 at 15:02:37 +0200, Boris Brezillon wrote:
> Hi Claudiu,
> 
> On Wed, 22 Mar 2017 15:29:34 +0200
> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> 
> >  static const struct platform_device_id atmel_pwm_devtypes[] = {
> >  	{
> >  		.name = "at91sam9rl-pwm",
> > -		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v1,
> > +		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v1,
> >  	}, {
> >  		.name = "sama5d3-pwm",
> > -		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v2,
> > +		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v2,
> >  	}, {
> >  		/* sentinel */
> >  	},
> 
> Unrelated to this series, but can you prepare a patch to get rid of
> this platform id table (AT91 platforms have completely switched to DT
> for quite some time now).
> 

Please, don't until AVR32 is gone.

> You can also get rid of the "if (pdev->dev.of_node)" condition in
> atmel_pwm_probe() since it's guaranteed to be true, otherwise the
> ->probe() method wouldn't be called.
> 
> Thanks,
> 
> Boris

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
