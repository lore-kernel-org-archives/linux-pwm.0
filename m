From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 00/26] Ingenic TCU patchset v8
Date: Thu, 24 Jan 2019 18:41:35 -0300
Message-ID: <1548366095.3881.1@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <CA+7wUszMOvGoPSVOKP7F_KHxgJvjBGT7oJmn5EO62hGGTQK4KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+7wUszMOvGoPSVOKP7F_KHxgJvjBGT7oJmn5EO62hGGTQK4KA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me
List-Id: linux-pwm@vger.kernel.org

Hi Mathieu,

Le jeu. 24 janv. 2019 =E0 18:26, Mathieu Malaterre <malat@debian.org> a=20
=E9crit :
> Paul,
>=20
> On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi,
>>=20
>>  Here's the version 8 and hopefully final version of my patchset,=20
>> which
>>  adds support for the Timer/Counter Unit found in JZ47xx SoCs from
>>  Ingenic.
>=20
> I can no longer boot my MIPS Creator CI20 with this series (merged
> opendingux/for-upstream-timer-v8).
>=20
> Using screen+ttyUSB, I can see messages stopping at:
>=20
> ...
> [  OK  ] Started Cgroup management daemon.
>          Starting Regular background program processing daemon...
> [  OK  ] Started Regular background program processing daemon.
>          Starting System Logging Service...
>          Starting Provide limited super user privileges to specific=20
> users...
>          Starting Restore /etc/resolv.conf if the system cras...s=20
> shut down....
>          Starting WPA supplicant...
>          Starting D-Bus System Message Bus...
> [  OK  ] Started D-Bus System Message Bus.
>=20
> Nothing really stands out in the error messages. Could you suggest
> things to try out to get into a bootable state ?

I'm debugging it right now on jz4740, it seems to happen when the=20
clocksource
from the ingenic-timer driver is used. Is it your case? It should not=20
happen
if you have CONFIG_INGENIC_OST set.

>>  The big change is that the timer driver has been simplified. The=20
>> code to
>>  dynamically update the system timer or clocksource to a new channel=20
>> has
>>  been removed. Now, the system timer and clocksource are provided as
>>  children nodes in the devicetree, and the TCU channel to use for=20
>> these
>>  is deduced from their respective memory resource. The PWM driver=20
>> will
>>  also deduce from its memory resources whether a given PWM channel=20
>> can be
>>  used, or is reserved for the system timers.
>>=20
>>  Kind regards,
>>  - Paul Cercueil
>>=20
=
