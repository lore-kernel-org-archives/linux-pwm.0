Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51673 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGVtf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 16:49:35 -0500
Date: Fri, 7 Dec 2018 22:49:32 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20181207214932.xckuuarcka733v7y@pengutronix.de>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: pwm: rcar: improve calculation of divider
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello,

while looking at the driver I noticed another patch opportunity: In
rcar_pwm_get_clock_division() there is a loop:

	for (div =3D 0; div <=3D RCAR_PWM_MAX_DIVISION; div++) {
		max =3D (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
			(1 << div);
		do_div(max, clk_rate);
		if (period_ns <=3D max)
			break;
	}

The value of div should be calculatable without a loop. Something like:

   divider =3D NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
   tmp =3D (unsigned long long)period_ns * clk_rate + (divider - 1);
   do_div(tmp, divider);
   div =3D ilog2(tmp - 1) + 1;

You might want to check if my maths are right, I didn't test.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
