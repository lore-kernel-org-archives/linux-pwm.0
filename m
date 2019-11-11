From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: simplify error handling
Date: Mon, 11 Nov 2019 14:32:30 +0100
Message-ID: <a7a4656d-98b4-6bbb-e389-fe7028a38f97@web.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-2-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111090357.13903-2-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Neil Brown <neilb@suse.de>, Neil Armstrong <narmstrong@baylibre.com>, kernel@pengutronix.de, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> Implementation note: The put: label was never reached without a goto and
> ret being unequal to 0, so the removed return statement is fine.

This can look fine (in principle) because the label was repositioned here.
Do you really want to call the function =E2=80=9Cof_node_put=E2=80=9D at t=
wo places now?


> +++ b/drivers/pwm/pwm-omap-dmtimer.c
=E2=80=A6
>  	omap =3D devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
>  	if (!omap) {
> -		pdata->free(dm_timer);
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto err_alloc_omap;
>  	}
=E2=80=A6

I suggest to reconsider your label name selection according to
the Linux coding style.


> @@ -339,13 +334,28 @@ static int pwm_omap_dmtimer_probe(struct platform_=
device *pdev)
=E2=80=A6
> +err_pwmchip_add:
> +
> +	/*
> +	 * *omap is allocated using devm_kzalloc,
> +	 * so no free necessary here
> +	 */
> +err_alloc_omap:
> +
> +	pdata->free(dm_timer);

Would the use of the label =E2=80=9Cfree_dm_timer=E2=80=9D be more appropr=
iate?


> +put:
> +	of_node_put(timer);
=E2=80=A6

Can the label =E2=80=9Cput_node=E2=80=9D be nicer?

Regards,
Markus
