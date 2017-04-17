From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix condition to set enable gpio as output
Date: Mon, 17 Apr 2017 21:36:06 +0200
Message-ID: <CAMuHMdVLUmT_NJt86tspYEZnsFEiEwiNu_19RQu0qhtcyP1SdQ@mail.gmail.com>
References: <20170416103546.3021-1-contact@paulk.fr> <CAMuHMdV1+caNwbuk=Kw7cRUxcp1iC=YArnQXf2mcn+qnc6+OOQ@mail.gmail.com>
 <1492443526.12267.4.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35692 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbdDQTgI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Apr 2017 15:36:08 -0400
In-Reply-To: <1492443526.12267.4.camel@paulk.fr>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-tegra@vger.kernel.org

Hi Paul,

On Mon, Apr 17, 2017 at 5:38 PM, Paul Kocialkowski <contact@paulk.fr> wrote=
:
> Le dimanche 16 avril 2017 =C3=A0 22:55 +0200, Geert Uytterhoeven a =C3=A9=
crit :
>> On Sun, Apr 16, 2017 at 12:35 PM, Paul Kocialkowski <contact@paulk.fr> w=
rote:
>> > The move to a dedicated pwm_backlight_initial_power_state function in
>> > commit 7613c922315e308a6486d802abed2eb74443dffd modified the condition
>> > to set the enable gpio as output. This breaks specific use cases using
>> > that GPIO, such as tegra124-based nyan Chromebooks where backlight
>> > stopped working.
>> >
>> > This puts the condition back to the way it was before the move.
>> >
>> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>>
>> Does "[PATCH v2] backlight: pwm_bl: Fix GPIO out for unimplemented
>> .get_direction()"
>> (https://lkml.org/lkml/2017/4/4/225) fix your issue?
>
> This definitely solves the issue!
>
> Since this fixes broken backlight (that, in turn, makes systems unusable)=
,
> perhaps this should be included in the next rc cycle?

You mean v4.11 final, as there probably won't be another rc?
Yes!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
