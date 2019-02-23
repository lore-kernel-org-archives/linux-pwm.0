From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
Date: Sat, 23 Feb 2019 00:17:25 -0300
Message-ID: <1550891845.20534.1@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-6-paul@crapouillou.net>
        <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
        <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
        <1548264353.3173.1@crapouillou.net> <20190123180155.GB9781@roeck-us.net>
        <154835808767.136743.14531363127962557756@swboyd.mtv.corp.google.com>
        <1548362788.3881.0@crapouillou.net>
        <154836998080.136743.17683029101430122926@swboyd.mtv.corp.google.com>
        <1548370388.3881.2@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548370388.3881.2@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Mathieu Malaterre <malat@debian.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-c
List-Id: linux-pwm@vger.kernel.org

Hi,

Le jeu. 24 janv. 2019 =E0 19:53, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
>=20
>=20
> Le jeu. 24 janv. 2019 =E0 19:46, Stephen Boyd <sboyd@kernel.org> a=20
> =E9crit :
>> Quoting Paul Cercueil (2019-01-24 12:46:28)
>>>=20
>>>=20
>>>  Le jeu. 24 janv. 2019 =E0 16:28, Stephen Boyd <sboyd@kernel.org> a
>>>  =E9crit :
>>>  > Quoting Guenter Roeck (2019-01-23 10:01:55)
>>>  >>  On Wed, Jan 23, 2019 at 02:25:53PM -0300, Paul Cercueil wrote:
>>>  >>  > Hi,
>>>  >>  >
>>>  >>  > Le mer. 23 janv. 2019 =C3  11:31, Guenter Roeck
>>>  >> <linux@roeck-us.net> a =C3=A9crit :
>>>  >>  > >On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
>>>  >>  > >>On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil
>>>  >> <paul@crapouillou.net>
>>>  >>  > >>wrote:
>>>  >>  > >>>
>>>  >>  > >>>From: Maarten ter Huurne <maarten@treewalker.org>
>>>  >>  > >>>
>>>  >>  > >>>OST is the OS Timer, a 64-bit timer/counter with buffered
>>>  >> reading.
>>>  >>  > >>>
>>>  >>  > >>>SoCs before the JZ4770 had (if any) a 32-bit OST; the=20
>>> =7F=7FJZ4770
>>>  >> and
>>>  >>  > >>>JZ4780 have a 64-bit OST.
>>>  >>  > >>>
>>>  >>  > >>>This driver will register both a clocksource and a=20
>>> =7F=7Fsched_clock
>>>  >> to the
>>>  >>  > >>>system.
>>>  >>  > >>>
>>>  >>  > >>>Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>>  >>  > >>>Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  >>  > >>>---
>>>  >>  > >>>
>>>  >>  > >>>Notes:
>>>  >>  > >>>      v5: New patch
>>>  >>  > >>>
>>>  >>  > >>>      v6: - Get rid of SoC IDs; pass pointer to
>>>  >> ingenic_ost_soc_info
>>>  >>  > >>>as
>>>  >>  > >>>            devicetree match data instead.
>>>  >>  > >>>          - Use device_get_match_data() instead of the=20
>>> of_*
>>>  >> variant
>>>  >>  > >>>          - Handle error of dev_get_regmap() properly
>>>  >>  > >>>
>>>  >>  > >>>      v7: Fix section mismatch by using
>>>  >>  > >>>builtin_platform_driver_probe()
>>>  >>  > >>>
>>>  >>  > >>>      v8: builtin_platform_driver_probe() does not work
>>>  >> anymore in
>>>  >>  > >>>          4.20-rc6? The probe function won't be called.=20
>>> =7F=7FWork
>>>  >> around
>>>  >>  > >>>this
>>>  >>  > >>>          for now by using late_initcall.
>>>  >>  > >>>
>>>  >>  > >
>>>  >>  > >Did anyone notice this ? Either something is wrong with the
>>>  >> driver, or
>>>  >>  > >with the kernel core. Hacking around it seems like the worst
>>>  >> possible
>>>  >>  > >"solution".
>>>  >>  >
>>>  >>  > I can confirm it still happens on 5.0-rc3.
>>>  >>  >
>>>  >>  > Just to explain what I'm doing:
>>>  >>  >
>>>  >>  > My ingenic-timer driver probes with=20
>>> =7F=7Fbuiltin_platform_driver_probe
>>>  >> (this
>>>  >>  > works),
>>>  >>  > and then calls of_platform_populate to probe its children.=20
>>> =7F=7FThis
>>>  >> driver,
>>>  >>  > ingenic-ost, is one of them, and will fail to probe with
>>>  >>  > builtin_platform_driver_probe.
>>>  >>  >
>>>  >>
>>>  >>  The big question is _why_ it fails to probe.
>>>  >>
>>>  >
>>>  > Are you sharing the device tree node between a 'normal' platform
>>>  > device
>>>  > driver and something more low level DT that marks the device's=20
>>> =7F=7Fbacking
>>>  > DT node as OF_POPULATED early on? That's my only guess why it's=20
>>> =7F=7Fnot
>>>  > working.
>>>=20
>>>  I do, but I clear the OF_POPULATED flag so that it is then probed=20
>>> =7F=7Fas a
>>>  normal platform device, and it's not on this driver's node but its
>>>  parent.
>>>=20
>>=20
>> Where do you clear the OF_POPULATED flag?
>>=20
>=20
> In the ingenic-timer driver introduced in patch [04/26], inside the=20
> probe function.

Anything new on this? It still happens on 5.0-rc7.
It probes with late_initcall, and not with device_initcall.
I have no clue what's going on.

-Paul
=
