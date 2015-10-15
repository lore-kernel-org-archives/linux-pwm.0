From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] backlight: pwm: reject legacy pwm request for device
 defined in dt
Date: Thu, 15 Oct 2015 12:03:09 +0100
Message-ID: <20151015110309.GB31804@x1>
References: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33648 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbJOLDO (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Oct 2015 07:03:14 -0400
Received: by wijp11 with SMTP id p11so23655051wij.0
        for <linux-pwm@vger.kernel.org>; Thu, 15 Oct 2015 04:03:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 12 Oct 2015, Vladimir Zapolskiy wrote:

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

Applied, thanks.

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

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
