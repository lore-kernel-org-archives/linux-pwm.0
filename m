From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Wed, 29 Mar 2017 20:25:14 +0200
Message-ID: <d399a9cb-7f73-08cd-47b5-f25aee416a6e@redhat.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
 <1490712327.708.30.camel@linux.intel.com>
 <d24997bc-9afc-00ec-425d-92a2d48ec2c6@redhat.com>
 <1490722132.708.43.camel@linux.intel.com>
 <1490722434.708.45.camel@linux.intel.com>
 <f2687abf-1fbb-de12-ab1f-be5056cddb70@redhat.com>
 <1490786665.708.47.camel@linux.intel.com>
 <3445f086-3619-33fb-7cfc-1c06b1ea654b@redhat.com>
 <1490809289.708.57.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752333AbdC2SZR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Mar 2017 14:25:17 -0400
In-Reply-To: <1490809289.708.57.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

Hi,

On 29-03-17 19:41, Andy Shevchenko wrote:
> On Wed, 2017-03-29 at 14:42 +0200, Hans de Goede wrote:
>> On 29-03-17 13:24, Andy Shevchenko wrote:
>>> On Tue, 2017-03-28 at 21:16 +0200, Hans de Goede wrote:
>>>> On 03/28/2017 07:33 PM, Andy Shevchenko wrote:
>>>>> On Tue, 2017-03-28 at 20:28 +0300, Andy Shevchenko wrote:
>>>>>> On Tue, 2017-03-28 at 19:20 +0200, Hans de Goede wrote:
>
>>>>>> Let me cite a bit of documentation (the wordings is the same
>>>>>> across
>>>>>> *all* supported Intel SoCs):
>>>>>>
>>>>>> --- 8< --- 8< ---
>>>>>>
>>>>>> 9.8.2 Programming Sequence
>>>>>> To ensure that there are no operational issues with PWM the
>>>>>> following
>>>>>> programming sequences must be performed in the order defined.
>>>>>>
>>>>>> • Initial Enable or First Activation
>>>>>> — Program the Base Unit and On Time Divisor values
>>>>>> — Set the Software Update Bit
>>>>>> — Enable the PWM Output by setting the PWM Enable bit
>>>>>> — Repeat the above steps for the next PWM module
>>>>>>
>>>>>> • Dynamic update while PWM is Enabled
>>>>>> — Program the Base Unit and On Time Divisor values
>>>>>> — Set the Software Update Bit
>>>>>> — Repeat the above steps for the next PWM module
>>>>>>
>
>>>>> 9.8.1 Functional Description
>>>>> Software controls the PWM block by updating the PWMCTRL register
>>>>> and
>>>>> setting the sw_update bit whenever a change in frequency or duty
>>>>> cycle
>>>>> of the PWM output signal is required. When the sw_update bit is
>>>>> set
>>>>> the
>>>>> PWM block applies the new settings at the start of the next
>>>>> output
>>>>> cycle
>>>>> and resets the sw_update bit.
>>>>>
>>>>> --- 8< --- 8< ---
>>>>
>>>> Right, notice the "pplies the new settings at the start of the
>>>> next
>>>> output cycle"
>>>> with the enable bit not set the next cycle never starts, at least
>>>> that
>>>> seems to
>>>> be the case on Cherry Trail.
>>>
>>> So, you are telling that "Initial Enable or First Activation" is
>>> buggy
>>> in your case?
>>
>> No what I'm saying is that if you set the update bit to 1 while the
>> enable
>> bit is 0 and then wait for the update bit to clear it will never clear
>> because it will clear when "the PWM block applies the new settings at
>> the start of the next output cycle" and there is no start of the next
>> output cycle with enable being 0 because then there is no output.
>
> Okay, in that case, why it works on the rest of SoCs either way?
>
> To me it sounds that spec doesn't clarify what exactly enable bit does
> vs. SW update one in actual hardware.
>
>>
>> IOW it seems that the cherrytrail hw is following the spec at least
>> how I read it.
>
> Spec doesn't clarify whether we should wait or not for SW update bit to
> be cleared when we enable PWM.
>
>> Either way I think the best way to resolve this is by having different
>> code paths on enable for Cherry Trail vs Apollo Lake. As I already
>> said
>> I will happily test a patch for this on Cherry Trail.
>
> I have one more theory, but would like to check first.
>
> Can you add something like the following whenever you about to set
> values to PWM (in either case if it's enabled or not)
>
> {
> void __iomem *x = iomap(phys_base + 0x800, 8);
> pr_info("Values are: %x %x\n", readl(x+0), readl(x+4));
> iounmap(x);
> pr_info("PWMCTRL: %x\n", readl(base));
> }
> ...
>
> update register
> ...
>
>
> I would like to see this when it works and when it doesn't.

OK, so with this diff:

--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -54,6 +54,9 @@ static inline void pwm_lpss_write(const struct pwm_device *pwm, u32 value)
  {
         struct pwm_lpss_chip *lpwm = to_lpwm(pwm->chip);

+ pr_err("pwm-lpss writing 0x%08x, values are 0x%08x 0x%08x\n",
+         value, readl(lpwm->regs + 0x800), readl(lpwm->regs + 0x804));
+
         writel(value, lpwm->regs + pwm->hwpwm * PWM_SIZE + PWM);
  }


I get the following without my latest patch to fix the issues I'm seeing
on cherrytrail:

[root@localhost ~]# dmesg | grep pwm-lpss
[    3.349048] pwm-lpss writing 0x8000a000, values are 0x00000000 0x00000003
[    3.349063] pwm-lpss writing 0xc000a000, values are 0x00000000 0x00000003
[    3.691037] pwm-lpss writing 0x8000a0ff, values are 0x00000000 0x00000003
[    3.691044] pwm-lpss writing 0xc000a0ff, values are 0x00000000 0x00000003
[    3.694369] pwm-lpss writing 0x0000a0ff, values are 0x00000000 0x00000003
[    4.752778] pwm-lpss writing 0x0000a0ff, values are 0x00000000 0x00000003
[    4.752788] pwm-lpss writing 0x4000a0ff, values are 0x00000000 0x00000003
[    5.252803] pwm-lpss 80862288:00: PWM_SW_UPDATE was not cleared

And a black lcd panel after that.

And the following with my patch added:

[root@ipv6 ~]# dmesg | grep pwm-lpss
[    3.312239] pwm-lpss writing 0x8000a000, values are 0x00000000 0x00000003
[    3.312253] pwm-lpss writing 0xc000a000, values are 0x00000000 0x00000003
[    3.652711] pwm-lpss writing 0x8000a0ff, values are 0x00000000 0x00000003
[    3.652720] pwm-lpss writing 0xc000a0ff, values are 0x00000000 0x00000003
[    3.655850] pwm-lpss writing 0x0000a0ff, values are 0x00000000 0x00000003
[    4.703856] pwm-lpss writing 0x0000a0ff, values are 0x00000000 0x00000003
[    4.703866] pwm-lpss writing 0x4000a0ff, values are 0x00000000 0x00000003
[    4.703875] pwm-lpss writing 0xc000a0ff, values are 0x00000000 0x00000003
[    4.703974] pwm-lpss writing 0x8000a000, values are 0x00000000 0x00000003
[    4.703982] pwm-lpss writing 0xc000a000, values are 0x00000000 0x00000003
[    9.617330] pwm-lpss writing 0x8000a0b3, values are 0x00000000 0x00000003
[    9.617343] pwm-lpss writing 0xc000a0b3, values are 0x00000000 0x00000003

And everything works as expected, note the brightness gets dimmed
after boot by userspace restoring the last brightness set before shutdown /
reboot.

Regards,

Hans
