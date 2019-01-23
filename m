From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
Date: Wed, 23 Jan 2019 14:25:53 -0300
Message-ID: <1548264353.3173.1@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-6-paul@crapouillou.net>
        <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
        <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mathieu Malaterre <malat@debian.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me, Maar
List-Id: linux-pwm@vger.kernel.org

Hi,

Le mer. 23 janv. 2019 =E0 11:31, Guenter Roeck <linux@roeck-us.net> a=20
=E9crit :
> On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
>> On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil=20
>> <paul@crapouillou.net> wrote:
>>>=20
>>> From: Maarten ter Huurne <maarten@treewalker.org>
>>>=20
>>> OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>>>=20
>>> SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
>>> JZ4780 have a 64-bit OST.
>>>=20
>>> This driver will register both a clocksource and a sched_clock to=20
>>> the
>>> system.
>>>=20
>>> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>=20
>>> Notes:
>>>       v5: New patch
>>>=20
>>>       v6: - Get rid of SoC IDs; pass pointer to=20
>>> ingenic_ost_soc_info as
>>>             devicetree match data instead.
>>>           - Use device_get_match_data() instead of the of_* variant
>>>           - Handle error of dev_get_regmap() properly
>>>=20
>>>       v7: Fix section mismatch by using=20
>>> builtin_platform_driver_probe()
>>>=20
>>>       v8: builtin_platform_driver_probe() does not work anymore in
>>>           4.20-rc6? The probe function won't be called. Work around=20
>>> this
>>>           for now by using late_initcall.
>>>=20
>=20
> Did anyone notice this ? Either something is wrong with the driver, or
> with the kernel core. Hacking around it seems like the worst possible
> "solution".

I can confirm it still happens on 5.0-rc3.

Just to explain what I'm doing:

My ingenic-timer driver probes with builtin_platform_driver_probe (this=20
works),
and then calls of_platform_populate to probe its children. This driver,
ingenic-ost, is one of them, and will fail to probe with
builtin_platform_driver_probe.

-Paul
=
