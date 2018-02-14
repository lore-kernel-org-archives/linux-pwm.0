From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 RESEND] pwm: imx: Let PWM be active during suspend
Date: Tue, 13 Feb 2018 23:48:25 -0200
Message-ID: <CAOMZO5Cr3HCXddDs_B6Yax4XLNwp+Ck6BMAnitXpURphTUX8Vg@mail.gmail.com>
References: <1514898119-19632-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40844 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966364AbeBNBs0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Feb 2018 20:48:26 -0500
Received: by mail-ot0-f194.google.com with SMTP id s4so19064278oth.7
        for <linux-pwm@vger.kernel.org>; Tue, 13 Feb 2018 17:48:26 -0800 (PST)
In-Reply-To: <1514898119-19632-1-git-send-email-fabio.estevam@nxp.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <lw@karo-electronics.de>, linux-pwm@vger.kernel.org

Hi Thierry,

On Tue, Jan 2, 2018 at 11:01 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
> On a imx6q-cubox-i board, which has an LED driven by PWM, when the system
> goes into suspend the PWM block is disabled by default, then the PWM pin
> goes to logic level zero and turn on the LED during suspend, which is not
> really the behaviour we want to see.
>
> By keeping the PWM enabled during suspend via STOPEN bit, the pwm-leds
> driver sets the brightness to zero in suspend and then the LED is
> turned off as expected.
>
> So always set the STOPEN to fix the PWM behaviour in suspend.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Hi Thierry,
>
> Resending it in the hope we can still get this in for 4.16.
>
> Please not that STOPEN is also unconditionally set in vendor's kernel:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/plat-mxc/pwm.c?h=imx_3.0.35_4.1.0#n106

We missed 4.16.

Can we get this one for 4.17?


>
>  drivers/pwm/pwm-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 2ba5c3a..08cbe81 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -35,6 +35,7 @@
>  #define MX3_PWMSAR                     0x0C    /* PWM Sample Register */
>  #define MX3_PWMPR                      0x10    /* PWM Period Register */
>  #define MX3_PWMCR_PRESCALER(x)         ((((x) - 1) & 0xFFF) << 4)
> +#define MX3_PWMCR_STOPEN               (1 << 25)
>  #define MX3_PWMCR_DOZEEN               (1 << 24)
>  #define MX3_PWMCR_WAITEN               (1 << 23)
>  #define MX3_PWMCR_DBGEN                        (1 << 22)
> @@ -210,7 +211,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
>                 writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>
>                 cr = MX3_PWMCR_PRESCALER(prescale) |
> -                    MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> +                    MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
>                      MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
>                      MX3_PWMCR_EN;
>
> --
> 2.7.4
>
