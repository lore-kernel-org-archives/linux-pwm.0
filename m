From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 04/12] backlight: pwm_bl: remove useless call to
 pwm_set_period
Date: Tue, 22 Sep 2015 23:12:18 +0100
Message-ID: <20150922221218.GA9317@x1>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-5-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34895 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbIVWMa (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Sep 2015 18:12:30 -0400
Received: by pacfv12 with SMTP id fv12so21096010pac.2
        for <linux-pwm@vger.kernel.org>; Tue, 22 Sep 2015 15:12:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442828009-6241-5-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@google.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutron>

On Mon, 21 Sep 2015, Boris Brezillon wrote:

> The PWM period will be set when calling pwm_config. Remove this usele=
ss
> call to pwm_set_period, which might mess up with the initial PWM stat=
e
> once we have added proper support for PWM init state retrieval.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index ae498c1..71944f8 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -293,12 +293,14 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
>  	 * period, parsed from the DT, in the PWM device. For the non-DT ca=
se,
>  	 * set the period from platform data if it has not already been set
>  	 * via the PWM lookup table.
> +	 * FIXME: This assignment should be dropped as soon as all the boar=
ds
> +	 * have moved to the PWM lookup table approach. The same goes for t=
he
> +	 * pb->period field which should be replaced by
> +	 * pwm_get_default_period() calls.
>  	 */
>  	pb->period =3D pwm_get_default_period(pb->pwm);
> -	if (!pb->period && (data->pwm_period_ns > 0)) {
> +	if (!pb->period && (data->pwm_period_ns > 0))
>  		pb->period =3D data->pwm_period_ns;
> -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> -	}
> =20
>  	pb->lth_brightness =3D data->lth_brightness * (pb->period / pb->sca=
le);
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
