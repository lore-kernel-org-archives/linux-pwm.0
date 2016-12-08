Return-Path: <oliver@schinagl.nl>
From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
Message-ID: <afcb938d-d2df-4740-6c85-cdf2766f671c@schinagl.nl>
Date: Thu, 8 Dec 2016 14:23:39 +0100
MIME-Version: 1.0
In-Reply-To: <20160826221900.GG3165@lukather>
Content-Type: multipart/alternative;
 boundary="------------D52D118D5E92C70C5E460C2E"
List-ID: <linux-pwm.vger.kernel.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D52D118D5E92C70C5E460C2E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hey Maxime,

first off, also sorry for the slow delay :) (pun not intended)

On 27-08-16 00:19, Maxime Ripard wrote:
> On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
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
>> Signed-off-by: Olliver Schinagl<oliver@schinagl.nl>
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
>>   	spin_lock(&sun4i_pwm->ctrl_lock);
>>   	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>>   	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
>> +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
>> +	spin_unlock(&sun4i_pwm->ctrl_lock);
>> +
>> +	/* Allow for the PWM hardware to finish its last toggle. The pulse
>> +	 * may have just started and thus we should wait a full period.
>> +	 */
>> +	ndelay(pwm_get_period(pwm));
> Can't that use the ready bit as well?

I started to implement our earlier discussed suggestions, but I do not 
think they will work. The read bit is not to let the user know it is 
ready with all of its commands, but only if the period registers are 
ready. I think it is some write lock while it copies the data into its 
internal control loop. From the manual:
PWM0 period register ready.
0: PWM0 period register is ready to write,
1: PWM0 period register is busy.


So no, I don't think i can use the ready bit here at all. The only thing 
we can do here, but I doubt it's worth it, is to read the period 
register, caluclate a time from it, and then ndelay(pwm_get_period(pwm) 
- ran_time)

The only 'win' then is that we could are potentially not waiting the 
full pwm period, but only a fraction of it. Since we are disabling the 
hardware (for power reasons) anyway, I don't think this is any 
significant win, except for extreme situations. E.g. we have a pwm 
period of 10 seconds, we disable it after 9.9 second, and now we have to 
wait for 10 seconds before the pwm_disable is finally done. So this 
could in that case be reduced to then only wait for 0.2 seconds since it 
is 'done' sooner.

However that optimization is also not 'free'. We have to read the period 
register and calculate back the time. I suggest to do that when 
reworking this driver to work with atomic mode, and merge this patch 'as 
is' to atleast fix te bug where simply not finish properly.

We can however change here the spin_lock to move it 2 lines lower. I did 
that in a local patch and can send it as a rebased v2.

Olliver

> Maxime
>


--------------D52D118D5E92C70C5E460C2E
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Hey Maxime,</p>
    <p>first off, also sorry for the slow delay :) (pun not intended)</p>
    <div class="moz-cite-prefix">On 27-08-16 00:19, Maxime Ripard wrote:<br>
    </div>
    <blockquote cite="mid:20160826221900.GG3165@lukather" type="cite">
      <pre wrap="">On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">When we inform the PWM block to stop toggeling the output, we may end up
in a state where the output is not what we would expect (e.g. not the
low-pulse) but whatever the output was at when the clock got disabled.

To counter this we have to wait for maximally the time of one whole
period to ensure the pwm hardware was able to finish. Since we already
told the PWM hardware to disable it self, it will not continue toggling
but merly finish its current pulse.

If a whole period is considered to much, it may be contemplated to use a
half period + a little bit to ensure we get passed the transition.

Signed-off-by: Olliver Schinagl <a class="moz-txt-link-rfc2396E" href="mailto:oliver@schinagl.nl">&lt;oliver@schinagl.nl&gt;</a>
---
 drivers/pwm/pwm-sun4i.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 03a99a5..5e97c8a 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -8,6 +8,7 @@
 
 #include &lt;linux/bitops.h&gt;
 #include &lt;linux/clk.h&gt;
+#include &lt;linux/delay.h&gt;
 #include &lt;linux/err.h&gt;
 #include &lt;linux/io.h&gt;
 #include &lt;linux/module.h&gt;
@@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	spin_lock(&amp;sun4i_pwm-&gt;ctrl_lock);
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 	val &amp;= ~BIT_CH(PWM_EN, pwm-&gt;hwpwm);
+	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	spin_unlock(&amp;sun4i_pwm-&gt;ctrl_lock);
+
+	/* Allow for the PWM hardware to finish its last toggle. The pulse
+	 * may have just started and thus we should wait a full period.
+	 */
+	ndelay(pwm_get_period(pwm));
</pre>
      </blockquote>
      <pre wrap="">Can't that use the ready bit as well?</pre>
    </blockquote>
    <br>
    <p>I started to implement our earlier discussed suggestions, but I
      do not think they will work. The read bit is not to let the user
      know it is ready with all of its commands, but only if the period
      registers are ready. I think it is some write lock while it copies
      the data into its internal control loop. From the manual:<br>
      PWM0 period register ready.<br>
      0: PWM0 period register is ready to write,<br>
      1: PWM0 period register is busy.<br>
    </p>
    <p><br>
    </p>
    <p>So no, I don't think i can use the ready bit here at all. The
      only thing we can do here, but I doubt it's worth it, is to read
      the period register, caluclate a time from it, and then
      ndelay(pwm_get_period(pwm) - ran_time)</p>
    <p>The only 'win' then is that we could are potentially not waiting
      the full pwm period, but only a fraction of it. Since we are
      disabling the hardware (for power reasons) anyway, I don't think
      this is any significant win, except for extreme situations. E.g.
      we have a pwm period of 10 seconds, we disable it after 9.9
      second, and now we have to wait for 10 seconds before the
      pwm_disable is finally done. So this could in that case be reduced
      to then only wait for 0.2 seconds since it is 'done' sooner.</p>
    <p>However that optimization is also not 'free'. We have to read the
      period register and calculate back the time. I suggest to do that
      when reworking this driver to work with atomic mode, and merge
      this patch 'as is' to atleast fix te bug where simply not finish
      properly.<br>
    </p>
    We can however change here the spin_lock to move it 2 lines lower. I
    did that in a local patch and can send it as a rebased v2.<br>
    <br>
    Olliver<br>
    <br>
    <blockquote cite="mid:20160826221900.GG3165@lukather" type="cite">
      <pre wrap="">
Maxime

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D52D118D5E92C70C5E460C2E--
