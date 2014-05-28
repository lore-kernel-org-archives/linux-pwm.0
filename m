From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] pwm: i.MX: Cleanup indentation for register definitions
Date: Wed, 28 May 2014 11:56:36 +0200
Message-ID: <20140528115636.4ad791aa@ipc1.ka-ro>
References: <1401185980-29536-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:51190 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbaE1J4l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 28 May 2014 05:56:41 -0400
In-Reply-To: <1401185980-29536-1-git-send-email-Ying.Liu@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Liu Ying <Ying.Liu@freescale.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, s.hauer@pengutronix.de, shawn.guo@freescale.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi,

Liu Ying wrote:
> This patch contains no logic change to cleanup indentation
> for register definitions only.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
>  drivers/pwm/pwm-imx.c |   26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index cc47733..0784554 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -21,24 +21,24 @@
> =20
>  /* i.MX1 and i.MX21 share the same PWM function block: */
> =20
> -#define MX1_PWMC    0x00   /* PWM Control Register */
> -#define MX1_PWMS    0x04   /* PWM Sample Register */
> -#define MX1_PWMP    0x08   /* PWM Period Register */
> +#define MX1_PWMC			0x00   /* PWM Control Register */
> +#define MX1_PWMS			0x04   /* PWM Sample Register */
> +#define MX1_PWMP			0x08   /* PWM Period Register */
> =20
> -#define MX1_PWMC_EN		(1 << 4)
> +#define MX1_PWMC_EN			(1 << 4)
> =20
>  /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
> =20
> -#define MX3_PWMCR                 0x00    /* PWM Control Register */
> -#define MX3_PWMSAR                0x0C    /* PWM Sample Register */
> -#define MX3_PWMPR                 0x10    /* PWM Period Register */
> -#define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
> -#define MX3_PWMCR_DOZEEN                (1 << 24)
> -#define MX3_PWMCR_WAITEN                (1 << 23)
> +#define MX3_PWMCR			0x00    /* PWM Control Register */
> +#define MX3_PWMSAR			0x0C    /* PWM Sample Register */
> +#define MX3_PWMPR			0x10    /* PWM Period Register */
> +#define MX3_PWMCR_PRESCALER(x)		(((x - 1) & 0xFFF) << 4)
                                                   ^
You could also add the missing () around the macro argument when you
are changing this line anyway.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
