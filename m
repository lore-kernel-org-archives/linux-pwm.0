From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Subject: Re: [PATCH v2 2/4] pwm: kona: Fix incorrect enable after channel
 polarity change
Date: Fri, 28 Nov 2014 15:48:00 -0800
Message-ID: <547909B0.2090408@broadcom.com>
References: <sbranden@broadcom.com>	<1416944441-12066-1-git-send-email-sbranden@broadcom.com>	<1416944441-12066-3-git-send-email-sbranden@broadcom.com> <CAD7vxxKgcu9QLY8qH8WR0b_5WBu+MNxcemmZ8syYa__JaC6tsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD7vxxKgcu9QLY8qH8WR0b_5WBu+MNxcemmZ8syYa__JaC6tsQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Scott Branden <sbranden@broadcom.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, Arun Ramamurthy <arunrama@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org



On 14-11-25 10:22 PM, Tim Kryger wrote:
> On Tue, Nov 25, 2014 at 11:40 AM, Scott Branden <sbranden@broadcom.co=
m> wrote:
>> From: Arun Ramamurthy <arunrama@broadcom.com>
>>
>> The pwm core code requires a separate call for enabling the channel
>> and hence the driver does not need to set pwm_trigger after a
>> polarity change
>
> The framework does restrict when polarity changes can occur but it
> isn't clear to me that there is any reason to delay applying the
> polarity change.
I examined several other drivers such as pwm-atmel-tcb.c, pwm-ep93xx.c,=
=20
pwm-renesas-tpu.c, pwm-samsung.c in the 3.17 kernel tree and none of=20
them enable the channel after changing polarity. We would be the first=20
driver to do so.

> Keep in mind that polarity matters even when a PWM
> is disabled.  While disabled, the output should be equivalent to an
> enabled configuration with zero duty.  Thus for normal polarity the
> output is constant low and for inversed polarity the output is
> constant high.
The driver does set the duty cycle to zero when disabling the pwm=20
channel.However since the frame work prevents polarity change when the=20
pwm is enabled, I don=E2=80=99t see how one could expect the polarity c=
hange to=20
be reflected immediately without a separate call to pwm enable.


I believe there is an expectation that the output is
> updated to reflect the requested polarity change prior to returning t=
o
> the caller.

Once again I disagree with this based on other pwm drivers which only=20
change the polarity and do not enable the channel when their set=20
polarity functions are called.

>
>>
>> Signed-off-by: Arun Ramamurthy <arunrama@broadcom.com>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>   drivers/pwm/pwm-bcm-kona.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
>> index 29eef9e..fa0b5bf 100644
>> --- a/drivers/pwm/pwm-bcm-kona.c
>> +++ b/drivers/pwm/pwm-bcm-kona.c
>> @@ -173,11 +173,6 @@ static int kona_pwmc_set_polarity(struct pwm_ch=
ip *chip, struct pwm_device *pwm,
>>
>>          writel(value, kp->base + PWM_CONTROL_OFFSET);
>>
>> -       kona_pwmc_apply_settings(kp, chan);
>> -
>> -       /* Wait for waveform to settle before gating off the clock *=
/
>> -       ndelay(400);
>> -
>>          clk_disable_unprepare(kp->clk);
>>
>>          return 0;
>> --
>> 2.1.3
>>
