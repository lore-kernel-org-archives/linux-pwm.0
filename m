From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: Re: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
Date: Fri, 06 Nov 2015 17:18:32 +0100
Message-ID: <563CD2D8.8060805@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com> <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com> <20151106151816.GD8418@ulmo> <563CCB6E.2090206@ultimaker.com> <20151106160547.GF8418@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37140 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbKFQSf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 11:18:35 -0500
Received: by wmll128 with SMTP id l128so45074132wml.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Nov 2015 08:18:33 -0800 (PST)
In-Reply-To: <20151106160547.GF8418@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hey Thierry,

On 06-11-15 17:05, Thierry Reding wrote:
> On Fri, Nov 06, 2015 at 04:46:54PM +0100, Olliver Schinagl wrote:
>> Hey Thierry,
>>
>> On 06-11-15 16:18, Thierry Reding wrote:
>>> On Mon, Oct 26, 2015 at 10:32:39PM +0100, Olliver Schinagl wrote:
>>>> From: Olliver Schinagl <oliver@schinagl.nl>
>>>>
>>>> Some hardware PWM's have the possibility to only send out one (or =
more)
>>>> pulses. This can be quite a useful feature in case one wants or ne=
eds
>>>> only a single pulse, but at the exact width.
>>>>
>>>> Additionally, if multiple pulses are possible, outputting a fixed =
amount
>>>> of pulses can be useful for various timing specific purposes.
>>> I see how theoretically this would be nice to have. But I'm relucta=
nt to
>>> merge this feature if there aren't any users. What drivers in the k=
ernel
>>> would want to use this feature? Are there new drivers being worked =
on
>>> that will need this?
>> I should have brought this up as to why I added this, I'm working on=
 a
>> stepper driver framework (inspired by the pwm framework actually) an=
d
>> rotating moters by x degree's you do by sending pulses, using contro=
lled
>> pulses (timing wise) you can precisely move stepper motors. Yes we c=
an do
>> this reasonably accurate in software, but doing it in hardware is so=
 much
>> nicer.
> So is this going to be a kernel framework for stepper motors? If you =
say
> you rotate the motors by sending pulses, doesn't that mean that the P=
WM
> framework with pulse support would be enough? Or are there dedicated
> stepper chips that you plan to support, with PWM + pulses being the
> fallback for when you don't have one of those chips?
Well I'll have to investigate more into what other chips do, but=20
generally speaking from what I know so far, that often you supply a=20
stepper driver chip a variable voltage (via a regular pwm) to setup the=
=20
current control, you have gpio's for direction, enable etc, and you=20
'pulse' for each step you want the motor to take. There are of course=20
some chips that have more logic, that work via i2c and spi interfaces.
>
>>>> * pwm_pulse_done()	an internal function for drivers to call when
>>>> 			they have completed their pre-configured number
>>>> 			of pulses
>>>> * pwm_is_pulsing()	tells the callers if the pwm is busy pulsing,
>>>> 			yielding a little more information than just
>>>> 			pwm_is_enabled()
>>> Similarily, I'd think that once the PWM is done executing the serie=
s of
>>> pulses that it was configured for it would be automatically disable=
d. A
>>> consumer could then simply use pwm_is_enabled() and drivers could c=
all
>>> pwm_disable() on their PWM to mark them as disabled when they're do=
ne
>>> pulsing.
>> I agree, pulseating can be dropped too as we know that a) the pulse =
flag is
>> set, b) we are enabled. But I'm not sure now if the flag is exported=
 to
>> sysfs, in any case, sysfs should just check the pulseating flag?
> Can't you derive that information simply by looking at the enable and
> pulses attributes? If enable =3D=3D 1 and pulses > 0 you know the PWM=
 is
> pulsing. If enable =3D=3D 1 and pulses =3D=3D 0 you know it's in regu=
lar mode.
oh right, yes you can :)

olliver
>
> Thierry

--=20
Met vriendelijke groeten, Kind regards, =E4=B8=8E=E4=BA=B2=E5=88=87=E7=9A=
=84=E9=97=AE=E5=80=99

Olliver Schinagl
Software Engineer
Research & Development
Ultimaker B.V.
