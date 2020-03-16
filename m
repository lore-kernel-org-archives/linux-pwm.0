From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 0/6] clocksource: timer-ti-dm: Prepare for dynamic pwm
 period updates
Date: Mon, 16 Mar 2020 13:41:34 +0100
Message-ID: <c931549a-6bc1-454d-ca2f-c5d977727f01@linaro.org>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200306171917.GF37466@atomide.com>
 <f40cd563-c05b-90b6-c526-196fcd4fa146@linaro.org>
 <20200312172659.GZ37466@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35411 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgCPMli (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 08:41:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so17865820wmi.0
        for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2020 05:41:37 -0700 (PDT)
In-Reply-To: <20200312172659.GZ37466@atomide.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>


Hi Tony,

On 12/03/2020 18:26, Tony Lindgren wrote:
> Hi,
> 
> * Daniel Lezcano <daniel.lezcano@linaro.org> [200312 11:11]:
>> On 06/03/2020 18:19, Tony Lindgren wrote:
>>> * Lokesh Vutla <lokeshvutla@ti.com> [200305 08:29]:
>>>> This series fixes dm_timer_ops used for enabling the pwm and enables
>>>> cpu_pm notifier for context save and restore. This acts as a preparatory
>>>> series for enabling dynamic period updates for pwm omap dm timer driver.
>>>>
>>>> Changes since v2:
>>>> - Incorporated changes from Tony
>>>
>>> I just gave this series another try here and it still works
>>> for me just fine and is good to go as far as I'm concerned.
>>
>> How do you want this series to be merged?
>>
>> Shall I pick the patches falling under drivers/clocksource or ack them?
> 
> I think best would be if you picked them and applied them into
> an immutable branch against v5.6-rc1 that can also be merged
> into pwm driver branch as needed.

Immutable branch based on v5.6-rc1:


https://git.linaro.org/people/dlezcano/linux.git/log/?h=timers/drivers/timer-ti-dm

and merged to timers/drivers/next:


https://git.linaro.org/people/dlezcano/linux.git/log/?h=timers/drivers/next

with a small conflict (fixed) with:


https://git.linaro.org/people/dlezcano/linux.git/commit/?h=timers/drivers/next&id=6ce4fcb015a1a1290ffafcf3554901b40f9322df

Regards

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
