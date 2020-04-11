From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
Date: Sat, 11 Apr 2020 18:37:36 +0200
Message-ID: <20200411163736.mcxk5ujzjy5mzjib@pengutronix.de>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33547 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgDKQhi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Apr 2020 12:37:38 -0400
Content-Disposition: inline
In-Reply-To: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello,

On Sat, Apr 11, 2020 at 05:35:28PM +0200, Christophe JAILLET wrote:
> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
> 
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 9973c442b455..bca04965bfe6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -537,7 +537,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
>  
>  	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
>  		dev_warn(chip->dev,
> -			 "requested disabled, but yielded enabled with duty > 0");
> +			 "requested disabled, but yielded enabled with duty > 0\n");

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
