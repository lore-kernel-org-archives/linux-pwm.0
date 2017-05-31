From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 1/3] pwm: sun4i: improve hardware read out
Date: Wed, 31 May 2017 22:13:55 +0800
Message-ID: <CAGb2v64Vhr_s0LuwtN7pFZ0eknTcdE=2pHdDKZpXXF4xUKowfw@mail.gmail.com>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
 <20170530193209.19247-2-alexandre.belloni@free-electrons.com>
 <CAGb2v65sznGc9Tp6RSGpQ6KND4BxRFkfHZag5AFrKLBoZJ-r8w@mail.gmail.com> <20170531073516.jrpgtu7nlkuizvfx@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:44558 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdEaOOU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 May 2017 10:14:20 -0400
In-Reply-To: <20170531073516.jrpgtu7nlkuizvfx@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, May 31, 2017 at 3:35 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 31/05/2017 at 11:34:43 +0800, Chen-Yu Tsai wrote:
>> On Wed, May 31, 2017 at 3:32 AM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> > +static void sun4i_pwm_get_state(struct pwm_chip *chip,
>> > +                               struct pwm_device *pwm,
>> > +                               struct pwm_state *state)
>> > +{
>> > +       struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
>> > +       u64 clk_rate, tmp;
>> > +       u32 val;
>> > +       unsigned int prescaler;
>> > +
>> > +       clk_rate = clk_get_rate(sun4i_pwm->clk);
>> > +
>> > +       val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>> > +
>> > +       if ((val == PWM_PRESCAL_MASK) && sun4i_pwm->data->has_prescaler_bypass)
>> > +               prescaler = 1;
>> > +       else
>> > +               prescaler = prescaler_table[PWM_REG_PRESCAL(val, pwm->hwpwm)];
>> > +
>> > +       if (prescaler == 0)
>> > +               return;
>>
>> This looks like an invalid state. How does the PWM core handle it?
>> Or rather, how does the driver signal an invalid state?
>>
>
> It doesn't and it doesn't really matter, if the IP is in an invalid
> state, this bails out without modifying the know state so the core will
> behave as if there was no hardware read out and everything will be
> synchronized on the first ->apply() call.

Cool.

Thanks
ChenYu

>
>> Otherwise,
>>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>>
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
