From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm-backlight:
Date: Fri, 6 Jun 2014 13:42:30 +0100
Message-ID: <20140606124230.GQ24240@lee--X1>
References: <1402052529-22761-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:52055 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbaFFMmi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Jun 2014 08:42:38 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so775897ieb.22
        for <linux-pwm@vger.kernel.org>; Fri, 06 Jun 2014 05:42:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402052529-22761-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Fri, 06 Jun 2014, Lothar Wa=C3=9Fmann wrote:

> commit 257462dbf3ed pwm-backlight: switch to gpiod interface
> introduced a regression leading to acquiring a bogus GPIO-0 when
> configured from DT without an 'enable-gpios' property.
> The driver will happily accept the 0 initialized 'enable_gpio' member
> of the struct platform_pwm_backlight_data as valid gpio number, and
> request this GPIO as enable pin. In case of multiple driver instances=
,
> the second will fail to register with the error message:
> pwm-backlight backlight1.23: failed to request GPIO#0: -16
>=20
> Fix this by setting enable_gpio in the pdata struct to -EINVAL.
>=20
> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> ---
>  drivers/video/backlight/pwm_bl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index 38ca88b..3d265c4 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *=
dev,
>  		data->dft_brightness =3D value;
>  		data->max_brightness--;
>  	}
> -
> +	data->enable_gpio =3D -EINVAL;
>  	return 0;
>  }

This patch doesn't look like it will apply.  I suggest you pull
v3.17-rc1 when it lands and rebase your patch.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
