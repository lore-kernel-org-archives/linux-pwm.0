From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 09/14] regulator: pwm: Adjust PWM config at probe time
Date: Fri, 3 Jun 2016 13:41:04 -0700
Message-ID: <20160603204104.GG124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-10-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36183 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964819AbcFCUlM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jun 2016 16:41:12 -0400
Received: by mail-pf0-f174.google.com with SMTP id f144so46959568pfa.3
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jun 2016 13:41:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464942192-25967-10-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com

On Fri, Jun 03, 2016 at 10:23:07AM +0200, Boris Brezillon wrote:
> The PWM attached to a PWM regulator device might have been previously
> configured by the bootloader.
> Make sure the bootloader and linux config are in sync, and adjust the PWM
> config if that's not the case.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/pwm-regulator.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
> index ab3cc02..524b43f 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -285,11 +285,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to the
> -	 * atomic PWM API.
> -	 */
> -	pwm_apply_args(drvdata->pwm);
> +	ret = pwm_adjust_config(drvdata->pwm);
> +	if (ret)
> +		return ret;
>  
>  	regulator = devm_regulator_register(&pdev->dev,
>  					    &drvdata->desc, &config);

Acked-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
