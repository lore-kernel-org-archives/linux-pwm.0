From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
Date: Wed, 27 Feb 2019 20:54:28 -0300
Message-ID: <1551311669.21164.1@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
        <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
        <1548264353.3173.1@crapouillou.net> <20190123180155.GB9781@roeck-us.net>
        <154835808767.136743.14531363127962557756@swboyd.mtv.corp.google.com>
        <1548362788.3881.0@crapouillou.net>
        <154836998080.136743.17683029101430122926@swboyd.mtv.corp.google.com>
        <1548370388.3881.2@crapouillou.net> <1550891845.20534.1@crapouillou.net>
        <155111793658.191923.2540746255375959460@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155111793658.191923.2540746255375959460@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Mathieu Malaterre <malat@debian.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-c
List-Id: linux-pwm@vger.kernel.org

Hi,

Le lun. 25 f=E9vr. 2019 =E0 15:05, Stephen Boyd <sboyd@kernel.org> a=20
=E9crit :
> Quoting Paul Cercueil (2019-02-22 19:17:25)
>>  Hi,
>>=20
>>  Anything new on this? It still happens on 5.0-rc7.
>>  It probes with late_initcall, and not with device_initcall.
>>  I have no clue what's going on.
>>=20
>=20
> I'm not sure what's going on either. You'll probably have to debug=20
> when
> the device is created and when it is probed by enabling the debug
> printing in the driver core or by adding in extra debug prints to=20
> narrow
> down the problem. For example, add a '#define DEBUG 1' at the top of
> drivers/base/dd.c and see if that helps give some info on what's going
> on with the drivers and devices.

The doc of __platform_driver_probe says:
"Use this instead of platform_driver_register() when you know the device
is not hotpluggable and has already been registered".

When the parent device and child device are both probed with
builtin_platform_driver_probe(), and the parent calls
devm_of_platform_populate(), it is not certain that the parent's
probe will happen before the child's, and if it does not, the child
device has not been registered and its probe is not allowed to defer.
So it turned out not to be a core bug, rather a misuse of the API.

So I will keep the builtin_platform_driver_probe() in the child, and=20
use a
subsys_initcall() in the parent. That works fine.

Regards,
-Paul
=
