From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
Date: Fri, 23 Sep 2016 16:03:53 +0200
Message-ID: <d68427df-a3ec-0a74-9bb5-c86ca60a1c2e@schinagl.nl>
References: <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <CANwerB2LwWShNEUmNNbuH_4GY90gSpVmrxbC+oLK4p51cxUe2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:40164 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757894AbcIWOD6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 23 Sep 2016 10:03:58 -0400
In-Reply-To: <CANwerB2LwWShNEUmNNbuH_4GY90gSpVmrxbC+oLK4p51cxUe2g@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Liu <net147@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hey Jonathan,


On 23-09-16 16:02, Jonathan Liu wrote:
> On 26 August 2016 at 03:50,  <oliver@schinagl.nl> wrote:
>> When we inform the PWM block to stop toggeling the output, we may end up
>> in a state where the output is not what we would expect (e.g. not the
>> low-pulse) but whatever the output was at when the clock got disabled.
>>
>> To counter this we have to wait for maximally the time of one whole
>> period to ensure the pwm hardware was able to finish. Since we already
>> told the PWM hardware to disable it self, it will not continue toggling
>> but merly finish its current pulse.
>>
>> If a whole period is considered to much, it may be contemplated to use a
>> half period + a little bit to ensure we get passed the transition.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>   drivers/pwm/pwm-sun4i.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
>> index 03a99a5..5e97c8a 100644
>> --- a/drivers/pwm/pwm-sun4i.c
>> +++ b/drivers/pwm/pwm-sun4i.c
>> @@ -8,6 +8,7 @@
>>
>>   #include <linux/bitops.h>
>>   #include <linux/clk.h>
>> +#include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>> @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>>          spin_lock(&sun4i_pwm->ctrl_lock);
>>          val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>>          val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
>> +       sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
>> +       spin_unlock(&sun4i_pwm->ctrl_lock);
>> +
>> +       /* Allow for the PWM hardware to finish its last toggle. The pulse
>> +        * may have just started and thus we should wait a full period.
>> +        */
>> +       ndelay(pwm_get_period(pwm));
>> +
>> +       spin_lock(&sun4i_pwm->ctrl_lock);
>> +       val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>>          val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>>          sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
>>          spin_unlock(&sun4i_pwm->ctrl_lock);
> I had some issues where setting the brightness for pwm-backlight to 0
> was not turning off the backlight sometimes.
> This patch fixes the issue for me. Thanks.
You are welcome, but there's some work still being done in this regard, 
or rather, i have to find time to grab a scope and properly check the 
output. So expect the proper fix to be coming to a kernel near you soon :)

Meanwhile, it seems to still confirm that this is needed. Thanks on that.

Olliver
>
> Tested-by: Jonathan Liu <net147@gmail.com>
