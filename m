From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 3/6] clocksource: timer-ti-dm: Implement cpu_pm
 notifier for context save and restore
Date: Mon, 16 Mar 2020 11:51:35 +0100
Message-ID: <5b7bd5f8-f4e3-b851-da3e-8f05386dce09@linaro.org>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200305082715.15861-4-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54922 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgCPKvl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:51:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so17080149wmc.4
        for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2020 03:51:38 -0700 (PDT)
In-Reply-To: <20200305082715.15861-4-lokeshvutla@ti.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>

On 05/03/2020 09:27, Lokesh Vutla wrote:
> omap_dm_timer_enable() restores the entire context(including counter)
> based on 2 conditions:
> - If get_context_loss_count is populated and context is lost.
> - If get_context_loss_count is not populated update unconditionally.
> 
> Case2 has a side effect of updating the counter register even though
> context is not lost. When timer is configured in pwm mode, this is
> causing undesired behaviour in the pwm period.
> 
> Instead of using get_context_loss_count call back, implement cpu_pm
> notifier with context save and restore support. And delete the
> get_context_loss_count callback all together.
> 
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> [tony@atomide.com: removed pm_runtime calls from cpuidle calls]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

[ ... ]

> @@ -725,6 +728,12 @@ static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
>  
>  	atomic_set(&timer->enabled, 0);
>  
> +	if (timer->capability & OMAP_TIMER_ALWON ||
> +	    !timer->func_base)
> +	    return 0;

WARNING: suspect code indent for conditional statements (8, 12)
#168: FILE: drivers/clocksource/timer-ti-dm.c:762:
+	if (timer->capability & OMAP_TIMER_ALWON ||
[...]
+	    return 0;


WARNING: Statements should start on a tabstop
#170: FILE: drivers/clocksource/timer-ti-dm.c:764:
+	    return 0;

[ ... ]


Mind to resend this patch with the warning fixed?

Thanks

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
