From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 0/2] extend PWM framework to support PWM dead-times
Date: Tue, 22 Aug 2017 15:11:16 +0300
Message-ID: <79aef372-f9de-89c4-27ea-d0c3bf679d9f@microchip.com>
References: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
 <20170821082527.GQ18996@ulmo>
 <d7dafc19-5a35-78cf-cad2-6770e09bc03f@microchip.com>
 <20170821112542.GA15750@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821112542.GA15750@ulmo>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: mark.rutland@arm.com, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

I added few other comments below. Please let me know what you think.

Thank you,
Claudiu

On 21.08.2017 14:25, Thierry Reding wrote:
> On Mon, Aug 21, 2017 at 01:23:08PM +0300, m18063 wrote:
>> Hi Thierry,
>>
>> Thank you for your response. I added few comments below.
>>
>> Thank you,
>> Claudiu
>>
>> On 21.08.2017 11:25, Thierry Reding wrote:
>>> On Tue, May 09, 2017 at 03:15:51PM +0300, Claudiu Beznea wrote:
>>>> Hi all,
>>>>
>>>> Please give feedback on these patches which extends the PWM
>>>> framework in order to support multiple PWM signal types.
>>>> Since I didn't receive any inputs on RFC series I'm resending it as
>>>> normal patch series.
>>>>
>>>> The current patch series add the following PWM signal types:
>>>> - PWM complementary signals
>>>> - PWM push-pull signal
>>>>
>>>> Definition of PWM complementary mode:
>>>> For a PWM controllers with more than one outputs per PWM channel,
>>>> e.g. with 2 outputs per PWM channels, the PWM complementary signals
>>>> have opposite levels, same duration and same starting times,
>>>> as in the following diagram:
>>>>
>>>>         __    __    __    __
>>>> PWMH __|  |__|  |__|  |__|  |__
>>>>      __    __    __    __    __
>>>> PWML   |__|  |__|  |__|  |__|
>>>>        <--T-->
>>>> Where T is the signal period.
>>>>
>>>> Definition of PWM push-pull mode:
>>>> For PWM controllers with more than one outputs per PWM channel,
>>>> e.g. with 2 outputs per PWM channel, the PWM push-pull signals
>>>> have same levels, same duration and are delayed until the begining
>>>> of the next period, as in the following diagram:
>>>>
>>>>         __          __
>>>> PWMH __|  |________|  |________
>>>>               __          __
>>>> PWML ________|  |________|  |__
>>>>        <--T-->
>>>>
>>>> Where T is the signal period.
>>>>
>>>> These output signals could be configured by setting PWM mode
>>>> (a new input in sysfs has been added in order to support this
>>>> operation).
>>>>
>>>> root@sama5d2-xplained:/sys/devices/platform/ahb/ahb:apb/f802c000.pwm/pwm/pwmchip0/pwm2# ls -l
>>>> -r--r--r--    1 root     root          4096 Feb  9 10:54 capture
>>>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 duty_cycle
>>>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 enable
>>>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 mode
>>>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 period
>>>> -rw-r--r--    1 root     root          4096 Feb  9 10:55 polarity
>>>> drwxr-xr-x    2 root     root             0 Feb  9 10:54 power
>>>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 uevent
>>>>
>>>> The PWM push-pull mode could be usefull in applications like
>>>> half bridge converters.
>>>
>>> Sorry for taking an absurdly long time to get back to you on this.
>>>
>>> One problem I see with this is that the PWM framework is built on the
>>> assumption that we have a single output per PWM channel. This becomes
>>> important when you start adding features such as this because now the
>>> users have no way of determining whether or not the PWM they retrieve
>>> will actually be able to do what they want.
>> I was thinking that the framework is there to offer support in configuring
>> the underlying hardware without taking into account how many outputs per
>> PWM channels are actually present. It is true I only worked with Atmel/Microchip
>> PWM controllers which for instance, SAMA5 SoC has a PWM controller
>> with 2 outputs per PWM channel. Taking into account that the driver is
>> already mainlined I though that the user is aware of what he is using
>> (either a one output per PWM channel controller, or 2 outputs or
>> more than 2) and about the underlying hardware support. I understand your
>> position on this. I'm just explaining myself on the approach I've chose
>> for this implementation.
> 
> So currently we assume that there will be (at least) one output per PWM
> channel. However there are currently no drivers that actually use any
> output other than the "primary" one.
> 
> That means, even if there are currently PWM controllers that support
> multiple outputs per PWM channel, we have no code making assumptions
> about it.
> 
> Before we can add code that makes any assumptions about the number of
> outputs per PWM channel, we have to add facitilities for such code to
> detect capabilities, so that they can deal with PWMs that don't match
> what they need.
> 
>>> For example, let's say you have a half bridge converter driver in the
>>> kernel and it does a pwm_get() to obtain a PWM to use. There's nothing
>>> preventing it from using a simple one-output PWM and there's no way to
>>> check that we're actually doing something wrong.
>> I understand your position here. I've chose this approach taking into
>> account that the user of the PWM will be aware of the capabilities
>> of the underlying hardware because I worked on a controller which already
>> has a mainlined driver and which has more than one output per PWM channel
>> and I believe there are also other controllers with this kind of capability
>> and with already mainlined driver (e.g. reading the code of STM32 PWM driver
>> I saw a bool type variable in driver specific data structure (struct stm32_pwm):
>> "bool have_complementary_output" which let me think that their controller
>> also could support more than one output per PWM channel (I will also try
>> to find the controller specific datasheet). At a first look I saw that also
>> TI ECAP PWM controller supports this (it is true that I am not aware of how
>> it is initialized in kernel, I need to check the datasheet, if it is public).
> 
> Yes, it's quite possible that many of the controllers we currently
> support have this feature or not. But that's not really relevant. The
> only important bit is that none of the users know about it. We don't
> have the means to configure anything beyond just one output. So the only
> guarantee you will get with the current framework is that there will be
> one output signal per PWM channel.
> 
>>> I think any in-kernel API would have to be more fully-featured,
>>> otherwise we're bound to run into problems. At the very least I think
>>> we'd have to expose some sort of capabilities list.
>> About the exposing of these capabilities would you prefer to have the
>> supported PWM modes registered in driver probe as a new field mask
>> in "struct pwm_chip". e.g.:
>> struct pwm_chip {
>>         struct device *dev;
>>         struct list_head list;
>>         const struct pwm_ops *ops;
>>         int base;
>>         unsigned int npwm;
>> 	unsigned int pwm_modes_mask;	/* bitfield of supported signal types */
>>
>>         struct pwm_device *pwms;
>>
>>         struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
>>                                         const struct of_phandle_args *args);
>>         unsigned int of_pwm_n_cells;
>> };
>>
>> And having in driver_probe() something like this:
>> driver_data->pwm_chip.pwm_modes = PWM_COMPLEMENTARY_MODE | PWM_PUSH_PULL_MODE;
>> pwmchip_add(&driver_data->chip);
>> Since the PWM push-pull mode imply more than one output per PWM channel. And
>> validate the supported PWM modes when trying to configure one.
>>
>> Or registering, as a field in pwm_chip, how many outputs per channel are actually
>> supported by the PWM controller and then validate the supported PWM mode based
>> on this?
>> e.g.:
>> in "struct pwm_chip". e.g.:
>> struct pwm_chip {
>>         struct device *dev;
>>         struct list_head list;
>>         const struct pwm_ops *ops;
>>         int base;
>>         unsigned int npwm;
>> 	unsigned int pwm_outputs;	/* Number of supported outputs per channel */>>
>>         struct pwm_device *pwms;
>>
>>         struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
>>                                         const struct of_phandle_args *args);
>>         unsigned int of_pwm_n_cells;
>> };
>>
>> In driver_probe():
>> //...
>> driver_data->pwm_chip.pwm_outputs = 2; /* 2 outputs per PWM channel. */
>> pwmchip_add(&driver_data->chip);
> 
> I think I'd prefer something more flexible. I also think this can't be
> per-chip, but really has to be at the granularity of single PWM
> channels. How about something like this:
> 
> 	struct pwm_caps {
> 		...
> 	};
> 
> 	int pwm_get_caps(struct pwm_device *pwm, struct pwm_caps *caps);
> 
> From a high-level perspective that would give users an easy way to
> obtain the capabilities of the PWM they're handed.
I forgot to mention, I don't know if you had time to look over the other
patch series I send to extend the PWM framework:
"[PATCH v2 0/2] extends PWM framework to support PWM dead-times"
(v2 since the auto build robot prompted me some compilation errors).
In that series I proposed some extensions to be able to configure
dead-times for PWM channels. Those changes are also specific to PWM
controllers which has more than 1 output per PWM channel. Taking into
account that:
- this is also specific to PWM controllers with more than 1 output per
PWM channel and
- your proposed below to introduce capabilities specific to more than
one output per PWM channel and not to introduce something to specify that
the PWM chip or PWM device supports a number of X outputs per PWM channel and
- PWM dead-time is, in my opinion, some kind of PWM push-pull mode with
lower delays b/w the edges of complementary outputs: 
Do you think it would be ok (in order to also have a way to configure
PWM dead-times) to merge the changes of
"[PATCH v2 0/2] extends PWM framework to support PWM dead-times" with the
changes that I will do for push-pull mode (with your below proposals)
and have a single PWM mode for both PWM push-pull and PWM dead-times
(e.g. the PWM_MODE_PUSH_PULL) and to have an interface which could be used
to configure the dead-times that will work only when the PWM device supports
push-pull mode and is configured in push-pull mode?
Something like this:

root@sama5d2-xplained:/sys/devices/platform/ahb/ahb:apb/f802c000.pwm/pwm/pwmchip0/pwm2# ls -l
-r--r--r--    1 root     root          4096 Feb  9 10:54 capture
-rw-r--r--    1 root     root          4096 Feb  9 10:54 duty_cycle
-rw-r--r--    1 root     root          4096 Feb  9 10:54 deadtime_re	<<<< interface for configuring dead-time rising edge delay 
-rw-r--r--    1 root     root          4096 Feb  9 10:54 deadtime_fe	<<<< interface for configuring dead-time falling edge delay
-rw-r--r--    1 root     root          4096 Feb  9 10:54 enable
-rw-r--r--    1 root     root          4096 Feb  9 10:54 mode		<<<< interface for PWM mode configuration
-rw-r--r--    1 root     root          4096 Feb  9 10:54 period
-rw-r--r--    1 root     root          4096 Feb  9 10:55 polarity
drwxr-xr-x    2 root     root             0 Feb  9 10:54 power
-rw-r--r--    1 root     root          4096 Feb  9 10:54 uevent

When user switch to push-pull mode it could start configure
the dead-times (in nanoseconds) to obtain a signal of a form similar to:
                      ____0    D____P     ____      ____      ____
        PWM signal __|    |____|    |____|    |____|    |____|    |___
                        __        __        __        __        __
              PWMH ____|  |____re|  |______|  |______|  |______|  |___
                   __        __        __        __        __        __
              PWML   |______|  |____fe|  |______|  |______|  |______|

(see "[PATCH v2 0/2] extends PWM framework to support PWM dead-times" cover
letter),
and starting from a driver specific dead-time value (e.g. on Atmel/Microchip
PWM controller starting with a dead-time value of ~0.05 microseconds) the PWM
outputs to actually switch to PWM push-pull mode (in this mode there is a delay
of a period introduce on a PWM ouptut) to obtain a signal similar to this one:
         __          __
 PWMH __|  |________|  |________
               __          __
 PWML ________|  |________|  |__
        <--T-->

Then we can start
> filling in that structure.
> 
> 	struct pwm_caps {
> 		unsigned long modes;
> 	};
> 
> 	#define PWM_MODE_NORMAL (1 << 0)
> 	#define PWM_MODE_COMPLEMENTARY (1 << 1)
> 	#define PWM_MODE_PUSH_PULL (1 << 2)
> 
> 	static inline bool pwm_caps_supports_mode(const struct pwm_caps *caps,
> 						  unsigned long mode)
> 	{
> 		return (caps->modes & mode) != 0;
> 	}
> 
> and maybe something like this as a shortcut:
> 
> 	static inline bool pwm_supports_mode(struct pwm_device *pwm,
> 					     unsigned long mode)
> 	{
> 		struct pwm_caps caps;
> 		int err;
> 
> 		err = pwm_get_caps(pwm, &caps);
> 		if (err < 0)
> 			return false;
> 
> 		return pwm_caps_supports_mode(&caps, mode);
> 	}
> 
> I think that gives us a lot of flexibility and easy extensibility for
> other capabilities. The implementation of pwm_get_caps() should probably
> call back into the driver.> 
> But that would cause a lot of boilerplate for simple cases, and would be
> a lot of work to convert all existing drivers up front. So I think we
> can add helpers to solve the normal cases. Something along these lines
> perhaps:
> 
> 	struct pwm_chip {
> 		...
> 
> 		int (*get_caps)(struct pwm_device *pwm, struct pwm_caps *caps);
> 
> 		const struct pwm_caps *caps;
> 	};
> 
> 	static int pwm_simple_get_caps(struct pwm_device *pwm, struct pwm_caps *caps)
> 	{
> 		if (!pwm || !caps || !pwm->chip->caps)
> 			return -EINVAL;
> 
> 		*caps = *pwm->chip->caps;
> 
> 		return 0;
> 	}
> 
> And then perhaps even do something like this:
> 
> 	const struct pwm_caps pwm_default_caps = {
> 		.modes = PWM_MODE_NORMAL,
> 	};
> > Now we can either have a patch that sets pwm_default_caps and
> pwm_simple_get_caps() for all existing drivers, or even easier add this
> to the pwmchip_add_with_polarity() function:
> 
> 	int pwmchip_add_with_polarity(struct pwm_chip *chip,
> 				      enum pwm_polarity polarity)
> 	{
> 		...
> 
> 		if (!chip->get_caps && !chip->caps) {
> 			chip->get_caps = pwm_simple_get_caps;
> 			chip->caps = pwm_default_caps;
> 		}
> 
> 		...
> 	}
> 
What about having a new member in "struct pwm_ops" something like this:
struct pwm_ops {
// ...
	int (*get_caps)(struct pwm_chip *chip, struct pwm_device *pwm, struct pwm_caps *caps);
// ...
};
to get from the driver the per PWM capabilities.

And maybe to have, in core.c:
int pwm_get_caps(struct pwm_device *pwm, struct pwm_caps *caps)
{
	struct pwm_chip *chip = pwm->chip;
	int ret = 0;

	if (!pwm || !chip || !chip->ops || !caps)
		return -EINVAL;

	if (chip->ops->get_caps)
		ret = chip->ops->get_caps(chip, pwm, caps);
	else
		caps = &pwm_default_caps;

	return ret;
}

> That way, every driver, unless upgraded with a custom ->get_caps() would
> get the defaults, which encode the current assumptions of the framework.
> 
> I think what we'd also want to do is make sure that every driver always
> at least implement NORMAL mode and perhaps even fail to register those
> that don't. Not sure we want to go that far, but those are the current
> assumptions, so devices must be supporting it already anyway.
> 
>>> A possibly simpler approach might be to restrict this to the driver that
>>> you need this for. It looks like you will be mainly using this via sysfs
>>> and in that case you might be able to just extend what information is
>>> exposed in sysfs for the particular PWM you're dealing with.
>> By this you mean exporting the sysfs attributes only for my driver or possibly
>> other drivers interested in this new feature? I may have another in kernel driver
>> which may try to use this feature.
> 
> If you've got another driver that will want to use this, I'm leaning
> towards going with the fully featured approach.
I'm thinking at PWM regulator driver. I worked lately on adding code to PWM
framework in order to support what our PWM controller calls PWM triggers.
These are external input received directly by the PWM controller which let
it change the PWM output waveform, as long as the trigger is active, only
at the controller level (no interaction with kernel code interaction -
no IRQ received on trigger activation).
This could be used, e.g., in regulators with feedback. I'm thinking that this
could be useful for PWM regulator driver when it is using a PWM channel
in push-pull mode and with trigger configuration.

I have create that code on top of push-pull mode modifications since
I want to take advantage of push-pull mode while using PWM triggers.
Of course this is something I didn't introduce (I can give more details
on this if you want).

Thank you,
Claudiu

Ideally you would try to
> implement both at once so we can get a better feeling about whether or
> not the framework changes are adequate to cover at least the first two
> cases, which is much more reassuring than just being able to cover a
> single case.
> 
> One thing to consider is still that if you only use this from sysfs,
> it'll be quite a lot of work to add in-kernel infrastructure when it's
> never needed. There's still an advantage to do it anyway because it
> allows us to abstract everything away properly from the start and avoid
> fragmentation of the sysfs interface.
> 
> Thierry
> 
