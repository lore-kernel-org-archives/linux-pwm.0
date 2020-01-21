From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ARM: s3c24xx/rx1950: switch to atomic pwm API
Date: Tue, 21 Jan 2020 20:59:11 +0100
Message-ID: <20200121195911.GA24380@kozik-lap>
References: <20200120193328.17007-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46174 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgAUT7Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jan 2020 14:59:16 -0500
Content-Disposition: inline
In-Reply-To: <20200120193328.17007-1-uwe@kleine-koenig.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Kukjin Kim <kgene@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org

On Mon, Jan 20, 2020 at 08:33:28PM +0100, Uwe Kleine-König wrote:
> Stop using the legacy PWM API which only still exists because there are
> some users left.
> 
> Note this change make use of the fact that the value of struct
> pwm_state::duty_cycle doesn't matter for a disabled PWM and so its value
> can stay constant simplifying the code a bit.
> 
> A side effect of the conversion is that the pwm isn't stopped in
> rx1950_backlight_init() by the call to pwm_apply_args() just before
> reenabling it when rx1950_lcd_power(1) is called.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 19 ++++++++++++-------

Thanks, applied.

Best regards,
Krzysztof
