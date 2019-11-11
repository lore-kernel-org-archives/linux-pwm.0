From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: put_device() after
 of_find_device_by_node()
Date: Mon, 11 Nov 2019 14:41:58 +0100
Message-ID: <812c95a0-7eb6-7ad6-16fa-c9e8339ff213@web.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Neil Brown <neilb@suse.de>, Neil Armstrong <narmstrong@baylibre.com>, kernel@pengutronix.de, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> This was found by coccicheck:
>
> 	drivers/pwm/pwm-omap-dmtimer.c:304:2-8: ERROR: missing put_device;
> 	call of_find_device_by_node on line 255, but without a corresponding
> 	object release within this function.

How do you think about to add a wording according to =E2=80=9Cimperative m=
ood=E2=80=9D
for your change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D31f4f5b495a62c9a8b15b1c358=
1acd5efeb9af8c#n151

=E2=80=A6
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
=E2=80=A6
> @@ -352,7 +352,14 @@ static int pwm_omap_dmtimer_probe(struct platform_d=
evice *pdev)
=E2=80=A6
>  	pdata->free(dm_timer);
> -put:
> +err_request_timer:
> +
> +err_timer_property:
> +err_platdata:
> +
> +	put_device(&timer_pdev->dev);

Would the use of the label =E2=80=9Cput_device=E2=80=9D be more appropriat=
e?


> +err_find_timer_pdev:
> +
>  	of_node_put(timer);
=E2=80=A6

Would the use of the label =E2=80=9Cput_node=E2=80=9D be better here?


> @@ -372,6 +379,8 @@ static int pwm_omap_dmtimer_remove(struct platform_d=
evice *pdev)
>
>  	omap->pdata->free(omap->dm_timer);
>
> +	put_device(&omap->dm_timer_pdev->dev);
> +
>  	mutex_destroy(&omap->mutex);
>
>  	return 0;

I suggest to omit a few blank lines.

Regards,
Markus
