Return-Path: <SRS0=oJbR=CF=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F1FC433DF
	for <linux-pwm@archiver.kernel.org>; Thu, 27 Aug 2020 20:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E3D20825
	for <linux-pwm@archiver.kernel.org>; Thu, 27 Aug 2020 20:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0UhQ (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:37:16 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19371 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgH0UhQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Aug 2020 16:37:16 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Aug 2020 13:37:16 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 27 Aug 2020 13:37:16 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id CAD1A1924; Thu, 27 Aug 2020 13:37:15 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:37:15 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: Allow store 64-bit duty cycle from sysfs interface
Message-ID: <20200827203715.GA18739@codeaurora.org>
References: <20200824145539.3160946-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145539.3160946-1-jarkko.nikula@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 05:55:39PM +0300, Jarkko Nikula wrote:
> PWM core was converted to u64 by the commit a9d887dc1c60 ("pwm: Convert
> period and duty cycle to u64") but did not change the duty_cycle_store()
> so it will error out if trying to pass a numeric string bigger than
> 2^32-1.
> 
> Fix this by using u64 and kstrtou64() in duty_cycle_store().
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Guru Das Srinagesh <gurus@codeaurora.org>

I'd made the change to period_store(), but had missed doing the same for
duty_cycle_store(). Thanks Jarkko for catching this.

Guru Das.

> ---
> I don't think this qualifies for a Fixes tag since original commit doesn't
> cause a regression while still might be good for v5.9 material.
> ---
>  drivers/pwm/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 449dbc0f49ed..9903c3a7eced 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -87,10 +87,10 @@ static ssize_t duty_cycle_store(struct device *child,
>  	struct pwm_export *export = child_to_pwm_export(child);
>  	struct pwm_device *pwm = export->pwm;
>  	struct pwm_state state;
> -	unsigned int val;
> +	u64 val;
>  	int ret;
>  
> -	ret = kstrtouint(buf, 0, &val);
> +	ret = kstrtou64(buf, 0, &val);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.28.0
> 
