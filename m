From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 1/2] drivers: pwm: core: implement pwm dead-times
Date: Tue, 30 May 2017 13:20:26 +0300
Message-ID: <009fe3a4-1a89-90d4-0610-5162bfcfc056@microchip.com>
References: <1494317990-9131-1-git-send-email-claudiu.beznea@microchip.com>
 <1494317990-9131-2-git-send-email-claudiu.beznea@microchip.com>
 <CAHp75Ve=v=50UmpOyi1guY3NVuk41U0Ma+_P__5NK7_dNr6gZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve=v=50UmpOyi1guY3NVuk41U0Ma+_P__5NK7_dNr6gZg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Linux Documentation List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, nicolas.ferre@microchip.com
List-Id: linux-pwm@vger.kernel.org

Hi Andy,

On 28.05.2017 01:28, Andy Shevchenko wrote:
> On Tue, May 9, 2017 at 11:19 AM, Claudiu Beznea
> <claudiu.beznea@microchip.com> wrote:
>> Extends PWM framework to support PWM dead-times.
>> The notions introduced are rising edge dead-time
>> and falling edge dead-time. These are useful for
>> PWM controllers with channels that have more than
>> one outputs.
>> The implementation add sysfs interface for
>> configuration. It extends the pwm_state structure
>> with two new members which keeps the values for
>> dead-times.
>> There were no additions in device tree for PWM channels
>> initialized by device tree.
> 
> AFAIU it's effectively called phase of the signal.
It is actually a delay introduce by the PWM controller
between it's outputs. As I said in cover letter, for
PWM controllers with 2 output signals per channel
(these signals are on different physical pins), this
dead-time is the delay introduced b/w these two outputs.
The term is a PWM literature specific.
These delays are useful when PWM drives a half bridge
converter where you need delays b/w positive edges of
the signals which drivers the transistors to avoid
shoot through scenarios.

> It looks to me much simpler if you allow to have linked / virtual
> channels instead of creating a lot of (duplicated) properties.My linked channels (the 2 outputs per PWM channel) are PWM controller
specifics. The standard output of these linked channels is as
follows:
              __    __    __    __
channel Xa __|  |__|  |__|  |__|  |__
           __    __    __    __    __
channel Xb   |__|  |__|  |__|  |__|
             <--T-->

This is the default output. To be able to use the controller
in applications which needs delays b/w the fronts of this outputs
I introduced the dead-time configuration. This allow the user
to set it's PWM output as he needs in his setup (these dead-times,
delays, if PWM is used e.g. in half bridge converters, depends
on the transistors used).

Thank you,
Claudiu Beznea

> 
