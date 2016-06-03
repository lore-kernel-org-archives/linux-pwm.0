From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 05/14] pwm: rockchip: Avoid glitches on already running
 PWMs
Date: Fri, 3 Jun 2016 13:28:59 -0700
Message-ID: <20160603202859.GD124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-6-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34079 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351AbcFCU3D (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jun 2016 16:29:03 -0400
Received: by mail-pa0-f44.google.com with SMTP id bz2so17300114pad.1
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jun 2016 13:29:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464942192-25967-6-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com

Hi,

Just noticed a few things:

On Fri, Jun 03, 2016 at 10:23:03AM +0200, Boris Brezillon wrote:
> The current logic will disable the PWM clk even if the PWM was left
> enabled by the bootloader (because it's controlling a critical device
> like a regulator for example).
> Keep the PWM clk enabled if the PWM is enabled to avoid any glitches.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index dfacf7d..798a787 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -299,6 +299,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *id;
>  	struct rockchip_pwm_chip *pc;
> +	struct pwm_state state;
>  	struct resource *r;
>  	int ret;
>  
> @@ -319,7 +320,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pc->clk))
>  		return PTR_ERR(pc->clk);
>  
> -	ret = clk_prepare(pc->clk);
> +	ret = clk_prepare_enable(pc->clk);
>  	if (ret)
>  		return ret;
>  
> @@ -342,12 +343,33 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>  	}
>  
> +	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
> +	pwm_get_state(pc->chip.pwms, &state);
> +	if (!state.enabled)

Why not just if (!pwm_is_enabled())?

> +		clk_disable(pc->clk);
> +
>  	return ret;
>  }
>  
>  static int rockchip_pwm_remove(struct platform_device *pdev)
>  {
>  	struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
> +	struct pwm_state state;
> +
> +	/*
> +	 * Disable the PWM clk before unpreparing it if the PWM device is still
> +	 * running. This should only happen when the last PWM user left it
> +	 * enabled, or when nobody requested a PWM that was previously enabled
> +	 * by the bootloader.
> +	 *
> +	 * FIXME: Maybe the core should disable all PWM devices in
> +	 * pwmchip_remove(). In this case we'd only have to call
> +	 * clk_unprepare() after pwmchip_remove().
> +	 *
> +	 */
> +	pwm_get_state(pc->chip.pwms, &state);
> +	if (state.enabled)

Same here.

With that:

Reviewed-by: Brian Norris <briannorris@chromium.org>

And it tests out fine:

Tested-by: Brian Norris <briannorris@chromium.org>


> +		clk_disable(pc->clk);
>  
>  	clk_unprepare(pc->clk);
>  
> -- 
> 2.7.4
> 
