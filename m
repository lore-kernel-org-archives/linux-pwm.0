From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Date: Wed, 13 Feb 2019 15:37:14 +0000
Message-ID: <213f33f4-319f-46ec-61b8-e42067725e51@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <20190205224906.GD1372@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205224906.GD1372@mithrandir>
Content-Language: en-US
Content-ID: <FB59CEC9DEC16749BDCB6CA623E254FD@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 06.02.2019 00:49, Thierry Reding wrote:
> On Sat, Jan 05, 2019 at 10:05:22PM +0100, Uwe Kleine-K=F6nig wrote:
>> Hello,
>>
>> On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.com w=
rote:
>>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>
>>> Add basic PWM modes: normal and complementary. These modes should
>>> differentiate the single output PWM channels from two outputs PWM
>>> channels. These modes could be set as follow:
>>> 1. PWM channels with one output per channel:
>>> - normal mode
>>> 2. PWM channels with two outputs per channel:
>>> - normal mode
>>> - complementary mode
>>> Since users could use a PWM channel with two output as one output PWM
>>> channel, the PWM normal mode is allowed to be set for PWM channels with
>>> two outputs; in fact PWM normal mode should be supported by all PWMs.
>>
>> I still think that my suggestion that I sent in reply to your v5 using
>> .alt_duty_cycle and .alt_offset is the better one as it is more generic.
>> A word about that from Thierry before putting the mode into the pwm API
>> would be great.
>>
>> I don't repeat what I wrote there assuming you still remember or are
>> willing to look it up at
>> e.g. https://www.spinics.net/lists/linux-pwm/msg08174.html (in the 2nd h=
alf
>> of my mail).
>=20
> The problem I see with .alt_duty_cycle and .alt_offset is that they
> provide too much flexibility in my opinion. There may be some variance
> in how the values are computed for the different modes and that just
> leads to additional code required in drivers to figure out what exactly
> the user wanted.

This is also my feeling. And I don't know how many controllers support
having this. E.g. on the IP I'm working on (the Atmel one) the dead times
have limited values, so that it cannot model all the possible delays b/w
outputs.

>=20
> If we only provide the user with a means to say which mode they want to
> operate the PWM in they can just tell us and the driver doesn't have to
> guess which one was meant.
>=20
> It also makes validation easier. We can check for capabilites upfront by
> just comparing a list of supported modes. With .alt_duty_cycle and
> .alt_offset we'd actually need to run code to figure out whether or not
> the given set of values corresponds to a supported configuration.
>=20
>> Also I think that if the capabilities function is the way forward adding
>> support to detect availability of polarity inversion should be
>> considered. This would also be an opportunity to split the introduction
>> of the capabilities function and the introduction of complementary mode.
>> (But my personal preference would be to just let .apply fail when an
>> unsupported configuration is requested.)
>>
>>> +static int pwm_get_default_caps(struct pwm_caps *caps)
>>> +{
>>> +	static const struct pwm_caps default_caps =3D {
>>> +		.modes_msk =3D PWM_MODE_BIT(NORMAL),
>>> +	};
>>> +
>>> +	if (!caps)
>>> +		return -EINVAL;
>>> +
>>> +	*caps =3D default_caps;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * pwm_get_caps() - get PWM capabilities of a PWM device
>>> + * @pwm: PWM device to get the capabilities for
>>> + * @caps: returned capabilities
>>> + *
>>> + * Returns: 0 on success or a negative error code on failure
>>> + */
>>> +int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps)
>>> +{
>>> +	if (!pwm || !caps)
>>> +		return -EINVAL;
>>> +
>>> +	if (pwm->chip->ops->get_caps)
>>> +		return pwm->chip->ops->get_caps(pwm->chip, pwm, caps);
>>> +
>>> +	return pwm_get_default_caps(caps);
>>
>> I'd drop pwm_get_default_caps (unless you introduce some more callers
>> later) and fold its implementation into pwm_get_caps.
>=20
> I think Claudiu and I may have talked past one another here. What I was
> suggesting was to make pwm_get_default_caps() an exported symbol so that
> drivers could use it if they didn't have extra capabilities. However, it
> seems like just handling that in pwm_get_caps() if ops->get_caps =3D=3D N=
ULL
> works just as well. I don't think it needs to be a different function in
> this case, but I don't mind if it is.
>=20
>>> +}
>>> +EXPORT_SYMBOL_GPL(pwm_get_caps);
>>> [...]
>>> @@ -53,12 +75,14 @@ enum {
>>>   * @period: PWM period (in nanoseconds)
>>>   * @duty_cycle: PWM duty cycle (in nanoseconds)
>>>   * @polarity: PWM polarity
>>> + * @modebit: PWM mode bit
>>>   * @enabled: PWM enabled status
>>>   */
>>>  struct pwm_state {
>>>  	unsigned int period;
>>>  	unsigned int duty_cycle;
>>>  	enum pwm_polarity polarity;
>>> +	unsigned long modebit;
>>
>> I fail to see the upside of storing the mode as 2^mode instead of a
>> plain enum pwm_mode. Given that struct pwm_state is visible for pwm
>> users a plain pwm_mode would at least be more intuitive.
>=20
> Agreed, we should have only the specific mode in the state and let the
> core deal with masks where necessary.

Good, I will rework this.

Thank you,
Claudiu Beznea

>=20
> Thierry
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
