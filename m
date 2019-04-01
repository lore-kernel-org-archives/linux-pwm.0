From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Mon, 1 Apr 2019 09:25:40 +0200
Message-ID: <1e6f9589-ff9a-f0fd-f12d-d680ffd58752@baylibre.com>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
 <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
 <20190325200730.cx73jgxfexz6ybzq@pengutronix.de>
 <CAFBinCCGWsb+1WHFe6uwrpUYgH4iix0WT8_v_Nj5BhGKRyjiLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCCGWsb+1WHFe6uwrpUYgH4iix0WT8_v_Nj5BhGKRyjiLQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: thierry.reding@gmail.com, jbrunet@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On 30/03/2019 20:29, Martin Blumenstingl wrote:
> Hello Uwe,
> 
> On Mon, Mar 25, 2019 at 9:07 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> [...]
>>>>  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
>>>>    register) freeze the output, or is the currently running period
>>>>    completed first? (The latter is the right behaviour.)
>>> I don't know, I would have to measure this with a logic analyzer.
>>
>> In practise you can do this with a multimeter, too. Just do something
>> like:
>>
>>         pwm_apply_state({ .enabled = true, .period = 5s, .duty_cycle = 5s, .polarity = PWM_POLARITY_NORMAL });
>>         pwm_apply_state({ .enabled = false, .period = 5s, .duty_cycle = 5s, .polarity = PWM_POLARITY_NORMAL });
>>
>> (assuming the PWM supports periods that long). The expectation is that
>> the last command takes nearly 5 s to complete and while it waits the
>> output is high and on return it's low. If that isn't the case, there is
>> a bug somewhere.
> the longest supported period (using the 24MHz crystal as input, which
> is the slowest input clock and thus gives the longest possible
> duration) is 349514407ns (that's approx. 0.35 seconds). my multimeter
> isn't fast enough to measure this so I'm using my logic analyzer with
> puleseview instead: [0]
> 
> I added the following code to meson_pwm_request:
>   struct pwm_state enable = {
>         .enabled = true,
>         .period = 349514407U,
>         .duty_cycle = 349514407U,
>         .polarity = PWM_POLARITY_NORMAL };
>   struct pwm_state disable = {
>         .enabled = false,
>         .period = 349514407U,
>         .duty_cycle = 349514407U,
>         .polarity = PWM_POLARITY_NORMAL };
>   pwm_apply_state(pwm, &enable);
>   pwm_apply_state(pwm, &disable);
> 
> this returns immediately. my logic analyzer doesn't see signal change
> (I'm sampling at 1MHz).
> 
> can you please confirm that my test code and measurement procedure is correct?
> if it is then my observation is that disabling the PWM does so
> immediately, without waiting for the current period to complete

I'm pretty 100,00000000000000% sure the HW doesn't permit waiting for a period to finish.

For disable states, we can either play on the period (high period at 0xffff for disable
at PWM_POLARITY_INVERSED and high period at 0 for PWM_POLARITY_NORMAL, if the HW behaves
correctly) or by adding some pinctrl states switching to GPIO modes and adding the
enable output high and output low property.

Neil


> 
> 
> Regards
> Martin
> 
> 
> [0] https://sigrok.org/wiki/Lcsoft_Mini_Board
> 
