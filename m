Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33777 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGJAD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 04:00:03 -0500
Date: Fri, 7 Dec 2018 10:00:01 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20181207090001.vk4rqzgnbuafdp43@pengutronix.de>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544171373-29618-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/5] pwm: rcar: add rcar_pwm_calc_counter() to calculate
 PWMCNT value only
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello,

On Fri, Dec 07, 2018 at 05:29:29PM +0900, Yoshihiro Shimoda wrote:
> -static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int d=
uty_ns,
> -				int period_ns)
> +static void rcar_pwm_calc_counter(struct rcar_pwm_chip *rp, int div,
> +				  int duty_ns, int period_ns)
>  {
>  	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
>  	unsigned long clk_rate =3D clk_get_rate(rp->clk);
> @@ -120,11 +121,17 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chi=
p *rp, int div, int duty_ns,
>  	do_div(tmp, one_cycle);
>  	ph =3D tmp & RCAR_PWMCNT_PH0_MASK;
> =20
> +	rp->pwmcnt =3D cyc | ph;

Wouldn't it be more natural to let rcar_pwm_calc_counter return cyc | ph
and then ...

> +}
> +
> +static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp)
> +{
>  	/* Avoid prohibited setting */
> -	if (cyc =3D=3D 0 || ph =3D=3D 0)
> +	if ((rp->pwmcnt & RCAR_PWMCNT_CYC0_MASK) =3D=3D 0 ||
> +	    (rp->pwmcnt & RCAR_PWMCNT_PH0_MASK) =3D=3D 0)
>  		return -EINVAL;
> =20
> -	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> +	rcar_pwm_write(rp, rp->pwmcnt, RCAR_PWMCNT);
> =20
>  	return 0;
>  }
> @@ -159,7 +166,8 @@ static int rcar_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
> =20
>  	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> =20
> -	ret =3D rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
> +	rcar_pwm_calc_counter(rp, div, duty_ns, period_ns);
> +	ret =3D rcar_pwm_set_counter(rp);
>  	if (!ret)
>  		rcar_pwm_set_clock_control(rp, div);

... pass this value to rcar_pwm_set_counter as u32. (Or pass div,
duty_ns and period_ns to rcar_pwm_set_counter and let this then call
rcar_pwm_calc_counter. Then you don't need a new member in the struct
rcar_pwm_chip.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
