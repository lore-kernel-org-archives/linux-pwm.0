Return-Path: <mikedunn@newsguy.com>
Message-ID: <522E0D72.3080805@newsguy.com>
Date: Mon, 09 Sep 2013 11:03:30 -0700
From: Mike Dunn <mikedunn@newsguy.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] pwm: pxa: add device tree support to pwm driver
References: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com> <20130909120845.GB22197@ulmo>
In-Reply-To: <20130909120845.GB22197@ulmo>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>

On 09/09/2013 05:08 AM, Thierry Reding wrote:
> On Sun, Sep 08, 2013 at 12:40:18PM -0700, Mike Dunn wrote:
>> This patch adds device tree support to the pxa's pwm driver.  Only an OF match
> 
> "PXA" and "PWM"


OK.  And thank you for the review!


> 
>> table is added; nothing needs to be extracted from the device tree node.  The
>> existing platform_device id table is reused for the match table data.  Support
> 
> "ID table"


OK


> 
>> Changle log:
>> v2:
>> - of_match_table contains only the "pxa250-pwm" compatible string; require one
>>   device instance per pwm
>> - add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> - add support for polarity flag in DT and implement set_polarity() method
>>   (the treo 680 inverts the signal between pwm out and backlight)
>> - return -EINVAL instead of -ENODEV if platform data or DT node not found
>> - output dev_info string if platform data missing
>> - expanded CC list of patch
> 
> I think this needs to be reviewed by the device tree bindings
> maintainers (as listed in MAINTAINERS) as well. Would you mind resending
> the patch with all of them on Cc so that they have full context? Thanks.


You bet.  Sorry... should have checked that.  Adding them to this reply, and
will resend original patch.


> 
>>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 33 +++++++++++++
>>  arch/arm/boot/dts/pxa27x.dtsi                     | 24 ++++++++++
>>  drivers/pwm/pwm-pxa.c                             | 57 +++++++++++++++++++++++
>>  3 files changed, 114 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> new file mode 100644
>> index 0000000..7b09bfa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> @@ -0,0 +1,33 @@
>> +Marvell pwm controller
>> +
>> +Required properties:
>> +- compatible:
>> +  for pxa25x, pxa27x, pxa168, pxa910: must be compatible = "marvell,pxa250-pwm";
>> +- reg: physical base address and length of the registers used by the pwm channel
> 
> "pwm" -> "PWM". There are a few more occurrences that I haven't
> explicitly pointed out.
> 
>> +  NB: One device instance must be created for each pwm that is used, so the
>> +  length covers only the register window for one pwm output, not that of the
>> +  entire pwm controller.  Currently length is 0x10 for all supported devices.
> 
> I'm not sure I like that very much. It seems a wrong representation of
> the hardware for the sake of modifying a smaller number of lines in the
> driver.


I don't like it either, but this is an existing driver defect that will need to
be corrected.  To do so, I will need to to survey all the supported processors
to determine how many pwm outputs is posessed by each.  And there may be some
confusion in that regard; the driver says "pxa25x" has one, but my pxa255
developer's manual makes no mention of a pwm.  The pxa270 I am testing on has
four, but the driver says "pxa27x" has two, so currently (using platform_data
with existing driver) two devices are instantiated, each with two pwms.  It
seems that there are many variations within a single generation of the processor
family, so to correctly identify the number of pwms, processor identification
will have to be made on a finer granularity than the current "pxa25x", for
example.  I'm guessing that the hardware designers had this
one-device-instance-per-pwm approach in mind when they made the decision to
segregate the register sets of each pwm.  I really hope that this sin can be
forgiven :)


> 
>> +- #pwm-cells: should be 3.
>> +   cell 1: the per-chip index of the PWM to use,
>> +   cell 2: the period in nanoseconds,
>> +   cell 3: flags; set bit 0 to specify inverse polarity.  The pwm controller
> 
> This is the standard binding, so you can just refer to the standard
> binding documentation instead, like so:
> 
> 	- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
> 	  the cells format.
> 
>> +   does not implement reverse polarity, but some boards may pass the pwm output
>> +   through an external inverter, which can cause problems if a client device
>> +   assumes that an increase in the duty cycle results in an increase in output
>> +   power.  The pwm-backlight is an example of such a client.
> 
> Please don't do that. Reverse polarity support should not be emulated.
> Either the hardware supports it or it doesn't. In the above case you
> should be able to achieve the same effect by adding the correct values
> in the pwm-backlight device node's brightness-levels property.


That was my initial thought too.  But sadly, that is not the case.  The
pwm-backlight driver assumes that the brightness-levels increase when parsed
from left to right (more specifically, it assumes the last one is max).  If
emulated polarity is unacceptable, the pwm-backlight driver will need some
rework to be usable in my case.  The change looks minor and straightforward at
first glance, though.


> 
>> +Example pwm client node:
>> +
>> +backlight {
>> +      	compatible = "pwm-backlight";
>> +     	pwms = <&pwm0 0 5000000 1>;  /* pwm output is inverted */
>> +	...
> 
> The indentation here is funky. You should be using only tabs to indent.


OK


> 
>> +#ifdef CONFIG_OF
>> +/*
>> + * Device tree users should create one device instance for each pwm channel.
>> + * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the original driver
>> + * code that this is a single channel pxa25x-pwm.
>> + */
>> +static struct of_device_id pwm_of_match[] = {
>> +	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0]},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pwm_of_match);
>> +
>> +static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
>> +{
>> +	const struct of_device_id *pwm_pxa_devid =
>> +		of_match_device(pwm_of_match, dev);
> 
> If you name this variable something much shorter, like "id", this will
> fit on a single line, and the code below will be slightly more readable
> as well.


OK.  I struggle not to be too verbose :)


Thanks again,
Mike
