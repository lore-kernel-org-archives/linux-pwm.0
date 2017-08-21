From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 0/2] extend PWM framework to support PWM dead-times
Date: Mon, 21 Aug 2017 13:23:08 +0300
Message-ID: <d7dafc19-5a35-78cf-cad2-6770e09bc03f@microchip.com>
References: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
 <20170821082527.GQ18996@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821082527.GQ18996@ulmo>
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

Thank you for your response. I added few comments below.

Thank you,
Claudiu

On 21.08.2017 11:25, Thierry Reding wrote:
> On Tue, May 09, 2017 at 03:15:51PM +0300, Claudiu Beznea wrote:
>> Hi all,
>>
>> Please give feedback on these patches which extends the PWM
>> framework in order to support multiple PWM signal types.
>> Since I didn't receive any inputs on RFC series I'm resending it as
>> normal patch series.
>>
>> The current patch series add the following PWM signal types:
>> - PWM complementary signals
>> - PWM push-pull signal
>>
>> Definition of PWM complementary mode:
>> For a PWM controllers with more than one outputs per PWM channel,
>> e.g. with 2 outputs per PWM channels, the PWM complementary signals
>> have opposite levels, same duration and same starting times,
>> as in the following diagram:
>>
>>         __    __    __    __
>> PWMH __|  |__|  |__|  |__|  |__
>>      __    __    __    __    __
>> PWML   |__|  |__|  |__|  |__|
>>        <--T-->
>> Where T is the signal period.
>>
>> Definition of PWM push-pull mode:
>> For PWM controllers with more than one outputs per PWM channel,
>> e.g. with 2 outputs per PWM channel, the PWM push-pull signals
>> have same levels, same duration and are delayed until the begining
>> of the next period, as in the following diagram:
>>
>>         __          __
>> PWMH __|  |________|  |________
>>               __          __
>> PWML ________|  |________|  |__
>>        <--T-->
>>
>> Where T is the signal period.
>>
>> These output signals could be configured by setting PWM mode
>> (a new input in sysfs has been added in order to support this
>> operation).
>>
>> root@sama5d2-xplained:/sys/devices/platform/ahb/ahb:apb/f802c000.pwm/pwm/pwmchip0/pwm2# ls -l
>> -r--r--r--    1 root     root          4096 Feb  9 10:54 capture
>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 duty_cycle
>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 enable
>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 mode
>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 period
>> -rw-r--r--    1 root     root          4096 Feb  9 10:55 polarity
>> drwxr-xr-x    2 root     root             0 Feb  9 10:54 power
>> -rw-r--r--    1 root     root          4096 Feb  9 10:54 uevent
>>
>> The PWM push-pull mode could be usefull in applications like
>> half bridge converters.
> 
> Sorry for taking an absurdly long time to get back to you on this.
> 
> One problem I see with this is that the PWM framework is built on the
> assumption that we have a single output per PWM channel. This becomes
> important when you start adding features such as this because now the
> users have no way of determining whether or not the PWM they retrieve
> will actually be able to do what they want.
I was thinking that the framework is there to offer support in configuring
the underlying hardware without taking into account how many outputs per
PWM channels are actually present. It is true I only worked with Atmel/Microchip
PWM controllers which for instance, SAMA5 SoC has a PWM controller
with 2 outputs per PWM channel. Taking into account that the driver is
already mainlined I though that the user is aware of what he is using
(either a one output per PWM channel controller, or 2 outputs or
more than 2) and about the underlying hardware support. I understand your
position on this. I'm just explaining myself on the approach I've chose
for this implementation.

> 
> For example, let's say you have a half bridge converter driver in the
> kernel and it does a pwm_get() to obtain a PWM to use. There's nothing
> preventing it from using a simple one-output PWM and there's no way to
> check that we're actually doing something wrong.
I understand your position here. I've chose this approach taking into
account that the user of the PWM will be aware of the capabilities
of the underlying hardware because I worked on a controller which already
has a mainlined driver and which has more than one output per PWM channel
and I believe there are also other controllers with this kind of capability
and with already mainlined driver (e.g. reading the code of STM32 PWM driver
I saw a bool type variable in driver specific data structure (struct stm32_pwm):
"bool have_complementary_output" which let me think that their controller
also could support more than one output per PWM channel (I will also try
to find the controller specific datasheet). At a first look I saw that also
TI ECAP PWM controller supports this (it is true that I am not aware of how
it is initialized in kernel, I need to check the datasheet, if it is public).
 
> 
> I think any in-kernel API would have to be more fully-featured,
> otherwise we're bound to run into problems. At the very least I think
> we'd have to expose some sort of capabilities list.
About the exposing of these capabilities would you prefer to have the
supported PWM modes registered in driver probe as a new field mask
in "struct pwm_chip". e.g.:
struct pwm_chip {
        struct device *dev;
        struct list_head list;
        const struct pwm_ops *ops;
        int base;
        unsigned int npwm;
	unsigned int pwm_modes_mask;	/* bitfield of supported signal types */

        struct pwm_device *pwms;

        struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
                                        const struct of_phandle_args *args);
        unsigned int of_pwm_n_cells;
};

And having in driver_probe() something like this:
driver_data->pwm_chip.pwm_modes = PWM_COMPLEMENTARY_MODE | PWM_PUSH_PULL_MODE;
pwmchip_add(&driver_data->chip);
Since the PWM push-pull mode imply more than one output per PWM channel. And
validate the supported PWM modes when trying to configure one.

Or registering, as a field in pwm_chip, how many outputs per channel are actually
supported by the PWM controller and then validate the supported PWM mode based
on this?
e.g.:
in "struct pwm_chip". e.g.:
struct pwm_chip {
        struct device *dev;
        struct list_head list;
        const struct pwm_ops *ops;
        int base;
        unsigned int npwm;
	unsigned int pwm_outputs;	/* Number of supported outputs per channel */

        struct pwm_device *pwms;

        struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
                                        const struct of_phandle_args *args);
        unsigned int of_pwm_n_cells;
};

In driver_probe():
//...
driver_data->pwm_chip.pwm_outputs = 2; /* 2 outputs per PWM channel. */
pwmchip_add(&driver_data->chip);

> 
> A possibly simpler approach might be to restrict this to the driver that
> you need this for. It looks like you will be mainly using this via sysfs
> and in that case you might be able to just extend what information is
> exposed in sysfs for the particular PWM you're dealing with.
By this you mean exporting the sysfs attributes only for my driver or possibly
other drivers interested in this new feature? I may have another in kernel driver
which may try to use this feature.

Thank you,
Claudiu
> 
> Thierry
> 
