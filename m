From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 0/6] clocksource: timer-ti-dm: Prepare for dynamic pwm
 period updates
Date: Thu, 12 Mar 2020 12:10:57 +0100
Message-ID: <f40cd563-c05b-90b6-c526-196fcd4fa146@linaro.org>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200306171917.GF37466@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20200306171917.GF37466@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-pwm@vger.kernel.org

On 06/03/2020 18:19, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [200305 08:29]:
>> This series fixes dm_timer_ops used for enabling the pwm and enables
>> cpu_pm notifier for context save and restore. This acts as a preparatory
>> series for enabling dynamic period updates for pwm omap dm timer driver.
>>
>> Changes since v2:
>> - Incorporated changes from Tony
> 
> I just gave this series another try here and it still works
> for me just fine and is good to go as far as I'm concerned.

How do you want this series to be merged?

Shall I pick the patches falling under drivers/clocksource or ack them?

> Thanks for doing this.
> 
> Regards,
> 
> Tony
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
