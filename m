From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: Fix pwm enabling sequence
Date: Tue, 25 Feb 2020 10:32:20 +0530
Message-ID: <bac78775-4bee-7437-f5ef-3cf85997e7d1@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-3-lokeshvutla@ti.com>
 <20200224084956.wwsnf2y24ragg3vf@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58394 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYFDQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 00:03:16 -0500
In-Reply-To: <20200224084956.wwsnf2y24ragg3vf@pengutronix.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

Hi Uwe,

On 24/02/20 2:19 PM, Uwe Kleine-König wrote:
> On Mon, Feb 24, 2020 at 10:51:33AM +0530, Lokesh Vutla wrote:
>> To configure DM timer is pwm mode the following needs to be set in
>> OMAP_TIMER_CTRL_REG using set_pwm callback:
>> - Set toggle mode on PORTIMERPWM output pin
>> - Set trigger on overflow and match on PORTIMERPWM output pin.
>> - Set auto reload
>>
>> This is a one time configuration and needs to be set before the start of
>> the dm timer. But the current driver tries to set the same configuration
>> for every period/duty cycle update, which is not needed. So move the pwm
>> setup before enabling timer and do not update it in pwm_omap_dmtimer_config.
> 
> Is this change kind of moot with the conversion to .apply in the next
> patch?

Yes, but I didn't want to club it with the conversion to .apply as this is
functional change wrt to the existing driver.

Thanks and regards,
Lokesh
