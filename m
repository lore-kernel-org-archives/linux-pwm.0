From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
Date: Fri, 19 Oct 2018 14:18:25 +0300
Message-ID: <67708c92-edbb-0429-d7e7-ac000968c271@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
 <20181016120321.GG8852@ulmo>
 <fca49cff-f883-baf4-4bd3-80f45635bb5a@microchip.com>
 <20181018160038.GD6226@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181018160038.GD6226@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nicolas.Ferre@microchip.com, robh+dt@kernel.org, alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org, treding@nvidia.com, shc_work@mail.ru, mark.rutland@arm.com, corbet@lwn.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com
List-Id: linux-pwm@vger.kernel.org



On 18.10.2018 19:00, Thierry Reding wrote:
> On Wed, Oct 17, 2018 at 12:41:53PM +0000, Claudiu.Beznea@microchip.com wrote:
>>
>>
>> On 16.10.2018 15:03, Thierry Reding wrote:
>>> On Fri, Sep 14, 2018 at 06:20:48PM +0200, Nicolas Ferre wrote:
>>>> Thierry,
>>>>
>>>> On 28/08/2018 at 15:01, Claudiu Beznea wrote:
>>>>> Hi,
>>>>>
>>>>> Please give feedback on these patches which extends the PWM framework in
>>>>> order to support multiple PWM modes of operations. This series is a rework
>>>>> of [1] and [2].
>>>>
>>>> This series started with a RFC back on 5 April 2017 "extend PWM framework to
>>>> support PWM modes". The continuous work starting with v2 of this series on
>>>> January 12, 2018.
>>>>
>>>> Then Claudiu tried to address all comments up to v4 which didn't have any
>>>> more reviews. He posted a v5 without comments since May 22, 2018. This
>>>> series is basically a resent of the v5 (as said in the $subject).
>>>>
>>>> We would like to know what is preventing this series to be included in the
>>>> PWM sub-system. Note that if some issue still remain with it, we are ready
>>>> to help to solve them.
>>>>
>>>> Without feedback from you side, we fear that we would miss a merge window
>>>> again for no obvious reason (DT part is Acked by Rob: patch 5/9).
>>>
>>> First off, apologies for not getting around to this earlier.
>>>
>>> I think this series is mostly fine, but I still have doubts about the DT
>>> aspects of this. In particular, Rob raised a concern about this here:
>>>
>>> 	https://lkml.org/lkml/2018/1/22/655
>>>
>>> and it seems like that particular question was never fully resolved as
>>> the discussion veered off that particular topic.
>>
>> 1/ If you are talking about this sentence:
>> "Yes, but you have to make "normal" be no bit set to be compatible with
>> everything already out there."
>>
>> The current implementation consider that if no mode is provided then, the
>> old approach is considered, meaning the normal mode will be used by every
>> PWM in-kernel clients.
>>
>> In of_pwm_xlate_with_flags() the pmw->args.mode is initialized with what
>> pwm_mode_get_valid() returns. In case of controllers which does not
>> implement something special for PWM modes the PWM normal mode will be
>> returned (pwmchip_get_default_caps() function has to be called in the end).
>> Otherwise the pwm->args.mode will be populated with what user provided as
>> input from DT, if what was provided from DT is valid for PWM channel.
>> Please see that pwm_mode_valid() is used to validate user input, otherwise
>> PWM normal mode will be used.
> 
> No, that part looks fine.
> 
>>
>> +	pwm->args.mode = pwm_mode_get_valid(pc, pwm);
>>
>> -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
>> -		pwm->args.polarity = PWM_POLARITY_INVERSED;
>> +	if (args->args_count > 2) {
>> +		if (args->args[2] & PWM_POLARITY_INVERTED)
>> +			pwm->args.polarity = PWM_POLARITY_INVERSED;
>> +
>> +		for (modebit = PWMC_MODE_COMPLEMENTARY_BIT;
>> +		     modebit < PWMC_MODE_CNT; modebit++) {
>> +			unsigned long mode = BIT(modebit);
>> +
>> +			if ((args->args[2] & mode) &&
>> +			    pwm_mode_valid(pwm, mode)) {
>> +				pwm->args.mode = mode;
>> +				break;
>> +			}
>> +		}
>> +	}
>>
>>
>> 2/ If you are talking about this sentence:
>> "Thinking about this some more, shouldn't the new modes just be
>> implied? A client is going to require one of these modes or it won't
>> work right."
>>
>> As explained at point 1, if there is no mode requested from DT the default
>> mode for channel will be used, which, in case of PWM controller which are
>> not implementing the new modes, will be PWM normal mode.
> 
> I don't think that's an issue. I think what Rob was referring to and
> which mirrors my concern is that these modes are a feature that doesn't
> extend to typical use-cases. So for all existing use-cases (like LED or
> backlight) we always assume a PWM running in normal mode. Now, if you
> write a driver for some particular piece of hardware that needs a mode
> that is not the normal mode, the question is: wouldn't that driver know
> that it wants exactly push-pull or complementary mode?

It should, yes.

Wouldn't it have
> to explicitly check that the PWM supports it and select it (i.e. in the
> driver code)?

Yes, that should be the flow. I added the DT changes for cases where a
driver could use more than one mode and to be able to choose one of the
modes it may needs.

> 
> Say you have a driver that requires push-pull mode. It doesn't really
> make sense to require the mode to be encoded in DT, because the driver
> will only work with one specific mode anyway. So might as well require
> it and have the driver check for support and fail if the PWM is not
> compatible. This would likely never happen, because hardware engineers
> couldn't have validated the design in that case, but there's no reason
> for the mode to be specified in DT because it is fixed by the very use-
> case anyway.

Yes, agree.

> 
> Also, leaving it out of DT simplifies things.

Agree.

> If you allow the mode to
> be specified in DT you could end up with a situation where the driver
> required push-pull mode, but the DT specifies complementary mode. What
> do you do in such a situation? Warn about it and just go with push-pull
> anyway? Then why give the users a way of screwing things up in the first
> place?

I only introduce this because I had in mind the PWM regulator and I was
thinking to make it work for either push-pull mode and normal mode. But
since there is no code for this at the moment I totally agree with you to
not introduce the DT part. My bad I push it here without a use case.

> 
>> 3/ If you are talking about:
>> "Also complementary mode could be accomplished with a single pwm output
>> and a board level inverter, right? How would that be handled when the
>> PWM driver doesn't support that mode?"
>> This complicates the things and I think it requires extra device tree
>> bindings to describe extra per-pwm channel capabilities. For the moment,
>> with this series I've stopped to only have the capabilities registered from
>> driver. My understanding is that this could be accomplished with extra
>> device tree bindings in PWM controller to describe PWM channels
>> capabilities. If you also want me to look into this direction please let me
>> know. And also, suggestions would be appreciated.
> 
> I think this is very interesting, but I don't think this needs to be
> done as part of this series.
> 
>> I know that Rob acked
>>> the DT parts of this, but I suspect that this might have been glossed
>>> over.
>>
>> If this is about point 3 I've emphasize above I would like to have some
>> inputs from your side, if you agree with a behavior like having extra DT
>> bindings. The intention wasn't to left this over but to have a better
>> understanding of the subject. I'm thinking if it is ok to have modules
>> outside of the SoC that model a behavior that could not be controlled from
>> software (it could be only hardware) but to behave in a single way. Take
>> for instance this scenario:
>>
>> - new DT bindings are implemented to specify this behavior per channel
>> - hardware modules are soldered outside of a PWM channel with one output
>> - the new DT bindings are not specified for the soldered PWM channel
>> - user enables this channel, it will have only normal mode available for it
>> to configure (because the new DT bindings were not provided)
>> - but the real output the user will see would be in complementary or even
>> push-pull mode.
> 
> I think we could possible model this as a "logical" PWM in DT. We could
> for example have something like this:
> 
> 	/ {
> 		...
> 
> 		pwms {
> 			pwm@0 {
> 				compatible = "pwm-fixed"; /* or whatever */
> 				pwms = <&pwm 0 40000>; /* input PWM */
> 				mode = <PWM_MODE_COMPLEMENTARY>;
> 			};
> 
> 			...
> 		};
> 
> 		...
> 	};
> 
> The above would model a logical PWM that is driven by the specified PWM
> in normal mode but which is effectively complementary because of some
> additional circuitry on the board.

Ok, i see it. Sounds good to me.

> 
>>> To restate the concern: these extended modes have special uses and none
>>> of the users in the kernel, other than sysfs, can use anything other
>>> than the normal mode. They may work fine with other modes, but only if
>>> they ignore the extras that come with them. Therefore I think it's safe
>>> to say that anyone who would want to use these modes would want to
>>> explicitly say so. For example the sysfs interface already does that by
>>> changing the mode only after the "mode" attribute is written. Any users
>>> for special use-cases would want to do the same thing, that is, drive a
>>> PWM in a specific mode, on purpose. You wouldn't have a "generic" user
>>> such as pwm-backlight or leds-pwm request anything other than the normal
>>> mode.
>>>
>>> So my question is, do we really need to represent these modes in DT? The
>>> series currently doesn't contain any patches that add users of these new
>>> modes. Are such patches available somewhere, or is the only user of this
>>> supposed to be sysfs?
>>
>> For the moment, no, there is no in-kernel user for this, only sysfs. I had
>> in mind to adapt the use of these new mode for PWM regulator for scenarios
>> described in [1] page 2126. Anyway, since these patches doesn't introduce
>> any user other that sysfs it will not disturbed me to drop the changes. By
>> the time I or someone else will do some other changes that requires this,
>> the DT part should also be introduced.
>>
>> [1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
> 
> Yes, I'd like that. The half-bridge converter certainly sounds like
> something that may be able to use the DT bindings that you specified,
> but I'd be less concerned about these changes if we had actual users.

I understand.

Now, thinking again at what you proposed above with regards to logical PWM
channels I'm wondering if, for future, if needed, would be good for PWM
clients that could used a PWM channel in more than one PWM mode, to have
specified in device tree, as a child of PWM controller, the mode that the
client would use that channel. E.g. if DriverX wants to use PWM0 in
complementary mode:

pwm@00aabbcc {
	// ...
	pwm@0 {
		mode = <PWM_MODE_COMPLEMENTARY>;
		// this being the only mode that could be used for
		// PWM channel 0
	};
}

driverx@00ffffff {
	pwms=<pwm 0 50000>;
}

For future reference, do you find this feasible?

> 
>>> I'm hesitant to move forward with this as-is without seeing how it will
>>> be used.
>>
>> For the moment only sysfs is supposed to use this.
>>
>> The PWM specifier flags are somewhat abused by adding modes to
>>> them. 
>>
>> I see.
>>
>> I think this hasn't been completely thought through, because the
>>> only reason to specify a mode is to actually set that mode.
>>
>> Maybe it wasn't clear understand, with the current implementation if no
>> mode will be specified the default mode will be used. There is no impose to
>> specify a mode.
>>
>>  But then the
>>> DT ABI allows a bitmask of modes to be requested via DT. I know that
>>> only the first of those modes will end up being used, but then why even
>>> allow it in the first place?
>>
>> I had in mind that I will change the PWM regulator driver to work in
>> scenarios like the one specified in the link above.
> 
> Yeah, that sounds like it would be reasonable from a quick look.
> However, what I don't quite understand yet is why the mode in the PWM
> specifier would need to be a bitmask.

You are talking to have them as bitmask in pwm-flags cell right?
I though to stick this to the current way to request the PWM mode.

Take for example the pwm-regulator
> case for a half-bridge converter. If your board uses such a setup, then
> you absolutely must drive the PWM in push-pull mode, otherwise the
> converter will not work, right?

Right!

So you want exactly one mode to be
> applied. Then why complicate matters by allowing the mode to be a
> bitmask? 

Just to have everything behaving almost in the same way as it was
previously.  I'm saying to request the PWM channel from a PWM client (via
DT) as it was previously done but just adding the PWM mode (in pwm-flags
cell as per this version).

I also was not sure about this: in the 2nd version of this series I
introduced a new cell for PWM modes but this new cell was after pwm-flags
cell, and pwm-flags cell is optional, so to have simpler code, in scenarios
with PWM modes user would have also specified the pwm-flags cell (although
maybe it was not necessary).

> We could just as easily reserve, say, 8 bits (24-31) for the
> mode, which could then be identical to enum pwm_mode.

In pwm-flags cell, right?


> 
>>> And again, even if we allow the mode to be specified in DT, how do the
>>> consumer drivers know that the correct mode was being set in DT. 
>>
>> PWM user will call at some point devm_pwm_get() which, in turn, will call
>> of_pwm_get() which in turn will initialize PWM args with inputs from DT.
>> After that PWM user will, at some point, apply a PWM state; if it is
>> initialized with PWM args initialized when devm_pwm_get() was called then
>> pwm_apply_state() would fail if no good mode is provided as input via DT.
>>
>> Same thing happens if a bad period is provided via DT.
> 
> But that only checks that the DT specified a supported mode, it doesn't
> mean that it's the correct one. For cases like pwm-regulator this may be
> fine because the driver ultimately doesn't care about the exact mode. If
> you have a driver that only works with a specific mode, however, it can
> be problematic.

Yes, agree.

> 
>> Let's
>>> say we have a consumer that requires the PWM to be driven in
>>> complementary mode. Should it rely on the DT to contain the correct
>>> specification for the mode? And if it knows that it needs complementary
>>> mode, why not just set that mode itself?
>>
>> I'm thinking it's the same way as is with PWM period which could also be
>> provided from DT. In the end a bad period value could be provided from
>> device tree. E.g. Atmel PWM controller could generate PWM signals who's
>> periods could not be higher than ~0.6 seconds. If a bad value is provided
>> the pwm_apply_state() will fail.
> 
> I understand that. And it's good to validate these things in the driver.
> However, the PWM driver can only validate for the PWM that it is
> driving. It doesn't know if the consumer has any special requirements
> regarding the mode. So if the PWM supports push-pull mode and the DT
> contains PWM_MODE_PUSH_PULL, then everything is fine as far as the PWM
> driver is concerned. However, if the consumer driver strictly requires
> complementary mode, there's nothing the PWM driver can do about it. So
> we either need the consumer to be able to query the mode if it has any
> specific needs and refuse to use a PWM that has the wrong mode in the
> specifier, or the consumer needs to explicitly set a mode, in which case
> there's no need to have it in DT and the PWM driver needs to reject it
> if the PWM doesn't support it.

Ok, I see your point and understand that DT part may be risky and
complicates the things. And I agree to remove it from this series since,
anyway, there is no in-kernel user for that.

Thank you,
Claudiu Beznea


> 
> Thierry
> 
