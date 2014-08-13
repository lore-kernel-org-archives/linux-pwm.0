From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: remove .owner field for drivers using
 module_platform_driver
Date: Wed, 13 Aug 2014 14:12:32 +0100
Message-ID: <20140813131232.GA8258@lee--X1>
References: <1407933518-7214-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:43385 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbaHMNMj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Aug 2014 09:12:39 -0400
Received: by mail-qc0-f180.google.com with SMTP id l6so4128779qcy.11
        for <linux-pwm@vger.kernel.org>; Wed, 13 Aug 2014 06:12:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407933518-7214-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jg1.han@samsung.com, cooloney@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, thierry.reding@gmail.com, patches@linaro.org, linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org

On Wed, 13 Aug 2014, Peter Griffin wrote:

> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver or platform_driver_register api,
> as this is overriden in __platform_driver_register.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/video/backlight/88pm860x_bl.c    | 1 -
>  drivers/video/backlight/aat2870_bl.c     | 1 -
>  drivers/video/backlight/adp5520_bl.c     | 1 -
>  drivers/video/backlight/as3711_bl.c      | 1 -
>  drivers/video/backlight/da903x_bl.c      | 1 -
>  drivers/video/backlight/da9052_bl.c      | 1 -
>  drivers/video/backlight/ep93xx_bl.c      | 1 -
>  drivers/video/backlight/gpio_backlight.c | 1 -
>  drivers/video/backlight/lm3533_bl.c      | 1 -
>  drivers/video/backlight/lp8788_bl.c      | 1 -
>  drivers/video/backlight/max8925_bl.c     | 1 -
>  drivers/video/backlight/ot200_bl.c       | 1 -
>  drivers/video/backlight/pandora_bl.c     | 1 -
>  drivers/video/backlight/platform_lcd.c   | 1 -
>  drivers/video/backlight/pwm_bl.c         | 1 -
>  drivers/video/backlight/tps65217_bl.c    | 1 -
>  drivers/video/backlight/wm831x_bl.c      | 1 -
>  17 files changed, 17 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
