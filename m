From: Naidu Tellapati <naidu.tellapati@gmail.com>
Subject: Re: quick help on PDM DAC driver
Date: Mon, 22 Sep 2014 19:28:43 +0530
Message-ID: <CAC3mp01gADb-SPJhd9dYwKg2fQgmmeGDQ+xt8qYahRovNSpXMA@mail.gmail.com>
References: <CAC3mp01MC3SaR8WmcDOXmGaB60eYfifx+YMT8xvxE2L=gZ093A@mail.gmail.com>
	<20140922112707.GR1470@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:57737 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaIVN6n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Sep 2014 09:58:43 -0400
Received: by mail-oi0-f42.google.com with SMTP id u20so3824415oif.1
        for <linux-pwm@vger.kernel.org>; Mon, 22 Sep 2014 06:58:43 -0700 (PDT)
In-Reply-To: <20140922112707.GR1470@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

Hi Thierry,

Many thanks for your continued help in this regard.

Each bit in my 12-bit input value to the PDM block does not in anyway
corresponds to fixed interval. My hardware PDM block works with the
following simple logic

counter [12:0] =3D counter [11:0] + pluse_in [11:0]     /* pulse_in is =
a
12-bit input value to PDM block */
pdm_out =3D counter [12]

The above logic runs for every pdm_clk cycle.

And hence I am of the opinion that I need to have a Linux PDM
=46ramework which is similar to PWM Framework and which provides
pulse_in as device attribute to the Linux User Space.

Please correct me if my understand is wrong. Please also suggest me if
there is a better approach. The plan is to write an upstream-ble PDM
driver.

Thanks in advance,

Regards,
Naidu.



















On Mon, Sep 22, 2014 at 4:57 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Sep 22, 2014 at 04:37:11PM +0530, Naidu Tellapati wrote:
>> Hi Thierry,
>>
>> Many thanks for your quick response.
>>
>> There are total 4 blocks available on our SOC, those could be used
>> either as PWM DAC (or) PDM DAC blocks. If one of them is used as a P=
WM
>> DAC block, it can=E2=80=99t be used as a PDM block. As an example if=
 the user
>> wants, based on the configuration from the device tree, he could use
>> all the 4 blocks as PWM DAC blocks (or) all 4 as PDM DAC blocks (or)=
 2
>> PDM DAC blocks & 2 PDM blocks (or) any combination of these two type=
s.
>> Since there are 4 blocks available, total 16 combinations of these t=
wo
>> types (PDM & PWM) are possible.
>>
>> For example based on sort of channel mask defined in the device tree=
,
>> If the user wishes to use the blocks as PWM DAC blocks, my driver
>> exactly fits into linux PWM frame work. As usual, the PWM blocks
>> expect the user to configure all the required configuration attribut=
es
>> (frequency, duty-cycle etc) as defined by the Linux PWM Framework.
>>
>> Bu if the user wishes to use the blocks as PDM DAC blocks, my driver
>> does not exactly fit into PWM framework. In this case the PDM DAC
>> block takes only a 12 bit value (as input) program in one of the SOC
>> configuration registers as an
>> input and based on some simple internal logic, the block produces a
>> form of analogue output according to the relative density of output
>> pulses to the intended analogue signal amplitude. The width of the
>> output pulse varies with the 12-bit value we program in one of the S=
OC
>> configuration registers.
>>
>> If the user wants to change the width of the output pulse, he has to
>> program different values for 12-bit value. For example different
>> 12-bit input values 0xFFF, 0x800, 0x0800, 0x0080, 0x0008, 0x001 will
>> produce output pulses of totally different widths.
>
> What's the relation of the 12-bit value to the resulting signal? Does
> each bit in the value correspond to a fixed interval so that a one is
> high and 0 low? That is, does:
>
>         0x800 produce -___________
>         0x080 produce ____-_______
>         0x008 produce ________-___
>         0x444 produce _-___-___-__
>         0x555 produce _-_-_-_-_-_-
>         0x00f produce ________----
>         ...
>
> ? If so you can probably still mimic PWM behaviour by subdividing the
> duty-cycle into 12 intervals.
>
>> The idea is to implement a driver which could be upstream-able. I am
>> trying to understand how I could use the existing PWM Framework to
>> achieve this. If you think this does not fit into existing PWM
>> Framework, I request you to please suggest me some better approach.
>
> Even if you can't mimic PWM using PDM it's still possible to use a PW=
M
> driver only if all channels are configured in PWM mode.
>
> Thierry
