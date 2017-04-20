From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix condition to set enable gpio as output
Date: Thu, 20 Apr 2017 12:16:36 +0200
Message-ID: <CAMuHMdXXHNUjexZ5X+rF4+vFrWbqBJ_2zeTUHJLJ8fsww5xvkg@mail.gmail.com>
References: <20170416103546.3021-1-contact@paulk.fr> <CAMuHMdV1+caNwbuk=Kw7cRUxcp1iC=YArnQXf2mcn+qnc6+OOQ@mail.gmail.com>
 <1492443526.12267.4.camel@paulk.fr> <CAMuHMdVLUmT_NJt86tspYEZnsFEiEwiNu_19RQu0qhtcyP1SdQ@mail.gmail.com>
 <1492505196.2014.0.camel@paulk.fr> <e5a9e6ce-b1dd-96ae-c051-60be7cbfbe1d@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5a9e6ce-b1dd-96ae-c051-60be7cbfbe1d-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Daniel,

On Thu, Apr 20, 2017 at 11:55 AM, Daniel Thompson
<daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 18/04/17 09:46, Paul Kocialkowski wrote:
>> Le lundi 17 avril 2017 =C3=A0 21:36 +0200, Geert Uytterhoeven a =C3=A9cr=
it :
>>> On Mon, Apr 17, 2017 at 5:38 PM, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
>>> wrote:
>>>> Le dimanche 16 avril 2017 =C3=A0 22:55 +0200, Geert Uytterhoeven a =C3=
=A9crit :
>>>>> On Sun, Apr 16, 2017 at 12:35 PM, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org=
>
>>>>> wrote:
>>>>>>
>>>>>> The move to a dedicated pwm_backlight_initial_power_state function i=
n
>>>>>> commit 7613c922315e308a6486d802abed2eb74443dffd modified the conditi=
on
>>>>>> to set the enable gpio as output. This breaks specific use cases usi=
ng
>>>>>> that GPIO, such as tegra124-based nyan Chromebooks where backlight
>>>>>> stopped working.
>>>>>>
>>>>>> This puts the condition back to the way it was before the move.
>>>>>>
>>>>>> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
>>>>>
>>>>> Does "[PATCH v2] backlight: pwm_bl: Fix GPIO out for unimplemented
>>>>> .get_direction()"
>>>>> (https://lkml.org/lkml/2017/4/4/225) fix your issue?
>>>>
>>>> This definitely solves the issue!
>>>>
>>>> Since this fixes broken backlight (that, in turn, makes systems
>>>> unusable),
>>>> perhaps this should be included in the next rc cycle?
>>>
>>> You mean v4.11 final, as there probably won't be another rc?
>>> Yes!
>>
>> I'm all for it!
>
> Thanks for keeping our attention on this. I sent a PR yesterday (and hope=
 my
> GPG key has attracted enough signatures).

Thank you, this morning I had already noticed it went upstream.

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
