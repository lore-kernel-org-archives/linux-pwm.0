From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] pwm: lpss: Add get_state callback
Date: Tue, 28 Feb 2017 00:20:57 +0200
Message-ID: <CAHp75Vdx4JNRzZSzfEe5H6Oj8vxJ7FJ-aA2ojY_HNgeXmCKq8A@mail.gmail.com>
References: <20170227165941.1379-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36689 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdB0W25 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Feb 2017 17:28:57 -0500
Received: by mail-qk0-f195.google.com with SMTP id r90so20509923qki.3
        for <linux-pwm@vger.kernel.org>; Mon, 27 Feb 2017 14:27:21 -0800 (PST)
In-Reply-To: <20170227165941.1379-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andy@infradead.org>, linux-pwm@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Mon, Feb 27, 2017 at 6:59 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add a get_state callback so that the initial state correctly reflects
> the actual hardware state.

> +static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +                              struct pwm_state *state)
> +{
> +       struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> +       unsigned long base_unit_range;
> +       unsigned long long base_unit, freq, on_time_div;
> +       u32 ctrl;
> +
> +       base_unit_range = BIT(lpwm->info->base_unit_bits);
> +
> +       ctrl = pwm_lpss_read(pwm);
> +       on_time_div = 255 - (ctrl & PWM_ON_TIME_DIV_MASK);
> +       base_unit = (ctrl >> PWM_BASE_UNIT_SHIFT) & (base_unit_range - 1);
> +
> +       freq = base_unit * lpwm->info->clk_rate;
> +       do_div(freq, base_unit_range);

> +       if (freq == 0)
> +               state->period = NSEC_PER_SEC;

And this is wrong. IIRC base_unit = 0 *or* on_time_div = 255 means
duty cycle = 100%.

> +       else
> +               state->period = NSEC_PER_SEC / (unsigned long)freq;

I would stop doing versions so fast and give one more try with
carefully chosen variable types and perhaps a bit straighter
arithmetic here.

> +
> +       on_time_div *= state->period;
> +       do_div(on_time_div, 255);
> +       state->duty_cycle = on_time_div;
> +
> +       state->polarity = PWM_POLARITY_NORMAL;
> +       state->enabled = !!(ctrl & PWM_ENABLE);
> +

> +       if (state->enabled)
> +               pm_runtime_get_sync(chip->dev);

Since you are too fast (again), let me ask where is the balanced put
for this call?
Second question, how ->get_state() is supposed to work if power is off
when it enters it?

> +}

-- 
With Best Regards,
Andy Shevchenko
