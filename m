Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([213.167.242.64]:53182 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeLIUyY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Dec 2018 15:54:24 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 09 Dec 2018 22:55:00 +0200
Message-ID: <1828832.OCLkmioh6N@avalon>
In-Reply-To: <20181207214932.xckuuarcka733v7y@pengutronix.de>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <20181207214932.xckuuarcka733v7y@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: pwm: rcar: improve calculation of divider
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Uwe,

On Friday, 7 December 2018 23:49:32 EET Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> while looking at the driver I noticed another patch opportunity: In
> rcar_pwm_get_clock_division() there is a loop:
>=20
> 	for (div =3D 0; div <=3D RCAR_PWM_MAX_DIVISION; div++) {
> 		max =3D (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
> 			(1 << div);
> 		do_div(max, clk_rate);
> 		if (period_ns <=3D max)
> 			break;
> 	}
>=20
> The value of div should be calculatable without a loop. Something like:
>=20
>    divider =3D NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
>    tmp =3D (unsigned long long)period_ns * clk_rate + (divider - 1);
>    do_div(tmp, divider);
>    div =3D ilog2(tmp - 1) + 1;
>=20
> You might want to check if my maths are right, I didn't test.

I've noticed the same, and wrote the following patch last week, also untest=
ed.
I was planning to give it a try before sending it out, but as you've noticed
the same issue, here's the code if anyone wants to give it a try before I c=
an.
Our calculations are similar, the main difference is the last line, and I
think yours read better.

=46rom 22f7149916f590d3dbcc673dacc738441c741900 Mon Sep 17 00:00:00 2001
=46rom: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 25 Nov 2018 16:02:39 +0200
Subject: [PATCH] pwm: rcar: Optimize rcar_pwm_get_clock_division()

Get rid of the loop over all possible divisor values by computing the
divisor directly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
=2D--
 drivers/pwm/pwm-rcar.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index a41812fc6f95..e6d73b94d5cf 100644
=2D-- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -68,21 +68,27 @@ static void rcar_pwm_update(struct rcar_pwm_chip *rp, u=
32 mask, u32 data,
 static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int perio=
d_ns)
 {
 	unsigned long clk_rate =3D clk_get_rate(rp->clk);
=2D	unsigned long long max; /* max cycle / nanoseconds */
=2D	unsigned int div;
+	u64 max_period_ns;
+	u32 div;
=20
 	if (clk_rate =3D=3D 0)
 		return -EINVAL;
=20
=2D	for (div =3D 0; div <=3D RCAR_PWM_MAX_DIVISION; div++) {
=2D		max =3D (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
=2D			(1 << div);
=2D		do_div(max, clk_rate);
=2D		if (period_ns <=3D max)
=2D			break;
=2D	}
+	/*
+	 * The maximum achievable period is 2^24 * 1023 cycles of the internal
+	 * bus clock.
+	 */
+	max_period_ns =3D (1ULL << RCAR_PWM_MAX_DIVISION) * RCAR_PWM_MAX_CYCLE
+		      * NSEC_PER_SEC;
+	do_div(max_period_ns, clk_rate);
+
+	if (period_ns > max_period_ns)
+		return -ERANGE;
=20
=2D	return (div <=3D RCAR_PWM_MAX_DIVISION) ? div : -ERANGE;
+	/* Calculate the divisor and round it up to the next power of two. */
+	div =3D DIV64_U64_ROUND_UP((u64)period_ns * clk_rate,
+				 (u64)RCAR_PWM_MAX_CYCLE * NSEC_PER_SEC);
+	return fls(2 * div - 1) - 1;
 }
=20
 static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,

=2D-=20
Regards,

Laurent Pinchart
