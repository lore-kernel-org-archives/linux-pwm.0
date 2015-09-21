From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm: free pwm requested by legacy API on
 error path
Date: Tue, 22 Sep 2015 00:23:38 +0100
Message-ID: <20150921232338.GG11284@x1>
References: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35126 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbbIUXXq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2015 19:23:46 -0400
Received: by pacfv12 with SMTP id fv12so132124371pac.2
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2015 16:23:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sun, 14 Jun 2015, Vladimir Zapolskiy wrote:

> If pwm is requested by legacy pwm_request() and if the following
> backlight_device_register() call fails, add pwm_free() clean-up.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index 9991cdb..a691247 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -307,6 +307,8 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		ret =3D PTR_ERR(bl);
> +		if (pb->legacy)
> +			pwm_free(pb->pwm);
>  		goto err_alloc;
>  	}
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
