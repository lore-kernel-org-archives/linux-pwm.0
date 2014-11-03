From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: Re: [PATCH] clk: Add PWM clock driver
Date: Mon, 03 Nov 2014 18:45:59 +0100
Message-ID: <5457BF57.3020906@elproma.com.pl>
References: <5410AEFD.5030302@elproma.com.pl> <20140923085130.GO30514@ulmo> <20140927200122.19023.40310@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140927200122.19023.40310@quantum>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


W dniu 2014-09-27 o 22:01, Mike Turquette pisze:
> Quoting Thierry Reding (2014-09-23 01:51:31)
>> On Wed, Sep 10, 2014 at 10:05:17PM +0200, Janusz U=C5=BCycki wrote:
>>> Hi,
>>>
>>> http://patchwork.ozlabs.org/patch/359069/
>>> https://lkml.org/lkml/2014/6/12/186
>>>
>>> Will the patch ever included to linux-next?
>> I've never seen this patch before. From a quick look it doesn't seem
>> like it would work as is, but the idea is certainly interesting. If
>> somebody decides to continue work on it, please Cc me and the linux-=
pwm
>> mailing list.
> I just merged a gpio-controlled clock gate and I'm fine with a PWM cl=
ock
> output.
>
> Janusz, how are you testing the clock driver?

Sorry, I didn't noticed the email.
I didn't test the patch yet. However I plan to check it this year.

best regards
Janusz

>
> Regards,
> Mike
>
>>> pwm_config()  API could be extended to support
>>> not only period [ns] and duty [ns] time
>>> but also frequency [Hz] and duty cycle fraction [1/1000?]
>>> (instead of time in ns) as parameters.
>>> Then  ns (rounded by pwm) to freq. conversion problem
>>> inclk_pwm_recalc_rate() usingpwm_get_period()
>>> could be avoided.
>>> To extend the API pwm_config() can support
>>> new flags forduty_ns and period_ns,
>>> eg. PWM_DUTY_PERCENT and PWM_PERIOD_HZ.
>> Is that rounding really a problem? Also the PWM chips will most like=
ly
>> use the concept of period and duty-cycle internally anyway, so it wi=
ll
>> convert back from Hz/percentage to nanoseconds and fall victim to
>> similar rounding effects.
>>
>> Thierry
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
