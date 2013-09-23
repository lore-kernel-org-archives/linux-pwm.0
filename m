Return-Path: <sylvester.nawrocki@gmail.com>
Return-Path: <sylvester.nawrocki@gmail.com>
Message-ID: <5240A41A.6050207@gmail.com>
Date: Mon, 23 Sep 2013 22:27:06 +0200
From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Subject: Re: V2: Agenda for the Edinburgh mini-summit
References: <201309101134.32883.hansverk@cisco.com> <52405427.6000002@samsung.com> <52406E5C.2020709@schinagl.nl>
In-Reply-To: <52406E5C.2020709@schinagl.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Oliver Schinagl <oliver+list@schinagl.nl>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hansverk@cisco.com>, "media-workshop@linuxtv.org" <media-workshop@linuxtv.org>, Sakari Ailus <sakari.ailus@iki.fi>, Thierry Reding <thierry.reding@gmail.com>, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On 09/23/2013 06:37 PM, Oliver Schinagl wrote:
> On 09/23/13 16:45, Sylwester Nawrocki wrote:
>> Hi,
>>
>> I would like to have a short discussion on LED flash devices support
>> in the kernel. Currently there are two APIs: the V4L2 and LED class
>> API exposed by the kernel, which I believe is not good from user space
>> POV. Generic applications will need to implement both APIs. I think we
>> should decide whether to extend the led class API to add support for
>> more advanced LED controllers there or continue to use the both APIs
>> with overlapping functionality.
>> There has been some discussion about this on the ML, but without any
>> consensus reached [1].
>
> What about the linux-pwm framework and its support for the backlight via
> dts?
>
> Or am I talking way to uninformed here. Copying backlight to flashlight
> with some minor modification sounds sensible in a way...

I'd assume we don't need yet another user interface for the LEDs ;) AFAICS
the PWM subsystem exposes pretty much raw interface in sysfs. The PWM LED
controllers are already handled in the leds-class API, there is the 
leds_pwm
driver (drivers/leds/leds-pwm.c).

I'm adding linux-pwm and linux-leds maintainers at Cc so someone may correct
me if I got anything wrong.

Presumably, what we need is a few enhancements to support in a standard way
devices like MAX77693, LM3560 or MAX8997.  There is already a led class 
driver
for the MAX8997 LED controller (drivers/leds/leds-max8997.c), but it 
uses some
device-specific sysfs attributes.

Thus similar devices are currently being handled by different subsystems.
The split between the V4L2 Flash and the leds class API WRT to Flash LED
controller drivers is included in RFC [1], it seems still up to date.


>> [1] http://www.spinics.net/lists/linux-leds/msg00899.html

--
Thanks,
Sylwester
