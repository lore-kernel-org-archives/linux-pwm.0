From: <Claudiu.Beznea@microchip.com>
Subject: Re: [RESEND PATCH v5 1/9] pwm: extend PWM framework with PWM modes
Date: Wed, 17 Oct 2018 12:42:00 +0000
Message-ID: <139cc421-ac12-1262-bc32-763731528ccf@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
 <20181016122508.GH8852@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016122508.GH8852@ulmo>
Content-Language: en-US
Content-ID: <CFEF1475EE1F8840ACB5C6A630E84E05@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, shc_work@mail.ru, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 16.10.2018 15:25, Thierry Reding wrote:
> On Tue, Aug 28, 2018 at 04:01:18PM +0300, Claudiu Beznea wrote:
>> Add basic PWM modes: normal and complementary. These modes should
>> differentiate the single output PWM channels from two outputs PWM
>> channels. These modes could be set as follow:
>> 1. PWM channels with one output per channel:
>> - normal mode
>> 2. PWM channels with two outputs per channel:
>> - normal mode
>> - complementary mode
>> Since users could use a PWM channel with two output as one output PWM
>> channel, the PWM normal mode is allowed to be set for PWM channels with
>> two outputs; in fact PWM normal mode should be supported by all PWMs.
>>
>> The PWM capabilities were implemented per PWM channel. Every PWM control=
ler
>> will register a function to get PWM capabilities. If this is not explici=
tly
>> set by the driver a default function will be used to retrieve the PWM
>> capabilities (in this case the PWM capabilities will contain only PWM
>> normal mode). This function is set in pwmchip_add_with_polarity() as a
>> member of "struct pwm_chip". To retrieve capabilities the pwm_get_caps()
>> function could be used.
>>
>> Every PWM channel have associated a mode in the PWM state. Proper
>> support was added to get/set PWM mode. The mode could also be set
>> from DT via flag cells. The valid DT modes are located in
>> include/dt-bindings/pwm/pwm.h. Only modes supported by PWM channel could=
 be
>> set. If nothing is specified for a PWM channel, via DT, the first availa=
ble
>> mode will be used (normally, this will be PWM normal mode).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  drivers/pwm/core.c  | 124 +++++++++++++++++++++++++++++++++++++++++++++=
+++++--
>>  drivers/pwm/sysfs.c |  61 ++++++++++++++++++++++++++
>>  include/linux/pwm.h |  39 +++++++++++++++++
>>  3 files changed, 221 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 1581f6ab1b1f..59a9df9120de 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -136,6 +136,7 @@ struct pwm_device *
>>  of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_ar=
gs *args)
>>  {
>>  	struct pwm_device *pwm;
>> +	int modebit;
>> =20
>>  	/* check, whether the driver supports a third cell for flags */
>>  	if (pc->of_pwm_n_cells < 3)
>> @@ -154,9 +155,23 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const =
struct of_phandle_args *args)
>> =20
>>  	pwm->args.period =3D args->args[1];
>>  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
>> +	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);
>> =20
>> -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
>> -		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
>> +	if (args->args_count > 2) {
>> +		if (args->args[2] & PWM_POLARITY_INVERTED)
>> +			pwm->args.polarity =3D PWM_POLARITY_INVERSED;
>> +
>> +		for (modebit =3D PWMC_MODE_COMPLEMENTARY_BIT;
>> +		     modebit < PWMC_MODE_CNT; modebit++) {
>> +			unsigned long mode =3D BIT(modebit);
>> +
>> +			if ((args->args[2] & mode) &&
>> +			    pwm_mode_valid(pwm, mode)) {
>> +				pwm->args.mode =3D mode;
>> +				break;
>> +			}
>> +		}
>> +	}
>> =20
>>  	return pwm;
>>  }
>> @@ -183,6 +198,7 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struc=
t of_phandle_args *args)
>>  		return pwm;
>> =20
>>  	pwm->args.period =3D args->args[1];
>> +	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);
>> =20
>>  	return pwm;
>>  }
>> @@ -250,6 +266,97 @@ static bool pwm_ops_check(const struct pwm_ops *ops=
)
>>  }
>> =20
>>  /**
>> + * pwm_get_caps() - get PWM capabilities of a PWM device
>> + * @chip: PWM chip
>> + * @pwm: PWM device to get the capabilities for
>> + * @caps: returned capabilities
>> + *
>> + * Returns: 0 on success or a negative error code on failure
>> + */
>> +int pwm_get_caps(struct pwm_chip *chip, struct pwm_device *pwm,
>> +		 struct pwm_caps *caps)
>> +{
>> +	if (!chip || !pwm || !caps)
>> +		return -EINVAL;
>> +
>> +	if (chip->ops && chip->ops->get_caps)
>> +		pwm->chip->ops->get_caps(chip, pwm, caps);
>> +	else if (chip->get_default_caps)
>> +		chip->get_default_caps(caps);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pwm_get_caps);
>=20
> I'm confused by the way ->get_default_caps() is used here. This always
> points at pwmchip_get_default_caps() if I understand correctly, so why
> bother with the indirection?

Yep, looking again at this it also looks ugly to me and I dont't remember
why I chose this approach. I looked over emails and so but didn't manage to
find the reason for this. I agree with you that there is no need to keep a
pointer in struct pwm_chip for this.

>=20
> I think it would be better to either export pwmchip_get_default_caps()
> as a default implementation of ->get_caps(), something like:
>=20
> 	void pwm_get_default_caps(struct pwm_chip *chip, struct pwm_device *pwm,
> 				  struct pwm_caps *caps)
> 	{
> 		...
> 	}
> 	EXPORT_SYMBOL_GPL(pwm_get_default_caps);
>=20
> This could be used by the individual drivers as the implementation if
> they don't support any modes.
>=20
> Another, probably simpler approach would be to just get rid of the
> chip->get_default_caps() pointer and directly call
> pwmchip_get_default_caps() from pwm_get_caps():
>=20
> 	int pwm_get_caps(...)
> 	{
> 		/*
> 		 * Note that you don't need the check for chip->ops because
> 		 * the core checks for that upon registration of the chip.
> 		 */
> 		if (chip->ops->get_caps)
> 			return chip->ops->get_caps(...);
>=20
> 		return pwm_get_default_caps(...);
> 	}
>=20
> And if we do that, might as well fold pwm_get_default_caps() into
> pwm_get_caps().

I am also in favor of this approach.

>=20
>> +/**
>> + * pwm_mode_get_valid() - get the first available valid mode for PWM
>> + * @chip: PWM chip
>> + * @pwm: PWM device to get the valid mode for
>> + *
>> + * Returns: first valid mode for PWM device
>> + */
>> +unsigned long pwm_mode_get_valid(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)
>=20
> This is a little ambiguous. Perhaps pwm_get_default_mode()?


Ok, will change it to pwm_get_default_mode(). I placed pwm_mode in front of
every function in this patch to emphasize the functions are dealing with
PWM modes. But being inside PWM core and using this approach might be
confusing.

>=20
>> +/**
>> + * pwm_mode_valid() - check if mode is valid for PWM device
>> + * @pwm: PWM device
>> + * @mode: PWM mode to check if valid
>> + *
>> + * Returns: true if mode is valid and false otherwise
>> + */
>> +bool pwm_mode_valid(struct pwm_device *pwm, unsigned long mode)
>=20
> Again, this is slightly ambiguous because the name suggests that it
> merely tests a mode for validity, not that it is really supported by the
> given device. Perhaps something like pwm_supports_mode()?

Ok, understand. I'll use pwm_supports_mode() instead.

>=20
>> +const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
>> +{
>> +	static const char * const modes[] =3D {
>> +		"invalid",
>> +		"normal",
>> +		"complementary",
>> +	};
>> +
>> +	if (!pwm_mode_valid(pwm, mode))
>> +		return modes[0];
>> +
>> +	return modes[ffs(mode)];
>> +}
>=20
> Do we really need to be able to get the name of the mode in the context
> of a given PWM channel? Couldn't we drop the pwm parameter and simply
> return the name (pwm_get_mode_name()?) and at the same time remove the
> extra "invalid" mode in there? I'm not sure what the use-case here is,
> but it seems to me like the code should always check for supported modes
> first before reporting their names in any way.

Looking back at this code, the main use case for checking PWM mode validity
in pwm_mode_desc() was only with regards to mode_store(). But there is not
need for this checking since the same thing will be checked in
pwm_apply_state() and, in case user provides an invalid mode via sysfs the
pwm_apply_state() will fail.

To conclude, I will change this function in something like:

if (mode =3D=3D PWM_MODE_NORMAL)
	return "normal";
else if (mode =3D=3D PWM_MODE_COMPLEMENTARY)
	return "complementary";
else if (mode =3D=3D PWM_MODE_PUSH_PULL)
	return "push-pull";
else
	return "invalid";

Please let me know if it is OK for you.

>=20
>> +/**
>>   * pwmchip_add_with_polarity() - register a new PWM chip
>>   * @chip: the PWM chip to add
>>   * @polarity: initial polarity of PWM channels
>> @@ -275,6 +382,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>> =20
>>  	mutex_lock(&pwm_lock);
>> =20
>> +	chip->get_default_caps =3D pwmchip_get_default_caps;
>> +
>>  	ret =3D alloc_pwms(chip->base, chip->npwm);
>>  	if (ret < 0)
>>  		goto out;
>> @@ -294,6 +403,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>>  		pwm->pwm =3D chip->base + i;
>>  		pwm->hwpwm =3D i;
>>  		pwm->state.polarity =3D polarity;
>> +		pwm->state.mode =3D pwm_mode_get_valid(chip, pwm);
>> =20
>>  		if (chip->ops->get_state)
>>  			chip->ops->get_state(chip, pwm, &pwm->state);
>> @@ -469,7 +579,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct p=
wm_state *state)
>>  	int err;
>> =20
>>  	if (!pwm || !state || !state->period ||
>> -	    state->duty_cycle > state->period)
>> +	    state->duty_cycle > state->period ||
>> +	    !pwm_mode_valid(pwm, state->mode))
>>  		return -EINVAL;
>> =20
>>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
>> @@ -530,6 +641,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct p=
wm_state *state)
>> =20
>>  			pwm->state.enabled =3D state->enabled;
>>  		}
>> +
>> +		/* No mode support for non-atomic PWM. */
>> +		pwm->state.mode =3D state->mode;
>=20
> That comment seems misplaced. This is actually part of atomic PWM, so
> maybe just reverse the logic and say "mode support only for atomic PWM"
> or something. I would personally just leave it away.

Ok, sure. I will remove the comment. But the code has to be there to avoid
unassigned mode value for PWM state (normal mode means BIT(0)) and so to
avoid future PWM applies failure.

The legacy API has
> no way of setting the mode, which is indication enough that we don't
> support it.
>=20
>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
>> index 56518adc31dd..a4ce4ad7edf0 100644
>> --- a/include/linux/pwm.h
>> +++ b/include/linux/pwm.h
>> @@ -26,9 +26,32 @@ enum pwm_polarity {
>>  };
>> =20
>>  /**
>> + * PWM modes capabilities
>> + * @PWMC_MODE_NORMAL_BIT: PWM has one output
>> + * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polari=
ties
>> + * @PWMC_MODE_CNT: PWM modes count
>> + */
>> +enum {
>> +	PWMC_MODE_NORMAL_BIT,
>> +	PWMC_MODE_COMPLEMENTARY_BIT,
>> +	PWMC_MODE_CNT,
>> +};
>> +
>> +#define PWMC_MODE(name)		BIT(PWMC_MODE_##name##_BIT)
>=20
> Why the C in the prefix? Why not just PWM_MODE_* for all of the above?

Well... PWM_MODE() macro was already took by pwm-sun4i.c driver at the time
I wrote this patch... So I choose to add extra C to this macro, "C" meaning
"constant" in my mind. I was not sure it was the best solution at that time
either.

>=20
>> +
>> +/**
>> + * struct pwm_caps - PWM capabilities
>> + * @modes: PWM modes
>=20
> This should probably say that it's a bitmask of PWM_MODE_*.

Ok, I'll update.

>=20
>> +struct pwm_caps {
>> +	unsigned long modes;
>> +};
>> +
>> +/**
>>   * struct pwm_args - board-dependent PWM arguments
>>   * @period: reference period
>>   * @polarity: reference polarity
>> + * @mode: reference mode
>=20
> As discussed in my reply to the cover letter, what is the use for the
> reference mode? Drivers want to use either normal or some other mode.
> What good is it to get this from board-dependent arguments if the
> driver already knows which one it wants or needs?

For the moment, no, there is no in-kernel user. Only sysfs. I was thinking
I would also adapt, e.g., the pwm-regulator driver to also make use of this
features in setups like the one described in [1], page 2126
(Figure 56-13: Half-Bridge Converter Application: No Feedback Regulation).
But, for the moment there is no in-kernel user.

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

>=20
>> @@ -300,6 +331,7 @@ struct pwm_chip {
>> =20
>>  	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
>>  					const struct of_phandle_args *args);
>> +	void (*get_default_caps)(struct pwm_caps *caps);
>=20
> As mentioned above, I don't think we need this.

Ok, I'll update.

>=20
> Thierry
>=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
