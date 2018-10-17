From: <Claudiu.Beznea@microchip.com>
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
Date: Wed, 17 Oct 2018 12:41:53 +0000
Message-ID: <fca49cff-f883-baf4-4bd3-80f45635bb5a@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
 <20181016120321.GG8852@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016120321.GG8852@ulmo>
Content-Language: en-US
Content-ID: <92A636DC92C2E84789D1F075F388771E@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, Nicolas.Ferre@microchip.com, robh+dt@kernel.org
Cc: alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org, treding@nvidia.com, shc_work@mail.ru, mark.rutland@arm.com, corbet@lwn.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com
List-Id: linux-pwm@vger.kernel.org



On 16.10.2018 15:03, Thierry Reding wrote:
> On Fri, Sep 14, 2018 at 06:20:48PM +0200, Nicolas Ferre wrote:
>> Thierry,
>>
>> On 28/08/2018 at 15:01, Claudiu Beznea wrote:
>>> Hi,
>>>
>>> Please give feedback on these patches which extends the PWM framework i=
n
>>> order to support multiple PWM modes of operations. This series is a rew=
ork
>>> of [1] and [2].
>>
>> This series started with a RFC back on 5 April 2017 "extend PWM framewor=
k to
>> support PWM modes". The continuous work starting with v2 of this series =
on
>> January 12, 2018.
>>
>> Then Claudiu tried to address all comments up to v4 which didn't have an=
y
>> more reviews. He posted a v5 without comments since May 22, 2018. This
>> series is basically a resent of the v5 (as said in the $subject).
>>
>> We would like to know what is preventing this series to be included in t=
he
>> PWM sub-system. Note that if some issue still remain with it, we are rea=
dy
>> to help to solve them.
>>
>> Without feedback from you side, we fear that we would miss a merge windo=
w
>> again for no obvious reason (DT part is Acked by Rob: patch 5/9).
>=20
> First off, apologies for not getting around to this earlier.
>=20
> I think this series is mostly fine, but I still have doubts about the DT
> aspects of this. In particular, Rob raised a concern about this here:
>=20
> 	https://lkml.org/lkml/2018/1/22/655
>=20
> and it seems like that particular question was never fully resolved as
> the discussion veered off that particular topic.

1/ If you are talking about this sentence:
"Yes, but you have to make "normal" be no bit set to be compatible with
everything already out there."

The current implementation consider that if no mode is provided then, the
old approach is considered, meaning the normal mode will be used by every
PWM in-kernel clients.

In of_pwm_xlate_with_flags() the pmw->args.mode is initialized with what
pwm_mode_get_valid() returns. In case of controllers which does not
implement something special for PWM modes the PWM normal mode will be
returned (pwmchip_get_default_caps() function has to be called in the end).
Otherwise the pwm->args.mode will be populated with what user provided as
input from DT, if what was provided from DT is valid for PWM channel.
Please see that pwm_mode_valid() is used to validate user input, otherwise
PWM normal mode will be used.

+	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);

-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
+	if (args->args_count > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm->args.polarity =3D PWM_POLARITY_INVERSED;
+
+		for (modebit =3D PWMC_MODE_COMPLEMENTARY_BIT;
+		     modebit < PWMC_MODE_CNT; modebit++) {
+			unsigned long mode =3D BIT(modebit);
+
+			if ((args->args[2] & mode) &&
+			    pwm_mode_valid(pwm, mode)) {
+				pwm->args.mode =3D mode;
+				break;
+			}
+		}
+	}


2/ If you are talking about this sentence:
"Thinking about this some more, shouldn't the new modes just be
implied? A client is going to require one of these modes or it won't
work right."

As explained at point 1, if there is no mode requested from DT the default
mode for channel will be used, which, in case of PWM controller which are
not implementing the new modes, will be PWM normal mode.

3/ If you are talking about:
"Also complementary mode could be accomplished with a single pwm output
and a board level inverter, right? How would that be handled when the
PWM driver doesn't support that mode?"
This complicates the things and I think it requires extra device tree
bindings to describe extra per-pwm channel capabilities. For the moment,
with this series I've stopped to only have the capabilities registered from
driver. My understanding is that this could be accomplished with extra
device tree bindings in PWM controller to describe PWM channels
capabilities. If you also want me to look into this direction please let me
know. And also, suggestions would be appreciated.

I know that Rob acked
> the DT parts of this, but I suspect that this might have been glossed
> over.

If this is about point 3 I've emphasize above I would like to have some
inputs from your side, if you agree with a behavior like having extra DT
bindings. The intention wasn't to left this over but to have a better
understanding of the subject. I'm thinking if it is ok to have modules
outside of the SoC that model a behavior that could not be controlled from
software (it could be only hardware) but to behave in a single way. Take
for instance this scenario:

- new DT bindings are implemented to specify this behavior per channel
- hardware modules are soldered outside of a PWM channel with one output
- the new DT bindings are not specified for the soldered PWM channel
- user enables this channel, it will have only normal mode available for it
to configure (because the new DT bindings were not provided)
- but the real output the user will see would be in complementary or even
push-pull mode.

>=20
> To restate the concern: these extended modes have special uses and none
> of the users in the kernel, other than sysfs, can use anything other
> than the normal mode. They may work fine with other modes, but only if
> they ignore the extras that come with them. Therefore I think it's safe
> to say that anyone who would want to use these modes would want to
> explicitly say so. For example the sysfs interface already does that by
> changing the mode only after the "mode" attribute is written. Any users
> for special use-cases would want to do the same thing, that is, drive a
> PWM in a specific mode, on purpose. You wouldn't have a "generic" user
> such as pwm-backlight or leds-pwm request anything other than the normal
> mode.
>=20
> So my question is, do we really need to represent these modes in DT? The
> series currently doesn't contain any patches that add users of these new
> modes. Are such patches available somewhere, or is the only user of this
> supposed to be sysfs?

For the moment, no, there is no in-kernel user for this, only sysfs. I had
in mind to adapt the use of these new mode for PWM regulator for scenarios
described in [1] page 2126. Anyway, since these patches doesn't introduce
any user other that sysfs it will not disturbed me to drop the changes. By
the time I or someone else will do some other changes that requires this,
the DT part should also be introduced.

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

>=20
> I'm hesitant to move forward with this as-is without seeing how it will
> be used.

For the moment only sysfs is supposed to use this.

The PWM specifier flags are somewhat abused by adding modes to
> them.=20

I see.

I think this hasn't been completely thought through, because the
> only reason to specify a mode is to actually set that mode.

Maybe it wasn't clear understand, with the current implementation if no
mode will be specified the default mode will be used. There is no impose to
specify a mode.

 But then the
> DT ABI allows a bitmask of modes to be requested via DT. I know that
> only the first of those modes will end up being used, but then why even
> allow it in the first place?

I had in mind that I will change the PWM regulator driver to work in
scenarios like the one specified in the link above.

>=20
> And again, even if we allow the mode to be specified in DT, how do the
> consumer drivers know that the correct mode was being set in DT.=20

PWM user will call at some point devm_pwm_get() which, in turn, will call
of_pwm_get() which in turn will initialize PWM args with inputs from DT.
After that PWM user will, at some point, apply a PWM state; if it is
initialized with PWM args initialized when devm_pwm_get() was called then
pwm_apply_state() would fail if no good mode is provided as input via DT.

Same thing happens if a bad period is provided via DT.

Let's
> say we have a consumer that requires the PWM to be driven in
> complementary mode. Should it rely on the DT to contain the correct
> specification for the mode? And if it knows that it needs complementary
> mode, why not just set that mode itself?

I'm thinking it's the same way as is with PWM period which could also be
provided from DT. In the end a bad period value could be provided from
device tree. E.g. Atmel PWM controller could generate PWM signals who's
periods could not be higher than ~0.6 seconds. If a bad value is provided
the pwm_apply_state() will fail.

Thank you,
Claudiu Beznea

That way there's no margin for
> error.


>=20
> Thierry
>=20
