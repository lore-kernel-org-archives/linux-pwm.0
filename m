From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm: handle EPROBE_DEFER while requesting the
 PWM
Date: Thu, 12 Mar 2015 09:02:24 +0000
Message-ID: <20150312090224.GC3314@x1>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, jg1.han@samsung.com, linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 19 Feb 2015, Nicolas Ferre wrote:

> When trying to request the PWM device with devm_pwm_get(), the EPROBE=
_DEFER
> flag is not handled properly. It can lead to the PWM not being found.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

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

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
