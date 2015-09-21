From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm: reject legacy pwm request for device
 defined in dt
Date: Tue, 22 Sep 2015 00:22:25 +0100
Message-ID: <20150921232225.GF11284@x1>
References: <1434292172-22129-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36026 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbbIUXWn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2015 19:22:43 -0400
Received: by padbj2 with SMTP id bj2so4448844pad.3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2015 16:22:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434292172-22129-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sun, 14 Jun 2015, Vladimir Zapolskiy wrote:

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
> ---
>  drivers/video/backlight/pwm_bl.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index 57cb9ec..9991cdb 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -271,15 +271,16 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
>  	}
> =20
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> -	if (IS_ERR(pb->pwm)) {
> +	if (IS_ERR(pb->pwm) && !pdev->dev.of_node) {
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
> +		dev_err(&pdev->dev, "unable to request PWM\n");
> +		ret =3D PTR_ERR(pb->pwm);
> +		goto err_alloc;
>  	}
> =20
>  	dev_dbg(&pdev->dev, "got pwm for backlight\n");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
