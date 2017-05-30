From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 1/2] drivers: pwm: core: implement pwm mode
Date: Tue, 30 May 2017 12:49:39 +0300
Message-ID: <f94c08aa-08ec-d956-468b-0c6a8e8dd546@microchip.com>
References: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
 <1494332153-14534-2-git-send-email-claudiu.beznea@microchip.com>
 <CAHp75VdSGLwryheu2RFg8N7U6qbEf--HmRFG5pa5CzFwJqWdfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdSGLwryheu2RFg8N7U6qbEf--HmRFG5pa5CzFwJqWdfA@mail.gmail.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Linux Documentation List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, nicolas.ferre@microchip.com
List-Id: linux-pwm@vger.kernel.org

Hi Andy,

On 28.05.2017 01:11, Andy Shevchenko wrote:
> On Tue, May 9, 2017 at 3:15 PM, Claudiu Beznea
> <claudiu.beznea@microchip.com> wrote:
>> Extends PWM framework to support PWM modes. The currently
>> implemented PWM modes were called PWM complementary mode
>> and PWM push-pull mode. For devices that have more than one
>> output per PWM channel:
>> - PWM complementary mode is standard working mode; in PWM
>> complementary mode the rising and falling edges of the
>> channels outputs have opposite levels, same duration and
>> same starting time.
>> - in PWM push-pull mode the channles outputs has same levels,
>> same duration and the rising edges are delayed until the
>> beginning of the next period.
>> A new member was added in pwm_state structure in order to
>> keep the new PWM argument.
> 
> To me it sound over-engineered.
> 
> It looks like polarity type
Could you, please, give me more details on this? I don't understand
your point. The PWM controller I worked with has more than one
physical output per PWM channel (e.g. a linux PWM channel has 2
output pins, as you said below, one with polarity P, the other one with
polarity !P). Different controllers could be configured to generate
different kind of signals. PWM push-pull signal type is one of these
and is a common characteristic. This kind of signal could be used, e.g.,
in half-bridge converter applications where you need delays between
positive fronts of PWM signals which drives the transistors.
It is a common characteristic of PWM controllers which is the
reason I tried to implement it.
The push-pull signal type looks like this in case of a controller
with 2 outputs per PWM channel:
              __          __
channel Xa __|  |________|  |________
                    __          __
channel Xb ________|  |________|  |__
             <--T--> 

> 
> I dunno if PWM supports linked / virtual channels, but it would be like that
> 
> channel X  (polarity P) effectively is
> 
> channel Xa (polarity P) / channel Xb (polarity !P)> 
> and vise versa.
The controller I worked for, the Atmel one, support 4 linux channels, but
every channel has 2 physical outputs, 2 pins which outputs, by default,
a signal with polarity P and a signal with polarity !P, exactly how you said.
I called this in my patch the "complementary" mode. Signals looks like this:
              __    __    __    __
channel Xa __|  |__|  |__|  |__|  |__
           __    __    __    __    __
channel Xb   |__|  |__|  |__|  |__|
             <--T-->

> 
> Moreover, mode in your case doesn't fit to GPIO style of output which
> would be emulated or native mode for PWM
For the PWM controller I worked for, one linux PWM channel outputs on
2 physical pins. Those 2 pins are requested from pin controller
to be used by PWM controller. The PWM controller is the one which generate
the signal form on those pins. Could you please give more details on
what what are you saying above?

 (we have already a use case
> and one driver implements that).
Could you, please, give me the driver name you are talking about?
On PWM drivers I found only one driver which is started in push-pull,
the drivers/pwm/pwm-bcm-kona.c one.
The idea with the patches I send was to have a chip which could be
user configurable to let the user choose how the chip to work.

Thank you,
Claudiu Beznea
> 
> GPIO type of output is, obviously, duty=100% in case of emulation,
> though separate state for HW assisted kind of that.

> 
