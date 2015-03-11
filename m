From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] backlight: pwm: handle EPROBE_DEFER while requesting
 the PWM
Date: Wed, 11 Mar 2015 13:48:34 +0100
Message-ID: <550039A2.9010307@atmel.com>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:58730 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbbCKMsk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2015 08:48:40 -0400
In-Reply-To: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, jg1.han@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Le 19/02/2015 10:30, Nicolas Ferre a =E9crit :
> When trying to request the PWM device with devm_pwm_get(), the EPROBE=
_DEFER
> flag is not handled properly. It can lead to the PWM not being found.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Any comment on this patch?
Can we see it included during next cycle (4.1)?

(aka ping).

Bye,


> ---
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index 3a145a643e0d..6897f1c1bc73 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -274,6 +274,10 @@ static int pwm_backlight_probe(struct platform_d=
evice *pdev)
> =20
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
> +		ret =3D PTR_ERR(pb->pwm);
> +		if (ret =3D=3D -EPROBE_DEFER)
> +			goto err_alloc;
> +
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		pb->legacy =3D true;
>  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
>=20


--=20
Nicolas Ferre
