From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] pwm: jz4740: Drop dependency on MACH_INGENIC
Date: Sun, 24 May 2020 19:03:24 +0200
Message-ID: <20200524170324.hmjspuy5f26vi4je@pengutronix.de>
References: <20200413121445.72996-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgEXRDb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 13:03:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C20C061A0E
        for <linux-pwm@vger.kernel.org>; Sun, 24 May 2020 10:03:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200413121445.72996-1-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 02:14:43PM +0200, Paul Cercueil wrote:
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
> index eebbc917ac97..7814e5b2cad7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -234,7 +234,7 @@ config PWM_IMX_TPM
>  
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
> -	depends on MACH_INGENIC
> +	depends on MIPS

Looks good to me.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
