Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1400108.outbound.protection.outlook.com ([40.107.140.108]:3437
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbeLJFJi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 10 Dec 2018 00:09:38 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 10 Dec 2018 05:09:31 +0000
Message-ID: <OSBPR01MB2293ED3087627127A1A884A4D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207214932.xckuuarcka733v7y@pengutronix.de> <1828832.OCLkmioh6N@avalon>
In-Reply-To: <1828832.OCLkmioh6N@avalon>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: pwm: rcar: improve calculation of divider
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Uwe, Laurent,

Thank you very much for your patches!
I tested patches and both codes work correctly.

> From: Laurent Pinchart, Sent: Monday, December 10, 2018 5:55 AM
>=20
> Hi Uwe,
>=20
> On Friday, 7 December 2018 23:49:32 EET Uwe Kleine-K=F6nig wrote:
> > Hello,
> >
> > while looking at the driver I noticed another patch opportunity: In
> > rcar_pwm_get_clock_division() there is a loop:
> >
> > 	for (div =3D 0; div <=3D RCAR_PWM_MAX_DIVISION; div++) {
> > 		max =3D (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
> > 			(1 << div);
> > 		do_div(max, clk_rate);
> > 		if (period_ns <=3D max)
> > 			break;
> > 	}
> >
> > The value of div should be calculatable without a loop. Something like:
> >
> >    divider =3D NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
> >    tmp =3D (unsigned long long)period_ns * clk_rate + (divider - 1);
> >    do_div(tmp, divider);

This should be do_div64_u64() because the divider is 1,023,000,000,000 (ove=
r 32-bits).

> >    div =3D ilog2(tmp - 1) + 1;
> >
> > You might want to check if my maths are right, I didn't test.
>=20
> I've noticed the same, and wrote the following patch last week, also unte=
sted.
> I was planning to give it a try before sending it out, but as you've noti=
ced
> the same issue, here's the code if anyone wants to give it a try before I=
 can.
> Our calculations are similar, the main difference is the last line, and I
> think yours read better.

So, I'd like to apply Uwe's code to mainline. Uwe, may I send such a patch
with your author and Singed-off-by?

Best regards,
Yoshihiro Shimoda

> From 22f7149916f590d3dbcc673dacc738441c741900 Mon Sep 17 00:00:00 2001
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date: Sun, 25 Nov 2018 16:02:39 +0200
> Subject: [PATCH] pwm: rcar: Optimize rcar_pwm_get_clock_division()
>=20
> Get rid of the loop over all possible divisor values by computing the
> divisor directly.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---
>  drivers/pwm/pwm-rcar.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index a41812fc6f95..e6d73b94d5cf 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -68,21 +68,27 @@ static void rcar_pwm_update(struct rcar_pwm_chip *rp,=
 u32 mask, u32 data,
>  static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int per=
iod_ns)
>  {
>  	unsigned long clk_rate =3D clk_get_rate(rp->clk);
> -	unsigned long long max; /* max cycle / nanoseconds */
> -	unsigned int div;
> +	u64 max_period_ns;
> +	u32 div;
>=20
>  	if (clk_rate =3D=3D 0)
>  		return -EINVAL;
>=20
> -	for (div =3D 0; div <=3D RCAR_PWM_MAX_DIVISION; div++) {
> -		max =3D (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
> -			(1 << div);
> -		do_div(max, clk_rate);
> -		if (period_ns <=3D max)
> -			break;
> -	}
> +	/*
> +	 * The maximum achievable period is 2^24 * 1023 cycles of the internal
> +	 * bus clock.
> +	 */
> +	max_period_ns =3D (1ULL << RCAR_PWM_MAX_DIVISION) * RCAR_PWM_MAX_CYCLE
> +		      * NSEC_PER_SEC;
> +	do_div(max_period_ns, clk_rate);
> +
> +	if (period_ns > max_period_ns)
> +		return -ERANGE;
>=20
> -	return (div <=3D RCAR_PWM_MAX_DIVISION) ? div : -ERANGE;
> +	/* Calculate the divisor and round it up to the next power of two. */
> +	div =3D DIV64_U64_ROUND_UP((u64)period_ns * clk_rate,
> +				 (u64)RCAR_PWM_MAX_CYCLE * NSEC_PER_SEC);
> +	return fls(2 * div - 1) - 1;
>  }
>=20
>  static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,
>=20
> --
> Regards,
>=20
> Laurent Pinchart
>=20
>=20
