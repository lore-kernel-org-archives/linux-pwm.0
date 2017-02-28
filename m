From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3] pwm: lpss: Add get_state callback
Date: Tue, 28 Feb 2017 15:09:11 +0100
Message-ID: <8e7e2207-6004-13c3-1d6f-416bf306bc11@redhat.com>
References: <20170227165941.1379-1-hdegoede@redhat.com>
 <CAHp75Vdx4JNRzZSzfEe5H6Oj8vxJ7FJ-aA2ojY_HNgeXmCKq8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752001AbdB1OJh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Feb 2017 09:09:37 -0500
In-Reply-To: <CAHp75Vdx4JNRzZSzfEe5H6Oj8vxJ7FJ-aA2ojY_HNgeXmCKq8A@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andy@infradead.org>, linux-pwm@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi,

On 27-02-17 23:20, Andy Shevchenko wrote:
> On Mon, Feb 27, 2017 at 6:59 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Add a get_state callback so that the initial state correctly reflects
>> the actual hardware state.
>
>> +static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +                              struct pwm_state *state)
>> +{
>> +       struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>> +       unsigned long base_unit_range;
>> +       unsigned long long base_unit, freq, on_time_div;
>> +       u32 ctrl;
>> +
>> +       base_unit_range = BIT(lpwm->info->base_unit_bits);
>> +
>> +       ctrl = pwm_lpss_read(pwm);
>> +       on_time_div = 255 - (ctrl & PWM_ON_TIME_DIV_MASK);
>> +       base_unit = (ctrl >> PWM_BASE_UNIT_SHIFT) & (base_unit_range - 1);
>> +
>> +       freq = base_unit * lpwm->info->clk_rate;
>> +       do_div(freq, base_unit_range);
>
>> +       if (freq == 0)
>> +               state->period = NSEC_PER_SEC;
>
> And this is wrong. IIRC base_unit = 0 *or* on_time_div = 255 means
> duty cycle = 100%.

Ok, so maybe we should do this then ?

	if (freq == 0) {
		state->period = NSEC_PER_SEC;
		state->duty_cycle = NSEC_PER_SEC;
		return;
	}

?


>
>> +       else
>> +               state->period = NSEC_PER_SEC / (unsigned long)freq;
>
> I would stop doing versions so fast and give one more try with
> carefully chosen variable types and perhaps a bit straighter
> arithmetic here.

I've carefully chosen the variable types, freq needs to
be 64 bits for do_div usage. Here I'm going from
freq (which has been divided by now) to a period time
in nsec, for which:

	state->period = NSEC_PER_SEC / (unsigned long)freq;

Is as straight forward as one can get, the
(unsigned long) cast is there to force a 32 bit
division since freq is known to fit in 32 bits at this
time.

>> +
>> +       on_time_div *= state->period;
>> +       do_div(on_time_div, 255);
>> +       state->duty_cycle = on_time_div;
>> +
>> +       state->polarity = PWM_POLARITY_NORMAL;
>> +       state->enabled = !!(ctrl & PWM_ENABLE);
>> +
>
>> +       if (state->enabled)
>> +               pm_runtime_get_sync(chip->dev);
>
> Since you are too fast (again), let me ask where is the balanced put
> for this call?

As I explained in my earlier mail this is balanced
by the disable path in apply(). But I guess what you are
getting at is what if the driver gets removed while the
pwm is enabled? It seems that we then indeed leak our
runtime-pm ref, note that is a pre-existing bug.

Anyways since we now may get a pm-ref during probe
I will add the balancing (and equally conditional)
put of that ref to pwm_lpss_remove().

> Second question, how ->get_state() is supposed to work if power is off
> when it enters it?

get_state only gets called on probe and the device is guaranteed to
be powered on during probe().

Regards,

Hans
