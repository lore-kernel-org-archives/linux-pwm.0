Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B4DC433B4
	for <linux-pwm@archiver.kernel.org>; Wed, 31 Mar 2021 20:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8093960FEF
	for <linux-pwm@archiver.kernel.org>; Wed, 31 Mar 2021 20:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhCaUjn (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 31 Mar 2021 16:39:43 -0400
Received: from mleia.com ([178.79.152.223]:58470 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236418AbhCaUjJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 31 Mar 2021 16:39:09 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2021 16:39:09 EDT
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 5405144DD41;
        Wed, 31 Mar 2021 20:32:58 +0000 (UTC)
Subject: Re: [PATCH] pwm: lpc3200: Don't modify HW state in .remove callback
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20210329064111.148508-1-u.kleine-koenig@pengutronix.de>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <e272a75e-ef6d-182e-affa-12f03dbcccdc@mleia.com>
Date:   Wed, 31 Mar 2021 23:32:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210329064111.148508-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20210331_203258_365025_39A016CF 
X-CRM114-Status: GOOD (  18.20  )
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 3/29/21 9:41 AM, Uwe Kleine-König wrote:
> A consumer is expected to disable a PWM before calling pwm_put(). And if
> they didn't there is hopefully a good reason (or the consumer needs
> fixing). Also if disabling an enabled PWM was the right thing to do,
> this should better be done in the framework instead of in each low level
> driver.
> 
> So drop the hardware modification from the .remove() callback.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/pwm/pwm-lpc32xx.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
> index c42cc314c170..2834a0f001d3 100644
> --- a/drivers/pwm/pwm-lpc32xx.c
> +++ b/drivers/pwm/pwm-lpc32xx.c
> @@ -136,10 +136,6 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
>   static int lpc32xx_pwm_remove(struct platform_device *pdev)
>   {
>   	struct lpc32xx_pwm_chip *lpc32xx = platform_get_drvdata(pdev);
> -	unsigned int i;
> -
> -	for (i = 0; i < lpc32xx->chip.npwm; i++)
> -		pwm_disable(&lpc32xx->chip.pwms[i]);
>   
>   	return pwmchip_remove(&lpc32xx->chip);
>   }
> 

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

I've briefly checked other PWM drivers, some of them do contain the same
logic, for instance please check pwm-stm32.c, pwm-stm32-lp.c

Many other drivers disable at least the controller clock, I believe there
should be a clear agreed policy, it makes no sense to vary the behaviour
among the drivers, thus likely all the drivers should be checked and fixed
at one series, thanks.

--
Best wishes,
Vladimir
