From: Naidu Tellapati <naidu.tellapati@gmail.com>
Subject: Re: quick help on PDM DAC driver
Date: Mon, 22 Sep 2014 16:37:11 +0530
Message-ID: <CAC3mp01MC3SaR8WmcDOXmGaB60eYfifx+YMT8xvxE2L=gZ093A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:54529 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaIVLHM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Sep 2014 07:07:12 -0400
Received: by mail-oa0-f41.google.com with SMTP id i7so2144020oag.0
        for <linux-pwm@vger.kernel.org>; Mon, 22 Sep 2014 04:07:11 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

Hi Thierry,

Many thanks for your quick response.

There are total 4 blocks available on our SOC, those could be used
either as PWM DAC (or) PDM DAC blocks. If one of them is used as a PWM
DAC block, it can=E2=80=99t be used as a PDM block. As an example if th=
e user
wants, based on the configuration from the device tree, he could use
all the 4 blocks as PWM DAC blocks (or) all 4 as PDM DAC blocks (or) 2
PDM DAC blocks & 2 PDM blocks (or) any combination of these two types.
Since there are 4 blocks available, total 16 combinations of these two
types (PDM & PWM) are possible.

=46or example based on sort of channel mask defined in the device tree,
If the user wishes to use the blocks as PWM DAC blocks, my driver
exactly fits into linux PWM frame work. As usual, the PWM blocks
expect the user to configure all the required configuration attributes
(frequency, duty-cycle etc) as defined by the Linux PWM Framework.

Bu if the user wishes to use the blocks as PDM DAC blocks, my driver
does not exactly fit into PWM framework. In this case the PDM DAC
block takes only a 12 bit value (as input) program in one of the SOC
configuration registers as an
input and based on some simple internal logic, the block produces a
form of analogue output according to the relative density of output
pulses to the intended analogue signal amplitude. The width of the
output pulse varies with the 12-bit value we program in one of the SOC
configuration registers.

If the user wants to change the width of the output pulse, he has to
program different values for 12-bit value. For example different
12-bit input values 0xFFF, 0x800, 0x0800, 0x0080, 0x0008, 0x001 will
produce output pulses of totally different widths.

The idea is to implement a driver which could be upstream-able. I am
trying to understand how I could use the existing PWM Framework to
achieve this. If you think this does not fit into existing PWM
=46ramework, I request you to please suggest me some better approach.

Thanks in advance,

Regards,
Naidu.















On Mon, Sep 22, 2014 at 3:18 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Sun, Sep 21, 2014 at 04:15:42PM +0530, Naidu Tellapati wrote:
>> Hi Thierry and all,
>>
>> Many thanks in advance. My name is Naidu Tellapati. I am from India.
>>
>> The Pulse Density Modulation DAC which we have on our SOC produces a
>> form of analogue output according to the relative density of output
>> pulses to the intended analogue signal amplitude. The 4 PDM outputs
>> are provided that can be used to control targets such as an LCD
>> backlight. After going through Linux PWM documentation, I understand
>> that our PDM DAC driver does not exactly fit into the Linux PWM
>> framework.
>>
>> The PDM DAC block takes only input clock and a 12 bit value (as inpu=
t
>> pulse) configured in one of the SOC configuration registers as an
>> input and based on some simple internal logic, the block produces a
>> form of analogue output according to the relative density of output
>> pulses to the intended analogue signal amplitude. The PDM DAC block
>> won't take duty_cycle as input configuration parameters. Instead it
>> takes 12 bit value (input pulse) as a configuration parameter.
>
> What does this 12-bit value represent? It sounds to me like it's exac=
tly
> what the duty-cycle is for other devices. And if it's the only parame=
ter
> then it seems to me like the device simply has a fixed period.
>
> Both of the above should be possible to do in the current PWM framewo=
rk.
> For example, you could compute the period (in ns) of the PDM based on
> the input clock frequency and inter/extrapolate the 12-bit parameter =
to
> range [0..period].
>
> You can also add checks to refuse setting a period in pwm_config() th=
at
> doesn't correspond to the fixed period derived from the input clock.
>
> Thierry
