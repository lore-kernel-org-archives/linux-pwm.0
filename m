From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
Date: Thu, 2 Jan 2014 23:45:11 -0800
Message-ID: <20140103074511.GA10680@core.coreip.homeip.net>
References: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:44988 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaACHpQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jan 2014 02:45:16 -0500
Content-Disposition: inline
In-Reply-To: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: thierry.reding@gmail.com, bpringlemeir@nbsps.com, linux-pwm@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alison Wang <b18965@freescale.com>, Jingchang Lu <b35083@freescale.com>

Hi Xiubo,

On Fri, Jan 03, 2014 at 01:24:21PM +0800, Xiubo Li wrote:
> +
> +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> +					       enum fsl_pwm_clk index)
> +{

Why do you declare this (and other module-local) function as inline?
It is usually better let compiler decide if given function should be
inlined or not.

[...]

> +
> +static int fsl_pwm_remove(struct platform_device *pdev)
> +{
> +	struct fsl_pwm_chip *fpc = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&fpc->lock);
> +
> +	return pwmchip_remove(&fpc->chip);

fpc->lock will be used while pwmchip_remove() is running so you should
not be destroying it before calling pwmchip_remove(). It should probbaly
go into free() method or just drop it altogether.

Thanks.

-- 
Dmitry
