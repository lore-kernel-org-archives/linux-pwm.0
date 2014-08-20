From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm-backlight: fix bogus request for GPIO#0 when
 instantiated from DT
Date: Wed, 20 Aug 2014 13:17:56 +0100
Message-ID: <20140820121756.GK4266@lee--X1>
References: <1408516716-28828-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35797 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbaHTMSC (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Aug 2014 08:18:02 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so11516369igq.1
        for <linux-pwm@vger.kernel.org>; Wed, 20 Aug 2014 05:18:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408516716-28828-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Wed, 20 Aug 2014, Lothar Wa=C3=9Fmann wrote:

> commit 257462dbf3ed ("pwm-backlight: switch to gpiod interface")
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

Applied to -fixes with Thierry's Ack and the blank line left.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index d7a3d13..e6ef6b4 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -172,7 +172,7 @@ static int pwm_backlight_parse_dt(struct device *=
dev,
>  		data->dft_brightness =3D value;
>  		data->max_brightness--;
>  	}
> -
> +	data->enable_gpio =3D -EINVAL;
>  	return 0;
>  }
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
