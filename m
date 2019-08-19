Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60664 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfHSJoZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 05:44:25 -0400
Date: Mon, 19 Aug 2019 11:44:20 +0200
From: Simon Horman <horms@verge.net.au>
Message-ID: <20190819094420.33kzsgdixoejxd5m@verge.net.au>
References: <1566195612-11614-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566195612-11614-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v3] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Mon, Aug 19, 2019 at 03:20:12PM +0900, Yoshihiro Shimoda wrote:
> Since the rcar_pwm_apply() has already checked whether state->enabled
> is set or not, this patch removes a redundant condition.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> Changes from v2:
>  - Revise some typos in the commit log.
> https://patchwork.kernel.org/patch/11083353/
> 
> Changes from v1:
>  - Spin-off this independent patch (5/7).
>  - Add Geert and Uwe's Reviewed-by.
> https://patchwork.kernel.org/patch/11034743/
> 
>  drivers/pwm/pwm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 5b2b8ec..c8cd43f 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -187,7 +187,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
>  	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
>  
> -	if (!ret && state->enabled)
> +	if (!ret)
>  		ret = rcar_pwm_enable(rp);
>  
>  	return ret;
> -- 
> 2.7.4
> 
