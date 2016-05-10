From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: Re: [PATCH RESEND 2/3] pwm: kona: Add support for Broadcom iproc pwm controller
Date: Tue, 10 May 2016 20:41:59 +0530
Message-ID: <CAL2FKYkyBF9aiMjnse6407HzcCyp+7cmcdmERcDLc5+FJgEnhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35686 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcEJPMG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2016 11:12:06 -0400
Received: by mail-io0-f174.google.com with SMTP id d62so19606757iof.2
        for <linux-pwm@vger.kernel.org>; Tue, 10 May 2016 08:12:00 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>

Hi Thierry,

On Tue, May 10, 2016 at 8:10 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Mar 29, 2016 at 10:22:29AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
>> Update the kona driver to support Broadcom iproc pwm controller
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> ---
>>  drivers/pwm/Kconfig        |   6 +-
>>  drivers/pwm/pwm-bcm-kona.c | 183 +++++++++++++++++++++++++++++++++++++++------
>>  2 files changed, 163 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index c182efc..e45ea33 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -76,9 +76,11 @@ config PWM_ATMEL_TCB
>>
>>  config PWM_BCM_KONA
>>       tristate "Kona PWM support"
>> -     depends on ARCH_BCM_MOBILE
>> +     depends on ARCH_BCM_MOBILE || ARCH_BCM_IPROC
>> +     default ARCH_BCM_IPROC
>
> Why the default? Typically you'd enable this in one or more of the
> default configurations. default ARCH_* is really only useful if the
> driver is essential. PWM doesn't usually fall into this category.
>
>> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
>> index c634183..ef152e3a 100644
>> --- a/drivers/pwm/pwm-bcm-kona.c
>> +++ b/drivers/pwm/pwm-bcm-kona.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/math64.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pwm.h>
>>  #include <linux/slab.h>
>> @@ -47,30 +48,90 @@
>>
>>  #define PWM_CONTROL_OFFSET                   (0x00000000)
>>  #define PWM_CONTROL_SMOOTH_SHIFT(chan)               (24 + (chan))
>> -#define PWM_CONTROL_TYPE_SHIFT(chan)         (16 + (chan))
>> +#define PWM_CONTROL_TYPE_SHIFT(shift, chan)  (shift + chan)
>
> You need to put the parameters into parentheses to avoid expansion from
> potentially messing up the expression.
>
>>  #define PWM_CONTROL_POLARITY_SHIFT(chan)     (8 + (chan))
>>  #define PWM_CONTROL_TRIGGER_SHIFT(chan)              (chan)
>>
>>  #define PRESCALE_OFFSET                              (0x00000004)
>> -#define PRESCALE_SHIFT(chan)                 ((chan) << 2)
>> -#define PRESCALE_MASK(chan)                  (0x7 << PRESCALE_SHIFT(chan))
>> +#define PRESCALE_SHIFT                               (0x00000004)
>> +#define PRESCALE_MASK                                (0x00000007)
>
> Hmm... this looks odd. Why are you dropping the chan parameter here?
>
>>  #define PRESCALE_MIN                         (0x00000000)
>>  #define PRESCALE_MAX                         (0x00000007)
>>
>> -#define PERIOD_COUNT_OFFSET(chan)            (0x00000008 + ((chan) << 3))
>> +#define PERIOD_COUNT_OFFSET(offset, chan)    (offset + (chan << 3))
>
> Need parentheses here as well.
>
>>  #define PERIOD_COUNT_MIN                     (0x00000002)
>>  #define PERIOD_COUNT_MAX                     (0x00ffffff)
>> +#define KONA_PERIOD_COUNT_OFFSET             (0x00000008)
>>
>> -#define DUTY_CYCLE_HIGH_OFFSET(chan)         (0x0000000c + ((chan) << 3))
>> +#define DUTY_CYCLE_HIGH_OFFSET(offset, chan) (offset + (chan << 3))
>>  #define DUTY_CYCLE_HIGH_MIN                  (0x00000000)
>>  #define DUTY_CYCLE_HIGH_MAX                  (0x00ffffff)
>> +#define KONA_DUTY_CYCLE_HIGH_OFFSET          (0x0000000c)
>> +
>> +#define PWM_CHANNEL_CNT                              (0x00000006)
>> +#define SIGNAL_PUSH_PULL                     (0x00000001)
>> +#define PWMOUT_TYPE_SHIFT                    (0x00000010)
>> +
>> +#define IPROC_PRESCALE_OFFSET                        (0x00000024)
>> +#define IPROC_PRESCALE_SHIFT                 (0x00000006)
>> +#define IPROC_PRESCALE_MAX                   (0x0000003f)
>> +
>> +#define IPROC_PERIOD_COUNT_OFFSET            (0x00000004)
>> +#define IPROC_PERIOD_COUNT_MIN                       (0x00000002)
>> +#define IPROC_PERIOD_COUNT_MAX                       (0x0000ffff)
>> +
>> +#define IPROC_DUTY_CYCLE_HIGH_OFFSET         (0x00000008)
>> +#define IPROC_DUTY_CYCLE_HIGH_MIN            (0x00000000)
>> +#define IPROC_DUTY_CYCLE_HIGH_MAX            (0x0000ffff)
>> +
>> +#define IPROC_PWM_CHANNEL_CNT                        (0x00000004)
>> +#define IPROC_SIGNAL_PUSH_PULL                       (0x00000000)
>> +#define IPROC_PWMOUT_TYPE_SHIFT                      (0x0000000f)
>> +
>> +/*
>> + * pwm controller reg structure
>> + *
>> + * @prescale_offset: prescale register offset
>> + * @period_offset: period register offset
>> + * @duty_offset: duty register offset
>> + * @no_of_channels: number of channels
>> + * @out_type_shift: out type shift in the register
>> + * @signal_type: push-pull or open drain
>> + * @prescale_max: prescale max
>> + * @prescale_shift: prescale shift in register
>> + * @prescale_ch_ascending: prescale ch order in prescale register
>> + * @duty_cycle_max: value of max duty cycle
>> + * @duty_cycle_min: value of min duty cycle
>> + * @period_count_max: max period count val
>> + * @period_count_min: min period count val
>> + * @smooth_output_support: pwm smooth output support
>> + */
>> +struct kona_pwmc_reg {
>> +     u32 prescale_offset;
>> +     u32 period_offset;
>> +     u32 duty_offset;
>> +     u32 no_of_channels;
>> +     u32 out_type_shift;
>> +     u32 signal_type;
>> +     u32 prescale_max;
>> +     u32 prescale_shift;
>> +     bool prescale_ch_ascending;
>> +     u32 duty_cycle_max;
>> +     u32 duty_cycle_min;
>> +     u32 period_count_max;
>> +     u32 period_count_min;
>> +     bool smooth_output_support;
>> +};
>
> This is rather tedious. It looks to me like this isn't very similar to
> the existing driver. Register offsets move around, bitfield positions
> change, feature set is different. Might be better off turning this into
> a separate driver after all.
>
>> +static const struct kona_pwmc_reg kona_pwmc_reg_data = {
>> +     .prescale_offset = PRESCALE_OFFSET,
>> +     .period_offset = KONA_PERIOD_COUNT_OFFSET,
>> +     .duty_offset = KONA_DUTY_CYCLE_HIGH_OFFSET,
>> +     .no_of_channels = PWM_CHANNEL_CNT,
>> +     .out_type_shift = PWMOUT_TYPE_SHIFT,
>> +     .signal_type = SIGNAL_PUSH_PULL,
>> +     .prescale_max = PRESCALE_MAX,
>> +     .prescale_shift = PRESCALE_SHIFT,
>> +     .prescale_ch_ascending = false,
>> +     .duty_cycle_max = DUTY_CYCLE_HIGH_MAX,
>> +     .duty_cycle_min = DUTY_CYCLE_HIGH_MIN,
>> +     .period_count_max = PERIOD_COUNT_MAX,
>> +     .period_count_min = PERIOD_COUNT_MIN,
>> +     .smooth_output_support = true,
>> +};
>> +
>> +static const struct kona_pwmc_reg iproc_pwmc_reg_data = {
>> +     .prescale_offset = IPROC_PRESCALE_OFFSET,
>> +     .period_offset = IPROC_PERIOD_COUNT_OFFSET,
>> +     .duty_offset = IPROC_DUTY_CYCLE_HIGH_OFFSET,
>> +     .no_of_channels = IPROC_PWM_CHANNEL_CNT,
>> +     .out_type_shift = IPROC_PWMOUT_TYPE_SHIFT,
>> +     .signal_type = IPROC_SIGNAL_PUSH_PULL,
>> +     .prescale_max = IPROC_PRESCALE_MAX,
>> +     .prescale_shift = IPROC_PRESCALE_SHIFT,
>> +     .prescale_ch_ascending = true,
>> +     .duty_cycle_max = IPROC_DUTY_CYCLE_HIGH_MAX,
>> +     .duty_cycle_min = IPROC_DUTY_CYCLE_HIGH_MIN,
>> +     .period_count_max = IPROC_PERIOD_COUNT_MAX,
>> +     .period_count_min = IPROC_PERIOD_COUNT_MIN,
>> +     .smooth_output_support = false,
>> +};
>
> This looks like you could possible support a lot more hardware with this
> driver because it's now almost completely parameterized.
>
> I don't see much sense in keeping this in the same driver and I think
> it'd be better to write a new one from scratch, even if that means
> slight duplication.
>

These two variants have the same block with different reg offsets and
bit fields. I thought of having a same driver, will address the fixes for
both if any. I will generate a new one as suggested and submit a
v2 version.

> Or you'll have to make a very compelling argument as to why this is the
> better option.
>
> Thierry

Thanks
Dhananjay
