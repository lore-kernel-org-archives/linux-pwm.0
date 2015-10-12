From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2] backlight: pwm: reject legacy pwm request for device
 defined in dt
Date: Mon, 12 Oct 2015 15:16:44 +0200
Message-ID: <561BB2BC.9090907@atmel.com>
References: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:23622 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbJLNRX (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Oct 2015 09:17:23 -0400
In-Reply-To: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Le 12/10/2015 14:29, Vladimir Zapolskiy a =E9crit :
> Platform PWM backlight data provided by board's device tree should be
> complete enough to successfully request a pwm device using pwm_get()
> API. This change fixes a bug, when an arbitrary (first found) PWM is
> connected to a "pwm-backlight" compatible device, when explicit PWM
> device reference is not given.
>=20
> Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> already describes "pwms" as a required property, instead of blind
> selection of a potentially wrong PWM reject legacy PWM device
> registration request, leave legacy API only for non-dt cases.
>=20
> Based on initial implementation done by Dmitry Eremin-Solenikov.
>=20
> Reported-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

It seems good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

(Adding some people to the Cc: list).


> ---
> The change is based on lee-backlight/for-backlight-next
>=20
> Changes from v1 to v2:
> * rebased on top of Nicolas' commit
>     68feaca0b13 ("backlight: pwm: Handle EPROBE_DEFER while requestin=
g the PWM")
>=20
> Links to previous discussions of the change:
> * https://patchwork.ozlabs.org/patch/483993/
> * https://patchwork.ozlabs.org/patch/398849/
>=20
>  drivers/video/backlight/pwm_bl.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index eff379b..ae3c6b6 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -271,19 +271,18 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
>  	}
> =20
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> -	if (IS_ERR(pb->pwm)) {
> -		ret =3D PTR_ERR(pb->pwm);
> -		if (ret =3D=3D -EPROBE_DEFER)
> -			goto err_alloc;
> -
> +	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER
> +	    && !pdev->dev.of_node) {
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		pb->legacy =3D true;
>  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> -		if (IS_ERR(pb->pwm)) {
> -			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> -			ret =3D PTR_ERR(pb->pwm);
> -			goto err_alloc;
> -		}
> +	}
> +
> +	if (IS_ERR(pb->pwm)) {
> +		ret =3D PTR_ERR(pb->pwm);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "unable to request PWM\n");
> +		goto err_alloc;
>  	}
> =20
>  	dev_dbg(&pdev->dev, "got pwm for backlight\n");
>=20


--=20
Nicolas Ferre
