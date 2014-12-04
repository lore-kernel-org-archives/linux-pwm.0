From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH v2 2/4] pwm: kona: Fix incorrect enable after channel
 polarity change
Date: Thu, 4 Dec 2014 12:33:34 -0800
Message-ID: <5480C51E.1010401@broadcom.com>
References: <sbranden@broadcom.com> <1416944441-12066-1-git-send-email-sbranden@broadcom.com> <1416944441-12066-3-git-send-email-sbranden@broadcom.com> <CAD7vxxKgcu9QLY8qH8WR0b_5WBu+MNxcemmZ8syYa__JaC6tsQ@mail.gmail.com> <547909B0.2090408@broadcom.com> <CAD7vxxLv+uh5DxjNYy9X8iY7Egu_9u-JzUg7Xk2UiNsoJwb1tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:31171 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbaLDUdn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Dec 2014 15:33:43 -0500
In-Reply-To: <CAD7vxxLv+uh5DxjNYy9X8iY7Egu_9u-JzUg7Xk2UiNsoJwb1tw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, Arun Ramamurthy <arunrama@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Comments below.

On 14-11-28 06:02 PM, Tim Kryger wrote:
> On Fri, Nov 28, 2014 at 3:48 PM, Arun Ramamurthy
> <arun.ramamurthy@broadcom.com> wrote:
>>
>>
>> On 14-11-25 10:22 PM, Tim Kryger wrote:
>>>
>>> On Tue, Nov 25, 2014 at 11:40 AM, Scott Branden <sbranden@broadcom.=
com>
>>> wrote:
>>>>
>>>> From: Arun Ramamurthy <arunrama@broadcom.com>
>>>>
>>>> The pwm core code requires a separate call for enabling the channe=
l
>>>> and hence the driver does not need to set pwm_trigger after a
>>>> polarity change
>>>
>>>
>>> The framework does restrict when polarity changes can occur but it
>>> isn't clear to me that there is any reason to delay applying the
>>> polarity change.
>>
>> I examined several other drivers such as pwm-atmel-tcb.c, pwm-ep93xx=
=2Ec,
>> pwm-renesas-tpu.c, pwm-samsung.c in the 3.17 kernel tree and none of=
 them
>> enable the channel after changing polarity. We would be the first dr=
iver to
>> do so.
>=20
> We are not "enabling" the channel as much as we are "triggering an
> application of settings" by hardware.
>=20
> Both pwm-ep93xx and pwm-samsung write polarity settings to the
> hardware immediately, presumably resulting in an immediate change in
> output.
>=20
> Alternatively, the pwm-atmel-tcb and pwm-renesas-tpu drivers save the
> polarity and write it to hardware later.
>=20
> There may be advantages to deferring the application of the polarity
> till a subsequent enable but both approaches appear to be acceptable.
>=20
>>
>>> Keep in mind that polarity matters even when a PWM
>>> is disabled.  While disabled, the output should be equivalent to an
>>> enabled configuration with zero duty.  Thus for normal polarity the
>>> output is constant low and for inversed polarity the output is
>>> constant high.
>>
>> The driver does set the duty cycle to zero when disabling the pwm
>> channel.However since the frame work prevents polarity change when t=
he pwm
>> is enabled, I don=E2=80=99t see how one could expect the polarity ch=
ange to be
>> reflected immediately without a separate call to pwm enable.
>>
>>
>>> I believe there is an expectation that the output is
>>> updated to reflect the requested polarity change prior to returning=
 to
>>> the caller.
>>
>>
>> Once again I disagree with this based on other pwm drivers which onl=
y change
>> the polarity and do not enable the channel when their set polarity f=
unctions
>> are called.
>=20
> I don't know why you keep calling this an enable.  Its not an enable,
> it is only a trigger.
>=20
> Perhaps this would be best explained with an example:
>=20
> # Export PWM for access by userspace
> cd /sys/class/pwm/pwmchip0
> echo 0 > export
> cd pwm0
>=20
> # Request 50% duty output when PWM is enabled
> echo 50000 > duty_cycle
> echo 100000 > period
>=20
> # Command Inversed Polarity
> echo inversed > polarity
>=20
> # Command Normal Polarity
> echo normal > polarity
>=20
> # Enable PWM
> echo 1 > enable
>=20
> The polarity changes trigger immediate output updates but the PWM is
> not enabled until the end.
>=20
> Prior to the last step the output is either a constant high or low
> signal, not the 50% duty waveform.
>=20

I just want to clarify so we're on the same page here. The pwm channel
needs to be disabled when polarity is set. When the set polarity
callback is called it just needs to update the polarity so that when th=
e
channel is enabled again the new polarity value is used. We write this
to the polarity register in the callback which seems appropriate. Also
note that the clock is disabled at the end of the routine so the signal
is just going to be floating anyway. Hopefully this makes sense.


>>
>>
>>>
>>>>
>>>> Signed-off-by: Arun Ramamurthy <arunrama@broadcom.com>
>>>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>>>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>>>> ---
>>>>   drivers/pwm/pwm-bcm-kona.c | 5 -----
>>>>   1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona=
=2Ec
>>>> index 29eef9e..fa0b5bf 100644
>>>> --- a/drivers/pwm/pwm-bcm-kona.c
>>>> +++ b/drivers/pwm/pwm-bcm-kona.c
>>>> @@ -173,11 +173,6 @@ static int kona_pwmc_set_polarity(struct pwm_=
chip
>>>> *chip, struct pwm_device *pwm,
>>>>
>>>>          writel(value, kp->base + PWM_CONTROL_OFFSET);
>>>>
>>>> -       kona_pwmc_apply_settings(kp, chan);
>>>> -
>>>> -       /* Wait for waveform to settle before gating off the clock=
 */
>>>> -       ndelay(400);
>>>> -
>>>>          clk_disable_unprepare(kp->clk);
>>>>
>>>>          return 0;
>>>> --
>>>> 2.1.3
>>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

