From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/7] pwm: jz4740: Drop dependency on MACH_INGENIC
Date: Fri, 9 Aug 2019 18:41:43 +0200
Message-ID: <20190809164143.2p573g7wlx43hero@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-4-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809123031.24219-4-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Aug 09, 2019 at 02:30:27PM +0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index d2557c6fcf65..82a75e0b72e5 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -224,7 +224,7 @@ config PWM_IMX_TPM
>  
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
> -	depends on MACH_INGENIC
> +	depends on MIPS

If this isn't actually useful on MIPS without MACH_INGENIC this is
better expressed using:

	depends on MIPS
	depends on MACH_INGENIC || COMPILE_TEST

This way some configuring a mips kernel without INGENIC isn't bothered
by this question.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
