From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2 Resend] pwm: samsung: Fix output race on disabling
Date: Thu, 19 Mar 2015 10:19:13 +0100
Message-ID: <550A9491.8050302@collabora.co.uk>
References: <1425543243-6587-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:56219 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbCSJTV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2015 05:19:21 -0400
In-Reply-To: <1425543243-6587-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>

Hello Sjoerd,

On 03/05/2015 09:14 AM, Sjoerd Simons wrote:
> When disabling the samsung PWM the output state remains at the level it
> was in the end of a pwm cycle. In other words, calling pwm_disable when
> at 100% duty will keep the output active, while at all other setting the
> output will go/stay inactive. On top of that the samsung PWM settings are
> double-buffered, which means the new settings only get applied at the
> start of a new PWM cycle.
> 
> This results in a race if the PWM is at 100% duty and a driver calls:
>   pwm_config (pwm, 0, period);
>   pwm_disable (pwm);
> 
> In this case the PWMs output will unexpectedly stay active, unless a new
> PWM cycle happened to start between the register writes in _config and
> _disable. As far as i can tell this is a regression introduced by 3bdf878,
> before that a call to pwm_config would call pwm_samsung_enable which,
> while heavy-handed, made sure the expected settings were live.
> 
> To resolve this, while not re-introducing the issues 3bdf878 (flickering
> as the PWM got reset while in a PWM cycle). Only force an update of the
> settings when at 100% duty, which shouldn't have a noticeable effect on
> the output but is enough to ensure the behaviour is as expected on
> disable.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier

