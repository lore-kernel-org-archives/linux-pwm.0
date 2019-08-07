Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 07 Aug 2019 15:53:55 +0200
From: Paul Cercueil <paul@crapouillou.net>
Message-Id: <1565186035.1834.1@crapouillou.net>
In-Reply-To: <20190730123229.31839-1-u.kleine-koenig@pengutronix.de>
References: <1564435163.6633.4@crapouillou.net>
 <20190730123229.31839-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: jz4740: document known limitations
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>



Le mar. 30 juil. 2019 =E0 14:32, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> The jz4740 PMW implementation doesn't fulfill the (up to now
> insufficiently documented) requirements of the PWM API. At least
> document them in the driver.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

> ---
> I intended to also add a Link to the reference manual, Paul suggested=20
> to
> use https://zcrc.me/~paul/jz_docs/ in December last year, but this
> stopped to work.
>=20
> The second item is something I noticed when reading through the=20
> manual,
> but it's not confirmed in practise. A test that this is indeed the=20
> case
> could be done by configuring a long period (say 5s) and a (in
> comparison) small duty-cycle (say 1s). If the pwm output isn't active
> when the call returns I'd consider this proven.
>=20
> @Paul: would you mind doing this test?
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-jz4740.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index f901e8a0d33d..9d444d012f92 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -2,6 +2,11 @@
>  /*
>   *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
>   *  JZ4740 platform PWM support
> + *
> + * Limitations:
> + * - The .apply callback doesn't complete the currently running=20
> period before
> + *   reconfiguring the hardware.
> + * - Each period starts with the inactive part.
>   */
>=20
>  #include <linux/clk.h>
> --
> 2.20.1
>=20

=
