From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is
 zero
Date: Mon, 20 Jun 2016 14:29:12 +0800
Message-ID: <9d79cc78-ef51-9461-c6dc-8a28945440ee@electromag.com.au>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
 <20160609135125.GA2385@dell> <20160610072346.51b0a5d5@ipc1.ka-ro>
 <20160610074449.GB1537@dell> <20160610123453.3a8ee14e@ipc1.ka-ro>
 <20160610145449.GA7351@dell> <20160611090803.42aeaf5f@ipc1.ka-ro>
 <20160617141719.GH21702@dell> <20160620082118.10a639d5@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:51145 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752010AbcFTGgB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jun 2016 02:36:01 -0400
In-Reply-To: <20160620082118.10a639d5@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Lee Jones <lee.jones@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On 20/06/2016 14:21, Lothar Wa=C3=9Fmann wrote:
> Hi,
>
> On Fri, 17 Jun 2016 15:17:19 +0100 Lee Jones wrote:
>> On Sat, 11 Jun 2016, Lothar Wa=C3=9Fmann wrote:
>>> On Fri, 10 Jun 2016 15:54:49 +0100 Lee Jones wrote:
>>>> On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:
>>>>> On Fri, 10 Jun 2016 08:44:49 +0100 Lee Jones wrote:
>>>>>> On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Thu, 9 Jun 2016 14:51:25 +0100 Lee Jones wrote:
>>>>>>>> On Tue, 07 Jun 2016, Lothar Wa=C3=9Fmann wrote:
>>>>>>>>
>>>>>>>>> 'brightness' is usually an index into a table of duty_cycle v=
alues,
>>>>>>>>> where the value at index 0 may well be non-zero
>>>>>>>>> (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are =
real-life
>>>>>>>>> examples).
>>>>>>>>> Thus brightness =3D=3D 0 does not necessarily mean that the P=
WM output
>>>>>>>>> will be inactive.
>>>>>>>>> Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=3D=
 0' to decide
>>>>>>>>> whether to disable the PWM.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
>>>>>>>>> ---
>>>>>>>>> Changes wrt. v1:
>>>>>>>>>   - update binding docs to reflect the change
>>>>>>>>>
>>>>>>>>>  .../devicetree/bindings/leds/backlight/pwm-backlight.txt    =
     | 9 ++++++---
>>>>>>>>>  drivers/video/backlight/pwm_bl.c                            =
     | 4 ++--
>>>>>>>>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight=
/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/p=
wm-backlight.txt
>>>>>>>>> index 764db86..95fa8a9 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-ba=
cklight.txt
>>>>>>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-ba=
cklight.txt
>>>>>>>>> @@ -4,10 +4,13 @@ Required properties:
>>>>>>>>>    - compatible: "pwm-backlight"
>>>>>>>>>    - pwms: OF device-tree PWM specification (see PWM binding[=
0])
>>>>>>>>>    - brightness-levels: Array of distinct brightness levels. =
Typically these
>>>>>>>>> -      are in the range from 0 to 255, but any range starting=
 at 0 will do.
>>>>>>>>> +      are in the range from 0 to 255, but any range will do.
>>>>>>>>>        The actual brightness level (PWM duty cycle) will be i=
nterpolated
>>>>>>>>> -      from these values. 0 means a 0% duty cycle (darkest/of=
f), while the
>>>>>>>>> -      last value in the array represents a 100% duty cycle (=
brightest).
>>>>>>>>> +      from these values. 0 means a 0% duty cycle, while the =
highest value in
>>>>>>>>> +      the array represents a 100% duty cycle.
>>>>>>>>> +      The range may be in reverse order (starting with the m=
aximum duty cycle
>>>>>>>>> +      value) to create a PWM signal with the 100% duty cycle=
 representing
>>>>>>>>> +      minimum and 0% duty cycle maximum brigthness.
>>>>>>>>>    - default-brightness-level: the default brightness level (=
index into the
>>>>>>>>>        array defined by the "brightness-levels" property)
>>>>>>>>>    - power-supply: regulator for supply voltage
>>>>>>>>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video=
/backlight/pwm_bl.c
>>>>>>>>> index b2b366b..80b2b52 100644
>>>>>>>>> --- a/drivers/video/backlight/pwm_bl.c
>>>>>>>>> +++ b/drivers/video/backlight/pwm_bl.c
>>>>>>>>> @@ -103,8 +103,8 @@ static int pwm_backlight_update_status(st=
ruct backlight_device *bl)
>>>>>>>>>  	if (pb->notify)
>>>>>>>>>  		brightness =3D pb->notify(pb->dev, brightness);
>>>>>>>>>
>>>>>>>>> -	if (brightness > 0) {
>>>>>>>>> -		duty_cycle =3D compute_duty_cycle(pb, brightness);
>>>>>>>>> +	duty_cycle =3D compute_duty_cycle(pb, brightness);
>>>>>>>>> +	if (duty_cycle > 0) {
>>>>>>>>
>>>>>>>> How does this work in the aforementioned:
>>>>>>>>
>>>>>>>>   "The range may be in reverse order"
>>>>>>>>
>>>>>>>> ... case?  Surely when duty_cycle is when the screen should be=
 at it's
>>>>>>>> brightest?  Wouldn't it confuse the user if they turn their br=
ightness
>>>>>>>> *up* and the screen goes *off*?
>>>>>>>>
>>>>>>> Assuming that the PWM output is inactive (LOW) when the duty_cy=
cle is
>>>>>>> set to zero, there will be no difference between operating the =
PWM at
>>>>>>> duty_cycle 0 or disabling it.
>>>>>>>
>>>>>>> Currently, the screen will go bright when it should be off in t=
his
>>>>>>> case.
>>>>>>
>>>>>> It sounds like we need something that lets the framework know if
>>>>>> duty_cycle =3D MAX is the brightest or if duty_cycle =3D 0 is.  =
Either way
>>>>>> someone is going to get screwed by this logic.
>>>>>>
>>>>> The backlight framework does not (and does not need to) know anyt=
hing
>>>>> about PWM duty cycles. Its 'brightness' values are consistently 0=
 =3D=3D
>>>>> dark, max =3D=3D brightest in either case.
>>>>
>>>> What I'm getting at is; by the look of the documentation, the
>>>> brightest setting can either be a duty cycle of 0 or 255.  So what
>>>> happens with your new semantics when the duty cycle of 0 represent=
s
>>>> the brightest setting and you reach 0?  Didn't you just turn the
>>>> backlight off?
>>>>
>>> As mentioned earlier, disabling the PWM has generally the same resu=
lt as
>>> setting the duty cycle to 0. The current behaviour is broken in thi=
s
>>> case, since setting brightness to 0 with a non-zero duty_cycle as t=
he
>>> first element of brightness-levels, the PWM will be disabled rather=
 than
>>> switched to the given duty cycle.
>>> Disabling the PWM should have the same effect as setting the duty c=
ycle
>>> to 0, so it is safe to check for duty_cycle =3D=3D 0 to decide whet=
her to
>>> disable the PWM.
>>
>> I agree with this. BUT, that's not what you're doing is it?
>>
>> Look at the code you're trying to write:
>>
>> duty_cycle =3D compute_duty_cycle(pb, brightness);
>> if (duty_cycle > 0) {
>>         pwm_config(pb->pwm, duty_cycle, pb->period);
>>         pwm_backlight_power_on(pb, brightness);
>> } else
>>         pwm_backlight_power_off(pb);
>>
>> Let's say duty_cycle =3D=3D 0.  In some cases this can mean "turn
>> brightness up to the *maximum*", but with your new logic you just
>> turned the backlight *off*.
>>
> Huh? Please think again!
>  - duty_cycle =3D=3D 0 means a CONSTANT LOW level on the PWM output. =
Agreed?
>  - Disabling the PWM usually achieves a CONSTANT LOW level on the PWM
>    output. Agreed?
> So duty_cycle =3D=3D 0  <=3D> disable the PWM no matter whether the b=
acklight
> is darkest or brightest at this duty cycle setting!
>
> The backlight controller does not know anything about the value of th=
e
> 'brightness' variable in the code but only sees the 'duty_cycle' valu=
e.
> When brightness =3D=3D 0 translates into max. duty cycle, the origina=
l code
> will switch the PWM OFF (which is equivalent to a ZERO duty cycle), w=
hen
> it rather should operate at the max. duty cycle.
> When duty_cycle is '0', this is equivalent to the PWM output being at
> constant LOW level which is the same as being switched OFF in the usu=
al
> cases.
>
> When the brightness is maximum at duty_cycle =3D=3D 0, that means, th=
at the
> backlight is brightest when the control pin is constantly LOW, which
> is usually the case when the PWM is disabled. This is exactly what th=
e
> patch does achieve!
> With the current code a backlight that is brightest at a constant '0'
> level will turn to max. brightness rather than off when selecting
> brightness level 0 (max. PWM duty cycle).
>
>> Conversely, let's say duty_cycle =3D=3D 255.  In some cases this can=
 mean
>> "turn the brightness to the *lowest* setting" i.e. *off*. Well your
>> logic just turned the backlight *on*.
>>
> OK. Let's try a sequence of brightness levels and duty cycles:
> For simplicity assume a range of brightness levels from 0..100, so
> that the 'brightness' value directly represents the duty cycle of the
> PWM. So either: brightness =3D=3D 0 =3D> duty cycle =3D=3D 0% =3D> co=
nstant LOW
> Or: brightnes =3D=3D 0 =3D> duty cycle =3D=3D 100% =3D> constant HIGH=
=2E
>
> Normal range with current and patched code:
>  brightness   duty_cycle
>     0            0           PWM disabled =3D> constant LOW
>     1            1           PWM active
>   ...
>   100          100           PWM active =3D> constant HIGH
>
> Inverted range (backlight brightest at duty cycle 0)
> Current code:
>  brightness   duty_cycle
>     0          100           PWM disabled (OUTPUT CONSTANT LOW!)
>     1           99           PWM active with near full duty cycle
>   ...
>    99            1           PWM active with near ZERO duty cycle
>   100            0           PWM active with 0% duty cycle =3D> const=
ant LOW
>
> With my patch:
>  brightness   duty_cycle
>     0          100           PWM active with 100% duty cycle (constan=
t HIGH)
>     1           99           PWM active with near full duty cycle
>   ...
>    99            1           PWM active with near ZERO duty cycle
>   100            0           PWM disabled =3D> constant LOW
>
>
pwm_backlight_power_off() disables the regulator.
So the supply to Backlight disappears, regardless of constant low...



--=20
Regards
Phil Reid
