From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] backlight: pwm: clean up pwm requested using legacy
 API
Date: Mon, 10 Nov 2014 10:01:29 +0000
Message-ID: <20141110100129.GK21424@x1>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: stable-owner@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Sat, 11 Oct 2014, Vladimir Zapolskiy wrote:

> If PWM device is requested by means of legacy API pwm_request(), its
> resources are not freed on module unbind, which may cause an oops on
> access, e.g. by reading /sys/kernel/debug/pwm.
>=20
> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/video/backlight/pwm_bl.c |    4 ++++
>  1 file changed, 4 insertions(+)

Applied with Thierry's Ack.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index dd7aaf7..40770dd 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -34,6 +34,7 @@ struct pwm_bl_data {
>  	struct regulator	*power_supply;
>  	struct gpio_desc	*enable_gpio;
>  	unsigned int		scale;
> +	bool			legacy;
>  	int			(*notify)(struct device *,
>  					  int brightness);
>  	void			(*notify_after)(struct device *,
> @@ -274,6 +275,7 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm) && !pdev->dev.of_node) {
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
> +		pb->legacy =3D true;
>  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
>  	}
> =20
> @@ -339,6 +341,8 @@ static int pwm_backlight_remove(struct platform_d=
evice *pdev)
> =20
>  	if (pb->exit)
>  		pb->exit(&pdev->dev);
> +	if (pb->legacy)
> +		pwm_free(pb->pwm);
> =20
>  	return 0;
>  }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
