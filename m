Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56941 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLJXF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Mar 2019 05:23:05 -0400
Date: Tue, 12 Mar 2019 10:23:02 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190312092302.2x6zf4imlfsevmkr@pengutronix.de>
References: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: Avoid deadlock warning when removing PWM device
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Phong Hoang <phong.hoang.wz@renesas.com>

On Tue, Mar 12, 2019 at 12:16:34PM +0900, Yoshihiro Shimoda wrote:
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..2fdd6611 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -311,10 +311,12 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_add(chip);
> =20
> -	pwmchip_sysfs_export(chip);
> -
>  out:
>  	mutex_unlock(&pwm_lock);
> +
> +	if (!ret)
> +		pwmchip_sysfs_export(chip);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pwmchip_add_with_polarity);
> @@ -368,10 +370,12 @@ int pwmchip_remove(struct pwm_chip *chip)
> =20
>  	free_pwms(chip);
> =20
> -	pwmchip_sysfs_unexport(chip);
> -
>  out:
>  	mutex_unlock(&pwm_lock);
> +
> +	if (!ret)
> +		pwmchip_sysfs_unexport(chip);
> +

I wonder if this needs to be done before free_pwms is called. Otherwise
the pwmchip is already gone and then something is requested via sysfs.

Also a comment about why it is important not to unexport while holding
the lock would be great.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
