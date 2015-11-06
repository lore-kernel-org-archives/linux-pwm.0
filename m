From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: Re: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
Date: Fri, 06 Nov 2015 16:46:54 +0100
Message-ID: <563CCB6E.2090206@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com> <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com> <20151106151816.GD8418@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151106151816.GD8418@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hey Thierry,

On 06-11-15 16:18, Thierry Reding wrote:
> On Mon, Oct 26, 2015 at 10:32:39PM +0100, Olliver Schinagl wrote:
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> Some hardware PWM's have the possibility to only send out one (or mo=
re)
>> pulses. This can be quite a useful feature in case one wants or need=
s
>> only a single pulse, but at the exact width.
>>
>> Additionally, if multiple pulses are possible, outputting a fixed am=
ount
>> of pulses can be useful for various timing specific purposes.
> I see how theoretically this would be nice to have. But I'm reluctant=
 to
> merge this feature if there aren't any users. What drivers in the ker=
nel
> would want to use this feature? Are there new drivers being worked on
> that will need this?
I should have brought this up as to why I added this, I'm working on a=20
stepper driver framework (inspired by the pwm framework actually) and=20
rotating moters by x degree's you do by sending pulses, using controlle=
d=20
pulses (timing wise) you can precisely move stepper motors. Yes we can=20
do this reasonably accurate in software, but doing it in hardware is so=
=20
much nicer.
>
>> A few new functions have been expanded or added for this new behavio=
r.
>>
>> * pwm_config()	now takes an additional parameter to setup the number=
 of
>> 		pulses to output. The driver may force this to 0 or 1
>> 		for if example if this feature is not or only partially
>> 		supported
> This is problematic because you need to atomically update all drivers
> and users (the kbuild robot already told you that you didn't do this)=
=2E
> To make things easier I suggest you wait with this change until the
> atomic PWM patches have been merged, at which point it should become =
a
> lot easier to deal with this kind of extension.
yes, I think i mentioned this in the cover letter, I wanted to get your=
=20
input whilst waiting for Boris's patches. So I deffinatly want to=20
combine it then, just getting some head work started :)
>
>> * pwm_[sg]et_pulse_count()	get or set the number of pulses the pwm
>> 				framework is configured for
>> * pwm_get_pulse_count_max()	get the maximum number of pulses the pwm
>> 				driver supports
>> * pwm_pulse()		Tell the PWM to emit a pre-configured number of pulse=
s
> Isn't this essentially the same as pwm_enable()? I'd think that if th=
e
> PWM is configured to output pulses, then pwm_enable() would simply do
> what it's been configured to do (emit the pulses). Why the need for a=
n
> additional function?
pwm_pulse() should be dropped, I think I accidentally left that in the=20
documentation, sorry.
>
>> * pwm_pulse_done()	an internal function for drivers to call when
>> 			they have completed their pre-configured number
>> 			of pulses
>> * pwm_is_pulsing()	tells the callers if the pwm is busy pulsing,
>> 			yielding a little more information than just
>> 			pwm_is_enabled()
> Similarily, I'd think that once the PWM is done executing the series =
of
> pulses that it was configured for it would be automatically disabled.=
 A
> consumer could then simply use pwm_is_enabled() and drivers could cal=
l
> pwm_disable() on their PWM to mark them as disabled when they're done
> pulsing.
I agree, pulseating can be dropped too as we know that a) the pulse fla=
g=20
is set, b) we are enabled. But I'm not sure now if the flag is exported=
=20
to sysfs, in any case, sysfs should just check the pulseating flag?
>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>   drivers/pwm/core.c      | 30 +++++++++++++++++++----
>>   drivers/pwm/pwm-gpio.c  |  3 ++-
>>   drivers/pwm/pwm-sun4i.c |  3 ++-
>>   drivers/pwm/sysfs.c     | 58 +++++++++++++++++++++++++++++++++++++=
+++++--
>>   include/linux/pwm.h     | 64 +++++++++++++++++++++++++++++++++++++=
+++++++++---
>>   5 files changed, 147 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 3f9df3e..e2c1c0a 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -432,22 +432,29 @@ EXPORT_SYMBOL_GPL(pwm_free);
>>    * @pwm: PWM device
>>    * @duty_ns: "on" time (in nanoseconds)
>>    * @period_ns: duration (in nanoseconds) of one cycle
>> + * @pulse_count: number of pulses (periods) to output on pwm_pulse
>>    *
>>    * Returns: 0 on success or a negative error code on failure.
>>    */
>> -int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
>> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns,
>> +	       unsigned int pulse_count)
> Like I said, this is problematic because every driver and every consu=
mer
> now needs to be aware of pulsing. Once the PWM atomic patches are mer=
ged
> this will become easier to do because the pulse configuration would b=
e a
> part of the atomic state, and hence can be conveniently ignored by us=
ers
> and driver alike.
I agree :) I'll take your initial comments and work with those so far i=
n=20
cleaning stuff up. Feel free to get back to me about the validity of th=
e=20
pwm_pulse for steppers generally
> Thierry

--=20
Met vriendelijke groeten, Kind regards, =E4=B8=8E=E4=BA=B2=E5=88=87=E7=9A=
=84=E9=97=AE=E5=80=99

Olliver Schinagl
Software Engineer
Research & Development
Ultimaker B.V.
