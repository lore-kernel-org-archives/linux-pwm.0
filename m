From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] backlight: pwm_bl: add configurable delay between
 re-enabling PWM and switching backlight power on
Date: Tue, 7 Nov 2017 18:46:18 -0600
Message-ID: <CAL_JsqLrmOc8AksfpfNGdoFCtaa6vwsT1aLEU9C=9URmaiyM=w@mail.gmail.com>
References: <1509022186-19636-1-git-send-email-LW@KARO-electronics.de>
 <1509022186-19636-4-git-send-email-LW@KARO-electronics.de>
 <20171027140307.x7mtgvy5py7l5nqf@rob-hp-laptop> <20171030103334.75ii247j6owrnrdb@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934040AbdKHAqk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 7 Nov 2017 19:46:40 -0500
In-Reply-To: <20171030103334.75ii247j6owrnrdb@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Thierry Reding <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>

On Mon, Oct 30, 2017 at 5:33 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 27 Oct 2017, Rob Herring wrote:
>
>> On Thu, Oct 26, 2017 at 02:49:46PM +0200, Lothar Waßmann wrote:
>> > When switching the backlight on, the LCD may need some time to adjust
>> > to the configured PWM duty cycle. Add a configurable delay between
>> > configuring the PWM and enabling the backlight regulator to account
>> > for this.
>> >
>> > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
>> > ---
>> >  .../bindings/leds/backlight/pwm-backlight.txt      |  4 ++++
>> >  drivers/video/backlight/pwm_bl.c                   | 22 +++++++++++++++++++---
>> >  2 files changed, 23 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> > index 764db86..95594c3 100644
>> > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> > @@ -17,6 +17,10 @@ Optional properties:
>> >                 "pwms" property (see PWM binding[0])
>> >    - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>> >                    and disables the backlight (see GPIO binding[1])
>> > +  - turn-on-delay-ms: delay in milliseconds between configuring the PWM
>> > +             and switching PWM on. This may be required to eliminate
>> > +             flicker when switching the PWM on after it has been
>> > +             disabled.
>>
>> The subject talks about turning on the backlight regulator, but this
>> only talks about the PWM.
>
> From my understanding "switching PWM on" == enabling the regulator.
>
> I don't see any disparity here.  Or am I missing something?

The delay is from (re-)enabling the PWM (turning it on) to switching
backlight power on. That sounds like 2 different things to me.

Rob
