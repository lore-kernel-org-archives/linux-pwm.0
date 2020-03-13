From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] gpio: mvebu: avoid error message for optional IRQ
Date: Fri, 13 Mar 2020 16:07:49 +0100
Message-ID: <CAMpxmJVmspJG9tnv7tTrCP4DA5v4H_3P_4n-O-ZHkOKXgtXhLQ@mail.gmail.com>
References: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38465 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgCMPIE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Mar 2020 11:08:04 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so4727290qva.5
        for <linux-pwm@vger.kernel.org>; Fri, 13 Mar 2020 08:08:03 -0700 (PDT)
In-Reply-To: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

pt., 13 mar 2020 o 04:42 Chris Packham
<chris.packham@alliedtelesis.co.nz> napisa=C5=82(a):
>
> platform_get_irq() will generate an error message if the requested irq
> is not present
>
>   mvebu-gpio f1010140.gpio: IRQ index 3 not found
>
> use platform_get_irq_optional() to avoid the error message being
> generated.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/gpio/gpio-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index d2b999c7987f..3c9f4fb3d5a2 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -1247,7 +1247,7 @@ static int mvebu_gpio_probe(struct platform_device =
*pdev)
>          * pins.
>          */
>         for (i =3D 0; i < 4; i++) {
> -               int irq =3D platform_get_irq(pdev, i);
> +               int irq =3D platform_get_irq_optional(pdev, i);
>
>                 if (irq < 0)
>                         continue;
> --
> 2.25.1
>

Patch applied, thanks!

Bartosz
